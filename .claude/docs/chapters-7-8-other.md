# Decisions: Chapters 7 and 8, lectures and other

Moved from AGENTS.md. Read this before working on the pages it covers; AGENTS.md points here.

### Lectures

The Chapter 3 lecture has no live demos (author's decision of 30 October); the Chapter 2
lecture has three, each Chapter 4 lecture has one of 18 minutes from a standalone
script, `demo-profile.R` and `demo-properties.R`, and the Chapter 6 lecture has one of 18
minutes from `demo-cycle.R` (author's decisions of 3 November), and the Chapter 7
lecture has one of 18 minutes from `demo-pooling.R` (author's decision of 4 November:
complete, no and partial pooling, origin and chilling, the shrinkage plot and curves for
new plants; no model comparison), and the Chapter 8 lecture has one of 18 minutes from
`demo-diagnosis.R` (author's decision of 4 November: a fit of the complete-pooling CO₂
model that stops in the wrong place from a poor start; convergence code, estimates,
gradient and `sdreport()`; multiple random starts; a BFGS restart from the best; a slice
and a likelihood profile to confirm; no comparison of optimisers). Slides state the general definition, rule or property
and then the result for the example, never the example alone (author's decision of 30
October), and the main takeaways stand on the slide, not only in the script (author's
decision of 3 November). The rules are in `STYLE_GUIDE_LECTURE.md`.

### Chapter 7

Rewritten from scratch on 4 November (theory, practical, one lecture) to the author's
decisions of that day; the plan with every number checked is `Chapter_7/rewrite-handoff.md`,
which stays until the author removes it.

- **One running example in the theory:** CO₂ uptake of 12 plants of *Echinochloa
  crus-galli* (`datasets::CO2`; Potvin, Lechowicz and Tardif 1990): two origins (Quebec,
  Mississippi) × two treatments (chilled, non-chilled) × three plants × seven
  concentrations. The group is the plant. Units: concentration in µL/L and uptake in
  µmol/m²/s (`attr(CO2, "units")`); a footnote says that the help page's mL/L is wrong.
  `CO2` is converted with `as.data.frame()` and the plant index is built explicitly.
- **Curve and random effect:** the saturating exponential shifted along $x$,
  $\mu(x)=a\left(1-e^{-b(x-c)}\right)$, with a Normal observation model and one random effect
  on the logarithm of the asymptote, $a_j=a\,e^{u_j}$,
  $u_j\sim\operatorname{Normal}(0,\sigma^2_{\mathrm{plant}})$ (a random rate adds little and
  is not used). Story: complete pooling, no pooling, partial pooling, then origin and
  chilling as fixed effects on the log asymptote **as contrasts with an interaction**
  (baseline Quebec non-chilled); a callout explains that the effects of groups can be
  encoded as one mean per group or as a baseline plus effects (the same model; the second
  quantifies differences directly).
- **Conditional distributions** are a short general section: Chapter 2's two-seed table,
  the continuous case, the model $Y_{ij}\mid u_j$ and the marginal distribution as an
  integral. One paragraph without code says that the Beta-Binomial of Chapter 6 is a
  marginal distribution of the same kind, with a closed form.
- **Marginal likelihood and the Laplace approximation:** intuition in the text, a hidden
  figure of the integrand of one plant (Mc2) with its Normal-shaped approximation, the
  formula in a statistical detail box, RTMB's `random` doing the calculation; no integral in
  a visible chunk. Terms: fixed effects, random effects, mixed-effects (hierarchical,
  multilevel) model, variance components, **predicted group effects** (the conditional
  modes; never called estimates), shrinkage, partial pooling; "population" is not used for
  the distribution of group effects.
- **REML:** a short section with code (every parameter of the curve added to `random`),
  the link to the $n-1$ of Chapter 3, and two cautions: approximate for non-linear or
  non-Normal models; models with different fixed effects are compared with ML fits. This
  keeps the promise of Chapter 4's footnote (now linked to `#sec-reml`).
- **After the fit, four topics:** DHARMa residuals from `obj$simulate()`, which redraws the
  plant effects (unconditional simulation; conditional simulation named once), per
  observation and per plant with `recalculateResiduals(group = ...)`; the curve of an
  observed plant against the range of new plants ($a\,e^{\pm1.96\,\sigma_{\mathrm{plant}}}$ at
  the estimates, without the uncertainty of the estimates); AIC on the marginal likelihood
  ($K$ counts the variance parameters, not the random effects); leave-one-plant-out
  cross-validation, scoring the held-out plant by its marginal log-likelihood through `map`.
- **AICc and BIC are not used for grouped models**, because $n$ lies somewhere between the
  number of groups and of observations. **No pooling is excluded from the comparison**,
  with one paragraph: its lower AIC describes new measurements of the same 12 plants, the
  marginal likelihood a new plant, and leave-one-plant-out cannot score it. No conditional
  AIC.
- Three numbered `Practice` callouts, a roadmap table after the learning goals and a recipe
  callout (nine steps) before the summary; one sentence and a link to `canned.qmd` for
  formula-based tools, no `glmmTMB` in the theory. The page has about 2,070 lines, above
  the target of 1,900; Stage 4 found nothing to cut without losing a required part (the
  author decides).
- **Practical:** five exercises, each keeping a promise of an earlier chapter: Exercise 1
  (worked) loblolly pines (`Loblolly`, the same curve as $A(1-e^{-k(t-t_0)})$, random
  asymptote per tree, all four checks); 2 reed frog tanks (`emdbook::ReedfrogPred`, random
  effect on the logit per tank against the Beta-Binomial; typical against mean survival);
  3 owl nests (`glmmTMB::Owls`, Negative Binomial with a random effect per nest, predicted
  nest effects against a no-pooling fit); 4 salamander sites (`glmmTMB::Salamanders`,
  Poisson with a random effect per site, refitted with `glmmTMB::glmmTMB()`, called with
  the prefix because attaching it masks functions of RTMBdist); 5 (extra) a simulation of
  the variance among groups by ML and REML. The solutions page links to the worked
  Exercise 1. Every question of Exercises 2 to 5 ends with a hint that names the section of
  the theory (or of Chapter 6) that it needs, as in the Chapter 6 practical, and the
  questions name every quantity that the solution reports; `tapply()` is introduced in the
  worked Exercise 1 (question 5) and reused later (student-perspective review of
  4 November). To fit the core into about 6 hours (author's decision of 4 November):
  Exercise 3 has three questions, and the range of new nests is one number in its question
  2 (no plot of curves); question 3 of Exercise 4 reports the dispersion statistic and the
  site residuals without a residual plot; the code of the plot of tank effects (Exercise 2,
  question 5) is given below the questions. Leave-one-group-out cross-validation is not
  practised in the practical.
- **Lecture:** one of 150 minutes (31 slides, 116 minutes of slides, 14 of slack, two
  breaks of 10) with the demo above.
- The simulated `shapes*.csv` files were removed with the `Data/` folder that held only
  them (author's decision of 4 November); no page used them after the rewrites of Chapters
  6 and 7. Apart from `Chapter_1/Practicals/seedpred.csv`, the course data come from R
  packages.

### Chapter 8

Rewritten from scratch on 4 November (theory, practical, one lecture) in seven stages to the
author's decisions of that day, with an independent review (Stage 4) because the author did
not review between stages. The plan with every number checked is
`Chapter_8/rewrite-handoff.md`, which stays until the author removes it. A draft until the
author reviews it.

- **No new data in the theory:** every difficulty is shown on a model that students already
  fitted. The main thread is the complete-pooling CO₂ model of Chapter 7 (`pooled_nll`),
  which stops in three wrong places from plausible starts (a ridge with the rate towards
  infinity, a curve at zero, an early plateau near a saddle point). The reed frog functional
  response of Chapter 6 gives the search paths and the estimates at a boundary, the owl calls
  of Chapter 4 the effect of parameterisation, the fir counts of Chapter 4 `optimize()`; the
  model with a random asymptote of Chapter 7 appears in one paragraph. No threshold or
  change-point model, no example with several maxima built for the purpose, no simulated data
  in the theory. Object names are those of the chapter whose model is revisited.
- **Organised by problem in five sections:** a fit that stops in the wrong place
  (`#sec-wrong-place`, with `#sec-search`, `#sec-gradients`, `#sec-stopping`,
  `#sec-diagnosis`); starting values and multiple starts (`#sec-multistart`); ridges,
  boundaries and identifiability (`#sec-identifiability`, with `#sec-boundaries`); scaling and
  parameterisation (`#sec-scaling`); other optimisers and global search
  (`#sec-other-optimisers`, with `#sec-global`). Each opens with the general difficulty, shows
  it on an earlier fit, explains the mechanism as far as needed, and gives the remedy. Roadmap
  table, three numbered `Practice` callouts, a recipe callout, summary and quiz, as in
  Chapters 6 and 7.
- **Concepts only, no algorithm coded by hand:** Newton's method, the BFGS update, finite
  differences and differential evolution are explained in words and figures, with formulas in
  detail boxes and no R chunks; every algorithm is called from an R function. Hidden chunks
  may record the path of an optimiser for a figure or check a claim with `obj$he()`.
- **Algorithms:** BFGS with RTMB's gradient stays the method of the course; `nlminb()`
  (glmmTMB's default), Nelder–Mead, `optimize()` for one parameter, multiple starting values,
  and differential evolution with `DEoptim::DEoptim()` as the one global method, always
  followed by BFGS from its best member. Other optimisers receive `obj$fn` and `obj$gr` of
  the same `MakeADFun()` object. SANN and genetic algorithms are named in one sentence and not
  used.
- **"A convergence code of zero does not mean the maximum"** is stated once, in the warning
  callout of `#sec-stopping`; the diagnosis (estimates, gradient, `sdreport()` with
  `pdHess`, a refit, a slice) is the answer. `reltol` is named with its default but never set;
  `parscale` is shown once. The Hessian check is `sdreport()`; positive definiteness and
  eigenvalues are in a box.
- **Identifiability** in full: structural (a common log asymptote plus 12 free deviations)
  and practical (the CO₂ measurements at 250 µL/L and above, with likelihood profiles of
  $c$). **Bounds are only mentioned** (L-BFGS-B and `nlminb()` accept them; the course keeps
  transformations); the only `lower` and `upper` in code are the box of `DEoptim()`.
- **Practical:** three exercises, each a full diagnosis (symptom, diagnosis, remedy,
  confirmation) of a fit: Exercise 1 (worked) the loblolly pines of Chapter 7 with a poor
  start; 2 a Gamma fit to the Adelie masses in grams, new in Chapter 8 since the Chapter 4
  practical dropped its penguin questions (author's decision of 4 November; the relative
  stopping rule; units, the mean–shape parameterisation and `nlminb()` as remedies); 3 the
  REML simulation of Chapter 7 (which practically zero variances among sites are maxima),
  with the closed form of the balanced Normal design labelled as a special case. Seeds:
  theory 801 and up, practical 811, 812, 751 and 831. The practical tells students to
  install DEoptim once. Every question names the theory section it needs (a hint in
  Exercises 2 and 3, "See ..." in the worked Exercise 1), linking to `#sec-parameterisation`,
  `#sec-local-optimisers` and `#sec-recipe` among others (student-perspective review of 4
  November). To fit the practical into about 3 hours (author's decision of 4 November):
  Exercise 2 has four questions without the gradient at the starting values (the zero slope
  in $\log(r)$); question 4 explains the remedies (threshold in kilograms, correlation
  0.996 against practically zero) and does not ask about invariance; Exercise 3 has three
  questions, refits only from 10 random starts drawn with `runif()` between σ = 0.1 and 10
  (no `nlminb()`, which Exercise 2 practises), and the bias of REML is one sentence in
  question 3, not a question.
- **Lecture:** one of 150 minutes (31 slides, 116 minutes of slides, 14 of slack, two
  breaks of 10) with the demo above.
- **Awaiting the author:** the theory has about 1,940 source lines against a target of
  1,600 (the candidates for cutting are listed in the handoff). The script notes that a
  `reltol` of $10^{-12}$ lets the early-plateau fit reach the maximum; the chapter makes no
  claim about it.
- Technical difficulties of optimisation appear in Chapter 7 only as examples, with a
  pointer to Chapter 8 and no mechanics (author's decision of 4 November); Exercise 5 of the
  Chapter 7 practical points to Exercise 3 of the Chapter 8 practical.

### Other

- The Chapter 1 practical has a step that installs the course packages, and it teaches
  contour plots with `outer()` and `contour()` in base R, so later chapters use them
  without introduction.
- Figures that the author decided to keep outside the plotting rules: the `theme_bw()`
  figure of the Chapter 3 theory and the two starting-value figures of the Chapter 5
  theory (base R, `plot()` with `curve()`). Awaiting the author's confirmation: the DHARMa
  residual plots of Chapter 6 (theory and lecture) are the package's own base-graphics
  plots, shown with visible code because the tool is the lesson.
- The glossary was updated for RTMB and for the terms of Chapter 8 (optimisers, stopping
  rule, identifiability, scaling and others).
- **Numbered practice callouts** (author's decision, issue 8): the `Practice` callouts of
  the theory pages of Chapters 2 to 8 are numbered per page ("Practice 3"), so that
  students' scripts and the lectures can refer to them; the chapter number is not shown
  on the page and is added by hand when a reference must be unique across the book. The
  supplements are not numbered. The Chapter 2 lecture (slides,
  script and handoff) names the callouts by number; `lecture-script.pdf` was not
  regenerated. The pattern is in `STYLE_GUIDE.md`.

