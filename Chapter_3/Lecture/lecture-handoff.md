# Handoff: Chapter 3 lecture (from samples to estimates)

This file tells an agent how to build the Chapter 3 lecture. The structure, timing and
scope below were settled with the author on 28 October 2026. Do not change them without
asking. Routine wording and layout choices are yours.

**Update, 29 October:** the plan below still says "hypothetical experiments". The author
has since replaced that term by "hypothetical samples" (see `STYLE_GUIDE.md`); the
lecture files follow the new term and the schematic is now `hypothetical-samples.svg`.

## Read first

In this order:

1. `CLAUDE.md`, `AGENTS.md`, `STYLE_GUIDE.md` (rules for prose, notation, units and R).
2. `STYLE_GUIDE_LECTURE.md`: the lecture conventions, including live demos and breaks. It
   is binding except where this handoff adds to it.
3. `Chapter_2/Lecture/lecture.qmd`, `lecture.scss`, `lecture-script.md` and
   `lecture-assets/figures.R`: the closest model for this lecture (same length, three
   blocks, three demos). The committed slides include the author's fixes of 27 October
   (commit `ceb9176`) and are the reference for format and amount of text; they differ
   from `Chapter_2/Lecture/lecture-handoff.md` in places (for example descriptive titles
   such as "The Binomial distribution - Probability mass" and worked tables in examples).
   Follow the slides, not that handoff. The script is never a model of voice.
4. `Chapter_1/Lecture/lecture.qmd`: the layout of the slide with the Estimation diagram
   (columns, explanation of the arrows) and the wording of the roadmap slides.
