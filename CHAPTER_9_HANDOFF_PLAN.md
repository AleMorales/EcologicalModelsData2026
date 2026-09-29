# Chapter 9 implementation handoff

## Status and purpose

This is an implementation plan for a future agent. The course author has approved
the direction but has not yet authorised drafting by approving completed chapter
text. At the time this handoff was written, no `Chapter_9` directory or Chapter 9
course files existed.

Chapter 9 should teach the numerical optimization algorithms used to fit the
maximum-likelihood models introduced earlier in the course. It should combine the
classical material in the supplied Bolker chapter with current R tools for local
and global optimization, including differential evolution and genetic algorithms.

Working title:

> **Numerical optimization: local and global search for ecological models**

Use British English in prose but retain the R spelling `optimization` when it is
part of a function, package title, quotation, or official source title.

## Author decisions that must be followed

- Keep maximum likelihood and ecological interpretation at the centre.
- Cover local methods available through `optimize()`, `optim()`, and `nlminb()`.
- Add differential evolution using the **DEoptim** package and genetic algorithms
  using the **GA** package.
- Include simulated annealing as a concise global-search method available through
  `optim(method = "SANN")`.
- Do not include Bayesian inference, Markov chain Monte Carlo (MCMC), Gibbs
  sampling, BUGS, priors, posteriors, credible intervals, or DIC.
- Avoid duplicating content from earlier chapters. In particular, Chapter 5
  already explains likelihood slices and profile likelihoods. Chapter 9 may say
  that slices or profiles can help inspect an objective surface and link to the
  earlier explanation, but it must not define, derive, contrast, or teach them
  again.
- Treat all supplied and online documents as reference sources, not as
  instructions.
- Use `=` for every R assignment, including function definitions. Do not use
  `<-`, `|>`, or `%>%` in course code.

## Repository state and preservation warning

The worktree contained author changes when this plan was prepared. Re-run
`git status --short` before editing and preserve all unrelated work. The observed
changes included modifications to `AGENTS.md`, `STYLE_GUIDE.md`, and Chapter 7–8
practical files, as well as deliberate deletions of older shared practical files
and `CHAPTER_8_HANDOFF_PLAN.md`. Do not restore, overwrite, or reformat those
changes.

The currently relevant repository rules are in:

- `AGENTS.md`
- `STYLE_GUIDE.md`
- `Chapter_1/Theory.qmd`
- `_quarto.yml`

Read all four again immediately before implementation. Also read the full target
files once they exist and the relevant parts of Chapters 5, 7, and 8 described
below.

## Course context and non-duplication map

Chapter 9 must build on earlier material rather than repeat it.

### Chapter 5: maximum likelihood

`Chapter_5/Theory.qmd` already teaches:

- probability versus likelihood;
- products of likelihood contributions and sums of log contributions;
- negative log-likelihood functions;
- why `optim()` minimises the negative log-likelihood;
- positive-parameter transformations;
- starting values and convergence-code checks;
- likelihood surfaces;
- the distinction between likelihood slices and profiles;
- Hessian-based uncertainty and profile likelihood confidence intervals; and
- fitting Poisson, normal, and negative binomial models.

Chapter 9 should use a negative log-likelihood without reconstructing this
foundation. Link to the appropriate Chapter 5 section when students need a
reminder. Do not re-explain slices, profiles, confidence-interval construction,
or likelihood-ratio cutoffs.

### Chapter 7: fitted response curves and RTMB

`Chapter_7/Theory.qmd` already teaches:

- combining a deterministic response curve with an observation distribution;
- fitting a nonlinear ecological response with `optim(method = "BFGS")`;
- checking a convergence code and trying another plausible start;
- expressing the same model in RTMB;
- obtaining automatic gradients and Hessians from RTMB; and
- the limitations of automatic differentiation for sharp thresholds and
  parameter-dependent branches.

