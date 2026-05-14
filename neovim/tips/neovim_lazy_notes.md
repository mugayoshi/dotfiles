# Neovim lazy.nvim Troubleshooting Notes

## Incident: telescope.nvim `refs/heads/0.2.0` error after changing tag spec

### What happened

1. Added `tag = "0.1.5"` to the telescope.nvim lazy spec to try to fix an unrelated tree-sitter error.
2. Ran `:Lazy sync` — lazy resolved the tag against the community manifest (`version = "0.2.0-1"`) and wrote a stale fetch refspec into the plugin's local git config:
   ```
   # ~/.local/share/nvim/lazy/telescope.nvim/.git/config
   fetch = +refs/heads/0.2.0:refs/remotes/origin/0.2.0
   ```
3. Reverting the tag in the lazy spec didn't help — the stale line was already baked into `.git/config`, not derived from the spec at fetch time.
4. Every subsequent `:Lazy sync` tried to fetch `refs/heads/0.2.0`, which doesn't exist on GitHub, and failed.

### Root cause

- `git remote set-branches --add` only appends refspecs, never removes them.
- lazy.nvim never audits `.git/config` to clean up refspecs that are no longer relevant to the current spec.
- lazy.nvim's community manifest (`_generated.lua`) can interfere with version resolution when you mix `tag`/`version` specs.

### Fix

Remove the stale line from the plugin's `.git/config`:

```
# ~/.local/share/nvim/lazy/<plugin-name>/.git/config
# Delete the line:
fetch = +refs/heads/<stale-branch>:refs/remotes/origin/<stale-branch>
```

Or, clean and reinstall the plugin entirely:

```
:Lazy clean telescope.nvim
:Lazy install
```

---

## Prevention rules

### 1. Don't pin `tag` or `branch` for plugins in lazy's community manifest

lazy.nvim ships a community manifest (`lua/lazy/community/_generated.lua`) with recommended versions for popular plugins. Mixing your own `tag` or `version` spec with a community manifest entry can cause lazy to resolve an unexpected branch.

To check if a plugin is in the community manifest:
```bash
grep "telescope" ~/.local/share/nvim/lazy/lazy.nvim/lua/lazy/community/_generated.lua
```

### 2. When reverting a spec change, clean the plugin first

Reverting a `tag`/`branch`/`version` in your lazy spec does **not** undo what was written to the plugin's `.git/config`. Always clean and reinstall:

```
:Lazy clean <plugin-name>
:Lazy install
```

### 3. When a `:Lazy sync` fails with `couldn't find remote ref refs/heads/X`

Check the plugin's git config for stale fetch refspecs:
```bash
cat ~/.local/share/nvim/lazy/<plugin-name>/.git/config
```
Remove any `fetch = +refs/heads/<branch>` lines for branches that no longer apply.

### 4. Prefer tracking `master`/`main` over pinning tags

For most Neovim plugins, tracking the default branch is fine — the `lazy-lock.json` already pins the exact commit. Use `tag` only when you have a specific reason (e.g., a known-good version before a breaking change), and clean the plugin when reverting.

---

