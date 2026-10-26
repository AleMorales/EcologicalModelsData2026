# Handoff: revise the Chapter 1 lecture

For the agent that executes this plan. It comes from a review of
[`../Theory.qmd`](../Theory.qmd) against [`lecture.qmd`](lecture.qmd) and
[`lecture-script.md`](lecture-script.md). Read the chapter first, then the lecture, then
this plan. `CLAUDE.md`, `AGENTS.md` and `STYLE_GUIDE.md` apply (British English,
distribution names capitalised, units with a slash, voice rules, no invented anecdotes or
citations). The chapter is the author's approved text and is the reference for content.
The lecture is a generated draft.

## Constraints

- **Length.** Do not make the lecture longer. The current one has 20 slides and 60 minutes.
  The target is 17 slides and 60 minutes, with about 4 minutes of slack for discussion
  (the old script had none). Rephrase and merge before adding. The only truly new
  material is: one framing slide of the problem, a straight line on the feeding schematic,
  one table that merges three slides, and a few sentences of speaker notes.
- **Do not edit `Theory.qmd`.** If you find a chapter problem, list it in your report.
- **Keep the author's figures** (`ModelCycle.png`, `Estimation.png`) unchanged.
- **Do not commit.** The working tree has unrelated changes (`lecture-README.md`,
  `lecture.html`, `ModelCycle.png`, the two PNG copies in `Lecture/`). Edit on top of them.
- **Never invent** author opinions, anecdotes or results. Where the chapter has the author
  speaking in the first person (Bolker, Diaconis), keep it as the chapter has it, or leave
  it as an optional note for the author, as slide 1 already does.
- **Keep three files in sync:** `lecture.qmd` (slides and speaker notes),
  `lecture-script.md` (the same content as a script, with timing table) and
  `lecture-README.md`.

## New slide sequence

The lecture currently reaches its two organising figures (modelling cycle, reality–model–
data) at minute 41 and 45, after the details they organise. The new order puts the cycle
early as a map, returns to it in the summary, and merges three definition slides into one.

| New | Title | Min | Source | Change |
|---:|---|---:|---|---|
| 1 | The problem and the purpose of the course | 3 | old 1 | Rewrite: add the problem and the two objectives |
| 2 | Ecological questions | 3 | old 2 | Keep; small edit |
| 3 | A predator's feeding response | 4 | old 3 | Add a straight line and the contrast with it |
| 4 | The components of a statistical model | 3 | old 4 | Small additions |
| 5 | The modelling cycle | 4 | old 15 | Move up; use as a map |
| 6 | Observation error and process variation | 4 | old 5, 6, 7 | Merge three slides into one |
| 7 | Probability models for ecological observations | 3 | old 8 | Keep; trim notes |
| 8 | Explaining some of the variation | 4 | old 9 | Reframe (see issue A) |
| 9 | Parameters and estimates | 3 | old 10 | Keep; small edit |
| 10 | Parameter uncertainty | 4 | old 11 | Move two notes onto the slide |
| 11 | Discussion: which source of variation? | 3 | old 12 | Reword items (see issue B) |
| 12 | Reality, model and data | 4 | old 16 | Add the "as if" point and frequentist stance |
| 13 | What we want from a statistical analysis | 4 | old 14 + 13 | Expand slightly; absorb "other uncertainties" |
| 14 | Course roadmap: distributions to estimation | 2 | old 17 | Trim |
| 15 | Course roadmap: response curves, groups, optimisation, supplement | 2 | old 18 | Add supplement row |
| 16 | The Chapter 1 R practical | 3 | old 19 | Add the AI line to the slide |
| 17 | Summary and closing questions | 3 | old 20 | Add a pointer back to the cycle |
| | Slack | 4 | | Not on any slide |
| | **Total** | **60** | | |

