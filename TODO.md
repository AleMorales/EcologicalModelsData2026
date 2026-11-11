# TODO: author's review after the final check of 11 November 2026

The final check of the book (plan `.plans/plan_final_check.md`) changed 51 files. Everything
it changed is a generated draft until the author has reviewed it. This list holds what the
author has to check or decide.

- **This year:** Chapters 5 to 8, both case studies, the lectures of Chapters 6 to 8, the
  supplements that those chapters use, and the guidance files.
- **Next year:** everything that touches Chapters 1 to 4, which have already been taught:
  their theory pages, practicals and lectures, and the distributions supplement, which
  supports Chapters 2 to 4. These changes are on the branch `next_year` (pushed), not on
  `main`.

The reports of the agents (`.plans/final_check/reports/`) and of the independent reviewers
(`.plans/final_check/review/`) are in a git-ignored folder and exist only on the machine
where the check ran. Each item below says what changed and where, so that the list can be
used without them. Line numbers are left out because they shift; items name the exercise,
question, section or slide.

## This year

### 0. Before anything is committed or published

- [ ] The uncommitted working tree on `main` now holds only the changes for this year
      (Chapters 5 to 8, case studies, supplements other than distributions, guidance
      files) and this file (staged). Chapters 5 to 8 have not been checked by the author
      yet. Read the diff of every file once (`git diff <file>`): the changes are drafts,
      and the list below covers decisions, not every sentence. Commit when done.
- [ ] Run one more full build (`quarto render --profile prod`). The last full render ended
      with exit code 0, but three lectures and the Chapter 5 solutions page were changed
      afterwards and rendered only individually.

### 1. Chapter 5

Practical and theory reviewed by the author on 11 November.

- [ ] Look at Exercise 5 on the rendered student and solutions pages of Chapter 5 (both
      re-rendered without warnings after the change, not yet looked at in a browser).

### 2. Chapter 6

Practical (`Chapter_6/Practicals/no_solution.qmd`, `solution.qmd`):

- [ ] **Open gap, needs a decision: no question fits a Beta-Binomial model** or uses
      `dbetabinom()`, although a model for overdispersed proportions is a learning goal, a
      roadmap row and recipe step 8. No data set of the practical is a proportion. Proposal
      of the agents: an extra question (about 20 minutes) on `emdbook::ReedfrogPred` with a
      Binomial and a Beta-Binomial fit, the dispersion of the residuals and AIC. A curve
      that returns a probability (`plogis()`, a band on the logit scale) is not practised
      either.
- [ ] **Exercise 1, question 2** now also asks for `obj$gr()` at the starting values and
      at the estimates (about 5 minutes). Confirm.
- [ ] **Exercise 1, questions 1 and 3** carry new hints (why a Normal model can suit
      positive titres; when a Wald interval can be used on the original scale). Confirm the
      reasoning.
- [ ] **Exercise 1, question 5:** the Gamma model is now presented with the mean $\mu$ and
      the shape $k$, with a clause on `scale = mu / shape`. A paragraph on the Normal model
      suiting a log10 titre was deleted because no question asks for it: restore it as a
      footnote if you want it.
- [ ] **Exercise 2, question 1** now asks students to read the starting values of $a$ and
      $b$ from a plot of the data (recipe step 3). Confirm.
- [ ] **Exercise 2, question 6:** the solution uses `plot()` and `plotResiduals()` in place
      of `plotQQunif()`, which the chapter does not teach. Confirm.
- [ ] **Exercise 4:** the solution of question 1 says that the function is shown once with
      both gaps filled, and the explanation of gap 2 moved to question 2. Confirm.
- [ ] About nine unasked interpretations were deleted from the solutions (for example the
      suggestion of a generalised Ricker curve in Exercise 1 question 4). Read the solutions
      page once for anything you want back.
- [ ] **Numbers that nobody verified:** which quartile line DHARMa draws in red and
      whether its test flags the pattern (Exercise 1 question 4, Exercise 2 question 6);
      the standard errors 0.043, 0.13 and 0.11 in Exercise 3 question 6.

Theory (`Chapter_6/Theory.qmd`):

- [ ] "Information criteria": the "where" clause of the AIC and AICc formulas now says that
      $\hat\theta$ stands for all the estimated parameters of the model. Confirm.
- [ ] **Notation, needs a decision:** $K_i$ (number killed, your decision) stands beside
      $K$ (number of parameters); the Beta-Binomial mean and variance also use an
      unindexed $K$ for the number killed. Keep, or write the number killed as $Y_i$ (also
      in the lecture and in the inset of the band figure).
