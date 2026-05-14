# Neovim + nvim-treesitter Version Mismatch

## What happened

After upgrading to Neovim 0.12.0, opening Lua files via neo-tree produced:

```
Query error at 74:3. Invalid field name "operator":
  operator: _ @operator)
```

## Root cause

Neovim 0.12.0 introduced two things that conflict with an outdated nvim-treesitter Lua parser:

1. **`ftplugin/lua.lua`** now automatically calls `vim.treesitter.start()` for every Lua buffer.
2. **Bundled `queries/lua/highlights.scm`** uses the `operator` named field, which requires a newer Lua tree-sitter grammar.

nvim-treesitter ships its own `parser/lua.so` (a compiled grammar binary). Because lazy.nvim prepends plugin directories to `runtimepath`, nvim-treesitter's old `lua.so` is found **before** Neovim's own bundled `lua.so` (at `lib/nvim/parser/lua.so`). The old parser doesn't support the `operator` field → the bundled query fails.

Neo-tree surfaces the error because it wraps file opens in `pcall(nvim_exec2, ...)` and logs failures explicitly. Telescope swallows the same error silently.

## Fix

Delete nvim-treesitter's bundled Lua parser so Neovim falls back to its own (compatible) one:

```sh
/bin/rm -f ~/.local/share/nvim/lazy/nvim-treesitter/parser/lua.so
```

`/bin/rm` (not `rm`) bypasses any `rm -i` shell alias.

In `lua/plugins/treesitter.lua`, keep `lua` out of `ensure_installed` and set `auto_install = false` to prevent nvim-treesitter from reinstalling an incompatible parser:

```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        -- do NOT add "lua" here — Neovim 0.12.0+ manages it natively
        "astro", "svelte", "javascript", "typescript",
        "html", "css", "go", "python"
      },
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
    }
  }
}
```

## Why the file doesn't come back

`parser/lua.so` is **not git-tracked** in nvim-treesitter. A `lazy update` (which runs `git pull`) will not restore it. `:TSUpdate` only updates parsers already installed in `~/.local/share/nvim/site/parser/`, so it won't reinstall lua either.

## Prevention checklist when upgrading Neovim

1. Check `$VIMRUNTIME/queries/{lang}/highlights.scm` for new field names.
2. If a language's queries changed, run `:TSUpdate {lang}` and confirm the parser version is compatible.
3. If `:TSUpdate` says "up-to-date" but errors persist, the nvim-treesitter parser is behind Neovim's bundled one — delete `~/.local/share/nvim/lazy/nvim-treesitter/parser/{lang}.so` and let Neovim use its own.
4. Neovim 0.12.0+ manages Lua, Vim, and a few other languages natively — avoid having nvim-treesitter override those parsers.