Update `data-timing` and the "Timing: N minutes · a–b minutes from the start" line in each
notes block (cumulative: 3, 6, 10, 13, 17, 21, 24, 28, 31, 35, 38, 42, 46, 48, 50, 53, 56;
the slack ends the hour). Renumber the slide references in the notes ("slide 3", "slide
12", and the "Adjustments during delivery" section).

## Slide-by-slide plan

### 1. The problem and the purpose

Addresses review points: missing "standard statistics" hook, missing objectives and
`glmmTMB`, softened stance on p-values.

- Keep the three bullets (knowledge proposes models, probability describes variation, data
  estimate, compare and check). Add one line on the problem from the chapter's "Overview of
  the book": ecologists who model and ecologists who run experiments each have half of
  the toolkit, and classic statistics assumes linear responses, Normal errors and
  balanced designs that ecological data often lack.
- Add the two objectives of the chapter, in short form: (1) understand likelihood-based
  inference well enough to know what tools like `glmmTMB` do; (2) build non-linear
  (mixed) models and analyse them the same way.
- Keep the takeaway "The aim is an answer to an ecological question".
- Notes: use the chapter's wording. The optional personal introduction (Bolker, 2010)
  stays as an option for the author and must not be written on the author's behalf.
- Fit: the slide must stay readable at 1440×900. If it is crowded, put the objectives in
  two short numbered lines and drop one bullet.

### 2. Ecological questions

- Keep the table. Add to the notes the chapter's point that we give up null hypothesis
  testing as the main goal because the questions that we care about are quantitative, and
  that this does not mean abandoning linear models (slide 13 develops it).
- Keep the 30-second activity.

### 3. A predator's feeding response

Addresses: "Why standard statistics are not enough" is the chapter's strongest argument
and is missing; the straight line is only in the notes.

- Edit `lecture-assets/feeding-response.svg`: add a dashed straight line over the same
  axes, labelled "Straight line", next to the saturating curve. Keep it schematic: no
  numbers, no parameter values. Add alt text for both.
- Replace the three bullets by the chapter's argument in three lines: a straight line
  describes part of the range but keeps increasing; a saturating curve represents the
  limit set by search and handling time; its parameters (maximum, rate at low density) are
  quantities that can be discussed and compared among studies, provided the models,
  units and conditions are similar. Keep one question on the slide: "Where would you
  measure if your main question was the maximum feeding rate?"
- Notes: keep the existing "data confined to the rising part" discussion. Add the
  chapter's remark that convenience used to be a good reason for simple models, and
  that modern computers remove that limit, so the challenge is whether the model is
  ecologically reasonable and whether the data can inform its parameters.

### 4. The components of a statistical model

- Keep the definition and the two columns.
- Add to the notes (not necessarily to the slide) two chapter statements: a statistical
  model needs at least one stochastic component (a distribution), and some questions need
  only distributions (a model can even be nested distributions). Deterministic functions
  approximate the ecological process of interest.
- Keep the instruction to return to the schematic.

### 5. The modelling cycle (moved from old 15)

Addresses: the three-part structure (Model, Estimation, Model comparison and answer) and
the chapter mapping are only in the figure, and the figure arrives at minute 41.

- Use the figure as a map of the course, not as a recap. The notes follow the three bullets
  of the chapter section "The modelling cycle": Model (distributions Chapter 2; functions
  Chapters 5 and 6; groups Chapter 7), Estimation (Chapters 3, 4, 8; marginal likelihood
  in 7), Model comparison and answer (AIC Chapter 4; other criteria and checks Chapter 6).
- Keep the caption that AIC is introduced in Chapter 4 and developed in Chapter 6, because
  the diagram places it under Chapter 6.
- Add to the notes: the course does not assign probabilities to models; we compare fitted
  candidates (slide 13 repeats this in one sentence).
- Keep the closing question about a curve that still rises at the highest prey density.
- Because estimation has not been explained yet, tell the presenter to say that every box
  gets its own slide later and that the figure returns in the summary (slide 17).

### 6. Observation error and process variation (merge old 5, 6, 7)

Addresses: three consecutive definition slides with the same layout; missing process-error
items; the chapter's point that unexplained is not the same as random.

- One slide with two columns:
  - **Observation error:** a difference between what happens and what we record. Examples:
    individuals missed or counted twice; instrument readings; protocol differences.
    Hypothetical case: 20 insects present, 16 recorded.
  - **Process variation** (also process error or stochasticity): variation in the
    ecological reality that the model does not explain. Examples: environment and
    unmeasured drivers; differences among individuals; demographic chance; **dependence
    among nearby or repeated observations**; **non-linear effects and interactions**;
    simplification by the model. Keep it to four bullets by grouping.
  - Takeaway: "Process variation remains with perfect observations." Add the word
    "relative to the model" in the definition.
- Move "parameter uncertainty" out of this slide. The old slide 5 ("Why probability
  matters") listed three sources; the three-source frame is now introduced in the notes
  of this slide and completed on slide 9 and 10.
- Notes: keep the observation-error and process-error material of the old notes, and add
  the chapter's Diaconis example in one or two sentences: coin flips can be predicted if
  the initial conditions are measured accurately, so unexplained variation is relative to
  the model and the information, not proof of fundamental randomness. (Credit
  Persi Diaconis as the chapter does; the chapter links the Numberphile video. Do not add
  details the chapter does not give.)
- Notes: say that a recorded value generally mixes both, that simple models describe their
  combined variation with one distribution, and that hierarchical (mixed or multilevel)
  models can separate them when groups exist (Chapter 7). This replaces the missing
  hierarchical-models point at no cost in slides.
- Keep one discussion prompt (the old slide 6 and 7 questions: pick one).

### 7. Probability models for ecological observations

- Keep the two panels and captions. Trim the notes by about a third; remove the repeated
  sentence that the fitted distribution does not separate sources (slide 8 and 11 say it).
- Keep "Could an insect count be negative? Could it be 3.5?"

### 8. Explaining some of the variation (reframed)

Addresses **issue A**, the most important conceptual problem: the lecture says that
treatment "helps explain differences", while the chapter classes the variation across
treatments as process error (not systematic observation error).

- Slide text: replace the three bullets by this logic and keep the figure:
  - Pooled counts mix differences among sprays with differences within sprays.
  - Differences among sprays are ecological (process variation), not recording error. A
    model that includes spray explains this part.
  - Variation within each spray remains: process variation among plants plus observation
    error.
- Notes: state explicitly that "explained" and "unexplained" always refer to a model. For
  the pooled model, the spray differences are unexplained process variation; for a model
  with spray, they are explained. Keep "the figure does not determine the separate
  contributions". Keep the transition to parameters and the connection to models with
  predictors or groups (Chapters 6 and 7).
- Keep the activity question "What information do we lose when we put every count in one
  group?" and drop the second one if time is short.

### 9. Parameters and estimates

- Keep. Make "estimate" depend on the procedure in one clause on the slide. Add to the
  notes the chapter's sentence that the model is fitted treating the data as if they were a
  random sample from the model (details on slide 12).
- Keep the pointers: Chapter 3 for sampling variation, Chapter 4 for maximum likelihood.

### 10. Parameter uncertainty

Addresses: caveats now only in notes.

- Move onto the slide: "the band is the uncertainty of the mean response, not where
  individual species lie" (this is already the third bullet, rewrite it plainly) and
  "three of the 28 species are dinosaurs and they shape the levelling-off".
- Add a short bullet on the stance: we use the frequentist interpretation; with little
  data the uncertainty statements are approximate; Bayesian methods are an alternative
  that this course does not teach (the book is meant as a bridge to them). Keep this to
  one line on the slide and the chapter's explanation in the notes (priors matter for
  small data sets; Bayesian methods are rising).
- Keep the caption and the three questions (point, line, band).

### 11. Discussion: which source of variation?

Addresses **issue B** (the item about two plants with the same treatment is ambiguous).

- Reword the three items so that each names its reference model:
  1. Two observers record different counts of the same animals at the same moment.
  2. Two plants with the same spray treatment have different true insect counts (a model
     that has only spray as a predictor).
  3. Repeating a study gives a different estimate of mean abundance.
- Notes: keep the answers. Add that item 2 would become explained variation if we
  measured plant size and added it. Add the sentence that all three occur in one
  analysis.
- Keep the discussion format (45 seconds, then answers). The old script has this slide at
  minute 37 and offers a break after it; the new position is minute 38, and the break
  note must say so.

### 12. Reality, model and data

- Keep the figure and the solid and dashed arrow legend.
- Add to the notes the chapter's footnote: in reality the data come from the data
  generating process, not from the model; treating them as a random sample from the model
  is an assumption that estimation needs. Keep it as a sentence on the slide as well
  ("an assumption that estimation needs").
- Keep the frequentist behaviour (bias, variability, interval coverage across repeated
  hypothetical samples) and the maximum likelihood preview. Keep the question about where
  the missed insect belongs in the diagram.
- Say that this slide and slide 5 together are the two figures of the chapter.

### 13. What we want from a statistical analysis (absorbs old 13)

Addresses: the p-value critique, the null model point, the Wasserstein reference, the
dependence on model choice, the "other sources of uncertainty" slide, and the instruction
not to assign probabilities to models.

- Keep the four questions and the takeaway that linear, generalised linear and mixed models
  remain useful ("we use them because we choose to, not because we have to").
- Add on the slide a short pair of statements from the chapter: "A small p-value is rarely
  the end of an analysis" and "a large p-value often reflects how much data we have".
  Notes carry the rest: "nothing happens" is often not a plausible model, we usually
  choose among several ways something might happen, and a test of a zero effect does not
  give effect size, shape or precision. Put the Wasserstein et al. (2019) reference
  on the slide in small print or in the notes exactly as the chapter footnote gives it.
- Replace the old "other sources of uncertainty" slide by one sentence on this slide:
  initial conditions, inputs, scenarios and numerical error matter for dynamical or
  forecasting models, which the course does not cover, and we do not assign probabilities
  to models. Delete old slide 13 and its notes.
- Add one sentence from the chapter that these habits (state the model, estimate with
  uncertainty, check the fit) also serve decision-making, although the course is about
  analysing data, not forecasting.
- Keep the discussion: "If prey density has a statistically significant effect, which
  questions about the feeding curve are still unanswered?" Refer to slide 3.

### 14 and 15. Roadmap

- Keep two table slides, so the tables stay legible. Trim the notes to the one-sentence-
  per-row rule that the old delivery note already asks for.
- Slide 15: add a row for the **Supplement on formula-based methods** (`glmmTMB`): the
  same techniques with a formula that writes the likelihood. This closes the loop with
  objective 1 on slide 1.
- Notes of slide 14: remove the stale comment in `lecture-script.md` (see housekeeping).
  Packages: say that RTMB and RTMBdist appear from Chapter 2 and fitting with `optim()`
  from Chapter 4, as the chapter roadmap and `AGENTS.md` say.
- Say that the detailed roadmap in the chapter is a reference to return to.

### 16. The Chapter 1 R practical

- Keep the four bullets and add the AI line from the notes onto the slide, in the chapter
  practical's own words if available (read `../Practicals/material.qmd` first): AI is for
  understanding and debugging; the learner explains the code and the ecological result.
- Keep the optional live demonstration inside the three minutes.

### 17. Summary and closing questions

- Keep the four bullets and the two closing questions.
- Add a final line: "Follow the cycle: question, model, data, estimation, comparison,
  answer", and tell the presenter to show the cycle figure again (it is already in the
  slide deck on slide 5; navigating back is enough, no new slide).