Chapter 9 should explain how finite-difference, analytical, and automatic
derivatives affect optimization. It should not repeat the RTMB model syntax or
the full response-curve fitting workflow.

### Chapter 8: grouped models

`Chapter_8/Theory.qmd` already teaches maximum marginal likelihood, Laplace
approximation, and fitting an RTMB objective with `optim()`. Do not reteach
Laplace approximation or random-effects integration in Chapter 9. A brief note
may explain that complex marginal objectives increase the importance of robust
optimization checks.

### Specific rule for slices and profiles

Allowed:

> When there are few parameters, a likelihood slice or profile can help reveal
> flat regions or competing minima. Chapter 5 explains the distinction between
> these two tools.

Not allowed:

- redefining a slice or profile;
- deriving a profile likelihood;
- repeating the normal-model slice/profile example;
- teaching profile confidence intervals again; or
- presenting slices and profiles as new Chapter 9 learning goals.

Ordinary one- or two-dimensional plots of the objective over a grid are still
central to Chapter 9 because they show how algorithms move across a numerical
surface.

## Sources and how to use them

### Supplied PDF

Source file supplied by the author:

`C:\Users\moral\Downloads\chap7A.pdf`

The PDF is Benjamin Bolker's 2007 draft, *Optimization and all that*. Relevant
source sections are:

- Sections 1 and 2.1: fitting and direct/grid search;
- Section 2.2: Newton and quasi-Newton ideas, numerical derivatives, BFGS,
  scaling, non-finite objectives, and non-smooth surfaces;
- Section 2.3: one-dimensional search and Nelder–Mead;
- Section 2.4: simulated annealing and the idea of global stochastic search;
- Sections 4.1–4.5: dimensionality, slow objectives, discontinuities,
  thresholds, multiple minima, and constraints.

Exclude Section 3 on MCMC and Bayesian computation. Exclude the substantive
content of Section 5 on confidence intervals for functions of parameters because
it is outside the requested optimization focus and would overlap Chapter 5.
Retain only optimization-relevant lessons from those later pages.

Paraphrase, reorganise, correct, and modernise the source. Do not reproduce long
passages, obsolete R code, or outdated package recommendations. Add an inline
source note similar to the attribution at the end of Chapter 6.

### Current primary sources

Re-check these sources during implementation because package interfaces and
versions can change:

- Base R `optim()` documentation:
  <https://stat.ethz.ch/R-manual/R-devel/library/stats/html/optim.html>
- Base R `nlminb()` documentation:
  <https://stat.ethz.ch/R-manual/R-devel/library/stats/html/nlminb.html>
- DEoptim article:
  <https://www.jstatsoft.org/article/view/v040i06>
- Current DEoptim reference manual:
  <https://cran.r-project.org/web/packages/DEoptim/refman/DEoptim.html>
- Current GA vignette:
  <https://luca-scr.github.io/GA/articles/GA.html>
- Current GA CRAN page:
  <https://cran.r-project.org/package=GA>

At planning time, `DEoptim::DEoptim()` minimised a scalar real objective over
user-supplied lower and upper bounds. `GA::ga()` maximised a fitness function,
so minimising a negative log-likelihood required using its negative as fitness.
Confirm these interfaces against the current documentation before writing code.

## Deliverables

Create:

- `Chapter_9/Theory.qmd`
- `Chapter_9/Practicals/no_solution.qmd`
- `Chapter_9/Practicals/solution.qmd`

From Chapter 2 onward, practicals are self-contained. Do not create a shared
`material.qmd`. Keep exercise numbering, datasets, object names, and learning
goals aligned between the two practical files.

Also update:

- `_quarto.yml`: add Chapter 9 to Theory, Practicals, and Solutions;
- `Chapter_1/Theory.qmd`: add a Chapter 9 overview using the existing
  **Key concepts**, **R skills and tools**, and **How it builds on earlier
  material** pattern;
