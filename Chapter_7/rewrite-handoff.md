# Handoff: rewrite of Chapter 7 (grouped ecological response curves)

This file tells future agents how to rewrite Chapter 7: theory, practical, one lecture, and the
cross-references and builds that depend on them. The scope, examples and structure below were
settled with the author on 4 November 2026. Do not change them without asking. Routine wording,
layout and coding choices are yours.

**The author does not review between stages.** They review the finished work after Stage 7. So
every stage must leave the work in a state that the next stage can build on without asking,
verify its own numbers in R, and record what it did in "Progress log" at the end of this file.
When a stage meets a question that would change the scientific meaning or the scope, it makes the
most conservative choice, writes the question under "Open questions for the author" and goes on.

## How the work is split

Each stage is done by **one fresh agent** (general-purpose, in the main working tree, no
worktree), **in this order**; a stage starts only when the previous one has a line in "Progress
log". A stage may be continued by a second agent from the progress log if it runs out of
context.

| Stage | What | Files it writes | Ends with |
|---|---|---|---|
| 0 | Done on 4 November: the author's decisions, feasibility checks in R, this plan | This file, one line in `AGENTS.md` | This file |
| **1** | Theory, part A: front matter to the end of "Group-level predictors and shrinkage" | `Chapter_7/Theory.qmd` | Part A renders and every number is checked in R |
| **2** | Theory, part B: uncertainty and REML, observed and new plants, checking, comparison, recipe, summary, quiz | `Chapter_7/Theory.qmd` | The whole page renders in the dev profile |
| **3** | Practical: student page and solutions | `Chapter_7/Practicals/no_solution.qmd`, `solution.qmd` | Both pages render |
| **4** | Independent review of theory and practical (statistics, voice, code, numbers), with fixes | The three pages | A review report in "Progress log" |
| **5** | Lecture: figures, slides, demo script | `Chapter_7/Lecture/` | The deck renders and every slide was inspected |
| **6** | Lecture script and its PDF | `Chapter_7/Lecture/lecture-script.md`, `.pdf` | The script agrees with the slides |
| **7** | Integration: links and promises elsewhere, guidance files, production build, final report | Other pages, `AGENTS.md`, style guides, `_quarto-prod.yml`, glossary | Production render and the report to the author |

**Branch and commits.** Work on branch `Chapter_7`, which was fast-forwarded on 4 November to
the end of the Chapter 6 rewrite (`chapter_6`, commit `9f6e313`). The author authorised commits
for this rewrite: at the end of each stage, commit the files of that stage with the message
`Chapter 7 rewrite: stage N` and the attribution lines of the session. Never push. Leave
unrelated changes in the working tree alone.

**R.** R is not on the `PATH` of the Bash tool. Use `"/c/Program Files/R/R-4.6.1/bin/Rscript.exe"`
(R 4.6.1 with RTMB 2.0, RTMBdist 1.1.0, TMB 1.9.25, emdbook 1.3.14, DHARMa 0.5.0, glmmTMB
1.1.15.2). Quarto is on the `PATH`. Run R scripts from files in the scratchpad (no Python is
available; a `python` call hangs on a Windows stub).

**Launch prompt for a stage** (the author or an orchestrating session pastes it):

> Read `Chapter_7/rewrite-handoff.md` in full, then carry out Stage N exactly as it describes.
> Read the files that "Read first" lists for your stage before editing. Verify every number you
> write in R. When you finish, add your line to "Progress log", list any new question under
> "Open questions for the author", commit as the file says, report what you changed and which
> checks ran, and stop. Do not start the next stage.

## Read first

Every stage reads, in this order:

1. `CLAUDE.md`, `AGENTS.md`, `STYLE_GUIDE.md`. The priority section on the author's voice and the
   sections "Presenting code in the text" and "Maximum likelihood with RTMB" (including the
   bullets on response curves, residuals and cross-validation added for Chapter 6) are binding.
2. This file in full.
3. `Chapter_1/Theory.qmd`, sections "Process error", "The modelling cycle" and "Chapter 7:
   Grouped ecological response curves" (the promises that Chapter 7 must keep, or that Stage 7
   corrects).

Then, by stage:

- **Stages 1, 2 and 4:** `Chapter_6/Theory.qmd` in full: the most recent rewrite and the
  reference for structure, depth, R pattern, figures, statistical detail boxes, Practice
  callouts, the recipe and the quiz; Chapter 7 continues it. `Chapter_6/rewrite-handoff.md`,
  "Rules that matter most" and the Stage 4 entry of its "Progress log" (the errors that the
  review found). `Chapter_4/Theory.qmd`: "Maximum likelihood" (the likelihood as a product, the
  footnote on the bar that promises conditional distributions), "Parameterisation, slices and
  profiles", "Standard errors and Wald intervals" (the boxes on the Hessian, Jensen's inequality
  and the delta method), "Likelihood profile intervals", "Bias in finite samples" (the footnote
  that promises REML) and "Model comparison". `Chapter_2/Theory.qmd`: "Joint distributions and
  independence" and "Joint distributions of continuous variables" (Chapter 7 continues them with
  conditional distributions; reuse their notation and the two-seed table). `Chapter_3/Theory.qmd`:
  the bias of the variance estimator (the $n-1$ that REML generalises).
  `Supplements/deterministic-functions.qmd`, the entry "Saturating exponential"
  (`#sec-fn-monomolecular`). `Supplements/distributions.qmd`, the Normal and Beta-Binomial
  entries. `Supplements/canned.qmd`, "Random effects" and "From TMB to `glmmTMB`" (what it says
  that Chapter 7 teaches). The current `Chapter_7/Theory.qmd` (to see what is replaced; do not
  copy its wording, which is generated and stale).
- **Stage 3:** the theory as Stages 1 and 2 left it; `Chapter_6/Practicals/no_solution.qmd` and
  `solution.qmd` (the reference for format, worked exercise, question headings and the skeleton
  of the extra exercise); `Chapter_4/Practicals/no_solution.qmd`, Exercise 1 (the reed frog tanks
  of `ReedfrogPred`, whose solution promises Chapter 7) and the opening of Exercise 2;
  `Chapter_3/Practicals/no_solution.qmd`, Exercise 1 and `Chapter_4/Theory.qmd` where the owl
  data are introduced (visits to the same nest, promised to Chapter 7); `Chapter_2/Theory.qmd`,
  "A simple diagnostic for overdispersion" (the salamander counts); the current Chapter 7
  practical.