- Keep the expected answers in the notes.

## Disposition of every review point

| Review point | Handled in |
|---|---|
| 1. Standard statistics are not enough (non-linear, non-Normal, unbalanced) | Slides 1, 3 |
| 1. Two course objectives and `glmmTMB` | Slides 1, 15 |
| 1. p-value critique, null model, Wasserstein | Slide 13 |
| 1. Frequentist and Bayesian stance, approximate uncertainty | Slide 10 |
| 1. Hierarchical models separate the errors | Slide 6 notes, slide 8 notes |
| 1. Three-part cycle and chapter mapping | Slide 5 |
| 1. Supplement on formula-based methods, Chapters 7 and 8 | Slide 15 |
| 1. A statistical model needs a stochastic component | Slide 4 notes |
| 1. Unexplained is not the same as random (Diaconis) | Slide 6 notes |
| 1. AI use | Slide 16 |
| 2.1 Spray figure framed as explained variation | Slide 8 (issue A) |
| 2.2 Discussion item 2 ambiguous | Slide 11 (issue B) |
| 2.3 Stance on null testing softened | Slides 1, 2, 13 |
| 2.4 Band is not where species lie (notes only) | Slide 10 |
| 2.5 "Other uncertainties": no probabilities for models | Slides 5, 13 |
| 2.6 Data come from the process, not the model | Slide 12 |
| 2.7 Stale roadmap comment in the script | Housekeeping |
| 2.8 Nested distributions in the definition of a model | Slide 4 notes |
| 2.9 AIC caption | Slide 5 (kept) |
| 2.10 Process list lacks dependence and non-linearities | Slide 6 |
| 3.1 Open with the problem | Slide 1 |
| 3.2 Straight line against curve | Slide 3 |
| 3.3 Running example and taxonomy | Slides 6, 8, 10, 11 |
| 3.4 Merge or trim slides | Slides 6, 13, 14 |
| 3.5 Move the cycle earlier | Slides 5, 17 |
| 3.6 Take-home sentence on "as if a random sample" | Slides 9, 12 |
| 3.7 Sparse slides and a concrete cue | Slide 6 (20 versus 16), slide 3 |
| 3.8 Voice | Notes style, below |

