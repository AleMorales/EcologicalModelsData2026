# Chapter 8 handoff plan: grouped ecological response curves

## Status

This document records the approved scope and detailed implementation plan for
an agent taking over Chapter 8. It is a plan only; it does not authorise
discarding any current uncommitted changes.

## Objective and fixed author decisions

Create Chapter 8 of the *Ecological Models and Data Analysis in R* textbook.
It follows Chapter 7's one-predictor response-curve workflow and introduces
repeated measurements within groups, pooling choices, random effects,
shrinkage, regularisation, maximum marginal likelihood, and RTMB fitting.

The course author has approved these decisions:

- The new material is Chapter 8, not Chapter 9.
- Theory and practical use different datasets. The theory uses the light
  response data from Chapter 7; the practical uses R's `datasets::Loblolly`.
- In `Chapter_7/Practicals/shapes1.csv`, each set of five rows at a light level
  belongs to the same five leaves, in the same order. Create leaf IDs 1 to 5
  repeated at each light level. State that the author supplied this information:
  it cannot be recovered from the CSV alone.
- Use variance notation throughout: $\sigma^2_{\mathrm{leaf}}$,
  $\sigma^2_{\mathrm{tree}}$, and $\sigma^2_{\mathrm{obs}}$. Do not use
  $\tau^2$ for a group variance. Do not use precision as a parameterisation or
  as teaching terminology.
- Teach **Laplace approximation only**. Do not explain, mention, or use
  Gaussian quadrature. The author's phrase "only using Gaussian quadrature"
  conflicts with their immediately preceding instruction to omit it and retain
  Laplace approximation; interpret the intended decision as Laplace only.
- All practical model fits use RTMB and `optim()`. Students understand
  marginalisation and Laplace approximation conceptually, while RTMB performs
  the numerical work.

## Required reading before implementation

Read these files fully before drafting:

1. `AGENTS.md`
2. `STYLE_GUIDE.md`
3. `Chapter_1/Theory.qmd`, particularly the roadmap
4. `Chapter_5/Theory.qmd` and its practical
5. `Chapter_6/Theory.qmd` and its practical
6. `Chapter_7/Theory.qmd` and `Chapter_7/Practicals/material.qmd`
7. `_quarto.yml`
8. existing files under `Chapter_8/`

Chapter 5 supplies likelihood, transformed parameters, `optim()`, Hessians,
profiles, and interval concepts. Chapter 6 supplies ecological response curves.
Chapter 7 combines a curve and observation distribution, introduces `%~%`,
RTMB, and `MakeADFun()`, then explicitly says that Chapter 8 will add random
effects. Retain those object names and teaching patterns where useful.

The worktree is already dirty. Chapter 1's roadmap has author changes; Chapter
8 practical wrappers are placeholders and its former `material.qmd` is deleted.
Preserve unrelated changes. Never reset or discard the user's work.

## Course-wide conventions

`STYLE_GUIDE.md` already contains these newly added durable rules:

- theory and practical material in the same chapter use different datasets;
- variance components use $\sigma^2$ with descriptive subscripts;
- components are described as variances, never precisions;
- $\tau^2$ is not used for a group variance;
- when a density function or code uses standard deviation $\sigma$, explain
  that $\sigma^2$ is the corresponding model variance.

Use direct, conversational British English. Use `$...$` and `$$...$$` for
mathematics, define every new symbol, and use `=` for all R assignment. Do not
use pipe operators. Use named distribution arguments and explain assumptions
before code. Explain R's `dnorm(sd = ...)` as accepting a standard deviation,
even when the model is described through variance.

Theory should use Chapter 7 metadata: HTML table of contents, numbered
sections, global `eval: false`, and explicitly enabled figure chunks. Put
student-run code in plain `r` fences. Use notes for definitions, warnings for
specific misconceptions, and nested important callouts with collapsed solution
tips for short questions and quizzes. Do not edit generated HTML, cache files,
or vendored extensions.

## Expected files and titles

Create or replace only these Chapter 8 sources as needed:

- `Chapter_8/Theory.qmd`, titled `"Grouped ecological response curves"`.
  Use the Chapter 7 theory metadata pattern, including `eval: false` globally.
