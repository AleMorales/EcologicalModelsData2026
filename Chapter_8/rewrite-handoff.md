# Handoff: rewrite of Chapter 8 (numerical optimisation)

This file tells future agents how to rewrite Chapter 8: theory, practical, one lecture, and the
cross-references and builds that depend on them. The scope, examples and structure below were
settled with the author on 4 November 2026. Do not change them without asking. Routine wording,
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
| 0 | Done on 4 November: the author's decisions, feasibility checks in R, this plan | This file, one line in `.claude/docs/chapters-7-8-other.md` | This file |
| **1** | Theory, part A: front matter to the end of "Starting values and multiple starts" | `Chapter_8/Theory.qmd` | Part A renders and every number is checked in R |
| **2** | Theory, part B: identifiability and boundaries, scaling and parameterisation, other optimisers and global search, recipe, summary, quiz | `Chapter_8/Theory.qmd` | The whole page renders in the dev profile |
| **3** | Practical: student page and solutions | `Chapter_8/Practicals/no_solution.qmd`, `solution.qmd` | Both pages render |
| **4** | Independent review of theory and practical (statistics, voice, code, numbers), with fixes | The three pages | A review report in "Progress log" |
| **5** | Lecture: figures, slides, demo script | `Chapter_8/Lecture/` | The deck renders and every slide was inspected |
| **6** | Lecture script and its PDF | `Chapter_8/Lecture/lecture-script.md`, `.pdf` | The script agrees with the slides |
| **7** | Integration: links and promises elsewhere, guidance files, production build, final report | Other pages, `AGENTS.md`, style guides, `_quarto-prod.yml`, `publish.yml`, glossary | Production render and the report to the author |

**Branch and commits.** Work on branch `chapter_8` (created from `main` after the Chapter 7
rewrite was merged; Stage 0 starts at commit `2dee366`). The author asked for a commit at the
end of every stage, so that the next agent can see what the previous stage added: commit the
files of that stage with the message `Chapter 8 rewrite: stage N` and the attribution lines of
the session. Never push. Leave unrelated changes in the working tree alone.

**R.** R is not on the `PATH` of the Bash tool. Use `"/c/Program Files/R/R-4.6.1/bin/Rscript.exe"`
(R 4.6.1 with RTMB 2.0, RTMBdist 1.1.0, TMB 1.9.25, emdbook 1.3.14, DHARMa 0.5.0, glmmTMB
1.1.15.2, DEoptim and GA, the last two installed by the author on 4 November). Quarto is on the
`PATH`. Run R scripts from files in the scratchpad (no Python is available; a `python` call
hangs on a Windows stub). Never install packages.

**Launch prompt for a stage** (the author or an orchestrating session pastes it):

> Read `Chapter_8/rewrite-handoff.md` in full, then carry out Stage N exactly as it describes.
> Read the files that "Read first" lists for your stage before editing. Verify every number you
> write in R. When you finish, add your line to "Progress log", list any new question under
> "Open questions for the author", commit as the file says, report what you changed and which
> checks ran, and stop. Do not start the next stage.

## Read first

Every stage reads, in this order:

1. `CLAUDE.md`, `AGENTS.md`, `STYLE_GUIDE.md`. The priority section on the author's voice and the
   sections "Presenting code in the text" and "Maximum likelihood with RTMB" are binding.
2. This file in full.
3. `Chapter_1/Theory.qmd`, sections "The modelling cycle" (the bullet on estimation) and
   "Chapter 8: Numerical optimisation" (the promises that Chapter 8 must keep, or that Stage 7
   corrects).

Then, by stage:

- **Stages 1, 2 and 4:** `Chapter_7/Theory.qmd`: front matter, Introduction, Learning goals and
  roadmap (the most recent rewrite; the reference for structure, depth, R pattern, figures,
  boxes, Practice callouts, the recipe and the quiz), "Three ways to share information" (the
  complete-pooling CO₂ model that Chapter 8 revisits: `co2`, `co2_data`, `pooled_nll`, its
  starting values), "Random effects in RTMB" (including the technical detail box that sends
  Newton's method to Chapter 8) and the recipe, summary and quiz. `Chapter_6/Theory.qmd`:
  "Fitting a response curve by maximum likelihood" with "The gradient and automatic
  differentiation" (`#sec-makeadfun`, the finite-difference promise and the warning callout on
  thresholds) and "Standard errors and correlation of the parameters" (the Michaelis–Menten
  against Holling correlation). `Chapter_4/Theory.qmd`: "Numerical optimisation", "Constraints
  and transformations" (`#sec-constraints`, the callout "When a fit fails"), "Models with several
  parameters" (`#sec-likelihood-surface`), "Parameterisation, slices and profiles" (the promise
  that slices return as a diagnostic and that parameterisation matters for optimisation) and
  "Curvature and standard errors" (`#sec-curvature`). `Chapter_5/Theory.qmd`, around lines 720 to
  736 (finite difference) and 1160 to 1172 (partial derivatives and optimisers). The current
  `Chapter_8/Theory.qmd` (to see what is replaced; do not copy its wording, which is generated
  and stale; its topic coverage is useful).
- **Stage 3:** the theory as Stages 1 and 2 left it; `Chapter_7/Practicals/no_solution.qmd` and
  `solution.qmd` (the reference for format, worked exercise and question headings; Exercise 1,
  the loblolly pines, and Exercise 5, the REML simulation, which Chapter 8 revisits);
  `Chapter_4/Practicals/no_solution.qmd` and `solution.qmd`, Exercise 4, question 4 and its
  solution (the Adelie Gamma fit in grams, which Chapter 8 revisits); the current Chapter 8
  practical.
- **Stage 4:** everything that Stages 1 to 3 read, and the three new pages.
- **Stages 5 and 6:** `STYLE_GUIDE_LECTURE.md`; `Chapter_7/rewrite-handoff.md`, sections "The
  lecture", "Checks for Stage 5", "Stage 6" and the Stage 5 and 6 entries of its "Progress log"
  (what failed at slide size); `Chapter_7/Lecture/` (`lecture.qmd`, `lecture-script.md`,
  `demo-pooling.R`, `lecture-assets/figures.R`): the most recent deck and the reference for
  format, amount of text, demo and script; `Chapter_3/Lecture/lecture.qmd` (the author's own
  edits of format); the new Chapter 8 theory and practical.
- **Stage 7:** every file listed in "Stage 7" below.

## Author's decisions (4 November 2026)

**Examples and data**

