# Instructions for course collaborators

## Working role

You are collaborating with the course author on an online textbook for Ecological
Modelling and Data Analysis in R (Quarto). Help students connect ecological questions to
probability models, fit models to data by maximum likelihood, and interpret estimates and
uncertainty. Write as a patient teacher of ecology, statistics and R, and explain the
reasoning behind an analysis so that students can apply it themselves.

These instructions rank below the assistant's higher-priority instructions and the user's
current request. The author decides course scope and approves the teaching material;
generated text is a draft until reviewed. Follow explicit author instructions over
inferred conventions, and do not copy a mistake because it appears in an established
chapter (the references contain typos, inconsistent formatting and stale cross-references).

This file holds progress, review status, author decisions on content and scope, and the
workflow. `STYLE_GUIDE.md` holds prose, notation, Quarto and R conventions. Both are
loaded in every session, so a rule is written in one of them only.

Roles, applied as needed within a task:

- **Teaching collaborator:** connect the question, equations, code and interpretation,
  with the student's prerequisites in view.
- **Statistical reviewer:** check assumptions, support, parameterisation, likelihood
  definitions and interpretations of uncertainty; separate exploratory evidence from
  conclusions that the model justifies.
- **R and Quarto editor:** readable, reproducible examples; preserve execution settings,
  includes, links and solution visibility.
- **Copy editor:** the author's voice (priority section of `STYLE_GUIDE.md`); correct
  local problems without expanding the requested scope.

## Read before working

- `Chapter_1/Theory.qmd` before any course-content change: it is the overview of the
  course, and it identifies the relevant theory, practical and prerequisite files.
- The target page, its practical or theory counterpart and the relevant earlier
  explanations. Check prerequisites and existing object names before adding code.
- `_quarto.yml` before changing navigation or document layout.

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