- `Chapter_8/Practicals/material.qmd`, containing all practical introduction,
  exercises, and conditional solutions.
- `Chapter_8/Practicals/no_solution.qmd`, titled
  `"Chapter 8: Grouped ecological response curves"`.
- `Chapter_8/Practicals/solution.qmd`, titled
  `"Chapter 8: Grouped ecological response curves — solutions"`.
- `Chapter_1/Theory.qmd`, with the one new Chapter 8 roadmap entry described
  below.

`STYLE_GUIDE.md` has already been changed to record the author's dataset and
variance decisions. Preserve those changes; do not duplicate them in a new
style-guide section.

## Theory data and core model

Use `Chapter_7/Practicals/shapes1.csv` in theory only. It has 55 rows: five
responses at each of 11 light intensities from 0 to 1000. Before use, verify
there are five rows per light level and 11 per derived leaf. The author-approved
construction is:

```r
light = read.csv("Practicals/shapes1.csv")
light$leaf_id = factor(rep(1:5, times = 11))
```

Tell students that this ID mapping comes from the original experimental record,
not from a general rule that row order identifies repeated measurements.

Use Chapter 7's net-photosynthesis response:

$$
m(x;r,a,k)=r+a(1-e^{-kx}), \qquad a>0,\quad k>0.
$$

Here $x$ is light intensity, $r$ is expected net photosynthesis at zero light,
$r+a$ is its limiting expected value, and $k$ controls its rate of increase.
Net photosynthesis may be negative at low light when respiration exceeds carbon
fixation.

Use a leaf-specific additive intercept effect as the core new model:

$$
\begin{aligned}
u_j &\sim \operatorname{Normal}(0,\sigma^2_{\mathrm{leaf}}),\\
Y_{ij}\mid u_j,x_{ij} &\sim \operatorname{Normal}\{m(x_{ij};r,a,k)+u_j,
  \sigma^2_{\mathrm{obs}}\}.
\end{aligned}
$$

$Y_{ij}$ is one net-photosynthesis measurement at light intensity $x_{ij}$ on
leaf $j$. $u_j$ is leaf $j$'s deviation from the common curve. Conditional on
the predictor, shared parameters, and a leaf's effect, state the observation
model and conditional independence assumption. Do not call the 55 rows
independent without this qualification.

The three pooling choices must use the same response curve and observation
model so the comparison isolates how group information is shared:

| Model | Leaf component | Question |
|---|---|---|
| Complete pooling | $u_j=0$ for all leaves | What common curve describes the recorded leaves? |
| No pooling | a separately estimated $r_j$ for each leaf | How do these leaves differ when no information is shared? |
| Partial pooling | $r_j=r+u_j$, with $u_j\sim\operatorname{Normal}(0,\sigma^2_{\mathrm{leaf}})$ | What common curve and among-leaf variation describe the data? |

No-pooling group parameters are separate fitted parameters, not random effects.
In the partial-pooling model, $u_j$ are random effects and $r$, $a$, $k$,
$\sigma^2_{\mathrm{leaf}}$, and $\sigma^2_{\mathrm{obs}}$ are shared model
parameters.

## Detailed theory outline

### 1. Introduction and learning goals

Open with the ecological question: how does net photosynthesis vary with light,
and do leaves follow the same curve? Connect to the pooled Chapter 7 example
and explain why the supplied leaf IDs now change the model. State the
observational unit and group unit explicitly.

Learning goals must cover: identifying repeated measurements; complete, no, and
partial pooling; fixed effects, random effects, mixed-effects, hierarchical, and
multilevel terminology; shrinkage and regularisation; the two variance
components; maximum marginal likelihood; intuition and limits of Laplace
approximation; and fitting a grouped RTMB model with `optim()`.

### 2. Plot and identify groups

Plot all leaf trajectories against light. Use symbols or line types as well as
colour, and use documented units or "recorded units". Ask a short callout
question: why do repeated point patterns not establish trajectories if no leaf
identifier is available? Explain the answer using the author-supplied mapping.

### 3. Complete, no, and partial pooling

