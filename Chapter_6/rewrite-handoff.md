# Handoff: rewrite of Chapter 6 (fitting ecological response curves)

This file tells future agents how to rewrite Chapter 6: theory, practical, one lecture, and the
cross-references and builds that depend on them. The scope, examples and structure below were
settled with the author on 3 November 2026. Do not change them without asking. Routine wording,
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
| 0 | Done on 3 November: the author's decisions and this plan | This file, one line in `AGENTS.md` | This file |
| **1** | Theory, part A: front matter to the end of "Uncertainty of a response curve" | `Chapter_6/Theory.qmd` | Part A renders and every number is checked in R |
| **2** | Theory, part B: checking, revision, comparison, recipe, summary, quiz | `Chapter_6/Theory.qmd` | The whole page renders in the dev profile |
| **3** | Practical: student page and solutions | `Chapter_6/Practicals/no_solution.qmd`, `solution.qmd` | Both pages render |
| **4** | Independent review of theory and practical (statistics, voice, code, numbers), with fixes | The three pages | A review report in "Progress log" |
| **5** | Lecture: figures, schematics, slides, demo script | `Chapter_6/Lecture/` | The deck renders and every slide was inspected |
| **6** | Lecture script and its PDF | `Chapter_6/Lecture/lecture-script.md`, `.pdf` | The script agrees with the slides |
| **7** | Integration: links and promises elsewhere, guidance files, production build, final report | Other pages, `AGENTS.md`, style guides, `_quarto-prod.yml` | Production render and the report to the author |

**Commits.** `CLAUDE.md` says: do not commit unless asked. Stages work on the working tree of
branch `chapter_6` without committing. If the author has authorised commits for this rewrite,
commit at the end of each stage with the message `Chapter 6 rewrite: stage N` and the attribution
lines of the session. Never push. Leave unrelated changes in the working tree alone.

**Launch prompt for a stage** (the author or an orchestrating session pastes it):

> Read `Chapter_6/rewrite-handoff.md` in full, then carry out Stage N exactly as it describes.
> Read the files that "Read first" lists for your stage before editing. Verify every number you
> write in R. When you finish, add your line to "Progress log", list any new question under
> "Open questions for the author", report what you changed and which checks ran, and stop. Do
> not start the next stage.

## Read first

Every stage reads, in this order:

1. `CLAUDE.md`, `AGENTS.md`, `STYLE_GUIDE.md`. The priority section on the author's voice and the
   sections "Presenting code in the text" and "Maximum likelihood with RTMB" are binding.
2. This file in full.
3. `Chapter_1/Theory.qmd`, sections "The modelling cycle" and "Chapter 6: Fitting ecological
   response curves" (the promises that Chapter 6 must keep, or that Stage 7 corrects).

Then, by stage:

- **Stages 1, 2 and 4:** `Chapter_4/Theory.qmd` in full (the reference for structure, depth, R
  pattern, statistical detail boxes, Practice callouts, the recipe and the quiz; it is the last
  chapter that was rewritten and shows how the author deals with complexity: principles over
  examples, no calculation by hand that a TMB tool does, short sections). `Chapter_5/Theory.qmd`:
  the introduction, "Phenomenological and mechanistic functions" (the disc equation),
  "Reparameterisation" (units of $\alpha$ and $H$), "Derivatives with respect to parameters",
  "Range and composition", "Nested functions", "Starting values by eye" and "Summary".
  `Chapter_2/Theory.qmd`, "Overdispersion". `Supplements/distributions.qmd`, the Binomial and
  Beta-Binomial entries. The current `Chapter_6/Theory.qmd` (to see what is replaced; do not copy
  its wording, which is generated and stale).
- **Stage 3:** the theory as Stages 1 and 2 left it; `Chapter_4/Practicals/no_solution.qmd` and
  `solution.qmd` (the reference for format, worked exercise, question headings and the skeleton
  of the extra exercise); `Chapter_5/Practicals/no_solution.qmd`, Exercises 1, 6 and 7 (where
  the same data were plotted and the curves placed by eye); the current Chapter 6 practical.
