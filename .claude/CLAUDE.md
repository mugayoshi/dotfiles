## Preference
- I use mise (https://mise.jdx.dev/) for Ruby, Python and Node.js version management in this machine.
  - When executing Ruby, Node.js, make sure mise is activated. 

## Explanation style

Keep answers short and plain-spoken.

- **Be brief** — lead with the answer, then only the context I actually need to
  act on it. No preamble, no recap of what I just asked, no summary of what you
  are about to say.
- **Plain words over insider terms** — explain ideas the way you would to a
  capable colleague from a different team. If a specialist term is the only
  accurate one (a library name, a config key, an error string), use it and add a
  short plain-language gloss the first time.
- **Don't dumb down the substance** — exact file paths, command names, numbers,
  and trade-offs stay. It's the wording that gets simpler, not the content.
- **Cut the padding** — three specific things I don't want:
  - Compliments on the question ("great question", "good catch").
  - Repeating back what I asked, or what the code obviously already does.
  - Walking me through approaches you already decided against. Name the one you
    recommend; mention a rejected option only if I need to know why it fails.
- This is about how you explain, not how hard you think. The Code Review Stance
  below still applies: be direct and critical, just say it in fewer, simpler
  words.

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

## Documents output (`~/Documents/`)

When you produce a prose deliverable that isn't a code change — research notes,
design docs, plans, QA results, review notes, reference docs — write it under
`~/Documents/` without asking where to put it. Code edits and patches still go
in the relevant repo.

### Where it goes

Route by **the question the document answers**, not by its topic:

| Directory | Question it answers | Typical content |
|---|---|---|
| `findings/` | What is true right now? | Investigations, root-cause analysis, impact analysis, fact-checks, reviews of a design doc, general research |
| `design/` | What should we build, and why this option? | Option comparison, the chosen approach, data models, interfaces, RFCs |
| `implementation/` | How do we carry out a settled design? | Files to change, step-by-step plans, migrations, rollout, one-off execution runbooks for a single task |
| `qa/` | Did what we built work? | Test checklists, verification results in a real environment, supporting logs/CSVs |
| `reviews/` | What do we think of this PR / branch? | Code review notes, inline comment drafts (design-doc reviews go to `findings/`) |
| `reference/` | How does X work, or how do I do X, every time? | System explanations, ER diagrams, job lists, reusable procedures |

When it's unclear:

1. **Does it contain a decision about what to build?** Yes → `design/`, even if
   it started as an investigation. No → `findings/`. When an investigation
   turns into a proposal, start a new design doc and link the findings rather
   than growing the findings file.
2. **Mixes design and implementation?** If what to build is still being argued
   → `design/`; if it's settled and the steps are the bulk → `implementation/`.
   If it's long, split it and link both ways.
3. **Verification?** Checking facts before building → `findings/`; checking the
   built thing works → `qa/`.
4. **Procedure?** Tied to one task and run once (e.g. a backfill runbook) →
   `implementation/`; reused across tasks → `reference/`.
5. Still unsure → ask me before writing.

### File naming

- Default: `~/Documents/<dir>/<TICKET-KEY>/YYYY-MM-DD-<short-kebab-slug>.{md|html}` (use today's date).
- **Group by issue tracker ticket.** Use a per-ticket sub-directory named after
  the key in upper case. Infer the key from the branch, PR, or conversation;
  ask me if you can't. When there is genuinely no ticket, write flat at the
  directory root — unless the document belongs to an existing themed
  sub-directory (lower-case, e.g. `findings/research_day/`), in which case put
  it there.
- **Exception — `reference/`:** these are kept current rather than snapshotted,
  so no date and no ticket in the path: `~/Documents/reference/<short-kebab-slug>.md`.
  Keep a last-updated date in the body, and update the document in place
  instead of writing a new dated copy.
- `findings/` and `qa/` may hold supporting data files (CSV, PDF, raw logs) next to the write-up.
- If it's better to include visual contents (e.g. graphs, charts), write HTML instead of markdown.
- Create the target directory if it doesn't exist.
- When one document links to another, use the full path including the ticket
  sub-directory (`~/Documents/<dir>/<TICKET-KEY>/<file>`), never a relative
  path, so the link survives either file being moved.

### One-off analysis scripts and their data

Throwaway scripts written to answer a ticket's question (SQL runners, diff
scripts, export shells) and their input/output data live **next to the
write-up they support**, in the same ticket directory — normally
`~/Documents/implementation/<TICKET-KEY>/`. Don't invent a separate working
directory outside `~/Documents/`; the script and the runbook that explains it
get separated and the script becomes unfindable.

- Keep raw input/output in per-environment sub-directories
  (`development/`, `production/`) so it's obvious which env a file came from.
- A script's usage and output columns belong in its own docstring, not
  duplicated in the runbook.
- Python: a `pyproject.toml` + `uv.lock` in the ticket directory, run with
  `uv run`. Never commit `.venv/` anywhere or move it — recreate with `uv sync`.
- If a script turns out to be reusable across tickets, move it into the
  relevant repo (or `~/Documents/reference/` if it's a documented procedure)
  rather than leaving it in one ticket's directory.

### After writing

- Tell me the full path on its own line so I can open it.
- Run a Crit review on the file (`crit <path>`) and address any comments before
  considering the task done — regardless of which repo I'm in. Don't pass `--resolve`.

Cross-session memory is handled by Claude Code's auto memory; don't ask me
before saving notes there. Files under `~/Documents/` are the durable
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