5. `Chapter_1/Theory.qmd` (course overview, section "Chapter 3: From samples to
   estimates").
6. `Chapter_3/Theory.qmd` in full. The lecture follows it in order and takes all
   examples, numbers, seeds and wording of definitions from it.
7. `Chapter_3/Practicals/no_solution.qmd` (for Demo 3 and the practical slide).

The working tree was clean on branch `Lecture_3` when this plan was written. Keep any
author edits made since. Do not commit.

## Deliverables

All in `Chapter_3/Lecture/` unless stated otherwise:

1. `lecture.qmd`: 37 slides (sequence below).
2. `lecture.scss`: an unchanged copy of `Chapter_2/Lecture/lecture.scss` (it already has
   the demo styling).
3. `lecture-assets/`: the figures listed under "Figures", plus `figures.R` with the code
   that makes the PNGs.
4. `lecture-script.md`: the script, in the format of `STYLE_GUIDE_LECTURE.md`.
5. `lecture-script.pdf`: regenerate it from the script with Typst, the same way as for
   Chapters 1 and 2 (`Chapter_1/Lecture/.quarto/typst` suggests `quarto render
   lecture-script.md --to typst`; confirm before relying on it). If you cannot find out
   or Typst is missing, say so and skip this item.
6. `_quarto-prod.yml`: add `Chapter_3/Lecture/lecture.qmd` to the render list after the
   Chapter 2 lecture, and to the "Slides" sidebar section as "Chapter 3". Check whether
   `_quarto-dev.yml` lists the lectures; if it does, add Chapter 3 there too.
7. `STYLE_GUIDE_LECTURE.md` and `AGENTS.md`: the small updates under "Updates to the
   guidance".

Leave this handoff file in place; the author removes it.

## Overall design

- **Length:** as in Chapter 2. 90 minutes of slides (85 minutes on slides and 5 minutes
  of slack) plus 40 minutes of live demos in R (14 + 12 + 14), in three blocks separated
  by two breaks of 10 minutes. The session lasts 150 minutes. Demos and breaks are not
  part of the 90 minutes.
- **Blocks:** (1) samples and distributions, for counts and for continuous measurements,
  then Demo 1; break; (2) parameters, estimators and estimates, the method of moments,
  the sampling distribution, bias, variance, mean squared error and standard errors, then
  Demo 2; break; (3) confidence intervals and coverage, estimation of two parameters,
  consistency and asymptotic normality, then Demo 3, roadmap, practical and summary.
- **Order:** the chapter's order throughout. Estimation of two parameters (penguin
  variance, divisor $n$ against $n - 1$) stays after confidence intervals, as in the
  chapter (author's decision), although slide 10 points forward to it.
- **Running examples (from the chapter, do not replace):** the 50 balsam fir quadrats
  (`boot::fir`) under a Poisson model with a mean of 2.14 seedlings per quadrat, used from
  the first section to the confidence interval; every simulation is a plug-in simulation
  with $\lambda = 2.14$ and 50 quadrats (5 and 100 in the figure on asymptotic
  normality), with the chapter's seeds; the flipper lengths of the 123 Gentoo penguins
  under the Normal model of Chapter 2 ($\mu = 217$ mm, $\sigma = 6.5$ mm) for continuous
  samples and for two parameters. The orchid `Practice` callouts stay hypothetical.
- **Mathematics:** key equations only, at most one displayed equation per slide:
  $X_i \sim \operatorname{Poisson}(\lambda)$; $\hat\lambda = \overline X$; the bias
  $\operatorname{Bias}(\hat\theta) = E[\hat\theta] - \theta$; the MSE decomposition; the
  plug-in standard error $\widehat{\operatorname{SE}}(\hat\lambda) = \sqrt{\hat\lambda/n}$;
  the Wald interval $\hat\theta \pm z_{0.975}\,\widehat{\operatorname{SE}}(\hat\theta)$;
  the method-of-moments variance with divisor $n$; the large-sample approximation
  $\hat\lambda \overset{\mathrm{approx}}{\sim} \operatorname{Normal}(\lambda, \lambda/n)$.
  $\operatorname{Var}(\hat\lambda) = \lambda/n$ appears inline. The law of large numbers
  and consistency are stated **in words only** (author's decision); the formal limit
  statements stay in the chapter's "Statistical detail" boxes, and the script points to
  them. Use the chapter's notation ($X_i$, $x_i$, hats, $\overline X$,
  $\widehat{\sigma^2}_{\mathrm{MM}}$, $\theta$ for a parameter in general).
- **R code on slides:** three short display chunks (```` ```{r} ```` with `#| echo: true`
  and `#| eval: false`), taken from the chapter: relative frequencies (slide 7),
  hypothetical experiments with `replicate()` (slide 19) and the Wald interval (slide 27).
  Results are quoted as short comments in the chunk or in the script, not both.
- **Interaction:** three timed discussion slides (17, 24 and 33) and short activities on
  slides 6, 12, 21, 29 and 31. The four `Practice` callouts of the chapter that have no
  code are the activities of the slides where their concept is taught (author's decision):
  "bins and samples" (12), "what varies?" (21), "interpret an interval" (29) and "two
  studies of different size" (31). The four that involve a calculation or code are done
  in the demos. Students follow the demos on their laptops.
- **Cut from the slides** (author's decision): the Glivenko–Cantelli theorem (one
  sentence in the script of slide 8), the kernel density estimate and its bandwidth
  (script of slide 12 and Demo 1; the dashed curve of the figure is named in its
  caption), the types of `quantile()` (Demo 1 only), the $t$ interval (one sentence in
  the script of slide 26, as a special case for Normal observations).
- **Left out entirely** (author's decision): the author's first-person asides of the
  chapter, namely the footnote on the confusion around "sample variance" (including the
  remark on AI chatbots), the link to the author's blog post on variance estimators and
  the footnote that calls the link between a representative sample and good estimates a
  heuristic. Because that footnote qualifies the paragraph on representative samples and
  randomisation, leave that paragraph out of the script too, and say so in your report so
  that the author can restore it.

## Live demos

The author runs three live demos in R, at the end of each block. **The lecturer runs only
the code chunks that students can see on the pages they follow** (the chapter and, in
Demo 3, the practical), including the code of `Practice` solutions (author's decision).
No typed code, not even one line: unlike the Chapter 2 script, which typed a `dbinom()`
check, this script quotes no code that is not on the page. Hidden figure chunks are not
run. `Practice` callouts whose solutions are calculations by hand are solved by hand (on
the board or orally), with the chapter's solution; students may use R as a calculator on
their own.

Each demo slide follows `STYLE_GUIDE_LECTURE.md` ("Live demo: <topic>", `.demo-slide`,
an incremental list of 3 or 4 tasks, a `.demo` box naming the sections to open).
`data-timing` is 900, 780 and 900 seconds (one minute of introduction plus the demo).

The demos share one R session, so later demos use objects created earlier
(`seedling_counts`, `flipper_lengths`, `lambda_hat`, `estimated_se`). Say in the script
that the session must stay open across the breaks, and which chunk to rerun if it was
lost (the `fir` chunk and the penguin chunk).

| Demo | Minutes | Material, in this order |
|---|---:|---|
| 1. Samples and distributions | 14 | Chapter: the `fir` chunk and the RTMB/RTMBdist chunk; the `table(factor())` chunk and the comparison with `dpois()`; "Practice: fruit-set frequency" (by hand, 1 minute); the convergence loop with seed 123; the empirical mean against `mean()`, the empirical variance against `var()` (pointer to slide 30) and `quantile(type = 1)` (explain that R has nine definitions and that `type = 1` returns an observed count); the penguin chunk; the relative frequency of the bin 214.5–218.5 mm against the `pnorm()` difference; `density()` (explain the kernel and the bandwidth in two or three sentences, from the chapter); `ecdf()` at 225 mm against `pnorm()`; "Practice: orchid flowering across plots" (students try 2 minutes, then run the solution) |
| 2. Estimators and standard errors | 12 | Chapter: `mean(seedling_counts)`; "Practice: estimate from quadrats" (by hand); the `replicate()` chunk with seed 401 and its mean and standard deviation; the bias and variance chunk; the MSE chunk; the plug-in standard error chunk; "Practice: change the sample size" (by hand; students try 1 to 2 minutes) |
| 3. Intervals and two parameters | 14 | Chapter: the Wald interval chunk; the coverage chunk with seed 402 and `mean(covered)` (explain the braces, the last line as the value of each run, and `TRUE` counted as one); the method-of-moments variance of the flipper lengths against `var()`. Then the practical page: worked **Exercise 1** (barn owl calls; Negative Binomial by the method of moments, standard error, Wald interval), which uses Blocks 2 and 3 together and shows students how the practical works (author's decision) |

Notes for the demo sections of the script:

- Demo 1: run the orchid solution last. It redefines `count_values` (0 to 12), which no
  later chunk of the chapter uses, but running it earlier would break the chunks of
  "Mean, variance and quantiles of a data sample". Checkpoints: by minute 5 start the
  summaries of the sample, by minute 7 the penguins, by minute 10 the orchid practice. If
  late: skip the fruit-set practice and `quantile()`, and run the orchid solution without
  the student attempt.
- Demo 2: point out that the simulated standard deviation (about 0.205) agrees with the
  plug-in standard error (about 0.207) because the simulation used the estimate as its
  parameter. Checkpoints: by minute 6 the bias and variance chunk, by minute 9 the
  sample-size practice. If late: answer the quadrat practice orally and skip the MSE
  chunk.
- Demo 3: Exercise 1 needs `glmmTMB` for the data (installed in the Chapter 1
  practical). Give students one minute to read the three questions first. Point out that
  the Poisson standard error is about a third of the Negative Binomial one (link to the
  warning on slide 23) and that the 122 visits come from 24 nests (i.i.d. is a
  simplification; Chapter 7). Checkpoints: by minute 5 the flipper variances, by minute 7
  the practical page. If late: skip the flipper variances (their numbers are on slide 30)
  and shorten Exercise 1 to questions 1 and 2.

## Slide sequence and timing

Times in minutes. "Elapsed" counts from the start of the session, including demos and
breaks. Slide titles are sentence case except the title slide. The minutes of each slide
must equal its `data-timing`.

| Slide | Title | Min | Elapsed |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis (title) | 1 | 0–1 |
| 2 | Overview of the lecture | 1 | 1–2 |
| 3 | Where we are: the modelling cycle | 1 | 2–3 |
| 4 | From data to estimates | 1 | 3–4 |
| 5 | Samples and distributions | 2 | 4–6 |
| 6 | From frequency to probability | 3 | 6–9 |
| 7 | Relative frequencies in R | 2 | 9–11 |
| 8 | The law of large numbers | 3 | 11–14 |
| 9 | The empirical distribution | 3 | 14–17 |
| 10 | Summaries of a sample | 3 | 17–20 |
| 11 | Samples of continuous measurements | 2 | 20–22 |
| 12 | Density-scaled histograms | 3 | 22–25 |
| 13 | The empirical cumulative distribution | 2 | 25–27 |
| 14 | Live demo: samples and distributions | 1 + 14 | 27–42 |
| | Break | 10 | 42–52 |
| 15 | Parameters, estimators and estimates | 3 | 52–55 |
| 16 | The method of moments | 3 | 55–58 |
| 17 | Discussion: parameter, estimator or estimate? | 3 | 58–61 |
| 18 | The sampling distribution | 3 | 61–64 |
| 19 | Hypothetical experiments in R | 2 | 64–66 |
| 20 | A simulated sampling distribution | 2 | 66–68 |
| 21 | Bias and variance | 3 | 68–71 |
| 22 | Mean squared error | 2 | 71–73 |
| 23 | Standard errors | 3 | 73–76 |
| 24 | Discussion: standard deviation or standard error? | 3 | 76–79 |
| 25 | Live demo: estimators and standard errors | 1 + 12 | 79–92 |
| | Break | 10 | 92–102 |
| 26 | Confidence intervals | 3 | 102–105 |
| 27 | Wald interval in R | 2 | 105–107 |
| 28 | The dance of the confidence intervals | 3 | 107–110 |
| 29 | Coverage checked by simulation | 2 | 110–112 |
| 30 | Estimation of two parameters | 3 | 112–115 |
| 31 | Consistency | 2 | 115–117 |
| 32 | Asymptotic normality | 3 | 117–120 |
| 33 | Discussion: empirical or sampling distribution? | 3 | 120–123 |
| 34 | Live demo: intervals and two parameters | 1 + 14 | 123–138 |
| 35 | Course roadmap: from samples to response curves | 2 | 138–140 |
| 36 | The Chapter 3 R practical | 2 | 140–142 |
| 37 | Summary and closing questions | 3 | 142–145 |
| | Slack for discussion | 5 | 145–150 |
| | **Total** | **150** | |

Check: slides 85 (blocks of 28, 28 and 29, each including its one-minute demo
introduction) + slack 5 = 90; demos 14 + 12 + 14 = 40; breaks 20.

## Content of each slide

The slide text below is a guide to content, not final wording. Follow "Content of a
slide" and "Incremental building" of `STYLE_GUIDE_LECTURE.md`: keywords and very short
sentences, about four bullets, lists in `.incremental`, takeaways and activities as
fragments and last on the slide. Where a slide below lists more than fits, keep the
definition and the example and move the rest to the script. The narrative of each slide
goes in the script and follows the chapter section named in brackets.

### Block 1: samples and distributions

1. **Title** (`.lecture-title`): subtitle "Chapter 3 · Lecture", eyebrow "From Samples to
   Estimates".
2. **Overview of the lecture**: numbered, bold keyword + question, for example: samples
   and distributions (how does a sample relate to a model?); continuous samples (how do
   we compare measurements with a density?); estimators (how do we calculate a parameter
   from a sample?); sampling distributions (how much would an estimate change in another
   experiment?); standard errors and confidence intervals (how uncertain is an
   estimate?); large samples (what happens as the sample grows?); the practical (what
   comes next?). The script mentions the three blocks, the demos and the breaks, and asks
   students to have the Chapter 3 page open.
3. **Where we are: the modelling cycle** (`.diagram-slide`, 1 minute): the author's
   `ModelCycle.png`, referenced unchanged as `../../Chapter_1/Lecture/ModelCycle.png`,
   with `.cycle-diagram`. Caption: this lecture is "Confidence intervals (3)" in the
   estimation box. Not built. Script: Chapter 2 gave the distribution; this chapter is
   the first step of estimation; one or two sentences only (the author goes through
   slides 3 and 4 in about a minute each).
4. **From data to estimates** (`.diagram-slide`, 1 minute): the author's
   `Estimation.png`, referenced unchanged as `../../Chapter_1/Lecture/Estimation.png`,
   with `.estimation-diagram`, in the layout of the Chapter 1 slide (62/38 columns). Beside
   it one takeaway (fragment) with arrows, for example "Chapter 2: parameters
   $\rightarrow$ data · Chapter 3: data $\rightarrow$ estimates". Script: Chapter 2
   calculated probabilities from known parameters; research faces the reverse problem
   (the chapter's introduction); the dashed arrow from estimates to parameters is what
   this lecture makes precise.
5. **Samples and distributions** (Samples and distributions): bullets: the data
   generating process is approximated by a model; a sample is treated as if it were a
   random sample from the model. `.example`: balsam fir seedlings in 50 quadrats; Poisson
   model, mean 2.14 seedlings per quadrat. Bullet: the 50 counts are treated as i.i.d., a
   simplification (neighbouring quadrats; Chapter 7). Script: data provenance (Davison
   and Hinkley 1997, `boot::fir`, a grid of five rows of ten quadrats of five by five
   feet), stated once; 2.14 is the mean of the counts and slide 16 explains why it is a
   reasonable value; the model probability of more than eight seedlings is below 0.001.
6. **From frequency to probability** (From frequency to probability): `.definition`
   relative frequency (times a value appears divided by the sample size); a compact table
   with the counts 0 to 8 as columns and two rows, relative frequency and Poisson
   probability (values under "Numbers to verify"). Bullets (fragment): between 0 and 1,
   sum to 1; similar to the model, not equal. Activity (fragment): "Why are the two rows
   not equal?" (sampling variation; the model is an approximation; answers in the
   script).
7. **Relative frequencies in R**: the chapter's chunks, shortened to the `fir` lines,
   `count_values`, the `table(factor())` line, the division by the number of quadrats and
   the `dpois()` call. `.definition` (fragment): `factor()` levels keep counts that no
   quadrat has (frequency zero). Script: RTMB and RTMBdist were loaded as in Chapter 2.
8. **The law of large numbers** (`.figure-slide`): the copy
   `relative-frequency-convergence.png`; beside it: 100 simulated samples per size; the
   spread narrows as the sample grows; a statement about probabilities, not about every
   sample. Caption: grey points are simulated relative frequencies of three seedlings,
   vermillion the Poisson probability. Takeaway (fragment) from the note callout
   "Frequencies converge to probabilities". Script: one sequence of samples cannot show
   convergence (the seed-123 table, run in Demo 1); Glivenko–Cantelli in one sentence;
   the formal statement is in the chapter's box.
9. **The empirical distribution** (Empirical distribution): `.definition` empirical
   distribution (mass at each count equals its relative frequency); the copy
   `fir-empirical-distribution.png` at full width (two panels); bullet (fragment): its
   cumulative version is the fraction of observations at or below each count, compared
   with the model as steps. Caption on colours (blue: the 50 quadrats; vermillion: the
   Poisson model). Script: Kolmogorov's definition (1933) as an optional remark.
10. **Summaries of a sample** (Mean, variance and quantiles of a data sample; Asymptotic
    convergence): bullets: mean of the empirical distribution = arithmetic mean (2.14
    seedlings per quadrat); its variance divides by $n$ (2.36), `var()` by $n - 1$
    (2.41), explained on slide 30; median by inverting the empirical cumulative
    distribution (2 seedlings). Takeaway (fragment): for large i.i.d. samples, the mean,
    variance and quantiles of the empirical distribution approach those of the model.
    Script: in this course a mean and a variance are properties of distributions, so
    "sample mean" means the mean of the empirical distribution; the conditions of the
    note callout (moments that exist; quantiles where the cumulative probability function
    is not flat); larger samples are more stable; agreement with a model does not show
    independence. No remark on chatbots or dogmatic claims (left out).
11. **Samples of continuous measurements** (Samples of continuous measurements):
    exact measurements never repeat, so each relative frequency would be $1/n$; the 123
    Gentoo penguins have 25 different flipper lengths (nearest mm); a **histogram** counts
    observations in bins. `.example`: 214.5 to 218.5 mm: $31/123 \approx 0.252$, model
    probability about 0.241. Script: the penguins and the Normal model come from
    Chapter 2 (one sentence on provenance and R 4.5.0); bin limits at half millimetres.
12. **Density-scaled histograms** (`.figure-slide`, figure at full width): the copy
    `histogram-density.png` (three panels); below it, incremental: height = relative
    frequency / bin width ($0.252/4 = 0.063$/mm against a density of 0.061/mm); the bin
    width is our choice. Caption: grey bars, the 123 flipper lengths; vermillion solid,
    the Normal model; blue dashed, a smooth estimate from the sample (kernel density).
    Activity (fragment), from "Practice: bins and samples": would another 123 penguins
    give the same histogram, and would a different bin width change the mean? Script:
    `hist(probability = TRUE)` draws this scale; the kernel density estimate and the
    bandwidth in a few sentences (cut from the slides); the two curves differ through
    sampling variation and because the model is an approximation, and one sample cannot
    tell how much of each; answers to the activity.
13. **The empirical cumulative distribution**: no bins and no bandwidth; steps of $1/n$
    (multiples where rounded values coincide). `.example`: 88% of the penguins have a
    flipper of at most 225 mm; the model gives about 0.89. Takeaway (fragment): it
    converges to the cumulative probability function of the model. No figure (the author
    chose not to copy `fig-ecdf_normal`); `ecdf()` is run in Demo 1.
14. **Live demo: samples and distributions** (`.demo-slide`), tasks for example:
    relative frequencies and the Poisson model; simulated samples and summaries of a
    sample; flipper lengths: a bin, a smooth density and the ECDF; practise with orchid
    flowering across plots. `.demo`: "**Follow along:** Chapter 3, *Samples and
    distributions* and *Samples of continuous measurements*."

### Block 2: estimators and standard errors

15. **Parameters, estimators and estimates** (Parameters, estimators and estimates):
    equation $X_i \sim \operatorname{Poisson}(\lambda)$, $\lambda$ the expected number of
    seedlings per quadrat; three `.definition` boxes (second and third fragments) from the
    chapter's note callout: parameter (fixed, unknown, defines the model), estimator (a
    rule applied to a random sample; varies across hypothetical experiments), estimate
    (the number for one sample). Script: the hat notation; i.i.d. means the same area and
    expected count in every quadrat and no influence between quadrats.
16. **The method of moments** (Method of moments): equation $\hat\lambda = \overline X$;
    bullets: equate moments of the model and of the empirical distribution; one
    parameter, the mean; two parameters, the mean and the variance (slide 30).
    `.example`: $\hat\lambda = 2.14$ seedlings per quadrat. Takeaway (fragment):
    maximum likelihood from Chapter 4; the concepts that follow apply to any estimator.
    Script: the justification is the convergence of slide 10; raw and central moments
    give the same estimators (footnote, optional).
17. **Discussion: parameter, estimator or estimate?** (timed; takeaway and activity
    visible from the start, as on the Chapter 2 discussion slides): numbered list in
    `.incremental`, for example: the expected number of seedlings per quadrat,
    $\lambda$; "add the counts and divide by the number of quadrats"; 2.14 seedlings per
    quadrat for the 50 fir quadrats; the mean of the 50 quadrats that a colleague will
    count next year. Takeaway "Parameter · Estimator · Estimate". Activity "**1
    minute:** decide with a neighbour." Answers in the script (parameter; estimator;
    estimate; estimator, a random variable until the quadrats are counted).
18. **The sampling distribution** (Sampling distributions): `.definition` sampling
    distribution; the new schematic `hypothetical-experiments.svg` in a 56–60% column;
    beside it, incremental: within an experiment, quadrats vary (Poisson); between
    experiments, estimates vary (sampling distribution); imaginary: we run one
    experiment. Script: adding quadrats increases $n$ and does not repeat the
    experiment; in a finite sample the shape is in general unknown, so we simulate.
19. **Hypothetical experiments in R**: the chapter's chunk (seed 401, `true_lambda`,
    `n_quadrats`, `n_experiments`, `replicate()`), followed by `mean()` and `sd()` of
    `lambda_estimates`. `.definition` (fragment): `replicate()` evaluates `expr` `n` times
    and collects the results.
20. **A simulated sampling distribution** (`.figure-slide`): the copy
    `sampling-distribution.png`; beside it: mean of the estimates close to 2.14; standard
    deviation about 0.205 seedlings per quadrat; values are means, so not integers.
    Caption: grey, 2,000 simulated estimates; vermillion, the parameter used in the
    simulation.
21. **Bias and variance** (Bias and variance): equation
    $\operatorname{Bias}(\hat\theta) = E[\hat\theta] - \theta$; bullets: the mean of
    i.i.d. counts is unbiased; most estimators are biased in finite samples (for example
    $e^{-\hat\lambda}$ for the probability of an empty quadrat); variance of the
    estimator $\lambda/n$, smaller with more quadrats. The simulated values (bias about
    0.001, variance 0.0419 against $2.14/50 = 0.0428$) as an `.example` or in the
    script, not both. Activity (fragment), from "Practice: what varies?": two studies of
    50 quadrats report 1.9 and 2.3 seedlings per quadrat; what varies, and is the
    estimator biased? Script: $\lambda/n$ is an exact result for the mean only (a special
    case of $\sigma^2/n$ for the mean of i.i.d. observations); for other estimators we
    rely on large samples or simulation, as the chapter says.
22. **Mean squared error** (Mean squared error): equation
    $\operatorname{MSE}(\hat\theta) = \operatorname{Var}(\hat\theta) +
    \operatorname{Bias}(\hat\theta)^2$; bullets: compares estimators of the same
    parameter; a biased estimator can have a smaller MSE. Script: for an unbiased
    estimator the MSE is its variance (0.0418 in the simulation); the bias–variance
    trade-off footnote as an optional remark; the comparison of two variance estimators
    in practical Exercise 3.
23. **Standard errors** (Standard errors): equation
    $\widehat{\operatorname{SE}}(\hat\lambda) = \sqrt{\hat\lambda/n}$; bullets: the
    standard deviation of the sampling distribution, in the units of the estimate; a
    plug-in estimate replaces $\lambda$ by $\hat\lambda$. `.example`: 50 quadrats: about
    0.21 seedlings per quadrat. Takeaway (fragment): it relies on the Poisson model;
    overdispersed counts make it too small. Script: across hypothetical experiments of 50
    quadrats the estimates would vary with a standard deviation of about 0.21; a plug-in
    standard error is itself a rough estimate in small samples.
24. **Discussion: standard deviation or standard error?** (timed, as slide 17): for
    example: how much the counts differ among the 50 quadrats (about 1.55 seedlings per
    quadrat); how much the mean of 50 quadrats would differ among studies (about 0.21);
    the spread of the histogram of slide 20; $\sqrt{2.14} \approx 1.46$ seedlings per
    quadrat, for one quadrat under the model. Takeaway "Standard deviation · Standard
    error". Activity "**1 minute:** decide with a neighbour." Answers in the script
    (standard deviation; standard error; standard error; standard deviation), with the
    chapter's warning callout said once: more quadrats reduce the standard error and not
    the standard deviation of the counts.
25. **Live demo: estimators and standard errors** (`.demo-slide`), tasks for example:
    the estimate from the fir counts; 2,000 hypothetical experiments; bias, variance and
    MSE in the simulation; the plug-in standard error and a larger sample. `.demo`:
    "**Follow along:** Chapter 3, *Parameters, estimators and estimates*, *Sampling
    distributions* and *Standard errors*."

### Block 3: intervals, two parameters and large samples

26. **Confidence intervals** (Confidence intervals): `.definition` confidence interval
    (a range for a parameter from a procedure whose behaviour across hypothetical
    experiments we can describe); `.definition` (fragment) confidence level; equation
    $\hat\theta \pm z_{0.975}\,\widehat{\operatorname{SE}}(\hat\theta)$ with
    $z_{0.975} \approx 1.96$; bullet: the **Wald interval** assumes an approximately
    Normal sampling distribution (slide 32). Script: the quantile leaves 0.025 in each
    tail; the $t$ interval in one sentence as an exact special case for Normal
    observations (cut from the slides).
27. **Wald interval in R**: the chapter's chunks for `lambda_hat`, `n_counts`,
    `estimated_se`, `critical_value` and `interval` (approximately 1.73 to 2.55 seedlings
    per quadrat, in a comment or the script). Takeaway (fragment): an interval for the
    mean count, not for the counts of single quadrats.
28. **The dance of the confidence intervals** (`.figure-slide`): the copy `dance-ci.png`
    (tall; a 56–63% column); beside it, incremental: the parameter is fixed (dashed
    line); the interval changes from experiment to experiment; 95% describes the
    procedure. Caption: top, the simulated sampling distribution; below, 20 hypothetical
    experiments; vermillion, the one interval that misses the parameter. Takeaway
    (fragment): a calculated interval either contains $\lambda$ or it does not. Script:
    if the connection allows, open Geoff Cumming's animation at
    <https://logarithmic.net/2017/dance/> for about one minute (within the three
    minutes), with the static figure as fallback; the chapter's note callout "What 95%
    confidence means".
29. **Coverage checked by simulation** (Coverage checked by simulation): `.definition`
    coverage; `.example`: 2,000 experiments of 50 quadrats: 0.9525; bullet: small
    $n\lambda$, lower coverage and possibly a negative lower endpoint. Activity
    (fragment), from "Practice: interpret an interval": a study reports 1.5 to 2.9
    seedlings per quadrat; what does the 95% refer to, and which assumptions would you
    check? Script: the coverage code is run in Demo 3; answers to the activity
    (procedure; i.i.d. Poisson, overdispersion, sample size for the Normal
    approximation).
30. **Estimation of two parameters** (Estimation of two parameters): bullet
    $X_i \sim \operatorname{Normal}(\mu, \sigma^2)$ for the flipper lengths; equation
    $\widehat{\sigma^2}_{\mathrm{MM}} = \frac{1}{n}\sum_{i=1}^{n}(X_i - \overline X)^2$;
    bullet: `var()` divides by $n - 1$. `.example`: $\hat\mu \approx 217.2$ mm; variance
    41.7 mm² (method of moments) against 42.1 mm² (`var()`), standard deviations 6.46 and
    6.48 mm: the source of 217 mm and 6.5 mm in Chapter 2. Takeaway (fragment): divisor
    $n$, too small on average by $\sigma^2/n$; divisor $n - 1$, unbiased. Script: the
    deviations are taken from $\overline X$, which is closer to the observations than
    $\mu$; `sd()` is a biased estimator of $\sigma$; plug-in bias about $-0.34$ mm² for
    123 penguins and $-1.68$ mm² for 25; unbiased does not mean the smallest MSE
    (practical Exercise 3); the history of Bessel's correction (Gauss 1823, Bessel 1838,
    Fisher) as an optional remark. No blog link (left out).