- **Stage 4:** everything that Stages 1 to 3 read, and the three new pages.
- **Stages 5 and 6:** `STYLE_GUIDE_LECTURE.md`; `Chapter_4/lecture-handoff.md` (the format of the
  slide plan, the lessons in its "Author's decisions" and "Progress log"); `Chapter_4/Lecture_2/`
  (`lecture.qmd`, `lecture-script.md`, `demo-properties.R`, `lecture-assets/figures.R`): the most
  recent deck, the reference for format, amount of text and demo; `Chapter_3/Lecture/lecture.qmd`
  (the author's own edits of format); the new Chapter 6 theory and practical.
- **Stage 7:** every file listed in "Stage 7" below.

## Author's decisions (3 November 2026)

**Examples and data**

- **One running example in the theory: the reed frog functional response**
  (`emdbook::ReedfrogFuncresp`, 16 tanks; `Initial` tadpoles per tank, from 5 to 100, and
  `Killed` in 14 days by three dragonfly larvae; Vonesh and Bolker 2005, cited as in Chapter 5).
  Chapter 5 used these data as a backdrop and read starting values by eye. No second data set in
  the theory, not even for the comparison of curves. The reed frog size experiment is not used in
  Chapter 6 (it stays in Chapter 5).
- **The simulated `shapes*.csv` files are no longer used by Chapter 6** (theory and practical).
  They stay in `Data/` because Chapter 7 uses `shapes1.csv`.
- **Parameterisation:** the Holling type II form of the disc equation (Chapter 5,
  "Reparameterisation"): the probability that a tadpole is killed in a tank with $N$ tadpoles is
  $p(N)=\alpha/(1+\alpha HN)$, so the expected number killed is the disc equation
  $\alpha N/(1+\alpha HN)$, a Michaelis–Menten curve with $a=1/H$ and $b=1/(\alpha H)$. $\alpha$
  (the attack rate, per experiment) is a probability and is optimised as $\operatorname{logit}(\alpha)$;
  $H$ (the handling time, experiments per tadpole killed) is positive and optimised as $\log(H)$.
  With this form $p(N)<1$ for every parameter value. Starting values from Chapter 5: $\alpha=0.5$,
  $H=1/60$. The $a,b$ form appears only to connect to Chapter 5 and in one sentence on
  correlation (0.98 in $a,b$ against 0.82 in $\alpha,H$).

**Content and story**

- **One modelling cycle on one data set:** Binomial model with the curve, fitted by maximum
  likelihood → uncertainty of the parameters and of the curve → simulation and scaled quantile
  residuals, which show overdispersion → Beta-Binomial model with the same curve → comparison of
  candidate models → interpretation.
- **Candidate models:** two curves (constant probability, i.e. $H=0$, nested in the Holling
  type II form; and Holling type II) crossed with two distributions (Binomial; Beta-Binomial,
  which approaches the Binomial as $\kappa\to\infty$): four models, all fitted to the same 16
  tanks.
- **Delta method: statistical detail box only** (author's decision), no calculation by hand in
  R. The confidence band of the curve comes from `ADREPORT()`. Where other pages promise that
  "Chapter 6 explains the delta method", Stage 7 changes the promise (see there).
- **Residuals: DHARMa only.** Simulate with `OBS()` and `obj$simulate()`, then
  `DHARMa::createDHARMa()` with the matrix of simulations. No hand-written quantile residuals. The
  author installed DHARMa on this machine on 3 November.
- **DHARMa's tests:** read the plots and the dispersion statistic (observed against simulated
  spread) as exploratory evidence. One sentence says that DHARMa also prints tests with
  p-values and why the course does not rest decisions on them (Chapter 1; the AIC paragraph of
  Chapter 4). Do not print a test object with its p-value in the theory.
- **Cross-validation: leave-one-out with the log score**: each tank is held out once, all
  parameters are refitted to the other 15, and the held-out tank is scored by its log probability;
  the score is the sum. No random folds, no seed. K-fold is named in one sentence. RMSE is not
  taught (Stage 7 corrects the Chapter 1 roadmap, which promises "predictive RMSE").
- **Information criteria:** AIC and AICc recalled from Chapter 4 (AICc matters here: $n=16$);
  BIC added. The number of observations $n$ is the number of tanks, not of tadpoles (one sentence
  why).
- **Coverage and bias by simulation: only in the practical's extra exercise.** The theory says in
  one sentence that a coverage check works as in Chapter 4. Stage 7 adjusts the Chapter 1 roadmap.
- **Automatic differentiation** stays in the theory as `#sec-makeadfun` (Chapters 5 and 8, the
  glossary and `distributions.qmd` link to it).
- **The `%~%` notation is not used** in Chapter 6 (theory or practical). Every NLL follows the
  `STYLE_GUIDE.md` pattern (two lists, `getAll()`, `cmb()`, `MakeADFun()`, BFGS).

**Practical**

- **Three core exercises and one extra**, all real data that the Chapter 5 practical used as a
  backdrop, now fitted: Exercise 1 (worked on the student page) myxoma virus titre with a Ricker
  curve; Exercise 2 `Puromycin`, Michaelis–Menten with Normal errors; Exercise 3 fir fecundity, a
  power law with Poisson and Negative Binomial models; Exercise 4 (extra) coverage and bias of a
  Wald interval of a quantity of the curve by simulation. Details under "Stage 3".

**Lecture**

- **One lecture of 150 minutes** (two breaks of 10), in `Chapter_6/Lecture/`, with **one live
  demo of 18 minutes** (2 at the slide, 16 in R) from a standalone script.
- **The demo shows the modelling cycle for one curve–distribution combination, with no model
  comparison:** the Binomial model with the Holling type II curve, from the fit to the residuals.
- **Production:** Stage 7 adds the theory, practical, solutions and lecture of Chapter 6 to
  `_quarto-prod.yml`.

## Choices I made within those decisions (the author may overrule them in review)

- **Size:** the theory stays below about 1,900 source lines (Chapter 5 has 1,800, Chapter 4
  2,760). A general statement and one result of the example; no detail of the reed frog
  experiment that does not support a general point (Chapter 4's rule "principles over
  examples").
- **Conditional distributions belong to Chapter 7** (`AGENTS.md`). The theory writes the model
  as $K_i\sim\operatorname{Binomial}(N_i,p(N_i))$ and says that the distribution of each
  observation depends on the known value of its predictor. It does not introduce the term
  "conditional distribution" or the notation $Y\mid x$ for it.
- **Figures:** the author's rules (ggplot2, `theme_classic()`, raw data blue, curves vermillion),
  hidden code, except the DHARMa residual plots, which are the package's own base-graphics plots
  shown with visible code because the tool is the lesson. Stage 7 records this exception in
  `AGENTS.md` ("Figures that the author decided to keep outside the plotting rules") marked as
  awaiting the author's confirmation.
- **Confidence band:** pointwise Wald intervals of $\operatorname{logit}(p(N))$ on a grid of
  densities from `ADREPORT()`, endpoints transformed back with `plogis()` and multiplied by $N$
  for the expected number killed. One sentence that the band is pointwise.
- **Profile intervals** for $\alpha$ and $H$ with `TMB::tmbprofile()` and `confint()`, and the
  maximum number killed per experiment, $1/H$, by transforming the endpoints of $H$ (a decreasing
  transformation swaps them).
- **Numbered `Practice` callouts** (`imp-` IDs), three or four, as in Chapters 2 to 5. Chapter 6
  is the first of Chapters 6 to 8 to use them; Stage 7 updates `AGENTS.md`.
- **Roadmap table** after the learning goals and a **recipe** callout before the summary, as in
  Chapter 4 (the recipe extends Chapter 4's eight steps; it does not repeat them word for word).
- **Stage 4 exists** because the author does not review between stages: a fresh agent who did
  not write the pages checks them.

## Rules that matter most

These come from the author's corrections of Chapters 3 to 5 and their lectures. They are in
`STYLE_GUIDE.md`, `STYLE_GUIDE_LECTURE.md` and `AGENTS.md`; they are repeated here because they
are the ones that generated text breaks most often.

1. **Definition first, example second.** Each section opens with the general concept in bold and
   general symbols ($\theta$, $x_i$, $Y_i$, "a parameter of the distribution"), then the reed frog
   case. Never open with the tanks.
2. **Principles over examples.** The example serves the general statement. Do not turn the reed
   frog tanks into a case study (no detail of dragonfly behaviour, of tank sizes, of the 14 days
   beyond what the units need).
3. **No calculation by hand that a TMB tool does:** no Hessian by hand, no delta method in R, no
   profile with a loop of inner fits, no `uniroot()` for interval endpoints. `sdreport()`,
   `ADREPORT()`, `TMB::tmbprofile()` with `confint()`, `obj$simulate()`.
4. **One step, one chunk, next to its explanation**; bullets for the items of a recipe (arguments
   and elements of output); do not repeat in the text a number that the chunk prints unless it is
   compared or interpreted.
5. **Voice:** no quips, no scene-setting hooks, no "X, not Y" reflex, one caveat where the risk
   is, provenance stated once, no first-person opinion invented for the author, no leaking of
   the authoring process. Formal register (Chapter 2 onwards). British English. Units with a
   slash ("tadpoles per tank" keeps "per", because a tank is a sampling unit).
6. **Notation:** $\log(x)$ with parentheses; $\operatorname{logit}(p)$; $K$ for the number of
   parameters in AIC; "likelihood profile", never "profile likelihood"; "hypothetical samples",
   never "experiments" for repeated sampling (the reed frog experiment itself stays an
   experiment); "model probability", "data generating process".
7. **R:** `=` for assignment, no pipes, `silent = TRUE`, `method = "BFGS"`, `gr = obj$gr`, never
   `reltol`, RTMB first and RTMBdist second, distribution functions from RTMB or RTMBdist inside
   an NLL, object names `<model>_obj`, `<model>_fit`, `<model>_sd`, `<model>_profile_<par>`,
   starting values simple and fixed in simulations, seeds set once before a batch.
8. **Never claim a render or execution that did not run.** Never invent a citation, data set or
   number; every footnote reference is checked (title, journal, year) before it is written.

## The theory (Stages 1 and 2)

Front matter: `title: "Fitting ecological response curves"` only (remove the `format:` and
`execute:` blocks; the global `eval: false` goes, so every chunk is evaluated unless it carries
`#| eval: false`). A first hidden chunk loads `ggplot2`, as in Chapters 4 and 5. Use
```` ```{r} ```` chunks only (no display-only ```` ```r ```` fences).

Keep these IDs, which other pages link to: `#sec-response-observation`, `#sec-fit-response`,
`#sec-makeadfun`, `#sec-delta-method`, `#sec-response-comparison`, `#sec-response-residuals`.
Stage 7 checks that the text around each link still describes what the section contains.

Below, each section has **General** (what the section states, in general terms; required) and
**Example** (what the reed frog data show; comes after). Object names are suggestions; once
Stage 1 chooses them, later stages keep them.

### Stage 1: part A

**`# Introduction`** (two paragraphs). Opens "In this chapter, we learn how to fit...": fit a
deterministic function as a parameter of a distribution (usually its mean) by maximum
likelihood, and then estimate the uncertainty, check the model against the data and compare it
with alternatives. Second paragraph: the two pillars (Chapters 2 to 4 and Chapter 5) come
together; what is new (the likelihood of a response curve, how RTMB calculates the gradient,
the uncertainty of a curve, residuals from simulation, BIC and cross-validation); the one
example (reed frog functional response, Vonesh and Bolker 2005, the data that Chapter 5 used
as a backdrop and for which it read starting values by eye); the distributions (Binomial and
Beta-Binomial); DHARMa named as the package for residuals. Chapter 7 adds groups.

**`# Learning goals`**: Chapter 2 format ("In this chapter, we will cover:" and short phrases
ending in semicolons, in the order of the chapter): a response curve as a parameter of a
distribution; the likelihood of a response curve and its fit; how RTMB calculates the gradient
of the NLL; standard errors, correlation and likelihood profile intervals of the parameters of a
curve; the uncertainty of the fitted curve; simulation from a fitted model and scaled quantile
residuals; a model for overdispersed proportions; model comparison with AIC, AICc, BIC and
leave-one-out cross-validation. Closing sentence: the Binomial and Beta-Binomial entries of the
distribution supplement, the Michaelis–Menten entry of the function supplement.

**Roadmap table** (as in Chapter 4: Step, Question it answers, In R; no column "Example" since
there is one example; caption "Roadmap of the chapter."). Rows: the model; the fit; the gradient;
uncertainty of the parameters; uncertainty of the curve; checking the model; revising the
observation model; comparison.

**`# From a response curve to a model for observations {#sec-response-observation}`**

- General: a **response curve** gives one parameter of the distribution of each observation as
  a function of a predictor, $\theta_i=f(x_i;\boldsymbol\beta)$; the other parameters of the
  distribution may be shared. The curve must return a value in the range of the parameter that
  it describes: a table (distribution, parameter that follows the curve, range, how to give a
  curve that range with a link to Chapter 5's `#sec-function-composition`) for Normal (mean, any
  value), Poisson and Negative Binomial (mean, positive), Binomial (probability, between 0 and
  1). The observations are treated as independent; their distributions differ because their
  predictors differ, which is what "identically distributed" no longer means. The observation
  model is a choice, like the curve (Chapter 2, "Choosing a distribution").
- Example: tanks $i=1,\ldots,16$; $K_i\sim\operatorname{Binomial}(N_i,p(N_i))$ with
  $p(N)=\alpha/(1+\alpha HN)$; why the probability and not the number killed follows the curve
  (Binomial needs a probability; the expected number killed $N\,p(N)$ is the disc equation of
  Chapter 5); units of $\alpha$ and $H$ from Chapter 5; the assumption that tanks are
  independent (one sentence).
- Figure `fig-curve_distribution` (new, hidden, ggplot2): the 16 tanks (blue points), the curve
  of the expected number killed with Chapter 5's values $\alpha=0.5$, $H=1/60$ (vermillion), and
  the Binomial probability mass at three densities (for example 10, 50 and 100) drawn as
  horizontal bars or points beside the curve, so that the student sees a distribution around
  the curve at each $x$. The caption says that the parameters are the values read by eye in
  Chapter 5.
- Practice callout (`imp-`): a short question on paper, for example which parameter of a
  Poisson model a curve of seedling counts against light should describe, and which range it
  must have.

**`# Fitting a response curve by maximum likelihood {#sec-fit-response}`**

- General: the log-likelihood is the sum over observations of the log probability (or density)
  of each observation, with the parameter of its distribution given by the curve at its own
  $x_i$: $\ell(\boldsymbol\beta)=\sum_{i=1}^n\log\left(P(Y_i=y_i\mid\boldsymbol\beta)\right)$.
  Everything of Chapter 4 applies: the NLL with two lists, transformations, `cmb()`,
  `MakeADFun()`, `optim()`, convergence. What is new: the data list holds the predictor as well
  as the response; starting values for the parameters of the curve are read from a plot
  (Chapter 5, "Starting values by eye").
- Example: chunk 1, load RTMB and RTMBdist (`#| message: false`) and the data
  (`data(ReedfrogFuncresp, package = "emdbook")`). Chunk 2, the NLL `binomial_nll` (or a
  similar name) with `logit_alpha`, `log_H`, `getAll()`, `plogis()`, `exp()`, `dbinom()`. Chunk
  3, `cmb()`, `MakeADFun()` from $\operatorname{logit}(0.5)$ and $\log(1/60)$, `optim()`,
  convergence. Chunk 4, estimates on the original scale: $\hat\alpha\approx0.526$ per
  experiment, $\hat H\approx0.0166$ experiments per tadpole killed, and by invariance the
  largest number of tadpoles that the larvae could kill in one experiment, $1/\hat H\approx60$,
  and the half-maximum density $1/(\hat\alpha\hat H)\approx115$ tadpoles per tank; compare with
  Chapter 5's 60 and 120 read by eye.
- Figure `fig-fitted_curve` (hidden, ggplot2): the 16 tanks and the fitted expected number
  killed, with Chapter 5's curve by eye as a dashed line.
- One sentence: a convergence code of zero is the first check and the residuals of
  `#sec-response-residuals` are the next; link to Chapter 4's "When a fit fails" callout.

**`## The gradient and automatic differentiation {#sec-makeadfun}`** (keep the ID; the title
may change)

- General: Chapter 4 said that `MakeADFun()` processes the NLL and that RTMB supplies the slope
  for BFGS; now we say what that slope is. The **gradient** of the NLL is the vector of its
  partial derivatives with respect to the parameters (link to Chapter 5's
  `#sec-parameter-derivatives`). RTMB calculates it by **automatic differentiation**, exactly up
  to rounding error, without a formula from us. Why it matters for response curves, in prose:
  BFGS uses it at every step; the parameters of a curve are often correlated, which makes the
  NLL a narrow tilted valley where an inexact gradient stops the search early; `sdreport()`
  uses the same derivatives for the curvature, `ADREPORT()` for derived quantities, and Chapter
  7 for random effects. Requirement: the NLL uses operations and functions that RTMB knows, which
  is why the distribution functions come from RTMB and RTMBdist.
- Example: one chunk, `obj$gr()` at the starting values and at the estimates (close to zero).
- Technical detail box (collapsed caution, "Technical detail: how automatic differentiation
  works"): the tape, the chain rule, why it is neither a formula nor a numerical approximation;
  `fn`, `gr` and `he` work from it. Adapt the current box; check it against the RTMB
  introduction vignette.
- Warning callout "When automatic differentiation needs care": a branch (`if`) on a parameter
  is fixed at the side taken at the starting values; a sharp threshold has no derivative; link
  to the RTMB tips vignette; check the NLL in R first. Adapt the current callout.
- Remove the paragraph on `%~%`.

**`# Uncertainty of a response curve`** (new ID, for example `{#sec-curve-uncertainty}`)

`## Standard errors and correlation of the parameters`

- General: `sdreport()` works as in Chapter 4. For a curve, the correlation between estimates is
  often high, and how precisely each parameter is estimated depends on where along $x$ the data
  lie (Chapter 5 showed with partial derivatives where the curve responds to each parameter).
  Data that cover only the rise of a saturating curve determine its initial slope better than
  its asymptote. The parameterisation changes the correlation and not the fit (Chapter 4,
  "Parameterisation, slices and profiles").
- Example: `sdreport()`, `summary()`, `cov2cor()`: correlation 0.82 between
  $\operatorname{logit}(\hat\alpha)$ and $\log(\hat H)$ (0.98 between $\log(\hat a)$ and
  $\log(\hat b)$, one sentence, no chunk); $\alpha$ is estimated precisely, $H$ (and its inverse,
  the asymptote) is not, because the densities stop at 100, below the half-maximum. This keeps
  the promise of Chapter 5 ("Starting values by eye": "What this means for the estimates and for
  their uncertainty is a question for Chapter 6").

`## Likelihood profile intervals of the parameters`

- General: as in Chapter 4, the reference method; with a curve the profile of a poorly
  determined parameter is often asymmetric; the endpoints of any monotonic transformation
  follow (a decreasing one swaps them).
- Example: `TMB::tmbprofile()` and `confint()` for `logit_alpha` and `log_H`, transformed back;
  the interval of $1/H$ from that of $H$. Quote only the intervals that the text interprets.

`## Uncertainty of the fitted curve {#sec-delta-method}` (keep the ID)

- General: a point of the curve is a quantity calculated from the parameters, so its standard
  error comes from `ADREPORT()` (Chapter 4); `ADREPORT()` of a vector gives one standard error
  per element; a grid of predictor values passed in the data list gives the curve at every point
  of the grid; calculate the Wald interval on an unbounded scale (here the logit of $p$) and
  transform the endpoints back, as in Chapter 4. The band is pointwise: each interval covers the
  curve at its own $x$.
- Example: the NLL with `ADREPORT(qlogis(p_grid))` (or the equivalent) for a grid of 0 to 100
  tadpoles per tank, a refit, the band for the expected number killed.
- Statistical detail box "Statistical detail: the delta method for several parameters"
  (collapsed caution, mathematics only, no R chunk): the tangent plane,
  $\operatorname{Var}(g(\hat\theta))\approx\nabla g^{\top}\hat\Sigma\,\nabla g$ with a "where"
  clause (gradient with respect to the parameters, Chapter 5; covariance matrix from
  `sdreport()`), the "In plain English" sentence, the one-parameter case as a special case
  (link to Chapter 4's box), when the approximation is poor. TMB applies it through `ADREPORT()`.
  The main text never relies on a symbol that only the box defines.
- Figure `fig-curve_band` (hidden, ggplot2): the model-reporting figure of `STYLE_GUIDE.md`:
  tanks, fitted curve, band (vermillion, `alpha = 0.2`), and a compact inset or table with the
  formula, the estimates and their likelihood profile intervals. Caption states the model and
  the meaning of the band.
- Practice callout (`imp-`, R as a calculator): from a given estimate of $\log(H)$ and its
  standard error, a Wald interval for $H$ and then for the maximum number killed $1/H$; why the
  endpoints swap.

### Stage 2: part B

**`# Checking the fitted model {#sec-response-residuals}`** (keep the ID)

`## Simulating from the fitted model`

- General: a fitted model is a data generating process that we can simulate; mark the response
  with `OBS()` and call `obj$simulate()` at the estimates (Chapter 4, "Coverage checked by
  simulation"); each simulation is a hypothetical sample of the same tanks with the same
  densities. Simulate complete observations, not only the curve.
- Example: the NLL gains `OBS(killed)` (decide with Stage 1's names whether `OBS()` is in the
  first NLL or added here; Chapter 4 adds it when it is needed). A loop or `replicate()` of
  1,000 calls to `obj$simulate(fit$par)` into a matrix with one row per tank, with a seed.

`## Scaled quantile residuals`

- General: definition in bold: for each observation, the fraction of its simulated values that
  lie below the observed value (with ties randomised for a discrete response); if the model
  describes the data generating process these residuals are approximately uniform between 0 and
  1 whatever the distribution; patterns to look for (non-uniform distribution, a trend against
  the predictor or the fitted value, too many residuals near 0 and 1). Footnote with the source
  (Dunn and Smyth 1996, "Randomized quantile residuals", *Journal of Computational and Graphical
  Statistics* 5: 236–244; and the DHARMa package, Hartig; check both before citing).
- R as a recipe in bullets: `DHARMa::createDHARMa()` with `simulatedResponse` (the matrix),
  `observedResponse`, `fittedPredictedResponse` (the expected numbers killed) and
  `integerResponse = TRUE`; `plot()` of the result; `DHARMa::plotResiduals()` with the predictor.
  Visible chunk with the two plots (the exception under "Choices I made").
- Example: the dispersion statistic, about 2.9: the counts vary among tanks with the same
  density more than a Binomial model allows (link to Chapter 2's "Overdispersion"). One sentence
  on DHARMa's tests (author's decision).
- Warning callout (one, where the risk is): a residual check shows where a model disagrees
  with the data; it does not say which assumption (curve, distribution, independence) is wrong,
  and a quiet plot does not show independence. Replace the scattered caveats of the current
  chapter with this one callout.

**`# A model for overdispersed proportions`** (new section; for example
`{#sec-beta-binomial-fit}`)

- General: when the probability varies among sampling units beyond what the predictor
  explains, the Beta-Binomial distribution keeps the same mean and adds variance (link to
  `distributions.qmd#sec-beta_binomial`); parameterised by the mean probability $p(N)$ from the
  curve and $\kappa=a+b$ (the supplement's symbols): $a=\kappa p$, $b=\kappa(1-p)$; a large
  $\kappa$ gives a Binomial; $\kappa$ is positive (log scale). The curve is unchanged: only the
  observation model is revised, which is the cycle of Chapter 1.
- Example: the NLL with `dbetabinom()` from RTMBdist; fit from the Binomial estimates and a
  moderate $\kappa$; estimates (curve parameters close to the Binomial ones, larger standard
  errors; check in R and say what changed); residuals again (dispersion statistic; check in R).
- Practice callout (`imp-`) optional here, if the chapter has room.

**`# Comparing candidate models {#sec-response-comparison}`** (keep the ID)

- General opening: the candidates should represent plausible ecological or statistical
  alternatives and be fitted to the same observations; nested curves (Chapter 5,
  `#sec-nested-functions`): the constant probability is the Holling type II form with $H=0$;
  the Binomial is the limit of the Beta-Binomial. Four candidates in a $2\times2$ design.
- `## Information criteria`: recall AIC and AICc (link `Chapter_4/Theory.qmd#sec-aic`; no
  derivation again); BIC with its formula and a "where" clause, its larger penalty for $n$
  above 7, its different aim (it tends to select the model with fewest parameters among those
  that contain the data generating process, while AIC aims at prediction), footnote Schwarz
  (1978), *Annals of Statistics* (check). $n$ is the number of tanks: the tadpoles of a tank are
  not independent observations under the Beta-Binomial model. Keep Chapter 4's position that AIC
  ranks and does not test; do not repeat its paragraph.
- `## Cross-validation`: definition in bold; leave-one-out on the log score; every parameter is
  refitted without the held-out tank; a larger score is better; it uses the whole predictive
  distribution, so it works for any observation model; K-fold in one sentence; for data ordered
  in time or space, the held-out part must respect that order (one sentence, no external link).
  AIC approximates the leave-one-out log score in large samples (Stone 1977, *Journal of the
  Royal Statistical Society B*; check before citing). Code: a function that fits one model to a
  subset (fixed starting values), a `for` loop over the 16 tanks, the held-out log probability.
  Present it once, for the four models.
- `## Comparing the four models`: one table (model, $K$, $\ell(\hat\theta)$, AIC, AICc, BIC,
  leave-one-out score) built in R, with differences from the best; interpretation: the density
  dependence of the risk (Holling type II against constant probability) and the extra variation
  among tanks (Beta-Binomial against Binomial), each judged by all criteria; what remains
  uncertain with 16 tanks. Then the ecological answer with the preferred model: the attack rate
  and handling time with intervals, in units.
- Remove the defensive links of the current chapter (R's `AIC` help page, `rsample`).

**`# A recipe for a response curve`**: a note callout, the steps from question to answer:
choose the curve (Chapter 5) and the observation model with the range of its parameter; write
the NLL with the predictor in the data list; starting values by eye; fit and check convergence;
standard errors, correlation, profile intervals; `ADREPORT()` for the curve; simulate and check
the residuals; revise; compare with AIC, AICc, BIC and cross-validation; interpret in units.

**`# Summary`**: a few short paragraphs, no new material.

**`# Chapter quiz`**: 8 to 10 questions in the Chapter 4 format (`::::
{.callout-important title="Question N: <ecological setting>"}` with a collapsed answer), each a
new ecological setting that tests one principle: what the curve must return for a given
distribution; which observations inform an asymptote; why a band is calculated on the logit
scale; what a trend in residuals means and does not mean; dispersion; nested candidates; $n$ in
BIC; why held-out observations are excluded from every fit of their fold; a branch on a
parameter in an NLL. Answers explain.

### Numbers checked on 3 November (R 4.6.1, RTMB, RTMBdist, emdbook, DHARMa 0.5.0)

Starting values $\operatorname{logit}(0.5)$, $\log(1/60)$; BFGS converged (code 0) for all of
these. Stages 1 and 2 recalculate every number in the page; these are a check.

| Quantity | Value |
|---|---|
| Binomial, Holling type II: $\hat\alpha$, $\hat H$, NLL | 0.5259, 0.01660, 46.721 |
| Correlation of $\operatorname{logit}(\hat\alpha)$ and $\log(\hat H)$ | 0.82 |
| Same model with $a,b$: $\hat a$, $\hat b$, correlation of logs; profile interval of $a$ | 60.2, 114.5, 0.98; 37.9 to 143.1 |
| Binomial, constant probability: NLL, AIC | 52.219, 106.44 |
| Binomial, Holling type II: AIC | 97.44 |
| Beta-Binomial, Holling type II: $\hat\alpha$, $\hat H$, $\hat\kappa$, NLL, AIC | 0.540, 0.0180, 26.4, 42.367, 90.73 |
| Leave-one-out log score, Binomial: Holling type II, constant | −51.98, −55.93 |
| DHARMa dispersion statistic, Binomial Holling type II (1,000 simulations, seed 1) | 2.89 |

Not yet run: the Beta-Binomial with constant probability, its leave-one-out score, AICc and BIC
of the four models, the dispersion statistic of the Beta-Binomial fit, the profile intervals in
the $\alpha,H$ parameterisation, the band. A naive Beta-Binomial fit in the $a,b$ form (where
$p$ can exceed 1) drifted to a meaningless NLL of about −10,000: in the $\alpha,H$ form it is
fine, but check every fit's convergence and estimates.

## The practical (Stage 3)

Front matter as in Chapter 4 (`title: "Chapter 6: Fitting ecological response curves"`,
`date: today`). An opening paragraph like Chapter 4's: which exercise uses which data, which are
core (1 to 3) and which extra (4), worked Exercise 1, link to the theory, "As in the theory...
RTMB and RTMBdist", and that DHARMa must be installed once with `install.packages("DHARMa")`. A
visible chunk loads RTMB and RTMBdist. Headings `# Exercise N: Topic`, `## Solution`,
`### Question n`, as in Chapter 4. Plots in base R only (`STYLE_GUIDE.md`, "Plots inside
exercises"), DHARMa's own plots allowed. Each data set comes with a short provenance paragraph,
taken from the Chapter 5 practical (same citations). Treat grouped observations as i.i.d. with
one sentence and a pointer to Chapter 7 where it applies.

`no_solution.qmd` contains the student version: Exercise 1 with its full worked solution (as
Chapter 4's Exercise 1), and Exercises 2 to 4 with questions only. `solution.qmd` contains all
four with solutions; the question text is identical in both files.

**Exercise 1 (worked): Virus titre in infected rabbits.** `emdbook::MyxoTiter_sum`, grade 1, 27
observations; Ricker curve $f(t)=ate^{-bt}$ for the mean titre (Chapter 5 practical, Exercise 1:
peak read by eye, $a=3.44$, $b=1/6$). Questions: (1) write the model with a Normal observation
model, the units of $a$, $b$ and $\sigma$, and why a Normal model can be used for a titre that is
positive; (2) fit from the values by eye, check convergence, plot the curve over the data; (3)
standard errors with `sdreport()`, the peak time $1/b$ and peak titre $a/(be)$ with `ADREPORT()`
and Wald intervals on the scale on which they were reported (say which); likelihood profile
interval of $b$ with `tmbprofile()`; (4) residuals with `obj$simulate()` and DHARMa, read; (5) the
same curve with a Gamma model (`dgamma()` with `shape` and `scale = mean / shape`), and a
comparison with AIC, AICc and BIC (same $K$). Checked on 3 November: Normal NLL 27.500
($\hat a=3.418$, $\hat b=0.1652$, $\hat\sigma=0.670$); Gamma NLL 29.509 ($\hat a=3.561$,
$\hat b=0.1713$, shape 90.5): the Normal model is preferred by about 4 units.

**Exercise 2: Enzyme kinetics.** `datasets::Puromycin`, 23 observations, Michaelis–Menten curve
with Normal errors (Chapter 5 practical, Exercise 6: curves by eye, the asymptote differs between
states). Questions: (1) one curve for both states; (2) a separate asymptote $a$ for each state
with a common $b$ and $\sigma$ (an index vector as in Chapter 4's practical, Exercise 1, question
6); (3) the difference between the two asymptotes with `ADREPORT()` and a Wald interval; (4) the
likelihood profile interval of $b$; (5) AIC, AICc, BIC and leave-one-out cross-validation (23
refits) for the two models; (6) residuals against the concentration for the preferred model.
Checked: one curve NLL 98.840; separate asymptotes NLL 85.296 ($\hat a$ 166.6 and 208.6
counts/min/min, $\hat b=0.0580$ ppm, $\hat\sigma=9.87$).

**Exercise 3: Fecundity of fir trees.** `emdbook::FirDBHFec_sum`, the trees with both diameter
and fecundity (311 in the check), power law $\mu(x)=ax^b$ (Chapter 5 practical, Exercise 7,
Part A). Questions: (1) remove the incomplete rows explicitly and say why a missing count is not a
zero; (2) Poisson model, fit, residuals with DHARMa; (3) Negative Binomial model (`dnbinom2()`
of RTMBdist, mean and shape $k$), fit, residuals; (4) AIC, AICc and BIC; (5) the exponent $b$
with its likelihood profile interval, and the factor $2^b$ by which fecundity changes when the
diameter doubles, with `ADREPORT()`. **Two points to settle in R:** six fecundity values are not
integers (read `?FirDBHFec_sum`; round them with one explained sentence, or drop them, and record
the choice under "Open questions"); in the check the NB fit ended with $\log(\hat a)$ almost at
its starting value 0 ($\hat b=1.80$, $\log(\hat k)=0.61$, NLL 1445.5; Poisson NLL 3957.1, $\hat
b=1.98$): verify from another start that this is the maximum. The column `pop` (two populations)
is not modelled: one sentence and a pointer to Chapter 7.

**Exercise 4 (extra): Coverage of an interval for a quantity of the curve.** From the Normal
Ricker fit of Exercise 1: simulate 1,000 (or 2,000 if it runs within a few minutes) hypothetical
samples at the same days with `obj$simulate()`, refit each from fixed starting values, and record
the estimate and the Wald interval of the peak time $1/b$ from `ADREPORT()`; calculate the bias
and the coverage, with the Monte Carlo error of the coverage. A skeleton function with two gaps,
as Chapter 4's Exercise 5. The question says that the profile interval would need
`tmbprofile()` in every sample, which is why only the Wald interval is checked. Record failed
fits and do not drop them silently.

## The lecture (Stages 5 and 6)

One folder `Chapter_6/Lecture/` with `lecture.qmd`, `lecture-script.md`, `lecture-script.pdf`,
`lecture.scss` (unchanged copy of `Chapter_4/Lecture_2/lecture.scss`), `demo-cycle.R` and
`lecture-assets/` (with `figures.R`). Title slide: subtitle "Chapter 6 · Lecture", eyebrow
"Fitting Ecological Response Curves". `pagetitle`: "Chapter 6 — Ecological Models and Data
Analysis". Footer: "Ecological Models and Data Analysis · Chapter 6".

The rules of `STYLE_GUIDE_LECTURE.md` hold, above all "General statement first" and "The main
points stand on the slide". Every content slide below is specified as **General** (required, on
the slide), **Example** (in `.example`, caption or code comments) and **Script** (notes for Stage
6). Slide titles name the concept, not the reed frogs. The specification is a plan: Stage 5 takes
the theory as Stage 4 left it as the source of wording, numbers and figures, and adapts a slide
when the chapter differs (and says so in the progress log).

### Slide sequence and timing

| Slide | Title | Min | Elapsed |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis (title) | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | Two pillars: functions and distributions | 3 | 4–7 |
| 5 | A response curve as a parameter of a distribution | 4 | 7–11 |
| 6 | What the curve must return | 4 | 11–15 |
| 7 | The likelihood of a response curve | 4 | 15–19 |
| 8 | The negative log-likelihood in R | 4 | 19–23 |
| 9 | Starting values and the fit | 4 | 23–27 |
| 10 | Reading the fitted curve | 3 | 27–30 |
| 11 | The gradient and automatic differentiation | 3 | 30–33 |
| 12 | Practice 1 | 3 | 33–36 |
| | Break | 10 | 36–46 |
| 13 | Precision and correlation of curve parameters | 4 | 46–50 |
| 14 | Where the data lie | 4 | 50–54 |
| 15 | Likelihood profile intervals of curve parameters | 4 | 54–58 |
| 16 | The uncertainty of a fitted curve | 4 | 58–62 |
| 17 | A confidence band | 4 | 62–66 |
| 18 | Practice 2 | 3 | 66–69 |
| 19 | Simulating from a fitted model | 3 | 69–72 |
| 20 | Scaled quantile residuals | 4 | 72–76 |
| 21 | Reading residual plots | 4 | 76–80 |
| 22 | Discussion: what does a residual pattern tell us? | 3 | 80–83 |
| | Break | 10 | 83–93 |
| 23 | Live demo: the modelling cycle for one model | 2 + 16 | 93–111 |
| 24 | Revising the observation model | 4 | 111–115 |
| 25 | Candidate models | 3 | 115–118 |
| 26 | AIC, AICc and BIC | 5 | 118–123 |
| 27 | Leave-one-out cross-validation | 4 | 123–127 |
| 28 | Comparing the candidates | 4 | 127–131 |
| 29 | A recipe for a response curve | 2 | 131–133 |
| 30 | The Chapter 6 R practical | 2 | 133–135 |
| 31 | Summary and closing questions | 3 | 135–138 |
| | Slack for discussion | 12 | 138–150 |
| | **Total** | **150** | |

Check: slides 118 (blocks of 36, 37 and 45, the demo included) + slack 12 + breaks 20 = 150.
The minutes of each slide equal its `data-timing` in seconds. The break before the demo lets the
lecturer open R and run section 0 of the demo script. Practice slides take the theory's
`Practice` callouts by number and title in the order of the page; if the theory has three or
four, adjust slides 12 and 18 (and add a third Practice slide in block 3 only if the slack allows,
keeping at least 8 minutes of slack).

### Slide specifications

1. **Title.**
2. **Overview:** numbered, bold keyword + question: the model (how does a predictor enter a
   distribution?); the fit (what changes from Chapter 4?); uncertainty (how precise are the
   parameters, and the curve?); checking (does the model describe the data?); revision and
   comparison (which model do the data support?); the practical.
3. **Where we are** (`.diagram-slide`, `../../Chapter_1/Lecture/ModelCycle.png` unchanged).
   Caption: this lecture goes round the whole cycle for one data set.
4. **Two pillars** (two columns, fragments): *Distributions and likelihood* (Chapters 2 to 4)
   and *Deterministic functions* (Chapter 5); takeaway: a curve gives a parameter of the
   distribution of each observation. Example: the reed frog functional response, 16 tanks.
   Script: provenance once (Vonesh and Bolker 2005, `emdbook`), the values by eye of Chapter 5.
5. **A response curve as a parameter of a distribution** (`.figure-slide`,
   `curve-distribution.png`, copy of `fig-curve_distribution`). General: equation
   $\theta_i=f(x_i;\boldsymbol\beta)$; bullets: one distribution per observation; other
   parameters shared; observations independent but not identically distributed. Example:
   $K_i\sim\operatorname{Binomial}(N_i,p(N_i))$, $p(N)=\alpha/(1+\alpha HN)$.
6. **What the curve must return:** the table of the theory (distribution, parameter, range,
   how to give the curve that range). Takeaway: the range of the curve is part of the model.
   Example: why $p(N)$ and not the number killed; the disc equation as $N\,p(N)$.
7. **The likelihood of a response curve:** equation
   $\ell(\boldsymbol\beta)=\sum_i\log(P(Y_i=y_i\mid\boldsymbol\beta))$; bullets: each
   observation evaluated at its own $x_i$; the same machinery as Chapter 4; the predictor goes
   in the data list. Example: the Binomial log probability of one tank.
8. **The negative log-likelihood in R** (code from the chapter): bullets for the items
   (transformations with `plogis()` and `exp()`, the curve, the log probabilities).
9. **Starting values and the fit** (code): bullets: values read by eye (Chapter 5), on the
   transformed scale; `MakeADFun()`, `optim()`, convergence. Example in comments: the estimates.
10. **Reading the fitted curve** (`.figure-slide`, `fitted-curve.png`): what such a figure shows
    in general; invariance gives derived quantities ($1/H$, the half-maximum). Example: estimates
    against the values by eye.
11. **The gradient and automatic differentiation:** definition of the gradient; RTMB
    differentiates the code, exactly; why it matters with correlated curve parameters; the
    requirement on functions. Script: the tape (the box), the warning on branches.
12. **Practice 1:** the first Practice callout of the theory, with the time on the slide.
13. **Precision and correlation of curve parameters** (code `sdreport()`, `cov2cor()`):
    bullets general; example: correlation 0.82 in $\alpha,H$; 0.98 in $a,b$; $\alpha$ precise,
    $H$ not. Script: Chapter 4's parameterisation lesson.
14. **Where the data lie** (figure: Chapter 5's `fig-parameter_derivatives` or a new figure from
    the chapter; if neither exists in the theory, a hand-written schematic SVG of a saturating
    curve with data only on its rise): the partial derivatives show where the curve responds to
    each parameter; observations inform a parameter where the curve responds to it. Takeaway:
    design determines what can be estimated.
15. **Likelihood profile intervals of curve parameters** (code `tmbprofile()`, `confint()`):
    asymmetric for a poorly determined parameter; endpoints transform (decreasing: swap).
16. **The uncertainty of a fitted curve:** a point of the curve is a function of the
    parameters; `ADREPORT()` of a vector on a grid; Wald interval on the logit scale, endpoints
    back; pointwise. Delta method named only, with a pointer to the chapter's box (no formula on
    the slide).
17. **A confidence band** (`.figure-slide`, `curve-band.png`, copy of `fig-curve_band`): how to
    read a band; what it does not show (where future tanks fall; that is the distribution).
18. **Practice 2:** the second Practice callout.
19. **Simulating from a fitted model** (code `OBS()`, `obj$simulate()`): a fitted model is a
    data generating process; complete observations, same design.
20. **Scaled quantile residuals:** definition; uniform under the model whatever the distribution;
    ties randomised for counts. Example: one tank, its observed count among its simulations.
21. **Reading residual plots** (`.figure-slide`, `residuals-binomial.png`, the DHARMa plot of
    the chapter saved as PNG): the QQ plot, residuals against the predictor, the dispersion
    statistic; a check shows disagreement and not its cause. Example: dispersion about 2.9.
22. **Discussion** (timed, takeaway and activity visible): four short residual descriptions to
    label as "curve", "distribution", "independence" or "cannot tell". Script: expected answers.
23. **Live demo: the modelling cycle for one model** (`.demo-slide`): numbered incremental list
    of the general steps of `demo-cycle.R`; a `.demo` box with the script name and sections. No
    model comparison (author's decision).
24. **Revising the observation model:** the Beta-Binomial with the same curve; mean from the
    curve, $\kappa$ for the extra variation; the curve is unchanged. Example: estimates and the
    dispersion statistic after revision.
25. **Candidate models:** a $2\times2$ table (curve × distribution); nested pairs; same
    observations.
26. **AIC, AICc and BIC:** the three formulas; what each aims at; $n$ is the number of
    independent observations (tanks). Script: Chapter 4's AIC paragraph is not repeated; Schwarz.
27. **Leave-one-out cross-validation:** definition; log score; refit everything; works for any
    distribution; respects order in time or space.
28. **Comparing the candidates:** the chapter's table (`.roadmap` class for a table slide);
    takeaway: criteria rank and the ecology interprets. Example: what the 16 tanks support.
29. **A recipe for a response curve:** the chapter's recipe, incremental, in keywords.
30. **The Chapter 6 R practical:** the four exercises as bold keywords; takeaway: Exercises 1
    to 3 are the core; try, then check.
31. **Summary and closing questions** (`.closing`): incremental take-home points; takeaway
    string ("Curve · Distribution · Gradient · Band · Residuals · Revision · AIC · BIC ·
    Cross-validation"); two closing questions. Script: final transition to Chapter 7 (groups:
    the 16 tanks were independent; leaves, nests and sites are not).

### Demo script `demo-cycle.R`

Header: packages (RTMB, RTMBdist, TMB, emdbook, DHARMa) and run time. Sections that match the
demo slide: 0 set-up and data; 1 the NLL and the fit; 2 estimates on the original scale and the
curve over the data (base R); 3 `sdreport()`, correlation and the profile of `log_H`; 4 the band
from `ADREPORT()` (base R plot); 5 `obj$simulate()` and the DHARMa plots. Object names of the
chapter. Runs in a clean session in under 30 seconds; Stage 5 runs it and records the time.

### Figures

All PNG with `dpi = 192`, copies at the size of the chapter's chunk; every image has `fig-alt`.
`lecture-assets/figures.R` runs in a clean session from the repository root and writes every PNG
into `lecture-assets/`; copies run the chapter's chunks unchanged in order and change only the
last line to save the plot. Expected files: `curve-distribution.png`, `fitted-curve.png`,
`curve-band.png`, `residuals-binomial.png` (DHARMa's plot through `png()`), and the figure of
slide 14. Compare copies with the rendered chapter figures in `_site/Chapter_6/Theory_files/`
(dev build) or `_freeze`. If a copy is unreadable at slide size, report it instead of changing
the figure.

### Checks for Stage 5

1. `quarto render Chapter_6/Lecture/lecture.qmd --to revealjs` from the repository root; no
   warnings ignored.
2. Every slide inspected at 1440 × 900 with all fragments showing, with the headless Edge command
   of `Chapter_4/lecture-handoff.md` ("Checks"), screenshots in the scratchpad. A slide fails if
   anything touches the footer; fix by moving text to the script notes.
3. General-first audit: list any example number outside an `.example` box, a caption or a code
   comment.
4. Minutes equal `data-timing`; blocks add up.

### Stage 6: the script

Written from the slides as Stage 5 left them (they replace the table above if they differ). The
format of `STYLE_GUIDE_LECTURE.md`, "The script", and of `Chapter_4/Lecture_2/lecture-script.md`:
opening (draft for review; 150 minutes, 118 of slides, 12 of slack, 2 breaks; one live demo;
links to theory and practical; which slides use which figure, with `figures.R`); timing table;
one section per slide with the narrative, general rule first; Practice and discussion slides
with expected answers; the demo section with a walkthrough of `demo-cycle.R` by section, the
numbers to expect and when to run section 0; "Adjustments during delivery" (what to shorten
first, what to keep: slides 5 to 7, 13, 16, 20 and 24; the demo is kept whole and takes the slack
first). PDF with `quarto render Chapter_6/Lecture/lecture-script.md --to typst` (confirm that it
works; if it fails, say so). No first-person anecdote or opinion for the author.

## Stage 4: independent review

The reviewer did not write the pages. It works through, for the theory and the practical:

1. **Statistics:** model statements, supports and ranges, parameterisations, likelihoods,
   the use of $n$ in BIC and AICc, the meaning of the band, the meaning of residual patterns,
   cross-validation without leakage, coverage with failed fits counted, no Normal-only result
   taught as general.
2. **Numbers:** run every chunk of both pages in a clean session (render in the dev profile) and
   compare every number quoted in prose with the output.
3. **Voice and style:** the checklist of `STYLE_GUIDE.md` ("Checklist for a revised or new
   passage") on every section; the "Rules that matter most" above; British English; units;
   $\log()$ with parentheses; "likelihood profile"; "hypothetical samples".
4. **Code:** the R rules of `STYLE_GUIDE.md`; names consistent between theory and practical;
   one step, one chunk.
5. **Scope:** nothing that belongs to Chapters 7 or 8 (conditional distributions, random effects,
   identifiability theory, optimiser comparisons) beyond a pointer; no hypothesis tests; size
   within the target.
6. **Alignment:** exercises and solutions identical in question text, numbering and data;
   learning goals match the sections.

The reviewer fixes what it finds (routine fixes directly; anything that changes the scientific
meaning goes to "Open questions for the author" with the conservative choice applied) and writes a
short report in the progress log: what was checked, what was changed, what remains.

## Stage 7: integration

1. **Links and promises.** Search the repository (`grep` for `Chapter_6`, `Chapter 6`) and fix
   every link and promise to what the new chapter contains. Known places:
   - The delta method (author's decision: box only in Chapter 6). `Chapter_3/Theory.qmd` (around
     line 1722), `Chapter_4/Theory.qmd` (around lines 1406 and 1450), `Chapter_4/Practicals/no_solution.qmd`
     (around line 283), `Supplements/canned.qmd` (around line 423), `Supplements/glossary.qmd`
     (around line 151), `STYLE_GUIDE.md` (the bullet on `ADREPORT()`, "which Chapter 6 explains"),
     `AGENTS.md` (Chapter 3 and Chapter 4 entries). Change "Chapter 6 explains it" to what is true:
     the formula is in Chapter 4's box and Chapter 6 applies it to a fitted curve
     (`#sec-delta-method`). Leave the Chapter 4 lecture slides and scripts unchanged unless they
     are wrong, and list any stale mention for the author.
   - `Chapter_1/Theory.qmd`, "The modelling cycle" and "Chapter 6: Fitting ecological response
     curves": the roadmap entry (key concepts; R skills: remove "predictive RMSE", say the
     leave-one-out log score; "how its built-in automatic differentiation and the delta method
     work" becomes accurate; coverage by simulation in the practical). This page is the author's
     approved text: change only the sentences that are wrong, and list them in the report.
   - `Chapter_5/Theory.qmd`: the promises around lines 28, 45, 651, 1164, 1171, 1327 ("link a
     predictor to the mean of a Poisson distribution and to the probability of a Bernoulli
     distribution"; Chapter 6 now uses a Binomial: rephrase), 1386, 1513, 1554, 1580, 1616;
     `Chapter_5/Practicals/no_solution.qmd` and `solution.qmd` (lines 13, 241, 337, 787, 968,
     1113). Check each against the new chapter.
   - `Supplements/deterministic-functions.qmd` around lines 786, 1024 and 1123: the old practical
     used the saturating exponential, the Gompertz against the logistic and the inverse logit of
     a quadratic; none remains. Replace with what is true (the Ricker of Exercise 1, the
     Michaelis–Menten of Exercise 2 and the theory, the power law of Exercise 3) or remove the
     sentence.
   - `Chapter_7/Theory.qmd` (intro, around lines 32, 67 and 133) says that Chapter 6 fitted the
     light-response data of `shapes1.csv`. Minimal edit only (Chapter 7 is not being rewritten):
     the data are introduced in Chapter 7; Chapter 6 fitted one curve to independent tanks.
   - `Chapter_8/Theory.qmd` (around lines 96 and 257) and `Supplements/canned.qmd` (around line
     527, residuals) and `Supplements/distributions.qmd` (around line 2665): check the wording.
2. **Guidance.** `AGENTS.md`: replace the Chapter 6 row of the status table and the Chapter 6
   bullets under "Chapters 6 to 8" with what now exists and what awaits review (the whole chapter,
   practical and lecture are generated drafts); add a "### Chapter 6" entry under "Decisions by
   page" with the durable decisions of this file (one example, parameterisation, the cycle,
   DHARMa without tests, delta method box only, leave-one-out, coverage only in the practical,
   one lecture with its demo, the DHARMa figure exception); update "Where topics live" (the
   delta method), "Builds and packages" (production now renders Chapter 6; DHARMa is needed in
   production) and the lecture paragraph. `STYLE_GUIDE.md`: numbered Practice callouts now also
   in Chapter 6; the DHARMa exception if the author confirms it; any convention that the stages
   established. `STYLE_GUIDE_LECTURE.md`: the Chapter 6 lecture and its demo where the guide
   lists lectures and demos. Write decisions once, as decisions, not history.
3. **Production build.** `_quarto-prod.yml`: add `Chapter_6/Theory.qmd`,
   `Chapter_6/Practicals/no_solution.qmd`, `Chapter_6/Practicals/solution.qmd` and
   `Chapter_6/Lecture/lecture.qmd` to the render list (after the Chapter 5 and Chapter 4 lecture
   entries, as the existing order suggests) and to the sidebar sections "Theory", "Slides"
   ("Chapter 6"), "Practicals" and "Solutions". Check `.github/workflows/publish.yml`: every
   package loaded by the new pages is listed (DHARMa, emdbook, RTMB, RTMBdist and TMB are; check
   any other). Do not change `_quarto-dev.yml` unless a Chapter 6 entry is missing.
4. **Renders.** `quarto render --profile prod` (the whole production site) if it runs in
   reasonable time; otherwise render each Chapter 6 page and every page edited in step 1 with
   the production profile. Report exactly what ran and any warning.
5. **Final report to the author** (in the session and as the last progress-log line): files
   changed per stage, checks that ran, numbers that differ from this file, open questions,
   sentences changed in approved pages (Chapters 1 to 3), and what awaits review. Leave this
   file in place; the author removes it.

## Open questions for the author

Stages add questions here; they do not wait for an answer.

Answered by the author on 4 November (decisions; later stages keep them):

- **Disagreement among the criteria stays.** Under the Beta-Binomial models AIC, AICc and BIC
  prefer the Holling type II curve (2.7, 1.6 and 2.0 units) and the leave-one-out score the
  constant probability (0.9). The theory says so and answers with the Beta-Binomial Holling
  type II model; students should see that model comparison criteria can disagree.
- **DHARMa's `plot()` stays**, with its printed tests and the sentence on why the course does
  not rest decisions on p-values. `plotResiduals(form = ...)` is named but not run.
- **$n$ in AICc and BIC is 16 tanks for all four models.** Whether $n$ could be the 610 tadpoles
  for the Binomial models is not discussed in Chapter 6; it belongs to Chapter 7.
- **Three numbered Practice callouts** (`imp-seedlings-light`, `imp-ladybird-handling`,
  `imp-fruit-set`); the lecture adjusts its Practice slides to three.

Added by Stage 3 (conservative choice applied; awaiting the author):

- **Fir fecundities that are not whole numbers.** Six of the 311 trees have a fecundity such
  as 206.5; `?FirDBHFec_sum` does not explain them, and in `FirDBHFec` the yearly counts of
  these trees contain fractions (e.g. 32.5). Exercise 3 rounds them with `round()` (each
  changes by at most half a rachis) and says why. Dropping them is the alternative.
- **`solution.qmd` repeats the worked Exercise 1 in full**, as this plan asks ("contains all
  four"), so that Exercise 4 can use its objects. The solution pages of Chapters 4 and 5
  leave out their worked exercise and link to the student page instead.
- **The Wald interval of the peak time is calculated on the original scale** (from
  `ADREPORT(peak_time)`), as the plan's question 3 implies; Exercise 4 finds a coverage of
  0.927 with misses mostly below the true value. A Wald interval from the log scale would
  be the course's usual choice for a positive quantity; the exercise uses the original
  scale because its lesson is the asymmetry that the profile interval captures.

## Progress log

Each stage adds one line: date, stage, what is done, what is next.

- 3 November 2026: Stage 0 done (author's decisions, this plan; feasibility of the theory and
  practical fits checked in R 4.6.1, see the tables above). Next: Stage 1.
- 3 November 2026: Stage 1 done. `Chapter_6/Theory.qmd` has the new part A (front matter to
  the end of "Uncertainty of a response curve", lines 1 to about 640) followed by the old part B
  unchanged below the comment "Stage 2 ... replaces everything below this comment" (old
  sections from "Compare candidate models" to the quiz; no executable chunks, IDs
  `#sec-response-comparison` and `#sec-response-residuals` kept so links resolve). Rendered
  with `--profile dev` (RTMB 2.0, RTMBdist 1.1.0, TMB 1.9.25, emdbook 1.3.14): no warnings;
  every printed number checked against the prose. **Names for Stage 2:** `frog_data` (list with
  `initial`, `killed`, and `initial_grid` = 0:100 added in `#sec-delta-method`); `cmb`;
  `binomial_nll`, whose last version has the grid lines and `ADREPORT(logit_p_grid)` but no
  `OBS()` (Stage 2 adds `killed = OBS(killed)` and reprocesses, as Chapter 4 does);
  `binomial_obj`, `binomial_fit`, `binomial_sd` (refitted with the grid); `alpha_mle`,
  `H_mle`; `binomial_profile_alpha`, `binomial_profile_H`, `profile_intervals` (rows `alpha`,
  `H`, `1/H`); `critical_value`; `band_summary`, `curve_band`; figure helpers `alpha_eye`,
  `H_eye`; hidden `mm_nll`, `mm_obj`, `mm_fit`, `binomial_summary`, `wald_H`. New ID
  `#sec-curve-uncertainty`; Practice callouts `imp-seedlings-light` (Practice 1) and
  `imp-ladybird-handling` (Practice 2). The one sentence on coverage by simulation (pointer to
  Chapter 4 and the practical's extra exercise) is at the end of "Uncertainty of the fitted
  curve"; Stage 2 need not repeat it. **Numbers** (all agree with the table above): profile
  intervals $\alpha$ 0.402 to 0.682, $H$ 0.00699 to 0.0264, $1/H$ 37.9 to 143.1 (Wald from the
  log scale 33.8 to 107.2, quoted once); standard errors 0.285 (`logit_alpha`) and 0.294
  (`log_H`); band at 100 tadpoles 23.5 to 33.1 killed. On the logit scale the band is narrowest
  near 50 tadpoles per tank and widens towards both ends (the text says so; it is not narrowest
  at low density). `confint()` warns "collapsing to unique 'x' values" because each profile
  holds the estimate twice; that chunk has `warning: false` with a comment. Next: Stage 2.
- 4 November 2026: Stage 2 done. `Chapter_6/Theory.qmd` part B written (the old part B and the
  Stage 2 comment removed; the page is 1,701 lines). Sections: "Checking the fitted model"
  (`#sec-response-residuals`, with "Simulating from the fitted model" and "Scaled quantile
  residuals"), "A model for overdispersed proportions" (`#sec-beta-binomial-fit`), "Comparing
  candidate models" (`#sec-response-comparison`, with "Information criteria",
  "Cross-validation" and "Comparing the four models"), the recipe callout, "Summary" and a quiz
  of 10 questions. Rendered with `--profile dev` (R 4.6.1, RTMB 2.0, RTMBdist 1.1.0, TMB 1.9.25,
  emdbook 1.3.14, DHARMa 0.5.0): no warnings, no unresolved cross-references, Practice 1 to 3
  numbered. Every number quoted in part B was checked against the rendered output. **Names:**
  `binomial_nll` gains `killed = OBS(killed)` (refitted); `n_sim`, `binomial_simulations`
  (seed 601), `binomial_expected`, `binomial_residuals` (figure `fig-residuals_binomial`, visible
  code, DHARMa's own `plot()`); `betabinomial_nll` (with `OBS()`), `betabinomial_obj`,
  `betabinomial_fit`, `betabinomial_sd`, `alpha_bb`, `H_bb`, `betabinomial_simulations` (seed
  602), `betabinomial_expected`, `betabinomial_residuals`; `constant_binomial_nll`,
  `constant_betabinomial_nll` (parameter `logit_alpha`, plus `log_kappa`); `fit_model()`,
  `models` (list of `nll` and `start`), `comparison` (columns `K`, `loglik`, `convergence`,
  `aic`, `aicc`, `bic`, `loo`), `n_tanks`, `subset_tanks()`, `n_failed`;
  `betabinomial_profile_alpha`, `betabinomial_profile_H`, `betabinomial_intervals`. The held-out
  tank is scored by calling the NLL directly with `as.list(fit$par)`; this works with `OBS()`
  and `ADREPORT()` in the NLL. Practice 3: `imp-fruit-set`. **Numbers:** dispersion statistic
  2.93 (Binomial, seed 601; the plan's 2.89 used seed 1) and 0.92 (Beta-Binomial; the tank with
  5 of 50 killed has a residual of 0.009, inside its simulations); Beta-Binomial $\hat\alpha$
  0.540, $\hat H$ 0.0180, $\hat\kappa$ 26.4, NLL 42.367, standard errors 0.377 (`logit_alpha`)
  and 0.462 (`log_H`), correlation 0.77 (not quoted); constant Beta-Binomial NLL 44.727;
  differences from the best (AIC, AICc, BIC, leave-one-out): constant Binomial 15.70, 13.99,
  14.16, −8.17; Holling Binomial 6.71, 5.63, 5.94, −4.21; constant Beta-Binomial 2.72, 1.64,
  1.95, 0; Holling Beta-Binomial 0, 0, 0, −0.94 (leave-one-out scores −55.93, −51.98, −47.76,
  −48.70; all 64 fits converged); Beta-Binomial profile intervals $\alpha$ 0.378 to 0.759, $H$
  0.00187 to 0.0376, $1/H$ 26.6 to 533. Citations added: Dunn and Smyth (1996), Hartig (DHARMa
  0.5.0, from `citation("DHARMa")`), Schwarz (1978), Stone (1977). Four questions added under
  "Open questions". Next: Stage 3.
- 4 November 2026: Stage 3 done. `Chapter_6/Practicals/no_solution.qmd` (589 lines: opening,
  worked Exercise 1, questions of Exercises 2 to 4 and the skeleton of
  `simulate_peak_time()` with two gaps) and `solution.qmd` (1,380 lines: all four exercises;
  the question blocks were copied from the student page and checked to be identical) replace
  the old `shapes*.csv` practical. Both render with `--profile dev` (R 4.6.1, RTMB 2.0,
  RTMBdist 1.1.0, TMB 1.9.25, emdbook 1.3.14, DHARMa 0.5.0): exit 0, no warnings, no stderr
  output, no unresolved cross-references; every relative link and anchor exists. The
  solution page takes about a minute (Exercise 4 about 30 s). Every number quoted in prose
  was checked against the rendered output and every DHARMa plot was inspected. **Names:**
  Exercise 1 `titre_data` (`day`, `titre`), `titre_start`, `normal_nll` (second version with
  `OBS(titre)` and `ADREPORT()` of `peak_time` and `peak_titre`), `normal_obj`, `normal_fit`,
  `normal_sd`, `normal_profile_b`, `a_mle`, `b_mle`, `sigma_mle`, `ricker()`,
  `critical_value`, `n_sim`, `normal_simulations` (seed 611), `normal_residuals`,
  `gamma_nll`, `gamma_obj`, `gamma_fit`; Exercise 2 `enzyme_data` (`conc`, `rate`, `state`),
  `pooled_nll`/`state_nll` (both with `OBS()`; `state_nll` with `ADREPORT(difference)`),
  `pooled_start`, `state_start`, `michaelis_menten()`, `fit_model()`,
  `subset_observations()`, `enzyme_models`, `state_profile_b`, `state_simulations` (seed
  621); Exercise 3 `fir`, `fir_data` (`dbh`, `cones` rounded), `power_law()`,
  `poisson_nll`, `nbinom_nll` (with `ADREPORT(doubling_factor)`), `poisson_simulations`
  (seed 631), `nbinom_simulations` (seed 632), `nbinom_sd`, `nbinom_profile_b`; Exercise 4
  `simulate_peak_time()`, `peak_samples` (seed 641, 2,000 samples). In Exercise 2 the
  held-out observation is scored with `fn` of an object processed for that observation,
  because `as.list(fit$par)` (the theory's route) breaks when `log_a` is a vector; the
  solution says why. Exercise 2, question 6 uses `plotQQunif()` and `plotResiduals()` instead
  of `plot()`, whose quantile regression prints qgam warnings with 23 observations.
  **Numbers** (agree with the plan): Ricker Normal $\hat a$ 3.418, $\hat b$ 0.1652,
  $\hat\sigma$ 0.670, NLL 27.500; peak 6.05 days (Wald 5.30 to 6.80; from the profile of
  $b$, 0.144 to 0.186/day, 5.36 to 6.95), height 7.61 (7.32 to 7.91); Gamma NLL 29.509,
  shape 90.5, all three criteria 4.0 in favour of the Normal; residuals against the day
  U-shaped and flagged by DHARMa (read as exploratory). Puromycin NLL 98.840 and 85.296
  ($\hat a$ 208.6 and 166.6, $\hat b$ 0.0580, $\hat\sigma$ 9.87); difference 42.0 (Wald 30.5
  to 53.5); $b$ profile 0.0469 to 0.0710 ppm, Wald 0.0476 to 0.0707; differences AIC 25.1,
  AICc 24.1, BIC 24.0, leave-one-out 11.8 (scores −102.17, −90.32; 46 fits converged).
  Fir: 311 trees; Poisson NLL 3957.1, $\hat b$ 1.98, dispersion 22.9, 147 trees outside their
  simulations; Negative Binomial NLL 1445.53 ($\hat a$ 1.00, $\hat b$ 1.80, $\hat k$ 1.84),
  the same from a second start (`log_a = -2`, `b = 2.5`, `log_k = 1`), so $\log(\hat a)\approx0$
  is the maximum and not a stalled fit; dispersion 0.66, one outlier; AIC difference about
  5,021; $b$ profile 1.55 to 2.05; $2^b$ 3.49 (Wald 2.88 to 4.10, from the profile 2.92 to
  4.15); correlation of $\log(\hat a)$ and $\hat b$ −0.99. Exercise 4: no failed fit; bias
  0.019 days (Monte Carlo SE 0.0085); SD of estimates 0.381 against SE 0.383; coverage 0.927
  (SE 0.006); misses 104 below, 43 above. Three questions added under "Open questions".
  Next: Stage 4.