Revisit the Chapter 7 pooled curve. Present no pooling with separate leaf
intercepts and shared curve shape. Then present partial pooling with $r_j=r+u_j$.
Use an overlaid or faceted figure to show the three model types. Explain what
each shares, what it estimates, and what ecological question it answers.

Add a warning that separate group parameters do not automatically make the
observation model adequate or remove all forms of within-leaf dependence.

### 4. Shrinkage, regularisation, and variance components

Explain partial pooling as a compromise between a common curve and wholly
separate curves. The normal group distribution produces shrinkage: a noisy or
lightly measured leaf is generally pulled further towards the common curve than
a precisely measured leaf. The amount depends on its data and on the estimated
$\sigma^2_{\mathrm{leaf}}$.

Describe regularisation plainly: very large leaf deviations are less compatible
with the group model unless data support them. This comes from the model and its
likelihood, not a correction applied afterwards. Do not say shrinkage proves a
leaf equals the population mean.

The balanced five-leaf data may not show unequal shrinkage clearly. If needed,
use a small, seeded simulation with unequal observations per leaf solely as an
illustration. Label it as simulated, use the same one-predictor response setting,
and do not introduce another fitting framework.

Define units: $u_j$ and $\sigma_{\mathrm{leaf}}$ have response units, while
$\sigma^2_{\mathrm{leaf}}$ has squared response units. The equivalent holds
for $\sigma^2_{\mathrm{obs}}$. Include a note defining both variance
components. Explain that a fitted group variance near zero approaches complete
pooling, while a boundary estimate makes usual large-sample intervals delicate.

### 5. Model terminology

Define terminology only after the concrete model:

- fixed effects: shared, population-level model parameters estimated from these
  data; fixed does not mean known or causal;
- random effects: group deviations modelled with a distribution whose variance
  is estimated;
- mixed-effects model: both shared parameters and random effects;
- hierarchical or multilevel model: observations nested within leaves.

Warn that "random effect" does not mean leaves were randomly allocated to a
treatment. The distribution is a model for among-leaf variation conditional on
the chosen curve and other assumptions.

### 6. Maximum marginal likelihood

First explain the two parts of a candidate leaf effect's joint contribution:
the normal densities of that leaf's measurements around its shifted curve, and
the normal density for that candidate $u_j$. Then give one displayed integral:

$$
L_j(\boldsymbol\theta\mid\mathbf y_j)=
\int_{-\infty}^{\infty}L_j(\boldsymbol\theta,u_j\mid\mathbf y_j)\,du_j.
$$

$\boldsymbol\theta$ contains shared curve parameters and both variance
components. Explain that the integral considers all possible leaf deviations,
weighted by their compatibility with the leaf and population models. The full
marginal likelihood combines contributions across leaves.

Explain why treating only the single best $u_j$ as an ordinary fixed parameter
is a different calculation. Maximum marginal likelihood integrates over the
unobserved effects before comparing shared parameter values and incorporates
uncertainty in the group effects. Do not ask students to calculate the integral.

### 7. Laplace approximation and RTMB

Explain only Laplace approximation:

- The integrand is often largest near the group effect that best balances a
  leaf's observations and the group distribution.
- Near this peak, a smooth log integrand can be approximated by a quadratic.
- A quadratic log curve gives a normal-shaped peak with a calculable area.
  Laplace approximation uses this local shape to approximate the integral.
- It can be unreliable for strongly non-normal conditional shapes, boundaries,
  weak information, or an unsuitable observation model.

Use a peak-and-area figure if it clarifies the explanation, but do not derive a
Laplace formula. Do not mention Gaussian quadrature, Gauss-Hermite rules, nodes,
weights, or other integration methods anywhere in Chapter 8.

For a Gaussian linear random-intercept model the calculation can be exact. Do
not generalise that result to this nonlinear light-response model.

Connect the concept to RTMB with a short model example. The model function
contains a density for `u` and an observation density for `y`; the parameter
list contains a vector `u`; and `MakeADFun(..., random = "u")` tells RTMB to
integrate it out with Laplace approximation. RTMB then returns the marginal
objective and derivatives for `optim()`. It does not guarantee convergence or
that the model describes the data suitably.