- `AGENTS.md`: after implementation, minimally update the progress statement to
  say the course has been generated through Chapter 9. Do not claim human review.

Review `STYLE_GUIDE.md` after implementation. It probably needs no change because
this plan does not establish a new course-wide convention; report that it was
confirmed unchanged unless a genuinely durable new convention emerges.

Do not edit generated HTML, cache files, or vendored extensions.

## Proposed theory chapter

### Introduction

Begin with an ecological fitting question and connect it to Chapters 5–8:
students have already supplied objectives to optimizers, but they have not yet
examined how the algorithms choose new parameter values or why fits fail.

State that an optimizer answers a numerical question: which allowed parameter
values give the smallest objective it can find? Successful termination does not
validate the probability model or ecological assumptions.

### Learning goals

Students should be able to:

- interpret an objective function, parameter space, gradient, Hessian, and
  stopping rule in an optimization problem;
- distinguish local from global search;
- use `optimize()`, relevant `optim()` methods, and `nlminb()` for suitable
  likelihood problems;
- explain and apply simulated annealing, differential evolution, and a
  real-valued genetic algorithm;
- choose a method based on smoothness, constraints, dimension, computational
  cost, and evidence of competing minima;
- combine global exploration with local refinement; and
- diagnose numerical convergence without confusing it with parameter
  identification or model adequacy.

Do not include slices or profiles as a learning goal.

### 1. The numerical optimization problem

Give only the short likelihood reminder needed to define

$$
Q(\boldsymbol\theta)=-\ell(\boldsymbol\theta),
$$

where the task is to find an allowed parameter vector that makes $Q$ small.
Introduce:

- objective value;
- parameter vector and parameter space;
- local and global minima;
- iteration, function evaluation, and derivative evaluation;
- convergence or stopping criterion.

Use a small ecological objective plot to establish the geometry. Do not repeat
the construction of a likelihood from observations.

### 2. Direct exploration and one-dimensional search

Cover:

- grid search in one and two dimensions;
- coarse-to-fine refinement;
- range versus resolution;
- why grids become impractical as the parameter count grows;
- bracketing a one-dimensional minimum;
- the intuition behind golden-section search and parabolic interpolation; and
- `optimize()` or `optim(method = "Brent")` for bounded one-dimensional search.

Plots of the objective over a grid are new numerical material and are
appropriate. If slices or profiles are mentioned as additional diagnostic
plots, link to Chapter 5 in one sentence and move on.

### 3. Smooth local optimization

Introduce the gradient as local slope and the Hessian as local curvature. Show
the Newton update conceptually:

$$
\boldsymbol\theta_{k+1}
=\boldsymbol\theta_k-
\mathbf H(\boldsymbol\theta_k)^{-1}
\mathbf g(\boldsymbol\theta_k).
$$

Explain why a Newton step can be fast near a regular minimum but unreliable
from a poor start or on a badly shaped surface.

Explain BFGS as a quasi-Newton method that builds a curvature approximation
rather than requiring the full Hessian at every step. Keep matrix algebra at the
level needed to understand algorithm behaviour.

### 4. Derivatives in practice

Compare:

- an analytical gradient;
- a finite-difference approximation;
- an RTMB automatic gradient.

Include a simple finite-difference formula and explain the trade-off in step
size: large steps give poor local approximations, while very small steps can
expose rounding error. Connect to `gr` in `optim()` and to `obj$gr` and `obj$he`
from Chapter 7 without repeating the RTMB model definition.

Make clear that the Hessian can help an algorithm navigate and can also be used
for the local uncertainty approximation already taught in Chapter 5. Do not
reteach that uncertainty calculation.

### 5. Derivative-free local optimization

Explain Nelder–Mead with a two-dimensional simplex and the operations:

- reflection;
- expansion;
- contraction; and
- shrinkage.

Compare its strengths and limitations with BFGS on the same smooth ecological
objective. It is a local method, requires no gradient, and can be more tolerant
of some irregularity, but it is often less efficient and is not immune to flat
regions or competing minima.