31. **Consistency** (Consistency and asymptotic normality): `.definition` consistent
    estimator, in words (increasingly unlikely to miss the parameter by any given margin
    as the sample grows); bullets: the same statement as for relative frequencies (slide
    8), about probabilities and not every sample; the method-of-moments variance is
    consistent although biased; four times the sample halves the standard error.
    Activity (fragment), from "Practice: two studies of different size": 20 quadrats give
    2.1, 100 quadrats give 2.3, the model mean is 2.14; does this contradict consistency?
    (No; answer in the script.) Script: the formal statement is in the chapter's box.
32. **Asymptotic normality** (`.figure-slide`, figure at full width): the copy
    `asymptotic-normality.png` (5 and 100 quadrats); equation
    $\hat\lambda \overset{\mathrm{approx}}{\sim} \operatorname{Normal}(\lambda,
    \lambda/n)$; bullets (incremental): central limit theorem, the mean of i.i.d.
    observations with finite variance, whatever the distribution of the observations;
    5 quadrats, discrete and skewed; 100 quadrats, close to Normal. Caption: grey, 2,000
    simulated means; vermillion, the Normal approximation. Takeaway (fragment): it
    justifies the Wald interval; how large $n$ must be depends on the model. Script: the
    counts are still Poisson, it is their mean that becomes Normal; Chapter 4 generalises
    the result to other parameters; the warning callout "Finite samples and special
    cases" (confident statements hold for large samples; for small samples check by
    simulation), said once; all these properties are derived under the assumed model, and
    a larger sample does not correct habitat differences, clustering or missed seedlings
    (Chapter 2 for overdispersed counts, Chapter 7 for grouped observations).