- [ ] **Notation, needs a decision:** the parameters of the curve are $\boldsymbol\beta$
      in $\theta_i=f(x_i;\boldsymbol\beta)$, whereas Chapters 7 and 8 write
      $\boldsymbol\theta$ for all the parameters and Chapter 7 uses
      $\beta_{\mathrm{name}}$ for the coefficient of a predictor.
- [ ] **Notation, optional:** the Beta-Binomial is displayed with its two shapes,
      $\operatorname{Beta-Binomial}(N_i,\kappa p(N_i),\kappa(1-p(N_i)))$; the alternative is
      $(N_i, p(N_i), \kappa)$.
- [ ] `Practice` callouts 1 and 2: one unasked sentence was removed from each solution.

Lecture (`Chapter_6/Lecture/lecture.qmd`, `lecture-script.md`):

- [ ] Slides changed: 16 (no reference to the box), 19, 21, 24 (names `dbetabinom()`), 26
      (why a penalty for $K$ is needed; the candidates are fitted in a loop), 28. Look at
      each in the rendered lecture.
- [ ] **Slide 28, "Comparing the candidates":** it ran into the footer and was shortened;
      the takeaway is now "A model that ignores variation among units overstates the
      evidence for the curve" and the caption is gone. Confirm that nothing you need was
      lost.
- [ ] **Slide 14, "Where the data lie":** it has 4 minutes for about 15 lines of main text
      and uses a figure of Chapter 5. Keep, or reduce to 3 minutes and add the minute to
      the slack.
- [ ] The two "Optional remark" paragraphs of the script on box material (the tape, the
      delta method) were cut to one sentence each. Confirm.

### 3. Chapter 7

Practical (`Chapter_7/Practicals/no_solution.qmd`, `solution.qmd`):

- [ ] **Notation changed throughout:** Exercise 2 indexes the tank with $j$ and writes
      $Y_j$, $u_j$, $n_j$, $p_j$, $P_j$ (it used $X_i$, $u_i$); Exercises 3 and 4 write the
      response as $Y_{ij}$ (it was $X_{ij}$). Read the three exercises once for a symbol
      that was missed, on both pages.
- [ ] **Notation, needs a decision:** worked Exercise 1 keeps $H_{ij}$, $h(t)$, $A$, $k$,
      $t_0$ for the pine curve, so $k$ is a rate there, the shape of the Negative Binomial
      in Exercise 3, and $K$ is the number of parameters. Keep, or write the pine curve
      with the generic $a(1-e^{-b(x-c)})$ of the theory (also in Exercise 1 of the Chapter 8
      practical).
- [ ] **Exercise 1, question 4** now asks for the age at 63% of the asymptote, and
      **question 5** for the mean height per age with `tapply()`; the remark on logistic
      and Gompertz curves and the claim that DHARMa flags a difference in spread among ages
      were removed. Confirm.
- [ ] **Exercise 2, question 4:** the hint explains the shape of the inverse logit itself
      and no longer sends students to the Jensen box of Chapter 4. Confirm the wording.
- [ ] **Exercise 2, question 5** now asks, on paper, for the columns of `~ pred * size`.
      Confirm.
- [ ] **Exercise 4, question 2** now reports the expected count at a mined site with
      `ADREPORT()` and a Wald interval (result 0.045, 0.011 to 0.19). Revert if you prefer
      the pattern of Exercise 3.
- [ ] **Exercise 5, question 3:** the hint points to the rule of shrinkage in the main text
      and no longer uses the weight formula of the box. Confirm.
- [ ] **Coverage left open, needs a decision:** typical groups from a second model matrix
      (`group_info`, `X_asym_group`) are practised nowhere (proposal: in Exercise 3
      question 2, the expected calls of a satiated brood in a typical nest from a one-row
      data frame, about 5 minutes); a fitted comparison of candidates that differ in their
      formula is not practised (proposal: AIC of `~ mined` in Exercise 4 question 2); the
      Laplace approximation is not asked about.
- [ ] `no_solution.qmd` was not run as a whole after the changes (its questions equal those
      of the solutions page and the code of Exercise 1 is unchanged). The build rendered it
      without errors.

Theory (`Chapter_7/Theory.qmd`):

- [ ] `#sec-grouped-residuals`: the sentence before the chunk with
      `residuals(plant_residuals)` now says that `residuals()` returns the scaled quantile
      residuals of a DHARMa object. Confirm.
- [ ] **Practice 3 (`imp-stand-growth`):** the simulated mean was corrected from 21.7 to
      21.6 cm/year (seed 702 gives 21.65; the closed form is 21.67). Confirm.