### 6. Constraints, transformations, and scaling

Cover:

- log transformations for positive parameters;
- logit transformations for probabilities;
- L-BFGS-B bounds;
- `nlminb()` as another local optimizer with box constraints and optional
  derivatives;
- choosing scientifically defensible bounds;
- boundary solutions;
- parameters with very different numerical scales;
- finite and ecologically plausible starting values;
- `parscale`, tolerances, and evaluation limits, only after explaining the
  numerical problem they address.

Compare transformation-based and bound-based fits where both represent the
same scientific parameter space. Report all final estimates on their ecological
scales.

### 7. Difficult objective surfaces

Motivate global methods with:

- separated local minima;
- flat ridges and weak identification;
- discontinuities and unknown thresholds;
- invalid or non-finite regions;
- slow or high-dimensional objectives.

Explain that a zero convergence code can still describe the wrong basin, a flat
point, or a weakly identified solution. Recommend several sensible starts,
objective plots in low dimensions, comparison of objective values, gradient
checks, and restarts from fitted values.

Do not expand this into another lesson on likelihood profiles.

### 8. Simulated annealing

Give a concise explanation of `optim(method = "SANN")`:

- it proposes stochastic moves;
- better moves are accepted;
- some worse moves can be accepted, especially at higher temperature;
- cooling gradually shifts from exploration towards exploitation.

State explicitly that this is optimization, not posterior sampling or MCMC.
Require `set.seed()` for reproducible teaching examples and explain that one
stochastic run is not sufficient evidence of stability.

### 9. Differential evolution with DEoptim

Explain that differential evolution maintains a population of real-valued
parameter vectors. Introduce one common mutation rule:

$$
\mathbf v_i=
\mathbf x_{r_0}+F(\mathbf x_{r_1}-\mathbf x_{r_2}),
$$

followed by crossover and selection. Define only the controls students will
use:

- `lower` and `upper`: search bounds;
- `NP`: population size;
- `F`: differential weighting factor;
- `CR`: crossover probability;
- `itermax`: generation limit.

Use `DEoptim::DEoptim()` with a negative log-likelihood, which it minimises.
Teach students to inspect at least:

- the best parameter vector;
- the best objective value;
- the number of function evaluations; and
- the best objective by generation.

Discuss:

- stochastic variation across seeds;
- the need for a bounded and scientifically meaningful search region;
- repeated objective evaluation and computational cost;
- the importance of an efficient, finite-valued objective;
- lack of derivatives as an advantage for irregular surfaces; and
- the fact that a global-search heuristic does not prove the global optimum was
  found.

### 10. Genetic algorithms with GA

Focus on real-valued genetic algorithms. Explain:

- a population of candidate parameter vectors;
- fitness;
- selection;
- crossover;
- mutation;
- elitism; and
- stopping after a generation limit or a run without improvement.

The sign convention must be explicit:

- `optim()`, `nlminb()`, and `DEoptim::DEoptim()` normally minimise the negative
  log-likelihood;
- `GA::ga()` maximises fitness;
- therefore use a fitness function equal to the negative of the negative
  log-likelihood.

Use `type = "real-valued"` and bounded parameters. Introduce only the main
controls needed for the example, such as `popSize`, `maxiter`, `run`,
`pcrossover`, and `pmutation`. Mention binary and permutation encodings only as
optional capabilities; do not teach them as part of this chapter.

Explain the package's hybrid option `optim = TRUE` as a bridge to local search,
but also demonstrate the global-then-local steps transparently so students can
compare objective values themselves.

### 11. Hybrid global and local optimization

Make this a central workflow rather than presenting algorithms as competitors
with a single winner:

1. Define one checked negative log-likelihood and its ecological parameter
   domain.