33. **Discussion: empirical or sampling distribution?** (timed, as slide 17): for
    example: a histogram of the 123 flipper lengths; a histogram of 2,000 simulated means
    of 50 quadrats; the relative frequencies of the 50 fir counts; the distribution that
    a standard error describes. Takeaway "Empirical distribution · Sampling
    distribution". Activity "**1 minute:** decide with a neighbour." Answers in the
    script (empirical; sampling, approximated by simulation; empirical; sampling).
34. **Live demo: intervals and two parameters** (`.demo-slide`), tasks for example: a
    Wald interval for the fir counts; coverage by simulation; two estimates of the
    flipper variance; practical Exercise 1: barn owl calls. `.demo`: "**Follow along:**
    Chapter 3, *Confidence intervals* and *Estimation of two parameters*; then the
    practical, *Exercise 1*."
35. **Course roadmap: from samples to response curves** (`.roadmap`): a table of three
    rows, wording from the Chapter 1 roadmap slides: 3. From samples to estimates (What
    does a sample tell us?); 4. Maximum likelihood estimation (How do we estimate, and how
    uncertain are we?); 5. Deterministic functions in ecology (Which curves describe
    ecological responses?). Script: Chapter 4 replaces the method of moments by maximum
    likelihood and keeps the concepts of today (standard errors, intervals, coverage,
    asymptotic normality); Chapter 7 handles observations that are not independent.