- [ ] Practice 1 and 2: unasked content was removed from the solutions. Read both.
- [ ] Shrinkage and REML boxes: `\bar y` became `\overline y`. No decision needed; look at
      the rendered boxes.
- [ ] The page defines `treatment_nll` twice (noticed in the inventory, not changed).
      Decide whether the second definition is intended.
- [ ] The main text (near the section on new groups) still points to the Jensen box of
      Chapter 4 for the median against the mean; the pointer is optional. Keep or remove.

Lecture (`Chapter_7/Lecture/lecture.qmd`, `lecture-script.md`):

- [ ] Slides changed: 5 (the function of the example moved to the example box), 8
      (retitled "A two-level model with a random effect"), 15, 17 (a bullet on `ADREPORT()`
      and derived quantities), 18 (`levels()` and `relevel()`), 27 (a bullet on differences
      between models fitted to the same observations; the formula is
      $\mathrm{AIC}=2K-2\,\ell(\hat\theta)$), 28. Look at each in the rendered lecture.
- [ ] **Slide 28, "Comparing the candidates":** to fit above the footer it lost the bullet
      on no pooling and the caption with ΔAIC. The script still explains why no pooling is
      not in the table. Decide whether the point must be back on the slide (then shorten
      the table or the takeaway).
- [ ] **Slide 21, "Practice 2":** it uses the shrinkage weight formula, which the chapter
      has in a collapsed box (and in its own Practice callout). Keep or drop the slide.
- [ ] **Slide 19, "Two ways to encode groups" (3 minutes):** it covers a note callout of
      the chapter. Keep, or shorten.
- [ ] Timing: the Laplace slide (14) went from 4 to 3 minutes and the slide on uncertainty
      and REML (23) from 4 to 5. The total stays 150 minutes. Confirm.
- [ ] Script, Practice 3: now "about 21.6 cm/year". The three optional remarks on box
      material were cut to one sentence each.

### 4. Chapter 8

Theory (`Chapter_8/Theory.qmd`):

- [ ] **New main text in `#sec-diagnosis`:** one sentence that says what `pdHess` reports
      (`TRUE`: the NLL curves upwards in every direction from the solution). Confirm the
      wording.
- [ ] **New main text in `#sec-multistart`:** two sentences on evaluating `obj$fn()` and
      `obj$gr()` at the starting values before a fit (recipe step 1, which the main text
      did not teach). Confirm the wording and the placement.
- [ ] The number of parameters is now $K$ where it was $p$ (six places). Look at the
      Nelder–Mead passage and the finite-difference box.
- [ ] **Practice 3 (`imp-fish-scaling`)** has a new question on `parscale` with the answer
      `c(1, 1, 100, 1)`. Keep or revert.
- [ ] Practice 1: a gloss of `pdHess` in plain words was added. Confirm.
- [ ] Four subsections have no `sec-` ID (structural and practical non-identifiability,
      "Scaling", "One parameter in an interval"). Add IDs if other pages should link to
      them.
- [ ] Optional: `#sec-stopping` does not say that BFGS evaluates `gr` at the start and
      after each step that counts (the hint of Exercise 2 question 1 states it itself).
- [ ] The theory is still longer than its target (noted before the check; not changed).

Practical (`Chapter_8/Practicals/no_solution.qmd`, `solution.qmd`):

- [ ] **Exercise 2, question 1** now asks for the check of `fn` and `gr` at the starting
      values. Confirm.
- [ ] **Exercise 3, question 3** now asks why `pdHess` is `TRUE` in some fits and `FALSE`
      in others (the solution already answered it), with a hint to `#sec-diagnosis`. The
      sentence on the bias of REML stays as one sentence marked as beyond the question, as
      you decided earlier. Confirm.
- [ ] **Exercise 1:** question 3 asks which curve each end point describes; "elements in
      the thousands" became "hundreds to thousands" (the printed gradient is 13534, 6194,
      −751, −3754). Confirm.
- [ ] Exercises 2 and 3: the method-of-moments estimates carry hats ($\hat k$, $\hat r$),
      the sample mean is $\overline x$, and the variance with divisor $n$ is
      $\hat\sigma^2$. Look at the rendered page.
- [ ] **Coverage left open, needs a decision:** `TMB::tmbprofile()`, Nelder–Mead,
      `optimize()`, an exact against an approximate gradient, and identifiability have no
      exercise question (identifiability only in the paper callout Practice 2). Proposals
      within the 3-hour budget: one call of `optim(method = "Nelder-Mead")` in Exercise 1
      question 4, comparing the NLL and the number of evaluations; a profile of the
      standard deviation among sites in Exercise 3 question 2 (untested: `tmbprofile()`
      with `random`).
