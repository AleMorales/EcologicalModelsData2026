# Decisions: Chapters 7 and 8, lectures and other

Moved from AGENTS.md. Read this before working on the pages it covers; AGENTS.md points here.

### Lectures

The Chapter 3 lecture has no live demos (author's decision of 30 October); the Chapter 2
lecture has three, each Chapter 4 lecture has one of 18 minutes from a standalone
script, `demo-profile.R` and `demo-properties.R`, and the Chapter 6 lecture has one of 18
minutes from `demo-cycle.R` (author's decisions of 3 November), and the Chapter 7
lecture has one of 18 minutes from `demo-pooling.R` (author's decision of 4 November:
complete, no and partial pooling, origin and chilling, the shrinkage plot and curves for
new plants; no model comparison). Slides state the general definition, rule or property
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
  Exercise 1.
- **Lecture:** one of 150 minutes (31 slides, 116 minutes of slides, 14 of slack, two
  breaks of 10) with the demo above.
- `shapes1.csv` is no longer used; the `shapes*.csv` files in `Data/` are used by no page
  and stay until the author decides.

### Chapter 8

- It predates the rewrite of Chapters 4 to 7 and received consistency fixes only; the
  full rewrite is a separate plan. Where its terms differ from Chapters 4 to 7, follow
  those chapters in new work. Chapter 8 passes plain functions to `optim()` with
  `hessian = TRUE`, carries a page-level `format` and `execute` block and display-only
  fences.
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
  the theory pages of Chapters 2 to 7 are numbered per page ("Practice 3"), so that
  students' scripts and the lectures can refer to them; the chapter number is not shown
  on the page and is added by hand when a reference must be unique across the book. The
  supplements and Chapter 8 are not numbered yet. The Chapter 2 lecture (slides,
  script and handoff) names the callouts by number; `lecture-script.pdf` was not
  regenerated. The pattern is in `STYLE_GUIDE.md`.