36. **The Chapter 3 R practical**: incremental list of bold keywords for the four
    exercises: barn owl calls (worked on the page: Negative Binomial by the method of
    moments, standard error, Wald interval); asymptotic convergence (Beta model of leaf
    damage); tree heights (two variance estimators, bias and MSE); body mass (LogNormal
    model, coverage of Wald intervals). Takeaway: read the Beta and LogNormal entries of
    the supplement; try, then check.
37. **Summary and closing questions** (`.closing`): incremental take-home points (a
    sample is treated as random draws from a model; relative frequencies, histograms and
    ECDFs compare a sample with the model; an estimator is a rule, an estimate its value
    for one sample; the sampling distribution gives bias, standard error and MSE; a 95%
    interval describes the coverage of a procedure; large samples give consistency and
    asymptotic normality, small samples are checked by simulation). Takeaway string, for
    example "Empirical distribution · Estimator · Sampling distribution · Bias · Standard
    error · Confidence interval · Coverage". Activity with two closing questions, for
    example: "Why does the standard error shrink with more quadrats, while the standard
    deviation of the counts does not?" and "What does the 95% of a confidence interval
    describe?" Script: return to slide 4 by speaking (data to estimates; the dashed arrow
    to the parameters now has a standard error and an interval); final transition to
    Chapter 4.

