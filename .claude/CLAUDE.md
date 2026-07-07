## Preference
- I use mise (https://mise.jdx.dev/) for Ruby, Python and Node.js version management in this machine.
  - When executing Ruby, Node.js, make sure mise is activated. 

## Multi-repo search

All my code lives under `~/repos/` (one directory per repository). When I ask
you to "find", "search for", "look up", or "check where X is used" without
naming a repo, search across all of `~/repos/` by default — don't ask which
repo first.

- Use `rg` (ripgrep) from `~/repos/` as the default tool.
- Respect each repo's `.gitignore` (ripgrep does this automatically).
- If a search returns hits from more than one repo, group results by repo in the summary so I can see which repo each match came from.
- Only narrow to a single repo if I name one, or if I'm clearly already
  working inside one (cwd is under `~/repos/<name>/`).

## Code Review Stance

Be critical and rigorous when I ask coding questions. Specifically:

- **Challenge my assumptions** — if my approach has a better alternative, say so directly
- **Point out hidden issues** — flag edge cases, performance pitfalls, or security concerns I may have missed, even if I didn't ask
- **Prefer correctness over agreement** — don't validate a flawed approach just because I seem committed to it
- **Explain the tradeoffs** — when multiple solutions exist, tell me what each one costs, not just what it gains
- **Push back on vague questions** — if my question is ambiguous or under-specified, ask for clarification rather than guessing

## Editor
I use Neovim and its version is higher than 0.11, which means it doesn't need to use `nvim-lspconfig` plugin for LSP configuration.

## Findings output

When you produce research notes, investigation summaries, comparison tables,
codebase analyses, or any other "findings" artifact that isn't a code change,
write it to `~/findings/` without asking where to put it.

- Filename: `~/findings/YYYY-MM-DD-<short-kebab-slug>.md` (use today's date).
- Create `~/findings/` if it doesn't exist.
- After writing, tell me the full path on its own line so I can open it.
- After writing (before considering the task done), run a Crit review on the
  file (`crit <path>`) and address any comments. Applies to every findings file,
  regardless of which repo I'm in — don't pass `--resolve`.
- Code edits and patches still go in the relevant repo — `~/findings/` is for
  prose/markdown deliverables only.

Cross-session memory is handled by Claude Code's auto memory; don't ask me
before saving notes there. Findings files in `~/findings/` are the durable
human-readable record — auto memory is your own working notes.

## Crit review on substantive file changes

When you make a substantive change to a file — new code, non-trivial logic,
prose/docs of real length, config with behavioral impact — review it with the
**Crit** plugin before considering the work done. Make the edit, run the `crit`
skill on the resulting diff, read its inline comments, and address anything it
flags.

- **Skip Crit for mechanical one-liners**: index/pointer updates, typo fixes,
  version bumps, formatting, renames, deleting a file, and similar rote edits.
  When in doubt about whether a change is substantive, ask rather than assume.
- Batch multi-file changes into a single Crit review unless I ask for
  file-by-file.
- Don't pass `--resolve` — resolving comments is my call, not yours.
- This applies across all repos, not just one project.

## Command alias
- rm is aliased to rm -i
