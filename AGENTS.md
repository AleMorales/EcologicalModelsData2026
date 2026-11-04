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

| Material | Status and use |
|---|---|
| Chapter 1 practical (`material.qmd` and wrappers) | Approved. Primary reference for teaching voice, introductory R and conditional solutions |
| `Chapter_1/Theory.qmd` | Approved, author's text. Reference for voice in its essay register only (see `STYLE_GUIDE.md`). Generated on the author's instruction and awaiting check: the two course objectives in "Overview of the book" and the roadmap entry "Supplement: Formula-based methods" |
| `Chapter_1/Lecture/` (`lecture.qmd`, `lecture-script.md`) | Generated draft of a 60-minute lecture on the chapter (19 slides). The author sets the length of each lecture; when a request does not give it, ask (see `STYLE_GUIDE_LECTURE.md`). The author revised the slides on 26 October (they are the reference for format and amount of text); the script awaits review. Slides carry keywords for students new to the course and no speaker notes; the narrative is only in the script (author's decision), so slide numbers, titles and times in the script are changed together with the slides. The README was removed. Never a model of voice |
| `Chapter_2/Lecture/` | Generated draft: 90 minutes of slides (33 slides) plus 40 minutes of live demos from the chapter's code and `Practice` callouts, in three blocks with two breaks of 10 minutes (150 minutes). Slides and script await review. Never a model of voice |
| `Chapter_3/Lecture/` | Generated draft: a session of 150 minutes with 34 slides (125 minutes, 5 of slack) in three blocks with two breaks of 10 minutes. No live demos (author's decision of 30 October, because the slides of the Chapter 2 lecture took longer than planned): the author decides during the lecture whether to run code, and the script lists the chunks that fit, all visible on the chapter and practical pages, with no typed code. Slides and script await review. Never a model of voice |
| `Chapter_4/Lecture_1/`, `Chapter_4/Lecture_2/` | Generated draft slides of two lectures of 150 minutes, one per part of the chapter (32 slides in Lecture 1 and 30 in Lecture 2, which has 12 minutes of slack instead of 5; each includes one live demo of 18 minutes with its standalone R script, checked in R). Scripts (`lecture-script.md` and PDF) were written on 3 November from the slides as they then stood; slides, scripts and demo scripts await review; the demo slide of Lecture 1 follows `demo-profile.R` (four steps, author's decision of 3 November), and both lectures use only copies of chapter figures or figures made from the chapter's data (Lecture 1, slide 27, reuses `slice-profile.png`; Lecture 2, slide 15 is the table of owl intervals). The plan and the author's decisions are in `Chapter_4/lecture-handoff.md`. Never a model of voice |
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
| Chapters 7 and 8 | Generated, not rewritten. Topic coverage only, never a model of voice |

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
- "Consistency and asymptotic normality" presents asymptotic normality as the general
  behaviour of most estimators (author's instruction of 30 October), with the central limit
  theorem as its name for the mean; method-of-moments estimators follow from the theorem
  applied to the moments plus a smooth function (the delta method, whose formula is a box
  in Chapter 4), and Chapter 4
  gives the result for maximum likelihood. The new wording awaits the author's check.
- Practical. Exercise 1: `Owls` from `glmmTMB` (`data(Owls, package = "glmmTMB")`),
  satiated nestlings and female parents, Negative Binomial model, method-of-moments
  estimates. Exercise 2 (asymptotic convergence): Beta model for the fraction of leaf
  area eaten (a = 2, b = 6), seeds 123 and 11, 22, 33, 44. Exercise 3: `Height` (ft) of
  `trees` (31 trees, Normal model); method-of-moments estimates, then 2,000 plug-in
  samples of 31 trees with seed 434 (the term parametric bootstrap is not introduced),
  and the solution reports the standard error of each simulated bias. Exercise 4 (mean
  body mass and coverage, LogNormal model): Wald intervals only; the $t$ interval appears
  only in a footnote of the theory. The solution page restates the tasks of each exercise.

### Lectures

The Chapter 3 lecture has no live demos (author's decision of 30 October); the Chapter 2
lecture has three, each Chapter 4 lecture has one of 18 minutes from a standalone
script, `demo-profile.R` and `demo-properties.R`, and the Chapter 6 lecture has one of 18
minutes from `demo-cycle.R` (author's decisions of 3 November). Slides state the general definition, rule or property
and then the result for the example, never the example alone (author's decision of 30
October), and the main takeaways stand on the slide, not only in the script (author's
decision of 3 November). The rules are in `STYLE_GUIDE_LECTURE.md`.

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

- **Principles over examples** (author's decision of 3 November): the examples serve the
  general statements and must not become case studies. The chapter was simplified that
  day (3,215 to about 2,740 source lines): details of the Poisson and Negative Binomial
  distributions, repeated calculations and numbers that do not support a general point
  were removed. Do not add such detail back, and keep the chapter from growing.
- **Structure:** two parts presented in the introduction and in the roadmap table,
  without "Part" headings. Part 1: likelihood, estimation, several parameters. Part 2:
  uncertainty (standard errors, Wald and profile intervals, joint regions, coverage),
  properties of estimators, AIC. The order stays (author's decision of 3 November:
  students know the properties from Chapter 3). A "recipe for a fit" callout closes the
  chapter before the summary. Do not add first-person opinion on the author's behalf.
- **Examples:** the 50 fir counts (estimation uses all 50; the likelihood curve, the
  standard error and the three intervals use the first ten quadrats, where the asymmetry
  is visible; the result for the 50 is one sentence each, the intervals from a hidden
  chunk) and the owl data. The Normal model appears only in footnotes and in the callout
  on the interactive likelihood page.
- **Estimation:** `optim()` is the only method (the closed-form Poisson estimator is
  stated, its derivation is in a box). The method of moments appears only as the starting
  values of the owl fit and in "Efficiency". The first derivative points to
  `Supplements/calculus.qmd`. One warning callout covers the clash between
  `RTMBdist::dnbinom2(x, mu, size)` and `RTMB::dnbinom2(x, mu, var)`. "The fitted model"
  is one paragraph with the figure of fitted probabilities; the Poisson log-likelihood is
  calculated in the AIC section.
- **Parameterisation, slices and profiles:** one section with one composite figure
  (contours in $k$ and $p$ with the slice and the path of the profile; slice and profile
  curves). The $k$, $p$ fit is hidden code and returns only in one line of "Covariance
  between estimates". Slices and profiles are defined in general symbols
  ($\theta_1$, $\theta_2$).
- **Failed fits:** a note callout at the end of "Constraints and transformations": check
  `convergence`; `fn` returns `NaN` without a warning where the NLL cannot be calculated
  and BFGS treats this as a failed step (harmless when the fit converges, an error when
  the starting values give `NaN`); what to try; Chapter 8 explains the rest.
- **Standard errors and Wald intervals** (draft, condensed on the author's request of 3
  November): the main text states the ideas and uses no calculation by hand. The opening
  gives asymptotic normality, for several parameters a multivariate Normal with a
  covariance matrix (links to Chapter 2 and `distributions.qmd#sec-multivariate_normal`).
  "Curvature and standard errors" (`#sec-curvature`): the log-likelihood near its maximum
  is approximately a parabola (degree two in each parameter); a slower fall (lower
  curvature) gives a larger standard error; for one parameter the standard error is one
  over the square root of the curvature; the curvatures give the covariance matrix; an
  asymmetric log-likelihood makes the Wald interval less accurate. "Standard errors with
  TMB" (`sdreport()` on the ten quadrats and the owls, `cov.fixed` and `cov2cor()` in both
  parameterisations; the former "Covariance between estimates" is merged here), "Standard
  errors on the original scale" (see "Back-transformation") and "Wald intervals on the
  original and log scales" (the ten quadrats from the rows of `ADREPORT(lambda)`; the owl
  intervals). Four statistical detail boxes, mathematics only and no R chunk (author's
  decision): Fisher information (observed and expected, the Poisson case $n/\hat\lambda$
  by hand), the Hessian matrix (the $2\times2$ matrix, its inverse, 22 and 0.213 for the ten
  quadrats; `optim(hessian = TRUE)` and `solve()` named), Jensen's inequality (with the
  values 0 and 2), the delta method (formula, log and logit cases). The Poisson NLL gains
  `ADREPORT(lambda)` in this section, as the owl NLL gains `ADREPORT(k)`. Quiz question 7
  gives curvatures, not Hessians. The rewritten text awaits the author's review.
- **Profile intervals** (draft): no profile or interval endpoint is calculated by hand,
  in the theory or the practical (author's decision of 3 November, because it takes too
  long and TMB gives the same result): no loop of inner fits with `map`, no `uniroot()`.
  The section explains the two steps (profile with inner fits, crossings of the cutoff) in
  words and introduces `tmbprofile()` and `confint()`; then "One parameter" (the ten
  quadrats, with the 50 in a hidden chunk) and "Two parameters" (the owls). The hidden
  code of the slice and profile figure uses `tmbprofile()` with `ytol = 10`, and draws the
  path of the profile from $p=k/(k+\hat\mu)$, because the MLE of the mean is the sample
  mean for every $k$. `uniroot()` is introduced in Chapter 5, where it finds a special
  point of the Ricker function. `fig-profile_interval` draws the ten-quadrat
  log-likelihood with its parabola and the cutoff, and the text says that the Wald interval
  on the original scale is where the parabola crosses $-1.92$ ($z_{0.975}^2/2=1.92$).
- **Owl intervals:** one table with the profile and log-scale Wald intervals of $\mu$ and
  $k$ and the Wald interval of $k$ on the original scale (from `ADREPORT()`).
- **Back-transformation:** endpoints can be transformed because the logarithm is
  increasing, so coverage is kept. A standard error cannot, because a variance is an
  average and a non-linear function does not pass through an average; the main text
  explains this conceptually and Jensen's inequality is a box. The difference in units is
  not the reason (author's correction). Wording (author's decision of 3 November): `exp()`
  of a standard error is no standard error at all, not a "biased" one; the delta method
  approximates the standard error on the new scale by treating the transformation as a
  straight line near the estimate (an approximation, widely used), it does not remove a
  bias, and TMB applies it through `ADREPORT()`. The formula is a box of this chapter;
  Chapter 6 gives it for several parameters in a box and applies it to a fitted curve.
- **Simulation:** data are marked with `OBS()`, `obj$simulate()` draws each hypothetical
  sample and a visible loop refits. The hidden coverage simulation of the theory checks
  the profile interval with one extra fit at the generating value, not `tmbprofile()` in
  every sample; the practical simulates the coverage of the Wald interval only (see
  below). `checkConsistency()` is not used
  (removed on 3 November; the bias comes from the visible loop). "Coverage checked by
  simulation" closes with a note callout (author's decision of 3 November): the course
  prefers likelihood profile intervals because their coverage in small samples tends to be
  closer to 95%, at the cost of many optimisations; a Wald interval on the log scale is
  the fast approximation.
- **Properties:** short, because Chapter 3 defines consistency, asymptotic normality,
  bias and MSE. One simulation; sections "Consistency and asymptotic normality",
  "Efficiency" (standard deviation and MSE only), "Bias in finite samples" and
  "Misspecified models". The simulation fits every sample from `log_mu = 0`, `log_k = 0`
  and keeps the samples; the method-of-moments estimates are calculated from them in their
  own chunk in "Efficiency" (`#sec-efficiency`; author's decision of 3 November, so that
  students do not think a fit needs method-of-moments starting values). The numbers did
  not change. `demo-properties.R` and the copy in `figures.R` follow it.
- **Owl example kept light** (author's decisions of 3 November): the chapter does not
  explain why the Negative Binomial model may not fit the owls. "Misspecified models" is
  general only: no implied variance, no gap between the method-of-moments and maximum
  likelihood estimates of $k$, no count of nests. The gap is mentioned once, where the fit
  is reported, as the difference between two estimators. Do not add such detail back.
- **Statistical detail boxes:** the derivation of the Poisson estimator, Fisher information,
  the Hessian matrix, Jensen's inequality, the delta method, Wilks' theorem,
  the cutoff for a joint region, why maximum likelihood estimators are consistent, the
  Cramér–Rao bound, the Kullback–Leibler divergence.
- **Model comparison:** AIC (`#sec-aic`) with AICc, presented as an approximation for the
  non-linear, non-Normal models of the course that is nevertheless common in the
  literature. The practical reports AICc next to AIC wherever it compares models.
- **Practice callouts:** four remain ("crab burrows", back to the ecological scale, an
  interval from the log scale, waiting for a pollinator).
- **Practical:** reed frog tadpole survival (`emdbook::ReedfrogPred`), glacier lily
  seedlings (`emdbook::Lily_sum`), black cherry volume (`trees`), Adelie body mass
  (`penguins`). Exercise 1 is worked on the student page and shows both routes for the
  standard error (the Hessian by hand, then `sdreport()`); it is the only place in the
  chapter where the Hessian is taken from `optim()` (author's decision of 3 November); its
  likelihood interval comes
  from `tmbprofile()` only. Its question 6 compares one probability of
  survival for all 48 tanks with one per predator treatment (AIC, AICc, and the
  difference with its standard error from `ADREPORT()` and a Wald interval; awaits
  confirmation). Exercise 2: the profile interval of $k$ with `tmbprofile()`, compared
  with the Wald interval. Exercise 3: students write `my_dzipois()` by hand and verify it
  against `dzipois()`. Exercises 3 to 5 use only the TMB tools. Exercises 1 to 4 are the
  core; Exercise 5 is extra practice with a skeleton of `simulate_gamma_samples()`
  (two gaps). It simulates the coverage of the Wald interval only, because the profile
  interval would need `tmbprofile()` in every sample (author's decision of 3 November; the
  question says so). The Gamma fits start at shape 1 and rate $1/\bar x$, because from the
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

### Chapter 6

- **One running example in the theory** (author's decision of 3 November): the reed frog
  functional response (`emdbook::ReedfrogFuncresp`, 16 tanks, Vonesh and Bolker 2005),
  the backdrop of Chapter 5, now fitted. No second data set, not even for the comparison.
  The `shapes*.csv` files are no longer used by Chapter 6 (`shapes1.csv` stays for Chapter
  7). Principles over examples, as in Chapter 4: no detail of the experiment that does not
  support a general point; keep the theory below about 1,900 source lines.
- **Parameterisation:** the Holling type II form, $p(N)=\alpha/(1+\alpha HN)$ for the
  probability that a tadpole is killed, optimised as $\operatorname{logit}(\alpha)$ and
  $\log(H)$, from the values read by eye in Chapter 5 ($\alpha=0.5$, $H=1/60$). The
  Michaelis–Menten form $a,b$ appears only to connect to Chapter 5 and in one sentence on
  correlation (0.98 in $a,b$ against 0.82 in $\alpha,H$). The model is written as
  $K_i\sim\operatorname{Binomial}(N_i,p(N_i))$; the term "conditional distribution" is left
  to Chapter 7.
- **One modelling cycle on one data set:** Binomial fit → standard errors, correlation and
  likelihood profile intervals ($\alpha$, $H$, and $1/H$ by transforming the endpoints) →
  pointwise confidence band of the curve from `ADREPORT()` on a grid, on the logit scale →
  simulation with `OBS()` and scaled quantile residuals from DHARMa, which show
  overdispersion → Beta-Binomial with the same curve (precision $\kappa$) → comparison →
  interpretation. Four candidate models: constant probability ($H=0$) and Holling type II,
  each with a Binomial and a Beta-Binomial distribution, all fitted to the 16 tanks.
- **Delta method:** a statistical detail box only (several parameters), no calculation by
  hand; the band comes from `ADREPORT()`. `#sec-delta-method` is the section "Uncertainty
  of the fitted curve" and `#sec-makeadfun` "The gradient and automatic differentiation"
  (with a collapsed technical detail box); other pages link to both IDs. RTMB 2.0 refuses
  an `if` on a parameter (`MakeADFun()` stops with "Comparison is generally unsafe for AD
  types"); the text and the lecture say so.
- **Residuals: DHARMa only**, from `obj$simulate()` and `createDHARMa()`. `plot()` stays
  with its printed tests (author's decision of 4 November); the plots and the dispersion
  statistic are exploratory, and one sentence says why the course does not rest decisions
  on p-values. `plotResiduals(form = ...)` is named but not run in the theory.
- **Comparison:** AIC and AICc recalled, BIC added, and leave-one-out cross-validation with
  the log score (every parameter refitted to the other 15 tanks from fixed starts; no
  random folds; other folds named once as "5-fold or 10-fold", never "$K$-fold", which
  clashes with $K$; no RMSE). $n$ in AICc and BIC is the
  16 tanks for all four models; whether it could be the tadpoles is left to Chapter 7
  (author's decision of 4 November). The criteria disagree on the curve under the
  Beta-Binomial (AIC, AICc and BIC prefer Holling type II, leave-one-out the constant
  probability), and the text keeps the disagreement so that students see it (author's
  decision); the answer uses the Beta-Binomial Holling type II model.
- **Coverage and bias by simulation:** only in the practical's extra exercise; the theory
  says in one sentence that a coverage check works as in Chapter 4.
- Three numbered Practice callouts (`imp-seedlings-light`, `imp-ladybird-handling`,
  `imp-fruit-set`), a roadmap table after the learning goals and a recipe callout before
  the summary, as in Chapter 4. No `%~%`.
- **Practical:** Exercise 1 (worked on the student page and repeated in full in
  `solution.qmd`, so that Exercise 4 can use its objects) the myxoma titre
  (`emdbook::MyxoTiter_sum`, grade 1) with a Ricker curve, Normal and Gamma models;
  Exercise 2 `Puromycin`, Michaelis–Menten with Normal errors, one curve against one
  asymptote per state; Exercise 3 fir fecundity (`emdbook::FirDBHFec_sum`), a power law
  with Poisson and Negative Binomial models; Exercise 4 (extra) bias and coverage of the
  Wald interval of the time of the peak by simulation, with a skeleton of
  `simulate_peak_time()` (two gaps). Awaiting the author: `solution.qmd` repeats Exercise 1
  in full, whereas the solution pages of Chapters 4 and 5 link to their worked exercise;
  six fecundities that are not whole numbers are rounded with `round()` (dropping them is
  the alternative); the Wald
  interval of the peak time is calculated on the original scale (coverage 0.927), because
  the lesson is the asymmetry that the profile interval captures.
- **Lecture:** one of 150 minutes; its demo shows the modelling cycle for the Binomial
  model with the Holling type II curve, from the fit to the residuals, without model
  comparison (author's decision of 3 November).

### Chapters 7 and 8

- They predate the rewrite of Chapters 4 to 6 and received consistency fixes only; the
  full rewrite is a separate plan. Where their terms differ from Chapters 4 and 6, follow
  Chapters 4 and 6 in new work.
- The rewrite of Chapter 7 (theory, practical, one lecture) follows
  `Chapter_7/rewrite-handoff.md`: seven stages with the author's decisions of 4 November
  (one example, the CO₂ uptake curves of `datasets::CO2` with a random asymptote per plant;
  conditional distributions, the Laplace approximation and REML; AIC and leave-one-group-out
  cross-validation; four real data sets in the practical). Its last stage moves the durable
  decisions into this file.
- Chapter 7 introduces `shapes1.csv` (light response of five leaves) itself; it no longer
  relies on Chapter 6 for these data or for the `%~%` notation.
- Not converted: the Chapter 7 theory and practical still use `%~%`, one parameter list,
  data read from the workspace and `obj$he()`; Chapter 8 passes plain functions to
  `optim()` with `hessian = TRUE`; the learning goals of Chapter 7 keep the old format.
- Chapter 4 points to Chapter 7 for REML, which Chapter 7 does not cover yet.
- Technical difficulties of optimisation appear in Chapter 7 only as examples, with a
  pointer to Chapter 8 and no mechanics (author's decision of 4 November). The first is
  Exercise 5 of the Chapter 7 practical: a few REML fits stop at a practically zero
  variance among sites with convergence code 0. A note callout in Chapter 8 ("Hybrid global
  and local optimisation") says that several random starting values find the maximum; the
  rewrite of Chapter 8 works through this example.

### Other

- The Chapter 1 practical has a step that installs the course packages, and it teaches
  contour plots with `outer()` and `contour()` in base R, so later chapters use them
  without introduction.
- Figures that the author decided to keep outside the plotting rules: the `theme_bw()`
  figure of the Chapter 3 theory and the two starting-value figures of the Chapter 5
  theory (base R, `plot()` with `curve()`). Awaiting the author's confirmation: the DHARMa
  residual plots of Chapter 6 (theory and lecture) are the package's own base-graphics
  plots, shown with visible code because the tool is the lesson.
- The glossary was updated for RTMB.
- **Numbered practice callouts** (author's decision, issue 8): the `Practice` callouts of
  the theory pages of Chapters 2 to 6 are numbered per page ("Practice 3"), so that
  students' scripts and the lectures can refer to them; the chapter number is not shown
  on the page and is added by hand when a reference must be unique across the book. The
  supplements and Chapters 7 and 8 are not numbered yet. The Chapter 2 lecture (slides,
  script and handoff) names the callouts by number; `lecture-script.pdf` was not
  regenerated. The pattern is in `STYLE_GUIDE.md`.

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
- Where topics live: method of moments in Chapter 3; AIC and AICc in Chapter 4; the delta
  method as a box in Chapter 4 (one parameter) and in Chapter 6 (several parameters,
  applied to a fitted curve through `ADREPORT()`), never calculated by hand in R; BIC,
  leave-one-out cross-validation and scaled quantile residuals in Chapter 6; bounds,
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
- The production build renders Chapters 1 to 6 (with the lectures of Chapters 1 to 4 and
  6) and five supplements; Chapters 7 and 8 are rendered only by the dev profile.
- Every package loaded in a rendered page must be in `.github/workflows/publish.yml`, or
  the production build fails. Production needs `MASS`, `ggplot2`, `patchwork`, `dplyr`,
  `RTMB`, `RTMBdist`, `TMB` (for `tmbprofile()`), `quarto`, `glmmTMB` (`Salamanders`,
  `Owls`, the `glmmTMB` supplement), `boot` (`fir`), `emdbook` (Chapter 4 practical,
  Chapters 5 and 6), `DHARMa` (Chapter 6), `knitr` and `rmarkdown`. `DEoptim` and `GA`
  stay for Chapter 8. `VGAM`, `gtools` and `COMPoissonReg` were removed because no page loads them.
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
