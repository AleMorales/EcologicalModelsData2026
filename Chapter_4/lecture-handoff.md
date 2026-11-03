# Handoff: Chapter 4 lectures (maximum likelihood estimation)

This file tells future agents how to build the two lectures of Chapter 4. The structure, timing
and scope below were settled with the author on 30 October 2026. Do not change them without
asking. Routine wording and layout choices are yours.

## How the work is split

| Phase | Who | What | Ends with |
|---|---|---|---|
| 0 | Done on 30 October | The author's decisions, this plan, and the updates to `STYLE_GUIDE_LECTURE.md`, `AGENTS.md` and `CLAUDE.md` | This file |
| **1** | One agent (a second one may continue from "Progress log") | Figures and slides of **both** lectures, in three steps: (A) folders, figures and numbers; (B) Lecture 1 slides; (C) Lecture 2 slides | **Stop.** The author reviews and edits the slides of both lectures together |
| **2** | One agent, after the author's review | Both scripts and their PDFs, written from the slides as the author left them. Lessons from the review go into the guidance | Final report |

Phase 1 writes **no script**, because the script follows the slides and the author usually
rewrites slides. Do not commit unless asked. Before the author edits the slides, ask them
whether to commit the Phase 1 state, so that Phase 2 can read their corrections in the diff.

## Read first

In this order, in both phases:

1. `CLAUDE.md`, `AGENTS.md`, `STYLE_GUIDE.md` (prose, notation, units, R).
2. `STYLE_GUIDE_LECTURE.md`: binding except where this handoff adds to it. It already holds the
   decisions on no live demos, "General statement first", two lecture folders and Practice
   slides.
3. `Chapter_3/Lecture/lecture.qmd`: **the reference for format and amount of text**, in the
   state that the author left it. Compare it with the plan in
   `Chapter_3/Lecture/lecture-handoff.md`, slides 16, 20, 21, 23 and 31, to see what the author
   changes (see the next section). The Chapter 3 script is a model of format only, and it
   applies to Phase 2.
4. `Chapter_3/Lecture/lecture-assets/figures.R`: the model for `figures.R`.
   `Chapter_2/Lecture/lecture-assets/density-area.svg`: the model for a hand-written schematic.
5. `Chapter_1/Theory.qmd`, section "Chapter 4: Maximum likelihood estimation".
6. `Chapter_4/Theory.qmd` in full. The lectures follow it in order and take all examples,
   numbers, seeds and wording of definitions from it.
7. `Chapter_4/Practicals/no_solution.qmd` (for the practical slides).

## The rule that matters most: general statement first

The author has repeatedly had to rewrite generated slides that showed only an example. This is
the main thing to get right. The rule is in `STYLE_GUIDE_LECTURE.md` ("General statement
first"). What the author's rewrites of the Chapter 3 plan look like:

| Slide of Chapter 3 | What the plan asked for | What the author wrote |
|---|---|---|
| The method of moments | Starts with the equation $\hat\lambda = \overline X$ | General bullets (one parameter: mean of the model = mean of the sample; two parameters; three or more). The equation moved into the `.example` box |
| A simulated sampling distribution | Mean close to 2.14, standard deviation 0.205, values are not integers | What such a distribution gives us: properties of an estimator, uncertainty, plug-in estimates, and that we do not always know its formula |
| Bias and variance | The mean of i.i.d. counts is unbiased, $\lambda/n$ | Which kinds of estimator are unbiased, that most are biased in finite samples, that the bias and the variance shrink with larger samples. Numbers only in `.example` |
| Standard errors | Starts with $\sqrt{\hat\lambda/n}$ | "The standard deviation of the sampling distribution of an estimator", "Use $\hat\theta$ instead of $\theta$". The formula and 0.21 come after that |
| Consistency | Same as for relative frequencies; four times the sample halves the standard error | General behaviour of bias and variance as the sample grows |

Every content slide below is therefore specified in this form:

- **General:** what stands on the slide in general terms and symbols. This part is required.
- **Example:** what goes in the `.example` box, the caption or the code comments. It comes last.
- **Script:** notes for Phase 2.

Where this plan gives a chapter's formula for one model (the chapter's own equation for slices
uses $k$ and $p$, for instance), write the general form on the slide and keep the specific form
for the example. When you adapt the chapter's wording to a slide, keep it general. Do not let an
example number slip into a bullet.

## Author's decisions

**Structure**

- Two lectures, one per part of the chapter. **Lecture 1:** the likelihood, estimation, several
  parameters (up to the end of "Slices and profiles"). **Lecture 2:** uncertainty, properties,
  model comparison (from "Uncertainty from the likelihood").
- **Each is a session of 150 minutes:** two breaks of 10 and three blocks. Lecture 1 has 32
  slides (125 minutes, 5 of slack); Lecture 2 has 30 slides (118 minutes, 12 of slack) since
  its standard errors were condensed on 3 November (author's decision: keep 150 minutes and
  add slack). Each lecture has one live demo.
- **One live demo per lecture** (author's decision of 3 November, replacing "no live
  demos"): 18 minutes (2 at the slide, 16 in R) from a standalone script in the lecture
  folder. Lecture 1, slide 30, `demo-profile.R`: the owl model with $k$ and $p$ (author's
  decision of 3 November, because there the slice and the profile differ), in five sections
  that match the slide: the fit, the surface, the slice of $k$, its profile with
  `TMB::tmbprofile()`, and both panels of the chapter's slice and profile figure in base R,
  with the ranges of $k$ within 1.92 units. No profile is calculated by hand (as in the
  chapter). It runs in about 5 seconds.
  Lecture 2, slide 25, `demo-properties.R`: one hypothetical sample with `obj$simulate()`,
  the chapter's simulation (seed 601, 2,000 samples of 20, 122 and 500 visits, about 75
  seconds), then consistency, histograms, the standard error, efficiency and bias. Both run
  in a clean session and reproduce the chapter's numbers (checked in R 4.6.1 on 3 November).
- **Folders:** `Chapter_4/Lecture_1/` and `Chapter_4/Lecture_2/`, each with `lecture.qmd`,
  `lecture-script.md`, `lecture-script.pdf`, `lecture.scss` (unchanged copy of the Chapter 3
  file) and `lecture-assets/` (with its own `figures.R`).
- **Practical:** a short practical session falls between the two lectures. Lecture 1 assigns
  Exercise 1, questions 1 to 3 (without the standard errors of question 3), and Exercise 2,
  questions 1 to 3 (without the joint region of question 3). Lecture 2 presents the rest. The
  practical page does not change.

**Content**

- **Code:** about five code slides per lecture, listed below. The chapter calculates no
  profile by hand (no `uniroot()`, no loop with `map`): the slides explain the idea of inner
  fits, and `tmbprofile()` does them. `checkConsistency()` is not used
  (removed from the chapter and from Lecture 2, slide 26, on 3 November).
- **Mathematics:** the equations of the chapter's main text only. Wilks' theorem, the Cramér–Rao
  bound and the Kullback–Leibler divergence are named and stated in words, with no equation; the
  derivation of the Poisson estimator stays in the chapter's box. The script points to the
  "Statistical detail" boxes.
- **Misspecified models:** one slide, general only (author's decision of 3 November): no owl
  example on the slide or in the script (no implied variance, gap in $k$ or count of nests).
- **`Practice` callouts:** all four are timed Practice slides (`STYLE_GUIDE_LECTURE.md`). In the
  order of the page: Practice 1 (crab burrows), 2 (back to the ecological scale), 3 (an interval
  from the log scale), 4 (waiting for a pollinator).
- **AIC as a test:** the author's paragraph in the chapter (a two-unit rule is null hypothesis
  testing in disguise) has its own short slide, "Using AIC". The script keeps the wording of the
  chapter and adds no opinion.
- **Covariance:** a bullet and an example on the Hessian slide, with no slide of its own.
- **Magnusson's interactive page:** an optional minute within Lecture 1, slide 26 (the
  likelihood surface), in the script only. It is not named on the slide; the static figure is the fallback.

**Choices I made within those decisions (the author may overrule them in review)**

- Neither lecture has a roadmap slide (Lecture 2's was cut on 3 November to make room for the
  demo); the last slides point forward in speech.
- Lecture 2 opens with a recap (steps 1 to 5 of the recipe) and closes with the full recipe.
- One discussion slide per lecture since 3 November (probability or likelihood; Wald or
  profile): the demos replace "slice or profile?" and "which property?", whose questions the
  script may ask during the demo.