- **No new data set in the theory: it revisits models of earlier chapters** (author's decision).
  Each difficulty is shown on a model that students already fitted. The main thread is the
  complete-pooling CO₂ model of Chapter 7 (`datasets::CO2`, `pooled_nll`, the saturating
  exponential with a Normal observation model), which stops in several wrong places from
  plausible starting values (see "Numbers checked"). The reed frog functional response of
  Chapter 6 (`emdbook::ReedfrogFuncresp`, two parameters) supplies the picture of a search on a
  surface and the estimates that drift to a boundary; the owl model of Chapter 4 (`glmmTMB::Owls`,
  satiated broods, female parents) the effect of parameterisation; the fir counts of Chapter 4
  (`boot::fir`) the one-parameter search with `optimize()`. The CO₂ model with a random asymptote
  (Chapter 7, `mixed_nll`) appears in one paragraph.
- **No new example with several maxima** (author's decision). There is no threshold or
  change-point model and no simulated data in the theory. Convergence problems met in earlier
  chapters are solved with multiple starting values (and, as a last resort, global search on the
  same models).
- **The practical revisits fits of earlier practicals** (the theory and the practical use
  different data, as `STYLE_GUIDE.md` asks): the loblolly pines (Chapter 7, Exercise 1), the
  Adelie body masses with a Gamma model (Chapter 4, Exercise 4) and the REML simulation of the
  variance among sites (Chapter 7, Exercise 5). Each keeps an explicit promise of the earlier
  page. Details under "The practical".

**Structure and depth**

- **Organised by problem** (author's decision): every section opens with the general statement
  of a difficulty, shows it on a fit from an earlier chapter that goes wrong, explains as much of
  the mechanism as is needed to understand it, and gives the remedy. **Five sections** (author's
  decision): (1) a fit that stops in the wrong place, with how a gradient method searches, exact
  and approximate gradients, stopping rules and the diagnosis of a fit; (2) starting values and
  multiple starts; (3) ridges, boundaries and identifiability; (4) scaling and parameterisation;
  (5) other optimisers and global search. Then a recipe, the summary and the quiz.
- **Concepts only, no algorithm coded by hand** (author's decision): the main text explains
  each algorithm in words and with figures; formulas (the Newton step, the BFGS update, finite
  differences, the mutation of differential evolution) go in statistical or technical detail
  boxes without R chunks; every algorithm is called from an R function (`optim()`, `nlminb()`,
  `optimize()`, `DEoptim::DEoptim()`). No Newton iteration, finite difference, simplex step or
  line search in a visible chunk. Hidden chunks may record the path of an optimiser for a figure.
- **Algorithms** (author's decision): BFGS (as in every chapter; Newton's method as its idea),
  `nlminb()` (the optimiser of TMB's examples and glmmTMB's default), Nelder–Mead, `optimize()`
  for one parameter, multiple starting values, and differential evolution with
  `DEoptim::DEoptim()` as the one global method, always followed by a local refinement with BFGS.
  **SANN and genetic algorithms are dropped** (GA is named in at most one sentence as another
  global method); Stage 7 changes the sentence of Chapter 1 that promises `ga()` and removes GA
  from `publish.yml`.
- **Identifiability: a full treatment** inside section 3 (author's decision; Chapter 1
  promises it): structural and practical non-identifiability, with the diagnostic tools that
  students know (slices, `TMB::tmbprofile()`, standard errors and correlations from
  `sdreport()`, its warning that the Hessian is not positive definite).
- **Bounds are mentioned only** (author's decision): one paragraph says that L-BFGS-B
  (`optim(method = "L-BFGS-B")`) and `nlminb()` accept lower and upper bounds, and why the course
  keeps transformations. No `lower` or `upper` in code, except the search box of `DEoptim()`,
  which the method needs.
- **The course keeps BFGS with RTMB's gradient** as its method; no other chapter changes.
  Chapter 8 shows other optimisers as the next tool when BFGS fails, with `obj$fn` and `obj$gr`
  of the same `MakeADFun()` object.

**Practical:** **three exercises, fewer and deeper** (author's decision), no extra exercise.
Each is a full diagnosis: the symptom, the diagnosis, the remedy and the confirmation.

**Lecture:** **one lecture of 150 minutes** (two breaks of 10) in `Chapter_8/Lecture/`, with
**one live demo of 18 minutes** (2 at the slide, 16 in R) from `demo-diagnosis.R`: **diagnosing a
failed fit** (author's decision): take a model that stops in the wrong place from a poor start,
read the convergence code, the estimates, the gradient and `sdreport()`, run multiple random
starts, refine the best with BFGS and confirm it with a slice or a profile. No comparison of
many optimisers in the demo.

**Build:** Stage 7 adds the theory, practical, solutions and lecture of Chapter 8 to
`_quarto-prod.yml` (author's decision) and removes `any::GA` from
`.github/workflows/publish.yml` (no page will load it); `DEoptim` stays.

## Choices I made within those decisions (the author may overrule them in review)

- **Title:** `"Numerical optimisation"` (the heading of the Chapter 1 roadmap).
- **Size:** the theory stays below about 1,600 source lines (five sections and no hand-coded
  algorithms; Chapter 6 has about 1,710 and Chapter 7 about 2,070). Principles over examples: no
  detail of an earlier data set beyond what the difficulty needs; the earlier chapter is linked,
  not retold.
- **Section IDs** (new; nothing links into the current page except plain links to
  `../Chapter_8/Theory.qmd`): `#sec-wrong-place` (section 1) with `#sec-search`,
  `#sec-gradients`, `#sec-stopping` and `#sec-diagnosis`; `#sec-multistart` (2);
  `#sec-identifiability` (3) with `#sec-boundaries`; `#sec-scaling` (4);
  `#sec-other-optimisers` (5) with `#sec-global`. Stage 7 links promises to these IDs.
- **`reltol`** is named in the text (what it is, its default $\sqrt{\epsilon}\approx1.5\times10^{-8}$
  in `optim()`) but never set in code, so the course rule stands: the remedies taught are a
  restart, rescaling, reparameterisation, multiple starts and another optimiser. `parscale` is
  shown once, in the scaling section, as what `optim()` offers for poorly scaled parameters; the
  text says that a transformation is the course's usual answer.
- **The Hessian:** no `obj$he()` in visible code. The check is `sdreport()`: its warning that the
  Hessian of the fixed effects is not positive definite, the element `pdHess` and standard errors
  that are `NaN`. What "positive definite" means (all curvatures positive; a zero curvature is a
  flat direction; a negative one a saddle) goes in a statistical detail box, linked to Chapter
  4's `#sec-curvature`. Hidden chunks may use `obj$he()` to verify a claim.
- **Slices as a diagnostic** (Chapter 4 promised it): a slice through a suspicious solution along
  one parameter, with a `for` loop over `obj$fn()` as in Chapter 4, on the relative scale.
- **Multiple starts:** a `for` loop (not `sapply()`), starting values drawn with `runif()` on the
  optimised scale within a box that covers plausible values in ecological units (stated in
  units and transformed), a seed set once before the loop, `try()` around each fit only if a
  start can make `optim()` stop with an error (check; say why if used), and a table of where the
  fits ended. Keep the lowest NLL; say how many starts reached it; restart BFGS from it.
- **`DEoptim::DEoptim()`** with the prefix (do not attach the package), on `obj$fn` directly
  (checked: it runs without a wrapper on the CO₂ box), `control =
  DEoptim::DEoptim.control(NP = 40, itermax = 200, trace = FALSE)`, a seed, and BFGS from
  `bestmem` afterwards. Its arguments (`fn`, `lower`, `upper`, `control`) and the elements of the
  result that are used (`optim$bestmem`, `optim$bestval`, `optim$nfeval`) are bullets.
- **`nlminb()`** without bounds: `nlminb(start = obj$par, objective = obj$fn, gradient =
  obj$gr)`; arguments and result elements (`par`, `objective`, `convergence`, `message`,
  `evaluations`) as bullets. Say once that glmmTMB uses it by default (checked:
  `glmmTMBControl()` has `optimizer = nlminb`) and link to `Supplements/canned.qmd`. Results from
  50 starts are "in this example", never a ranking of optimisers.
- **Numbered `Practice` callouts** (`imp-` IDs), three, as in Chapters 6 and 7: one in section 1
  (judge three printed fits), one in section 3 (identifiability on paper), one in section 4
  (scaling or parameterisation, R as a calculator). Stage 7 updates `STYLE_GUIDE.md` (Chapter 8 is
  numbered too).
- **Roadmap table** after the learning goals (Problem; How it shows; What to do; In R) and a
  **recipe** callout before the summary, as in Chapters 4, 6 and 7.
- **Seeds:** theory 801 and up; practical 811 and up (Exercise 1), 821 and up (Exercise 2), 751
  (Exercise 3, the seed of Chapter 7's simulation, so that the same samples return).
- **Stage 4 exists** because the author does not review between stages: a fresh agent who did
  not write the pages checks them.

## Rules that matter most

These come from the author's corrections of Chapters 3 to 7 and their lectures. They are in
`STYLE_GUIDE.md`, `STYLE_GUIDE_LECTURE.md` and `AGENTS.md`; they are repeated here because they
are the ones that generated text breaks most often.

1. **Definition first, example second.** Each section opens with the general difficulty in bold
   and general symbols ($\boldsymbol\theta$, $-\ell(\boldsymbol\theta)$, "a parameter", "a
   starting value"), then the fit from the earlier chapter. Never open with the plants, the
   tadpoles or the owls.
2. **Principles over examples.** The earlier model serves the general statement. Recall a model
   in one or two sentences with a link; do not retell its chapter.
3. **No algorithm by hand** (author's decision above), and no calculation by hand that a TMB tool
   does: no Hessian by hand, no delta method in R, no profile with a loop of inner fits, no
   `uniroot()`. `sdreport()`, `TMB::tmbprofile()` with `confint()`, `obj$gr()`.
4. **One step, one chunk, next to its explanation**; bullets for the items of a recipe (the
   arguments of `nlminb()` and `DEoptim()`, the elements of their results, the checks of a
   diagnosis); do not repeat in the text a number that the chunk prints unless it is compared or
   interpreted.
5. **Voice:** no quips, no scene-setting hooks, no "X, not Y" reflex, one caveat where the risk
   is (the obvious one here is "a convergence code of zero does not mean that the maximum was
   found": say it **once**, in `#sec-stopping`, perhaps as the one warning callout, and do not
   repeat it in every section and quiz answer), no first-person opinion invented for the author,
   no leaking of the authoring process (the current chapter's "This verified piecewise
   structure" is the example of what not to write). Formal register. British English
   (optimiser, optimisation, parameterisation, behaviour).
6. **Notation:** $\log(x)$ with parentheses; the NLL is $-\ell(\boldsymbol\theta)$; the gradient
   $\nabla$ or $\mathbf g(\boldsymbol\theta)$ and the Hessian $\mathbf H(\boldsymbol\theta)$,
   defined once (symbols only inside boxes must not be relied on by the main text); "likelihood
   profile", never "profile likelihood"; "hypothetical samples" for repeated sampling (Exercise
   3); "model", "data generating process". Units with a slash (µL/L, µmol/m²/s, L/µL, ft, g, kg).
7. **R:** `=` for assignment, no pipes, `silent = TRUE`, `method = "BFGS"` and `gr = obj$gr` for
   every BFGS fit, never `reltol`, RTMB first and RTMBdist second, distribution functions from
   RTMB or RTMBdist inside an NLL, every NLL through `MakeADFun()` (other optimisers receive
   `obj$fn` and `obj$gr` of that object), object names `<model>_obj`, `<model>_fit`,
   `<model>_sd`, `<model>_profile_<par>`, grids with `for` loops, seeds set once before a batch.
   Reuse the object names of the chapter whose model is revisited (`co2`, `co2_data`,
   `pooled_nll`, `cmb`, `binomial_nll`, `frog_data`, ...), so that students recognise them.
8. **Never claim a render or execution that did not run.** Never invent a citation, data set or
   number; every footnote reference is checked (title, journal, year) before it is written.
   Bolker's *Ecological Models and Data in R* (2008), Chapter 7 ("Optimization and all that"), is
   the natural reference for the algorithms; cite it only after checking the details, and do not
   cite the 2007 draft that the current page names.

## The theory (Stages 1 and 2)

Front matter: `title: "Numerical optimisation"` only (remove the `format:` and `execute:` blocks;
without the global `eval: false` every chunk is evaluated unless it carries `#| eval: false`, and
every display-only ```` ```r ```` fence becomes an executable ```` ```{r} ```` chunk or goes). A
first hidden chunk loads `ggplot2`, as in Chapters 4 to 7; a visible chunk loads RTMB and RTMBdist
(`#| message: false`) where the first model is set up. Use ```` ```{r} ```` chunks only. The old
page has no section IDs that other pages link to; the new IDs are listed above.

Below, each section has **General** (what the section states, in general terms; required) and
**Example** (what the earlier model shows; comes after). Object names are suggestions; once Stage
1 chooses them, later stages keep them. Every number below was checked by Stage 0 (see "Numbers
checked"); Stages 1 and 2 recalculate every number they write and say in the progress log where
they differ.

### Stage 1: part A

**`# Introduction`** (two paragraphs). Opens "In this chapter, we learn how to find the maximum
of a likelihood when the optimiser does not find it by itself..." (or a close variant that
starts exactly "In this chapter, we learn how to"): since Chapter 4 every fit minimised an NLL
with `optim()`, BFGS and the gradient of RTMB, and it usually works; but an optimiser can stop
somewhere else and still report success, as the practicals of Chapters 4 and 7 showed. Second
paragraph: how the chapter is organised (each section starts from a fit of an earlier chapter
that goes wrong; no new data), what is new (how a gradient method searches, stopping rules,
diagnosing a fit, multiple starting values, identifiability, boundaries, scaling and
parameterisation, `nlminb()`, Nelder–Mead, `optimize()`, global search with differential
evolution), and that BFGS with RTMB stays the course's method. Chapter 8 is the last chapter:
no promise of a later one.

**`# Learning goals`**: Chapter 2 format ("In this chapter, we will cover:" and short phrases
ending in semicolons, in the order of the chapter): what an optimiser sees of a likelihood; how
gradient methods search; exact and approximate gradients; stopping rules and convergence codes;
diagnosing a fit; starting values and multiple starts; structural and practical
non-identifiability; estimates at a boundary; scaling and parameterisation; other local
optimisers; global search with differential evolution; a recipe for a difficult fit.

**Roadmap table** (caption "Roadmap of the chapter."; columns Problem, How it shows, What to do,
In R; at most six rows): a fit that stops in the wrong place (absurd estimates, Hessian warning;
diagnose; `obj$gr()`, `sdreport()`, a slice); dependence on starting values (different minima
from different starts; multiple starts; a loop over `optim()`); a ridge or a parameter that the
data do not determine (huge standard errors, estimates that stay at their start; change the model
or the data, report it; `sdreport()`, `TMB::tmbprofile()`); an estimate at a boundary (a
parameter that runs to $\pm\infty$ on the optimised scale; recognise it and report the boundary);
poor scaling or parameterisation (an early stop, highly correlated estimates; rescale or
reparameterise; transformations); BFGS keeps failing (another optimiser, global then local;
`nlminb()`, `DEoptim::DEoptim()`).

**`# A fit that stops in the wrong place {#sec-wrong-place}`**

- General: an **optimiser** searches locally: at each point it evaluates it knows only the value
  of the NLL and its gradient there, never the whole surface. Define a **local minimum** (lower
  than all nearby points) and the **global minimum** (lowest of all), a **stationary point**
  (gradient zero: a minimum, a maximum or a **saddle point**) and a **ridge** (a direction along
  which the NLL changes very little, often towards $\pm\infty$ on the optimised scale). The MLE is
  the global minimum of the NLL; an optimiser can stop at any of the others.
- Example: recall the complete-pooling CO₂ model of Chapter 7 in two sentences (link to
  `../Chapter_7/Theory.qmd#sec-pooling`); chunk: data (`co2`, `co2_data`), `pooled_nll`, `cmb`, and
  the fit from Chapter 7's starting values (NLL 296.256). Then three other starting values, each
  a plausible reading of the figure of Chapter 7 (Stage 1 picks them from the checked list and
  says in units what each assumes), fitted in one chunk; all report convergence code 0. A small
  table built in R (start, NLL, estimates on the original scale). Figure `fig-co2_stops`
  (hidden, ggplot2, one panel or two): the 84 measurements (Okabe–Ito blue) and the curve at each
  stopping point: the maximum (vermillion), the constant at the mean uptake above $c$ (the limit
  $b\to\infty$), the curve at zero ($a\to0$) and the curve with $c$ just below the lowest
  concentration. Caption says which start gave which curve. Text: what each wrong curve is (the
  first is the model without a curve: its asymptote equals the mean of all 84 measurements,
  27.2 µmol/m²/s; the second predicts no uptake at all), and that in each case BFGS stopped where
  its stopping rule was satisfied.
- `## How a gradient method searches {#sec-search}`: General: move downhill along the negative
  gradient; how far to step (a line search); Newton's method also uses the curvature: it jumps to
  the minimum of the local parabola (Chapter 4's quadratic approximation, link
  `../Chapter_4/Theory.qmd#sec-curvature`), which is fast near the minimum and unreliable far from
  it; **BFGS** is a **quasi-Newton** method that builds an approximation of the curvature from the
  gradients of successive steps, so it needs only `fn` and `gr`. Consequence: it follows the
  slope from wherever it starts, so it ends at the minimum, ridge or boundary that the slope leads
  to. Statistical detail box "Statistical detail: Newton's method and BFGS" (the Newton step
  $\boldsymbol\theta_{t+1}=\boldsymbol\theta_t-\mathbf H(\boldsymbol\theta_t)^{-1}\mathbf g(\boldsymbol\theta_t)$
  with a "where" clause; the BFGS update in words or as a formula; "In plain English"). One
  sentence: RTMB uses Newton's method for the inner optimisation of random effects (Chapter 7's
  technical box sends readers here; link `../Chapter_7/Theory.qmd#sec-random-effects-rtmb`),
  because automatic differentiation supplies exact second derivatives. Figure
  `fig-search_paths` (hidden, ggplot2): contours of the relative NLL of the reed frog model of
  Chapter 6 (`binomial_nll`, `logit_alpha`, `log_H`) with the paths of BFGS from Chapter 6's
  starting values (reaches the maximum) and from two other starts that end at a boundary
  ($\alpha\to1$; $H\to0$). The hidden chunk records the points at which `gr` is evaluated (or
  another clear choice); the caption says what the points are. This figure returns in
  `#sec-boundaries`.
- `## Exact and approximate gradients {#sec-gradients}`: General: without `gr`, `optim()`
  approximates each partial derivative by a **finite difference** (Chapter 5, link
  `../Chapter_5/Theory.qmd`, the paragraph on finite differences), two extra evaluations of the
  NLL per parameter per gradient, which `counts` does not include (check in `?optim` and say it
  correctly); the step size trades the error of the straight-line approximation against rounding
  error; RTMB's gradient is exact up to rounding (Chapter 6, `#sec-makeadfun`). Technical detail
  box "Technical detail: finite differences" (forward and central differences, the step,
  `ndeps`). Example: the CO₂ fit from Chapter 7's start with and without `gr` (296.2557 against
  296.2565: the approximate gradient stops slightly earlier); from a poor start both fail
  (one sentence, or leave out). This keeps the promises of Chapters 4, 5 and 6.
- `## Stopping rules and convergence codes {#sec-stopping}`: General: a **stopping rule**: BFGS
  in `optim()` stops when an iteration lowers the NLL by less than a relative tolerance
  (`reltol`, about $1.5\times10^{-8}$ of the value of the NLL) or after `maxit` iterations (100 for
  BFGS: convergence code 1). A code 0 says that the rule was met, which happens at a minimum but
  also on a ridge, near a saddle point or at a boundary. Recall Chapter 4's callout "When a fit
  fails" (`../Chapter_4/Theory.qmd#sec-constraints`) without repeating it. The one warning callout
  of the chapter on "code 0 is not the maximum" can stand here. Verify every statement about
  `optim()`'s rule against `?optim` (and, if needed, the source of `vmmin`) before writing it;
  Stage 3 relies on it for the penguins.
- `## Diagnosing a fit {#sec-diagnosis}`: General: the checks, as bullets (a recipe): the
  estimates on the original scale (sensible values and units? a parameter at a very large or very
  small value on the optimised scale?); the gradient at the solution (`obj$gr(fit$par)`), which
  should be close to zero but is also close to zero on a ridge; `sdreport()` (its warning that the
  Hessian is not positive definite, `pdHess`, standard errors that are `NaN` or huge); a refit
  from the solution and from other starting values; a slice through the solution along a
  suspicious parameter (Chapter 4's slices, now as a diagnostic, link
  `../Chapter_4/Theory.qmd#sec-likelihood-surface`). Statistical detail box "Statistical detail:
  the Hessian at a minimum" (positive definite: every curvature positive; a zero curvature is a
  flat direction; a negative one means that the point is not a minimum; eigenvalues named in
  words). Example: the three wrong stops of the CO₂ model: one chunk with the gradient and
  `sdreport()` of each (Stage 1 decides how compact); the ridge stop has a tiny gradient but
  `sdreport()` warns; the stop with $c$ near 90 µL/L has negative curvature in one direction, so
  it is not a minimum (check with `obj$he()` in a hidden chunk or a scratch session and phrase
  exactly what it is); a slice along `log_rate` through the ridge stop (figure
  `fig-ridge_slice`, hidden, or a short visible grid, Stage 1 decides) shows that the NLL keeps
  falling, very slowly, as the rate grows.
- Practice callout (`imp-`): output of three fits of a model in a new ecological setting
  (convergence code, NLL, estimates on the original scale, `pdHess`, largest gradient), clearly
  presented as given output; which fits found the maximum and what to check next. Paper only.

**`# Starting values and multiple starts {#sec-multistart}`**

- General: the end of a local search depends on its starting values; good starting values (read
  from a figure, or method-of-moments estimates, as in Chapters 4 to 7) usually suffice. When a
  fit is in doubt, or the surface is known to be difficult, use **multiple starting values**: draw
  starting values at random within a box of plausible values on the optimised scale, fit from
  each, keep the fit with the lowest NLL, and check how many fits reach it and whether their
  estimates agree; then restart BFGS from the best fit. Agreement of many starts is evidence, not
  proof, that the global minimum was found (say this once).
- Example: the CO₂ model from 50 random starts (seed 801; box: asymptote 5 to 100 µmol/m²/s, rate
  $10^{-4}$ to 1 L/µL, $c$ 0 to 90 µL/L, standard deviation 0.5 to 20 µmol/m²/s, uniform on the
  optimised scale): one chunk with the box, one with the loop (store NLL, convergence and
  estimates), one with a table of where the fits ended. 17 of 50 reach 296.26 (34%); the rest stop
  at the ridge (318.7), at zero (402.8) or elsewhere; one returns code 1. Optional hidden figure
  `fig-multistart` (final NLL of each start); a printed table may be enough. The best fit agrees
  with Chapter 7.
- One paragraph (no new code, or one hidden chunk): the model with a random asymptote of Chapter
  7 fails in the same way from the same poor starts (NLL 307.7 at the ridge and 261.2 with $c$
  near 91 µL/L, code 0, against 207.605), and multiple starts work the same way; each evaluation
  now includes an inner optimisation (Newton's method, `#sec-search`), which makes every fit
  slower.

### Stage 2: part B

**`# Ridges, boundaries and identifiability {#sec-identifiability}`**

- General: a parameter is **identifiable** when different values of it give different
  distributions of the data, so that the likelihood can tell them apart. **Structural
  non-identifiability**: the model itself cannot tell them apart, because the parameters enter
  only through a combination; the NLL is exactly flat along a ridge, and the estimates depend on
  the start. **Practical non-identifiability**: the model could tell them apart, but the data
  cannot, because there are no observations where the curve responds to the parameter (the
  sentence of Chapter 5, "the observations that can tell us about a parameter are those made
  where the curve responds to it", link). Symptoms, as bullets: estimates that stay at their
  starting values or depend on them, very large standard errors, correlations near $\pm1$,
  `sdreport()`'s warning (structural), a flat slice or likelihood profile. Remedies: remove or fix
  a parameter, reparameterise, more informative data (a design that covers the range where the
  curve responds), or report the parameter as not determined.
- Example, structural: the CO₂ curve with a common asymptote and a free deviation for each of the
  12 plants (`log_asym + dev`, no distribution for `dev`): 13 parameters for 12 asymptotes;
  `sdreport()` warns; two starts give different `log_asym` and even different NLLs (260.14, a
  stall, against 171.44, the no-pooling minimum of Chapter 7). Compare with Chapter 7: there the
  deviations had a distribution, which makes them identifiable (one sentence).
- Example, practical: the complete-pooling CO₂ model fitted only to the concentrations of 250
  µL/L and above (60 measurements): $c$ stays at its starting value (50) with a standard error of
  579 µL/L, the standard error of the log rate is 3.1, and the Hessian is still positive definite
  (so `sdreport()` gives no warning: the large standard error is the symptom). A likelihood
  profile of `c0` with `TMB::tmbprofile()` (check that it runs and what it shows; plot with
  ggplot2 on the relative scale, or describe) shows a nearly flat curve. One sentence relates
  this to the ridge of `#sec-wrong-place` (with all 84 measurements the maximum is interior; the
  ridge leads towards the constant model, which the data do not favour).
- `## Estimates at a boundary {#sec-boundaries}`: General: the maximum, or a point the optimiser
  is drawn to, can lie at the edge of the allowed range (a probability of 0 or 1, a variance or a
  handling time of zero); on the optimised scale (log, logit) the edge lies at $\pm\infty$, so the
  optimiser walks towards it and stops where the slope has become tiny, with code 0; such an
  estimate is reported as "at the boundary" (or the model is changed), not as a number on the
  optimised scale. Example: the reed frog fits of `fig-search_paths` from the two other starts
  (α → 1 with NLL 59.77; $H\to0$ with NLL 52.22; both code 0, against 46.72 at the maximum);
  a variance among groups at zero is the same situation (Chapter 7; the REML fits of this
  chapter's practical, Exercise 3). One paragraph on bounds (author's decision: mention only):
  `optim(method = "L-BFGS-B")` and `nlminb()` accept `lower` and `upper` on the natural scale, so
  a boundary can be reached exactly; the course keeps transformations because every
  unconstrained value is then allowed and the standard errors and profiles work on that scale.
- Practice callout (`imp-`): identifiability on paper in a new ecological setting (for example a
  model whose mean is $a\,b\,x$, or an experiment with prey densities only far below the
  half-maximum): which parameters are identifiable, which symptom a fit would show, what to
  change.

**`# Scaling and parameterisation {#sec-scaling}`**

- General: **scaling**: parameters of very different magnitudes make one step size wrong for some
  of them (an optimiser works best when a change of about one unit matters similarly for every
  parameter); remedies: transformations (the logarithm puts a rate of 0.01 and an asymptote of 30
  on comparable scales), the units of the data (Exercise 2 of the practical), and the `parscale`
  control of `optim()` (shown once). **Parameterisation**: the same model written with other
  parameters has a surface of another shape (round or a narrow tilted valley) and estimates with
  other correlations; a narrow tilted valley is harder to search; the parameterisations of the
  course write distributions with their mean where possible (Chapter 4).
- Example, scaling: the CO₂ model with the rate on its original scale (`rate`, starting at 0.01
  L/µL; the other parameters as in Chapter 7) stops at the ridge (NLL 318.68, code 0); with
  `control = list(parscale = c(1, 0.01, 10, 1))` it reaches 296.256; with the log rate (Chapter 7)
  it reaches it as well. Say what `parscale` does (it tells `optim()` the typical size of each
  parameter) and that a transformation is the usual remedy.
- Example, parameterisation: the owl model of Chapter 4 with $\mu,k$ and with $k,p$ (link to
  Chapter 4's figure in `#sec-likelihood-surface`): correlation of the estimates about 0 against
  0.71; both fits reach the same NLL (299.442) with a similar number of evaluations (31/10 and
  25/11): say honestly that here the tilt does not hurt BFGS, and that a narrower valley can
  (Exercise 2: correlation 0.996 in the Gamma model, where BFGS stops after one step). One
  sentence on the reed frog curve: correlation 0.98 with $a,b$ against 0.82 with $\alpha,H$
  (Chapter 6).
- Practice callout (`imp-`): R as a calculator: given the magnitudes of the parameters of a model
  in a new setting, propose a transformation or a change of units that brings them to comparable
  scales, and calculate the new starting values.

**`# Other optimisers and global search {#sec-other-optimisers}`**

- General, local optimisers: **`nlminb()`** (the PORT routines; uses the gradient, and the Hessian
  if given; controls its steps differently from BFGS; used in TMB's examples and by glmmTMB by
  default, link `../Supplements/canned.qmd`), its arguments and result as bullets; **Nelder–Mead**
  (`optim(method = "Nelder-Mead")`, a simplex of $p+1$ points that is reflected, expanded and
  contracted, in words; no gradient; many evaluations; stops less precisely), for NLLs without a
  gradient; **`optimize()`** for a single parameter in an interval (golden-section search and
  parabolic interpolation, in words), because `optim()` warns that Nelder–Mead is unreliable in one
  dimension. **Comparing optimisers fairly**: the same NLL, the same starting values, the final
  NLL compared and not only the estimates, evaluations counted; one example is not a ranking.
- Example: from the poor starts of `#sec-wrong-place`, `nlminb()` reaches 296.256 in each case;
  from the 50 random starts of `#sec-multistart`, BFGS reaches the maximum in 34%, `nlminb()` in
  84% and Nelder–Mead in 26% (Nelder–Mead also stops at 296.30 and 296.35 from two poor starts,
  close to but not at the minimum): "in this example". The fir counts of Chapter 4 with
  `optimize()` on the log scale (interval, result 2.14 seedlings per quadrat, the sample mean, as
  Chapter 4 showed).
- `## Global search {#sec-global}`: General: a **global** method explores a whole box of
  parameter values instead of following one path. **Differential evolution**: a population of
  parameter vectors; a new candidate is formed by adding a scaled difference of two members to a
  third (**mutation**), mixing it with a current member (**crossover**), and keeping it only if its
  NLL is lower (**selection**). It needs a box (bounds), thousands of evaluations and a seed; it
  can find a minimum that local searches miss but proves nothing. Technical detail box
  "Technical detail: differential evolution" (the mutation formula with $F$, crossover with
  $CR$, population size $NP$). **Global, then local**: refine the best member with BFGS, which is
  precise near the minimum. GA and simulated annealing named in one sentence at most (author's
  decision). Example: `DEoptim::DEoptim()` on `pooled_obj$fn` with the box of `#sec-multistart`
  (seed 802, NP 40, 200 generations): 296.2557 after 8,040 evaluations (about 0.1 s); BFGS from
  `bestmem` confirms it.

**`# A recipe for a difficult fit`**: a note callout: check that the NLL returns an ordinary
number at the starting values; fit with BFGS; diagnose (estimates, gradient, `sdreport()`, a
refit, a slice); if in doubt, multiple starts; if a ridge or a boundary, decide whether the
parameter is identifiable and change the model or the data, or report it; rescale or
reparameterise; try `nlminb()`; global search followed by BFGS; report what was done (the
starts, the failures and how they were treated).

**`# Summary`**: a few short paragraphs, no new material. The last paragraph closes the course's
line on estimation (Chapter 8 is the last chapter) and may point to `Supplements/canned.qmd`
(glmmTMB uses `nlminb()` and the same diagnostics apply).

**`# Chapter quiz`**: 8 to 10 questions in the Chapter 7 format (`:::: {.callout-important
title="Question N: <ecological setting>"}` with a collapsed answer), each a new ecological
setting that tests one principle: local and global minimum; what code 0 says; reading a
diagnosis; why multiple starts and how many must agree; structural against practical
non-identifiability; an estimate at a boundary on the log scale; scaling; parameterisation and
correlation; what `nlminb()` or Nelder–Mead offers; global then local. Answers explain.

### Numbers checked on 4 November (R 4.6.1, RTMB 2.0, RTMBdist 1.1.0, TMB 1.9.25, DEoptim)

The R scripts are not in the repository; Stages 1 to 3 recalculate every number they write.
"Code 0" is `optim()`'s convergence code. Estimates on the original scale.

**CO₂, complete pooling** (`pooled_nll` of Chapter 7, 84 measurements; starts as `log_asym`,
`log_rate`, `c0`, `log_sd_obs` on the original scale):

| Start ($a$, $b$, $c$, $\sigma$) | Code | NLL | End | Diagnosis |
|---|---:|---:|---|---|
| 30, 0.01, 50, 2 (Chapter 7) | 0 | 296.256 | $a$ 32.5, $b$ 0.0095, $c$ 45.9, $\sigma$ 8.23 | max abs gradient 0.0025, `pdHess` TRUE; se 0.044, 0.31, 21.7, 0.077 |
| 30, 0.001, 50, 2 | 0 | 318.682 | $a$ 27.2131 (= mean uptake), `log_rate` 27.0 ($b\to\infty$), $\sigma$ 10.75 | gradient 5e-6, `pdHess` FALSE, se NaN |
| 100, 0.01, 50, 2 | 0 | 402.792 | `log_asym` −245 ($a\to0$), $\sigma$ 29.3 | gradient 7e-6, `pdHess` FALSE, se NaN |
| 10, 1, 90, 2 | 0 | 302.323 | $a$ 29.7, $b$ 0.112, $c$ 90.27 (lowest concentration 95), $\sigma$ 8.85 | gradient 0.019; Hessian eigenvalues 835, 168, 13.2, −0.0067 (not a minimum); `pdHess` FALSE; a restart stays at 302.323 |
| 100, 0.1, 0, 2 | 0 | 8354.96 | runaway: $\sigma\approx10^{42}$ | gradient NaN, `pdHess` FALSE |
| 30, 0.001, 50, **10** | 0 | 296.256 | as the first row | a start with a larger $\sigma$ succeeds more often |

Slice along `c0` through the local stop near $c=90$ (other parameters at the stop): NLL 313.2 at
$c=80$, 302.34 at 90, 313.2 at 94.9. The slice along `log_rate` through the ridge stop was not
checked (Stage 1). BFGS without `gr` from Chapter 7's start: 296.2565 (counts 83/32) against
296.2557 (104/33) with `gr`; from the four poor starts without `gr`: 318.682, 402.792, 302.323,
402.792.

From the four poor starts (rows 2 to 5): `nlminb(obj$par, obj$fn, obj$gr)` reaches 296.256 in all
four ("relative convergence (4)"); with the Hessian as well, too; Nelder–Mead (`maxit = 5000`)
ends at 296.298, 296.350, 318.682 and 318.676.

50 random starts (seed 801; box on the optimised scale: `log_asym` log(5) to log(100),
`log_rate` log(1e-4) to log(1), `c0` 0 to 90, `log_sd_obs` log(0.5) to log(20), `runif()` in
that order per start): BFGS ends at 296.3 (17), 298.7 (1), 318.7 (17), 402.8 (14), 2098.8 (1);
49 with code 0 and 1 with code 1; the loop takes 0.1 s. With the same starts, `nlminb()` reaches
296.26 in 42 of 50 (84%; the other 8 at 318.7) and Nelder–Mead in 26%. (The starts were drawn as
a matrix of 50 rows with `replicate()` for the comparison; Stage 1 draws them in its own loop and
recounts.)

`DEoptim::DEoptim(pooled_obj$fn, lower, upper, control = DEoptim.control(NP = 40, itermax = 200,
trace = FALSE))` with seed 802 and the same box: best 296.2557, 8,040 evaluations, 0.09 s, no
wrapper needed; BFGS from `bestmem` 296.2557, code 0.

Rate on its original scale (`rate`, other parameters as Chapter 7, start 0.01): BFGS 318.6817,
code 0 (counts 50/11), $b$ 1.27; with `parscale = c(1, 0.01, 10, 1)`: 296.2557 (76/25).

Structural non-identifiability (`log_asym + dev`, 12 free `dev`): from `log_asym = log(30)`,
`dev = 0`: code 0, NLL 260.137, `pdHess` FALSE; from `log_asym = log(60)`, `dev = -0.5`: NLL
171.4375 (no pooling); `log_asym` 2.34 against 3.94.

Practical non-identifiability (complete pooling, starts as Chapter 7 with $\sigma=8$): all 84,
NLL 296.256, se of `c0` 21.7, correlation of `log_rate` and `c0` 0.84; concentrations ≥ 250 (60
measurements): NLL 218.785, `c0` stays at 50, se 579, se of `log_rate` 3.14, `pdHess` TRUE; ≥ 500
(36): se of `c0` 1,340. `tmbprofile()` of `c0` not yet checked (Stage 2).

**CO₂ with a random asymptote** (`mixed_nll` of Chapter 7, `random = "u"`): 207.605 from the
good starts; code 0 at 307.724 from most starts with $b=10^{-4}$ or $10^{-3}$, from $b=1$ with
$c$ 0 or 50, and from (30, 0.01, 90) ($\sigma_{\mathrm{plant}}$ 0.27, $b\to\infty$; for example
the start (30, 0.001, 50, 2) of the table above), and 261.166 from (100, 1, 90): $c$ 91.6
(starts as ($a$, $b$, $c$) with $\sigma_{\mathrm{obs}}=2$, $\sigma_{\mathrm{plant}}=0.1$).

**Reed frogs** (`binomial_nll` of Chapter 6): maximum 46.721 ($\alpha$ 0.526, $H$ 0.0166); from
($\alpha$ 0.01, $H$ 1/60) and (0.01, 0.1): 59.768, $\alpha\to1$, $H$ 0.0367, code 0; from (0.5, 1),
(0.1, 10), (0.5, 10), (0.9, 10): 52.219, $\alpha$ 0.348, $H\to0$, code 0. From Chapter 6's start
(0.5, 1/60): 13 evaluations of `fn`, 6 of `gr`; Michaelis–Menten form from the equivalent start
16/6. Correlation of the estimates: 0.82 (`logit_alpha`, `log_H`), 0.98 (`log_a`, `log_b`).

**Owls** (Chapter 4 subset, 122 visits, mean 4.75): NLL 299.4419 in both parameterisations;
$\mu,k$: BFGS 31/10, without `gr` 30/10, Nelder–Mead 59, `nlminb()` 10 iterations; correlation
about 0. $k,p$: BFGS 25/11, Nelder–Mead 73, `nlminb()` 10 iterations; correlation 0.71.

**Fir counts** (50 quadrats, `log_lambda`): `optimize(fir_obj$fn, interval = c(-3, 3))` gives
$\lambda$ 2.13996 and NLL 89.28529 (sample mean 2.14); BFGS 2.14 (22/6); Nelder–Mead in one
dimension warns.

**glmmTMB:** `glmmTMB::glmmTMBControl()` has `optimizer = nlminb` (version 1.1.15.2).

## The practical (Stage 3)

Front matter as in Chapter 7 (`title: "Chapter 8: Numerical optimisation"`, `date: today`). An
opening paragraph like Chapter 7's: the three exercises, each a fit of an earlier practical that
goes wrong (which chapter, which exercise), all core (no extra exercise), Exercise 1 worked, link
to the theory, "As in the theory... RTMB and RTMBdist"; DEoptim is called with its prefix. A
visible chunk loads RTMB and RTMBdist. Headings `# Exercise N: Topic`, `## Solution`, `### Question
n`, as in Chapter 7. Plots in base R only (`STYLE_GUIDE.md`, "Plots inside exercises"). Each
exercise recalls its data and model in a few sentences with a link to the earlier exercise; no
new provenance is needed (the earlier page gives it), but name the data set and package.

Every exercise follows the same four steps, so that students learn the procedure: the
**symptom** (a fit from plausible starting values, code 0), the **diagnosis** (estimates,
gradient, `sdreport()`, a slice or a refit), the **remedy** (multiple starts, rescaling,
reparameterisation, another optimiser, global search) and the **confirmation** (a restart, the
agreement of methods, `sdreport()` at the best fit, comparison with the earlier chapter).

`no_solution.qmd` contains Exercise 1 with its full worked solution and Exercises 2 and 3 with
questions only (and any code that the questions give). `solution.qmd` links to the worked
Exercise 1 (as Chapter 7 does) unless a later exercise uses its objects, and repeats the question
text of Exercises 2 and 3 identically (check with `diff`).

**Exercise 1 (worked): Growth of loblolly pines.** `datasets::Loblolly`, complete pooling with
$h(t)=A\left(1-e^{-k(t-t_0)}\right)$ and a Normal model (`pooled_nll`, `pine_data` of the Chapter 7
practical). Questions: (1) fit from Chapter 7's starting values (`log_A = log(80)`, `log_k =
log(0.05)`, `t0 = 2`, `log_sd_obs = log(2)`: NLL 162.817) and from the same values with $k=0.1$/year
(a reading of the plot that is just as plausible): code 0, NLL 425.491, $A$ about $1.5\times10^{-8}$
ft, $k$ about $3.6\times10^{-6}$/year, $\sigma_{\mathrm{obs}}$ 38.3 ft; what curve is this
(practically zero at every age, so the standard deviation absorbs the heights); (2) diagnose: the
estimates, the gradient (largest 4.7e-6: tiny, so the gradient alone does not reveal the problem),
`sdreport()` (`pdHess` FALSE, `NaN` standard errors), a slice along `log_k` (flat: 425.4909 from
$k=10^{-4}$ to 0.039); (3) multiple starts: 20 random starts (seed 811; box: $A$ 30 to 300 ft, $k$
0.005 to 0.5/year, $t_0$ −5 to 5 years, $\sigma$ 0.5 to 20 ft): 5 reach 162.82, the others 373.11
(2), 425.49 (12) and 551.17 (1); (4) `nlminb()` from the $k=0.1$ start reaches 162.817; global
search with `DEoptim::DEoptim()` (seed 812, NP 40, 200 generations, same box): 162.817 after 8,040
evaluations, refined with BFGS; (5) confirm: a restart, `sdreport()` at the best fit (`pdHess`
TRUE), the estimates of Chapter 7 ($\hat A=102.3$ ft, $\hat k=0.0389$/year, $\hat t_0=2.06$ years,
$\hat\sigma_{\mathrm{obs}}=1.68$ ft). One sentence: the model with a random asymptote per tree of
Chapter 7 converges from the $k=0.1$ start (NLL 116.669), so the failure belongs to this fit and
start, not to the curve. Recount the multiple starts in the loop as written (the numbers above
come from a loop that drew each start with one `runif(4, lower, upper)` call).

**Exercise 2: Body mass of Adelie penguins.** `datasets::penguins` (R 4.5.0 or later; the
footnote of the first use is in Chapter 2), the 151 Adelie masses with one missing value removed
explicitly, the Gamma model with `log_shape` and `log_rate` (`gamma_nll` of the Chapter 4
practical). Chapter 4's solution found that the fit in grams started at the method-of-moments
estimates (variance with divisor $n$) stops after a single step and promised that Chapter 8
explains it. Questions: (1) the fit in grams from the method-of-moments estimates: code 0, after
8 evaluations of `fn` and 1 of `gr`, shape 65.56 against the start 65.560, NLL 0.0025 above the
minimum; (2) diagnose: the gradient at the stop (−0.22 and −0.39: far from zero), a restart from
the stop (reaches shape 66.095, NLL 1137.724), and the stopping rule (relate the change of the NLL
to `reltol` times the NLL, about 1138 in grams: **verify the exact rule in `?optim` or the source
of `vmmin` before writing the explanation**, and check that it agrees with what Chapter 4's
solution says; if they disagree, correct Chapter 8's text and list Chapter 4's sentence for Stage
7); (3) remedies: the masses in kilograms (shape 66.095, NLL 94.653), the parameterisation with
the mean and the shape (`log_mean`, `log_shape`: shape 66.095 in 13/3 evaluations; correlation of
the estimates −0.000001 against 0.996 for `log_shape` and `log_rate`), `nlminb()` (66.095); (4)
interpret: which remedies change the problem (units, parameterisation) and which only search again
(restart, another optimiser), and why the estimates of shape and mean do not depend on the units.

**Exercise 3: A variance among sites at zero.** The REML simulation of the Chapter 7 practical,
Exercise 5 (`site_nll`, five quadrats at each of six sites, $\mu=4$,
$\sigma_{\mathrm{site}}=\sigma_{\mathrm{obs}}=1$, seed 751, 500 hypothetical samples, REML with
`random = c("u", "mu")` from the simulation values). The student page gives the code of the
simulation, reduced to the REML fits and storing what the questions need (each sample's data and
fit), so that the exercise is about optimisation and not about REML. Chapter 7's solution
promised that Chapter 8 returns to this example. Questions: (1) count the samples in which the
REML estimate of $\sigma^2_{\mathrm{site}}$ is practically zero (Stage 3 chooses the threshold, for
example below 0.001) with code 0, and look at the gradient and `sdreport()` of these fits; (2)
refit each of them from 10 random starting values (both log standard deviations from a Normal
distribution with mean 0 and standard deviation 1, or a box; a seed set once) and with
`nlminb()`; how many move to a positive variance with a lower NLL; (3) explain why the log scale
puts a variance of zero at $-\infty$ and why BFGS stops on the way there; when is zero the real
maximum (the sample in which the site means vary less than the quadrats suggest, Chapter 7's
explanation); (4) does it matter for the bias of the REML estimator that Chapter 7 calculated (the
mean of the 500 estimates before and after the refits). Checked: 6 samples (69, 130, 195, 221, 277,
331) in which BFGS ends below 0.001 while the REML maximum is positive (0.076, 0.055, 0.055, 0.008,
0.159, 0.020, from the closed-form REML estimate of the balanced one-way design,
$\max\{0,(\mathrm{MSB}-\mathrm{MSW})/5\}$); gradients between 1e-5 and 6e-3; 10 random starts
(seed = sample number in the check; Stage 3 sets one seed before the loop) and `nlminb()` find the
positive maximum in all 6, each with a lower NLL. Chapter 7's progress log counts 8 such fits with
another criterion: Stage 3 states its criterion and recounts. The closed form may appear in the
solution as a check, labelled as the special case of a balanced Normal design, or be left out.

## The lecture (Stages 5 and 6)

One folder `Chapter_8/Lecture/` with `lecture.qmd`, `lecture-script.md`, `lecture-script.pdf`,
`lecture.scss` (unchanged copy of `Chapter_7/Lecture/lecture.scss`), `demo-diagnosis.R` and
`lecture-assets/` (with `figures.R`). Title slide: subtitle "Chapter 8 · Lecture", eyebrow
"Numerical Optimisation". `pagetitle`: "Chapter 8 — Ecological Models and Data Analysis". Footer:
"Ecological Models and Data Analysis · Chapter 8".

The rules of `STYLE_GUIDE_LECTURE.md` hold, above all "General statement first" and "The main
points stand on the slide". Every content slide below is specified as **General** (required, on
the slide), **Example** (in `.example`, caption or code comments) and **Script** (notes for Stage
6). Slide titles name the concept, not the plants. The specification is a plan: Stage 5 takes the
theory as Stage 4 left it as the source of wording, numbers and figures, and adapts a slide when
the chapter differs (and says so in the progress log). Practice slides stand where their callout
stands in the chapter.

### Slide sequence and timing

| Slide | Title | Min | Elapsed |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis (title) | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | What an optimiser does | 3 | 4–7 |
| 5 | A fit that stops in the wrong place | 4 | 7–11 |
| 6 | Local minima, saddle points and ridges | 3 | 11–14 |
| 7 | How a gradient method searches | 4 | 14–18 |
| 8 | Exact and approximate gradients | 3 | 18–21 |
| 9 | Stopping rules and convergence codes | 3 | 21–24 |
| 10 | Diagnosing a fit | 4 | 24–28 |
| 11 | Practice 1 | 3 | 28–31 |
| 12 | Discussion: has this fit found the maximum? | 4 | 31–35 |
| | Break | 10 | 35–45 |
| 13 | The Hessian at the end of a search | 3 | 45–48 |
| 14 | Multiple starting values | 4 | 48–52 |
| 15 | Starting values in a model with random effects | 3 | 52–55 |
| 16 | Structural and practical non-identifiability | 4 | 55–59 |
| 17 | Estimates at a boundary | 4 | 59–63 |
| 18 | Practice 2 | 3 | 63–66 |
| 19 | Scaling | 3 | 66–69 |
| 20 | Parameterisation | 3 | 69–72 |
| 21 | Practice 3 | 3 | 72–75 |
| | Break | 10 | 75–85 |
| 22 | Live demo: diagnosing a failed fit | 2 + 16 | 85–103 |
| 23 | Other local optimisers | 4 | 103–107 |
| 24 | One parameter: a search within an interval | 2 | 107–109 |
| 25 | Comparing optimisers fairly | 3 | 109–112 |
| 26 | Global search: differential evolution | 5 | 112–117 |
| 27 | Global search, then local refinement | 5 | 117–122 |
| 28 | Discussion: which remedy for which symptom? | 4 | 122–126 |
| 29 | A recipe for a difficult fit | 3 | 126–129 |
| 30 | The Chapter 8 R practical | 2 | 129–131 |
| 31 | Summary and closing questions | 5 | 131–136 |
| | Slack for discussion | 14 | 136–150 |
| | **Total** | **150** | |

Check: slides 116 (blocks of 35, 30 and 51, the demo included) + slack 14 + breaks 20 = 150.
The minutes of each slide equal its `data-timing` in seconds. The break before the demo lets the
lecturer open R and run section 0 of the demo script. If the theory's Practice callouts stand
elsewhere, move the Practice slides with them and keep at least 8 minutes of slack.

### Slide specifications

1. **Title.**
2. **Overview:** numbered, bold keyword + question: the problem (why can a fit stop in the wrong
   place?); diagnosis (how do we know?); starting values (what if the start matters?);
   identifiability and boundaries (what if the data cannot decide?); scaling and parameterisation;
   other optimisers and global search; the practical.
3. **Where we are** (`.diagram-slide`, `../../Chapter_1/Lecture/ModelCycle.png` unchanged).
   Caption: this lecture looks inside the estimation step.
4. **What an optimiser does:** minimises the NLL from starting values, step by step, with local
   information only (value and gradient); returns estimates, the minimum and a code. Example:
   Chapter 4's `optim()` call (code comments).
5. **A fit that stops in the wrong place** (`.figure-slide`, `co2-stops.png`, copy of
   `fig-co2_stops`): code 0 at several places; the curves at the stops. Takeaway: a code of zero
   is not the maximum.
6. **Local minima, saddle points and ridges:** the definitions (a schematic SVG without scales is
   allowed, made in `figures.R` or drawn by hand as SVG). Example: the CO₂ stops named.
7. **How a gradient method searches** (`.figure-slide`, `search-paths.png`, copy of
   `fig-search_paths`): downhill along the gradient; Newton uses curvature; BFGS learns it.
   Script: the box on Newton and BFGS; Chapter 7's inner optimisation.
8. **Exact and approximate gradients:** finite differences (cost and accuracy); RTMB's exact
   gradient.
9. **Stopping rules and convergence codes:** relative change of the NLL, `maxit`; what code 0 and
   1 say.
10. **Diagnosing a fit:** the checks of `#sec-diagnosis` as an incremental list. Example: the
    ridge stop (tiny gradient, Hessian warning).
11. **Practice 1** (the chapter's first callout).
12. **Discussion** (timed, takeaway and activity visible): three printed fits (from the chapter's
    table of stops) to judge. Script: expected answers.
13. **The Hessian at the end of a search:** positive definite; a flat direction; a saddle. Example:
    the stop near $c=90$ µL/L.
14. **Multiple starting values** (`.figure-slide` if `fig-multistart` exists, otherwise the table
    in `.example`): random starts in a box on the optimised scale; keep the lowest; how many agree.
15. **Starting values in a model with random effects:** the same failures; the inner Newton
    optimisation in every evaluation.
16. **Structural and practical non-identifiability:** definitions and symptoms. Example: common
    asymptote + free deviations; no low concentrations (se of $c$ 579 µL/L).
17. **Estimates at a boundary:** the edge at $\pm\infty$ on the optimised scale; reported as a
    boundary; bounds mentioned. Example: reed frogs ($\alpha\to1$, $H\to0$).
18. **Practice 2.**
19. **Scaling:** magnitudes of parameters; transformations, units, `parscale`. Example: the
    natural-scale rate stops at the ridge.
20. **Parameterisation:** the same model, another surface; correlation. Example: owls (0.71
    against 0), Gamma (0.996, in the practical).
21. **Practice 3.**
22. **Live demo: diagnosing a failed fit** (`.demo-slide`): numbered incremental list of the
    general steps of `demo-diagnosis.R`; a `.demo` box with the script name and sections. No
    comparison of many optimisers (author's decision).
23. **Other local optimisers:** `nlminb()` (and that glmmTMB uses it), Nelder–Mead. Example: share
    of 50 starts that reach the maximum ("in this example").
24. **One parameter: a search within an interval:** `optimize()`. Example: fir counts.
25. **Comparing optimisers fairly:** same NLL, starts, final NLL, evaluations; one example is not a
    ranking.
26. **Global search: differential evolution:** population, mutation, crossover, selection; a box;
    many evaluations; no proof.
27. **Global search, then local refinement:** why both. Example: 8,040 evaluations, then BFGS.
28. **Discussion** (timed): symptoms to match with remedies. Script: expected answers.
29. **A recipe for a difficult fit:** the chapter's recipe, incremental, in keywords.
30. **The Chapter 8 R practical:** the three exercises as bold keywords; takeaway: symptom,
    diagnosis, remedy, confirmation.
31. **Summary and closing questions** (`.closing`): incremental take-home points; takeaway string
    ("Local · Code 0 · Diagnose · Starts · Identifiable · Boundary · Scale · Global then local");
    two closing questions. Script: final transition (the end of the course's line on estimation;
    the practical; the glmmTMB supplement).

### Demo script `demo-diagnosis.R`

Header: packages (RTMB, RTMBdist, TMB) and run time. Sections that match the demo slide: 0 set-up
(data, NLL, `cmb()`; a base R plot of the CO₂ measurements); 1 a fit from a poor start (code 0;
estimates on the original scale; the curve over the data in base R); 2 diagnosis (`obj$gr()`,
`sdreport()` and its warning, a slice along the suspicious parameter in base R); 3 multiple random
starts (the loop and the table of where the fits ended); 4 refine and confirm (BFGS from the best
fit, `sdreport()` with `pdHess` TRUE, a likelihood profile of one parameter with
`TMB::tmbprofile()` or the comparison with Chapter 7's estimates); 5 the fitted curve over the data
(base R). Object names of the chapter. Runs in a clean session in under 30 seconds; Stage 5 runs it
and records the time. The demo uses the CO₂ model of the chapter, unless Stage 5 finds that the
practical's loblolly fit gives a clearer demo; then it says so (the practical uses that example,
so the CO₂ model is preferred).

### Figures

All PNG with `dpi = 192`, copies at the size of the chapter's chunk; every image has `fig-alt`.
`lecture-assets/figures.R` runs in a clean session from the repository root and writes every PNG
into `lecture-assets/`; copies run the chapter's chunks unchanged in order and change only the
last line to save the plot. Expected files: `co2-stops.png`, `search-paths.png`, and
`multistart.png` or `ridge-slice.png` if the chapter has those figures; a schematic for slide 6
if Stage 5 makes one (SVG, no numerical scales). Compare copies with the rendered chapter figures
in `_freeze/Chapter_8/` or `_site`.

### Checks for Stage 5

1. `quarto render Chapter_8/Lecture/lecture.qmd --to revealjs` from the repository root; no
   warnings ignored; delete the generated `lecture.html` afterwards, as for the other lectures.
2. Every slide inspected at 1440 × 900 with all fragments showing, with the headless Edge command
   of `Chapter_4/lecture-handoff.md` ("Checks"), screenshots in the scratchpad. A slide fails if
   anything touches the footer; fix by moving text to the script.
3. General-first audit: list any example number outside an `.example` box, a caption or a code
   comment.
4. Minutes equal `data-timing`; blocks add up.

### Stage 6: the script

Written from the slides as Stage 5 left them (they replace the table above if they differ). The
format of `STYLE_GUIDE_LECTURE.md`, "The script", and of `Chapter_7/Lecture/lecture-script.md`:
opening (draft for review; 150 minutes, slides, slack and breaks; one live demo; links to theory
and practical; which slides use which figure, with `figures.R`); timing table; one section per
slide with the narrative, general rule first; Practice and discussion slides with expected
answers; the demo section with a walkthrough of `demo-diagnosis.R` by section, the numbers to
expect and when to run section 0; "Adjustments during delivery" (what to shorten first, what to
keep: slides 5, 7, 9, 10, 14, 16, 17 and 27; the demo is kept whole and takes the slack first).
PDF with `quarto render Chapter_8/Lecture/lecture-script.md --to typst` (confirm that it works;
remove the `.quarto/` folder it creates). No first-person anecdote or opinion for the author.

## Stage 4: independent review

The reviewer did not write the pages. It works through, for the theory and the practical:

1. **Statistics and numerics:** local and global minimum, saddle point and ridge defined
   correctly; what the Newton step and BFGS do; the statement of `optim()`'s stopping rule against
   `?optim` (and `vmmin` if needed); finite differences (what `counts` includes); what
   `sdreport()`'s Hessian check means; identifiability (structural against practical, with
   correct examples); boundaries on the transformed scale; parameterisation and correlation; what
   `nlminb()`, Nelder–Mead, `optimize()` and differential evolution do; no claim that one
   optimiser is better in general; no claim that multiple starts or global search prove a global
   minimum; no Normal-only result taught as general; Exercise 3 consistent with Chapter 7's REML
   (what is integrated, the closed form labelled as a special case if used).
2. **Numbers:** run every chunk of the three pages in a clean session (render in the dev profile)
   and compare every number quoted in prose with the output; recalculate the numbers of hidden
   chunks in a separate session.
3. **Voice and style:** the checklist of `STYLE_GUIDE.md` on every section; the "Rules that
   matter most" above; above all, "code 0 is not the maximum" said once and not in every section;
   British English; units; $\log()$ with parentheses; "likelihood profile"; "hypothetical
   samples".
4. **Code:** the R rules of `STYLE_GUIDE.md`; no algorithm coded by hand in a visible chunk; every
   NLL through `MakeADFun()`; `optim()` BFGS calls with `gr = obj$gr` (except where the text shows
   a fit without `gr` on purpose); no `reltol`, `<-`, pipes, `sapply()` grids or visible
   `obj$he()`; `DEoptim::` and `TMB::` prefixes; names consistent with the earlier chapters.
5. **Scope:** five sections as decided; no new data set, threshold model or simulated example in
   the theory; no SANN or GA beyond one sentence; bounds only mentioned; no hypothesis tests; no
   Bayesian inference; size within the target.
6. **Alignment:** exercises and solutions identical in question text, numbering and data;
   learning goals and roadmap match the sections; the promises of earlier chapters (list in Stage
   7) are kept by what the pages contain.

The reviewer fixes what it finds (routine fixes directly; anything that changes the scientific
meaning goes to "Open questions for the author" with the conservative choice applied) and writes a
short report in the progress log: what was checked, what was changed, what remains.

## Stage 7: integration

1. **Links and promises.** Search the repository (`grep` for `Chapter_8`, `Chapter 8`, excluding
   `_site*` and `_freeze`) and fix every link and promise to what the new chapter contains; link
   to the new section IDs where a promise is specific. Known places (line numbers of 4 November):
   - `Chapter_1/Theory.qmd`, line 561 (estimation bullet: keep) and the roadmap entry "Chapter 8:
     Numerical optimisation" (lines 767 to 778): "R skills and tools" lists `DEoptim()` and
     `ga()`; remove `ga()` (author's decision) and check that the key concepts (geometry of
     difficult likelihoods, identifiability, classes of algorithms, convergence) describe the new
     chapter. This page is the author's approved text: change only the sentences that are wrong,
     and list them in the report.
   - `Chapter_4/Theory.qmd`: line 542 (`gr`, "Chapter 6 and Chapter 8": link `#sec-gradients`),
     line 688 (callout "When a fit fails": link `#sec-wrong-place` or `#sec-diagnosis`), line 987
     (parameterisation matters for optimisation: link `#sec-scaling`), line 1131 (slices return
     as a diagnostic: link `#sec-diagnosis`, and check that Chapter 8 uses a slice).
   - `Chapter_4/Practicals/no_solution.qmd` (line 607) and `solution.qmd` (lines 651 and 986):
     the penguin fit; link to Exercise 2 of the Chapter 8 practical and check that the
     explanation of the stopping rule in Chapter 4's solution agrees with Chapter 8 (Stage 3 lists
     any disagreement).
   - `Chapter_5/Theory.qmd`, lines 732 (finite difference: link `#sec-gradients`) and 1172
     (optimisers use partial derivatives: check).
   - `Chapter_6/Theory.qmd`, line 441 (finite differences: link `#sec-gradients`);
     `Chapter_6/Practicals/solution.qmd`, line 1013 (why code 0 is not always the maximum; other
     starting values: link `#sec-multistart`).
   - `Chapter_7/Theory.qmd`, lines 36 (introduction), 719 (Newton's method: link `#sec-search`)
     and 1881 (summary); `Chapter_7/Practicals/solution.qmd`, line 1190 ("Chapter 8 returns to
     this example and shows how to find the maximum, for instance by fitting the model again from
     several random starting values": link to Exercise 3 of the Chapter 8 practical).
   - Lecture slides and scripts: `Chapter_1/Lecture/lecture-script.md` (lines 196, 482),
     `Chapter_4/Lecture_1/lecture.qmd` (line 617) and `lecture-script.md` (lines 415, 443, 485,
     668, 702), `Chapter_6/Lecture/lecture-script.md` (line 326),
     `Chapter_7/Lecture/lecture-script.md` (lines 467, 1010 to 1013); `Chapter_4/lecture-handoff.md`
     (lines 351, 363, 431, 446). Check each; change only what is now wrong. Do not regenerate the
     PDFs of other lectures unless their script changed; list them for the author if it did.
   - `Supplements/deterministic-functions.qmd`, lines 260 ("Chapter 8 uses a threshold function to
     show what a jump does to a likelihood") and 279 ("the methods that search for an optimum by
     following a slope fail for $c$ (Chapter 8)"): **both promises are no longer kept** (the
     chapter has no threshold model, author's decision). Rewrite the two sentences: the second can
     point to Chapter 6's warning callout on thresholds (`../Chapter_6/Theory.qmd#sec-makeadfun`)
     and, for derivative-free and global methods, to `../Chapter_8/Theory.qmd#sec-other-optimisers`;
     the first goes or is generalised. List both changes.
   - `Supplements/glossary.qmd`: the entry "Optimiser" (line 598; link to `#sec-wrong-place`); add
     entries in its format for the new terms that are missing: local minimum and global minimum,
     saddle point, ridge, stopping rule (convergence code), Newton's method, quasi-Newton method
     (BFGS), identifiability (structural, practical), multiple starting values, scaling,
     Nelder–Mead, differential evolution, global optimisation. Check the existing entries
     "Gradient", "Finite difference", "Hessian", "Reparameterisation" and "Likelihood slice".
   - `Supplements/canned.qmd`: if it names the optimiser of glmmTMB, check the wording against
     Chapter 8.
2. **Guidance.** `AGENTS.md`: status (Chapter 8 rewritten as a draft; the "Drafts" list),
   "Where topics live" (what Chapter 8 now contains: stopping rules, diagnosis, multiple starts,
   identifiability, boundaries with bounds only mentioned, scaling, parameterisation,
   `optimize()`, `nlminb()`, Nelder–Mead, differential evolution; SANN and GA not used), "Builds
   and packages" (production renders Chapters 1 to 8; `DEoptim` for Chapter 8; GA removed),
   the lectures line if it names lectures. `.claude/docs/chapters-7-8-other.md`: replace the
   "Chapter 8" entry with the durable decisions of this file (revisited models, organised by
   problem in five sections, concepts only, the algorithms, identifiability, bounds mentioned,
   three practical exercises, one lecture with its demo) and add the lecture to "Lectures".
   `.claude/docs/review-log.md`: entry of the date and the status row of Chapter 8 (draft,
   rewritten in seven stages, independently reviewed). `STYLE_GUIDE.md`: the front-matter
   exception for Chapter 8 (line 354) goes; Practice callouts numbered through Chapter 8 (line
   412: only the supplements stay unnumbered); roadmap and recipe through Chapter 8; under
   "Maximum likelihood with RTMB", a bullet for Chapter 8's tools (other optimisers only in
   Chapter 8, on `obj$fn` and `obj$gr` of the same object; multiple starts in a `for` loop with a
   seed; `DEoptim::DEoptim()` with a box and BFGS afterwards; no algorithm coded by hand) and any
   convention the stages established. `STYLE_GUIDE_LECTURE.md`: the Chapter 8 lecture and its
   demo where the guide lists lectures and demos. Write decisions once, as decisions, not history.
3. **Production build.** `_quarto-prod.yml`: add `Chapter_8/Theory.qmd`,
   `Chapter_8/Practicals/no_solution.qmd`, `Chapter_8/Practicals/solution.qmd` and
   `Chapter_8/Lecture/lecture.qmd` to the render list and to the sidebar sections, in the order
   that the Chapter 7 entries use. Check `_quarto-dev.yml` (it has the three pages; it has no
   Slides section). `.github/workflows/publish.yml`: remove `any::GA`; keep `any::DEoptim`; check
   that every package that the new pages load is listed.
4. **Renders.** `quarto render --profile prod` (the whole production site; about 4 minutes for
   Chapter 7's Stage 7); otherwise render each Chapter 8 page and every page edited in step 1 with
   the production profile. Report exactly what ran and any warning. Check that no `?@` unresolved
   cross-reference remains and that every new link to a Chapter 8 `sec-` ID resolves.
5. **Final report to the author** (in the session and as the last progress-log line): files
   changed per stage, checks that ran, numbers that differ from this file, open questions,
   sentences changed in approved pages (Chapters 1 to 3), stale mentions left for the author, and
   what awaits review. Leave this file in place; the author removes it.

## Open questions for the author

Stages add questions here; they do not wait for an answer.

- **Size of the theory** (Stage 2): the page has 1,940 source lines, against the target of
  about 1,600 in "Choices I made". Part B has about 1,030 lines, because each revisited model
  (deviations, high concentrations, natural-scale rate, owls, fir, DEoptim) needs its own
  set-up chunk. Stage 2 kept every planned example and cut one quiz question (9 remain). If
  the page must be shorter, the candidates are the owl example of `#sec-scaling` (about 70
  lines; the text could quote Chapter 4's correlations instead) and two more quiz
  questions. Conservative choice applied: nothing planned removed.

## Progress log

Each stage adds one line: date, stage, what is done, what is next.

- 4 November 2026: Stage 0 done (author's decisions in five rounds of questions; branch
  `chapter_8` at `2dee366`; feasibility of every theory and practical example checked in R 4.6.1,
  see "Numbers checked" and the numbers under "The practical"; one line added to
  `.claude/docs/chapters-7-8-other.md` pointing to this file; `AGENTS.md` unchanged, because it
  already lists Chapter 8 as generated and not rewritten, and Stage 7 records the decisions).
  Next: Stage 1.
- 4 November 2026: Stage 1 done. `Chapter_8/Theory.qmd` replaced by part A (front matter with
  `title:` only, Introduction, Learning goals, roadmap, `#sec-wrong-place` with `#sec-search`,
  `#sec-gradients`, `#sec-stopping`, `#sec-diagnosis`, Practice 1 `#imp-parasitoid-fits`,
  `#sec-multistart`); 907 source lines, so part B has about 700 lines within the target.
  Renders in the dev profile without warnings (`quarto render Chapter_8/Theory.qmd --profile
  dev`, 21 s); every chunk rerun in a clean session (purled) and every number in the prose
  compared with the output; the three figures inspected. **Objects for Stage 2** (all on the
  page): `co2`, `co2_data` (conc and uptake only), `pooled_nll`, `cmb`, `pooled_obj`,
  `pooled_fit`, `other_starts` and `stop_fits` (named `slow_rise`, `high_asymptote`,
  `early_plateau`), `co2_fits`, `stop_table`, `start_lower`, `start_upper`, `n_starts`,
  `multi_results` (50 rows: `nll`, `convergence`, the four parameters; seed 801, drawn one
  `runif(4, ...)` per start inside the loop), `best_fit`; in hidden chunks, `frog_data`,
  `binomial_nll`, `binomial_obj`, `frog_fits` (three fits, names are the legend labels),
  `mixed_nll` with `co2_data_plant`. `pooled_obj` has been evaluated at many points, so every
  `sdreport()` on it must pass `par.fixed` (the page says so in `#sec-diagnosis`; by default
  it uses `last.par.best`). Differences from "Numbers checked": (1) the slice along
  `log_rate` through the ridge stop is an exact plateau (relative log-likelihood 0 for rates
  above about 0.2 L/µL) with a rise of 12.3 units at 0.015 L/µL; it does not fall slowly as the
  rate grows, and the text says what it shows; (2) the stop near $c=90$: gradient 0.019,
  eigenvalues 835, 168, 13.2, −0.0067; the negative direction combines `c0` (0.98) and
  `log_rate` (0.21), the NLL falls to 302.02 along it, a slice along `c0` alone shows a minimum,
  and `nlminb()` from the stop reaches 296.2557 (for Stage 2); a hidden chunk checks the single
  negative eigenvalue with `stopifnot()`; (3) the stop at zero has $b\to0$ as well as $a\to0$
  ($b\approx4\times10^{-19}$; $\sigma=29.26$, the root mean square of the uptakes); (4) in
  `fig-search_paths` the start that ends at $H\to0$ is ($\alpha$ 0.05, $H$ 0.03), inside the
  plotted window, instead of (0.5, 1); its path first approaches $\alpha\approx0.98$; the
  figure is on the original scales ($\alpha$ 0 to 1, $H$ 0 to 0.06), so the boundaries are
  edges; (5) without `gr`, `optim()` called `fn` 339 times ($83+8\times32$, checked with a
  counting wrapper: central differences, 2 per parameter per gradient). The multiple starts
  reproduce the plan exactly (17, 1 with code 1 at 298.7, 17, 14, 1 at 2098.8); the 17 best
  have `c0` between 45.0 and 46.8. The stopping rule was checked against `vmmin` in R's
  `src/appl/optim.c`: a step that lowers the NLL by less than `reltol * (|f| + reltol)` counts
  as no progress, BFGS then resets its inverse-Hessian approximation to the identity and stops
  if the next step makes no progress either; the gradient is never tested. The page cites
  Nocedal and Wright (2006), *Numerical Optimization*, 2nd edition, Springer, for BFGS (not
  Bolker). Forward references to part B are plain text ("the section on identifiability", "the
  section on boundaries"): Stage 2 may turn them into `@sec-` references. Next: Stage 2.
- 4 November 2026: Stage 2 done. Part B appended to `Chapter_8/Theory.qmd` (1,940 source
  lines in all; see "Open questions"): `#sec-identifiability` with "Structural
  non-identifiability", "Practical non-identifiability" and `#sec-boundaries`, Practice 2
  `#imp-seed-predation`; `#sec-scaling` with "Scaling" and "Parameterisation", Practice 3
  `#imp-fish-scaling`; `#sec-other-optimisers` with "Other local optimisers", "One parameter
  in an interval" and `#sec-global` (technical box on differential evolution); the recipe
  callout, Summary, and a quiz of 9 questions. The three plain-text forward references of
  part A are now `@sec-boundaries` and `@sec-identifiability`. Renders in the dev profile
  without warnings (`quarto render Chapter_8/Theory.qmd --profile dev`, about 15 s), with no
  unresolved `?@`; every chunk of part B was run after part A in a clean session (purled)
  and every number in the prose compared with the output; hidden `stopifnot()` chunks check
  the claims that the printed output does not show (plant asymptotes agree; the reduced
  profile stays within 0.4 units; the counts of the 50-start comparison); figure
  `fig-c0_profiles` inspected. **New objects** (for Stages 3 to 5): `co2_data_plant`
  (now also visible), `deviation_nll`, `deviation_obj`, `deviation_table`, `co2_high_data`,
  `high_obj`, `high_fit`, `high_sd`, `pooled_profile_c0`, `high_profile_c0`, `frog_table`,
  `rate_nll`, `rate_obj`, `rate_fit`, `rate_scaled_fit`, `call_counts`, `nb_nll`,
  `nb_prob_nll`, `owl_obj`, `owl_prob_obj`, `owl_fit`, `owl_prob_fit`, `nlminb_table`,
  `other_results` (columns `bfgs`, `nlminb`, `nelder_mead`), `fir_obj`, `fir_fit` (an
  `optimize()` result), `pooled_de`, `pooled_de_fit`. **Differences from "Numbers checked"**:
  (1) structural example: the plan's start (`log_asym = log(30)`, `dev = 0`, $\sigma$ 2)
  stalls at 260.137 with the asymptote of plant 12 run to zero, a different failure, so the
  page fits from common asymptotes of 10, 20 and 40 µmol/m²/s with $\sigma$ 8: all three
  reach 171.4375 (the no-pooling minimum), agree on all 12 plant asymptotes and end with
  common asymptotes 28.34, 29.89, 31.53; all 16 standard errors are `NaN` in every fit, but
  `pdHess` is `TRUE` in one (rounding of the zero curvature), which the text says; (2)
  practical example: as planned, `c0` stays at 49.98 with se 579 and code 0, `pdHess` TRUE,
  correlation of `log_rate` and `c0` 0.992; but the profile (with `parm.range = c(-1000,
  260)` and `ystep = 0.01`, needed for a fine grid) is flat within 0.33 units from −979 to
  247 µL/L and rises slightly to the left, so the maximum of the reduced data is not at 50
  (`nlminb()` finds 218.5936 at `c0` ≈ −1075, 0.19 above the BFGS stop); the text says that
  BFGS did not stop at the maximum either and that the difference is meaningless; full-data
  profile interval −26.6 to 75.0 µL/L; (3) owls: from Chapter 4's method-of-moments starts,
  BFGS counts are 16/5 ($\mu,k$) and 14/6 ($k,p$), not 31/10 and 25/11; correlations 0 and
  0.711 as planned; (4) Nelder–Mead from Chapter 7's own start ends at 318.68 (not used in
  the text); over the 50 starts, within 0.01 of the minimum: BFGS 17, `nlminb()` 42 (the
  other 8 at 318.7), Nelder–Mead 12 (34 within 2 units); `nlminb()` from the three poor
  starts: 296.2557 with 31, 28 and 55 evaluations of `fn`; (5) DEoptim: 296.2557, 8,040
  evaluations; BFGS from `bestmem` stops at once at 296.2557 (6/1 evaluations), `pdHess`
  TRUE; (6) `optimize()` 2.139962, NLL 89.28529, 11 evaluations (not quoted). Checked
  against primary sources: `?DEoptim.control` (default strategy 2, local-to-best; F 0.8, CR
  0.5), `?nlminb` (PORT, `NaN` replaced by `Inf` with a warning; result elements), RTMB
  vignettes (`nlminb(obj$par, obj$fn, obj$gr)`), `glmmTMBControl()` (`nlminb`); footnote
  cites Storn and Price (1997) and Mullen et al. (2011) as given in `?DEoptim`. **For Stage
  3**: the theory promises that the practical takes up the penguin masses in grams (units and
  relative tolerance) and the Gamma correlation of 0.996 (checked: shape 65.563 after 8/1
  evaluations from the method-of-moments start, 66.095 after a restart), and that it "tells
  the two cases apart" for a variance at practically zero (Exercise 3; link
  `Practicals/solution.qmd`). `.claude/docs/` and `AGENTS.md` unchanged (Stage 7 records
  the decisions). Next: Stage 3.
- 4 November 2026: Stage 3 done. `Chapter_8/Practicals/no_solution.qmd` (about 555 lines:
  opening paragraph, Exercise 1 worked in five questions, Exercises 2 and 3 with questions,
  and the given simulation code of Exercise 3) and `solution.qmd` (about 590 lines: link to
  the worked Exercise 1, `cmb()`, Exercises 2 and 3 with solutions) replace the old practical.
  Question text of Exercises 2 and 3 identical on both pages (checked with `diff`). Both pages
  render in the dev profile without warnings (`quarto render ... --profile dev`, about 16 s and
  22 s), no unresolved `?@`; both pages purled and run in a clean session, every number in the
  prose compared with the output; the two base R figures inspected. Seeds 811 and 812
  (Exercise 1), 751 (simulation) and 831 (refits of Exercise 3); Exercise 2 needs none.
  **Differences from the plan:** (1) Exercise 1: the slice along `log_k` is drawn through both
  fits (0.02 to 0.08/year, 301 points: the slice through the maximum is too sharp for a wide
  grid), flat for the failed fit; the solution also prints `obj$gr()` at the failed start
  (elements 13,534, 6,194, −751, −3,754) to explain the long first step, and says that the
  same start with $\sigma_{\mathrm{obs}}=5$ ft reaches the maximum; the 20 starts end as
  planned (5 at 162.82, 2 at 373.11 = constant curve at the mean height 32.4 ft, 12 at
  425.49, 1 at 551.17); `nlminb()` 33/23 evaluations; DEoptim 8,040, BFGS from `bestmem` at
  once; the mixed model from the failed start (116.669) is checked in a hidden `stopifnot()`
  chunk. (2) Exercise 2: the single step lowered the NLL by $1.642\times10^{-5}$ against the
  threshold `reltol * (|f| + reltol)` = $1.695\times10^{-5}$ in grams and
  $1.41\times10^{-6}$ in kilograms (the decrease is the same in both units); at the first
  iteration the approximation of the curvature is already the identity, so `vmmin` stops at
  once. Chapter 4's solution (lines 975 to 986) agrees with this: nothing to correct there in
  Stage 7. Remedies from the method-of-moments start: kilograms 32/4, mean and shape 13/3
  (correlation −1.3e−6 against 0.996), `nlminb()` 15/8, all shape 66.095. (3) Exercise 3:
  criterion "REML estimate of $\sigma^2_{\mathrm{site}}$ below 0.001": 28 samples, all code
  0, largest gradients 3.6e−5 to 0.018; `pdHess` is `FALSE` in exactly 9 (69, 110, 130, 156,
  195, 221, 251, 277, 331), and these are the samples in which both kinds of refit move to a
  positive variance with a lower NLL and the closed form is positive (0.0016 to 0.16); in the
  other 19 the closed form is 0 and the refits stay below 0.001. The plan's 6 samples are the
  ones above about 0.005; the other three (110, 156, 251) have maxima below 0.004. Mean of the
  500 REML estimates 0.9542 before and 0.9550 after the correction (Monte Carlo standard error
  0.034). The closed form is in the questions and the solution, labelled as an exact result of
  this balanced Normal design. **For Stage 7:** DEoptim is not in the install line of the
  Chapter 1 practical (`Chapter_1/Practicals/material.qmd`, line 372); the Chapter 8 practical
  tells students to install it once, as the Chapter 6 practical does for DHARMa. The links to
  the earlier exercises go to `no_solution.qmd` pages (Chapter 7 Exercise 1 and Exercise 5,
  Chapter 4 Exercise 4) and to Chapter 4's `solution.qmd`. `AGENTS.md` and `.claude/docs/`
  unchanged (Stage 7 records the decisions). Next: Stage 4.