- [ ] **Numbers that nobody verified:** the NLL of 1138 in grams and the "0.003" change
      of the shape in the first step (Exercise 2).

Lecture (`Chapter_8/Lecture/lecture.qmd`, `lecture-script.md`):

- [ ] **Slide 13** is retitled "Curvature at the end of a search" and rebuilt on the main
      text (what `pdHess` reports, a flat direction, a downward curvature); "positive
      definite", the inverse and the eigenvalues left the slide and the script. Confirm.
- [ ] Slides changed: 9 (takeaway "Code 0 says that the stopping rule was met, not that
      the maximum was found"), 10 (shortened to fit), 12 and 29 (`sdreport()` in place of
      "Hessian"), 15 (three bullets), 16 (names `TMB::tmbprofile()`), 17 (a boundary can be
      the maximum or a failure; the estimate on both scales), 19, 26 (a definition of
      global search), the Nelder–Mead slide ($K+1$ points). Slides 13 and 16 are tight
      above the footer: look at them.
- [ ] Timing: slides 10 and 16 gained a minute each, slides 15, 25, 26 and 27 lost one
      each, and the slack grew from 14 to 16 minutes. Confirm.
- [ ] Script: the formulas of Newton's method, the BFGS update and differential evolution,
      `ndeps`, $F$, $CR$ and $NP$ were removed; each box is now mentioned in one sentence.
      Confirm that nothing you want to say was lost.

### 5. Case studies

- [ ] `Case_study_1/Theory.qmd`: the coefficient of variation is now $v$ (it was $c$), as
      in Case study 2; the R object `cv` is unchanged. Read the section on the difference
      between the species.
- [ ] `Case_study_1/Theory.qmd`: two pointers no longer credit Chapter 2 with the Gamma
      distribution; they go to the supplement (`#sec-gamma`) and to Exercise 4 of the
      Chapter 4 practical. Confirm.
- [ ] `Case_study_2/Theory.qmd`: "3 g per week" became "3 g/week" and a stray ",:" was
      removed.
- [ ] **Notation, needs a decision:** Case study 2 writes the response as $W_{ij}$ (leaf
      mass), because $Y^{1989}_j$ and $Y^{1990}_j$ are the indicators of the years. Keep,
      or write the response as $Y_{ij}$ and give the indicators another letter.
- [ ] Not fixed (known before the check): the coverage figures quoted in the simulation
      section of Case study 2 (94.6% and 92.8%) disagree with the printed output (0.95 and
      0.93).

### 6. Supplements used from Chapter 5 on

`Supplements/deterministic-functions.qmd`:

- [ ] The saturating exponential entry now gives the 63% point ($x=c+1/b$) and the
      half-maximum ($x=c+\log(2)/b$) of the shifted form, and says that Chapter 8 fits the
      function of Chapter 7 again. Confirm.
- [ ] The range in the summary of the Richards function is now $0<y<a$ for $d>0$ and
      $0\le y<a$ for $-1\le d<0$ (checked numerically). Confirm.
- [ ] One sentence was corrected to "piecewise functions" with British spelling.
- [ ] **Needs a decision:** the logistic and bell-shaped entries write generic
      coefficients as $\beta_0$, $\beta_1$, $\beta_2$. Keep, or write them with $a$ and $b$
      and the midpoint in words.
- [ ] Optional: the Michaelis–Menten entry has no sentence on the shifted form, which
      Chapter 5 teaches (Exercise 2 question 4, Exercise 5 question 3, quiz question 8).

`Supplements/calculus.qmd`:

- [ ] New: the exponent of a power law from two points (worked case and R lines), which
      Chapter 5 Exercise 7 needs; the limit of $e^{-bx}$ as $x\to-\infty$; a chain rule
      applied twice; the tangent as an approximation of the curve ($e^{-u}\approx1-u$); the
      central difference in "Checking with R". Confirm each.
- [ ] **Optional addition, needs a decision:** second and mixed partial derivatives with a
      link to the Hessian, and practice problem 21. The Hessian is box material in the
      chapters: delete the passage and the problem if it is outside the refresher.
- [ ] About 75 logarithms gained parentheses and the products of the rules lost `\cdot`
      (now a thin space between symbols and `\times` between numbers). Look at the rules of
      differentiation in the rendered page: check that every product still reads without
      ambiguity.