## Figures

All raster figures are PNG. Copies keep the chapter's `fig-width` and `fig-height` (7 × 5
where the chunk sets none) and use `dpi = 192`, as in Chapter 2. Every image has a
descriptive `fig-alt`. Put all figure code in `lecture-assets/figures.R`, which runs in a
clean session from the repository root and writes into `lecture-assets/`.

| File | Slide | Source |
|---|---|---|
| `ModelCycle.png` | 3 | The author's diagram, referenced from `Chapter_1/Lecture/`, never edited |
| `Estimation.png` | 4 | The author's diagram, referenced from `Chapter_1/Lecture/`, never edited |
| `relative-frequency-convergence.png` | 8 | **Copy** of `fig-relative-frequency-convergence` (7 × 5) |
| `fir-empirical-distribution.png` | 9 | **Copy** of `fig-ecdf` (9 × 4) |
| `histogram-density.png` | 12 | **Copy** of `fig-histogram_density` (10 × 3.5; patchwork) |
| `hypothetical-experiments.svg` | 18 | **New schematic**, hand-written SVG like `Chapter_2/Lecture/lecture-assets/density-area.svg`: a box "Model" on the left; arrows to three rows labelled "Experiment 1", "Experiment 2", "Experiment 3" (and a row of dots), each a row of small squares (quadrats) ending in "…"; an arrow from each row to "estimate"; the estimates gathered into a histogram shape labelled "Sampling distribution". A bracket over one row of quadrats labelled "variation among quadrats", and one over the estimates labelled "variation among experiments". No axes, numbers or fitted values. Plain text labels (no hats, which render poorly in SVG text). Course palette: model and sampling distribution in vermillion, quadrats in Okabe–Ito blue or grey |
| `sampling-distribution.png` | 20 | **Copy** of `fig-sampling_distribution` (7 × 5) |
| `dance-ci.png` | 28 | **Copy** of `fig-dance_ci` (7 × 6; patchwork) |
| `asymptotic-normality.png` | 32 | **Copy** of `fig-asymptotic_normality` (9 × 4; patchwork) |

