# Instructions for course collaborators

## System prompt / working role

You are collaborating with the course author on an online textbook for Ecological
Modelling and Data Analysis in R. Help students connect ecological questions to
probability models, fit models to data using maximum likelihood, and interpret
estimates and uncertainty. Write as a patient teacher of ecology, statistics, and
R. Explain the reasoning behind an analysis so students can apply it themselves.

These are repository instructions, subject to the assistant's higher-priority
instructions and the user's current request. The human author decides course
scope and approves the teaching material; generated text is a draft until reviewed.

## Read before working

- Read [Chapter_1/Theory.qmd](Chapter_1/Theory.qmd) before making course-content
  changes. It is the overview of the course and its chapters; use it to identify
  the relevant theory, practical, and prerequisite files before reading those
  files in detail.
- Read [STYLE_GUIDE.md](STYLE_GUIDE.md) before writing or editing course material.
  It defines prose, notation, Quarto, and R conventions.
- Read the target page, its associated practical or theory, and relevant earlier
  explanations. Check prerequisites and existing object names before adding code.
- Read `_quarto.yml` before changing navigation or document layout.
- Follow explicit author instructions over inferred conventions. Where the source
  is inconsistent, use the decisions in the style guide for new work. Do not copy
  mistakes simply because they appear in an established chapter.

## Reference material and review status

The course has currently been generated through Chapter 8. The former Chapters 2
(discrete probability) and 3 (continuous probability) were merged into one
Chapter 2 and the later chapters moved down by one, so older notes and git
history may use numbers that are one higher. Generation does not imply human
review; record later review decisions here when the author confirms them.

On 5 October 2026 the author stated that Chapters 1 to 3, theory and practicals,
are reviewed and approved. Use all of them as reference for content, depth,
notation and format. For voice, the author's own text remains the reference, as
the table lists; Chapter 1 is the exception in register. Chapters 4 and 5 were
rewritten from scratch after that review and await the author's review (last rows but one).

On 6 October 2026 two reviews of Chapters 1 to 5 and the supplements led to a round of
corrections and rewrites, which the author decided finding by finding. The sections that
were rewritten in that round (listed in the table) are generated drafts awaiting the
author's review, **including the author's own sections that were rewritten**: those no
longer count as references for voice until the author approves them. Decisions of that
round that override earlier ones: real data replace the hypothetical running examples for
continuous data (Gentoo penguin flipper length and body mass, Chapters 2 and 3), for
overdispersion (the `Salamanders` counts, Chapter 2) and for the Poisson example (the
`boot::fir` counts of balsam fir seedlings, Chapters 3 and 4); the hypothetical Normal
model of tree heights (22 m and 4 m) is no longer used anywhere; the hypothetical Binomial
seed-survival example stays in Chapter 2; and a practical may use another species of the
data set that its theory page uses (the Chapter 4 practical uses Adelie penguins and the
Chapter 2 practical Chinstrap penguins, while the theory uses Gentoo penguins).
`penguins` of `datasets` needs R 4.5.0 or later, and `boot` is in `publish.yml` for the
Chapter 3 and Chapter 4 theory.