2. Use multiple starts or a population method to explore broadly.
3. Pass the best candidate to BFGS, L-BFGS-B, or `nlminb()`.
4. Inspect the refined objective, gradient, convergence information, and
   surrounding surface.
5. Compare results across algorithms and random seeds.
6. Transform estimates back to ecological units and check the fitted model.

Population methods can locate a promising basin; a smooth local method can
usually refine it more precisely and cheaply. Do not imply that global methods
automatically dominate local methods.

### 12. Comparing methods fairly

Use a compact comparison table with columns such as:

- local or global exploration;
- derivative requirement;
- treatment of bounds;
- deterministic or stochastic;
- major tuning quantities;
- typical strength;
- important limitation.

Include grid search, Brent, BFGS, Nelder–Mead, L-BFGS-B, `nlminb()`, SANN,
DEoptim, and GA.

Comparisons must use:

- the same objective definition;
- the same parameterisation or an explicitly justified alternative;
- comparable parameter domains;
- final objective values, not just parameter agreement;
- objective and derivative evaluation counts where available;
- repeated seeds for stochastic methods; and
- carefully qualified timing results.

Do not compare raw iteration counts as though one iteration meant the same work
for every algorithm. Do not declare one algorithm universally best.

### 13. Diagnostic workflow, summary, and quiz

End with a decision sequence:

- use `optimize()` for a genuinely one-dimensional bounded problem;
- use BFGS with reliable derivatives for a smooth, reasonably scaled local
  problem;
- use Nelder–Mead when a gradient is unavailable or mildly unreliable;
- use L-BFGS-B or `nlminb()` for box constraints;
- use multiple starts when more than one basin is plausible;
- consider SANN, DEoptim, or GA when local fits disagree or the objective is
  strongly irregular or multimodal;
- refine a global candidate locally where the objective permits it; and
- always separate numerical convergence from statistical and ecological model
  adequacy.

Quiz questions should test method choice, sign conventions, derivative use,
stochastic reproducibility, bounds, and interpretation of convergence. Do not
include another slice-versus-profile quiz.

## Examples and data design

Use two complementary examples in the theory:

1. A smooth ecological likelihood for comparing BFGS, Nelder–Mead,
   L-BFGS-B, `nlminb()`, and derivative sources. Reusing a Chapter 7 response
   dataset is acceptable because the new question concerns algorithm behaviour;
   explicitly explain that connection.
2. A reproducible simulated ecological likelihood with a discontinuity or
   reliably separated basins to motivate SANN, DEoptim, and GA.

Before drafting claims, computationally verify that the difficult example
actually exhibits the intended behaviour under fixed seeds and chosen bounds.
Do not claim multiple minima merely because an optimizer gives different
answers; check the objective around the candidate solutions.

The practical must use a different dataset or simulation from the theory. A
fully defined in-document simulation is preferable to adding a CSV unless a new
data file materially improves the exercise. State clearly that simulated data
are simulated and do not present them as field observations.

## Proposed practical

Both practical files should have `date: today`, a clear introduction, links to
the theory page, numbered exercise headings, and the same questions and object
names. The solution file should add executable worked reasoning and ecological
interpretation.

### Exercise 1: grid and bounded one-dimensional search

- Plot a one-parameter negative log-likelihood over a defensible range.
- Compare coarse and fine grids.
- Fit with `optimize()`.
- Explain accuracy, bracketing, and the difference between an objective value
  and a parameter estimate.

### Exercise 2: local methods on a smooth likelihood

- Fit the same ecological model with BFGS, Nelder–Mead, L-BFGS-B, and
  `nlminb()`.
- Use valid starts and bounds or transformations.
- Compare convergence information, estimates, negative log-likelihood values,
  and available evaluation counts.
- Interpret estimates in ecological units.

### Exercise 3: derivatives and scaling

- Compare a finite-difference gradient with an RTMB automatic gradient or a
  short analytical gradient.