When code fits positive standard deviations on a log scale, report the
corresponding model variances by squaring them. Do not name a standard deviation
as though it were a variance. Conditional fitted leaf effects may be used for
plots, but do not call them independent leaf MLEs.

Use official sources for technical RTMB statements:

- <https://cran.r-project.org/web/packages/RTMB/vignettes/RTMB-introduction.html>
- <https://www.jstatsoft.org/article/view/v070i05>

### 8. Interpretation, limits, summary, and quiz

Distinguish a fitted curve for an observed leaf from a prediction for a new leaf;
the latter includes among-leaf variation. State that five leaves provide limited
information about a population distribution, the normal group distribution and
common curve shape are assumptions, and a random intercept may miss differences
in curve shape.

Finish with a concise summary linking to the Loblolly practical. Include a small
quiz with collapsed answers on: grouping versus observational unit; all three
pooling choices; shrinkage; the two variances; what marginal likelihood
integrates over; the intuition behind Laplace approximation; and what
`random = "u"` means in RTMB.

## Practical: `datasets::Loblolly`

Use `datasets::Loblolly` only for the practical. It is built into R and contains
84 tree-height observations: `height` in feet, `age` in years, and a `Seed`
identifier. There are 14 trees with six observations each. State this provenance
without inventing ecological or sampling details.

Before finalising the exercise, plot trajectories and prototype every RTMB model
in a clean R session. A likely candidate mean curve is:

$$
m(t;A,R_0,k)=A-(A-R_0)e^{-kt},\qquad A>0,\quad k>0,
$$

where $t$ is age, $R_0$ is extrapolated height at age zero, $A$ is asymptotic
height, and $k$ controls the approach to the asymptote. Check the curve's
stability and whether interpretation before the first observed age is suitably
qualified. If another simple curve is clearly more stable and interpretable, use
it and explain the decision in the practical.

The core grouped model varies only one component between trees. First test an
additive asymptote effect:

$$
\begin{aligned}
u_j &\sim \operatorname{Normal}(0,\sigma^2_{\mathrm{tree}}),\\
H_{ij}\mid u_j,t_{ij} &\sim \operatorname{Normal}\{m(t_{ij};A+u_j,R_0,k),
  \sigma^2_{\mathrm{obs}}\}.
\end{aligned}
$$

If that lets the optimiser explore invalid tree asymptotes, use a log-asymptote:

$$
\log A_j=\log A+u_j,\qquad
u_j\sim\operatorname{Normal}(0,\sigma^2_{\mathrm{tree}}).
$$

Explain that this moves $\sigma^2_{\mathrm{tree}}$ to the log-asymptote scale
and keeps tree asymptotes positive after exponentiation. Use only the version
that is robust in the core practical.

The practical introduction links to `../Theory.qmd`, tells students to work in
order, says RTMB performs marginalisation after effects are marked random, and
states they need not implement Laplace approximation.

### Exercise 1: grouping and complete pooling

Students load `datasets::Loblolly`, convert `Seed` to an integer RTMB index,
count trees and observations per tree, and plot height against age by tree. They
identify observational and grouping units; fit a complete-pooling normal growth
model in RTMB; inspect convergence; report shared curve parameters and
$\sigma^2_{\mathrm{obs}}$ in appropriate units; overlay the common curve; and
describe a systematic feature it misses.

The solution introduces all code in teaching order, sets explicit starting
values, constructs the RTMB model, uses `MakeADFun()`, and fits with `optim()`
and `obj$gr`. Explain why `optim()` sees only the free parameters from `obj$par`.

### Exercise 2: no pooling

Students fit a model with one separate curve component per tree and common
remaining parameters. They inspect convergence, plot fitted tree curves, identify
large differences from the common curve, and explain what data are shared. The
solution uses a vector indexed by tree ID but does not declare it `random`.
Explain that these are separate fitted parameters, not random effects.

### Exercise 3: partial pooling and shrinkage

Students replace separate parameters with deviations drawn from a normal group
distribution. They add the tree-effect density, use
`MakeADFun(..., random = "u")`, and fit the marginal model with `optim()` and
`obj$gr`. They report shared curve parameters, $\sigma^2_{\mathrm{tree}}$, and
$\sigma^2_{\mathrm{obs}}$, including scales and units. They plot conditional
tree effects only for graphical comparison with no pooling, identify shrinkage,
and explain what RTMB did when `u` was declared random.