- The "Three intervals" figure was approved by the author; it is made in two stages from one
  block of code (`wald-parabolas.png`, `three-intervals.png`), so that slide 11 of Lecture 2
  does not show the profile interval before slide 14 defines it.
- **Cuts of 3 November for the demos** (the slides now hold the result; numbers are the old
  ones of the tables below). Lecture 1: slide 8 (the value of a likelihood) became a bullet on
  slide 7, slide 13 (continuous data) a bullet on slide 11, slide 16 (closed-form solutions) a
  bullet and the example on slide 15, and slide 33 (discussion) was replaced by the demo.
  Lecture 2: slide 17 (intervals and sample size) became a bullet on slide 15, slides 23 and
  24 merged into "Consistency and asymptotic normality" (the figure
  `sampling-distribution-k.png` is no longer on a slide; the demo draws the histograms), slide
  28 (discussion) was replaced by the demo, slide 30 (AICc) became a bullet on slide 29, and
  slide 34 (roadmap) was cut. Several slides lost a minute. The script carries the numbers
  that left the slides (the 50-quadrat likelihoods, $n\log(1000)$, the table of intervals for
  10 and 50 quadrats).

## Rules for wording and notation

- **Parentheses around the argument of a logarithm**, as in `STYLE_GUIDE.md`: $\log(\lambda)$,
  $\log(k)$. Chapter 4 still writes $\log\lambda$ in places; do not copy that. Write
  $\operatorname{logit}(p)$ in the same way.
- **Hypothetical samples**, never "experiments". "Model probability", "the parameter used to
  simulate". Chapter 3's slides use "true" in quotation marks; these lectures follow the
  chapter's wording instead.
- **"Maximum likelihood estimate" and MLE:** expand at first use. Write "likelihood profile
  interval" on slides; "likelihood interval" only where the chapter contrasts it for the
  one-parameter case.
- **Terms:** Fisher information, observed information, Hessian, Wald interval, quadratic
  approximation, relative log-likelihood, inner fits, parameterisation,
  invariance. $K$ for the number of parameters in AIC, because $k$ is the shape.
- **Units:** "seedlings per quadrat" and "calls per visit" (a sampling unit keeps "per").
- **Slide 4 of Lecture 1 and the summaries** say what the concepts are for in this book.
- **The first person:** the chapter's "I fitted the same model" (section "Parameterisation")
  becomes neutral. Add no anecdote or opinion for the author.
- **Hidden code:** the $k,p$ fit, the slice and profile curves and the coverage simulation are
  hidden in the chapter, so they are not on the slides and not in the script's code to run.
  The $k,p$ fit, its surface, the slice and the profile of $k$ (with `tmbprofile()`) are
  shown in `demo-profile.R` on the author's request.

## Lecture 1: slide sequence and timing

Title slide: subtitle "Chapter 4 · Lecture 1", eyebrow "Maximum Likelihood Estimation: the
Method". `pagetitle`: "Chapter 4, Lecture 1 — Ecological Models and Data Analysis". Footer:
"Ecological Models and Data Analysis · Chapter 4 · Lecture 1".

Current sequence (3 November). The specifications below keep the numbers of the Phase 1 plan;
"Cuts of 3 November" under "Author's decisions" says where the content of the removed slides
went.

| Slide | Title | Min | Elapsed |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis (title) | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | From the method of moments to maximum likelihood | 2 | 4–6 |
| 5 | The likelihood function | 4 | 6–10 |
| 6 | Probability and likelihood | 3 | 10–13 |
| 7 | A likelihood by hand | 4 | 13–17 |
| 8 | A likelihood is not the probability of a parameter value | 4 | 17–21 |
| 9 | Discussion: probability or likelihood? | 3 | 21–24 |
| 10 | The log-likelihood | 4 | 24–28 |
| 11 | Log-likelihoods in R | 3 | 28–31 |
| 12 | Practice 1: crab burrows | 5 | 31–36 |
| | Break | 10 | 36–46 |
| 13 | The maximum likelihood estimator | 5 | 46–51 |
| 14 | The likelihood curve | 4 | 51–55 |
| 15 | Numerical optimisation | 3 | 55–58 |
| 16 | The negative log-likelihood in R | 4 | 58–62 |
| 17 | From the negative log-likelihood to a fit | 3 | 62–65 |
| 18 | A fit in R | 5 | 65–70 |
| 19 | The result of `optim()` | 3 | 70–73 |
| 20 | Constraints and transformations | 4 | 73–77 |
| 21 | Invariance | 4 | 77–81 |
| 22 | Practice 2: back to the ecological scale | 3 | 81–84 |
| 23 | Models with several parameters | 4 | 84–88 |
| 24 | A fit with two parameters in R | 5 | 88–93 |
| | Break | 10 | 93–103 |
| 25 | Checking the fitted model | 3 | 103–106 |
| 26 | The likelihood surface | 4 | 106–110 |
| 27 | Parameterisation | 4 | 110–114 |
| 28 | Slices and profiles | 3 | 114–117 |
| 29 | Slice against profile | 4 | 117–121 |
| 30 | Live demo: a likelihood profile in R | 2 + 16 | 121–139 |
| 31 | The Chapter 4 R practical: first part | 2 | 139–141 |
| 32 | Summary and closing questions | 4 | 141–145 |
| | Slack for discussion | 5 | 145–150 |
| | **Total** | **150** | |

Check: slides 125 (blocks of 36, 47 and 42, the demo included) + slack 5 + breaks 20 = 150.
The minutes of each slide equal its `data-timing` in seconds.

### Block 1: the likelihood

1. **Title** (`.lecture-title`).
2. **Overview of the lecture:** numbered, bold keyword + question: the likelihood (how probable
   are the data for a given parameter value?); the log-likelihood (why do we work with
   logarithms?); maximum likelihood estimation (which value is best supported?); the fit in R
   (how do we find it numerically?); transformations (how do we keep a parameter within its
   range?); several parameters (what does the likelihood say about one of them?); the practical
   (what do we try next?).
   - Script: two lectures for one chapter; this one builds the method and the next asks what we
     can say once a model is fitted. Three blocks, two breaks.
3. **Where we are: the modelling cycle** (`.diagram-slide`): `ModelCycle.png`, referenced
   unchanged as `../../Chapter_1/Lecture/ModelCycle.png`, with `.cycle-diagram`. Caption: this
   lecture: likelihood (4) and optimise (4) in the estimation box.
4. **From the method of moments to maximum likelihood** (two columns, each a fragment):
   - General: *Method of moments:* uses the mean and the variance of a sample. *Maximum
     likelihood:* uses the probability of every observation; works for any model with a mass or
     density function. Takeaway: same concepts (estimator, sampling distribution, standard
     error, confidence interval), a different estimator; the method of the rest of the course.
   - Example: two running examples: fir seedlings in 50 quadrats (Poisson); barn owl calls at
     122 visits (Negative Binomial).
   - Script: the chapter's introduction.
5. **The likelihood function** [The likelihood function]:
   - General: `.definition` likelihood: the joint probability of the observed sample, read as a
     function of the parameters with the data held fixed. Equation $L(\theta\mid x_1,\ldots,x_n)
     = P(X_1=x_1,\ldots,X_n=x_n\mid\theta) = \prod_{i=1}^{n}P(X_i=x_i\mid\theta)$. Bullets: the
     bar reads "for a given value of"; independence gives the product; continuous data use
     densities.
   - Example: fir seedlings, $X_i \sim \operatorname{Poisson}(\lambda)$.
   - Script: Chapter 2 announced that i.i.d. would be fundamental for estimation. History
     (Fisher 1912, 1921, 1922; Aldrich 1997; Stigler 2007) as an optional remark.
6. **Probability and likelihood** (two columns, each a fragment):
   - General: *Probability:* parameters fixed, data vary (Chapter 2). *Likelihood:* data fixed,
     parameters vary. Takeaway: a parameter value under which the sample is more probable is
     better supported by the data.
   - Example: the Poisson mass $e^{-\lambda}\lambda^{x}/x!$: as a function of $x$, and as a
     function of $\lambda$.
7. **A likelihood by hand:**
   - General: each observation contributes its probability; the contributions are multiplied; we
     compare parameter values through their likelihoods.
   - Example: first three quadrats (0, 1, 2): $L(\lambda\mid 0,1,2)=e^{-3\lambda}\lambda^{3}/2$;
     0.0249 at $\lambda=1$; 0.0099 at $\lambda=2$; about 2.5 times more probable under a mean of
     1.
   - Script: their own mean is 1. Say that 50 counts reverse the order (next slide).
