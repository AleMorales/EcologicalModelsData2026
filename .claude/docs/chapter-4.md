# Decisions: Chapter 4

Moved from AGENTS.md. Read this before working on the pages it covers; AGENTS.md points here.

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
  curves). The $k$, $p$ NLL and fit (`nb_prob_nll()`, `owl_prob_obj`) are visible, because
  "Standard errors with TMB" uses `owl_prob_obj` for a correlation; the surface, slice and
  profile code is hidden. Slices and profiles are defined in general symbols
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
  seedlings (`emdbook::Lily_sum`), black cherry volume (`trees`). The penguin questions of
  Exercise 4 (Gamma fit in grams and kilograms, LogNormal comparison) and the Wald interval
  of the tree shape at the start of Exercise 5 were removed because the practical was too
  long (author's decision of 4 November); the stalled Gamma fit of the Adelie masses is now
  introduced in Exercise 2 of the Chapter 8 practical. Do not add them back. Exercise 1 is
  worked on the student page and shows both routes for the standard error of
  $\operatorname{logit}p$ (the Hessian of `optim(hessian = TRUE)`, then `sdreport()`); it
  is the only place in the chapter where the Hessian is taken from `optim()` (author's
  decision of 3 November); question 3 also asks for the standard error of $\hat p$ with
  `ADREPORT()`, which question 6 needs; its likelihood interval comes from `tmbprofile()`
  only. Question 6 compares one probability of survival for all 48 tanks with one per
  predator treatment and asks for the difference with its standard error and 95% Wald
  intervals for both probabilities and the difference (author's decision of 4 November).
  Exercise 2: the profile interval of $k$ with `tmbprofile()`, compared with the Wald
  interval. Exercise 3: students write `my_dzipois()` by hand and verify it against
  `dzipois()`. Exercises 3 to 5 use only the TMB tools. Exercises 1 to 4 are the core;
  Exercise 5 is extra practice with one chunk of code after each of questions 1 and 2
  (author's decision of 4 November): every gap is an `NA` that students replace, with a
  comment above it, and no other `NA` appears in the chunks (the data frame starts with
  zeros). The chunk of question 1 defines `simulate_gamma_samples()` (fit of one sample:
  `sim_obj`, `fit`, `shape_ml`; it stores `se_log_shape` from `sdreport()`) and calls it
  (shape and rate as gaps); the chunk of question 2 calculates `lower`, `upper` and
  `covered` from the columns of `trees_31`, outside the loop. Exercise 4, question 1 fixes
  the names `gamma_nll()`, `log_shape`, `log_rate` and `x`, on which the chunk relies. It
  simulates 31 trees (seed 801) and then 150 trees (seed 802) from the same model, and
  the coverage of the Wald interval only, because the profile interval would need
  `tmbprofile()` in every sample (author's decision of 3 November; the question says so).
  The simulated fits start at shape 1 and rate $1/\bar x$. Grid ranges for the contour
  questions are given in the questions. Exercise 4, question 3 has a hint that names the
  columns `log_shape` and `value` of the result of `tmbprofile()` and the argument `ytol`,
  because the theory uses them only in hidden code (added after a read-through as a
  student on 4 November). Final check of 11 November (drafts awaiting the author): question
  3 of Exercise 1 explains the Hessian in its own text as the curvature of the
  log-likelihood and no longer sends students to the detail boxes; the closing caveat of
  question 6 and the Beta-Binomial pointer of question 5 were removed because no question
  asks for them; question 4 of Exercise 3 has a hint for the cumulative probabilities and
  the introduction says that `zeroprob` is the argument of RTMBdist; question 1 of Exercise
  5 asks to check convergence. Properties of estimators are practised only in the extra
  Exercise 5.

