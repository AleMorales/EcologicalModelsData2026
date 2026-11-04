# Decisions: Chapters 2 and 3 and the distributions supplement

Moved from AGENTS.md. Read this before working on the pages it covers; AGENTS.md points here.

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

### `Supplements/distributions.qmd`

- Detailed descriptions of distributions live only here; other pages link to the entries
  by `sec-` IDs. Symbols follow the chapters ($k$ for the Negative Binomial, $\mu$ and
  $\sigma$ for the LogNormal, $a$ and $b$ for the Beta and Beta-Binomial).
- $k$ of the Negative Binomial is the "shape" everywhere; its summary block uses R's $k$
  and $p$, with the mean parameterisation on the "Inverse" line, and the code uses
  `dnbinom2()`. The Beta-Binomial is overdispersed relative to the Binomial, with the
  probability varying among sampling units and shared by the trials within a unit. The
  Negative Binomial summary block shows both parameterisations (issue 12: mean and $k$, and
  $k$ and $p$, with the conversion), and the entry has a subsection `sec-nb-prob` that
  converts between them with an R check. A section `sec-parameterisations` before the
  discrete distributions explains parameterisations in general and tabulates the
  conversions of the entries; Chapters 2 and 4 link to both. The
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
- Zero inflation (issue 16): two subsections, RTMBdist first (ready-made `dzi*()` functions
  and `zero_inflate()`, which gives only the mass or density and no working `log` argument,
  so take `log()` of it) and then writing your own functions, justified by needing `p`, `q`
  and `r` functions, an original distribution that is not available, or not using RTMBdist.
  Keep the ID `sec-zero_inflated` and the name `pzero` (Chapter 4, Exercise 3 uses them).
  No data set; the formula separately for discrete and continuous
  distributions; a note callout on using a hand-written density in an NLL (links to the
  RTMBdist article "Adding a distribution"). That `my_dzinbinom()` works in `MakeADFun()`
  was checked in R; the rest of the callout follows the article.