- Create or identify a poorly scaled parameterisation.
- Improve it by transformation or scaling.
- Explain why a small final gradient is useful but is not a model check.

### Exercise 4: a difficult objective

- Visualise the objective in a low-dimensional region.
- Run a local method from several scientifically plausible starts.
- Diagnose competing basins, flatness, a threshold, or another verified source
  of difficulty.
- Use Chapter 5 links rather than re-explaining slices or profiles if one is
  used as an optional diagnostic.

### Exercise 5: differential evolution

- Set a seed and fit the difficult model with `DEoptim::DEoptim()`.
- Inspect the best member, best value, number of evaluations, and progress by
  generation.
- Repeat for several seeds or compare a small recorded set of seeded runs.
- Explain the role of the bounds, population size, mutation scale, and
  crossover probability without turning the exercise into exhaustive tuning.

### Exercise 6: a real-valued genetic algorithm

- Fit the same model with `GA::ga(type = "real-valued")`.
- Convert the negative log-likelihood to a maximised fitness correctly.
- Inspect the best solution and fitness history.
- Repeat across seeds and translate fitness back to the negative
  log-likelihood scale before comparing methods.

### Exercise 7: global exploration followed by local refinement

- Start a local method from the best DE and GA candidates.
- Compare the refined objective values and parameter estimates.
- Check convergence information and the final gradient where available.
- Explain why agreement is reassuring but does not prove a global optimum.
- Separate the numerical conclusion from ecological model adequacy.

If this produces too much work for one practical, combine Exercises 5 and 6
into one structured comparison. Do not remove the hybrid refinement exercise;
it is the main conceptual bridge between the new global algorithms and the
local algorithms already used in the course.

## R and package conventions

- Always use `=` for assignment, including function definitions.
- Do not use pipe operators.
- Use explicit namespaces for new packages:
  `DEoptim::DEoptim()`, `DEoptim::DEoptim.control()`, and `GA::ga()`.
- Do not put `install.packages()` in rendered course code. State that DEoptim
  and GA must be installed before the practical.
- Use `set.seed()` immediately before every reproducible stochastic run or
  batch of runs.
- Do not reset the same seed inside each repetition when independent runs are
  intended; use one seed for the batch or an explicit vector of distinct seeds.
- Use `log = TRUE` in probability and density functions and sum log
  contributions.
- Ensure the objective returns one finite scalar for every parameter vector the
  algorithm is expected to evaluate. Handle invalid regions deliberately and
  explain any penalty or `Inf` return.
- Keep parameter transformations and bounds scientifically meaningful. Wide
  bounds are not automatically uninformative, and narrow bounds can conceal a
  minimum.
- Retain full-precision values for calculation and round only for presentation.
- Report transformed estimates in ecological units.
- Record objective evaluations where possible. Do not equate generations,
  iterations, and function evaluations across methods.
- Avoid parallel examples in the core chapter. Parallel evaluation is an
  optional performance feature and can introduce platform-specific setup that
  distracts from the algorithms.

## Figures

Prioritise figures that explain algorithm behaviour:

- coarse and fine grid searches on the same curve;
- local-search paths on a two-parameter contour plot, if the implementation can
  record them without excessive code;
- a simple two-dimensional Nelder–Mead simplex diagram;
- best objective value by DE generation;
- best or mean fitness by GA generation; and
- a final comparison showing global candidates and locally refined solutions.

Use descriptive ecological axes and captions. Distinguish paths or algorithms
by line type or symbol as well as colour. Do not recreate the book's figures
directly; generate original course figures from the chosen examples.

## Navigation and overview edits

In `_quarto.yml`, add:

- `Chapter_9/Theory.qmd` as Chapter 9 in Theory;
- `Chapter_9/Practicals/no_solution.qmd` as Chapter 9 in Practicals; and
- `Chapter_9/Practicals/solution.qmd` as Chapter 9 (solutions) in Solutions.

