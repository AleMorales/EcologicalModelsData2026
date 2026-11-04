# Review log and status of materials

Moved from AGENTS.md. Read this before working on the pages it covers; AGENTS.md points here.

## Review status

The course has been generated through Chapter 8. The former Chapters 2 (discrete
probability) and 3 (continuous probability) were merged into Chapter 2 and the later
chapters moved down by one, so older notes and git history may use numbers one higher.
Generation does not imply review; record review decisions here when the author confirms
them. All dates are in 2026.

- **5 October:** the author approved Chapters 1 to 3 (theory and practicals). They are
  the reference for content, depth, notation and format. For voice only the author's own
  text counts (table below).
- **6 October:** two reviews of Chapters 1 to 5 and the supplements led to corrections
  and rewrites. Every section rewritten then is a generated draft awaiting review,
  **including the author's own sections**, which are not references for voice until
  approved.
- **7 October:** RTMB was introduced from Chapter 4 and its distribution functions from
  Chapter 2. The plan (`.plans/plan_rtmb_early.md`, decisions D1 to D17) is in a
  git-ignored folder and may be absent; its decisions are recorded in this file and in
  `STYLE_GUIDE.md`, without the D numbers. The code of Chapters
  2 and 3 was converted with numbers unchanged and awaits a quick check; their status
  stays approved. The theory pages of Chapters 1 to 4 were checked against "Presenting
  code in the text" (chunks split, recipe items as bullets, repeated numbers removed;
  the R code is unchanged apart from comments and the order of two calculations in "The
  fitted model" of Chapter 4). The reworded sentences await the author's check.
  Supplements, practicals and Chapters 5 to 8 have not been checked against that rule.
- **12 October:** parentheses around the argument of a logarithm were applied to
  `Supplements/deterministic-functions.qmd`; other pages have not been checked.
- **29 October:** the author replaced "hypothetical experiments" by "hypothetical samples"
  (realisations of the data generating process) in repeated-sampling arguments (rule in
  `STYLE_GUIDE.md`). Chapter 3 (theory, practical, lecture and its figures) was converted;
  a footnote in "Sampling distributions" says why the course avoids "experiment", and a
  sentence says that field campaigns analysed together form one sample. The rest of the
  book followed the same day: Chapter 4 (theory and practical, including code names), the
  Chapter 1 roadmap, the Chapter 1 lecture, Chapter 6, `Supplements/canned.qmd` and the
  glossary (which gained an entry "Hypothetical sample"). Real experiments keep the word
  (the reed frog experiments, the seed survival example of Chapter 2, aleatoric
  probability as replications of "the same experiment or observation protocol"). The new
  wording awaits the author's check. On the author's instruction, the definition of the
  data generating process in "The modelling cycle" of Chapter 1 now reads "in an
  experiment, a survey or any other study".