- **Stage 4:** everything that Stages 1 to 3 read, and the three new pages.
- **Stages 5 and 6:** `STYLE_GUIDE_LECTURE.md`; `Chapter_6/rewrite-handoff.md` (sections "The
  lecture", "Checks for Stage 5", "Stage 6" and the Stage 5 and 6 entries of its "Progress
  log", which record what failed at slide size); `Chapter_6/Lecture/` (`lecture.qmd`,
  `lecture-script.md`, `demo-cycle.R`, `lecture-assets/figures.R`): the most recent deck and the
  reference for format, amount of text, demo and script; `Chapter_3/Lecture/lecture.qmd` (the
  author's own edits of format); the new Chapter 7 theory and practical.
- **Stage 7:** every file listed in "Stage 7" below.

## Author's decisions (4 November 2026)

**Examples and data**

- **One running example in the theory: CO₂ uptake curves of 12 plants**
  (`datasets::CO2`, built into R; Potvin, Lechowicz and Tardif 1990, *Ecology* 71: 1389–1400,
  a paper on the analysis of ecophysiological response curves with repeated measures).
  Six plants of the grass *Echinochloa crus-galli* came from Quebec and six from Mississippi;
  three of each were chilled overnight before the measurements; the CO₂ uptake of every plant
  was measured at the same seven ambient CO₂ concentrations (84 rows). The observational unit
  is one measurement, the group is the plant.
- **`shapes1.csv` is no longer used** (it is simulated, and its leaf identity came from row
  order). The `shapes*.csv` files stay in `Data/` until the author decides (Stage 7 lists them).
- **Connection to Chapter 6 in prose only:** where conditional and marginal distributions are
  defined, one paragraph (no code) says that the Beta-Binomial of Chapter 6 is the marginal
  distribution of a Binomial count whose probability varies among tanks according to a Beta
  distribution, and that a random effect is the same idea with a Normal distribution on another
  scale, which has no closed form. The reed frog tanks with a random effect are an exercise of
  the practical.
- **The practical uses four real data sets, each keeping a promise of an earlier chapter:**
  Loblolly pines (worked), reed frog tanks (`emdbook::ReedfrogPred`, Chapter 4 practical), owl
  nests (`glmmTMB::Owls`, Chapters 3 and 4), salamander sites (`glmmTMB::Salamanders`, Chapter
  2), and an extra simulation exercise on REML. Details under "The practical".

**Model and content**

- **Curve:** the saturating exponential shifted along $x$, with generic symbols (STYLE_GUIDE,
  "Deterministic functions"): $\mu(x)=a\left(1-e^{-b(x-c)}\right)$, where $a$ is the asymptote
  (µmol/m²/s), $b$ the rate (L/µL) and $c$ the CO₂ concentration at which uptake is zero (µL/L).
  Link to `deterministic-functions.qmd#sec-fn-monomolecular`. Normal observation model with
  standard deviation $\sigma_{\mathrm{obs}}$.
- **The random effect is on the logarithm of the asymptote:** $a_j=a\,e^{u_j}$ with
  $u_j\sim\operatorname{Normal}(0,\sigma^2_{\mathrm{plant}})$, so every asymptote is positive.
  One random effect throughout the theory; a random rate was checked and adds little (NLL
  191.37 against 192.09), so the theory does not use it (one sentence may say that any parameter
  of a curve can vary among groups, and that the practical or `canned.qmd` shows more).
- **Story:** pooling first, then predictors. Complete pooling (one curve), no pooling (one
  asymptote per plant as ordinary parameters), partial pooling (the random asymptote); then
  origin and chilling as fixed effects on the log asymptote, **as contrasts with an
  interaction** (author's decision): a baseline (R's reference levels: Quebec, non-chilled) plus
  the effects of Mississippi, of chilling, and of their interaction. **A callout explains that
  the effects of groups can be encoded in different ways** (one mean per group, or a baseline
  plus effects and interactions): it is the same model, but the second form quantifies the
  differences between treatments directly, and which one to use depends on the question. The
  predictors explain most of the variation among plants and make shrinkage visible.
- **Conditional distributions: a short general section** (author's decision): the definition
  on Chapter 2's discrete joint table first, then the continuous case, then the model
  $Y_{ij}\mid u_j$ and the marginal distribution as an integral; the Beta-Binomial paragraph;
  one Practice callout.
- **Marginal likelihood and the Laplace approximation:** intuition in the main text, a hidden
  figure of the integrand for one plant with its Normal-shaped approximation (author's
  decision), the formula in a statistical detail box, and RTMB's `random` argument doing the
  calculation. No integral is calculated by hand in a visible chunk.
- **REML: a short section with code** (author's decision): why maximum likelihood estimates of
  variances are too small when fixed effects are estimated (the $n-1$ of Chapter 3), the
  one-change RTMB version (the fixed effects added to `random`), the CO₂ numbers, and two
  cautions (an approximation for non-linear or non-Normal models; models are compared with
  maximum likelihood fits). This keeps the promise of Chapter 4's footnote.
- **After the fit, the theory covers all four** (author's decision): residuals with DHARMa
  from `obj$simulate()`, which redraws the plant effects; the curve of an observed plant against
  the curves for new plants; AIC on the marginal likelihood; leave-one-plant-out
  cross-validation.
- **$n$ in AICc and BIC** (the question that Chapter 6 deferred): grouped models are compared
  with AIC and leave-one-plant-out cross-validation only; the text explains that $n$ is
  ambiguous for grouped data (somewhere between the number of groups and the number of
  observations), which is why AICc and BIC are not used for these models (author's decision).
- **No pooling is excluded from the comparison table, with an explanation** (author's
  decision): its AIC (372.9) is lower than that of every mixed model, because its likelihood
  describes new measurements of the same 12 plants, whereas the marginal likelihood describes a
  new plant; leave-one-plant-out cannot score it (it has no asymptote for a new plant). One
  paragraph says so; no conditional AIC.
- **The `%~%` notation is not used** anywhere in Chapter 7. Every NLL follows the
  `STYLE_GUIDE.md` pattern (two lists, `getAll()`, `cmb()`, `MakeADFun()`, BFGS); the random
  effects are a third kind of element of the list of parameters.

**Lecture**

- **One lecture of 150 minutes** (two breaks of 10), in `Chapter_7/Lecture/`, with **one live
  demo of 18 minutes** (2 at the slide, 16 in R) from `demo-pooling.R`.
- **The demo goes from pooling to partial pooling:** complete pooling, no pooling, the random
  asymptote with `random = "u"`, the variance components, the predicted plant effects with
  their standard errors, origin and chilling, the shrinkage plot, and curves for new plants. No
  model comparison.

**Build:** Stage 7 adds the theory, practical, solutions and lecture of Chapter 7 to
`_quarto-prod.yml`.

## Choices I made within those decisions (the author may overrule them in review)

- **Size:** the theory stays below about 1,900 source lines (Chapter 6 has about 1,710).
  Principles over examples: no detail of the CO₂ experiment that does not support a general
  point (no photosynthetic biochemistry beyond one sentence on what the asymptote means).
- **CO₂ units:** R's help page (`?CO2`) gives the concentration in mL/L, which cannot be right
  (1000 mL/L would be pure CO₂); ambient concentrations of 95 to 1000 are in µL/L (ppm). Stage 1
  states µL/L, checks it against Potvin et al. (1990) or Pinheiro and Bates (2000) if it can,
  and adds a footnote that the help page says mL/L. Uptake is in µmol/m²/s.
- **Terms:** **fixed effects** (parameters shared by all groups, including the effects of
  group-level predictors), **random effects** (group deviations described by a distribution),
  **mixed-effects model**, **hierarchical** or **multilevel model** (defined once, with one
  sentence that "random" does not mean randomly allocated); **variance components**
  ($\sigma^2_{\mathrm{plant}}$, $\sigma^2_{\mathrm{obs}}$); **predicted plant effects** for the
  values of $u_j$ that RTMB returns (the conditional modes, named once; they are not estimates
  of parameters); **shrinkage**; **partial pooling**. "Population" is avoided for the
  distribution of plant effects (`STYLE_GUIDE.md`, "Model, not truth"): say "the distribution of
  plant effects" or "plants in general".
- **Interpretation of a log-scale standard deviation:** $\sigma_{\mathrm{plant}}=0.079$ means
  that the asymptotes of plants of the same origin and treatment differ by roughly 8% (one
  sentence: for small values, a standard deviation on the log scale is approximately a
  coefficient of variation). The curve with $u_j=0$ has the median asymptote of plants in
  general, not the mean (link to Chapter 4's box on Jensen's inequality).
- **Curves for new plants:** the 2.5% and 97.5% quantiles of the asymptote among plants,
  $a\,e^{\pm1.96\,\sigma_{\mathrm{plant}}}$, at the estimates (exact quantiles because the curve
  increases with $u$); one sentence that this range leaves out the uncertainty of the
  estimates. No band from `ADREPORT()` is required in Chapter 7.
- **Simulation:** in the NLL, the line with the density of `u` comes **before** `u` is used
  (checked: otherwise `obj$simulate()` fails with "Non-numeric argument to mathematical
  function"); then `obj$simulate()` draws new plant effects and new observations (unconditional
  simulation). Conditional simulation (plant effects kept at their predicted values) is named in
  one sentence. The rule goes into `STYLE_GUIDE.md` in Stage 7.
- **Residuals per plant:** DHARMa residuals for each observation and, with
  `recalculateResiduals(group = ...)`, one per plant. `fittedPredictedResponse` is the curve
  with $u_j=0$. Same exception as Chapter 6: DHARMa's own base-graphics plots with visible code.
- **Leave-one-plant-out:** the held-out plant is scored by its marginal log-likelihood (its
  seven measurements together, its plant effect integrated out). This needs one new tool,
  `map` in `MakeADFun()`, which fixes parameters at given values: an object for the held-out
  plant with every fixed parameter mapped to its estimate and `random = "u"` returns that
  plant's marginal NLL from `obj$fn()`. Checked in R (see the table). Introduce `map` there,
  with a bullet list of what it takes; the comparison of fixed-effect structures could also use
  `map` to fix an effect at zero, but separate NLLs are clearer for students (Stage 2 chooses
  and keeps it simple).
- **Statistical detail boxes:** the Laplace approximation; shrinkage in the Normal linear case
  (the weight $n_j\sigma^2_{\mathrm{plant}}/(n_j\sigma^2_{\mathrm{plant}}+\sigma^2_{\mathrm{obs}})$
  on a group's own mean); REML (what is integrated). **Technical detail box:** what RTMB does
  with `random` (an inner optimisation over $u$ at every evaluation of the NLL, and the Hessian
  with respect to $u$ from automatic differentiation; link to Chapter 6's `#sec-makeadfun`).
  The main text never relies on a symbol that only a box defines.
- **Numbered `Practice` callouts** (`imp-` IDs), three, as in Chapter 6: one on conditional
  distributions (paper or R as a calculator), one on shrinkage (which of two groups, one with
  few and one with many observations, is pulled more towards the mean, and why), one on curves
  for observed and new groups or on what a variance component means. Stage 7 updates
  `AGENTS.md` and `STYLE_GUIDE.md` (numbered through Chapter 7).
- **Roadmap table** after the learning goals and a **recipe** callout before the summary, as in
  Chapters 4 and 6 (the recipe extends Chapter 6's ten steps for grouped data; it does not
  repeat them word for word).
- **glmmTMB:** one question of the practical (Exercise 4) fits the same model with
  `glmmTMB::glmmTMB()` and compares the log-likelihood and estimates (identical, checked). The
  theory has one sentence that formula-based tools fit such models and a link to
  `canned.qmd`; it does not use `glmmTMB`. Call it with the prefix and do not attach it:
  `library(glmmTMB)` masks `dbell()`, `dgenpois()` and other functions of RTMBdist.
- **Stage 4 exists** because the author does not review between stages: a fresh agent who did
  not write the pages checks them.

## Rules that matter most

These come from the author's corrections of Chapters 3 to 6 and their lectures. They are in
`STYLE_GUIDE.md`, `STYLE_GUIDE_LECTURE.md` and `AGENTS.md`; they are repeated here because they
are the ones that generated text breaks most often.

1. **Definition first, example second.** Each section opens with the general concept in bold and
   general symbols ($Y_{ij}$, $u_j$, $\boldsymbol\theta$, "a group", "an observation"), then the
   CO₂ case. Never open with the plants.
2. **Principles over examples.** The example serves the general statement. Do not turn the
   CO₂ experiment into a case study.
3. **No calculation by hand that a TMB tool does:** no Laplace approximation or integral in a
   visible chunk (the hidden figure is an illustration), no Hessian by hand, no delta method in
   R, no profile with a loop of inner fits, no `uniroot()`. `random =`, `sdreport()`,
   `ADREPORT()`, `TMB::tmbprofile()` with `confint()`, `obj$simulate()`.
4. **One step, one chunk, next to its explanation**; bullets for the items of a recipe (the
   arguments `random` and `map`, the elements of `summary(sdreport(...), "random")`); do not
   repeat in the text a number that the chunk prints unless it is compared or interpreted.
5. **Voice:** no quips, no scene-setting hooks, no "X, not Y" reflex, one caveat where the risk
   is, provenance stated once, no first-person opinion invented for the author, no leaking of
   the authoring process (the current chapter's "The author supplied the mapping" is the
   example of what not to write). Formal register. British English. Units with a slash; "per
   plant" keeps "per", because a plant is a sampling unit.
6. **Notation:** $\log(x)$ with parentheses; variance parameters $\sigma^2$ with descriptive
   subscripts ($\sigma^2_{\mathrm{plant}}$, $\sigma^2_{\mathrm{obs}}$), never $\tau^2$, described
   as variances (the code takes standard deviations; say that the square is the variance); $K$
   for the number of parameters in AIC (it counts the variance parameters, not the random
   effects); "likelihood profile", never "profile likelihood"; "hypothetical samples", never
   "experiments", for repeated sampling (the CO₂ experiment itself stays an experiment); "model
   probability", "data generating process".
7. **R:** `=` for assignment, no pipes, `silent = TRUE`, `method = "BFGS"`, `gr = obj$gr`, never
   `reltol`, RTMB first and RTMBdist second, distribution functions from RTMB or RTMBdist inside
   an NLL, object names `<model>_obj`, `<model>_fit`, `<model>_sd`, `<model>_profile_<par>`,
   starting values simple and fixed in simulations, seeds set once before a batch. The density
   of the random effects comes before they are used. `CO2` is a `groupedData` object with an
   ordered factor `Plant`: convert it with `as.data.frame()` and build the integer index of the
   plants explicitly.
8. **Never claim a render or execution that did not run.** Never invent a citation, data set or
   number; every footnote reference is checked (title, journal, year) before it is written.

## The theory (Stages 1 and 2)

Front matter: `title: "Grouped ecological response curves"` only (remove the `format:` and
`execute:` blocks and the two TODO paragraphs; without the global `eval: false` every chunk is
evaluated unless it carries `#| eval: false`). A first hidden chunk loads `ggplot2`, as in
Chapters 4 to 6. Use ```` ```{r} ```` chunks only. There are no section IDs in the current page
that other pages link to (Stage 7 checks); new IDs are suggested below.

Below, each section has **General** (what the section states, in general terms; required) and
**Example** (what the CO₂ data show; comes after). Object names are suggestions; once Stage 1
chooses them, later stages keep them.

### Stage 1: part A

**`# Introduction`** (two paragraphs). Opens "In this chapter, we learn how to fit response
curves to observations that come in groups...": repeated measurements on the same plants,
animals, nests or sites share the conditions of their group, so they are not independent; a
grouped model describes a common curve, how the curve varies among groups, and the variation
within groups. Second paragraph: what is new (conditional and marginal distributions, random
effects and partial pooling, maximum marginal likelihood and the Laplace approximation, variance
components and shrinkage, REML, curves for new groups, checking and comparing grouped models);
the one example (CO₂ uptake of 12 plants, Potvin et al. 1990, footnote with the reference and
"The data are in R as `CO2`"); the Normal observation model and the saturating exponential;
RTMB's `random` argument. Chapter 6 treated every observation as independent; Chapter 8 deals
with the difficulties of optimisation.

**`# Learning goals`**: Chapter 2 format ("In this chapter, we will cover:" and short phrases
ending in semicolons, in the order of the chapter): observations in groups; conditional and
marginal distributions; fixed and random effects; complete, no and partial pooling; the marginal
likelihood and the Laplace approximation; random effects in RTMB; variance components and
predicted group effects; group-level predictors and shrinkage; uncertainty of variance
components and REML; curves for observed and new groups; checking a grouped model; comparing
grouped models with AIC and leave-one-group-out cross-validation. Closing sentence: the Normal
entry of the distribution supplement and the saturating exponential of the function
supplement.

**Roadmap table** (as in Chapter 6: Step, Question it answers, In R; caption "Roadmap of the
chapter."). Rows: the groups; the model; pooling; the fit; predictors; uncertainty and REML; new
groups; checking; comparison.

**`# Observations in groups {#sec-grouped-observations}`**

- General: an **observational unit** and a **group** (or grouping unit); observations of one
  group share conditions (genotype, microhabitat, a nest, an observer), so they tend to resemble
  each other more than observations of different groups, and treating them as independent makes
  intervals too narrow and the evidence look stronger than it is (the reed frog tanks of the
  Chapter 4 practical; Chapter 6's question about $n$). Examples in one sentence: nests, sites,
  tanks, individuals. Variation among groups is part of the process variation of Chapter 1.
- Example: the CO₂ data: units, design (2 origins × 2 treatments × 3 plants × 7
  concentrations), the curve $\mu(x)=a(1-e^{-b(x-c)})$ with its units, why the asymptote is the
  natural parameter to vary (the uptake capacity of a plant). Chunk: `as.data.frame(CO2)`, an
  integer index `plant` (1 to 12), and the list of data.
- Figure `fig-co2_data` (hidden, ggplot2): four panels (origin × treatment), the three plants of
  each panel with points and lines that join the measurements of one plant (line type or shape
  per plant, Okabe–Ito blue). Caption: lines join measurements of the same plant.

**`# Conditional and marginal distributions {#sec-conditional}`**

- General: the **conditional distribution** of $X_1$ for a given value of $X_2$,
  $P(X_1=x_1\mid X_2=x_2)=P(X_1=x_1,X_2=x_2)/P(X_2=x_2)$, on Chapter 2's two-seed table with a
  worked number ($0.28/0.70=0.4$); independence means that the conditional distribution equals
  the marginal one; the continuous case with densities, $f(x\mid y)=f(x,y)/f(y)$; the joint
  density as conditional times marginal, and the marginal density as the integral of that
  product over the other variable. The bar is the same as in Chapter 4's likelihood notation
  ("for a given value of"); now what is given is the value of a random variable.
- The Beta-Binomial paragraph (author's decision; no code).
- Example: the grouped model, $u_j\sim\operatorname{Normal}(0,\sigma^2_{\mathrm{plant}})$ and
  $Y_{ij}\mid u_j\sim\operatorname{Normal}(\mu_j(x_{ij}),\sigma^2_{\mathrm{obs}})$ with
  $\mu_j(x)=a\,e^{u_j}(1-e^{-b(x-c)})$, a "where" clause; the measurements of a plant are
  independent for a given $u_j$, but not marginally, because they share $u_j$. Then the names:
  fixed effects, random effects, mixed-effects, hierarchical and multilevel models.
- Practice callout (`imp-`): a conditional probability from a small joint table, or the
  conditional distribution of one measurement given a group effect (paper or R as a calculator).

**`# Three ways to share information {#sec-pooling}`**

- General: **complete pooling** (one curve for all groups), **no pooling** (separate parameters
  for each group, ordinary parameters with no distribution), **partial pooling** (group
  parameters drawn from a distribution whose variance is estimated). What each assumes and
  which question each answers (the 12 measured plants, or plants in general).
- Example: chunk with the complete-pooling NLL and fit; chunk with the no-pooling NLL (an index
  vector of 12 log asymptotes, as in Chapter 6's practical, Exercise 2) and fit. Partial pooling
  is fitted in the next section. A compact figure or table comparing the two fits is optional.

**`# Maximum marginal likelihood {#sec-marginal-likelihood}`**

- `## The marginal likelihood`: General: the random effects are not observed, so the likelihood
  of the parameters $\boldsymbol\theta$ (fixed effects and variance components) integrates them
  out: for group $j$, $L_j(\boldsymbol\theta)=\int f(\mathbf y_j\mid u)\,f(u\mid\sigma_{\mathrm{plant}})\,du$,
  and the likelihood is the product over groups (groups are independent). Why not estimate the
  12 effects as parameters (that is no pooling); one variance parameter instead of 12 effects.
- `## The Laplace approximation`: General: intuition (the integrand has a peak at the predicted
  effect; near the peak its logarithm is close to a parabola, so the integrand is close to a
  Normal-shaped curve whose area is known; Chapter 4's quadratic approximation of the
  log-likelihood is the same idea). Hidden figure `fig-laplace` for one plant (for example plant
  11, the most shrunk one): the integrand as a function of $u$ and its approximation, from the
  fitted model. When it is accurate (many observations per group, Normal or nearly Normal
  conditional distributions; exact for Normal linear mixed models, as `canned.qmd` says) and
  when not (few observations per group, counts near zero, binary data). Statistical detail box
  "Statistical detail: the Laplace approximation" (formula for one dimension, its "where"
  clause, the multivariate determinant in words, "In plain English").
- `## Random effects in RTMB {#sec-random-effects-rtmb}`: General: the NLL is the joint NLL
  (minus the log density of the random effects plus minus the log probability of the
  observations for given effects); the random effects are an element of the list of parameters
  with one starting value per group; `random = "u"` tells `MakeADFun()` to integrate them out
  with the Laplace approximation, so `fn` and `gr` are those of the marginal NLL and `optim()`
  works as before; the density of `u` comes first. Technical detail box on what RTMB does.
  Example: chunk with the NLL (random asymptote, no predictors yet), chunk with `MakeADFun()`
  and `optim()`, convergence.
- `## Variance components and predicted plant effects`: General: the two standard deviations
  and what each measures (scale and units: $\sigma_{\mathrm{plant}}$ on the log scale of the
  asymptote, $\sigma_{\mathrm{obs}}$ in µmol/m²/s); `sdreport()` and `summary(..., "fixed")` and
  `summary(..., "random")` as bullets; predicted plant effects and their standard errors; they
  are not parameters and are not estimated by maximum likelihood. Example: $\sigma_{\mathrm{plant}}$
  0.34, $\sigma_{\mathrm{obs}}$ 2.0 (check), what they mean.

**`# Group-level predictors and shrinkage {#sec-group-predictors}`**

- General: a predictor measured at the level of the group (origin, treatment) is a fixed effect
  that explains part of the variation among groups; the variance component then describes what
  remains. Encoding: contrasts with interaction (author's decision); the callout "Two ways to
  encode groups" (note callout, visible; one mean per group against baseline plus effects and
  interaction; the same model and the same likelihood; the choice follows the question).
- Example: the NLL with `b_miss`, `b_chill`, `b_int` on the log asymptote; fit;
  $\sigma_{\mathrm{plant}}$ falls from 0.34 to 0.079; `ADREPORT()` of the factor by which
  chilling multiplies the asymptote in each origin (0.90 in Quebec plants, 0.59 in Mississippi
  plants), as the ecological answer of the section; Wald intervals on the log scale with the
  endpoints transformed back, or likelihood profile intervals in Stage 2 (Stage 1 decides and
  tells Stage 2).
- `## Shrinkage {#sec-shrinkage}`: General: definition in bold; the predicted effect of a group
  is a compromise between its own data and the distribution of groups; it is pulled further
  towards the group mean when the group has few or noisy observations or when the variance
  among groups is small; this is **regularisation**, and it is part of the model, not a
  correction. Statistical detail box with the weight in the Normal linear case. Example: figure
  `fig-shrinkage` (hidden, ggplot2): for each plant, the no-pooling asymptote, the predicted
  asymptote of the mixed model and the mean of its origin × treatment group (arrows or segments
  from the first to the second). Without the predictors shrinkage is almost invisible (seven
  precise measurements per plant); with them plant 11 moves from 14.2 to 15.6 µmol/m²/s, towards
  18.5. Say both.
- Practice callout (`imp-`) on shrinkage.

### Stage 2: part B

**`# Uncertainty in a grouped model {#sec-grouped-uncertainty}`**

- `## Standard errors and likelihood profile intervals`: General: `sdreport()` and
  `TMB::tmbprofile()` work on the marginal NLL as in Chapters 4 and 6; a variance component is
  bounded below by zero, its log-likelihood is often asymmetric, and with few groups it is
  poorly determined: use the profile interval, on the log scale of the standard deviation.
  Example: profile interval of $\sigma_{\mathrm{plant}}$ (0.045 to 0.139) and of the interaction
  (−0.64 to −0.21 on the log scale; transformed back it is a factor of about 0.53 to 0.81 on the
  ratio of the chilling effects: check and phrase in ecological terms).
- `## Restricted maximum likelihood {#sec-reml}`: General (author's decision, see above).
  Example: the same NLL with the fixed effects added to `random`; $\sigma_{\mathrm{plant}}$ 0.079
  (ML) against 0.105 (REML), $\sigma_{\mathrm{obs}}$ 2.04 against 2.05. Optional footnote
  (Patterson and Thompson 1971, *Biometrika*; check before citing, or leave it out).

**`# Curves for observed and new plants {#sec-new-groups}`**

- General: the curve of an observed group uses its predicted effect; the curve with $u_j=0$ is
  the typical curve (median asymptote) of its origin and treatment; a new group is a new draw
  of $u$, so its curve lies anywhere in the range given by the distribution of group effects.
  Which one answers which question (these plants; a plant that was not measured).
- Example: figure `fig-new_plants` (hidden, ggplot2) for one origin × treatment group: the
  measurements, the conditional curves of its three plants, the typical curve and the range of
  curves for new plants. Practice callout (`imp-`) if not used before.

**`# Checking a grouped model {#sec-grouped-residuals}`**

- General: a fitted grouped model is a data generating process with two levels: simulate new
  group effects, then new observations; `OBS()` and `obj$simulate()` do both (rule on the
  order of the lines; conditional simulation in one sentence). Scaled quantile residuals per
  observation and per group (`recalculateResiduals(group = ...)`), as in Chapter 6 (link
  `../Chapter_6/Theory.qmd#sec-response-residuals`; do not repeat the definition). One warning
  callout where the risk is: residuals per observation can hide a problem at the level of the
  groups (and the other way round), and a quiet plot does not show that the distribution of
  group effects is Normal with 12 groups.
- Example: 1,000 simulations (seed of Stage 2's choice), DHARMa plots, dispersion statistic
  (0.80 with seed 701), the residual of each plant (plant 11 has 0.01: its asymptote is lower
  than the model expects for its group; phrase as a pattern to note, not a test).

**`# Comparing grouped models {#sec-grouped-comparison}`**

- General: AIC on the marginal likelihood, with $K$ counting fixed effects and variance
  components (not random effects); why $n$ is ambiguous, so AICc and BIC are not used (author's
  decision); a model without the random effect has $\sigma_{\mathrm{plant}}=0$, at the boundary,
  and AIC is then only an approximate guide (one sentence). **Leave-one-group-out
  cross-validation**: hold out a whole group, refit, score the group by its marginal
  log-likelihood; why the held-out part must be a group (Chapter 6 said that it should be a
  block of related observations); `map` with bullets.
- Example: five candidates fitted to the 84 measurements, one table built in R (model, $K$,
  $\ell(\hat\theta)$, AIC, leave-one-plant-out score, differences from the best). The no-pooling
  paragraph (author's decision). Interpretation: the random effect and the predictors (AIC and
  cross-validation agree on the best model; they disagree on the order of two others, which the
  text says), then the ecological answer: chilling reduces the uptake capacity of Mississippi
  plants much more than that of Quebec plants, with intervals and the variation among plants.

**`# A recipe for a grouped response curve`**: a note callout that extends Chapter 6's recipe:
identify the groups and the level of each predictor; choose the parameter that varies among
groups and its scale; write the joint NLL (density of the random effects first); `random`;
fit and check convergence; variance components, predicted effects, profile intervals, REML when
the variances are the question; curves for observed and new groups; simulate and check
residuals per observation and per group; compare with AIC and leave-one-group-out
cross-validation; interpret in units.

**`# Summary`**: a few short paragraphs, no new material; last paragraph points to Chapter 8.

**`# Chapter quiz`**: 8 to 10 questions in the Chapter 6 format (`::::
{.callout-important title="Question N: <ecological setting>"}` with a collapsed answer), each a
new ecological setting that tests one principle: observational unit and group; a conditional
probability; complete, no or partial pooling for a given question; what $\sigma^2_{\mathrm{group}}$
and $\sigma^2_{\mathrm{obs}}$ describe; which group is shrunk more; what `random` does; why REML;
observed against new group; why cross-validation holds out whole groups; why no pooling's AIC
answers another question. Answers explain.

### Numbers checked on 4 November (R 4.6.1, RTMB 2.0, RTMBdist 1.1.0, TMB 1.9.25, DHARMa 0.5.0)

Starting values: `log_asym = log(30)`, `log_rate = log(0.01)`, `c0 = 50`, effects 0,
`log_sd_plant = log(0.1)`, `log_sd = log(2)`, `u = rep(0, 12)` (11 in leave-one-out fits); BFGS
converged (code 0) for every fit to the 84 measurements below. The convergence of the 60
leave-one-plant-out fits was not recorded: Stage 2 counts the failed ones, as Chapter 6 does.
The R scripts are not in the repository; Stages 1 and 2 recalculate every number they write.

| Quantity | Value |
|---|---|
| Complete pooling, no predictors: NLL, $\sigma_{\mathrm{obs}}$ | 296.256, 8.23 |
| No pooling (12 log asymptotes, common rate and $c$): NLL, $K$, AIC | 171.438, 15, 372.87 |
| Random asymptote, no predictors: NLL; $\hat a$ (median), $\hat b$, $\hat c$; $\sigma_{\mathrm{plant}}$, $\sigma_{\mathrm{obs}}$ | 207.605; 30.9, 0.00958, 48.4; 0.335, 2.01 |
| Same model in `nlme` (random effect on $a$ itself, not its log): log-likelihood | −206.18 |
| Random asymptote + origin × chilling (baseline Quebec, non-chilled): NLL | 192.086 |
| Its estimates: `log_asym` (se), `b_miss`, `b_chill`, `b_int` (se) | 3.742 (0.048), −0.306, −0.100, −0.420 (0.099) |
| Baseline asymptote; $\hat b$; $\hat c$ | 42.17 µmol/m²/s; 0.00959 L/µL; 48.4 µL/L |
| $\sigma_{\mathrm{plant}}$ (ML; profile interval); $\sigma_{\mathrm{obs}}$ | 0.079 (0.045 to 0.139); 2.04 |
| Factor of chilling on the asymptote (`ADREPORT()`, se): Quebec, Mississippi | 0.905 (0.061), 0.594 (0.043) |
| Profile interval of `b_int` | −0.638 to −0.209 |
| REML-type fit (fixed effects in `random`): $\sigma_{\mathrm{plant}}$, $\sigma_{\mathrm{obs}}$ | 0.105, 2.05 |
| Group means / no pooling / predicted asymptote, plant 11 (Mc2) | 18.46 / 14.18 / 15.57 |
| Same without predictors, plant 11 | no pooling 14.18, predicted 14.54 |
| Random rate added (independent): NLL | 191.37 (not used) |
| DHARMa (1,000 simulations, seed 701): dispersion; residual of plant 11 | 0.80; 0.01 |

Candidate models (all converged; leave-one-plant-out = sum over the 12 plants of the marginal
log-likelihood of the held-out plant, fitted to the other 11):

| Model | $K$ | NLL | AIC | Leave-one-plant-out |
|---|---:|---:|---:|---:|
| Complete pooling, no predictors | 4 | 296.256 | 600.51 | −310.74 |
| Complete pooling, origin × chilling | 7 | 202.661 | 419.32 | −235.93 |
| Random asymptote, no predictors | 5 | 207.605 | 425.21 | −216.80 |
| Random asymptote, origin + chilling | 7 | 197.394 | 408.79 | −214.11 |
| Random asymptote, origin × chilling | 8 | 192.086 | 400.17 | −213.75 |

The held-out score was calculated with an object for the held-out plant in which every fixed
parameter is mapped (`map = list(name = factor(NA), ...)`) to its estimate from the 11 plants,
`random = "u"` with one starting value, and `obj$fn(numeric(0))`.

## The practical (Stage 3)

Front matter as in Chapter 6 (`title: "Chapter 7: Grouped ecological response curves"`, `date:
today`). An opening paragraph like Chapter 6's: which exercise uses which data, which are core
(1 to 4) and which extra (5), worked Exercise 1, link to the theory, "As in the theory... RTMB
and RTMBdist". A visible chunk loads RTMB and RTMBdist. Headings `# Exercise N: Topic`,
`## Solution`, `### Question n`, as in Chapter 6. Plots in base R only (`STYLE_GUIDE.md`, "Plots
inside exercises"), DHARMa's own plots allowed. Each data set comes with a short provenance
paragraph (check every citation; for built-in data, the help page). Every exercise says which
earlier chapter treated these observations as independent and that the grouped model now
describes the groups.

`no_solution.qmd` contains Exercise 1 with its full worked solution and Exercises 2 to 5 with
questions only (and the skeleton of Exercise 5). `solution.qmd` follows Chapter 6's practice:
it may repeat Exercise 1 in full if a later exercise uses its objects, otherwise it links to the
student page (Chapter 6's open question on this is still unanswered; follow whatever the author
decided by then, or link if undecided). The question text is identical in both files.

**Exercise 1 (worked): Growth of loblolly pines.** `datasets::Loblolly`, 14 trees measured at
ages 3 to 25 years (84 rows; heights in feet, as recorded). The same curve as the theory in the
form $h(t)=A\left(1-e^{-k(t-t_0)}\right)$ ($t_0$: the age at which the curve crosses zero
height), Normal model, random effect on $\log(A)$ per tree. Questions: (1) units, groups and a
plot of the 14 trajectories; (2) complete pooling; (3) the random asymptote with `random`,
convergence, variance components with their units and scales; (4) predicted tree effects,
conditional curves against the typical curve and the range for new trees; (5) DHARMa residuals
per observation and per tree; (6) AIC of complete pooling against the mixed model. Checked:
from `log_A = log(80)`, `log_k = log(0.1)`, `t0 = 2` the mixed model converges with NLL 116.67,
$\hat A=102.0$ ft, $\hat k=0.0390$/year, $\hat t_0=2.06$ years, $\sigma_{\mathrm{tree}}=0.039$,
$\sigma_{\mathrm{obs}}=0.74$ ft. The asymptote lies far above the tallest tree (check the
maximum height and say what this means, as Chapter 6 said for the handling time). The old form
$A-(A-R_0)e^{-kt}$ failed from simple starting values ($k\to0$); do not use it.

**Exercise 2: Survival of tadpoles in tanks.** `emdbook::ReedfrogPred` (48 tanks; `density`
10, 25 or 35 tadpoles; `pred`, `size`, `surv`). Chapter 4's practical, Exercise 1, found that
the tanks vary more than a Binomial model allows. Binomial model with a Normal random effect
per tank on the logit of the probability of survival, and the effect of predators; compare with
the Beta-Binomial model with the same effect (Chapter 6). Questions: the model as conditional
and marginal distributions (one observation per group: the random effect describes variation
among tanks, as the Beta-Binomial does); fit both; compare with AIC (same $K$); the probability
of survival of a typical tank, `plogis()` of the fixed part, against the mean survival over
tanks (Jensen's inequality; calculate the mean by simulation from the distribution of tank
effects); predicted tank effects. Checked (predator effect only): Binomial with tank effects
NLL 109.90, $\sigma_{\mathrm{tank}}=0.78$; Beta-Binomial NLL 113.97. Read Chapter 4's
Exercise 1 first and keep its subset and wording of the data (it mentions 24 tanks and 560
tadpoles; check which subset it used and whether this exercise should use all 48 tanks).

**Exercise 3: Begging calls at owl nests.** `glmmTMB::Owls` (599 visits to 27 nests, 4 to 52
visits per nest). Negative Binomial model (`dnbinom2()` of RTMBdist, mean and shape $k$) for
`SiblingNegotiation`, with the mean $\exp(a+b_{\mathrm{sat}}\,\text{satiated}+b_t(t-24)+u_j)$
($t$ the arrival time in hours) and a random effect per nest. Questions: the curve of calls
against arrival time; fit with and without the nest effect and compare with AIC; predicted nest
effects plotted against the number of visits (shrinkage of lightly visited nests); curves for
deprived and satiated broods for a typical nest and the range for new nests. Checked: NLL
1734.19, $a=2.140$, $b_{\mathrm{sat}}=-0.692$, $b_t=-0.115$/hour, $\sigma_{\mathrm{nest}}=0.42$,
$k=0.89$. The shrinkage pattern was not clear in the check (of the two nests with 4 visits, one
has a predicted effect of −0.05 and the other −0.46): plot the predicted effects against the
number of visits, together with each nest's own log mean ratio, and describe what the plot
shows; do not claim a pattern that it does not show.
Brood size is not modelled (one sentence; an offset is not taught). Chapters 3 and 4 used the
satiated nestlings with female parents only; say that this exercise uses all visits.

**Exercise 4: Salamanders at mined and unmined sites.** `glmmTMB::Salamanders`, species `GP`
(92 counts: 23 sites, 4 visits each). Chapter 2 calculated a dispersion ratio for the 48 counts
at the 12 unmined sites and treated the visits as i.i.d. Poisson model with the effects of
mining and of `cover` (check its definition in `?Salamanders` before describing it) on the log
mean and a random effect per site. Questions: the Poisson model without site effects and its
DHARMa dispersion; the model with site effects; residuals per site; the same model with
`glmmTMB::glmmTMB(count ~ mined + cover + (1 | site), family = poisson, data = ...)` and a
comparison of log-likelihood and estimates (the reference level of `mined` differs: say why
the signs differ). Checked: RTMB NLL 109.1207; glmmTMB log-likelihood −109.1207; $b_{\mathrm{mined}}=-3.742$
(glmmTMB: `minedno` 3.742), $b_{\mathrm{cover}}=0.133$, $\sigma_{\mathrm{site}}=0.43$.

**Exercise 5 (extra): Variance among groups estimated by ML and REML.** Simulation with a
skeleton function `simulate_group_variance()` with two gaps, as Chapter 6's Exercise 4. A
Normal model with a random intercept (an ecological setting of the student's page, for example
log biomass in five quadrats at each of six sites), $\sigma_{\mathrm{group}}=1$,
$\sigma_{\mathrm{obs}}=1$; simulate hypothetical samples with `obj$simulate()`, fit each by ML
(`random = "u"`) and by REML (`random = c("u", "mu")`) from fixed starting values, and compare
the mean of the estimated variances with the true one, with Monte Carlo errors. Record failed
fits. Checked: 500 samples (seed 741) in 13 s: mean variance 0.82 (ML) and 1.03 (REML). The
question asks also how the bias changes with the number of groups (optional: 12 groups).

## The lecture (Stages 5 and 6)

One folder `Chapter_7/Lecture/` with `lecture.qmd`, `lecture-script.md`, `lecture-script.pdf`,
`lecture.scss` (unchanged copy of `Chapter_6/Lecture/lecture.scss`), `demo-pooling.R` and
`lecture-assets/` (with `figures.R`). Title slide: subtitle "Chapter 7 · Lecture", eyebrow
"Grouped Ecological Response Curves". `pagetitle`: "Chapter 7 — Ecological Models and Data
Analysis". Footer: "Ecological Models and Data Analysis · Chapter 7".

The rules of `STYLE_GUIDE_LECTURE.md` hold, above all "General statement first" and "The main
points stand on the slide". Every content slide below is specified as **General** (required, on
the slide), **Example** (in `.example`, caption or code comments) and **Script** (notes for Stage
6). Slide titles name the concept, not the plants. The specification is a plan: Stage 5 takes
the theory as Stage 4 left it as the source of wording, numbers and figures, and adapts a slide
when the chapter differs (and says so in the progress log). Practice slides stand where their
callout stands in the chapter.

### Slide sequence and timing

| Slide | Title | Min | Elapsed |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis (title) | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | Observations in groups | 3 | 4–7 |
| 5 | Response curves measured on the same plants | 3 | 7–10 |
| 6 | Conditional distributions | 4 | 10–14 |
| 7 | Marginal distributions | 4 | 14–18 |
| 8 | Practice 1 | 3 | 18–21 |
| 9 | Fixed effects and random effects | 3 | 21–24 |
| 10 | Three ways to share information | 4 | 24–28 |
| 11 | A model with a random asymptote | 4 | 28–32 |
| 12 | Discussion: which pooling answers which question? | 3 | 32–35 |
| | Break | 10 | 35–45 |
| 13 | The marginal likelihood | 4 | 45–49 |
| 14 | The Laplace approximation | 4 | 49–53 |
| 15 | Random effects in RTMB | 4 | 53–57 |
| 16 | Variance components and predicted effects | 4 | 57–61 |
| 17 | Group-level predictors | 4 | 61–65 |
| 18 | Two ways to encode groups | 3 | 65–68 |
| 19 | Shrinkage | 4 | 68–72 |
| 20 | Practice 2 | 3 | 72–75 |
| | Break | 10 | 75–85 |
| 21 | Live demo: from pooling to partial pooling | 2 + 16 | 85–103 |
| 22 | Uncertainty of variance components and REML | 4 | 103–107 |
| 23 | Observed plants and new plants | 4 | 107–111 |
| 24 | Checking a grouped model | 4 | 111–115 |
| 25 | Practice 3 | 3 | 115–118 |
| 26 | AIC for grouped models | 4 | 118–122 |
| 27 | Leave-one-group-out cross-validation | 4 | 122–126 |
| 28 | Comparing the candidates | 3 | 126–129 |
| 29 | A recipe for a grouped response curve | 2 | 129–131 |
| 30 | The Chapter 7 R practical | 2 | 131–133 |
| 31 | Summary and closing questions | 3 | 133–136 |
| | Slack for discussion | 14 | 136–150 |
| | **Total** | **150** | |

Check: slides 116 (blocks of 35, 30 and 51, the demo included) + slack 14 + breaks 20 = 150.
The minutes of each slide equal its `data-timing` in seconds. The break before the demo lets the
lecturer open R and run section 0 of the demo script. If the theory's Practice callouts stand
elsewhere, move the Practice slides with them and keep at least 8 minutes of slack.

### Slide specifications

1. **Title.**
2. **Overview:** numbered, bold keyword + question: groups (why are grouped observations not
   independent?); the model (how does a curve vary among groups?); the fit (what is a marginal
   likelihood?); interpretation (variances, shrinkage, new groups); checking and comparison;
   the practical.
3. **Where we are** (`.diagram-slide`, `../../Chapter_1/Lecture/ModelCycle.png` unchanged).
   Caption: this lecture extends the model step to groups.
4. **Observations in groups:** observational unit and group; shared conditions; consequences of
   treating them as independent. Example: Chapter 4's reed frog tanks, Chapter 6's tanks.
5. **Response curves measured on the same plants** (`.figure-slide`, `co2-data.png`, copy of
   `fig-co2_data`): the design; the curve with its units. Script: provenance once (Potvin et
   al. 1990, `datasets::CO2`).
6. **Conditional distributions:** definition with the formula; independence as equality of
   conditional and marginal. Example: the two-seed table, $0.28/0.70=0.4$.
7. **Marginal distributions:** joint = conditional × marginal; the marginal as a sum or an
   integral. Example: the Beta-Binomial as a marginal distribution (Chapter 6).
8. **Practice 1.**
9. **Fixed effects and random effects:** the names (fixed, random, mixed, hierarchical,
   multilevel); "random" is a description by a distribution.
10. **Three ways to share information** (a three-column comparison or a small schematic):
    complete, no and partial pooling, what each assumes and answers.
11. **A model with a random asymptote:** the two-level equations; independence for a given
    $u_j$; dependence marginally.
12. **Discussion** (timed, takeaway and activity visible): four ecological questions to match
    with complete, no or partial pooling. Script: expected answers.
13. **The marginal likelihood:** the integral per group, the product over groups; why
    integrate instead of estimating the effects.
14. **The Laplace approximation** (`.figure-slide`, `laplace.png`, copy of `fig-laplace`): a
    parabola for the log integrand near its peak; accuracy; RTMB does it.
15. **Random effects in RTMB** (code from the chapter): bullets for the joint NLL, the density
    of `u` first, `random = "u"`. Script: the technical detail box (inner optimisation).
16. **Variance components and predicted effects** (code `sdreport()`, `summary()`): the two
    standard deviations and their scales; predicted effects are not parameters.
17. **Group-level predictors:** fixed effects on the log asymptote; the variance describes what
    remains. Example: $\sigma_{\mathrm{plant}}$ 0.34 → 0.079; chilling factors 0.90 and 0.59.
18. **Two ways to encode groups:** one mean per group against baseline + effects + interaction;
    same model, different questions.
19. **Shrinkage** (`.figure-slide`, `shrinkage.png`, copy of `fig-shrinkage`): definition; what
    makes a group shrink more; regularisation is part of the model.
20. **Practice 2.**
21. **Live demo: from pooling to partial pooling** (`.demo-slide`): numbered incremental list of
    the general steps of `demo-pooling.R`; a `.demo` box with the script name and sections. No
    model comparison (author's decision).
22. **Uncertainty of variance components and REML:** profile intervals for a variance near zero;
    why ML underestimates variances; REML in one change. Example: 0.079 against 0.105.
23. **Observed plants and new plants** (`.figure-slide`, `new-plants.png`, copy of
    `fig-new_plants`): conditional curve, typical curve, range for new plants; median, not mean.
24. **Checking a grouped model:** simulation at two levels; residuals per observation and per
    group. Example: plant 11. Script: the warning callout.
25. **Practice 3.**
26. **AIC for grouped models:** $K$ counts variance parameters; $n$ is ambiguous, so no AICc or
    BIC; boundary at zero.
27. **Leave-one-group-out cross-validation:** hold out a group, score it by its marginal
    likelihood; why whole groups.
28. **Comparing the candidates** (the chapter's table, `.roadmap` class, at most three columns
    besides the first as the stylesheet allows): takeaway: the criteria rank, the ecology
    interprets; no pooling answers another question.
29. **A recipe for a grouped response curve:** the chapter's recipe, incremental, in keywords.
30. **The Chapter 7 R practical:** the five exercises as bold keywords; takeaway: Exercises 1
    to 4 are the core; try, then check.
31. **Summary and closing questions** (`.closing`): incremental take-home points; takeaway
    string ("Groups · Conditional · Marginal · Pooling · Laplace · Variance · Shrinkage · REML
    · New groups"); two closing questions. Script: transition to Chapter 8 (finding the optimum
    of harder likelihoods).

### Demo script `demo-pooling.R`

Header: packages (RTMB, RTMBdist, TMB) and run time. Sections that match the demo slide: 0
set-up, data and a base R plot of the 12 plants; 1 complete pooling; 2 no pooling (12 asymptotes);
3 the random asymptote with `random = "u"`, the variance components and `summary(sdreport(),
"random")`; 4 origin × chilling, the drop of $\sigma_{\mathrm{plant}}$ and the shrinkage plot
(no pooling against predicted asymptotes, base R); 5 curves of observed plants and the range for
new plants (base R). Object names of the chapter. Runs in a clean session in under 30 seconds;
Stage 5 runs it and records the time.

### Figures

All PNG with `dpi = 192`, copies at the size of the chapter's chunk; every image has `fig-alt`.
`lecture-assets/figures.R` runs in a clean session from the repository root and writes every PNG
into `lecture-assets/`; copies run the chapter's chunks unchanged in order and change only the
last line to save the plot. Expected files: `co2-data.png`, `laplace.png`, `shrinkage.png`,
`new-plants.png`, and a DHARMa plot if slide 24 shows one. A two-panel figure of about 9 × 4
inches goes in a 60 to 64% column beside the bullets (`STYLE_GUIDE_LECTURE.md`). Compare copies
with the rendered chapter figures in `_freeze/Chapter_7/` or `_site`.

### Checks for Stage 5

1. `quarto render Chapter_7/Lecture/lecture.qmd --to revealjs` from the repository root; no
   warnings ignored; delete the generated `lecture.html` afterwards, as for the other lectures.
2. Every slide inspected at 1440 × 900 with all fragments showing, with the headless Edge command
   of `Chapter_4/lecture-handoff.md` ("Checks"), screenshots in the scratchpad. A slide fails if
   anything touches the footer; fix by moving text to the script.
3. General-first audit: list any example number outside an `.example` box, a caption or a code
   comment.
4. Minutes equal `data-timing`; blocks add up.

### Stage 6: the script

Written from the slides as Stage 5 left them (they replace the table above if they differ). The
format of `STYLE_GUIDE_LECTURE.md`, "The script", and of `Chapter_6/Lecture/lecture-script.md`:
opening (draft for review; 150 minutes, slides, slack and breaks; one live demo; links to theory
and practical; which slides use which figure, with `figures.R`); timing table; one section per
slide with the narrative, general rule first; Practice and discussion slides with expected
answers; the demo section with a walkthrough of `demo-pooling.R` by section, the numbers to
expect and when to run section 0; "Adjustments during delivery" (what to shorten first, what to
keep: slides 6, 7, 10, 11, 13, 15, 19 and 23; the demo is kept whole and takes the slack first).
PDF with `quarto render Chapter_7/Lecture/lecture-script.md --to typst` (confirm that it works;
remove the `.quarto/` folder it creates). No first-person anecdote or opinion for the author.

## Stage 4: independent review

The reviewer did not write the pages. It works through, for the theory and the practical:

1. **Statistics:** model statements at both levels; scales of the random effects and of the
   variance components; the marginal likelihood and what `random` integrates; Laplace accuracy
   claims; predicted effects not called estimates; REML statements (what it integrates, that it
   is approximate for non-linear models, that models with different fixed effects are compared
   with ML fits); AIC with $K$ counting variance parameters; the no-pooling paragraph; leave-one-
   group-out without leakage (every parameter refitted without the held-out group, fixed starts,
   the held-out group scored by its marginal likelihood); simulation at two levels; failed fits
   counted in Exercise 5; no Normal-only result taught as general (the shrinkage weight is
   labelled as the Normal linear case).
2. **Numbers:** run every chunk of the three pages in a clean session (render in the dev profile)
   and compare every number quoted in prose with the output; recalculate the numbers of hidden
   chunks in a separate session.
3. **Voice and style:** the checklist of `STYLE_GUIDE.md` on every section; the "Rules that
   matter most" above; British English; units (µL/L, µmol/m²/s, feet); $\log()$ with
   parentheses; "likelihood profile"; "hypothetical samples"; no "population" for the
   distribution of group effects.
4. **Code:** the R rules of `STYLE_GUIDE.md`; the density of the random effects before their
   use; names consistent between theory and practical; one step, one chunk; no `%~%`, no `<-`,
   no pipes, no `reltol`, no `obj$he()`.
5. **Scope:** nothing that belongs to Chapter 8 (optimiser comparisons, starting-value searches)
   beyond a pointer; no hypothesis tests (DHARMa's printed tests get the one sentence of Chapter
   6); no Bayesian inference; size within the target.
6. **Alignment:** exercises and solutions identical in question text, numbering and data;
   learning goals and roadmap match the sections.

The reviewer fixes what it finds (routine fixes directly; anything that changes the scientific
meaning goes to "Open questions for the author" with the conservative choice applied) and writes a
short report in the progress log: what was checked, what was changed, what remains.

## Stage 7: integration

1. **Links and promises.** Search the repository (`grep` for `Chapter_7`, `Chapter 7`) and fix
   every link and promise to what the new chapter contains; link to the new section IDs where a
   promise is specific. Known places:
   - `Chapter_1/Theory.qmd`, "The modelling cycle" (lines about groups and marginal likelihood)
     and the roadmap entry "Chapter 7: Grouped ecological response curves": "Chapter 7 applies
     Chapter 6's response curve and observation model" is no longer accurate (another curve,
     a Normal model); the R skills could name REML and leave-one-group-out cross-validation.
     This page is the author's approved text: change only the sentences that are wrong, and list
     them in the report.
   - `Chapter_2/Theory.qmd` (around lines 905, 1219, 1280, 1321) and `Chapter_3/Theory.qmd`
     (around lines 119 and 1813): check that each pointer describes what Chapter 7 contains
     (spatial dependence among neighbouring quadrats is **not** covered by Chapter 7: where a
     page promises it, rephrase to "models for grouped observations" or leave the promise
     general, and list it).
   - `Chapter_4/Theory.qmd`: the footnote on the bar (around line 88; link to
     `#sec-conditional`), the owl visits (around line 767; the practical's Exercise 3), the REML
     footnote (around line 2326; link to `#sec-reml`). `Chapter_4/Practicals/no_solution.qmd`
     and `solution.qmd` (around lines 352, 477, 498 and 43): the reed frog tanks (Exercise 2 of
     the new practical), the lily quadrats (a grid; Chapter 7 does not model spatial
     dependence).
   - `Chapter_4/Lecture_2/lecture-script.md` (around line 526: the note "Chapter 7 does not cover
     REML yet") and `Chapter_4/lecture-handoff.md` (around line 712): update the note.
   - `Chapter_6/Theory.qmd` (around lines 35, 450, 1524), its practical (around lines 492 and
     821), its lecture (slide with "random effects (Chapter 7)") and script: check; and
     `AGENTS.md`, Chapter 6, "whether it could be the tadpoles is left to Chapter 7": now
     answered (record what Chapter 7 says).
   - `Supplements/canned.qmd` (around lines 19, 80, 100): random effects, marginal likelihood
     and the Laplace approximation of Chapter 7; check the wording.
   - `Supplements/deterministic-functions.qmd`: the saturating exponential entry ("Chapters 6
     and 7 write it as $r+a(1-e^{-kx})$ for the response of photosynthesis to light" and "the
     practical of Chapter 7 writes it as $A-(A-R_0)e^{-kt}$"): neither is true any more;
     Chapter 7 uses the form shifted along $x$, $a(1-e^{-b(x-c)})$, for CO₂ uptake and for the
     growth of the pines. If the entry has no line for that form, add it to the "Also written"
     line and the paragraph on shifted forms, consistent with Chapter 5's "Shifting and
     scaling".
   - `Supplements/distributions.qmd`, Beta-Binomial entry: if it does not say that the
     Beta-Binomial is a Binomial whose probability follows a Beta distribution, add nothing
     unless the Chapter 7 paragraph links to a sentence that is missing.
   - `Supplements/glossary.qmd`: add entries in its format for the new terms (conditional
     distribution, fixed effect, random effect, mixed-effects model, variance component,
     partial pooling, shrinkage, marginal likelihood, Laplace approximation, REML) if they are
     missing; check existing entries.
   - `Chapter_8/Theory.qmd` (around line 464) and the Chapter 1 lecture script (lines 191, 196,
     247, 293, 480): check.
2. **Guidance.** `AGENTS.md`: review status (5 November or the date of Stage 7), the status rows
   for the Chapter 7 pages and lecture ("Chapters 7 and 8" becomes "Chapter 8"), a "### Chapter
   7" entry under "Decisions by page" with the durable decisions of this file (CO₂ example and
   units, curve and random asymptote on the log scale, contrasts with the encoding callout,
   conditional distributions, Laplace figure and box, REML section, the four topics after the
   fit, AIC and leave-one-group-out only with the reason, no pooling excluded with the reason,
   the practical's five exercises, one lecture with its demo), the conditional-distribution and
   REML promises now kept ("Chapter 4 points to Chapter 7 for REML" goes), "Where topics live"
   (conditional distributions, random effects, Laplace, REML, leave-one-group-out
   cross-validation in Chapter 7), "Builds and packages" (production renders Chapters 1 to 7;
   check `.github/workflows/publish.yml` for every package that the new pages load), the
   lectures paragraph, numbered Practice callouts through Chapter 7, and the `shapes*.csv` files
   (no page uses them; the author decides). `STYLE_GUIDE.md`: Practice callouts and front matter
   through Chapter 7; "Chapter 7 still lacks one" (summary) goes; a bullet under "Maximum
   likelihood with RTMB" on random effects (the joint NLL, the density of the random effects
   before their use, `random`, `map` for scoring a held-out group, REML through `random`,
   predicted effects from `summary(sdreport(...), "random")`); any convention that the stages
   established. `STYLE_GUIDE_LECTURE.md`: the Chapter 7 lecture and its demo where the guide
   lists lectures and demos. Write decisions once, as decisions, not history.
3. **Production build.** `_quarto-prod.yml`: add `Chapter_7/Theory.qmd`,
   `Chapter_7/Practicals/no_solution.qmd`, `Chapter_7/Practicals/solution.qmd` and
   `Chapter_7/Lecture/lecture.qmd` to the render list and to the sidebar sections, in the order
   that the Chapter 6 entries use. Check `_quarto-dev.yml` for missing Chapter 7 entries.
4. **Renders.** `quarto render --profile prod` (the whole production site; about 4 minutes for
   Chapter 6's Stage 7); otherwise render each Chapter 7 page and every page edited in step 1
   with the production profile. Report exactly what ran and any warning.
5. **Final report to the author** (in the session and as the last progress-log line): files
   changed per stage, checks that ran, numbers that differ from this file, open questions,
   sentences changed in approved pages (Chapters 1 to 3), stale mentions left for the author,
   and what awaits review. Leave this file in place; the author removes it.

## Open questions for the author

Stages add questions here; they do not wait for an answer.

## Progress log

Each stage adds one line: date, stage, what is done, what is next.

- 4 November 2026: Stage 0 done (author's decisions in four rounds of questions; branch
  `Chapter_7` fast-forwarded to `9f6e313`, the end of the Chapter 6 rewrite; feasibility of
  every theory and practical model checked in R 4.6.1, see the tables above and the numbers
  under "The practical"; one line added to `AGENTS.md`). Next: Stage 1.
- 4 November 2026: Stage 1 done. `Chapter_7/Theory.qmd` replaced by part A (front matter
  `title:` only, hidden `ggplot2` chunk, Introduction, Learning goals, roadmap table, and the
  sections `#sec-grouped-observations`, `#sec-conditional`, `#sec-pooling`,
  `#sec-marginal-likelihood` with "The marginal likelihood", "The Laplace approximation",
  "Random effects in RTMB" `#sec-random-effects-rtmb` and "Variance components and predicted
  plant effects", and `#sec-group-predictors` with "Shrinkage" `#sec-shrinkage`). The old page
  is gone; an HTML comment at the end marks where Stage 2 writes part B. Rendered with
  `--profile dev` (R 4.6.1, RTMB 2.0, RTMBdist 1.1.0, TMB 1.9.25): exit 0, no warnings, no
  unresolved cross-references; every printed number compared with the prose; the three
  figures inspected. **Size:** part A is 1,098 lines, so part B has about 800 lines within
  the 1,900 target (Chapter 6's part B was about 1,000): keep it compact, or accept a page of
  about 2,000 lines and say so. **Units:** `attr(CO2, "units")` gives µL/L and µmol/m²/s; a
  footnote says that the help page's mL/L is wrong. Citations checked: Potvin et al. (1990)
  from `?CO2`; Kristensen et al. (2016, TMB) from `citation("TMB")`, in the technical box.
  **Names for Stage 2:** `co2` (data frame), `plant_names` (Qn1, Qn2, Qn3, Qc1, Qc2, Qc3,
  Mn1, Mn2, Mn3, Mc1, Mc2, Mc3: plant 11 is Mc2), `plant` (index 1 to 12 by first
  appearance), `co2_data` (list: `conc`, `uptake`, `plant`, and, added in
  `#sec-group-predictors`, the per-plant indicators `mississippi` and `chilled`, length 12;
  a leave-one-plant-out subset must drop the plant from these too and renumber `plant`),
  `first_row`, `cmb`; parameters `log_asym`, `log_rate`, `c0`, `log_sd_plant`, `log_sd_obs`,
  `u`, and `beta_miss`, `beta_chill`, `beta_int` (symbols $a$, $b$, $c$,
  $\sigma_{\mathrm{plant}}$, $\sigma_{\mathrm{obs}}$, $u_j$, $\beta_{\mathrm{miss}}$,
  $\beta_{\mathrm{chill}}$, $\beta_{\mathrm{int}}$, indicators $M_j$ and $C_j$; $\beta$
  because $b$ is the rate); `pooled_nll/obj/fit` (complete pooling), `separate_nll/obj/fit`
  and `separate_asym` (no pooling; named vector), `mixed_nll/obj/fit/sd` and `mixed_effects`
  (random asymptote, no predictors; list order `log_asym, log_rate, c0, log_sd_plant,
  log_sd_obs, u`), `treatment_nll/obj/fit/sd` (random asymptote with origin × chilling; list
  order `log_asym, beta_miss, beta_chill, beta_int, log_rate, c0, log_sd_plant, log_sd_obs,
  u`; the NLL has `ADREPORT(log_chill_factor)`, the vector `c(beta_chill, beta_chill +
  beta_int)`, and no `OBS()` yet: Stage 2 adds `uptake = OBS(uptake)` and refits, as Chapter
  6 did), `critical_value`, `chill_summary`, `chill_factor` (rows Quebec, Mississippi).
  Hidden: `laplace_*`, `mc2`, `log_integrand`, `u_peak`, `step`, `curvature`, `area_exact`,
  `area_laplace`, `laplace_ratio`, `u_grid`, `laplace_curves`, `co2_plot`, `treatment_par`,
  `typical_treatment`, `typical_mixed`, `shrink_data`. Practice callouts `imp-seedlings-quadrat`
  (Practice 1, a two-level discrete model: marginal dependence, conditional independence) and
  `imp-chick-wings` (Practice 2, shrinkage weights, formula stated in the callout); Stage 2
  adds Practice 3 (new groups or a variance component). **Decisions for Stage 2:** the chilling
  factors have Wald intervals from the log scale in part A; Stage 2 gives the likelihood
  profile intervals of `beta_int` and `log_sd_plant` and should link the sentence "We return
  to the uncertainty of these effects, with likelihood profile intervals, later in the
  chapter" (end of `#sec-group-predictors`) to `@sec-grouped-uncertainty`. The second bullet
  of "Random effects in RTMB" says that the density of `u` comes first "(we need this order
  to simulate from the model)"; Stage 2 explains why in `#sec-grouped-residuals`. "Median,
  not mean" (link to Chapter 4's Jensen box) is already said for $\hat a$ in "Variance
  components"; Stage 2 need only recall it. **Numbers** (all agree with the table above):
  complete pooling NLL 296.256, $\sigma_{\mathrm{obs}}$ 8.23; no pooling NLL 171.438,
  $\sigma_{\mathrm{obs}}$ 1.86, asymptotes 14.2 (Mc2) to 45.0 (Qn3); random asymptote NLL
  207.605, $\hat a$ 30.94, $\hat b$ 0.009587, $\hat c$ 48.40, $\sigma_{\mathrm{plant}}$ 0.335,
  $\sigma_{\mathrm{obs}}$ 2.01, predicted effects of Mc1, Mc2, Mc3 −0.370, −0.755, −0.422;
  with origin × chilling NLL 192.086, $\sigma_{\mathrm{plant}}$ 0.0790 (variance −94%),
  $\sigma_{\mathrm{obs}}$ 2.04, chilling factors 0.905 (Wald from the log scale 0.793 to
  1.032) and 0.594 (0.516 to 0.685); shrinkage of Mc2 14.18 → 14.54 (largest change without
  predictors) and 14.18 → 15.57 towards 18.46 (about a third of the way); Laplace for Mc2:
  area 0.3% smaller than the exact integral, log-likelihood changed by 0.003. The one-mean-
  per-group encoding was checked to give the same NLL (192.086). No new open question.
  `AGENTS.md` unchanged (Stage 7 records the decisions). Next: Stage 2.
- 4 November 2026: Stage 2 done. Part B written in `Chapter_7/Theory.qmd` in place of the
  HTML comment: `#sec-grouped-uncertainty` ("Standard errors and likelihood profile
  intervals"; "Restricted maximum likelihood" `#sec-reml` with the box "Statistical detail:
  what REML integrates", the i.i.d. Normal case giving $S/(n-1)$), `#sec-new-groups` (with
  `fig-new_plants`, chilled Mississippi plants, and Practice 3 `imp-stand-growth`, range of
  new stands and the LogNormal mean by simulation, seed 702), `#sec-grouped-residuals`
  (`fig-residuals_grouped`, DHARMa's own plot; warning callout "Residuals of observations
  and of groups"), `#sec-grouped-comparison`, "A recipe for a grouped response curve" (nine
  steps), "Summary" and a quiz of 10 questions. Part A's sentence on profile intervals now
  links to `@sec-grouped-uncertainty`. Rendered with `--profile dev` (R 4.6.1, RTMB 2.0,
  DHARMa 0.5.0): exit 0, no warnings, no unresolved cross-references; whole page in about
  30 s; every printed number of part B compared with the prose; both new figures inspected.
  Citation checked: Patterson and Thompson (1971), *Biometrika* 58(3): 545–554 (footnote in
  `#sec-reml`). **Size:** the page has 2,063 lines, above the 1,900 target (part B about
  960 lines, of which the comparison code about 200 and the quiz about 190); Stage 4 may
  shorten the quiz or the comparison prose if it wants the target. **Choices:** REML puts
  every parameter of the curve in `random` (`u`, `log_asym`, the three `beta_`,
  `log_rate`, `c0`), only the two log standard deviations are optimised (as in the
  practical's Exercise 5, `random = c("u", "mu")`); with only the four effects on the
  asymptote in `random`, $\sigma_{\mathrm{plant}}$ would be 0.106 and
  $\sigma_{\mathrm{obs}}$ 2.02 (not in the page). The comparison uses separate NLLs
  (`pooled_treatment_nll`, `additive_nll`), not `map`, for the nested models; `map` is used
  only to score a held-out plant. `treatment_nll` gains `uptake = OBS(uptake)` in
  `#sec-grouped-residuals` and is refitted there, so `treatment_obj` and `treatment_fit` are
  the `OBS()` versions from then on. Residuals per plant use
  `recalculateResiduals(group = co2_data$plant)` (integer index; a character group would be
  sorted alphabetically). The `fittedPredictedResponse` is the typical curve ($u_j=0$) of
  each measurement's origin and treatment. **Names for Stage 3 and later:**
  `treatment_profile_sd`, `treatment_profile_int`, `sd_interval`, `int_interval`,
  `treatment_intervals`, `reml_obj`, `reml_fit`, `treatment_par`, `sd_plant`,
  `mississippi_group`, `chilled_group`, `log_typical`, `new_plant_asym` (rows Quebec
  non-chilled, Quebec chilled, Mississippi non-chilled, Mississippi chilled), `n_sim`,
  `treatment_simulations` (seed 701), `typical_asym`, `plant_group`, `treatment_expected`,
  `treatment_residuals`, `plant_residuals`, `plant_scaled`, `pooled_treatment_nll`,
  `additive_nll`, `curve_start`, `sd_start`, `effect_start`, `models` (`pooled`,
  `pooled_treatment`, `mixed`, `additive`, `treatment`, each with `nll`, `random`,
  `start`), `fit_model(model, data)`, `subset_plants(data, plants)`,
  `plant_loglik(model, estimates, data)`, `n_plants`, `comparison`, `n_failed`. Hidden:
  `treatment_fixed`, `conc_grid`, `curve_shape`, `mc_rows`, `mc_points`, `mc_asym`,
  `mc_curves`, `mc_range`. **Numbers:** profile intervals $\sigma_{\mathrm{plant}}$ 0.045 to
  0.139 (variance 0.0020 to 0.019; Wald from the log scale 0.046 to 0.136), `beta_int`
  −0.638 to −0.209 ($e^{\beta_{\mathrm{int}}}$ 0.528 to 0.812; Wald −0.614 to −0.227);
  REML $\sigma_{\mathrm{plant}}$ 0.105, $\sigma_{\mathrm{obs}}$ 2.05; typical asymptotes and
  95% ranges of new plants 42.2 (36.1 to 49.2), 38.2 (32.7 to 44.5), 31.1 (26.6 to 36.3),
  18.5 (15.8 to 21.5) µmol/m²/s; mean over median $e^{\sigma^2/2}$ 1.003; dispersion 0.80
  (seed 701); plant residuals Mc2 0.010, Mc1 0.956, the rest 0.195 to 0.887; the upper
  quartile line of the observation residuals lies above 0.75 (DHARMa flags it), traced to
  Mc1 and Mc3, whose residuals are mostly high. Comparison: all five fits and all 60
  leave-one-plant-out fits converged; AIC 600.51, 419.32, 425.21, 408.81, 400.17 (as in the
  table above); leave-one-plant-out −310.74, −235.96, −216.80, −214.10, −213.77, which
  differ from the table above by at most 0.03 in the last three (−235.93, −214.11,
  −213.75; the page's values are the ones calculated by its code). No pooling AIC 372.87.
  AIC and leave-one-plant-out agree on the best model, disagree on the order of complete
  pooling with predictors and the random asymptote without predictors, and on the strength
  of the interaction (8.6 units of AIC, 0.33 of log score); the text says all three.
  No new open question. `AGENTS.md` unchanged (Stage 7 records the decisions). Next:
  Stage 3.