| Material | Status and use |
|---|---|
| `Chapter_1/Practicals/material.qmd` and its wrappers | Reviewed and approved. Completed practical; primary reference for teaching voice, introductory R, and conditional solutions |
| `Chapter_1/Theory.qmd` | Reviewed and approved. Finalised by the author; reference for the author's voice in its essay register (motivation, opinion). Do not carry that level of opinion into technical chapters |
| `Chapter_2/Theory.qmd` | Reviewed and approved on 5 October 2026, then revised on 6 October 2026. On 7 October 2026 its code was converted to the distribution functions of RTMB and RTMBdist (D13: both are loaded at the first probability calculation, with one sentence and a pointer to Chapter 4; numbers unchanged); the converted code awaits a quick check by the author. The author's own sections that were not rewritten are the primary reference for voice in technical chapters, conceptual explanations, ecological examples, notation, and figures: "Discrete probability distributions", the discrete part of "Joint distributions" (the seed-survival examples stay), the discrete part of "Expectations and central moments" and "Choosing a distribution" with the parts of "Overdispersion" that were not rewritten. Rewritten on 6 October 2026 (**generated drafts awaiting the author's review**; use for content, depth, notation and format, not as a model of voice, and the author's passages among them are no longer references for voice until approved): the i.i.d. paragraph of the i.i.d. subsection (identically distributed separated from independent), the passage on skewness and kurtosis (standardised moments, excess kurtosis), "Overdispersion" ("A simple diagnostic for overdispersion" uses the `Salamanders` counts of the spring salamander, species `GP`, at the 12 unmined sites: 48 counts with mean 2.21 and variance 4.98), and the sentence on the mean and variance of the Binomial model. "Continuous probability distributions", "Joint distributions of continuous variables" and the `integrate()` passage of the expectations section were generated, approved and then rewritten with the Gentoo penguins: a Normal model of flipper length with the rounded parameters $\mu=217$ mm and $\sigma=6.5$ mm (described as values that describe the data well, with a pointer to Chapter 3 for how such values are obtained), and a bivariate Normal model of flipper length and body mass (5100 g and 500 g, correlation 0.7) drawn over the real birds. `integrate()` runs from 150 to 280 mm because infinite limits fail for this narrow density. The introduction, learning goals, summary and quiz questions 4 to 6 and 8 follow these examples |
| `Chapter_2/Practicals/no_solution.qmd` and `solution.qmd` | Reviewed and approved. On 7 October 2026 the code was converted to RTMB and RTMBdist (D13; `dnbinom2()`, `rnbinom2()` and the load order; numbers unchanged) and awaits a quick check by the author. Exercises 1 (seedlings), 3 (`InsectSprays`) and 4 (Negative Binomial) are the author's completed work and the primary reference for exercises, worked reasoning, and interpretation; on 6 October 2026 question 4 of Exercise 3 (the Negative Binomial fit from moments) was removed by the author's decision, "theoretical" became "model" and the solution headings of Exercise 4 were matched to its four questions. Exercises 2 (Normal), 5 (LogNormal) and 6 (Beta) were generated and then approved; worked Exercise 2 was rewritten on 6 October 2026 (a generated draft awaiting review): it is "Bill length under a Normal model" for the 68 Chinstrap penguins, whose data only motivate the rounded parameters 49 mm and 3.3 mm, and question 3 stays a simulation of 1,000 values compared with the model density |
| `Chapter_3/Theory.qmd` | Reviewed and approved on 5 October 2026, then rewritten on 6 October 2026: a generated draft awaiting the author's review. On 7 October 2026 its code was converted to RTMB and RTMBdist (D13; numbers unchanged), which also awaits a quick check. The opening section, `# Samples and distributions`, was the author's text (moved from Chapter 2) and was rewritten with the real data, so it is no longer a reference for voice until approved; the author's sentences were kept where they still apply, and the sentence that a data sample "does not have a mean or a variance" was softened. Decisions that stand. **Examples**: the counts of balsam fir seedlings in 50 quadrats (`boot::fir`; mean 2.14; Davison and Hinkley 1997) under a Poisson model, from the opening section to the confidence interval, and the flipper lengths of the 123 Gentoo penguins in "Samples of continuous measurements" and "Estimation of two parameters", compared with the Normal model of Chapter 2. Neighbouring quadrats are treated as i.i.d. (stated once, with a pointer to Chapter 7). Every simulation uses a mean of 2.14 and 50 quadrats (a plug-in simulation), and the figure on asymptotic normality keeps its two sample sizes, 5 and 100 quadrats. **Statistical detail boxes**: as in Chapter 4, formal results sit in collapsed `callout-caution` boxes (the law of large numbers and the Glivenko–Cantelli theorem, the bias of the variance estimator, consistency, the central limit theorem) and the main text states each in plain words and is complete without them. **Conditions**: the callout on asymptotic convergence states its conditions (moments converge when they exist; a quantile converges where the cumulative probability function of the model is not flat), and agreement of the empirical distribution with the model does not show independence. The orchid practice callouts stay hypothetical; the other practice callouts and quiz questions follow the new examples |
| `Chapter_3/Practicals` | Reviewed and approved; the code was converted to RTMB and RTMBdist on 7 October 2026 (D13; numbers unchanged) and awaits a quick check. Decisions that stand: Exercise 1 uses the `Owls` data from `glmmTMB` (loaded with `data(Owls, package = "glmmTMB")`, not a copied CSV), restricted to satiated nestlings and female parents, with a Negative Binomial model and method-of-moments estimates. Exercise 2 (asymptotic convergence) uses a Beta model for the fraction of leaf area eaten (a = 2, b = 6) with the fixed seeds 123 and 11, 22, 33, 44; it replaced the author's Poisson exercise, which was moved from Chapter 2. Exercise 3 (variation in tree heights) uses the `Height` column (ft) of the `trees` data set from base R's `datasets` package (31 trees, Normal model): students estimate the mean and variance by method of moments and then simulate 2,000 hypothetical experiments of 31 trees from a Normal model with those estimates as parameters (a plug-in simulation, without introducing the term parametric bootstrap); it keeps seed 434 and 2,000 experiments, and the solution reports the standard error of each simulated bias, so that students see that the deviation from the expected value is about two standard errors. No package needs adding to `publish.yml` for it. Exercise 4 (mean body mass and interval coverage, LogNormal model) uses Wald intervals only: the $t$ interval does not appear in the practical, because the data are not Normal and the course teaches the general approximation (it remains only in a footnote of the theory page). The solution page restates the tasks of every exercise above its solution |
| `Chapter_3/Practicals` | Reviewed and approved; the code was converted to RTMB and RTMBdist on 7 October 2026 (D13; numbers unchanged) and awaits a quick check. Decisions that stand: Exercise 1 uses the `Owls` data from `glmmTMB` (loaded with `data(Owls, package = "glmmTMB")`, not a copied CSV), restricted to satiated nestlings and female parents, with a Negative Binomial model and method-of-moments estimates. Exercise 2 (asymptotic convergence) uses a Beta model for the fraction of leaf area eaten (a = 2, b = 6) with the fixed seeds 123 and 11, 22, 33, 44; it replaced the author's Poisson exercise, which was moved from Chapter 2. Exercise 3 (variation in tree heights) uses the `Height` column (ft) of the `trees` data set from base R's `datasets` package (31 trees, Normal model): students estimate the mean and variance by method of moments and then simulate 2,000 hypothetical experiments of 31 trees from a Normal model with those estimates as parameters (a plug-in simulation, without introducing the term parametric bootstrap). No package needs adding to `publish.yml` for it. Exercise 4 (mean body mass and interval coverage, LogNormal model) uses Wald intervals only: the $t$ interval does not appear in the practical, because the data are not Normal and the course teaches the general approximation (it remains only in a footnote of the theory page) |
| `Supplements/distributions.qmd` | Reference entry per distribution: summary table, description, `### Example:` verified in R, figure, and a `Practice` callout with a collapsed solution. The Binomial, Poisson, and Negative Binomial text is the author's (moved from Chapter 2); the other entries are generated drafts awaiting review. Tables and prose use the chapter symbols ($k$ for Negative Binomial, $\mu$ and $\sigma$ for LogNormal, $a$ and $b$ for Beta and Beta-Binomial). The author decided that detailed distribution descriptions live only here: Chapter 2 keeps two running examples (the Binomial for discrete data and the Normal for continuous data) and the Overdispersion section, and theory pages, practicals, and later chapters link to the entries by their `sec-` IDs. The Chapter 2 practical tells students to read the relevant entries first. Decisions of 6 October 2026: $k$ of the Negative Binomial is the "shape" everywhere (the summary block is written in R's parameters $k$ and $p$, with the mean parameterisation on the "Inverse" line); the Beta-Binomial is overdispersed relative to the Binomial, with the probability varying among sampling units and shared by the trials within a unit; the zero-inflation section is written without a data set and gives the formula separately for discrete and for continuous distributions; the Student's t entry has that name (the ID is unchanged). The Normal, Student's t and Multivariate Normal entries no longer use tree heights: the first two use the shell length of mussels in a bed (hypothetical, $\mu=60$ mm and $\sigma=5$ mm) and the third the length and width of mussel shells (width 30 mm and 3 mm, correlation 0.6). These three examples are generated drafts awaiting review. **RTMB conversion (7 October 2026, D14)**: every entry names the RTMB or RTMBdist density or mass function first, and the functions that fill in (base R, MASS or a sum of the mass) are announced once in the introduction and named in an entry only when they come from another package or are calculated from the mass; `VGAM`, `gtools` and `COMPoissonReg` are no longer loaded (the page loads `RTMB`, `RTMBdist` and `MASS`). The Conway–Maxwell–Poisson entry is written on `dcompois2()` (mean and $\nu$; the example is a clutch with a mean of 2.5 eggs, the cumulative probability is a sum of the mass and `sample()` on the mass simulates); the Uniform entry says that RTMB has no Uniform density for fitting; the Student's t entry uses `stats::pt()`; the Negative Binomial entry uses `dnbinom2()` (author's text, only code and function names changed). The generated changes await the author's review. On 7 October 2026 the zero-inflation section received a note callout on using a hand-written density in an NLL (it links to the RTMBdist article "Adding a distribution" and says that functions that branch on parameters, use `stats::` prefixes or need `obj$simulate()` may need extra steps); its claim that `my_dzinbinom()` works in `MakeADFun()` was checked in R (same NLL and gradient as `dzinbinom()`), the rest follows the article and is a generated draft |
| `Chapter_4/Theory.qmd` and `Chapter_4/Practicals` | **Rewritten to the RTMB pattern on 7 October 2026 under `.plans/plan_rtmb_early.md` (decisions D1 to D17 in the paragraph after this table): a generated draft awaiting the author's review.** Before that, the chapter was rewritten from scratch after the review of Chapters 1 to 3 and trimmed and refocused on 6 October 2026 after the author's first reading (a generated draft with the author's own edits, which stay). The four `<!-- AUTHOR: ... -->` comments of the draft were replaced by the author's own sentences, so the theory has none; do not add first-person opinion on the author's behalf. Decisions that stand. **Structure**: the page is presented in two parts, in the introduction and in the roadmap table that follows the learning goals (Part 1: likelihood, estimation, several parameters; Part 2: uncertainty, properties, model comparison), without "Part" headings. Part 2 runs in the order uncertainty (standard errors, Wald and profile intervals, joint regions, coverage), then properties of estimators (each property told from a simulation first), then AIC. A "recipe for a fit" callout closes the chapter before the summary. It holds the explanation of the gap between the method-of-moments and maximum likelihood estimates of $k$ for the owls (the model is an approximation and no pair of values reproduces the mean, the variance and the fraction of zeros; in none of 2,000 simulated experiments does the gap reach the observed 0.27), which "Efficiency" does not claim to explain: that section keeps the general comparison of precision. **Failed fits**: a note callout ("When a fit fails") at the end of "Constraints and transformations" says to check `convergence`, that `fn` returns `NaN` without a warning for parameter values where the NLL cannot be calculated and that BFGS treats this as a failed step (harmless when the fit converges, an error when the starting values give `NaN`), what to try when a fit fails, and that Chapter 8 explains the rest. **Calculus**: the first derivative of the chapter points to the rules of differentiation in `Supplements/calculus.qmd`. **Statistical detail boxes**: formal results (the derivation of the Poisson estimator, Wilks' theorem, the cutoff for a joint region, consistency, the Cramér–Rao bound, the Kullback–Leibler divergence) sit in collapsed `callout-caution` boxes that students can skip; the main text must be complete without them. **Examples**: the theory uses the 50 counts of balsam fir seedlings of Chapter 3 (`boot::fir`, Poisson model; estimation uses all 50 quadrats, and the likelihood curve and the three intervals use the first ten quadrats as a smaller sample, where the asymmetry is visible, and are then repeated for the 50, where they nearly coincide) and the owl data of the Chapter 3 practical (Negative Binomial model); the Normal model appears only in footnotes and in the callout about the interactive likelihood page. The practical uses reed frog tadpole survival (`emdbook::ReedfrogPred`), glacier lily seedlings (`emdbook::Lily_sum`), the volume of black cherry trees (`trees`) and Adelie penguin body mass (`penguins`, which needs R 4.5.0 or later); Exercise 1 is worked on the student page and shows both routes for the standard error and the interval (by hand, then `sdreport()` and `TMB::tmbprofile()`; its question 6 compares one probability of survival for all 48 tanks with one per predator treatment, with AIC and AICc, and reports the difference between treatments with its standard error from `ADREPORT()` and a Wald interval, a choice that awaits the author's confirmation). Exercises 2 to 5 are for students to solve: Exercise 2 asks for one profile by hand (a grid of inner fits fixed with `map`) checked with `tmbprofile()`, Exercise 3 has students write the zero-inflated Poisson mass function by hand and verify it against `dzipois()` (the hand-written function is `my_dzipois()`), and Exercises 3 to 5 use only the TMB tools for standard errors and profiles. The Gamma fits of the Adelie penguins start at shape 1 and rate $1/\bar x$ and not at the method-of-moments estimates, because without `reltol` the latter stop one step from the maximum; the solution says why (a choice that awaits the author's confirmation). Exercises 1 to 4 are the core of the practical and Exercise 5 is extra practice; it gives students a code skeleton of the simulation function (`simulate_gamma_experiments()`, with three gaps) in place of the complete code. **Notation**: keep the bar in $P(X=x\mid\theta)$ and $L(\theta\mid x_1,\ldots,x_n)$; $\ell$ is the log-likelihood and NLL the negative log-likelihood. **Fitting**: every NLL takes `parms` and `data` and uses `getAll()`; `cmb()` connects it to data, `MakeADFun()` processes it and `optim()` with `method = "BFGS"` receives `gr = obj$gr` (the first fit already, so the chapter contains no plain function given to `optim()`; there is no `reltol`); constraints only by transformation (logarithm, logit); each calculation that TMB does is shown once by hand (the Hessian from `hessian = TRUE` and `solve()`, `uniroot()` for a profile endpoint, a grid of inner fits for a profile of $k$) and then done with `sdreport()`, `ADREPORT()`, `TMB::tmbprofile()` with `confint()`, and `OBS()` with `obj$simulate()` (the hypothetical experiments of the simulations; `checkConsistency()` appears once, called with `estimate = TRUE`, with the bias calculated from the refitted estimates because the default call does not measure the bias of the maximum likelihood estimator, a departure from the wording of D7 that awaits the author's confirmation); the length of the page is 3,041 lines against 2,857 before the rewrite (D6 is not met); `optim()` is the only method of estimation (the closed-form Poisson estimator is stated, and its derivation is in a box); grids filled with `for` loops that call `obj$fn()` serve to draw likelihood curves, surfaces and slices, never to estimate. The method of moments appears only as a source of starting values and in "Efficiency", the one place where the two methods are compared. The code of the second parameterisation of the Negative Binomial model ($k$ and $p$) and of the slice and profile curves of the owl model is hidden (`#| include: false` or `#| echo: false`) and kept in the source. **Standard errors and Wald intervals** (section 6.1 of the theory, reorganised on 7 October 2026 at the author's request, a generated draft awaiting review): four subsections in this order, "Fisher information" (observed information and the Wald interval on the original scale), "The Hessian matrix" (`optim(hessian = TRUE)`, `solve()`, `diag()` and `sqrt()`, for the Poisson fit and by hand for the owl model), "Constrained and unconstrained parameters" (the standard errors of $\hat\lambda$ and of $\log\hat\lambda$ are compared explicitly with the Poisson example, and the interval from the log scale is calculated from them) and "Automation with TMB" (`sdreport()`, `ADREPORT()` and the interval table of the owl model, which does not repeat that comparison); the by-hand owl fit with `hessian = TRUE` comes before the NLL with `ADREPORT(k)`, which is processed and fitted again. **Profile likelihood intervals** (section 6.3, reorganised on 7 October 2026 at the author's request, a generated draft awaiting review): three subsections in this order, "One parameter" (the Poisson interval by hand with `uniroot()`), "Two parameters" (the profile of $k$ by hand on a grid of inner fits) and "Automation with TMB" (`TMB::tmbprofile()` with `confint()`, for the Poisson and owl models, the comparison of intervals and the figure); the text says that in practice students use the TMB functions and do not repeat the hand calculations. **Back-transformation**: endpoints of an interval can be transformed because the logarithm is increasing, so the transformed interval has the same coverage; a standard error cannot be transformed that way (the reason is that a standard error is built from expectations, which do not pass through non-linear functions, as Jensen's inequality states; the difference in units is not the reason, by the author's correction of 7 October 2026), so a quantity calculated from the parameters is requested with `ADREPORT()` and its standard error read from `sdreport()`, where TMB applies the delta method, which Chapter 6 explains. Four practice callouts remain ("crab burrows", back to the ecological scale, an interval from the log scale, waiting for a pollinator). **Uncertainty**: the profile likelihood interval is the reference method and the Wald interval is the fast approximation, calculated on the optimised scale with the endpoints transformed back; the delta method is applied by TMB through `ADREPORT()` and explained in Chapter 6. **Model comparison**: AIC (with $K$ for the number of parameters) is introduced here, together with the small-sample correction AICc, which the author asked to present as an approximation for the non-linear, non-Normal models of the course that is nevertheless common in the literature (Chapter 6 adds BIC and cross-validation, not AICc). The practical reports AICc next to AIC wherever it compares models (Exercises 2, 3 and 4) |
| `Chapter_5/Theory.qmd`, `Chapter_5/Practicals`, `Supplements/deterministic-functions.qmd` and `Supplements/calculus.qmd` | Rewritten from scratch after the review of Chapter 4: a generated draft awaiting the author's review. Two `<!-- AUTHOR: ... -->` comments in the theory (phenomenological against mechanistic functions; how to choose between candidate functions) mark places for the author's own view; do not fill them with first-person opinion. Decisions that stand. **Content**: the chapter contains no statistics, and its introduction says why it comes now (Chapters 2 to 4 gave every observation the same distribution; Chapter 6 fits curves and needs the candidate functions, the meaning of their parameters and starting values). The theory analyses two functions in full (Michaelis–Menten and Ricker), which match its two reed frog data sets. On 6 October 2026 the author reduced them from four because the chapter was too long: the exponential decay and the logistic function are no longer analysed in the theory (the theory names them for the decreasing and sigmoid shapes, keeps the half-life as one sentence that points to the exponential entry, and keeps the inverse logit and the exponential of a line in the composition section, which Chapter 6 links to), and their derivations, with the three forms of the logistic function, live in their supplement entries, which are self-contained; do not add them back to the theory. Every other function has a full entry in the function supplement (one entry per function, with `sec-fn-` IDs; since 7 October 2026 the entries have no examples, figures or exercises, see the paragraph on this supplement after the table), and the theory links to those entries. The theory also covers phenomenological and mechanistic functions (the disc equation is derived as the example), functions of two inputs, range and composition, nested functions, partial derivatives with respect to parameters, choosing a function and reading starting values by eye. On 6 October 2026 the author removed the sections on transformations of the axes and on local approximation (linear and quadratic) from the theory because the chapter had grown too long, together with the questions of the practical that depended on them (the two approximations and the logarithmic axis in Exercise 6, the logarithmic axes in Exercise 7); do not add them back. Exercise 6 now has two questions, and in Exercise 7 the power law is chosen from the shape of the cloud on ordinary axes, with the exponent calculated from two points read from it. **Calculus**: the theory recalls and uses the rules of calculus without teaching them; `Supplements/calculus.qmd` teaches them, with worked cases and a practice set, and the practical tells students to read it first if they need it. **Names and symbols**: Michaelis–Menten is the primary name of $ax/(b+x)$ and Holling type II is its predator–prey parameterisation; generic parameters $a,b,c,d$ are used for every function, with ecological symbols only for a specific parameterisation. **Units** are a thread of the worked examples and of the exercises. **Data**: real data are a backdrop and nothing is fitted (fitting is Chapter 6). The theory uses `emdbook::ReedfrogFuncresp` and `emdbook::ReedfrogSizepred`; the practical uses `Puromycin` (from `datasets`), `emdbook::FirDBHFec_sum` (`DBH` is in centimetres), `emdbook::MyxoTiter_sum` (the values were read from a published figure) and `emdbook::DamselRecruitment_sum`. **Practical**: Exercise 1 is worked on the student page, Exercises 2 to 5 are drills on paper (limits and end behaviour, derivatives and slopes, special points, parameters) and Exercises 6 and 7 are cases with real data, on paper and then in R. The function supplement closes with a short entry on functions without a closed form that names the Rogers random-predator equation, and says that the theta-logistic model is solved by the Richards function. A mechanistic derivation tells what the parameters would measure if its assumptions held, and a good fit does not show that they hold. An asymptote is a line that the curve approaches (a curve may cross it) |
| `Chapter_6` through `Chapter_8` | Generated course material; not rewritten by the author. Use for topic coverage, never as a model of voice. They predate the rewrite of Chapters 4 and 5, apart from the sentences that were corrected to match them (the "Information criteria" section of Chapter 6 recalls AIC from Chapter 4 and uses $K$; its introduction calls the Michaelis–Menten function by that name; and short links point back to the new material of Chapter 5 and to the function supplement). Where their terms differ from Chapter 4 (for example "quadratic interval" for the Wald interval, or `vapply()` for grids), follow Chapter 4 in new work. On 7 October 2026 (D10, D16) they received consistency fixes only: the first fit of Chapter 6 is written in the form of Chapter 4, Chapter 6 has the stopgap sections `#sec-makeadfun` (what RTMB calculates for `optim()`, with a collapsed technical detail box on automatic differentiation) and `#sec-delta-method`, its "quadratic interval" became "Wald interval", and the introductions and sentences of Chapters 7 and 8 that presented RTMB as new were reworded. Not converted: the practicals of Chapters 6 and 7 and the Chapter 7 theory still use `%~%`, one parameter list, data read from the workspace and `obj$he()`; Chapter 8 passes plain functions to `optim()` with `hessian = TRUE`; the learning goals of Chapters 6 and 7 keep the old format. The full rewrite of Chapters 6 to 8 is a separate plan |

On 7 October 2026 the author decided to introduce RTMB from Chapter 4 and its
distribution functions from Chapter 2 (plan: `.plans/plan_rtmb_early.md`, phases 0 to 8;
the status table of the plan records progress). Decisions, in compact form. **D1**: every
NLL takes named lists (`parms`, `data`) and uses `getAll()`; every fit goes through
`MakeADFun()`, including the first Poisson fit; no example passes a plain function to
`optim()`; the text says only that `MakeADFun()` processes the NLL and that details come
progressively. **D2**: `optim()` receives `gr = obj$gr` from the first fit, as a black box,
with a pointer to Chapter 6. **D3**: the helper `cmb = function(f, d) function(p) f(p, d)`
connects a likelihood to data (so that it can be calculated on other data with the same
variable names); do not explain lexical scoping or present it as an awkward part of TMB, and
do not answer questions that students may not have. **D4**: Negative Binomial as
`RTMBdist::dnbinom2(x, mu, size)`, with `library(RTMB)` before `library(RTMBdist)` and one
warning callout in Chapter 4 on the clash with `RTMB::dnbinom2(x, mu, var)`. **D5**: Chapter 4
uses `ADREPORT()` and `sdreport()` for the standard error of a derived quantity and says that
TMB applies the delta method, which Chapter 6 teaches. **D6**: each calculation that TMB does
is shown once by hand on the simplest case and then done with the TMB tool; the chapter
should not grow (2,857 source lines before). **D7**: data are marked with `OBS()`,
`obj$simulate()` draws each hypothetical experiment, a visible loop refits, and
`checkConsistency()` appears once (its p-value is not interpreted); coverage simulations keep
one extra fit at the generating value instead of `tmbprofile()` in every experiment. **D8**:
for the owl $k$, show the Wald interval on the original scale (from `ADREPORT()`), the Wald
interval on the log scale with endpoints transformed back (recommended), and the profile
interval (reference). **D9**: the worked Exercise 1 of the Chapter 4 practical shows both
routes, Exercise 2 one profile by hand checked with `tmbprofile()`, Exercises 3 to 5 the TMB
tools only. **D10**: Chapter 6 explains `MakeADFun()` and `obj$gr` (section
`#sec-makeadfun`) and the delta method (section `#sec-delta-method`, added on 7 October 2026
because the chapter had no passage on it); both are stopgaps until Chapters 6 to 8 are
rewritten, and pointers from earlier pages link to these two IDs. By the author's decision of
the same day, the first fit of Chapter 6 goes through `MakeADFun()` like every other fit (no
comparison with a plain function given to `optim()` without `gr`), and students only need to
know that RTMB calculates the gradient of the NLL accurately: the tape and the mechanics of
automatic differentiation sit in a collapsed "Technical detail" box, and the main text does
not use the word tape. **D11**: students still write
the zero-inflated Poisson mass function by hand and verify it against `dzipois()`. **D12**:
`reltol` is dropped everywhere. **D13**: Chapters 2 and 3 (theory and practicals) load RTMB and
RTMBdist from the first probability calculation, with one sentence at the first `library()`
call and nothing about TMB; their status stays reviewed and approved, with the note that the
code was converted on the date of the change and awaits a quick check. **D14**: densities and
mass functions always come from RTMB or RTMBdist, and where a cumulative, quantile or random
function is missing, base R, MASS or a hand-written line fills in and the entry says so; the
summary blocks keep the current symbols. **D15**: pages outside Chapters 6 to 8 are audited
and the glossary updated; `Supplements/canned.qmd` is left alone (a new supplement on
`glmmTMB` will replace it). **D16**: Chapters 6 to 8 get consistency fixes only. **D17**: the
Chapter 1 practical has a step that installs the course packages. The Chapter 4 row above
describes the state before this rewrite and is superseded where it conflicts with these
decisions. The duplicated `Chapter_3/Practicals` row in the table is an existing defect and
was left as it is (both copies received the same edit on 7 October 2026). The plan was carried out on
7 October 2026 in phases 0 to 8 (status table and reports in `.plans/plan_rtmb_early.md`); the Chapter 4 row,
the supplement row and the rows of Chapters 2, 3 and 6 to 8 above describe the result.

Also on 7 October 2026 the theory pages of Chapters 1 to 4 were checked against the section
"Presenting code in the text" of `STYLE_GUIDE.md`. Chapter 1 needed no change (its chunks
are hidden figures). In Chapters 2 to 4 chunks that held several steps were split, with the
sentences of each step placed before its chunk, the arguments and results of `integrate()`,
`uniroot()`, `sdreport()` and of the route from the Hessian to standard errors became
bullets, and numbers that only repeated the printed output were removed from the text. The
R code did not change, apart from comments and the order of two independent calculations in
"The fitted model" of Chapter 4 (the fraction of visits without calls now comes before the
log-likelihoods). The author's passage on `cmb()`, `MakeADFun()` and `optim()` was not
touched. The reworded sentences are generated text that awaits the author's check; the
Chapter 4 theory now has 3,146 source lines. Supplements, practicals and Chapters 5 to 8
have not been checked against this rule.

On 7 October 2026 the author requested that `Supplements/canned.qmd` become a bridge
from the course's TMB methods to `glmmTMB`, covering only linear and generalised linear
models and their mixed-effects versions. Bayesian methods, non-linear model sections,
and the survey of other fitting packages were removed. The rewritten supplement
connects formulae to observation models and the familiar calculations (marginal
likelihood, profile intervals, delta-method prediction errors, information criteria,
and simulation); it is a generated draft awaiting the author's review. This replaces
the earlier D15 decision to leave `canned.qmd` alone. Its existing filename and
navigation are retained. The same day the draft was checked against the installed
`glmmTMB` (1.1.15) and the style guide: all chunks run and the page renders with the dev
profile. Corrections: for a Normal model `dispformula` describes the logarithm of the
residual standard deviation (the draft said the variance); `ADREPORT()` and `sdreport()`
are attributed to Chapter 4 and the delta method to Chapter 6; the front matter holds only
the title; data-preparation lines that changed nothing were removed (the page uses
`InsectSprays` and `Salamanders` directly, and `relevel()` appears once, for the penguins);
chunks have comments. At the author's request the supplement was added to
`_quarto-prod.yml` (render list and sidebar, after the glossary), so the production build
now renders five supplements; `glmmTMB` is already in `publish.yml`, and the `DHARMa` chunk
of the page is not evaluated. The paragraph of `index.qmd` that describes this supplement
was reworded to match (it described a survey of packages); it is generated text in the
author's first person and awaits the author's check.

Also on 7 October 2026 the author stated the two objectives of the course, which
`Chapter_1/Theory.qmd` now lists in "Overview of the book": (1) to teach likelihood-based
inference in theory and in implementation, so that students understand tools like
`glmmTMB` better, and (2) to teach how to build non-linear (mixed) models and apply to
them the same type of analysis that one would use with `glmmTMB`. The roadmap of Chapter 1
ends with an entry "Supplement: Formula-based methods". Both passages are generated text
on the author's instruction and await the author's check; the rest of Chapter 1 remains the
author's text.

Also on 7 October 2026 the author removed the `### Example:` subsections, the figures and
the `Practice` callouts from `Supplements/deterministic-functions.qmd`, because the
ecological justification of some of them was poor and no data set supported others. An
entry now has a summary block, the paragraphs on uses and the formula with its landmarks;
do not add examples, figures or exercises back. The page states that it is derived from
Chapter 3 of Bolker's *Ecological Models and Data in R* (the draft chapter is
`.plans/chap3A.pdf`), and the author trusts that source: a statement about how a function
is used may rest on that chapter without further verification, and any other such
statement needs a citation that was checked. The same day every usage paragraph was
checked against that chapter and, where the chapter is silent, against the publications.
Most entries needed no change. Changed (generated text awaiting the author's review): the
quadratic entry (species abundance along a gradient, ter Braak and Prentice 1988, and
stabilising selection, Lande and Arnold 1983, replace an example without a source); the
bell-shaped entry (Gauch and Whittaker 1972, ter Braak and Prentice 1988 and Angilletta
2006 added); the Michaelis–Menten entry (the Monod equation is empirical, so the entry no
longer says that the function is mechanistic in every use); the Hassell entry (discrete
generations, not one generation per year, and the derivation of Brännström and Sumpter
2005); the hockey stick entry (Brännström and Sumpter 2005 only name the ramp function);
and citations added to the Holling type III (Hassell et al. 1977), exponential (Olson
1963) and Shepherd (Shepherd 1982) entries. The paragraph of the page that lists the parts
of an entry was shortened to match. The hidden chunk that loads `ggplot2` is still on the
page, although no figure uses it.

The author requires `=` for all R assignment throughout the course, including
function definitions. Apply this rule to existing and new code. The references contain occasional
typos, inconsistent formatting, and stale cross-references; preserve the teaching
approach without treating those defects as conventions. For beginner-facing
examples, prefer ordinary numeric literals and `NA` over typed literals such as
`2L` and `NA_real_`, unless the distinction is part of the lesson. Add short
explanatory comments to R chunks so students can follow the purpose of groups
of lines and new programming operations.

Every chapter should begin with `# Introduction`, whose first sentence starts
with “In this chapter, we learn how to...”, followed by `# Learning goals`.
List learning goals in the order in which the chapter develops them. Every
theory chapter ends with `# Summary` before `# Chapter quiz`. The author has
also decided on British spelling throughout, capitalised distribution names
(Binomial, Normal, LogNormal), and a formal tone from Chapter 2 onward, with
Chapter 1 as the only personal, candid chapter; details are in `STYLE_GUIDE.md`.

## Responsibilities

Apply these roles as needed within the task; they do not require separate agents.

- **Teaching collaborator:** Introduce the general concept before applying it
  to an ecological example. Connect the question, equations, code, and
  interpretation while keeping the student's prerequisites in view.
- **Statistical reviewer:** Check assumptions, support, parameterization, likelihood
  definitions, and interpretations of uncertainty. Distinguish exploratory evidence
  from conclusions justified by the model.
- **R and Quarto editor:** Produce readable, reproducible examples and preserve
  document execution settings, includes, links, and solution visibility.
- **Copy editor:** Use the author's direct, conversational teaching voice. Remove
  repetition and correct local language problems without making prose needlessly
  formal or expanding the requested scope.

The priority section on the author's voice in `STYLE_GUIDE.md` is the prose
standard when revising existing material and writing new material. It takes precedence over generic
textbook concision, while scientific accuracy and the course's stated scope
remain mandatory.

## Teaching scope and progression

- Keep maximum likelihood and ecological interpretation at the centre of the
  course. Build understanding of explicit probability and likelihood functions
  before relying on formula-based fitting interfaces.
- When motivating ecological models, explain how interpretable response
  parameters, model comparison, and explicit observation models can answer
  questions beyond a zero-effect test. Acknowledge that standard regression and
  mixed models remain useful, and connect these skills to prediction and
  uncertainty without expanding the course into forecasting methods.
- The current progression is R foundations (Chapter 1), probability
  distributions for discrete and continuous data (Chapter 2), samples,
  estimation and sampling distributions (Chapter 3), maximum likelihood
  (Chapter 4), deterministic functions (Chapter 5), fitted ecological response
  curves (Chapter 6), grouped response curves (Chapter 7), and numerical
  optimisation (Chapter 8). Verify chapter details against
  `Chapter_1/Theory.qmd` and the actual files before referring students to them.
- Chapter 2 ("Probability distributions") is about the distributions
  themselves. The author decided that everything about how samples relate to
  distributions (relative frequencies, empirical distributions, histograms,
  kernel density estimates, `ecdf()`, convergence with sample size) lives in
  Chapter 3 ("From samples to estimates"), where samples are used. Do not move
  that material back into Chapter 2. Overdispersion, with the dispersion-ratio
  diagnostic, stays in Chapter 2 with a forward pointer to Chapter 3 for what a
  sample variance is.
- Chapter 2 covers joint and marginal distributions and independence, for
  discrete and continuous variables. Conditional distributions are not
  introduced there; the author assigned them to the grouped-curves chapter
  (Chapter 7), which has not yet received them. Chapter 4 also points to Chapter 7 for
  restricted maximum likelihood (REML), which Chapter 7 does not cover yet.
- Contour plots with `outer()` and `contour()` are taught in base R in the
  Chapter 1 practical, so later chapters can use them without introduction.
- Plots follow two rules, decided by the author on 6 October 2026. The author's own
  figures (theory pages and supplements) use `ggplot2` with `theme_classic()` and the
  palette of `STYLE_GUIDE.md`. Plots inside exercises (the practicals from Chapter 2
  onward, student page and solutions, and the `Practice` callouts) use simple base R
  graphics, so that students do not spend their time on visualisation. The Chapter 1
  practical teaches both systems and keeps both. The practicals of Chapters 4 and 5
  and the entry figures of `Supplements/distributions.qmd` were converted to this
  rule on 6 October 2026. Exceptions that the author decided to keep: the figure with
  `theme_bw()` in the Chapter 3 theory, and the two starting-value figures of the
  Chapter 5 theory, which stay in base R (`plot()` with `curve()`).
- Chapter 5 contains no statistics: it is about deterministic functions and their
  mathematical properties, and it prepares Chapter 6, where the functions are combined
  with distributions and fitted. Detailed descriptions of functions live only in
  `Supplements/deterministic-functions.qmd` (as for distributions), and the rules of
  calculus live only in `Supplements/calculus.qmd`; theory pages, practicals and later
  chapters link to their entries by `sec-fn-` and `sec-calc-` IDs. Starting values read
  from a plot, composition to enforce a range, nested functions and partial
  derivatives with respect to parameters belong to Chapter 5. This is an author
  decision.
- Chapter 4 introduces model comparison with AIC (`#sec-aic`). Chapter 6 recalls
  it and adds BIC, cross-validation, and goodness of fit. Point promises about formal
  model comparison to Chapter 4 and Chapter 6 accordingly. Chapter 4 uses the delta
  method through `ADREPORT()` and `sdreport()`; Chapter 6 explains it. Bounds on parameters, `optimize()`, scaling, the sensitivity of a fit
  to its starting values, local maxima, Hessian problems, and the effect of
  parameterisation on optimisation belong to Chapter 8; Chapter 4 only uses
  transformations and points forward.
- Exercises may use real data sets shipped with R packages (for example `InsectSprays`
  and `Owls`), loaded with `data(name, package = "pkg")`; add the package to the
  dependency list in `.github/workflows/publish.yml` (`RTMBdist` and `TMB` were added
  there on 7 October 2026, because the course loads RTMB and RTMBdist from Chapter 2
  onward and uses `TMB::tmbprofile()`; `VGAM`, `gtools` and `COMPoissonReg` were removed
  the same day, because no page loads them any more). The same applies to any package
  loaded in a rendered page (including `Supplements/distributions.qmd`, which needs
  `RTMB`, `RTMBdist` and `MASS`), because the production build fails if one is missing.
  The production build renders Chapters 1 to 5 and the four supplements only, so it needs
  `MASS`, `ggplot2`, `patchwork`, `dplyr`, `RTMB`, `RTMBdist`, `TMB`, `quarto`, `glmmTMB`,
  `boot`, `emdbook`, `knitr` and `rmarkdown`; `DHARMa`, `DEoptim` and `GA` stay in
  `publish.yml` for Chapters 6 to 8, which only the dev profile renders.
  `emdbook` is in `publish.yml` because the Chapter 4 practical and the Chapter 5
  theory and practical load its data (Chapter 5 also uses `Puromycin` from base R's
  `datasets`; the Chapter 5 pages need no other package). `boot` is in `publish.yml`
  because the Chapter 3 and Chapter 4 theory load `fir`, and `glmmTMB` because the
  Chapter 2 theory loads `Salamanders`; the theory of Chapters 2 and 3 and the practicals
  of Chapters 2 and 4 use `penguins` of `datasets`, which needs R 4.5.0 or later (a
  footnote at the first use says so).
  Before Chapter 7 the course treats
  grouped or nested observations (visits to the same nest, neighbouring quadrats, visits
  to the same stream site) as i.i.d.; the exercise says
  that this is a simplification and points to Chapter 7. This is an author decision.
- Use simulation to connect known model parameters to samples, estimates, and
  repeated-sampling behaviour. Introduce unfamiliar R tools when they are needed.
- The course is about non-linear models with non-Normal distributions, so teach
  results that hold in general and present special cases as special cases. For
  finite samples, estimators are in general biased and the shape of their sampling
  distribution is unknown; exact results (for example the $t$ interval for the mean
  of Normal observations, or $\operatorname{Var}(\bar X)=\sigma^2/n$) exist only
  for a few estimators and models. Confident statements about bias, variance,
  standard errors and confidence intervals hold for large samples (asymptotically);
  for small samples present them as approximations and use simulation to check
  them. Do not teach a Normal-only result as if it were general. This is an
  author decision.
- Describe the sampling distribution as the distribution of an estimate across
  repeated hypothetical experiments: an imaginary process that is never observed.
  Keep it distinct from the replicates (for example quadrats) within one
  experiment. This is an author decision.
- Retain method of moments as a bridge to estimation. Do not replace the course's
  likelihood focus with hypothesis testing, p-values, Bayesian inference, or a
  survey of modelling packages unless the author requests that change.
- The course does not work with dynamical models. When motivating probability,
  emphasise observation error, parameter uncertainty, and process variation.
  Summarise initial-condition, driver, scenario, and numerical uncertainty as
  wider forecasting applications without developing dynamical-model methods.
- Exercises should ask students to calculate, simulate, plot, compare, and explain.
  Solutions should explain why the code answers the ecological question.
- Support AI use as tutoring that helps students understand and debug their work;
  keep responsibility for scientific interpretation with the learner and author.

## Repository workflow

1. Identify the requested scope and the relevant source files. Preserve unrelated
   author changes, including ongoing moves and deletions.
2. Check the surrounding concepts and consult the style guide. Resolve routine
   editorial choices autonomously; ask only when a substantive ambiguity would
   change the scientific meaning or course scope.
3. Edit source `.qmd` files. Chapter 1 exclusively uses shared
   `Practicals/material.qmd` with `solution.qmd` and `no_solution.qmd` wrappers.
   From Chapter 2 onward, each practical must be self-contained: both
   `solution.qmd` and `no_solution.qmd` contain their relevant text and code.
   Do not introduce shared `material.qmd` files in later chapters.
   Quarto settings shared by every build belong in `_quarto.yml`; complete render
   and sidebar lists belong in the mutually exclusive `_quarto-dev.yml` and
   `_quarto-prod.yml` profiles, so profile merging cannot duplicate navigation.
4. Keep exercises and solutions aligned in numbering, data, notation, and learning
   goals. A deliberately worked example may appear on the student page: by
   author decision the Chapter 2 practical starts with two worked exercises
   (seedlings under a Binomial model, bill length of Chinstrap penguins under a Normal model),
   followed by four exercises for students to solve. The Chapter 4 practical
   follows the same pattern: Exercise 1 is worked on the student page, followed by
   four exercises. Do not remove the worked exercises automatically.
5. Check new or changed mathematics and code against the accompanying explanation.
   For computational changes, run focused R checks when available. For changes to
   includes, metadata, or solution visibility, render the affected wrappers when
   available and inspect both versions. Documentation-only edits need a source
   review, not a full site build. Respect any user limits on execution.
6. Report what changed and which checks actually ran. Clearly identify unverified
   numerical claims or unavailable tooling; never claim a successful render or
   execution without performing it.
7. After making any course-content or repository-guidance change, review
   `AGENTS.md` and update it when the change establishes new progress, a durable
   convention, a file-structure rule, or an author decision. Report whether it
   was updated or confirmed unchanged.

Do not edit generated HTML, cache files, or vendored extensions to change course
content. Do not install packages during rendering. Preserve source attribution
and existing credits; do not invent citations, datasets, numerical results, or
claims of human review. Check external technical claims against primary sources
when needed, without turning routine local editing into unnecessary research.

## Maintaining these instructions

Keep durable collaboration instructions here and concrete style patterns in
`STYLE_GUIDE.md`. Record new author decisions there when requested or when they
clearly establish a lasting convention. Do not treat an isolated exception or an
unreviewed generated passage as a new course-wide rule.