- **3 November:** on the author's request, the Chapter 4 theory was simplified so that the
  examples serve the general principles (see "Chapter 4" below). The rewritten sections
  are drafts awaiting the author's review; the Chapter 4 lecture slides and the lecture
  handoff were not updated and no longer match the chapter in places. The same day,
  likelihood profiles calculated by hand were removed from the theory and the practical
  (see "Chapter 4" below), and from Lecture 1: `demo-profile.R` uses the owl model with
  $k$ and $p$, where the slice and the profile differ, and draws the chapter's figure of
  both (author's decision); the overview, demo slide and summary follow it. Later that day,
  on the author's request, "Standard errors and Wald intervals" was condensed: the main text
  keeps the principles and `sdreport()`/`ADREPORT()`, and Fisher information, the Hessian,
  Jensen's inequality and the delta method moved to statistical detail boxes (see "Chapter
  4" below). Lecture 2 (slides 6 to 10), its handoff, `figures.R`, the learning goals,
  roadmap, summary and quiz question 7 follow it.
- **4 November:** Chapter 6 (theory, practical, one lecture) was rewritten from scratch to
  the author's decisions of 3 and 4 November (see "Chapter 6" below) and added to the
  production build; all of it is a generated draft awaiting review. Promises about
  Chapter 6 elsewhere were corrected the same day and await the author's check: in the
  approved pages, two sentences of the Chapter 6 entry of the Chapter 1 roadmap (coverage
  by simulation only in the practical; automatic differentiation, the delta method and the
  leave-one-out score in place of "predictive RMSE") and one sentence of Chapter 3
  ("Consistency and asymptotic normality": the delta method's formula is in Chapter 4);
  elsewhere, the pointers to the delta method in Chapter 4 (theory and practical),
  `canned.qmd` and the glossary, two sentences of Chapter 5 and its practical, three
  sentences of `deterministic-functions.qmd`, the introduction and two sentences of
  Chapter 7 (which no longer claim that Chapter 6 used `shapes1.csv` or described `%~%`)
  and one of Chapter 8. The plan, `Chapter_6/rewrite-handoff.md`, stays until the author
  removes it.
- **4 November, Chapter 7:** Chapter 7 (theory, practical, one lecture) was rewritten from
  scratch to the author's decisions of 4 November (see `chapters-7-8-other.md`) in seven
  stages with an independent review (Stage 4), and added to the production build; all of it
  is a generated draft awaiting review. Promises about Chapter 7 elsewhere were corrected
  the same day and await the author's check: in the approved Chapter 1, two sentences of the
  roadmap entry "Chapter 7" (R skills now name REML and the comparison by AIC and
  leave-one-group-out cross-validation; "builds on" no longer says that Chapter 7 reuses
  Chapter 6's curve and observation model); elsewhere, the promises of spatial dependence
  among neighbouring quadrats (Chapter 3 theory, Chapter 4 practical, the Chapter 3 lecture
  slide and script, the Chapter 4 Lecture 1 script), which Chapter 7 does not model, now say
  that the course does not model it and that Chapter 7 treats observations in groups; links
  to `#sec-conditional`, `#sec-reml`, `#sec-marginal-likelihood` from Chapter 4 and
  `canned.qmd`; the shifted forms of the saturating exponential in
  `deterministic-functions.qmd`; eleven glossary entries. `lecture-script.pdf` of the
  Chapter 3 lecture and of Chapter 4 Lectures 1 and 2 were not regenerated. The plan,
  `Chapter_7/rewrite-handoff.md`, stays until the author removes it.
- **4 November, Chapter 8:** Chapter 8 (theory, practical, one lecture) was rewritten from
  scratch to the author's decisions of 4 November (see `chapters-7-8-other.md`) in seven
  stages with an independent review (Stage 4), and added to the production build; all of it
  is a generated draft awaiting review. Promises about Chapter 8 elsewhere were corrected
  the same day and await the author's check: in the approved Chapter 1, one sentence of the
  roadmap entry "Chapter 8" (R skills no longer name `ga()`); in `deterministic-functions.qmd`,
  the two promises on the threshold function, which the chapter does not use (one sentence
  removed; the other now points to Chapter 6's warning on automatic differentiation and to
  Chapter 8's other optimisers); links to the new section IDs from Chapters 4 to 7 and
  `canned.qmd`; the Chapter 4 practical (Exercise 4) and Chapter 7 practical (Exercise 5) now
  point to Exercises 2 and 3 of the Chapter 8 practical; fifteen new and six revised glossary
  entries. No lecture slide or script of another chapter needed a change. The plan,
  `Chapter_8/rewrite-handoff.md`, stays until the author removes it.

| Material | Status and use |
|---|---|
| Chapter 1 practical (`material.qmd` and wrappers) | Approved. Primary reference for teaching voice, introductory R and conditional solutions |
| `Chapter_1/Theory.qmd` | Approved, author's text. Reference for voice in its essay register only (see `STYLE_GUIDE.md`). Generated on the author's instruction and awaiting check: the two course objectives in "Overview of the book" and the roadmap entry "Supplement: Formula-based methods" |
| `Chapter_1/Lecture/` (`lecture.qmd`, `lecture-script.md`) | Generated draft of a 60-minute lecture on the chapter (19 slides). The author sets the length of each lecture; when a request does not give it, ask (see `STYLE_GUIDE_LECTURE.md`). The author revised the slides on 26 October (they are the reference for format and amount of text); the script awaits review. Slides carry keywords for students new to the course and no speaker notes; the narrative is only in the script (author's decision), so slide numbers, titles and times in the script are changed together with the slides. The README was removed. Never a model of voice |
| `Chapter_2/Lecture/` | Generated draft: 90 minutes of slides (33 slides) plus 40 minutes of live demos from the chapter's code and `Practice` callouts, in three blocks with two breaks of 10 minutes (150 minutes). Slides and script await review. Never a model of voice |
| `Chapter_3/Lecture/` | Generated draft: a session of 150 minutes with 34 slides (125 minutes, 5 of slack) in three blocks with two breaks of 10 minutes. No live demos (author's decision of 30 October, because the slides of the Chapter 2 lecture took longer than planned): the author decides during the lecture whether to run code, and the script lists the chunks that fit, all visible on the chapter and practical pages, with no typed code. Slides and script await review. Never a model of voice |
| `Chapter_4/Lecture_1/`, `Chapter_4/Lecture_2/` | Generated draft slides of two lectures of 150 minutes, one per part of the chapter (33 slides in Lecture 1, with 3 minutes of slack, and 30 in Lecture 2, with 12; each includes one live demo of 18 minutes with its standalone R script, checked in R). Scripts (`lecture-script.md` and PDF) were written on 3 November from the slides as they then stood; slides, scripts and demo scripts await review; the demo slide of Lecture 1 follows `demo-profile.R` (four steps, author's decision of 3 November), and both lectures use only copies of chapter figures or figures made from the chapter's data (Lecture 1, slide 28, reuses `slice-profile.png`; Lecture 2, slide 15 is the table of owl intervals). Lecture 1, slide 7 (added on 4 November at the author's request) shows the Poisson mass for a fixed mean beside the likelihood of the 50 fir counts, as a visual reference for the two readings of slide 6 and not as an analysis; its figures are made in `figures.R`. The plan and the author's decisions are in `Chapter_4/lecture-handoff.md`. Never a model of voice |
| `Chapter_2/Theory.qmd` | Approved, then partly rewritten. **Primary reference for voice in technical chapters** (author's sections not rewritten): "Discrete probability distributions", the discrete parts of "Joint distributions" and "Expectations and central moments", "Choosing a distribution", and the parts of "Overdispersion" that were not rewritten. Drafts: see Chapter 2 below |
| Chapter 2 practical | Approved. Exercises 1 (seedlings), 3 (`InsectSprays`) and 4 (Negative Binomial) are the author's work and the primary reference for exercises, worked reasoning and interpretation. Exercises 5 and 6 generated, then approved. Worked Exercise 2 is a draft |
| `Chapter_3/Theory.qmd` | Approved, then rewritten: a draft. The opening `# Samples and distributions` was the author's text and is no longer a reference for voice |
| Chapter 3 practical | Approved |
| `Supplements/distributions.qmd` | Binomial, Poisson and Negative Binomial text is the author's (only code and function names changed); other entries, the three mussel examples and the RTMB changes are drafts |
| Chapter 4 (theory and practical) | Draft: rewritten from scratch, trimmed by the author, then rewritten to the RTMB pattern. The author's own edits and sentences stay |
| Chapter 5 (theory and practical), `Supplements/deterministic-functions.qmd`, `Supplements/calculus.qmd` | Drafts, rewritten from scratch |
| `Supplements/canned.qmd` | Draft, rewritten on 7 October. The paragraph of `index.qmd` that describes it is generated text in the author's first person and awaits check |
| Chapter 6 (theory, practical) | Draft, rewritten from scratch on 3 and 4 November in seven stages (`Chapter_6/rewrite-handoff.md`), with an independent review (Stage 4) but no review by the author. Never a model of voice |
| `Chapter_6/Lecture/` | Generated draft: a session of 150 minutes with 32 slides (121 minutes, 9 of slack) in three blocks with two breaks of 10 minutes, including one live demo of 18 minutes (2 at the slide, 16 in R) from `demo-cycle.R`. Every figure is a copy of a chapter figure or made from the chapter's code (`lecture-assets/figures.R`; `parameter-derivatives.png` is a copy of the Chapter 5 figure, whose axis labels are small at slide size). Slides, script and demo script await review. Never a model of voice |
| Chapter 7 (theory, practical) | Draft, rewritten from scratch on 4 November in seven stages (`Chapter_7/rewrite-handoff.md`), with an independent review (Stage 4) but no review by the author. Never a model of voice |
| `Chapter_7/Lecture/` | Generated draft: a session of 150 minutes with 31 slides (116 minutes, 14 of slack) in three blocks with two breaks of 10 minutes, including one live demo of 18 minutes (2 at the slide, 16 in R) from `demo-pooling.R`. Every figure is made from the chapter's code (`lecture-assets/figures.R`); the DHARMa panels of slide 25 are small at slide size. Slides, script and demo script await review. Never a model of voice |
| Chapter 8 (theory, practical) | Draft, rewritten from scratch on 4 November in seven stages (`Chapter_8/rewrite-handoff.md`), with an independent review (Stage 4) but no review by the author. The theory is longer than its target (about 1,940 source lines against 1,600; open question in the handoff). Never a model of voice |
| `Chapter_8/Lecture/` | Generated draft: a session of 150 minutes with 31 slides (116 minutes, 14 of slack) in three blocks with two breaks of 10 minutes, including one live demo of 18 minutes (2 at the slide, 16 in R) from `demo-diagnosis.R`. Three figures are copies of chapter figures and one is a schematic (`lecture-assets/figures.R`). Slides, script and demo script await review. Never a model of voice |

