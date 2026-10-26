# Handoff: Chapter 2 lecture (probability distributions)

This file tells an agent how to build the Chapter 2 lecture. The structure, timing and
scope below were settled with the author on 26 October 2026. Do not change them without
asking. Routine wording and layout choices are yours.

## Read first

In this order:

1. `CLAUDE.md`, `AGENTS.md`, `STYLE_GUIDE.md` (rules for prose, notation, units and R).
2. `STYLE_GUIDE_LECTURE.md`: the lecture conventions. It is binding except where this
   handoff adds to it (live demos, breaks).
3. `Chapter_1/Lecture/lecture.qmd`, `lecture.scss` and `lecture-script.md`: the
   reference for format, amount of text per slide and the shape of the script. The slides
   are the reference; the script is never a model of voice.
4. `Chapter_1/Theory.qmd` (course overview, section "Chapter 2: Probability
   distributions").
5. `Chapter_2/Theory.qmd` in full. The lecture follows it in order and takes all
   examples, numbers and wording of definitions from it.
6. `Chapter_2/Practicals/no_solution.qmd` (for the practical slide).

The working tree has uncommitted author edits (`AGENTS.md`, `CLAUDE.md`,
`STYLE_GUIDE_LECTURE.md`, deleted Chapter 1 lecture files). Keep them. Do not commit.

## Deliverables

All in `Chapter_2/Lecture/` unless stated otherwise:

1. `lecture.qmd`: 33 slides (sequence below).
2. `lecture.scss`: a copy of `Chapter_1/Lecture/lecture.scss` with only the new demo
   styling added (see "Live demos").
3. `lecture-assets/`: the figures listed under "Figures", plus `figures.R` with the code
   that makes them.
4. `lecture-script.md`: the script, in the format of `STYLE_GUIDE_LECTURE.md`, with demo
   sections (see "The script").
5. `lecture-script.pdf`: regenerate it from the script with Typst, the same way as for
   Chapter 1 (look for how the Chapter 1 PDF was made, for example a Typst template or a
   `quarto render --to typst` call; if you cannot find out or Typst is missing, say so and
   skip this item).
6. `_quarto-prod.yml`: add `Chapter_2/Lecture/lecture.qmd` to the render list after the
   Chapter 1 lecture, and to the "Slides" sidebar section as "Chapter 2". Check whether
   `_quarto-dev.yml` lists the Chapter 1 lecture; if it does, add Chapter 2 there too.
7. `STYLE_GUIDE_LECTURE.md`: add the conventions for live demos and breaks (see "Updates
   to the guidance").
8. `AGENTS.md`: a row for `Chapter_2/Lecture/` in the status table (see "Updates to the
   guidance").

Leave this handoff file in place; the author removes it.

## Overall design

- **Length:** 90 minutes of slides (85 minutes on slides and 5 minutes of slack) plus
  40 minutes of live demos in R, in three blocks separated by two breaks of 10 minutes.
  The session lasts 150 minutes in total. Demos and breaks are not part of the 90 minutes.
- **Blocks:** (1) discrete distributions and the four faces, then Demo 1; break; (2)
  continuous distributions, then Demo 2; break; (3) joint distributions, expectations,
  choosing a distribution and overdispersion, then Demo 3, roadmap, practical and summary.
- **Running examples (from the chapter, do not replace):** seed survival in quadrats with
  four seeds under a Binomial model with $p = 0.4$; flipper length of the 123 Gentoo
  penguins under a Normal model with $\mu = 217$ mm and $\sigma = 6.5$ mm; germination of
  two seeds for joint distributions; flipper length and body mass for the joint density;
  spring salamander counts (`Salamanders`, species `GP`, 12 unmined sites, 48 counts) for
  overdispersion.
- **Mathematics:** key equations only, at most one displayed equation per slide, for
  these ideas: the sum of probabilities is 1, the Binomial mass function, the cumulative
  probability and the quantile (discrete definition), the probability of an interval as an
  integral, the Normal density, $F(b) - F(a)$, the independence product, $E[f(X)]$ as a
  weighted sum, the variance, the Poisson mean equal to the variance, the dispersion ratio
  and the Negative Binomial variance. Symbols are explained in the script, not on the
  slide. Use the chapter's notation ($X$ and $x$, $P(X = x)$, $F_X$, $f_X$, $q_\alpha$,
  $E[X]$, $\operatorname{Var}(X)$).
- **R code:** short display chunks only (```` ```{r} ```` with `#| eval: false`, so that
  rendering needs no R packages), taken from the chapter, on slides 10 and 17. Results
  are quoted from the chapter or checked in R (see "Numbers to verify"). The longer
  examples happen in the live demos.
- **Interaction:** two timed discussion slides (18 and 24) and short questions on slides
  5, 12, 15, 21 and 29. Students follow the demos on their laptops.
- **Cut from the slides** (author's decision): skewness and kurtosis (one sentence in the
  script of slide 26), pseudo-random numbers and seeds (shown in Demo 1 only), the
  Beta-Binomial and Conway–Maxwell–Poisson distributions (named in the script of
  slide 29 only).

## Live demos

The author runs three live demos in R. They use the material that the chapter already
has: its code chunks and its `Practice` callouts. Do not write new R scripts for the
demos. Students follow along on the chapter page.

Each demo has its own slide at the end of its block, titled "Live demo: <topic>". It shows:

- an incremental list of 3 or 4 tasks, each one a short phrase naming what is run;
- a `.demo` box that names the chapter sections to open ("Follow along: Chapter 2,
  *The four faces of a distribution*").

Add a slide class `.demo-slide` and a box class `.demo` to `lecture.scss`. Stay within
the course palette (for example light green `#f0f6f2` background with a dark green
`#164c43` left rule and a small "Live demo" label, as in the other boxes). Change no other
rule of the stylesheet.

Timing: a demo slide has `data-timing` equal to one minute of introduction plus the demo
(780, 780 and 1020 seconds), so that the speaker view tracks the whole session. The
script's table shows the two parts separately (see "Timing table").

| Demo | Minutes | Chapter material, in this order |
|---|---:|---|
| 1. Discrete distributions | 12 | Loading RTMB and RTMBdist; the four `*binom()` calls of "The four faces of a distribution"; checking $P(X = 2)$ from slide 7 with `dbinom()`; `set.seed()` and `rbinom()` (pseudo-random numbers and seeds are explained here, from the chapter's two paragraphs); "Practice: orchid fruit set" |
| 2. Continuous distributions | 12 | Loading `penguins` and keeping the Gentoo penguins; `dnorm()` at 217 mm, in mm and in cm ("Mass and density"); the `pnorm()` difference, `lower.tail = FALSE` and `qnorm()` ("The four faces of a continuous distribution"); "Practice: measuring a flipper" (brief) and "Practice: a flipper length threshold" |
| 3. Expectations and overdispersion | 16 | Mean and variance of the seed model as weighted sums; `integrate()` for the mean and variance of the flipper model, with the reason for finite limits; the salamander counts and the dispersion ratio ("A simple diagnostic for overdispersion"); "Practice: fruit set on orchid plants" and, if time allows, "Practice: variation in orchid stem counts" |

In the script, each demo section says which chunks to run and in which order, what to
point out in the output, when to let students try a `Practice` callout first (1 to 2
minutes) before solving it live, and checkpoints for time ("by minute 6, start the
simulation"). It quotes code only where the chapter has none (for example the
`dbinom()` check of slide 7). It also says what to drop when a demo runs late.

## Slide sequence and timing

Times in minutes. "Elapsed" counts from the start of the session, including demos and
breaks. Slide titles are sentence case except the title slide. The minutes of each slide
must equal its `data-timing`.

| Slide | Title | Min | Elapsed |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis (title) | 1 | 0–1 |
| 2 | Overview of the lecture | 1 | 1–2 |
| 3 | Where we are: the modelling cycle | 2 | 2–4 |
| 4 | Random variables and support | 3 | 4–7 |
| 5 | Probabilities of counts | 3 | 7–10 |
| 6 | What do these probabilities mean? | 2 | 10–12 |
| 7 | The Binomial distribution | 3 | 12–15 |
| 8 | The four faces of a distribution | 4 | 15–19 |
| 9 | Cumulative probability and quantiles | 3 | 19–22 |
| 10 | The four faces in R | 3 | 22–25 |
| 11 | Live demo: discrete distributions | 1 + 12 | 25–38 |
| | Break | 10 | 38–48 |
| 12 | Continuous random variables | 3 | 48–51 |
| 13 | Probability density | 4 | 51–55 |
| 14 | The Normal distribution | 3 | 55–58 |
| 15 | Mass and density | 3 | 58–61 |
| 16 | The four faces of the Normal distribution | 4 | 61–65 |
| 17 | Intervals and tails in R | 3 | 65–68 |
| 18 | Discussion: d, p, q or r? | 3 | 68–71 |
| 19 | Live demo: continuous distributions | 1 + 12 | 71–84 |
| | Break | 10 | 84–94 |
| 20 | Joint and marginal distributions | 3 | 94–97 |
| 21 | Independence | 3 | 97–100 |
| 22 | The joint distribution of two measurements | 3 | 100–103 |
| 23 | Independent and identically distributed | 2 | 103–105 |
| 24 | Discussion: joint, marginal or independent? | 3 | 105–108 |
| 25 | Expectations and the mean | 3 | 108–111 |
| 26 | Variance and standard deviation | 2 | 111–113 |
| 27 | Choosing a distribution | 3 | 113–116 |
| 28 | Overdispersion | 3 | 116–119 |
| 29 | Distributions for overdispersed counts | 2 | 119–121 |
| 30 | Live demo: expectations and overdispersion | 1 + 16 | 121–138 |
| 31 | Course roadmap: from distributions to estimates | 2 | 138–140 |
| 32 | The Chapter 2 R practical | 2 | 140–142 |
| 33 | Summary and closing questions | 3 | 142–145 |
| | Slack for discussion | 5 | 145–150 |
| | **Total** | **150** | |

Check: slides 85 + slack 5 = 90; demos 12 + 12 + 16 = 40; breaks 20.

## Content of each slide

The slide text below is a guide to content, not final wording. Follow "Content of a
slide" and "Incremental building" of `STYLE_GUIDE_LECTURE.md`: keywords and very short
sentences, about four bullets, lists in `.incremental`, takeaways and activities as
fragments and last on the slide. The narrative of each slide goes in the script and
follows the chapter section named in brackets.

### Block 1: discrete distributions

1. **Title** (`.lecture-title`): subtitle "Chapter 2 · Lecture", eyebrow "Probability
   Distributions".
2. **Overview of the lecture**: numbered, bold keyword + question, for example:
   discrete random variables (what can we count, and how probable is it?); the four faces
   (how do we calculate with a distribution?); continuous random variables (what is a
   probability density?); joint distributions (when are observations independent?);
   expectations (what are the mean and the variance of a distribution?); choosing a
   distribution (which distribution for which data?); the practical (what comes next?).
   The script mentions the three blocks, the demos and the breaks.
3. **Where we are: the modelling cycle** (`.diagram-slide`): the author's
   `ModelCycle.png`, referenced unchanged as `../../Chapter_1/Lecture/ModelCycle.png`
   (do not copy or edit it), with `.cycle-diagram`. Caption: the box with chapter 2
   ("distribution"). Script: Chapter 1 split a model into a response function and a
   probability distribution; this chapter is the language for the second part. Not built.
4. **Random variables and support** (Random variables and probability): `.definition`
   random variable; `.definition` (fragment) support; `.example` four seeds per quadrat,
   $X \in \{0, 1, 2, 3, 4\}$; finite and countably infinite (traps without a maximum);
   $X$ the random variable, $x$ an observation.
5. **Probabilities of counts**: the chapter's table of $P(X = x)$ (0.05, 0.15, 0.30,
   0.30, 0.20); equation $\sum_{\forall x} P(X = x) = 1$; $P(X \geq 3) = 0.30 + 0.20 =
   0.50$. Activity (fragment): "What is $P(X \leq 1)$?" (0.20; answer in the script).
6. **What do these probabilities mean?**: two columns, each a fragment: epistemic
   (certainty about a prediction) and aleatoric (relative frequency across replications).
   Takeaway: this course uses relative frequencies (frequentist). The script keeps the
   chapter's footnotes on terminology as optional remarks and the pointer to Dietze's
   *Ecological Forecasting* only if the author wants it.
7. **The Binomial distribution**: assumptions as bullets (a fixed number of events $n$;
   two values, 0 or 1; the same probability $p$ for each); the mass function
   $P(X = x) = \binom{n}{x} p^x (1 - p)^{n - x}$; `.example`: $n = 4$, $p = 0.4$,
   $P(X = 2) = 6 \times 0.16 \times 0.36 \approx 0.35$ (checked in R in Demo 1). Script:
   Bernoulli 1713 as the chapter states it; why "failures and successes" is avoided.
8. **The four faces of a distribution** (`.figure-slide`): new figure
   `binomial-four-faces.png` in a 62–65% column; beside it an incremental list: mass,
   cumulative probability, quantile, random sampler. Script: "four faces" is the author's
   own term (keep the chapter's wording, first person allowed because it is the author's
   claim in the chapter).
9. **Cumulative probability and quantiles**: $F_X(x) = P(X \leq x)$ and
   $q_\alpha = \min\{x : F_X(x) \geq \alpha\}$ as two blocks (second a fragment);
   `.example`: $F_X(2) \approx 0.82$, median 2. Takeaway: quantiles return as confidence
   intervals in Chapter 3. Script: the cumulative probability is the basis of p-values,
   which the course does not use (the chapter's footnote).
10. **The four faces in R**: the chapter's chunk with `dbinom()`, `pbinom()`, `qbinom()`,
    `rbinom()` (display only); `.definition`: prefix + short name; first argument `x`,
    `q`, `p` or `n`, then the parameters. Script: RTMB and RTMBdist supply the functions
    and are loaded once, RTMB first (one sentence, pointer to Chapter 4, nothing on TMB);
    sampling is called simulation in the course. The packages are named in the script,
    not on the slide.
11. **Live demo: discrete distributions** (`.demo-slide`): tasks and `.demo` box as in
    "Live demos".

### Block 2: continuous distributions

12. **Continuous random variables**: `.definition`; the 123 Gentoo penguins, flipper
    length in mm; infinitely many values between 217 and 218 mm; records rounded to the
    nearest mm. Activity (fragment): a flipper recorded as 221 mm: which lengths could it
    be, and is $P(X = 221) > 0$? (Practice "measuring a flipper"; answers in the script.)
    Data provenance (Gorman, Williams and Fraser 2014; R 4.5.0) in the script only.
13. **Probability density**: equation $P(a < X \leq b) = \int_a^b f_X(x)\,dx$; bullets:
    area under the curve; $f_X(x) \geq 0$ and total area 1; endpoints do not matter.
    Optional schematic `density-area.svg` (density curve with a shaded interval, no
    numerical scales) in a 56–60% column. Script: why a single value has probability zero,
    keeping the author's hand-waving footnote on measure theory as an optional remark.
14. **The Normal distribution**: the density formula; $\mu$ sets the centre, $\sigma$ the
    spread; `.example`: flipper length, $\mu = 217$ mm, $\sigma = 6.5$ mm, rounded values
    that describe the 123 penguins. Script: how such values are obtained is Chapter 3; a
    negative length has negligible probability.
15. **Mass and density**: two columns (fragments): discrete (`d*` gives a probability,
    sums) and continuous (`d*` gives a density in 1/mm, integrals, can exceed 1).
    `.example`: 0.0614/mm, 0.614/cm, 61.4/m at the mean. Takeaway: a density is a
    probability per unit of $X$, not the probability of a value. Activity (fragment): "Can
    a density be larger than 1?" Script: the approximation density × width ≈ 0.061 for a
    record of 217 mm.
16. **The four faces of the Normal distribution** (`.figure-slide`): the copy
    `normal-four-faces.png`; beside it: area under the density, smooth cumulative
    probability, exact inverse for the quantile, histogram of the 123 penguins in place of
    a simulated sample. Caption on colours (vermillion: model; grey: measurements).
17. **Intervals and tails in R**: equation $P(a < X \leq b) = F_X(b) - F_X(a)$; display
    chunk with the `pnorm()` difference (approximately 0.68), `lower.tail = FALSE` for
    lengths above 230 mm (about 2%) and `qnorm(p = 0.95)` (approximately 227.7 mm). Quote
    the numbers in the script, or as short comments in the chunk, not both.
18. **Discussion: d, p, q or r?** (timed; takeaway and activity visible from the start,
    as on the Chapter 1 discussion slide): numbered list in `.incremental`, for example:
    the probability that exactly two seeds survive; the probability that a flipper is
    between 210 and 220 mm; the length below which 95% of flippers fall; 20 hypothetical
    quadrats. Takeaway "`d` · `p` · `q` · `r`". Activity: "**1 minute:** decide with a
    neighbour." Answers in the script (`d`; `p` twice, a difference; `q`; `r`).
19. **Live demo: continuous distributions** (`.demo-slide`).

### Block 3: joint distributions, expectations and choice

20. **Joint and marginal distributions**: `.definition` joint distribution; the general
    2 × 2 table of germination of two seeds with margins (the chapter's first table, in a
    compact form); `.definition` (fragment) marginal distribution: add over a row or a
    column. Not built beyond the fragment definition (tables are not built).
21. **Independence**: equation
    $P(X_1 = x_1, X_2 = x_2) = P(X_1 = x_1)\,P(X_2 = x_2)$; the numeric table for
    $P(X_1 = 1) = 0.6$, $P(X_2 = 1) = 0.3$ (0.28, 0.42, 0.12, 0.18). Takeaway:
    independence is an assumption of the model. Activity (fragment): one reason why two
    seeds might not be independent (shared parent plant, soil patch, drought, herbivore).
22. **The joint distribution of two measurements** (`.figure-slide`): the copy
    `joint-density.png`; beside it: contours join equal density; tilted contours:
    correlation 0.7; above both means: 0.25 if independent, about 0.37 with the
    correlation. Script: continuous version of joint, marginal and independence with
    integrals, in words; a bivariate Normal with correlation 0 is independent (not true in
    general).
23. **Independent and identically distributed**: `.definition` i.i.d.; identically
    distributed and independent are separate assumptions; `.example` two seeds with
    $p = 0.3$ (0.49, 0.21, 0.21, 0.09) or just the statement; takeaway: the basis of
    estimation in Chapters 3 and 4.
24. **Discussion: joint, marginal or independent?** (timed, as slide 18): for example:
    the body mass of a penguin regardless of its flipper length (marginal); a flipper of
    210 to 225 mm and a mass above 5000 g (joint); acorn production of two oaks under the
    same weather (independence doubtful); four visits to the same stream site treated as
    i.i.d. (a simplification; Chapter 7). Takeaway "Joint · Marginal · Independent ·
    i.i.d." Activity: "**1 minute:** decide with a neighbour." Answers in the script.
25. **Expectations and the mean**: equation $E[f(X)] = \sum_x f(x)\,P(X = x)$; the mean
    $E[X]$ as a probability-weighted average; `.example`: the seed model, mean 1.6 seeds,
    which no quadrat can contain. Script: the continuous version is an integral with the
    density; the chapter's note that the mean need not be an observable value.
26. **Variance and standard deviation**: equation
    $\operatorname{Var}(X) = E[(X - E[X])^2]$; SD as its square root, in the units of
    $X$; `.example`: flipper model, 42.25 mm², SD 6.5 mm (the parameters of the Normal);
    seed model: the mean 1.6 is not a parameter. Script: central moments in one sentence;
    skewness and kurtosis in one sentence each (cut from the slides).
27. **Choosing a distribution**: two columns (fragments): discrete (fixed upper limit:
    Binomial; no upper limit: Poisson, Negative Binomial) and continuous (unconstrained:
    Normal; positive: LogNormal; constrained: Beta). Takeaway: no correct distribution,
    only plausible candidates (type and range of values, mean–variance relationship, fit
    to the data). Script: read the supplement entries; formal comparison in Chapters 4
    (AIC) and 6.
28. **Overdispersion** (`.figure-slide`): new figure `salamander-counts.png`; beside it:
    Poisson $E[X] = \operatorname{Var}(X) = \lambda$; the dispersion ratio (sample variance
    / sample mean); salamanders: mean 2.21, variance 4.98, ratio about 2.3. Caption on
    colours. Script: data source (Price et al. 2016, full reference from the chapter);
    treating four visits per site as i.i.d. is a simplification (Chapter 7); `var()` and
    the sample variance are explained in Chapter 3.
29. **Distributions for overdispersed counts**: Negative Binomial with mean $\mu$ and
    shape $k$, $\operatorname{Var}(X) = \mu + \mu^2/k$; smaller $k$, more variance; large
    $k$, close to Poisson. Activity (fragment): which ecological causes could make the
    salamander counts overdispersed? (habitat differences among sites, clustering,
    detection, repeated visits.) Script: the ratio describes and does not identify the
    cause (the chapter's warning callout, said once); Beta-Binomial and
    Conway–Maxwell–Poisson named in one sentence with a pointer to the supplement.
30. **Live demo: expectations and overdispersion** (`.demo-slide`).
31. **Course roadmap: from distributions to estimates** (`.roadmap`): a table of three
    rows, wording taken from the Chapter 1 roadmap slides: 2. Probability distributions
    (What can we observe, and how probable is it?); 3. From samples to estimates (What
    does a sample tell us?); 4. Maximum likelihood estimation (How do we estimate, and how
    uncertain are we?). Script: Chapter 3 reverses the direction, from known parameters
    to a sample (`Chapter_1/Theory.qmd`).
32. **The Chapter 2 R practical**: incremental list of bold keywords for the six
    exercises (seedling survival and bill length, worked on the page; overdispersion with
    `InsectSprays`; Negative Binomial quadrat counts; LogNormal body mass; Beta vegetation
    cover). Takeaway: read the supplement entries first, then try before checking.
33. **Summary and closing questions** (`.closing`): incremental take-home points (a
    distribution assigns probabilities to sets of values; four faces; mass vs density;
    independence and i.i.d. are assumptions; mean and variance as expectations; choose by
    support and mean–variance relationship). Takeaway string, for example "Random variable
    · Distribution · Four faces · Density · Independence · Expectation · Overdispersion".
    Activity with two closing questions, for example: "Why is `dnorm()` at 217 mm not the
    probability of a 217 mm flipper?" and "What does a dispersion ratio of 2.3 tell us,
    and what does it not tell us?" Script: return to slide 3 by speaking.

## Figures

All raster figures are PNG at a size that fills their column at 1440 × 900 (look at the
sizes of the Chapter 1 PNGs). Every image has a descriptive `fig-alt`. Put all figure
code in `lecture-assets/figures.R`, which runs in a clean session from the repository
root and writes into `lecture-assets/`.

| File | Slide | Source |
|---|---|---|
| `ModelCycle.png` | 3 | The author's diagram, referenced from `Chapter_1/Lecture/`, never edited |
| `binomial-four-faces.png` | 8 | **New.** Same content as `fig-four_faces` of the chapter ($n = 4$, $p = 0.4$, cutoff 2, 20 samples with seed 42), redrawn in the course style: `theme_classic()`, model mass as vermillion (`#D55E00`) bars or segments, the simulated sample as `grey90` bars with `grey40` outline, cutoff marks in grey. The chapter's figure uses an off-style palette, which is why it is redrawn and not copied |
| `normal-four-faces.png` | 16 | **Copy** of `fig-four_faces_normal`: run the chapter chunk unchanged (with its data loading) and save with `ggsave()` |
| `joint-density.png` | 22 | **Copy** of `fig-joint_density`, same procedure |
| `salamander-counts.png` | 28 | **New.** Relative frequencies of the 48 `GP` counts at unmined sites (`grey90` bars, `grey40` outline) and the Poisson mass with the sample mean (vermillion points and segments). No Negative Binomial: no parameters for it are given in the chapter and fitting is Chapter 4 (author's decision). Axes: "Number of salamanders", "Relative frequency / probability" or similar |
| `density-area.svg` | 13 | **Optional schematic**, hand-written SVG like `Chapter_1/Lecture/lecture-assets/feeding-response.svg`: a bell-shaped curve with a shaded area between $a$ and $b$, no numerical scales |

Copies of chapter figures stay unchanged. If the patchwork layout of a copy is unreadable
at slide size, report it to the author instead of changing the figure.

## Numbers to verify

Check in R before using them, and correct the slide and script if R disagrees:

- Binomial $n = 4$, $p = 0.4$: $P(X = 2) = 0.3456$; $F_X(2) = 0.8208$;
  `qbinom(0.5, 4, 0.4)` = 2; mean 1.6; variance 0.96.
- Normal 217, 6.5: `dnorm(217, 217, 6.5)` ≈ 0.0614; in cm ≈ 0.614; the `pnorm()`
  difference between 210.5 and 223.5 ≈ 0.68; $P(X > 230)$ ≈ 0.023; `qnorm(0.95)` ≈ 227.7.
- Bivariate Normal, correlation 0.7: $P$(above both means) ≈ 0.37 (the exact value is
  $1/4 + \arcsin(0.7)/(2\pi) \approx 0.373$).
- Salamanders: 48 counts, mean 2.21, variance 4.98, ratio ≈ 2.3 (needs `glmmTMB`).

If R or a package is unavailable, keep the chapter's values and list them as unverified.

## The script

Follow "The script" of `STYLE_GUIDE_LECTURE.md` and the shape of the Chapter 1 script,
with these additions:

- **Opening:** draft for the author's review; target 90 minutes of slides plus 40 minutes
  of live demos and two breaks of 10 minutes (150 minutes); links to the theory and the
  practical; that the narrative is here; which slides use which figure (ModelCycle on 3;
  new figures on 8 and 28; copies on 16 and 22; schematic on 13 if made) and that the
  code of the figures is in `lecture-assets/figures.R`.
- **Timing table:** as above, with columns Slide, Topic, Minutes, Elapsed time. Demo
  slides show "1 + 12" (or similar) in Minutes; breaks and slack are rows without a slide
  number. Below the table, one line totals slides, slack, demos and breaks.
- **One section per slide**, `## Slide N — Title`. The narrative follows the chapter
  section of that slide and uses its definitions and numbers. The author's first-person
  remarks in the chapter (the four faces as their own term, the hand-waving on measure
  theory, the Bernoulli and Dietze footnotes) are kept in the chapter's words or offered
  as optional notes; invent nothing on the author's behalf.
- **Demo sections** (slides 11, 19, 30): the narrative of the one-minute introduction,
  then a **Live demo** block (steps, chapter chunks, what to point out, `Practice`
  callouts that students try first, time checkpoints, what to drop if late).
- **Discussion slides** (18, 24) have a **Discussion and expected answers** block.
- **Breaks:** after the sections of slides 11 and 19, a short line "Break (10 minutes)".
- **Adjustments during delivery:** what to shorten first (for example slide 6 to one
  sentence, slide 23 merged into speech on slide 21, the second `Practice` callout of
  Demo 3, slide 31 to one sentence), how much each recovers, and which explanations to
  keep (mass vs density, independence as an assumption, the dispersion ratio as
  description).

## Updates to the guidance

- **`STYLE_GUIDE_LECTURE.md`:** add, without restructuring the file: live demos (their
  own slide "Live demo: ..." at the end of a block, `.demo-slide` and `.demo`, tasks as an
  incremental list, `data-timing` including the demo, demos outside the length that the
  author sets, demo instructions only in the script and based on the chapter's material);
  breaks as rows of the timing table without a slide; the fifth box class in the box
  table; figure code for new slide figures in `lecture-assets/figures.R`. Write these as
  conventions, not as the history of this lecture.
- **`AGENTS.md`:** add a row to the status table: `Chapter_2/Lecture/` is a generated
  draft of 90 minutes of slides (33 slides) plus 40 minutes of live demos in three blocks
  with two breaks, both slides and script await review. Keep it to two or three lines.
  Update "Builds and packages" only if the build list changes in a way it describes.

## Checks and report

1. Render with `quarto render Chapter_2/Lecture/lecture.qmd --to revealjs` from the
   repository root, if Quarto is available. Look for warnings (missing images, MathJax).
   Never claim a render that did not run.
2. Check the checklist of `STYLE_GUIDE_LECTURE.md`, plus: the minutes in the script equal
   every `data-timing`; slide numbers in the script match the rendered slides; demo and
   discussion slides follow the rules above.
3. Report: files created and changed, which checks ran, which numbers were verified in R
   and which were not, any figure that looks poor at slide size, and whether `AGENTS.md`
   and `STYLE_GUIDE_LECTURE.md` were updated.