8. **The value of a likelihood:**
   - General: every observation multiplies the likelihood by a probability below one; so its
     value depends on the number of observations and means nothing by itself; only comparisons
     between parameter values, for the same data, are used.
   - Example: all 50 quadrats: $4.2\times10^{-50}$ at $\lambda=1$, $1.3\times10^{-39}$ at
     $\lambda=2$, about $3\times10^{10}$ times more probable.
9. **A likelihood is not the probability of a parameter value** [warning callout]:
   - General: the parameter is fixed in the model, and probabilities describe data and estimates
     across hypothetical samples; a likelihood need not add up or integrate to one over
     parameter values. Takeaway: use it to compare parameter values.
   - Example: 50 quadrats: area under the likelihood about $8.7\times10^{-40}$.
   - Script: the footnote on Bayesian inference, one sentence, pointer to Chapter 1.
10. **Discussion: probability or likelihood?** (timed, takeaway and activity visible, as on the
    Chapter 3 discussion slides): numbered, for example: how probable are three seedlings in a
    quadrat at $\lambda=2$?; how well do the counts 0, 1 and 2 support $\lambda=1$ against
    $\lambda=2$?; a quantity that sums to one over all possible counts; a curve whose area is
    $8.7\times10^{-40}$. Takeaway "Probability · Likelihood". Activity "**1 minute:** decide
    with a neighbour."
    - Script: expected answers: probability; likelihood; probability; likelihood.
11. **The log-likelihood** [The log-likelihood]:
    - General: equation $\ell(\theta) = \log(L(\theta)) =
      \sum_{i=1}^{n}\log(P(X_i=x_i\mid\theta))$. Bullets: the product becomes a sum; the
      logarithm is increasing, so the maximum is at the same value; products of many
      probabilities fall below what the computer can represent.
    - Example: 1,000 simulated counts with $\lambda=4$ (seed 501): `prod()` returns 0; the sum
      of log probabilities is an ordinary number (quote it from R).
12. **Log-likelihoods in R** (code):
    - General: bullets: every `d*` function has `log = TRUE`; it is more accurate than taking
      the logarithm afterwards; the log-likelihood is the sum of these values.
    - Example: chunk from "The log-likelihood" (`sum(dpois(x = seedling_counts, lambda = 2, log
      = TRUE))`, against `log(prod(...))`), with the value in a comment.
13. **Continuous data:**
    - General: the contributions are densities; a density has units and can exceed one; so a
      log-likelihood can be positive and its value changes with the units; differences between
      parameter values, or models, do not change.
    - Example: body masses from grams to kilograms: every density is multiplied by 1,000 and the
      log-likelihood increases by $n\log(1000)$.
    - Script: the practical checks this with body mass (Exercise 4).
14. **Practice 1: crab burrows** (Practice slide; `.activity`, "**3 minutes:** on paper"): three
    plots with 3, 1 and 2 burrows, i.i.d. Poisson; write the likelihood; calculate the
    likelihood and the log-likelihood at $\lambda=2$ and $\lambda=3$; which value is better
    supported?
    - Script: the chapter's solution ($e^{-3\lambda}\lambda^{6}/12$; 0.0132 and $-4.33$; 0.0075
      and $-4.89$; about 1.8 times). The break follows.

### Block 2: estimation

15. **The maximum likelihood estimator:**
    - General: `.definition`: the value of the parameter for which the likelihood of the
      observed sample is highest. Equation $\hat\theta = \arg\max_\theta L(\theta\mid
      x_1,\ldots,x_n) = \arg\max_\theta \ell(\theta\mid x_1,\ldots,x_n)$. Bullets: $\arg\max$
      gives the location of the maximum, $\max$ its height; MLE stands for both the estimator
      and the estimate.
    - Example: none needed; the next slide has it.
16. **Closed-form solutions:**
    - General: at the maximum the slope of the log-likelihood is zero; differentiate, set to
      zero, solve; this gives a formula for only a few models; otherwise the setting-to-zero
      equations cannot be solved with algebra, so we search numerically.
    - Example: Poisson: $\hat\lambda=\overline x$, 2.14 seedlings per quadrat, also the
      method-of-moments estimate.
    - Script: the derivation is in the chapter's box (calculus refresher); the Normal model as a
      second case; the score only if asked.
17. **The likelihood curve** (`.figure-slide`, `likelihood-curve.png`):
    - General: the relative log-likelihood $\ell(\theta)-\ell(\hat\theta)$ is zero at the
      estimate and negative elsewhere; all likelihood figures use this scale, because only
      differences have meaning; how fast the curve falls shows how well the data discriminate;
      it need not be symmetric.
    - Example: first ten quadrats (22 seedlings): $\hat\lambda=2.2$; $-3.33$ at 1.2 and $-1.76$
      at 3.2, both one seedling away from the estimate. Caption: vermillion, relative
      log-likelihood; dashed, the estimate.
    - Script: ten quadrats because the shape is easier to see in a small sample; Lecture 2
      compares 10 and 50. The grid with a `for` loop is on the chapter page.
18. **Numerical optimisation** (`optimiser-search.svg` in a 56–60% column):
    - General: `.definition` optimiser: searches for the values at which a function reaches its
      minimum. Bullets: starts from values that we provide; moves step by step to lower values;
      stops when it cannot improve; `optim()` minimises, so we give it the **negative
      log-likelihood** (NLL), $-\ell(\theta)$.
19. **The negative log-likelihood in R** (code):
    - General: bullets for the items: a function of two named lists, `parms` and `data`;
      `getAll()` makes their elements available by name; returns minus the sum of the log
      probabilities.
    - Example: chunk `poisson_nll_lambda`. Note under the chunk: this is the form of every NLL
      in the course.
20. **From the negative log-likelihood to a fit** (`fit-pipeline.svg`, full width or a 60%
    column):
    - General: bullets, each with the name in code format: `cmb()` connects a likelihood to a
      data set, so it can be used again on other data with the same names; `MakeADFun()`
      processes the NLL for the tools of the course and takes the starting values; it returns
      `par`, `fn` and `gr` (starting values, NLL, gradients); `optim()` minimises `fn` from
      `par`, using `gr`.
    - Script: use the wording of `STYLE_GUIDE.md` ("Maximum likelihood with RTMB"):
      `MakeADFun()` "processes" the NLL, details come progressively, `gr` is the slope that RTMB
      supplies, Chapter 6 says how and Chapter 8 explains BFGS. No tapes, automatic
      differentiation or lexical scoping, and no apology for `cmb()`.
21. **A fit in R** (code):
    - General: one line: the same three steps for every model.
    - Example: chunks `cmb`, `fir_lambda_obj` and `fir_lambda_fit` with comments that label the
      steps.
22. **The result of `optim()`**:
    - General: bullets: `par`, the estimates; `value`, the NLL at the estimates; `convergence`,
      zero when the search stopped normally: the first thing to check; a code other than zero
      means that `par` holds no estimates.
    - Example: three lines of code with results in comments (2.14 seedlings per quadrat).
    - Script: the note callout "When a fit fails": `NaN` during the search is harmless when the
      fit converges; error "initial value in 'vmmin' is not finite"; what to try; Chapter 8.
23. **Constraints and transformations** [Constraints and transformations]:
    - General: `.definition` constraint. Bullets: an optimiser can try any real number;
      `dpois()` then returns `NaN`; the optimiser searches over a transformed parameter that can
      be any real number, and the NLL converts it; positive parameter: logarithm, `exp()` back;
      probability: logit, `qlogis()` and `plogis()`.
    - Example: chunk with `lambda = exp(log_lambda)` in the NLL and `exp(fir_fit$par)` with
      result in a comment: 2.14 again.
    - Script: the same NLL connected to the first ten quadrats (2.2 seedlings per quadrat),
      which shows why `cmb()` exists; both objects return in Lecture 2.
24. **Invariance:**
    - General: equation $\widehat{g(\theta)} = g(\hat\theta)$. Bullets: a transformation only
      relabels the axis of the likelihood curve, so the highest point is the same on both
      scales; the MLE of any quantity calculated from the parameter follows. Takeaway:
      invariance carries over the estimate and not unbiasedness.
    - Example: probability of an empty quadrat $e^{-\hat\lambda}\approx 0.12$ (7 of the 50
      quadrats in the sample); Chapter 3 showed that this estimator is biased.
    - Script: Zehna (1966) as an optional citation.