- [ ] Practice problem 18 was reworded and the solution of problem 21 changed the order of
      differentiation to match the definition on the page. Confirm.

`Supplements/canned.qmd`:

- [ ] **The mathematics was rewritten to the convention of Chapter 7:** coefficients
      $\beta_0$, $\beta_{\mathrm{x}}$, $\beta_{\mathrm{quad}}$, $\beta_{\mathrm{level}}$,
      $\beta_{\mathrm{disp}}$ (they were $a$, $b$, $c$); the indicator $M_i$ (it was $z_i$);
      baselines $\log(\sigma_0)$ and $\log(k_0)$; $\eta$ defined once as the linear
      predictor of the fixed effects, with $u_j$ added explicitly. The subscripts are the
      agent's choice. Read every formula of the page.
- [ ] `pdHess` is now attributed to Chapter 8 (`#sec-diagnosis`), not to Chapter 4.
- [ ] New sentences: `nlminb()` as the default of `glmmTMB` with a link to Chapter 8;
      `model.matrix()` with a link to Chapter 7; grouped models are compared with AIC only
      (also in the table row of `BIC()`); why the course does not rest decisions on the
      p-values of DHARMa. Confirm each.
- [ ] The sentence on `ziformula` now says that the distributions supplement describes
      zero inflation as an extra probability $p_0$ and that `ziformula` makes it depend on
      predictors through a logit link. Confirm.

`Supplements/distributions.qmd`, the part that Chapter 6 uses:

- [ ] The Beta-Binomial entry is now parameterised with the mean probability $p$ and
      $a=\kappa p$, as Chapter 6. Its example is now parasitised aphids (24 per plant) in
      place of tadpoles in tanks. Confirm the entry (the rest of the page is under "Next
      year").

### 7. Not inspected by the check

- [ ] Symbols inside the PNG and SVG files of the lectures of Chapters 6 to 8 were not
      looked at. Known: the inset of the band figure of Chapter 6 carries
      "K ~ Binomial(N, p(N))".
- [ ] The DHARMa panels and the other figures of the changed practical pages were run but
      not looked at one by one. Look through the rendered solutions pages of Chapters 5 to
      8.

## Next year

Everything below touches Chapters 1 to 4, which have been taught this year. The author has
read the diffs and approved the changes, which live on the branch `next_year` (commit
`3661834`, pushed). The items below are what is left to check or decide on that branch
before it is merged into `main` for the next course.

### Corrections that could go out now

These are errors, not changes of content. They could be merged into `main` before next
year.

- [ ] `Chapter_1/Practicals/material.qmd`: the axis labels of the ggplot2 scatter plot of
      the iris data were swapped (the x axis shows `Petal.Length`).
- [ ] `Chapter_1/Practicals/material.qmd`, Exercise 9: the solution did not combine the two
      conditions with `&`, as the task asks.
- [ ] `Chapter_3/Practicals/no_solution.qmd`: the preamble said that Exercises 2 to 4 are
      all simulated, but Exercise 3 uses the real `trees` data.
- [ ] `Chapter_2/Theory.qmd`, Practice 4: the solution did not state the answers to its
      questions (the probabilities, the mean 9.6 and the variance 3.84).
- [ ] `Supplements/distributions.qmd`: "Seven distributions for continuous data" before
      eight entries.

### Chapter 1

- [ ] `Chapter_1/Theory.qmd`: read the new roadmap entry "Supplement: Symbols" (on `main`;
      it is in the author's approved chapter).
- [ ] Check the symbols of Chapters 1 to 4 on `next_year` against `Supplements/symbols.qmd`,
      whose chapter numbers were checked on `main`.

Practical (`Chapter_1/Practicals/material.qmd`; approved, the author's text):

- [ ] **Solutions changed in Exercises 3, 6, 7, 8, 9, 10, 11, 12 and 13.** Read each
      against its tasks.
- [ ] **Exercise 10:** the question "which version do you prefer, and why?" is now answered
      with a neutral paragraph on what base R and ggplot2 each make easier. Replace it with
      your own view. The ggplot2 versions now carry the axis labels of the base versions.
- [ ] **Exercise 11:** task 1 now tests three values, as asked; the closing remark that a
      loop can be avoided only when a formula for the whole sequence exists was removed.
      Restore it if you value it.
- [ ] **Exercise 12:** the wording about passing `na.rm` "to `length`" was corrected.
- [ ] **Exercises 7 and 8:** the solution parts are numbered like the tasks; Exercise 7
      explains `rowSums(cover > 20) > 0` and has an example of a logical vector as the row
      index of a matrix.
- [ ] **Exercise 13:** the solution explains `mean(taken > 0)` and names the least
      attractive species; the dplyr alternative and other extras were removed.
- [ ] **New teaching text in "Base R graphics":** one paragraph and one chunk on `lines()`,
      `abline()`, `legend()` and `lty`, and two sentences on `type = "l"`. The style guide
      says that the Chapter 1 practical teaches these functions, and it did not. Rewrite in
      your own words; the `lines()` example draws a line by eye between two arbitrary
      points.
- [ ] **New:** `population_growth()` has a default argument (`years = 50`), with a sentence
      and calls that use and override it, because default arguments were announced without
      an example. Confirm.
- [ ] `print()` is introduced at first use, and a few plot arguments that nothing taught
      were removed from solutions. Confirm.
- [ ] **Needs a decision:** Exercises 1, 2 and 4 have no solution part. Add one line each
      if every exercise should have a solution.
- [ ] **Needs a decision:** the section on base graphics uses `set.seed()`, `rpois()`,
      `dpois()`, `cumsum()` and `table()/N` without explanation (HTML comments in the source
      say that they are to move to Chapter 2).
- [ ] **Needs a decision:** R tools that later chapters use and the practical does not
      teach: `round()`, `rbind()` and `cbind()`, `data(name, package = )`, `seq_along()`,
      `which()`, `%in%`, `replicate()`, `quantile()`, `apply()`. Teach them here, or where
      each is first used in Chapters 2 to 4.
- [ ] Noticed and not changed: `.xlsx` and tab-separated files are mentioned in "Loading
      data" without a function; "from brightspace" at the data download; the typos
      "undersand", "highes", "specially".
- [ ] Notation: `\cdot` was removed from $N_{t+1}=r\,N_t$ and $N_t=N_0\,r^t$. The letter
      $r$ is a growth rate there and a radius in the exercise on the volume of a sphere.

Theory (`Chapter_1/Theory.qmd`): not changed.

- [ ] The roadmap names neither the case studies nor the glossary. Decide whether it
      should.

Lecture (`Chapter_1/Lecture/`): not changed.

### Chapter 2

Practical (`Chapter_2/Practicals/no_solution.qmd`, `solution.qmd`; approved):

- [ ] **Exercise 6, question 5 (new):** a 2 × 2 joint table of $V$ (cover of at least 0.20)
      and $S$ (seedlings present), the marginals with `colSums()` and `rowSums()`, and the
      products against the joint probabilities. It is the only practice of joint and
      marginal distributions and of independence, which are a learning goal. The ecological
      story and the numbers are generated: check them, or move the question, or delete it.
      It adds about 10 minutes to the practical.
- [ ] **Exercise 3, question 3 (your exercise):** re-aimed from "a model with spray as a
      predictor" to a distribution within each spray, with a clause on i.i.d. Confirm or
      restore. The solution of question 2 keeps a column `n = n()` that the question does
      not ask for.
- [ ] **Exercise 4 (your exercise):** the questions now name `rnbinom2()` and the Poisson
      entry with `dpois()`; the solution of question 3 uses `var()` only (the variance with
      divisor $n$ is a Chapter 3 topic); the ratio moved to question 4; `matplot()` was
      replaced by `plot()`, `lines()` and `legend()`. `probability_sum` remains although no
      question asks for it. Confirm.
- [ ] **Exercise 1 (your worked exercise):** the `choose()` chunk and the final comparison
      chunk were removed because no question asks for them; a link to the Binomial entry
      and one sentence each on `table()` and on `rbind()` with `beside` were added. Some
      extra sentences in worked Exercises 1 and 2 were left. Confirm.
- [ ] **Exercise 5:** question 1 now asks to verify the mean with `integrate()` (the result
      is 33.99, as the formula gives); the solution of question 3 no longer uses
      `par(mfrow)`. Confirm.
- [ ] **Exercise 6, question 4:** a note on "< or <=" and an extension on zero inflation
      were removed from the solution; the exercise no longer points to the zero-inflated
      section of the supplement.
- [ ] Exercise 2: an unasked legend was removed from the solution.

Theory (`Chapter_2/Theory.qmd`), `Practice` callouts only:

- [ ] Practice 1: the solution is restructured as answers 1 to 5, and the sentence "89%
      sure" (an epistemic reading of a probability) was removed. Confirm.
- [ ] Practice 2: an explicit answer to the second question was added.
- [ ] Practice 4: see "Corrections that could go out now".
- [ ] Notation: `Var(X)` became `\operatorname{Var}(X)`, three typed dots became `\ldots`,
      and `mm$^2$` became mm².
- [ ] Noticed and not changed: three terms are in italics where the style guide asks for
      bold (*bivariate*, *overdispersion*, *underdispersion*); the figure of the four faces
      uses `theme_minimal()` and colours outside the course palette; $k$ is both the order
      of a central moment and the shape of the Negative Binomial.

Lecture (`Chapter_2/Lecture/`): not changed.

### Chapter 3

Practical (`Chapter_3/Practicals/no_solution.qmd`, `solution.qmd`; approved):

- [ ] **Exercise 2, question 4 (new):** a histogram, a kernel density estimate and the
      `ecdf()` of the sample against the model (seed 99). It is the only practice of
      empirical distributions in the practical. The theory names `hist(probability = TRUE)`
      only in prose, so the question gives the argument. Keep or delete. The plots were not
      looked at.
- [ ] **Exercise 2:** the student page gained the three hints that only the solutions page
      had; the solution lost `aggregate()` and the standard deviations, and one sentence
      introduces `rbind()`.
- [ ] **Exercise 1, question 2:** the Poisson standard error was removed from the solution.
- [ ] **Exercise 3, question 2:** the interpretation "2.1 standard errors" was removed;
      `rowMeans()` is explained in a comment. The question uses the bias $-\sigma^2/n$,
      which the main text gives in words and numbers.
- [ ] **Exercise 4:** `&&` and a default argument left the solution, and the comparison
      with the standard deviation of the individual masses was dropped.
- [ ] The removed extras were interpretation that you may want back as questions.
- [ ] **Coverage left open:** `table()` and `quantile(type = 1)` on counts are practised
      only in Practice 2 of the theory.
- [ ] **R names, needs a decision:** `mu_hat`, `variance_mm`, `variance_hat` and `k_hat`
      break the `_mom` rule of the style guide (`mu_mom`, `var_mom`, `k_mom`). Not renamed.

Theory (`Chapter_3/Theory.qmd`):

- [ ] **Practice 2:** the plot now uses only `plot(type = "h")`, `points()` and `legend()`,
      without helper data frames, and the second question ("How much can you rely on a
      single simulation?") is answered explicitly, with the sample means 2.42 and 2.98
      (seed 246). Confirm.
- [ ] Notation: `\bar{I}_n` became `\overline{I}_n` in the box on the law of large numbers.
      The estimated standard error is written $s/\sqrt n$ in the footnote on the Wald
      interval and in the solution of Exercise 4 (left as it is).
- [ ] Noticed and not changed: the skewness values 1.4 and 0.26 quoted in the text are not
      calculated on the page.

Lecture (`Chapter_3/Lecture/`):

- [ ] Slide "Summaries of a sample": the variance of the empirical distribution is now
      $\hat\sigma^2$ (it was $S^2_X$). Confirm against the chapter.
- [ ] Script, slide 33: the sentence on Exercise 2 now also names question 4.
      `lecture-script.pdf` was regenerated.

### Chapter 4

Practical (`Chapter_4/Practicals/no_solution.qmd`, `solution.qmd`):

- [ ] **Exercise 1, question 3 (your decision of 3 November stands):** the Hessian is still
      taken by hand once, although the observed information, the Hessian and the delta
      method are box material in the theory. The question now defines the Hessian and the
      solution explains it as the curvature of the log-likelihood (main text,
      `#sec-curvature`), without references to the boxes. Confirm that this is how you want
      the conflict resolved.
- [ ] **Exercise 1, removed because no question asks for them:** the closing caveat of
      question 6 (the interval is too narrow because of the overdispersion of question 5;
      forecast of Chapters 6 and 7), the pointer to the Beta-Binomial in question 5, the
      5.5-times comparison, the second-derivative check, the formula check and the NLL at
      the minimum. Two of the deleted sentences were yours. If you want the caveat back,
      add "How much weight does the comparison deserve?" to question 6.
- [ ] **Exercise 1, question 5:** `sort(unique())` was replaced by `c(10, 25, 35)`.
- [ ] **Exercise 3:** the introduction says that `zeroprob` is the argument of RTMBdist;
      question 4 has a hint for $P(X\ge 20)$ with `pzipois()` and `pnbinom2()`. Confirm.
- [ ] **Exercise 5, question 1** now asks to check that every fit converged; "the MLE is
      the better" and the Monte Carlo standard error were removed from the solutions.
- [ ] Unasked content was also removed from the solutions of Exercise 2 (questions 3 and
      5), Exercise 3 (questions 2 to 4) and Exercise 4 (question 1).
- [ ] Notation: about 35 logarithms and all the logits gained parentheses on both pages.
      Look at the rendered pages.
- [ ] **Coverage:** the properties of estimators (a learning goal) and misspecification are
      practised only in the extra Exercise 5, and the joint region once, as decided on
      4 November. No action unless you want to revisit it.
- [ ] **R names, needs a decision:** `shape_ml` and `sim_k_ml` break the `_mle` rule.

Theory (`Chapter_4/Theory.qmd`):

- [ ] Kullback–Leibler box: the probability under the data generating process is now
      $P_0(X=x)$ and the expectation $E_0$ (it was $g$, which is a transformation elsewhere
      on the page). Confirm.
- [ ] The sentence on partial derivatives near the Hessian box now links to
      `calculus.qmd#sec-calc-partial`.
- [ ] Practice 1 now asks to verify the result in R; Practice 4 lost an unasked sentence.
- [ ] Noticed and not changed: the main text uses three terms that are defined only in
      boxes (Hessian, Fisher information, Kullback–Leibler divergence).

Lectures (`Chapter_4/Lecture_1/`, `Chapter_4/Lecture_2/`):

- [ ] Lecture 2 script: three spacing-only changes in formulas; `lecture-script.pdf` was
      regenerated. Lecture 1 was not changed.
- [ ] Slide 6 of Lecture 2 writes 1.96 and its script $z_{0.975}$ (both allowed).
- [ ] Known before the check and not addressed: the slides of both lectures no longer match
      the chapter in places after the simplification of 3 November.

### Distributions supplement (`Supplements/distributions.qmd`)

It supports Chapters 2 to 4. Twelve examples and `Practice` callouts were replaced because
they shared a setting with an exercise, and two more because they came close. All new
settings are hypothetical placeholders: confirm or replace each.

- [ ] **Binomial (your entry):** seedling survival became mistletoe on 16 host trees
      ($p=0.75$). The sentences around the example are yours and were kept. Note that 16 is
      also the number of trials of the callout `imp-orchid-plants` of Chapter 2.
- [ ] **Poisson (your entry):** wildlife detections became mist-net captures. The solution
      of the callout gained a sentence that answers its "why" question.
- [ ] **Negative Binomial (your entry):** seedlings in quadrats became earthworms in soil
      cores.
- [ ] **Conway–Maxwell–Poisson:** clutch size became litter size (a mean of 2.5 pups).
- [ ] **Exponential and Gamma:** waiting for a pollinator became waiting times at a camera
      trap. Callouts: the time until a barnacle larva settles on bare rock (Exponential),
      acorn mass (Gamma).
- [ ] **LogNormal:** body mass became the home range of deer. **Beta:** vegetation cover
      became the fraction of time that a tortoise feeds. Both had the exact parameters of
      Exercises 5 and 6 of the Chapter 2 practical.
- [ ] **Weibull callout:** seedling survival time became limpet survival time.
      **Multivariate Normal callout:** turtle traits.
- [ ] **Needs a decision:** the Binomial callout "hatching success in a clutch" (12 eggs,
      $p=0.6$) was kept, although quiz question 9 of Chapter 2 sets the same task.
- [ ] The general statements of the Beta entry still name vegetation cover and the fraction
      of a leaf eaten as examples of use (the settings of two exercises); they are not
      worked examples and were left. The same holds for the sentences of Chapters 1 and 2
      that name body mass and vegetation cover as uses of the LogNormal and the Beta.
- [ ] The sentence of the Student's t entry about Chapter 3 now names what Chapter 3
      contains (the interval for a Normal mean, in a footnote).
- [ ] Zero-inflation section: the mass of the original distribution is now $P(X=x)$ and its
      density $f_X(x)$ (they were $p(x)$ and $f(x)$), and $p_0$ replaced `p_{\text{0}}`.
      The R name `pzero` and the section ID are unchanged.
- [ ] Other notation: parentheses on logarithms (Conway–Maxwell–Poisson and LogNormal),
      $e^{\ldots}$ in the LogNormal summary, units as m², g² and /mm², $E$ in the
      Multivariate Normal entry, $n$ for the number of trials in the Multinomial overview.
- [ ] Three callout solutions lost a line that did more than was asked (Bernoulli,
      Conway–Maxwell–Poisson, LogNormal).
- [ ] Symbols that only the supplement uses were left as they are (Student's t, Dirichlet,
      Multinomial, Multivariate Normal, Weibull scale $\lambda$ and shape $k$, $K$ as a
      number of categories).