### Exercise 4: interpretation and checking

Students calculate an approximate Hessian interval for a meaningful shared curve
parameter and report it on an ecological scale. They distinguish a predicted
curve for an observed tree from one for a new tree. They simulate complete
hierarchical data under the fitted partial-pooling model, including both
tree-level and observation-level variation, then compare observed and simulated
patterns by age and tree. They describe two limitations, including 14 groups and
the choice to vary only one curve component.

Use DHARMa only if it correctly simulates and communicates the full hierarchical
model. A transparent comparison of complete simulated trajectories may be more
appropriate. Do not simulate observation variation alone: it cannot check the
grouped model.

## Practical file architecture

Restore `Chapter_8/Practicals/material.qmd` as shared content. Restore wrappers
following Chapter 7 precisely:

- `no_solution.qmd`: title `"Chapter 8: Grouped ecological response curves"`,
  `date: today`, `quarto::write_yaml_metadata_block(show_solution = FALSE)`,
  then `{{< include material.qmd >}}`.
- `solution.qmd`: title
  `"Chapter 8: Grouped ecological response curves — solutions"`, `date: today`,
  `quarto::write_yaml_metadata_block(show_solution = TRUE)`, then the same
  include.

Use `.content-hidden unless-meta="show_solution"` around each conditional
solution. Do not leave the old Chapter 9 titles.

## Roadmap and navigation

Add a Chapter 8 section directly after Chapter 7 in `Chapter_1/Theory.qmd`.
Mirror the existing three-paragraph roadmap pattern:

- **Key concepts:** repeated measurements nested in groups, complete/no/partial
  pooling, random and fixed effects, shrinkage and regularisation, maximum
  marginal likelihood, and Laplace approximation.
- **R skills and tools:** construct group identifiers; express group models in
  RTMB; declare random effects with `MakeADFun(..., random = "u")`; fit the
  marginal objective with `optim()`; interpret shared parameters, variance
  components, and group-specific fitted curves.
- **How it builds on earlier material:** apply Chapter 7's response curve,
  observation model, and RTMB workflow to repeated measurements without
  requiring manual marginalisation.

Patch only this addition because Chapter 1 has current author edits. `_quarto.yml`
already contains Chapter 8 links; change it only if rendering exposes a broken
link.

## Implementation and quality checks

Prototype and run every solution before writing numerical claims.

1. Use a clean R session and the installed RTMB version; do not install packages.
2. Define inputs and group indices outside each RTMB objective.
3. Use named, valid starting parameters and evaluate the ordinary objective at
   them before `MakeADFun()` where feasible.
4. Build the object, fit with `optim(par = obj$par, fn = obj$fn, gr = obj$gr,
   method = "BFGS")`, and check convergence, gradients if available, sensible
   estimates, Hessian invertibility, and plausible alternate starts.
5. Do not expect the joint ordinary objective to equal the RTMB marginal
   objective after `random = "u"`; explain the distinction if it appears in
   teaching code.
6. Check every theory equation, defined symbol, figure label, and numerical
   claim against executed code.
7. Search changed sources for `tau`, `precision`, `quadrature`, `Gauss`, and
   `Hermite`; the first two must not violate variance rules and the last three
   must be absent from Chapter 8 and its roadmap.
8. Check that theory and practical datasets are different.
9. Render `Chapter_8/Theory.qmd`, `Chapter_8/Practicals/no_solution.qmd`, and
   `Chapter_8/Practicals/solution.qmd`. Inspect both practical outputs: student
   material must hide conditional solutions and the solution page must show them.
10. Check figures for readable labels and group distinctions beyond colour.
11. Run `git diff --check` and perform a focused source review. Report only
    checks that actually ran.

## Final report required from the implementing agent

State the files changed; identify the distinct theory and practical datasets;
describe the partial-pooling model and its named variance components; confirm
that only Laplace approximation is discussed; explain RTMB's role; list the R
and Quarto checks that ran; and identify remaining limitations, especially the
author-supplied leaf-ID reconstruction and the small number of groups.