25. **Practice 2: back to the ecological scale** (Practice slide; "**2 minutes:** R as a
    calculator"): `par = 0.92` for the logarithm of the mean ticks per lizard, `par = -0.85` for
    the logit of a germination probability; report both on the ecological scale; are they the
    maximum likelihood estimates?
    - Script: solution: 2.5 ticks per lizard and 0.30, by invariance. The break follows.

### Block 3: several parameters

26. **Models with several parameters** [Models with several parameters]:
    - General: the likelihood is a function of all parameters jointly; the MLE is the
      combination with the highest likelihood; the curve becomes a surface; new questions: how
      to look at it, how the estimates depend on each other, what the data say about one
      parameter.
    - Example: `Owls`: 122 visits, mean 4.75 calls per visit, variance 42.3; $X_i \sim
      \operatorname{NegBin}(\mu,k)$, $\operatorname{Var}(X_i)=\mu+\mu^2/k$.
    - Script: Roulin and Bersier (2007), the data of the Chapter 3 practical, once; females and
      satiated nestlings; i.i.d. is a simplification (visits to the same nest; Chapter 7).
27. **A fit with two parameters in R** (code):
    - General: bullets: one list element per parameter; every constrained parameter transformed;
      starting values from the method of moments.
    - Example: chunks `nb_nll` (the first version), `owl_obj`, `owl_fit`, and `exp()` with
      comments: $\hat\mu\approx4.75$ calls per visit, $\hat k\approx0.33$, against 0.60 by the
      method of moments. A comment says `dnbinom2()` of RTMBdist takes `mu` and `size`.
    - Script: the warning callout on the two `dnbinom2()` (load order); the MLE of the mean is
      the sample mean whatever $k$; the gap in $k$ returns in Lecture 2.
28. **Checking the fitted model** (`.figure-slide`, `owl-fits.png`):
    - General: `optim()` returns estimates for any model, so we compare the fit with the data;
      for counts: relative frequencies against fitted probabilities; a simpler model as a
      reference.
    - Example: zero calls: 44% of visits, 0.41 Negative Binomial, 0.009 Poisson; log-likelihood
      about 335 units higher. Caption: bars, the sample; lines and points, the fitted models.
29. **The likelihood surface** (`.figure-slide`, `likelihood-surface.png`):
    - General: contours join combinations with the same relative log-likelihood; the MLE is the
      top of the hill; contours that are not tilted mean that estimates hardly depend on each
      other.
    - Example: $\mu$ and $k$: the best $\mu$ is the sample mean for every $k$. Caption: the
      circle is the MLE.
    - Script: the surface comes from two nested `for` loops over `obj$fn()`, on the optimised
      scale, and `contour()` from the Chapter 1 practical. If the connection allows, open
      Kristoffer Magnusson's page (<https://rpsychologist.com/likelihood/>) for about a minute,
      within the four minutes; it uses a Normal model; the figure is the fallback.
30. **Parameterisation** (`.figure-slide`, `surface-size-prob.png`):
    - General: `.definition` parameterisation: the same model written with different parameters.
      Bullets: same maximum and same fitted model; different shape of the surface; tilted
      contours mean estimates that depend on each other; the course uses the mean where
      possible.
    - Example: shape $k$ and probability $p=k/(k+\mu)$: maximum log-likelihood $-299.44$ in
      both, $\hat p\approx0.064$; a larger $k$ goes with a larger $p$, which keeps the mean near
      4.75.
    - Script: neutral wording for the chapter's "I fitted"; the choice also matters for
      optimisation (Chapter 8).
31. **Slices and profiles:**
    - General: `.definition` slice: fix the other parameters, normally at their estimates.
      `.definition` profile: re-estimate them for every value of the parameter of interest.
      Equation $\ell_{\mathrm{prof}}(\theta_1)=\max_{\theta_2}\ell(\theta_1,\theta_2)$. No term
      is introduced for the parameters that are re-estimated.
    - Example: `.example`: $\ell(k,\hat p)$ is a slice; $\max_p\ell(k,p)$ is the profile of $k$.
32. **Slice against profile** (`.figure-slide`, full width, `slice-profile.png`):
    - General, below the figure: both pass through the MLE; the profile is never below the
      slice; a slice treats the other parameters as known, so it is narrower; the profile does
      not depend on how the other parameter is written.
    - Example: range of $k$ within 1.92 units: slice 0.26 to 0.41, profile 0.24 to 0.45.
      Caption: left, contours with the slice (dashed) and the ridge (solid); right, the two
      curves.
    - Script: 1.92 is justified in Lecture 2; with $\mu$ as second parameter the two curves
      coincide; slices are a quick inspection and return in Chapter 8.
33. **Discussion: slice or profile?** (timed): for example: $k$ varies with $p$ fixed at its
    estimate; $k$ varies with $p$ re-estimated at each value; what the data would say about $k$
    if we knew $p$ exactly; a curve that takes into account that $p$ is estimated from the same
    data. Takeaway "Slice · Profile". Activity "**1 minute:** decide with a neighbour."
    - Script: answers: slice, profile, slice, profile. If time allows, chapter's quiz question
      6.
34. **The Chapter 4 R practical: first part:** incremental: **Reed frog tadpoles** (Exercise 1,
    questions 1 to 3: likelihood by hand, estimator, fit; worked on the page); **Glacier lily
    seedlings** (Exercise 2, questions 1 to 3: method of moments, fit, contours). Takeaway:
    leave standard errors and the joint region for after Lecture 2; try, then check.
    - Script: which parts of those questions need Lecture 2.
35. **Summary and closing questions** (`.closing`): incremental take-home points: the likelihood
    is the probability of the sample read as a function of the parameters; the log-likelihood is
    a sum, and only differences have meaning; the MLE is the value with the highest likelihood,
    found with `optim()`; transformations keep parameters in range, and invariance carries the
    estimate back; with several parameters, a surface whose shape depends on the
    parameterisation; slices fix and profiles re-estimate. Takeaway string: "Likelihood ·
    Log-likelihood · MLE · NLL · Transformation · Invariance · Surface · Profile". Activity with
    two closing questions, for example: "Why is a likelihood not the probability of a parameter
    value?" and "Why is a slice narrower than a profile?"
    - Script: final transition to the short practical and to Lecture 2 (how uncertain are these
      estimates?). Expected answers.

## Lecture 2: slide sequence and timing

Title slide: subtitle "Chapter 4 · Lecture 2", eyebrow "Maximum Likelihood Estimation:
Uncertainty, Properties and Model Comparison". `pagetitle` and footer as in Lecture 1 with
"Lecture 2".

Current sequence (3 November, after the chapter's "Standard errors and Wald intervals" was
condensed); the specifications of Block 1 below use these numbers; Blocks 2 and 3 keep the
numbers of the Phase 1 plan.

| Slide | Title | Min | Elapsed |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis (title) | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | Recap: the steps of a fit | 2 | 4–6 |
| 5 | Uncertainty from the likelihood | 3 | 6–9 |
| 6 | Asymptotic normality of the MLE | 4 | 9–13 |
| 7 | Curvature and standard errors | 4 | 13–17 |
| 8 | `sdreport()`: standard errors and correlations | 4 | 17–21 |
| 9 | Back-transforming a standard error | 5 | 21–26 |
| 10 | A Wald interval depends on the scale | 4 | 26–30 |
| 11 | Practice 3: an interval from the log scale | 4 | 30–34 |
| | Break | 10 | 34–44 |
| 12 | Likelihood profile intervals | 4 | 44–48 |
| 13 | Reading a likelihood profile interval | 5 | 48–53 |
| 14 | `tmbprofile()` and `confint()` | 2 | 53–55 |
| 15 | Profile intervals with several parameters | 4 | 55–59 |
| 16 | Joint confidence regions | 4 | 59–63 |
| 17 | Simulating from a fitted model | 3 | 63–66 |
| 18 | Coverage of Wald and profile intervals | 4 | 66–70 |
| 19 | Discussion: Wald or profile? | 3 | 70–73 |
| 20 | Consistency and asymptotic normality | 5 | 73–78 |
| 21 | Efficiency | 4 | 78–82 |
| 22 | Bias in finite samples | 4 | 82–86 |
| | Break | 10 | 86–96 |
| 23 | Live demo: properties by simulation | 2 + 16 | 96–114 |
| 24 | Misspecified models | 4 | 114–118 |
| 25 | The Akaike information criterion | 6 | 118–124 |
| 26 | Using AIC | 3 | 124–127 |
| 27 | Practice 4: waiting for a pollinator | 4 | 127–131 |
| 28 | A recipe for a fit | 2 | 131–133 |
| 29 | The Chapter 4 R practical | 2 | 133–135 |
| 30 | Summary and closing questions | 3 | 135–138 |
| | Slack for discussion | 12 | 138–150 |
| | **Total** | **150** | |

Check: slides 118 (blocks of 34, 42 and 42, the demo included) + slack 12 + breaks 20 = 150.
The break before the demo lets the lecturer open R and run section 0 of the script. The slack
grew from 5 to 12 minutes when slides 6 to 12 of the Phase 1 plan were condensed into five
(author's decision of 3 November: keep 150 minutes and add slack).

### Block 1: standard errors and Wald intervals

1. **Title** (`.lecture-title`).
2. **Overview of the lecture:** standard errors (how precise is an estimate?); Wald intervals
   (what do we get from the curvature?); likelihood profile intervals (which values do the data
   support?); coverage (do the intervals do what they promise?); properties (why does the method
   work, and when does it fail?); model comparison (which model do the data support?); the
   practical (what comes next?).
3. **Where we are: the modelling cycle** (`.diagram-slide`): caption: this lecture: confidence
   intervals (3 and 4) in the estimation box, information criteria (4) in the comparison box.
4. **Recap: the steps of a fit:**
   - General: incremental numbered list, steps 1 to 5 of the recipe in keywords: write the
     model; write the NLL; connect and process it (`cmb()`, `MakeADFun()`); minimise it
     (`optim()`, `convergence`); transform back and compare with the data. Takeaway: today: how
     uncertain, why it works, which model.
   - Example: fir (50 quadrats): $\hat\lambda=2.14$; owls: $\hat\mu\approx4.75$, $\hat
     k\approx0.33$.
5. **Uncertainty from the likelihood** (two columns, each a fragment):
   - General: *Wald interval:* the curvature of the log-likelihood at its maximum; asymptotic
     normality; fast; what software usually reports. *Likelihood profile interval:* the whole
     shape around the maximum; the reference method; many fits. Takeaway: both work for any
     model fitted with `optim()`, without a formula for the variance.
6. **Asymptotic normality of the MLE** [Standard errors and Wald intervals]:
   - General: equation $\hat\theta \overset{\mathrm{approx}}{\sim}
     \operatorname{Normal}(\theta,\operatorname{SE}(\hat\theta)^2)$ for sufficiently large $n$.
     Bullets: several parameters: a multivariate Normal (Chapter 2) with a covariance matrix;
     Wald interval $\hat\theta\pm1.96\,\widehat{\operatorname{SE}}(\hat\theta)$, as in Chapter 3;
     regularity conditions in keywords.
   - Example: Poisson mean: $\operatorname{Normal}(\lambda,\lambda/n)$, the result of Chapter 3.
   - Script: Chapter 3 ended by announcing this; history (Fisher 1922, 1925; Wald 1943; Cramér
     1946) as an optional remark. The simulation of the demo examines the claim.
7. **Curvature and standard errors** (`.figure-slide`, `curvature-information.png`; the parabola
   equation above the columns) [Curvature and standard errors]:
   - General: bullets: in a large sample the log-likelihood near its maximum is close to a
     parabola; falls slowly: low curvature, many values supported, large standard error; one
     parameter: standard error $=1/\sqrt{\text{curvature}}$; several: the curvatures give the
     covariance matrix.
   - Example: standard error of $\hat\lambda$: ten quadrats 0.47; 50 quadrats 0.207 seedlings
     per quadrat. Caption explains the two curves.
   - Script: the two approximations (Normal sampling distribution, parabola) go together; the
     Wald interval replaces the log-likelihood by the parabola. Fisher information, observed
     information and the Hessian are only in the chapter's statistical detail boxes: mention
     them by name at most, with the Poisson case $n/\hat\lambda$ as an optional remark.
8. **`sdreport()`: standard errors and correlations** (code) [Standard errors with TMB]:
   - General: bullets: `sdreport(obj)` after the fit, the curvature at the estimates;
     `summary()`, a row per parameter with `Estimate` and `Std. Error`, on the optimised scale;
     `cov.fixed`, the covariance matrix, and `cov2cor()`, the correlations; tilted contours,
     correlated estimates.
   - Example: owl chunk (`sdreport()`, `summary()`, `cov2cor()`) with values in comments;
     correlations: $\log(\mu)$ and $\log(k)$ about 0; $\log(k)$ and
     $\operatorname{logit}(p)$ 0.71, the tilt of the surface in Lecture 1.
9. **Back-transforming a standard error** [Standard errors on the original scale]:
   - General: `sdreport()` gives the standard error on the scale that was optimised. Two
     columns: *A non-linear function and an average:* $E[g(X)]\neq g(E[X])$; a variance is an
     average and a standard error its square root, so applying $g$ gives no standard error;
     estimates and endpoints are values and transform. *The delta method:* treats $g$ as a
     straight line near the estimate, an approximation (Chapter 6); `ADREPORT(k)` in the NLL adds
     a row to `sdreport()`. Takeaway: transform estimates and endpoints; for a standard error on
     the new scale, use `ADREPORT()`.
   - Example: ten quadrats: 0.213 on the log scale; `exp(0.213)` gives 1.24, but the standard
     error of $\hat\lambda$ is 0.47; owls: $\hat k=0.327$, standard error 0.054.
   - Script: the author's wording (3 November): `exp()` of a standard error is not a biased
     standard error, it is no standard error at all; the delta method approximates the standard
     error on the new scale and does not remove a bias. The difference in units is not the
     reason. Jensen's inequality, the worked case (values 0 and 2) and the delta method formula
     with the log and logit cases are in the chapter's boxes. The object must be fitted again
     after `ADREPORT()` is added to the NLL.
10. **A Wald interval depends on the scale** (`.figure-slide`, `wald-parabolas.png`)
    [Wald intervals on the original and log scales]:
    - General: bullets: a Wald interval replaces the log-likelihood by a parabola; an
      unconstrained parameter is closer to Normal, so calculate it on the optimised scale; an
      increasing transformation of the endpoints keeps the coverage; a positive parameter stays
      positive and asymmetry is captured.
    - Example: ten quadrats: 1.28 to 3.12 on the original scale; 1.45 to 3.34 from the log
      scale; owls, $k$: 0.221 to 0.434 on the original scale, 0.237 to 0.453 from the log scale.
      Caption explains the lines.
    - Script: why the coverage is kept: the transformation is increasing, so the interval
      contains the parameter in the same hypothetical samples.
11. **Practice 3: an interval from the log scale** (Practice slide; "**2 minutes:** R as a
    calculator"): `par = 0.92` for the logarithm of the mean ticks per lizard, standard error
    0.141; calculate a 95% Wald interval for the mean; why is it not symmetric around the
    estimate?
    - Script: solution: 1.9 to 3.3 around 2.5. The break follows.

### Block 2: likelihood profile intervals and coverage

14. **Likelihood profile intervals:**
    - General: `.definition` from the note callout: all the values whose relative profile
      log-likelihood is within 1.92 units of the maximum; the other parameters are re-estimated
      for each value. Bullets: 1.92 is half the 0.95 quantile of a chi-squared distribution with
      one degree of freedom (3.84, the square of 1.96); from Wilks' theorem, in words: twice the
      drop at the generating value behaves like the square of a standard Normal variable, so
      about 95% of hypothetical samples fall within the cutoff.
    - Example: `qchisq(p = 0.95, df = 1) / 2` in one line of code.
    - Script: the box on Wilks' theorem; no likelihood ratio test (footnote).
15. **Reading a likelihood profile interval** (`.figure-slide`, new `three-intervals.png`):
    - General: bullets: the interval follows the shape of the curve, so it need not be
      symmetric; it does not depend on the scale; idea of **inner fits**: move the parameter,
      re-estimate the others, record the NLL, find the two crossings of the cutoff.
    - Example: ten quadrats: profile 1.40 to 3.25, with 0.80 below and 1.05 above the estimate.
      Caption gives all three intervals.
    - Script: by hand in the chapter (`uniroot()`; the grid of inner fits with `map`); in
      practice TMB does it.
16. **`tmbprofile()` and `confint()`** (code):
    - General: bullets: `TMB::tmbprofile(obj, name, trace = FALSE)` profiles one parameter,
      named as in the list of parameters, and returns a data frame; `confint()` finds the two
      crossings; both work on the optimised scale, so transform the endpoints back.
    - Example: chunks for `fir_ten_profile` and `owl_profile_k`, with results in comments.
    - Script: the prefix `TMB::` because RTMB does not export it.
17. **Intervals and sample size:**
    - General: bullets: the log-likelihood of a larger sample is closer to a parabola around its
      maximum; so the intervals agree more closely and all are narrower; with a small sample the
      method matters.
    - Example: table (Wald original, Wald log, profile; 10 and 50 quadrats): 1.28–3.12 and
      1.73–2.55; 1.45–3.34 and 1.77–2.59; 1.40–3.25 and 1.76–2.57.
18. **Profile intervals with several parameters** (`.figure-slide`, `profile-interval.png`):
    - General: bullets: each parameter has its profile, with the others re-estimated; a Wald
      interval on the optimised scale can come close; on the original scale it may miss the
      asymmetry; the profile interval is the reference.
    - Example: compact table: $k$: profile 0.235–0.451, Wald from the log scale 0.237–0.453,
      Wald on the original scale 0.221–0.434; $\mu$: profile 3.49–6.68, Wald from the log scale
      3.45–6.55 calls per visit. Caption explains solid, dashed and vertical lines.
    - Script: the parabola is on the original scale, with standard error about 0.78.
19. **Joint confidence regions** (`.figure-slide`, `joint-region.png`):
    - General: `.definition` joint confidence region: the combinations whose relative
      log-likelihood is above a cutoff, with 3.00 for two parameters (half the 0.95 quantile
      with two degrees of freedom). Bullets: the region lies inside one contour of the surface;
      it extends beyond each interval; the rectangle formed by two intervals is not a 95%
      region; use an interval for one parameter and a region for a combination.
    - Example: caption: the owl model; vermillion contour, the region; segments, the two profile
      intervals.
20. **Simulating from a fitted model** (code):
    - General: bullets: `OBS()` in the NLL marks the data as observations; `obj$simulate()` then
      draws a hypothetical sample of the size of the data, for parameters on the optimised
      scale; placeholder data of another length give another sample size.
    - Example: complete `nb_nll` with `OBS(calls)` and
      `owl_obj$simulate(owl_fit$par)$calls[1:20]`.
21. **Coverage of Wald and profile intervals** (`.figure-slide`, `coverage.png`):
    - General: bullets: simulate from known parameters and record whether each interval contains
      them; a Wald interval on the original scale fails when counts are few; on a suitable scale
      it can match the profile with one fit; a simulated coverage has its own noise.
    - Example: Poisson, $\lambda=0.5$, 10 quadrats: Wald 0.878, profile 0.924. Negative
      Binomial, $k$, 20 visits: Wald from the log scale 0.945, profile 0.942. Noise about 0.005
      for 2,000 samples. Caption: dashed line, the nominal level.
    - Script: the zero-total samples (footnote); coverage is quick because one extra fit
      replaces a whole profile; Exercise 5.
22. **Discussion: Wald or profile?** (timed): for example: uses the curvature at the maximum;
    gives the same interval on any scale; needs a single fit; can include negative values for a
    positive parameter. Takeaway "Wald · Profile". Activity "**1 minute:** decide with a
    neighbour."
    - Script: answers: Wald; profile; Wald; Wald on the original scale. The break follows.

### Block 3: properties and model comparison

23. **Consistency** [Properties of maximum likelihood estimators; Consistency]:
    - General: `.definition` consistent estimator: the chance of missing the parameter by more
      than any given margin becomes small as the sample grows. Bullets: an MLE is an estimator,
      so it has a sampling distribution, a bias and a variance; MLEs are consistent when the
      observations are i.i.d. from the model; a statement about probabilities and not every
      sample.
    - Example: 2,000 hypothetical samples from the owl fit ($\mu=4.75$, $k=0.327$): missing $k$
      by 0.1 or more: 45% with 20 visits, 7% with 122, none with 500.
    - Script: seed 601, simulation on the chapter page; it is slow, so do not run it live; the
      box on consistency; this simulation serves slides 24 to 27.
24. **Asymptotic normality in a simulation** (`.figure-slide`, full width,
    `sampling-distribution-k.png`):
    - General, below the figure: how large $n$ must be depends on the model and the parameter;
      small samples can be skewed; a standard error from one fit describes the variation across
      samples when $n$ is large.
    - Example: 20 visits: skewed, mean 0.40; 500 visits: mean 0.329, nearly symmetric (parameter
      used to simulate 0.327). 122 visits: standard deviation of $\log(\hat k)$ 0.162, standard
      error from one fit 0.165. Caption explains bars, curves and line.
25. **Efficiency:**
    - General: `.definition` more efficient: estimates vary less across hypothetical samples.
      Bullets: maximum likelihood uses the probability of each observation, the method of
      moments only the mean and variance; **asymptotically efficient**: in large samples no
      other regular estimator is more precise; the inverse of the Fisher information is the
      smallest variance such an estimator can have.
    - Example: standard deviation of $\hat k$: 122 visits 0.055 against 0.086, 500 visits 0.024
      against 0.042; mean squared error at 122 visits: 0.0031 against 0.0085; the method of
      moments would need about 2.5 times as many visits.
    - Script: Cramér–Rao in words, with "unbiased", and the box; why this is the reason to use
      maximum likelihood when you can write the likelihood.
26. **Bias in finite samples:**
    - General: bullets: MLEs are in general biased in finite samples; the bias shrinks as the
      sample grows, faster than the standard error; for a small sample, these properties are
      approximations; check by simulation: simulate hypothetical samples from the fit, refit
      each, compare the mean of the estimates with the value used to simulate. No code.
    - Example: relative bias of $\hat k$: 21%, 2.6% and 0.6% for 20, 122 and 500 visits.
    - Script: the numbers come from the simulation of slide 23 (seed 601), the visible loop of
      the chapter. The bias corrections footnote (REML is not yet in Chapter 7: check before
      citing).
27. **Misspecified models** [Misspecified models]:
    - General: `.definition` misspecified: the model does not contain the distribution of the
      data generating process, for any parameter values. Bullets: the MLE converges to the
      values that bring the model closest to that process (the Kullback–Leibler divergence,
      named only); the fit is the best approximation that the model offers; standard errors and
      intervals become approximations.
    - No example box (author's decision of 3 November): the slide stays general.
    - Script: this section may be skipped at a first reading of the chapter.
28. **Discussion: which property?** (timed): for example: none of 2,000 estimates from 500
    visits misses $k$ by 0.1; a histogram of estimates that has become bell-shaped; one method
    needs 2.5 times the visits of another; a mean estimate 21% too high with 20 visits. Takeaway
    "Consistency · Asymptotic normality · Efficiency · Bias". Activity "**1 minute:** decide
    with a neighbour."
29. **The Akaike information criterion** [Model comparison with AIC]:
    - General: equation $\mathrm{AIC}=2K-2\,\ell(\hat\theta)$, $K$ the number of estimated
      parameters. Bullets: a model with more parameters can adapt to its own sample, and when it
      contains another as a special case its maximum cannot be lower; the lowest AIC is
      preferred; only differences between models fitted to the same observations in the same
      units are meaningful; it estimates the distance to the data generating process when
      predicting new data.
    - Example: table: Poisson, $K=1$, $\ell=-634.16$; Negative Binomial, $K=2$, $\ell=-299.44$;
      difference about 667.
    - Script: Kullback–Leibler named; Akaike (1973, 1974); why $2K$ corrects for using the same
      data twice.
30. **Corrected AIC:**
    - General: equation $\mathrm{AICc}=\mathrm{AIC}+2K(K+1)/(n-K-1)$. Bullets: with few
      observations per parameter, $2K$ is too small; each parameter costs $2n/(n-K-1)$; used as
      AIC, as a difference; derived for linear models with Normal errors, so an approximation
      here, but common in the literature.
    - Example: owls: 0.03 and 0.10 units against a difference of 667.
    - Script: needs $n>K+1$; Burnham and Anderson's $n/K$ below about 40; the practical reports
      both.
31. **Using AIC:**
    - General: bullets: ranks the candidates that we give it; does not show that the best one
      describes the data well; a rule such as "reject unless AIC drops by two units" is null
      hypothesis testing in disguise; one criterion among others for evidence and prediction.
    - Example: Negative Binomial far better than Poisson for the owls, and still an
      approximation (visits to the same nest).
    - Script: keep the chapter's wording on the absence of error-rate control and on strength of
      evidence; Chapter 6 adds BIC, cross-validation and goodness of fit.
32. **Practice 4: waiting for a pollinator** (Practice slide; "**2 minutes:** on paper"):
    Exponential ($K=1$) and Gamma ($K=2$) fitted to the same waiting times, maximum
    log-likelihoods $-231.0$ and $-230.4$; calculate both AICs; which is lower?; could the Gamma
    log-likelihood have been lower?
    - Script: 464.0 and 464.8; hardly distinguishable; no, because the Exponential is a Gamma
      with a shape of one.
33. **A recipe for a fit** (from the chapter's callout): incremental numbered list of the eight
    steps, each a keyword phrase with its function. Takeaway: the same steps for every model in
    the rest of the book.
34. **Course roadmap: from likelihood to response curves** (`.roadmap`), three rows, wording of
    the Chapter 1 slides: 4. Maximum likelihood estimation (How do we estimate, and how
    uncertain are we?); 5. Deterministic functions in ecology (Which curves describe ecological
    responses?); 6. Fitting ecological response curves (How do we fit a curve to data?).
35. **The Chapter 4 R practical:** incremental: **Reed frog tadpoles** (Exercise 1, questions 3
    to 6: standard errors, intervals, adequacy, predators); **Glacier lily seedlings** (Exercise
    2: joint region, intervals, AIC); **Zero inflation** (Exercise 3); **Timber volume and body
    mass** (Exercise 4: Gamma model, units); **Simulation** (Exercise 5: extra). Takeaway:
    Exercises 1 to 4 are the core. Try, then check.
36. **Summary and closing questions** (`.closing`): incremental: in large samples an MLE is
    approximately Normal, with variance from the inverse of the information; `sdreport()` gives
    standard errors on the optimised scale, and endpoints transform back; profile intervals
    follow the likelihood and do not depend on the scale; simulation checks coverage; MLEs are
    consistent and asymptotically efficient, and biased in small samples; AIC ranks candidates
    and shows nothing about whether they are good. Takeaway string: "Fisher information ·
    Hessian · Wald · Profile · Coverage · Efficiency · AIC". Activity, for example: "Why can we
    transform the endpoints of an interval and not a standard error?" and "What does AIC not
    tell us?"
    - Script: return to the cycle and the Estimation diagram by speaking; final transition to
      Chapter 5 (deterministic functions; no statistics; Chapter 6 joins them to this
      likelihood).

## Code slides

Each chunk is a shortened copy of the chapter's code, with `#| echo: true` and `#| eval: false`.
Do not invent code, and keep names and arguments. The code follows the `STYLE_GUIDE.md` rules:
`=` for assignment, `silent = TRUE`, `method = "BFGS"`, no `reltol`, no pipes.

| Lecture, slide | Content |
|---|---|
| 1, 12 | `dpois(log = TRUE)` and `sum()` |
| 1, 19 | `poisson_nll_lambda` |
| 1, 21 | `cmb()`, `MakeADFun()`, `optim()` |
| 1, 22 | `$par`, `$value`, `$convergence` |
| 1, 23 | `exp(log_lambda)` in the NLL, `exp(fir_fit$par)` |
| 1, 27 | Two-parameter `nb_nll` and its fit |
| 2, 8 | `sdreport()`, `summary()`, `cov2cor()` |
| 2, 9 | `ADREPORT(k)` (inline) |
| 2, 14 | `qchisq()` (one line) |
| 2, 16 | `TMB::tmbprofile()`, `confint()` |
| 2, 20 | `OBS()`, `obj$simulate()` |

## Figures

All raster figures are PNG with `dpi = 192`. Copies keep the size of the chapter's chunk (7 × 5
where the chunk sets none). Every image has a `fig-alt` that describes what it shows. Each
folder has its own `lecture-assets/figures.R`, which runs in a clean session from the repository
root and writes into its own `lecture-assets/`.

| File | Lecture, slide | Source |
|---|---|---|
| `ModelCycle.png` | 1, 3; 2, 3 | The author's diagram, referenced from `Chapter_1/Lecture/`, never edited |
| `optimiser-search.svg` | 1, 18 | **New schematic**, hand-written: an NLL curve against a parameter, without numbers; a "starting value" with three or four steps down to the "estimate" at the minimum; "negative log-likelihood" on the vertical axis. Curve in vermillion, steps in dark green |
| `fit-pipeline.svg` | 1, 20 | **New schematic**, hand-written: four boxes, left to right: "NLL (parameters, data)" → `cmb()` ("+ data") → `MakeADFun()` ("+ starting values"; "par, fn, gr") → `optim()` ("par, value, convergence"). No numbers |
| `likelihood-curve.png` | 1, 17 | **Copy** of `fig-likelihood_curve` (7 × 5) |
| `owl-fits.png` | 1, 28 | **Copy** of `fig-owl_fits` (9 × 4.5) |
| `likelihood-surface.png` | 1, 29 | **Copy** of `fig-likelihood_surface` (7 × 5) |
| `surface-size-prob.png` | 1, 30 | **Copy** of `fig-surface_size_prob` (7 × 5) |
| `slice-profile.png` | 1, 32 | **Copy** of `fig-slice_profile` (10 × 4.5; patchwork) |
| `curvature-information.png` | 2, 7 | **New.** `ggplot2`, `theme_classic()`. Relative log-likelihood against $\lambda$ for the first ten quadrats and for all 50 on one axis (grid `seq(0.8, 5, by = 0.05)`, `ylim` −8 to 0). Both curves vermillion with `linewidth = 0.8`, separated by `linetype`, legend on top. Axis labels as `fig-likelihood_curve` |
| `wald-parabolas.png` | 2, 10 | **New.** Ten quadrats: solid curve; dashed parabola on the original scale, $-(\lambda-\hat\lambda)^2/(2\,\mathrm{SE}^2)$; dotted parabola from the log scale, $-(\log(\lambda)-\log(\hat\lambda))^2/(2\,\mathrm{SE}_{\log}^2)$; horizontal line at −1.92 in `grey40`. Same axis as above, `ylim` −6 to 0. Standard errors from `sdreport()` with `ADREPORT(lambda)`, as in the chapter, not typed |
| `three-intervals.png` | 2, 15 | **New.** The same figure with the three intervals added as labelled horizontal segments below the cutoff ("Wald, original scale", "Wald, log scale", "Profile"), endpoints calculated in the code (`uniroot()` for the profile) |
| `profile-interval.png` | 2, 18 | **Copy** of `fig-profile_interval` (7 × 5) |
| `joint-region.png` | 2, 19 | **Copy** of `fig-joint_region` (7 × 5) |
| `coverage.png` | 2, 21 | **Copy** of `fig-coverage` (9 × 4) |
| `sampling-distribution-k.png` | 2, 24 | **Copy** of `fig-sampling_distribution_k` (9 × 4; patchwork) |

Copies must be identical to the chapter's output, including the random draws. Run each chunk
unchanged, in the chapter's order, after the chunks it depends on, and change only the last line
of a figure chunk, to assign the plot and save it with `ggsave()`.

- **Order matters.** `nb_nll` and `owl_obj` are redefined three times in the chapter, so keep
  that order or use the last version from the start, whichever gives identical figures; compare
  them.
- **Seeds:** 601 (the sampling distribution), 701 and 702 (coverage). Other chunks use no random
  numbers.
- **Run time:** `Lecture_2/lecture-assets/figures.R` refits thousands of samples and takes
  minutes. Run it in the background.
- **Comparison:** the rendered chapter figures are in
  `_site-prod/Chapter_4/Theory_files/figure-html/` and `_freeze/Chapter_4/Theory/figure-html/`.
  Those folders are git-ignored; use them only to compare with.
- If a copy is unreadable at slide size, report it to the author instead of changing the figure.

## Numbers to verify

The chapter's text is the source. **On 30 October I checked the following in R 4.6.1:** first
three counts 0, 1, 2; first ten quadrats sum to 22; likelihoods of the 50 counts
$4.21\times10^{-50}$ and $1.32\times10^{-39}$; relative log-likelihood $-3.33$ and $-1.76$; 122
owl visits, mean 4.754, variance 42.35, 44.3% zeros, 24 nests; Poisson log-likelihood of the owl
counts $-634.16$.

**Not yet checked; verify in Phase 1 by running the chapter's chunks, and correct the slide if R
disagrees** (and tell the author if R disagrees with the chapter): every other number in the
slide specifications above, and the values that the specifications say to quote from R (Lecture
1, slides 11 and 12; Lecture 2, slide 9). Coverage and simulation values must come from the
seeds of the chapter.

## Phase 1 steps

**Step A: folders, figures, numbers.**

1. Create both folders, copy `Chapter_3/Lecture/lecture.scss` unchanged to each.
2. Write both `figures.R`, the schematics, and run them. R is at `C:\Program
   Files\R\R-4.6.1\bin\Rscript.exe` on this machine (it is not on the Bash path). All the
   packages were available on 30 October: RTMB, RTMBdist, TMB, ggplot2, patchwork, glmmTMB,
   boot, emdbook.
3. Compare copies with the rendered chapter figures. Verify the numbers.
4. Add both lectures to `_quarto-prod.yml`: the render list after
   `Chapter_3/Lecture/lecture.qmd`, and the "Slides" sidebar section as "Chapter 4 (lecture 1)"
   and "Chapter 4 (lecture 2)". `_quarto-dev.yml` lists no lectures; leave it. No package list
   changes, because code on slides is not evaluated.

**Step B: Lecture 1 slides.** Front matter as in `Chapter_3/Lecture/lecture.qmd` with the title,
subtitle and footer above. `data-timing` in seconds on every slide.

**Step C: Lecture 2 slides.** The same.

**Checks.**

1. `quarto render Chapter_4/Lecture_1/lecture.qmd --to revealjs` from the repository root, and
   the same for Lecture 2. Look for warnings. Never claim a render that did not run.
2. Look at **every slide** with all fragments showing, at 1440 × 900. A working command on this
   machine, from PowerShell, N counting from 0:

   ```powershell
   & "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --headless=new --disable-gpu `
     --hide-scrollbars --window-size=1440,900 --virtual-time-budget=15000 `
     "--screenshot=<scratchpad>\slide-N.png" "file:///<path>/lecture.html?fragments=false#/N"
   ```

   Do not use `#/N/0/99`: it hides the fragments. Put the PNGs in your scratchpad and open them.
   A slide fails if anything touches the footer (slide 13 of Chapter 3 nearly does). Fix an
   overfull slide by moving text to the script notes, not by shrinking fonts.
3. **General-first audit:** apply the test of `STYLE_GUIDE_LECTURE.md` to every content slide
   and list any example number outside an `.example` box, a caption or a code comment.
4. Check that the minutes above equal `data-timing`, and that the blocks add up.

**Report and stop.** Say which files were made, which checks ran, which numbers were verified
and which differed from the chapter, any figure that is poor at slide size, and any slide where
the general statement was hard to write. Add a line to "Progress log". Ask the author to review
the slides and whether to commit first. Do not write the scripts.

## Phase 2 steps

1. Read the author's changes to both `lecture.qmd` (with `git diff` if Phase 1 was committed).
   **The slides as the author left them are the source for the script:** their numbers, order
   and titles replace those above. Recalculate the timing tables from `data-timing`.
2. Write what the author corrected, as general lessons, into `STYLE_GUIDE_LECTURE.md` (not a
   list of edits). Ask if a correction looks specific to one slide.
3. Write both `lecture-script.md` in the format of `STYLE_GUIDE_LECTURE.md` ("The script"),
   using the **Script** notes above and the chapter for the narrative.
   - Opening: draft for the author's review; 150 minutes (Lecture 1: 125 of slides and 5 of
     slack; Lecture 2: 118 and 12; 2 breaks of 10); one live demo; links to the theory and the practical; which slides use which figure,
     with `figures.R`. Lecture 2 links to Lecture 1.
   - Timing table: columns Slide, Topic, Minutes, Elapsed time, with breaks, slack and total.
   - The narrative states the general rule first, in full sentences, and then the example, as
     the slide does. Provenance and caveats once: fir data in Lecture 1, slide 5 or 7 (Davison
     and Hinkley 1997, `boot::fir`, as in the Chapter 3 script); owl data in Lecture 1, slide
     26; i.i.d. simplifications in the same places.
   - Practice and discussion slides give expected answers and say how long to wait. Practice
     slides are not solved by running code.
   - No first-person anecdote or opinion for the author.
4. **Adjustments during delivery** (slide numbers of the current tables). The demos are kept
   whole; if one overruns, it takes the slack first. Lecture 1: shorten slide 3 to a
   sentence; slide 19 to its bullets; slide 25 to the figure; section 3 of the demo (the
   second parameterisation) can be shown only as its plot. Keep: probability against
   likelihood (6, 8), the steps of a fit (16 to 19), slice against profile (28, 29). Lecture
   2: shorten slide 14 to its bullets and slide 24 to the definition; in the demo, show only
   the histograms and the table of efficiency. Keep endpoints against standard errors (9),
   what the profile interval is (12, 13), and that AIC ranks without judging (26). State the
   minutes that each recovers.
5. **Live demos:** a section per demo slide (Lecture 1, slide 30; Lecture 2, slide 23) that
   walks through the script by section: what to say before running each section, what to
   point at in the output, which question of the removed discussion slides to ask (slice or
   profile?; which property?), and the numbers to expect. Say to open R and run section 0
   during the preceding break (Lecture 2) or slide 29 (Lecture 1), and that section 3 of
   `demo-properties.R` runs for about 75 seconds, so explain the loop while it runs. No other
   code is run live.
6. **PDFs:** regenerate `lecture-script.pdf` for each lecture with Typst, as for Chapter 3
   (`quarto render lecture-script.md --to typst`; confirm it first). If that fails, say so.
7. **Status:** replace the row of `Chapter_4/Lecture_1/`, `Chapter_4/Lecture_2/` in the table of
   `AGENTS.md` with what exists, and what awaits review. Keep it to three lines.
8. Check the checklist of `STYLE_GUIDE_LECTURE.md`. Report files, checks that ran, numbers
   verified, and whether `AGENTS.md` and the style guide were updated. Leave this file in place;
   the author removes it.

## Progress log

Each phase or step adds one line: date, what is done, what is next.

- 30 October 2026: Phase 0 done (decisions, this plan, guidance). Next: Phase 1, step A.
- 30 October 2026: Phase 1 done (steps A to C): figures, schematics and slides of both lectures,
  committed so that `git diff` against that commit shows the author's edits. Every number in the
  slide specifications agreed with a run of all the chapter's chunks in R 4.6.1. For Phase 2 and
  the lecture guide: a code frame shows about 19 lines and hides the rest without warning; a
  full-width figure stretches to the bottom of the slide, so the text below it reaches the footer
  unless a spacer div follows it (slide 32 of Lecture 1, slide 24 of Lecture 2). Next: the
  author's review, then Phase 2.
- 3 November 2026: audit of both decks for "the main points stand on the slide"
  (`STYLE_GUIDE_LECTURE.md`). General points from the Script notes and the chapter were
  moved onto Lecture 1, slides 7, 30 and 32, and Lecture 2, slides 7, 11, 18, 21 and 25
  (new takeaways on 21 and 25); the example boxes of 21 and 25 were shortened to make room.
  Where the slides now differ from the specifications above, the slides hold. Lecture 2,
  slide 26: `checkConsistency()` and its chunk replaced by a general bullet on checking bias
  by simulation (author's decision).
- 3 November 2026: one live demo of 18 minutes per lecture (author's decision): slides
  "Live demo: a likelihood profile in R" (Lecture 1, slide 30) and "Live demo: properties by
  simulation" (Lecture 2, slide 25), with `demo-profile.R` and `demo-properties.R` in the
  lecture folders, both run in a clean session in R 4.6.1 (11 and 80 seconds; numbers agree
  with the chapter). Slides were merged or cut to keep 125 minutes (see "Cuts of 3 November");
  both decks rendered and every changed slide was inspected at 1440 × 900. Next: the
  author's review, then Phase 2.
- 3 November 2026: the chapter's "Standard errors and Wald intervals" was condensed (Fisher
  information, the Hessian, Jensen's inequality and the delta method moved to statistical
  detail boxes; no standard error by hand in the main text). Lecture 2, slides 6 to 12 of that
  morning became five slides (6 to 10): "The Hessian matrix", "From the Hessian to standard
  errors in R" and "`sdreport()` and `ADREPORT()`" were removed or merged, "Fisher
  information" became "Curvature and standard errors" and "`sdreport()`: standard errors and
  correlations" is new. 30 slides, 118 minutes, 12 of slack. `figures.R` now takes the two
  standard errors from `sdreport()` (same values, PNGs unchanged). The deck rendered and slides
  6 to 10 were inspected at 1440 × 900.