## Notes style

The speaker notes and script are a generated draft in a cautious register. While you edit,
shorten hedges ("generally", "does not determine", "an analysis that estimates ... gives us
information"). Write the notes as a teacher who defines a concept, shows one example and
says what it is for in this course. The chapter's remarks that are honest asides ("those
pesky assumptions") may appear as speaker prompts, but do not put first-person opinion in
the author's mouth beyond what the chapter states. Avoid slogans and quips.

## Housekeeping

1. **README output path.** `lecture-README.md` says the render writes
   `Chapter_1/lecture.html`; the file is at `Chapter_1/Lecture/lecture.html`. Check where
   Quarto writes it (run the render if Quarto is available) and correct the README.
2. **Links in `lecture-script.md`.** They point to `Theory.qmd`, `Practicals/material.qmd`
   and `../AGENTS.md`, relative to `Chapter_1/`, and break from inside `Lecture/`. Change
   to `../Theory.qmd`, `../Practicals/material.qmd` and `../../AGENTS.md`. Check each.
3. **Stale statement.** The "Source and preparation notes" of the script say that the
   package timing "supersedes the older software descriptions still present in the Chapter
   1 roadmap". The chapter roadmap already describes RTMB from Chapter 2. Remove the
   sentence and, if it is no longer true, any claim derived from it.
4. **Figures in the script.** The script says to reuse the chapter figures
   (`fig-observation-error`, and so on) and "preparation requires … three chapter figure
   displays", while the slides use PNG copies in `lecture-assets/`. Rewrite the script
   to name the PNG files, and keep the README table of the copies. The copies go stale if
   the chapter figures change; keep that warning.
5. **Slide numbers in the script and notes.** Update the timing table, the cross-references
   ("slide 3", "slides 13, 17 and 18"), the break suggestion ("after slide 12") and the
   "Adjustments during delivery" section to the new order. The new shortening advice: if
   discussion runs long, use the slack first, then shorten slides 14 and 15 to one spoken
   sentence each.
6. **README.** Update the slide count (17), the statement about slides 15 and 16 (now
   5 and 12), the duration (60 minutes with slack), and mention the edited
   `feeding-response.svg`.
7. **Do not touch** `lecture.html` by hand. Re-render it only if Quarto is available.

## Checks

- Read the final `lecture.qmd` and compare each slide with the chapter section it
  represents. For each statement of the chapter listed in the disposition table, confirm
  that it is present and not distorted.
- Check that the slide count is 17, that `data-timing` values and the elapsed times in the
  notes add up to 56 minutes plus 4 minutes of slack, and that every slide number in the
  notes is correct.
- Check British spelling, capitalised distribution names (Negative Binomial, LogNormal),
  slashes in units (kg, mm), and that no pipes or code appear on slides.
- If Quarto is installed, render with
  `quarto render Chapter_1/Lecture/lecture.qmd --to revealjs` and look at slides 1, 3, 6,
  13 and 15 for overflow at 1440×900 (the most crowded ones). If it is not available, say
  so. Never claim a render that did not run.
- Check that the edited SVG displays in both the rendered slide and the PNG fallback, with
  the alt text.

## Report back

State: what changed per slide; which review points are covered and how; anything you left
out and why; what ran and what did not; whether `AGENTS.md` was reviewed (workflow step 7).
The lecture is not mentioned in `AGENTS.md`. Decide whether a one-line entry in "Review
status" is a durable decision (a lecture exists, a draft awaiting the author's review) and
say what you did. List chapter issues you noticed but did not change.