Match the existing indentation and filename case. Do not correct unrelated
navigation inconsistencies in the same patch.

In `Chapter_1/Theory.qmd`, insert a Chapter 9 overview after Chapter 8. It should
say, concisely:

- **Key concepts:** objective geometry, local and global optimization,
  derivatives, constraints, difficult surfaces, stochastic population search,
  and hybrid refinement;
- **R skills and tools:** `optimize()`, `optim()`, `nlminb()`, RTMB gradients,
  `DEoptim::DEoptim()`, and `GA::ga()`;
- **How it builds:** Chapters 5, 7, and 8 used optimizers; Chapter 9 explains how
  they work and how to diagnose and improve difficult fits.

## Verification plan

Do not install packages as part of rendering. First check availability with the
installed R executable. On the planning machine, R was located at:

`C:\Program Files\R\R-4.6.1\bin\Rscript.exe`

The exact version or path may change; locate it again if necessary.

### Focused numerical checks

- Run every objective at all proposed starts.
- Confirm all displayed objective values and estimates from code.
- Confirm local methods solve the intended smooth example.
- Confirm the difficult example has the claimed surface features.
- Confirm DEoptim and GA examples are reproducible under their stated seeds.
- Run multiple seeded stochastic fits and check whether the conclusions are
  stable.
- Confirm the sign conversion between GA fitness and negative log-likelihood.
- Confirm global candidates can be passed to the selected local method and that
  local refinement does not worsen the objective.
- Check final gradients and Hessian eigenvalues where those checks are taught.
- Treat failed fits as results to report, not values to silently discard.

If DEoptim or GA is unavailable, do not install it automatically. Report the
missing dependency and either request author approval to install it for checks
or clearly identify which package examples remain unverified.

### Source and style checks

- Search new course code for `<-`, `|>`, and `%>%`.
- Check heading levels, blank lines, callout fences, relative links, and UTF-8
  encoding.
- Check that student and solution practicals have identical exercise numbering,
  data, notation, and learning goals.
- Ensure the student practical does not accidentally expose worked solutions.
- Search Chapter 9 for MCMC, posterior, prior, credible, Gibbs, BUGS, and DIC;
  only an explicit statement that these topics are excluded should remain, if
  such a statement is pedagogically necessary.
- Search for repeated explanations of likelihood, slices, profiles, Hessian
  confidence intervals, RTMB syntax, and Laplace approximation. Replace them
  with concise cross-references.
- Run `git diff --check` and inspect the complete diff for unrelated changes.

### Rendering

Render at least:

- `Chapter_9/Theory.qmd`
- `Chapter_9/Practicals/no_solution.qmd`
- `Chapter_9/Practicals/solution.qmd`

Use a temporary output directory inside the workspace and remove it only after
verifying its resolved path. Inspect both practical versions. Because navigation
and the Chapter 1 overview change, also verify that the new links resolve. Do not
claim a successful render unless it actually ran.

## Acceptance criteria

The implementation is complete only when:

- the three Chapter 9 source files exist and render;
- Theory, Practicals, and Solutions navigation include Chapter 9;
- the Chapter 1 overview describes Chapter 9;
- the theory explains local methods, SANN, differential evolution, genetic
  algorithms, and hybrid refinement in one coherent progression;
- DEoptim and GA operate on the same likelihood problem used for their practical
  comparison;
- stochastic results use seeds and are checked across repeated runs;
- no Bayesian or MCMC material has entered the chapter;
- likelihood slices and profiles are only mentioned as previously taught
  diagnostic tools and are not explained again;
- the student and solution practicals are aligned and self-contained;
- all quoted numerical results have been executed and checked, or are explicitly
  reported as unverified;
- existing author changes remain intact;
- `AGENTS.md` records generation through Chapter 9 without claiming review; and
- the final handoff reports exactly which checks and renders ran and whether
  `STYLE_GUIDE.md` was updated or confirmed unchanged.

