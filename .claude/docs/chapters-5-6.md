# Decisions: Chapters 5 and 6 and their supplements

Moved from AGENTS.md. Read this before working on the pages it covers; AGENTS.md points here.

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
  16 tanks for all four models (author's decision of 4 November). Chapter 7 answers why
  not the tadpoles: tadpoles of one tank share it, so the tanks are the independent
  observations ("Observations in groups"); for grouped data $n$ lies somewhere between
  the number of groups and of observations, so grouped models are compared with AIC and
  leave-one-group-out cross-validation only. The criteria disagree on the curve under the
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
  with Poisson and Negative Binomial models, the profile interval of the exponent
  (transformed to $2^b$) and, in question 6, the pointwise band of the mean fecundity from
  `ADREPORT()` of its logarithm on a grid of diameters (the only practice of recipe step
  6); Exercise 4 (extra) bias and coverage of the Wald interval of the time of the peak by
  simulation, with a skeleton of `simulate_peak_time()` (two gaps). Leave-one-out
  cross-validation in Exercise 2, question 5 is a skeleton with two gaps (the refit and
  the score); the text above it explains that `as.list(fit$par)` fails for the vector
  `log_a`, so the held-out observation is scored with `MakeADFun()` and `fn()`. No
  restart from other starting values in this practical (a Chapter 8 skill). Questions of
  Exercises 2 to 4 end with inline "Hint:" sentences that name the theory section in
  quotes with a link to its `sec-` ID; the intro says to work in one R session (`cmb()`,
  `critical_value` and `n_sim` carry over). The Monte Carlo standard error is defined in
  the hints of Exercise 4 (it is not taught earlier). Estimated time of the core for an
  average student: about 5 to 5.5 hours. Awaiting the author: the hints, the skeleton of
  Exercise 2 and Exercise 3, question 6 (drafts of 4 November); `solution.qmd` repeats Exercise 1
  in full, whereas the solution pages of Chapters 4 and 5 link to their worked exercise;
  six fecundities that are not whole numbers are rounded with `round()` (dropping them is
  the alternative); the Wald
  interval of the peak time is calculated on the original scale (coverage 0.927), because
  the lesson is the asymmetry that the profile interval captures.
- **Lecture:** one of 150 minutes; its demo shows the modelling cycle for the Binomial
  model with the Holling type II curve, from the fit to the residuals, without model
  comparison (author's decision of 3 November).

