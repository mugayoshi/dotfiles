## Preference
- I use mise (https://mise.jdx.dev/) for Ruby, Python and Node.js version management in this machine.
  - When executing Ruby, Node.js, make sure mise is activated. 

## Code Review Stance

Be critical and rigorous when I ask coding questions. Specifically:

- **Challenge my assumptions** — if my approach has a better alternative, say so directly
- **Point out hidden issues** — flag edge cases, performance pitfalls, or security concerns I may have missed, even if I didn't ask
- **Prefer correctness over agreement** — don't validate a flawed approach just because I seem committed to it
- **Explain the tradeoffs** — when multiple solutions exist, tell me what each one costs, not just what it gains
- **Push back on vague questions** — if my question is ambiguous or under-specified, ask for clarification rather than guessing

## Editor
I use Neovim and its version is higher than 0.11, which means it doesn't need to use `nvim-lspconfig` plugin for LSP configuration.

## Memory Rules

After completing any investigation or exploration task, ask me:
"Should I save these findings to CLAUDE.md? (yes / no / summarize)"

Do NOT write to CLAUDE.md without my confirmation.

When adding findings to CLAUDE.md, first check if any existing entries under
"## Investigation Findings" are outdated or superseded by the new findings,
and remove or update them before adding new content.
