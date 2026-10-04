# CLAUDE.md

This repository is an online textbook on Ecological Modelling and Data Analysis
in R (Quarto). The course instructions and style rules live in two shared files.
They are imported below, so Claude loads them automatically at session start.
Edit those files, not this one, when a convention changes.

@AGENTS.md
@STYLE_GUIDE.md

## Notes for Claude Code

- `AGENTS.md` was written for another tool. Where it says "the assistant", it
  means you. Your own system and tool rules rank above it, as it states itself.
- The imports above give you the rules, not the course content. Before changing
  any course content, still read `Chapter_1/Theory.qmd` (course overview), the
  target page, its practical or theory counterpart, and `_quarto.yml` when the
  change touches navigation or layout. This is the "Read before working" step in
  `AGENTS.md`; it is not satisfied by the imports.
- Use Read, Edit, Grep and Glob for files. Do not edit generated HTML, cache
  files, or vendored extensions.
- Run focused R or Quarto checks only when R and Quarto are available. Never
  claim a render or execution succeeded unless you ran it.
- After any course-content or guidance change, apply step 7 of the repository
  workflow: review `AGENTS.md`, update it if a durable convention or author
  decision was established, and say in your report whether you did.
- Do not commit or push unless asked. Leave unrelated working-tree changes alone
  (for example `feedback_handoff.md` and in-progress edits to chapter files).
- Generated text is a draft until the author reviews it. Do not claim human
  review, invent citations, datasets, or numerical results.