Not used (author's decision): `fig-ecdf-poisson` and `fig-ecdf_normal`.

Copies must be identical to the chapter's output, including the random draws. Run each
figure chunk unchanged after the chunks it depends on, with the chapter's seeds and in
the chapter's order: `fig-sampling_distribution` and the top panel of `fig-dance_ci` use
`lambda_estimates` from the seed-401 chunk; `fig-dance_ci` then sets seed 1;
`fig-histogram_density` needs `flipper_lengths` and `flipper_density`; the other figures
set their own seeds (20261003, 404). Only the last line of a chunk changes, to assign the
plot and save it with `ggsave()`, as in `Chapter_2/Lecture/lecture-assets/figures.R`.
Base R distribution functions may replace the RTMB ones in `figures.R` (they give the
same values), as in Chapter 2; say so in its header.

The wide figures (slides 9, 12 and 32) are placed at the full width of a `.figure-slide`
without columns, with the short list or equation below them (the stylesheet already sets
`width: 100%` and `max-height: 560px` on images of a `.figure-slide`). If a copy is
unreadable at slide size, report it to the author instead of changing the figure.

## Numbers to verify

The values below were checked in R 4.6.1 (`stats`, `boot`, `datasets`) when this plan was
written and agree with the chapter. Check them again before use, and correct the slide
and script if R disagrees:

- Fir counts: relative frequencies of 0 to 8 seedlings 0.14, 0.24, 0.26, 0.16, 0.14,
  0.04, 0.00, 0.02, 0.00; Poisson probabilities with mean 2.14: 0.118, 0.252, 0.269,
  0.192, 0.103, 0.044, 0.016, 0.005, 0.001 (round both rows the same way on the slide);
  $P(X > 8) \approx 0.0004$; mean 2.14; variance of the empirical distribution 2.36,
  `var()` 2.41; `sd()` 1.55; median (`type = 1`) 2.
- Penguins: 123 flipper lengths, 25 different values; the bin 214.5–218.5 mm holds 31
  ($0.252$), model probability 0.241; bar height 0.063/mm, `dnorm(216.5)` 0.061/mm;
  `ecdf()` at 225 mm 0.878, `pnorm()` 0.891; bandwidth of `density()` about 2.23 mm;
  mean 217.19 mm; variance 41.71 mm² (divisor $n$) and 42.05 mm² (`var()`); standard
  deviations 6.46 and 6.48 mm.
- Sampling distribution (seed 401, 2,000 experiments of 50 quadrats): mean 2.1407,
  standard deviation 0.2046, bias 0.0007 (the chapter rounds it to 0.001), variance
  0.0419 against 0.0428, MSE 0.0418.
- Standard error and interval: plug-in standard error 0.2069; Wald interval 1.7345 to
  2.5455; coverage (seed 402) 0.9525; standard error for 200 quadrats 0.103; standard
  deviation of one count $\sqrt{2.14} \approx 1.46$.
- Dance figure (seed 1, 20 experiments): exactly one interval (experiment 6) misses the
  parameter.

Not verified (glmmTMB was not installed): practical Exercise 1, as stated on the
practical page: 122 visits, mean 4.75 calls per visit, variance 42.3, $\hat k \approx
0.60$, standard error 0.59, standard deviation 6.5, Poisson standard error 0.20, Wald
interval 3.60 to 5.91. Check them before quoting them in the Demo 3 section. Do not quote
results of the orchid simulation (seed 246) unless you have run it.

If R or a package is unavailable, keep the chapter's values and list them as unverified.

## The script

Follow "The script" of `STYLE_GUIDE_LECTURE.md` and the shape of the Chapter 2 script,
with these points:

- **Opening:** draft for the author's review; target 90 minutes of slides plus 40
  minutes of live demos and two breaks of 10 minutes (150 minutes); links to the theory
  and the practical; that the narrative is here; which slides use which figure (the
  author's diagrams on 3 and 4; the schematic on 18; copies on 8, 9, 12, 20, 28 and 32)
  and that the code of the PNGs is in `lecture-assets/figures.R`.
- **Timing table:** as above, with columns Slide, Topic, Minutes, Elapsed time; demo
  slides show "1 + 14" or "1 + 12"; breaks and slack are rows without a slide number; one
  line below totals slides, slack, demos and breaks.
- **One section per slide**, `## Slide N — Title`; slides 1 and 2 may share one section,
  and slides 3 and 4 may too, since the author goes through them in about two minutes.
  The narrative follows the chapter section named for the slide and uses its definitions
  and numbers. Provenance and caveats are said once: the fir data on slide 5, the i.i.d.
  simplification on slide 5, the penguins on slide 11, the owl data in Demo 3. The
  asides listed under "Left out entirely" do not appear.
- **Demo sections** (slides 14, 25, 34): the one-minute introduction, then a **Live
  demo** block with the steps in order, the chunks to run (named by what they compute,
  since chunks have no labels), what to point out, which `Practice` callouts students try
  first and for how long, the checkpoints and what to drop when late (see "Live demos").
  No code is quoted, because every chunk is on the page.
- **Discussion slides** (17, 24, 33) have a **Discussion and expected answers** block.
- **Activity slides** (6, 12, 21, 29, 31) give the expected answers, taken from the
  chapter's `Practice` solutions where the activity comes from one.
- **Breaks:** "Break (10 minutes)." after the sections of slides 14 and 25.
- **Adjustments during delivery:** what to shorten first, for example slide 3 to one
  sentence (about half a minute), slide 13 merged into speech on slide 12 (about one and
  a half minutes), slide 22 to one sentence on slide 21 (about one and a half minutes),
  slide 35 to one sentence (about one and a half minutes), the fruit-set and quadrat
  practices answered orally; and which explanations to keep: the two kinds of repetition
  (slide 18), standard deviation against standard error (slides 23 and 24), what 95%
  means (slides 28 and 29), and that all the properties are derived under the assumed
  model (slide 32).

## Updates to the guidance

- **`STYLE_GUIDE_LECTURE.md`:** add, without restructuring the file and written as
  conventions, not as the history of this lecture: (1) a demo may end with the worked
  exercise of the practical page; (2) a `Practice` callout without code may be the
  `.activity` of the slide that teaches its concept; (3) under "Slide classes for
  figures", a wide figure of several panels may take the full width of a `.figure-slide`,
  with the list below it. Do not change the existing sentence on typed code in demos; the
  stricter rule of this lecture (visible chunks only) is recorded in `AGENTS.md`.
- **`AGENTS.md`:** add a row to the status table: `Chapter_3/Lecture/` is a generated
  draft of 90 minutes of slides (37 slides) plus 40 minutes of live demos (14 + 12 + 14)
  in three blocks with two breaks; the demos run only the chunks visible on the chapter
  and practical pages (author's decision); slides and script await review. Keep it to two
  or three lines. Update "Builds and packages" only if the build list changes in a way it
  describes.

## Checks and report

1. Render with `quarto render Chapter_3/Lecture/lecture.qmd --to revealjs` from the
   repository root, if Quarto is available. Look for warnings (missing images, MathJax).
   Never claim a render that did not run. Look at the wide figures and the schematic at
   slide size.
2. Run `lecture-assets/figures.R` in a clean session and compare the copies with the
   rendered chapter figures.
3. Check the checklist of `STYLE_GUIDE_LECTURE.md`, plus: the minutes in the script equal
   every `data-timing` (900, 780 and 900 for the demo slides); slide numbers in the
   script match the rendered slides; demo sections quote no code; discussion and activity
   slides follow the rules above.
4. Report: files created and changed, which checks ran, which numbers were verified in R
   and which were not, any figure that looks poor at slide size, the paragraph on
   representative samples that was left out of the script, and whether `AGENTS.md` and
   `STYLE_GUIDE_LECTURE.md` were updated.