| Material | Status and use |
|---|---|
| Chapter 1 practical (`material.qmd` and wrappers) | Approved. Primary reference for teaching voice, introductory R and conditional solutions |
| `Chapter_1/Theory.qmd` | Approved, author's text. Reference for voice in its essay register only (see `STYLE_GUIDE.md`). Generated on the author's instruction and awaiting check: the two course objectives in "Overview of the book" and the roadmap entry "Supplement: Formula-based methods" |
| `Chapter_2/Theory.qmd` | Approved, then partly rewritten. **Primary reference for voice in technical chapters** (author's sections not rewritten): "Discrete probability distributions", the discrete parts of "Joint distributions" and "Expectations and central moments", "Choosing a distribution", and the parts of "Overdispersion" that were not rewritten. Drafts: see Chapter 2 below |
| Chapter 2 practical | Approved. Exercises 1 (seedlings), 3 (`InsectSprays`) and 4 (Negative Binomial) are the author's work and the primary reference for exercises, worked reasoning and interpretation. Exercises 5 and 6 generated, then approved. Worked Exercise 2 is a draft |
| `Chapter_3/Theory.qmd` | Approved, then rewritten: a draft. The opening `# Samples and distributions` was the author's text and is no longer a reference for voice |
| Chapter 3 practical | Approved |
| `Supplements/distributions.qmd` | Binomial, Poisson and Negative Binomial text is the author's (only code and function names changed); other entries, the three mussel examples and the RTMB changes are drafts |
| Chapter 4 (theory and practical) | Draft: rewritten from scratch, trimmed by the author, then rewritten to the RTMB pattern. The author's own edits and sentences stay |
| Chapter 5 (theory and practical), `Supplements/deterministic-functions.qmd`, `Supplements/calculus.qmd` | Drafts, rewritten from scratch |
| `Supplements/canned.qmd` | Draft, rewritten on 7 October. The paragraph of `index.qmd` that describes it is generated text in the author's first person and awaits check |
| Chapters 6 to 8 | Generated, not rewritten. Topic coverage only, never a model of voice |

## Decisions by page

Data decisions that apply across pages: real data are the running examples for continuous
data (Gentoo penguin flipper length and body mass, Chapters 2 and 3), overdispersion
(`Salamanders`, Chapter 2), the Poisson model (`boot::fir`, balsam fir seedlings in 50
quadrats, mean 2.14, Chapters 3 and 4) and the Negative Binomial model (`Owls`, Chapters
3 and 4). The hypothetical Normal model of tree heights (22 m, 4 m) is not used anywhere;
the hypothetical Binomial seed-survival example stays in Chapter 2. A practical may use
another species of the data set of its theory (Chinstrap in Chapter 2, Adelie in Chapter
4). `penguins` of `datasets` needs R 4.5.0 or later; a footnote at the first use says so.

### Chapter 2

- Scope: the distributions themselves. Everything about samples (relative frequencies,
  empirical distributions, histograms, kernel density estimates, `ecdf()`, convergence
  with sample size) lives in Chapter 3; do not move it back. Overdispersion with the
  dispersion-ratio diagnostic stays, with a pointer to Chapter 3 for the sample variance.
  Joint and marginal distributions and independence are covered for discrete and
  continuous variables; conditional distributions are assigned to Chapter 7, which has
  not received them yet.
- Two running examples: the Binomial (discrete) and the Normal (continuous).
- Drafts of 6 October: the i.i.d. paragraph (identically distributed separated from
  independent); skewness and kurtosis (standardised moments, excess kurtosis);
  "Overdispersion" (the diagnostic uses the `Salamanders` counts of species `GP` at the
  12 unmined sites: 48 counts, mean 2.21, variance 4.98); the sentence on the mean and
  variance of the Binomial; and "Continuous probability distributions", "Joint
  distributions of continuous variables" and the `integrate()` passage, rewritten with
  the Gentoo penguins.
- Gentoo models: Normal flipper length with $\mu=217$ mm and $\sigma=6.5$ mm; bivariate
  Normal with body mass (5100 g, 500 g, correlation 0.7) drawn over the real birds.
  `integrate()` runs from 150 to 280 mm because infinite limits fail for this narrow
  density. The introduction, learning goals, summary and quiz questions 4 to 6 and 8
  follow these examples.
- RTMB and RTMBdist are loaded at the first probability calculation, with one sentence,
  a pointer to Chapter 4 and nothing about TMB (also in Chapter 3).
- Practical: two worked exercises on the student page (seedlings under a Binomial model;
  "Bill length under a Normal model" for the 68 Chinstrap penguins, whose data only
  motivate the rounded parameters 49 mm and 3.3 mm, with question 3 a simulation of 1,000
  values compared with the model density), then four exercises to solve. Question 4 of
  Exercise 3 (Negative Binomial fit from moments) was removed by the author; the solution
  headings of Exercise 4 match its four questions. Students are told to read the relevant
  supplement entries first.

### Chapter 3

- Theory examples: the fir counts under a Poisson model from the opening section to the
  confidence interval; the flipper lengths of the 123 Gentoo penguins in "Samples of
  continuous measurements" and "Estimation of two parameters". Neighbouring quadrats are
  treated as i.i.d. (stated once, pointer to Chapter 7). Every simulation is a plug-in
  simulation with mean 2.14 and 50 quadrats; the figure on asymptotic normality keeps 5
  and 100 quadrats. The orchid practice callouts stay hypothetical.
- Statistical detail boxes: the law of large numbers and the Glivenko–Cantelli theorem,
  the bias of the variance estimator, consistency, the central limit theorem.
- The callout on asymptotic convergence states its conditions (moments converge when
  they exist; a quantile converges where the cumulative probability function of the model
  is not flat). Agreement of the empirical distribution with the model does not show
  independence. The sentence that a sample "does not have a mean or a variance" was
  softened.
- Practical. Exercise 1: `Owls` from `glmmTMB` (`data(Owls, package = "glmmTMB")`),
  satiated nestlings and female parents, Negative Binomial model, method-of-moments
  estimates. Exercise 2 (asymptotic convergence): Beta model for the fraction of leaf
  area eaten (a = 2, b = 6), seeds 123 and 11, 22, 33, 44. Exercise 3: `Height` (ft) of
  `trees` (31 trees, Normal model); method-of-moments estimates, then 2,000 plug-in
  experiments of 31 trees with seed 434 (the term parametric bootstrap is not introduced),
  and the solution reports the standard error of each simulated bias. Exercise 4 (mean
  body mass and coverage, LogNormal model): Wald intervals only; the $t$ interval appears
  only in a footnote of the theory. The solution page restates the tasks of each exercise.

### `Supplements/distributions.qmd`

- Detailed descriptions of distributions live only here; other pages link to the entries
  by `sec-` IDs. Symbols follow the chapters ($k$ for the Negative Binomial, $\mu$ and
  $\sigma$ for the LogNormal, $a$ and $b$ for the Beta and Beta-Binomial).
- $k$ of the Negative Binomial is the "shape" everywhere; its summary block uses R's $k$
  and $p$, with the mean parameterisation on the "Inverse" line, and the code uses
  `dnbinom2()`. The Beta-Binomial is overdispersed relative to the Binomial, with the
  probability varying among sampling units and shared by the trials within a unit. The
  Student's t entry has that name (ID unchanged) and uses `stats::pt()`.
- Examples: the Normal and Student's t entries use the shell length of mussels in a bed
  (hypothetical, $\mu=60$ mm, $\sigma=5$ mm); the Multivariate Normal adds shell width
  (30 mm, 3 mm, correlation 0.6).
- RTMB: every entry names the RTMB or RTMBdist density or mass function first; the
  functions that fill in are announced once in the introduction and named in an entry
  only when they come from another package or are calculated from the mass. The page
  loads `RTMB`, `RTMBdist` and `MASS`. The Conway–Maxwell–Poisson entry uses
  `dcompois2()` (mean and $\nu$; a clutch with a mean of 2.5 eggs; cumulative probability
  as a sum of the mass; `sample()` on the mass simulates). The Uniform entry says that
  RTMB has no Uniform density for fitting.
- Zero inflation: no data set; the formula separately for discrete and continuous
  distributions; a note callout on using a hand-written density in an NLL (links to the
  RTMBdist article "Adding a distribution"). That `my_dzinbinom()` works in `MakeADFun()`
  was checked in R; the rest of the callout follows the article.

### Chapter 4

- **Structure:** two parts presented in the introduction and in the roadmap table,
  without "Part" headings. Part 1: likelihood, estimation, several parameters. Part 2:
  uncertainty (standard errors, Wald and profile intervals, joint regions, coverage),
  properties of estimators (each told from a simulation first), AIC. A "recipe for a fit"
  callout closes the chapter before the summary. No `<!-- AUTHOR: ... -->` comments
  remain; do not add first-person opinion on the author's behalf. The author's passage on
  `cmb()`, `MakeADFun()` and `optim()` is not to be touched.
- **Examples:** the 50 fir counts (estimation uses all 50; the likelihood curve and the
  three intervals use the first ten quadrats, where the asymmetry is visible, and are
  repeated for the 50) and the owl data. The Normal model appears only in footnotes and
  in the callout on the interactive likelihood page.
- **Estimation:** `optim()` is the only method (the closed-form Poisson estimator is
  stated, its derivation is in a box). The method of moments appears only as a source of
  starting values and in "Efficiency". The code of the $k$, $p$ parameterisation and of
  the slice and profile curves of the owl model is hidden and kept in the source. The
  first derivative points to `Supplements/calculus.qmd`. One warning callout covers the
  clash between `RTMBdist::dnbinom2(x, mu, size)` and `RTMB::dnbinom2(x, mu, var)`.
- **Failed fits:** a note callout at the end of "Constraints and transformations": check
  `convergence`; `fn` returns `NaN` without a warning where the NLL cannot be calculated
  and BFGS treats this as a failed step (harmless when the fit converges, an error when
  the starting values give `NaN`); what to try; Chapter 8 explains the rest.
- **Standard errors and Wald intervals** (6.1; draft): "Fisher information" (observed
  information, Wald interval on the original scale), "The Hessian matrix"
  (`optim(hessian = TRUE)`, `solve()`, `diag()`, `sqrt()`; Poisson fit, then the owl
  model by hand), "Constrained and unconstrained parameters" (standard errors of
  $\hat\lambda$ and $\log(\hat\lambda)$ compared on the Poisson example) and "Automation
  with TMB" (`sdreport()`, `ADREPORT()`, the interval table of the owl model). The
  by-hand owl fit comes before the NLL with `ADREPORT(k)`, which is fitted again.
- **Profile intervals** (6.3; draft): "One parameter" (`uniroot()`), "Two parameters"
  (profile of $k$ on a grid of inner fits), "Automation with TMB" (`tmbprofile()` with
  `confint()`). The text says that in practice students use the TMB functions.
- **Owl $k$:** three intervals are shown: Wald on the original scale (from `ADREPORT()`),
  Wald on the log scale with the endpoints transformed back (recommended) and profile
  (reference).
- **Back-transformation:** endpoints can be transformed because the logarithm is
  increasing, so coverage is kept. A standard error cannot, because it is built from
  expectations, which do not pass through non-linear functions (Jensen's inequality).
  The difference in units is not the reason (author's correction).
- **Simulation:** data are marked with `OBS()`, `obj$simulate()` draws each hypothetical
  experiment and a visible loop refits. Coverage simulations use one extra fit at the
  generating value, not `tmbprofile()` in every experiment. `checkConsistency()` appears
  once, with `estimate = TRUE` and the bias calculated from the refitted estimates; its
  p-value is not interpreted (awaits the author's confirmation).
- **The gap in $k$:** the recipe callout explains the gap between the method-of-moments
  and maximum likelihood estimates of $k$ (the model is an approximation and no pair of
  values reproduces the mean, the variance and the fraction of zeros; in none of 2,000
  simulated experiments does the gap reach the observed 0.27). "Efficiency" keeps the
  general comparison of precision and does not claim to explain it.
- **Statistical detail boxes:** the derivation of the Poisson estimator, Wilks' theorem,
  the cutoff for a joint region, consistency, the Cramér–Rao bound, the Kullback–Leibler
  divergence.
- **Model comparison:** AIC (`#sec-aic`) with AICc, presented as an approximation for the
  non-linear, non-Normal models of the course that is nevertheless common in the
  literature. The practical reports AICc next to AIC wherever it compares models.
- **Practice callouts:** four remain ("crab burrows", back to the ecological scale, an
  interval from the log scale, waiting for a pollinator).
- **Length:** the chapter should not grow. It has 3,146 source lines against 2,857 before
  the RTMB rewrite, so this is not met.
- **Practical:** reed frog tadpole survival (`emdbook::ReedfrogPred`), glacier lily
  seedlings (`emdbook::Lily_sum`), black cherry volume (`trees`), Adelie body mass
  (`penguins`). Exercise 1 is worked on the student page and shows both routes (by hand,
  then `sdreport()` and `tmbprofile()`); its question 6 compares one probability of
  survival for all 48 tanks with one per predator treatment (AIC, AICc, and the
  difference with its standard error from `ADREPORT()` and a Wald interval; awaits
  confirmation). Exercise 2: one profile by hand (inner fits fixed with `map`) checked
  with `tmbprofile()`. Exercise 3: students write `my_dzipois()` by hand and verify it
  against `dzipois()`. Exercises 3 to 5 use only the TMB tools. Exercises 1 to 4 are the
  core; Exercise 5 is extra practice with a skeleton of `simulate_gamma_experiments()`
  (three gaps). The Gamma fits start at shape 1 and rate $1/\bar x$, because from the
  method-of-moments estimates they stop one step from the maximum without `reltol`; the
  solution says why (awaits confirmation).

### Chapter 5 and its supplements

- **Scope:** no statistics; deterministic functions and their mathematical properties,
  in preparation for Chapter 6. The introduction says why it comes now. Real data are a
  backdrop and nothing is fitted. Starting values read from a plot, composition to
  enforce a range, nested functions and partial derivatives with respect to parameters
  belong here, with phenomenological and mechanistic functions (the disc equation is
  derived), functions of two inputs and choosing a function.
- **Two functions analysed in full:** Michaelis–Menten and Ricker. The exponential decay
  and the logistic function are only named (the half-life is one sentence that points to
  the exponential entry; the inverse logit and the exponential of a line stay in the
  composition section, which Chapter 6 links to); their derivations and the three forms
  of the logistic live in the supplement. The sections on transformations of the axes and
  on local approximation were removed with the questions that depended on them. Do not
  add any of this back.
- Two `<!-- AUTHOR: ... -->` comments (phenomenological against mechanistic; choosing
  between candidates) mark places for the author's view; do not fill them.
- Units are a thread of the worked examples and exercises. A mechanistic derivation
  tells what the parameters would measure if its assumptions held, and a good fit does
  not show that they hold. An asymptote is a line that the curve approaches (a curve may
  cross it).
- **Data:** theory `emdbook::ReedfrogFuncresp` and `emdbook::ReedfrogSizepred`; practical
  `Puromycin`, `emdbook::FirDBHFec_sum` (`DBH` in cm), `emdbook::MyxoTiter_sum` (values
  read from a published figure) and `emdbook::DamselRecruitment_sum`.
- **Practical:** Exercise 1 worked on the student page; Exercises 2 to 5 drills on paper
  (limits and end behaviour, derivatives and slopes, special points, parameters);
  Exercises 6 (two questions) and 7 cases with real data, on paper and then in R. In
  Exercise 7 the power law is chosen from the shape of the cloud on ordinary axes, with
  the exponent calculated from two points. Students are told to read the calculus
  supplement first if they need it.
- **`Supplements/calculus.qmd`** teaches the rules of calculus (worked cases, practice
  set; `sec-calc-` IDs); the theory only recalls and uses them.
- **`Supplements/deterministic-functions.qmd`:** detailed descriptions of functions live
  only here (`sec-fn-` IDs). The author removed the examples, figures and `Practice`
  callouts on 7 October. Every usage paragraph was checked against Chapter 3 of Bolker
  (`.plans/chap3A.pdf`) or the publications; the entries changed then are drafts
  (quadratic, bell-shaped, Michaelis–Menten, Hassell, hockey stick; citations added to
  Holling type III, exponential, Shepherd). The page closes with an entry on functions
  without a closed form (the Rogers random-predator equation; the theta-logistic model is
  solved by the Richards function). A hidden chunk still loads `ggplot2` although no
  figure uses it.

### `Supplements/canned.qmd`

A bridge from the TMB methods of the course to `glmmTMB`: linear and generalised linear
models and their mixed-effects versions only (no Bayesian methods, non-linear models or
survey of packages). It connects formulae to observation models and to the familiar
calculations (marginal likelihood, profile intervals, delta-method prediction errors,
information criteria, simulation). Checked against `glmmTMB` 1.1.15: all chunks run and
the page renders with the dev profile. For a Normal model `dispformula` describes the
logarithm of the residual standard deviation. The page uses `InsectSprays` and
`Salamanders` directly and `relevel()` once (penguins); the `DHARMa` chunk is not
evaluated. Filename and navigation are kept; it is in `_quarto-prod.yml` after the
glossary.

### Chapters 6 to 8

- They predate the rewrite of Chapters 4 and 5 and received consistency fixes only; the
  full rewrite is a separate plan. Where their terms differ from Chapter 4, follow
  Chapter 4 in new work.
- Chapter 6 has two stopgap sections that earlier pages link to: `#sec-makeadfun` (what
  RTMB calculates for `optim()`, with a collapsed technical detail box on automatic
  differentiation; the main text does not use the word tape) and `#sec-delta-method`.
  Its first fit goes through `MakeADFun()` like every other fit, with no comparison with
  a plain function. "Information criteria" recalls AIC from Chapter 4 with $K$ and adds
  BIC, cross-validation and goodness of fit, not AICc.
- Not converted: the practicals of Chapters 6 and 7 and the Chapter 7 theory still use
  `%~%`, one parameter list, data read from the workspace and `obj$he()`; Chapter 8
  passes plain functions to `optim()` with `hessian = TRUE`; the learning goals of
  Chapters 6 and 7 keep the old format.
- Chapter 4 points to Chapter 7 for REML, which Chapter 7 does not cover yet.

### Other

- The Chapter 1 practical has a step that installs the course packages, and it teaches
  contour plots with `outer()` and `contour()` in base R, so later chapters use them
  without introduction.
- Figures that the author decided to keep outside the plotting rules: the `theme_bw()`
  figure of the Chapter 3 theory and the two starting-value figures of the Chapter 5
  theory (base R, `plot()` with `curve()`).
- The glossary was updated for RTMB.

## Teaching scope and progression

- **Objectives** (stated by the author): (1) teach likelihood-based inference in theory
  and in implementation, so that students understand tools like `glmmTMB` better; (2)
  teach how to build non-linear (mixed) models and apply to them the type of analysis
  that one would use with `glmmTMB`.
- **Progression:** R foundations (1), probability distributions (2), samples, estimation
  and sampling distributions (3), maximum likelihood (4), deterministic functions (5),
  fitted response curves (6), grouped response curves (7), numerical optimisation (8).
  Verify details against `Chapter_1/Theory.qmd` and the files before referring students
  to them.
- Keep maximum likelihood and ecological interpretation at the centre, and build
  understanding of explicit probability and likelihood functions before relying on
  formula-based interfaces. When motivating models, explain how interpretable response
  parameters, model comparison and explicit observation models answer questions beyond a
  zero-effect test; acknowledge that standard regression and mixed models remain useful.
- Do not replace the likelihood focus with hypothesis testing, p-values, Bayesian
  inference or a survey of packages unless the author asks. The method of moments stays
  as a bridge to estimation.
- No dynamical models. When motivating probability, emphasise observation error,
  parameter uncertainty and process variation; mention initial-condition, driver,
  scenario and numerical uncertainty only as wider forecasting applications.
- The course is about non-linear models with non-Normal distributions: teach results that
  hold in general and present special cases as special cases. Confident statements about
  bias, variance, standard errors and intervals hold asymptotically; for small samples
  present them as approximations and check them by simulation. Do not teach a Normal-only
  result (the $t$ interval, $\operatorname{Var}(\bar X)=\sigma^2/n$) as if it were general.
- Before Chapter 7, grouped or nested observations (visits to the same nest, neighbouring
  quadrats, visits to the same stream site) are treated as i.i.d.; the exercise says that
  this is a simplification and points to Chapter 7.
- Where topics live: method of moments in Chapter 3; AIC and AICc in Chapter 4; BIC,
  cross-validation and the explanation of the delta method in Chapter 6; bounds,
  `optimize()`, scaling, sensitivity to starting values, local maxima, Hessian problems
  and the effect of parameterisation on optimisation in Chapter 8 (Chapter 4 only uses
  transformations and points forward).
- Use simulation to connect known parameters to samples, estimates and repeated-sampling
  behaviour. Introduce an unfamiliar R tool when it is needed.
- Exercises ask students to calculate, simulate, plot, compare and explain; solutions
  explain why the code answers the ecological question. Exercises may use real data sets
  shipped with R packages, loaded with `data(name, package = "pkg")`.
- Support AI use as tutoring that helps students understand and debug their work;
  scientific interpretation stays with the learner and the author.

## Builds and packages

- Settings shared by every build belong in `_quarto.yml`; the complete render and sidebar
  lists belong in the mutually exclusive `_quarto-dev.yml` and `_quarto-prod.yml`, so
  that profile merging cannot duplicate navigation.
- The production build renders Chapters 1 to 5 and five supplements; Chapters 6 to 8 are
  rendered only by the dev profile.
- Every package loaded in a rendered page must be in `.github/workflows/publish.yml`, or
  the production build fails. Production needs `MASS`, `ggplot2`, `patchwork`, `dplyr`,
  `RTMB`, `RTMBdist`, `TMB` (for `tmbprofile()`), `quarto`, `glmmTMB` (`Salamanders`,
  `Owls`, the `glmmTMB` supplement), `boot` (`fir`), `emdbook` (Chapter 4 practical,
  Chapter 5), `knitr` and `rmarkdown`. `DHARMa`, `DEoptim` and `GA` stay for Chapters 6
  to 8. `VGAM`, `gtools` and `COMPoissonReg` were removed because no page loads them.
- Do not install packages during rendering.

## Repository workflow

1. Identify the requested scope and the relevant source files. Preserve unrelated author
   changes, including ongoing moves and deletions.
2. Check the surrounding concepts. Resolve routine editorial choices autonomously; ask
   only when an ambiguity would change the scientific meaning or the course scope.
3. Edit source `.qmd` files, never generated HTML, cache files or vendored extensions.
   Chapter 1 uses a shared `Practicals/material.qmd` with `solution.qmd` and
   `no_solution.qmd` wrappers. From Chapter 2 onward each practical is self-contained in
   those two files; do not introduce `material.qmd` in later chapters.
4. Keep exercises and solutions aligned in numbering, data, notation and learning goals.
   Do not remove the worked exercises on the student pages of Chapters 2, 4 and 5.
5. Check new or changed mathematics and code against the accompanying explanation. For
   computational changes run focused R checks when available. For changes to includes,
   metadata or solution visibility, render the affected wrappers and inspect both
   versions. Documentation-only edits need a source review, not a site build. Respect
   any user limits on execution.
6. Report what changed and which checks actually ran. Identify unverified numerical
   claims and unavailable tooling; never claim a render or execution that was not done.
7. After any course-content or guidance change, review this file and update it when the
   change establishes progress, a durable convention, a file-structure rule or an author
   decision. Report whether it was updated or confirmed unchanged.

Preserve source attribution and existing credits. Do not invent citations, data sets,
numerical results or claims of human review. Check external technical claims against
primary sources when needed, without turning routine editing into research.

## Maintaining these instructions

Record a decision once: content, scope, status and workflow here, concrete style patterns
in `STYLE_GUIDE.md`. Write the decision and what still awaits review, not the history of
how the page got there (git and `.plans/` keep that), and replace an entry when a later
decision supersedes it. Do not treat an isolated exception or an unreviewed generated
passage as a course-wide rule.
