# Chapter 2 lecture script: Probability distributions

Draft for the course author's review. **Target: 90 minutes of slides plus 40 minutes of
live demos in R and two breaks of 10 minutes, 150 minutes in total.** The slides take 85
minutes on 33 slides, including the questions and discussions below, and leave 5 minutes
of slack. The three live demos (12, 12 and 16 minutes) close the three blocks of the
lecture, and the breaks separate the blocks.

This script follows [Chapter 2 theory](../Theory.qmd), in its order, with a short
introduction to the [R practical](../Practicals/no_solution.qmd). The slides carry
keywords only; the narrative is here. The demos use the code chunks and the `Practice`
callouts of the chapter, so students follow along on the chapter page.

Slide 3 uses your diagram `ModelCycle.png` from the Chapter 1 lecture folder. Slides 8
(`binomial-four-faces.png`) and 28 (`salamander-counts.png`) use new figures, slides 16
(`normal-four-faces.png`) and 22 (`joint-density.png`) use unchanged copies of the
chapter figures `fig-four_faces_normal` and `fig-joint_density`, and slide 13 uses the
schematic `density-area.svg`. All are in `lecture-assets/`, and the code of the PNG
figures is in `lecture-assets/figures.R`. If the chapter figures change, run that script
again to refresh the copies.

## Timing and slide sequence

Times are measured from the start of the session and include the demos and the breaks.

| Slide | Topic | Minutes | Elapsed time |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis | 1 | 0–1 |
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
| 18 | Discussion: `d`, `p`, `q` or `r`? | 3 | 68–71 |
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

Slides 85 minutes, slack 5, live demos 40 (12 + 12 + 16), breaks 20: 150 minutes. The
`data-timing` of a demo slide includes its demo (780, 780 and 1020 seconds).

## Slides 1 and 2 — Ecological Models and Data Analysis; Overview of the lecture

In this lecture, we learn how to use probability distributions as the central pillar of
our statistical models. The session has three blocks, each closed by a live demo in R.

The first block is about counts: discrete random variables, what their probabilities
mean, the Binomial distribution and the four faces of a distribution, which is how we
calculate with a distribution in R. After the first demo there is a break.

The second block extends the same ideas to measurements, such as the flipper length of a
penguin. Here probability mass is replaced by probability density, which is the most
important distinction of the chapter. After the second demo there is another break.

The third block looks at several random variables together (joint and marginal
distributions and independence), at expectations (the mean and the variance), at how to
choose a distribution and at overdispersion. It ends with the third demo, the roadmap,
the practical and the summary.

Please have the Chapter 2 page open on your laptop: in the demos we run the code of the
chapter and try its practice exercises together.

## Slide 3 — Where we are: the modelling cycle

In Chapter 1 we split a statistical model into two parts: a response function, which
describes the expected response, and a probability distribution, which describes the
variation around it. This chapter is about the second part. It is the language that we
need for the model box of the cycle (the "distribution" with the red 2), and every later
chapter uses it.

Today there is no response function yet: the distributions describe observations under
one set of conditions. Response functions come in Chapters 5 and 6.

**Figure walkthrough**

Point to the model box and to "Distribution (2)". Do not walk through the whole cycle
again; one sentence that estimation (Chapters 3 and 4) needs a distribution is enough.

## Slide 4 — Random variables and support

A **random variable** is the quantity whose value is uncertain before we make that
observation. We will use a hypothetical experiment on seed survival to illustrate how to
model ecological count data. Suppose we randomly distribute several quadrats in a field
and in each of them we place four seeds of a target species. We come back after a fixed
period and count how many seeds survived in each quadrat. The random variable $X$ keeps
track of the possible counts, so it can take any integer value from 0 to 4.

The **support** of a random variable is the set of values that it can take. Here the
support is **finite**. In other cases there is no fixed maximum, such as the number of
spores or insects that could fall into a trap. Then we use random variables that can
take any non-negative integer value, $\{0, 1, 2, \ldots\}$, which is called **countably
infinite**. In practice the counts are always finite, but we do not have to say in
advance where they stop. A random variable is discrete when its support is finite or
countably infinite.

Note that $X$ does not record the seeds that survived in a particular quadrat: that is an
observation. The capital letter $X$ is the random variable and the lower-case $x$ is a
possible or observed value. This distinction looks fussy at first, but it keeps the model
and the data separate once we start estimating parameters in Chapters 3 and 4.

## Slide 5 — Probabilities of counts

A random variable has a probability distribution that assigns a value between 0 and 1 to
every possible observation and to every set of observations. The table is an example of
such an assignment for the four seeds (it is not yet a named distribution).

The probability of a set of values is the sum of the individual probabilities. For
example, the probability that at least three seeds survive is $P(X = 3) + P(X = 4) =
0.30 + 0.20 = 0.50$. The probability that any value occurs is the sum of all the
individual probabilities, and that sum must be 1. In the equation, $\forall x$ means "for
all possible values $x$".

**Short activity — included in the three minutes**

Ask the question on the slide and give students 20 seconds. Expected answer:
$P(X \leq 1) = P(X = 0) + P(X = 1) = 0.05 + 0.15 = 0.20$. If there is time, ask whether a
table with probabilities that add up to 1.10 could be a distribution (no; question 2 of
the chapter quiz).

## Slide 6 — What do these probabilities mean?

What does it mean to say that "the probability that 2 seeds survive is 0.30"? There are
two complementary perspectives, depending on how probability is applied.

**Epistemic** probability: if the goal is to predict the number of seeds that survive in
one specific quadrat, probability represents how certain we are about each possible
value. In the table, I would be twice as confident that the value is 2 than that it is 1.
This relates to how much knowledge we have about the system.

**Aleatoric** probability: probability can also represent the relative frequency with
which different counts occur across all possible replications of the same experiment or
observation protocol. This relates to errors in measurement and to stochasticity and
variability in ecological systems.

This course focuses on aleatoric probability as it is used by the frequentist
statistical paradigm. We use probabilities to model the relative frequencies of
observations and, from Chapter 3 onward, of parameter estimates.

**Optional remarks (the chapter's footnotes)**

Epistemic probability is sometimes called subjective probability, a name with an
unwarranted pejorative connotation; aleatoric probability is sometimes called objective
probability, which implies that the other is subjective. When we want to say something
about the uncertainty of predictions, we sometimes borrow ideas from the Bayesian
paradigm, which is common in practice. If you wish, add the chapter's recommendation:
for research focused on forecasting and uncertainty quantification, Michael Dietze's
*Ecological Forecasting* is the book to read.

## Slide 7 — The Binomial distribution

When the set of possible observations is large, we cannot keep a table. Instead, we use a
**probability mass function**: a formula that assigns a probability to every possible $x$.
From it we calculate the probability of any set of values by addition, and that is what
we call a **probability distribution**.

The oldest and most basic distribution for discrete data is the Binomial distribution,
published by Jacob Bernoulli in 1713 (*Ars Conjectandi*). It assumes a fixed number of
events, $n$; each event has one of two values, 0 or 1; and every event has the same
probability $p$ of the value 1. That fits the seeds: the event is whether a seed
survives (1) or not (0), and we assume that all seeds have the same probability of
survival. In the mass function, $n$ is the number of events and $p$ the probability of
the value 1; the binomial coefficient $\binom{n}{x}$ counts the ways of choosing which
$x$ of the $n$ seeds survive.

For four seeds with $p = 0.4$, the probability that exactly two survive is
$\binom{4}{2} \times 0.4^2 \times 0.6^2 = 6 \times 0.16 \times 0.36$, which is
approximately 0.35. We check this in R in the first demo.

**Optional remark**

The classic example is the number of heads in a fixed number of coin flips. Many texts
describe the Binomial in terms of "failures and successes"; the chapter avoids that
language because it has strange connotations for seeds and other organisms.

## Slide 8 — The four faces of a distribution

Every distribution has four functions that are related to each other. The chapter calls
them the four faces; that is your own term ("terminology that I completely made up"):
the probability mass, the cumulative probability, the quantile and the random sampler.

**Figure walkthrough — included in the four minutes**

The figure shows the four faces of the Binomial distribution with $n = 4$ and $p = 0.4$.

- Top left, the mass: the probability of each count. The dashed line marks 2 seeds, with
  a probability of 0.35.
- Top right, the cumulative probability: the masses up to and including 2 seeds are in
  full colour. Their sum, 0.82, is the probability that at most two seeds survive.
- Bottom left, the quantile function: it turns the question around. We give a cumulative
  probability (0.82) and get the count at which it is reached (2). The steps appear
  because the counts are discrete.
- Bottom right, the random sampler: the relative frequencies of 20 quadrats simulated
  from the model. They resemble the mass but do not match it exactly; how samples relate
  to their distributions is the topic of Chapter 3.

The next slide defines the cumulative probability and the quantile; slide 10 shows the
four functions in R.

## Slide 9 — Cumulative probability and quantiles

A **cumulative probability function**, $F_X$, adds the probability masses up to and
including a value $x$: $F_X(x) = P(X \leq x)$. For example, $F_X(3)$ is the probability
that at most three seeds survive. The cumulative probability is always between zero and
one and never decreases as $x$ increases. We will not use it much in this course; it is
the basis for calculating p-values, which the course ignores.

A **quantile function** is the inverse of the cumulative probability function: we give a
cumulative probability and ask at which value of $x$ it is reached. For a discrete
variable, the $\alpha$-quantile $q_\alpha$ is the smallest $x$ whose cumulative
probability reaches or exceeds $\alpha$. For the seeds, $F_X(2) \approx 0.82$, and the
median (the 0.5 quantile) is 2: the cumulative probability first reaches 0.5 at two
seeds, because $F_X(1) \approx 0.48$.

We use quantiles to describe a distribution (the median is the 0.5 quantile), as a
complement to the mean and the variance of slides 25 and 26. We will also use them to
quantify parameter uncertainty as confidence intervals in Chapter 3.

## Slide 10 — The four faces in R

In R, the four faces are implemented for each distribution, and the name of each
function is a prefix letter followed by a short name of the distribution: `dbinom()`,
`pbinom()`, `qbinom()` and `rbinom()` for the Binomial. The first argument is always the
same (`x` for the mass, `q` for the cumulative probability, `p` for the quantile, `n`
for the number of random values); the other arguments are the parameters (`size` is $n$
and `prob` is $p$).

We take these functions from the packages RTMB and RTMBdist, which provide the
distribution functions of the whole course, including some that base R lacks. We load
them once, RTMB first. Chapter 4 explains what else they do.

The fourth face is not so much a function as a procedure: a random sampler generates
possible observations that are compatible with the distribution. To simulate 10 quadrats,
we generate 10 random values from the Binomial distribution. We use random sampling
throughout the course and call it **simulation**: it is a versatile way to study the
statistical properties of a model that we fit to data.

**Transition**

Now we run these four lines and check the hand calculation of slide 7.

## Slide 11 — Live demo: discrete distributions

We now run the code of the first part of the chapter. Open the section "The four faces
of a distribution" and run the chunks with me.

**Live demo (12 minutes)**

1. **Load the packages (1 minute).** Run the chunk with `library(RTMB)` and
   `library(RTMBdist)`. Say once that RTMB comes first, and nothing more about the
   packages.
2. **The four faces (3 minutes).** Run the chunk with `seed_survival_probability`,
   `seed_count` and the four `*binom()` calls. Point out that `dbinom()` returns about
   0.35 (slide 7), `pbinom()` about 0.82 and `qbinom()` 2 (slide 9), and that `rbinom()`
   returns ten counts between 0 and 4. Run the `rbinom()` line again: the counts change.
3. **Check $P(X = 2)$ by hand (1 minute).** The chapter has no chunk for this; type:

   ```r
   choose(4, 2) * 0.4^2 * 0.6^2
   dbinom(x = 2, size = 4, prob = 0.4)
   ```

   Both give 0.3456.
4. **Seeds (2 minutes); by minute 5, start here.** Explain from the chapter's two
   paragraphs that R uses a deterministic algorithm that produces a **pseudo-random
   sequence**, and that a **seed** sets its starting state. Run `set.seed(42)` followed
   by the `rbinom()` line twice, then the pair again: the same seed gives the same
   counts. Set the seed once at the start of a script or before a simulation.
5. **Practice: orchid fruit set (5 minutes); by minute 7, start here.** Give students 2
   minutes to try questions 1 to 5 of the callout, then solve it live with the chunk of
   the solution. Point out the answers: the support is 0 to 6; `dbinom()` gives about
   0.23 and `pbinom()` about 0.89; the 0.75 quantile is 4, although the cumulative
   probability at 4 is 0.89, because the counts are discrete (the cumulative probability
   jumps from about 0.66 at 3 flowers to 0.89 at 4). The second probability means that
   across many repetitions of the six-flower unit, 89% have at most four flowers with
   fruit.

**If the demo runs late**

Skip step 3 (the number was already shown on slide 7), and solve the orchid practice
live without the student attempt.

Break (10 minutes).

## Slide 12 — Continuous random variables

A **continuous random variable** can take any value within an interval of the real
numbers, so its support is an interval (all positive numbers, or all numbers between 0
and 1) and its values cannot be listed one by one. We use continuous random variables for
measurements such as height, body mass, leaf area or vegetation cover.

Our example is the flipper length of Gentoo penguins (*Pygoscelis papua*). The data are
measurements of 124 adult Gentoo penguins near Palmer Station, Antarctica (Gorman,
Williams and Fraser 2014); one has no measurements, which leaves 123. They are part of
the data set `penguins`, which is built into R 4.5.0 and later (with an older version of
R, use the package `palmerpenguins`).

Let $X$ be the flipper length in millimetres. Between 217 mm and 218 mm there are
infinitely many other lengths (217.5 mm, 217.25 mm, 217.137 mm and so on), so we cannot
build a table of probabilities as we did for the seeds. In practice every instrument has
a finite precision: the flipper lengths are recorded to the nearest millimetre, so a
record of 217 mm stands for any length between 216.5 mm and 217.5 mm. We still treat
flipper length as continuous, because the rounding interval is small compared with the
variation among penguins.

**Short activity — included in the three minutes**

Ask the question on the slide (the chapter's "Practice: measuring a flipper"). Expected
answers: lengths between 220.5 mm and 221.5 mm are recorded as 221 mm; under a
continuous distribution $P(X = 221) = 0$, but the interval from 220.5 to 221.5 mm has a
positive probability. The next slide explains why.

## Slide 13 — Probability density

With a discrete random variable we could give a probability to every value and add them.
For a continuous random variable this breaks down: between any two values there are
infinitely many others, and adding positive probabilities for all of them would give an
infinite sum for any interval, however small. The probability of a single value is
therefore zero, which on its own is rather useless.

So instead of the probability of a value, we calculate the probability that $X$ falls in
an interval, such as $P(210 < X \leq 220)$. These probabilities come from a **probability
density function**, $f_X(x)$, which plays a similar role to the probability mass
function. The probability of an interval is the integral of the density over that
interval; in plain English, it is the area under the density curve between $a$ and $b$,
the shaded area of the schematic. For these areas to be probabilities, the density
cannot be negative and the total area under the curve must be 1.

Because a single value has a probability of zero, it does not matter whether the
endpoints of an interval are included: $P(a < X \leq b)$, $P(a \leq X \leq b)$ and
$P(a < X < b)$ are the same.

**Optional remark (the chapter's footnote)**

The chapter admits to waving its hands here: the formal mathematics of continuous
probability involves measure theory and the Lebesgue measure, which we do not need for
our work as ecologists. If you wish, repeat the chapter's own words: "I understand if you
are struggling to build an intuition that makes sense, I do too."

## Slide 14 — The Normal distribution

As with discrete data, there are many continuous distributions, and we represent each by
its probability density function. The example of this chapter is the Normal
distribution. In its density, $\mu$ is the mean, which sets the centre of the
distribution, and $\sigma > 0$ is the standard deviation, which sets its spread; slides 25
and 26 define the mean and the standard deviation.

We assume that the flipper length of the penguins follows a Normal distribution with
$\mu = 217$ mm and $\sigma = 6.5$ mm. These are rounded values that describe the 123
measured lengths well (slide 16 shows the comparison). How such values are obtained from
a sample is the topic of Chapter 3. The Normal distribution allows any real value, but
with these parameters the probability of a negative length is negligible.

## Slide 15 — Mass and density

For a discrete distribution, the `d*` functions in R return a probability mass; for a
continuous distribution they return a probability density. These are different
quantities that are easily confused. A probability mass is a probability: it is at most
1, and probabilities of sets of values are sums. A density has units of 1 over the units
of $X$: probabilities of intervals are integrals, and the density itself can be larger
than 1.

A density is a probability per unit of $X$. The density of the flipper model at 217 mm
is approximately 0.0614/mm. This is not the probability that a flipper is exactly 217 mm
long, which is zero. However, the density times the width of a narrow interval
approximates the probability of that interval: the probability of a length between
216.5 mm and 217.5 mm (a record of 217 mm) is approximately $0.0614 \times 1 \approx
0.061$.

If we express the same model in centimetres ($\mu = 21.7$ cm, $\sigma = 0.65$ cm), the
density at the mean is ten times larger, approximately 0.614/cm, because the same
probability is spread over ten times fewer units. The probability of the interval does
not change: 216.5 mm to 217.5 mm is 0.1 cm wide, and $0.614 \times 0.1 \approx 0.061$.

**Short activity — included in the three minutes**

Ask the question on the slide. Expected answer: yes. In metres ($\mu = 0.217$ m,
$\sigma = 0.0065$ m) the density at the mean is approximately 61.4/m. This is the
misconception to remove: the value returned by `dnorm()` is not a probability.

## Slide 16 — The four faces of the Normal distribution

A continuous distribution has the same four faces, with a probability density in place
of the probability mass. In R they are `dnorm()`, `pnorm()`, `qnorm()` and `rnorm()`,
with the arguments `mean` ($\mu$) and `sd` ($\sigma$).

**Figure walkthrough — included in the four minutes**

The figure is a copy of the chapter figure.

- Top left, the density: the shaded area between 210.5 and 223.5 mm (one standard
  deviation either side of the mean) is a probability, 0.68.
- Top right, the cumulative probability: the same definition as before,
  $F_X(x) = P(X \leq x)$, but calculated as an integral of the density. It increases
  smoothly, with no steps. The dashed lines read off $F_X(223.5) \approx 0.84$.
- Bottom left, the quantile function: the inverse of the curve above. For a continuous
  distribution the inverse is exact, so the $\alpha$-quantile is the value for which
  $F_X(q_\alpha) = \alpha$, without the "smallest $x$" rule of the discrete case.
- Bottom right: in place of a simulated sample, the histogram of the 123 measured flipper
  lengths with the model density. Continuous values are not expected to repeat (the
  measured ones do only because they were rounded), so we group them into intervals. The
  histogram is scaled as a density so that it is comparable with the curve. Histograms
  and other summaries of samples are the topic of Chapter 3.

## Slide 17 — Intervals and tails in R

We use cumulative probabilities more often with continuous distributions, because they
give the probability of an interval without our calculating any integral: we subtract
two cumulative probabilities.

The first line of the chunk gives the probability of a length between 210.5 and 223.5 mm,
within one standard deviation of the mean: the model assigns about two thirds of the
penguins to that interval. For lengths above 230 mm we need the upper tail,
$P(X > 230) = 1 - F_X(230)$, which `pnorm()` calculates with `lower.tail = FALSE`: under
the model, about 2% of the flippers are longer than 230 mm. The last line is the 0.95
quantile: the model assigns a probability of 0.95 to lengths below 227.7 mm.

The numbers are in the comments of the chunk; students calculate them in the second demo.

## Slide 18 — Discussion: `d`, `p`, `q` or `r`?

This discussion checks that students can match a question to one of the four faces before
they use them in the demo.

**Discussion and expected answers — included in the three minutes**

Give students one minute, then take one answer per item.

1. `d`: the probability of one count of a discrete variable, `dbinom(x = 2, size = 4,
   prob = 0.4)`.
2. `p`, twice: the difference of two cumulative probabilities, `pnorm(q = 220, ...) -
   pnorm(q = 210, ...)` (question 5 of the chapter quiz). Students who answer `d` have
   the misconception of slide 15.
3. `q`: the 0.95 quantile, `qnorm(p = 0.95, ...)`.
4. `r`: a simulation of 20 quadrats, `rbinom(n = 20, size = 4, prob = 0.4)`.

## Slide 19 — Live demo: continuous distributions

We now run the continuous part of the chapter. Open the sections "Mass and density" and
"The four faces of a continuous distribution".

**Live demo (12 minutes)**

1. **The penguin data (2 minutes).** Run the chunk that loads `penguins`, keeps the Gentoo
   penguins and removes the one without a flipper length (section "Continuous probability
   distributions"). Point out the output: one missing value and 123 penguins. With R older
   than 4.5.0 the data set is missing; students then follow on the page.
2. **Density in mm and in cm (2 minutes).** Run the two `dnorm()` chunks of "Mass and
   density": 0.0614 and 0.614. Ask what the value in metres would be (61.4).
3. **Intervals, tails and quantiles (3 minutes); by minute 4, start here.** Run the
   `pnorm()` difference (0.68), the chunk with `lower.tail = FALSE` (0.023) and type
   `qnorm(p = 0.95, mean = 217, sd = 6.5)` (227.7 mm), which the chapter gives in the
   text. Point out that the first argument of `pnorm()` is a length and of `qnorm()` a
   probability.
4. **Practice: measuring a flipper (1 minute).** Recall the answer from slide 12; no code.
5. **Practice: a flipper length threshold (4 minutes); by minute 8, start here.** Give
   students 1 to 2 minutes to try it, then run the chunk of the solution. The probability
   of a length above 225 mm is approximately 0.109 (about 11%); the length that marks the
   lower 10% is approximately 208.7 mm. Ask students to say each result in words.

**If the demo runs late**

Skip step 1 by saying that the data are loaded as in the chapter (no later step needs
them), and skip step 4.

Break (10 minutes).

## Slide 20 — Joint and marginal distributions

So far we had one random variable at a time. Many questions involve several: two seeds,
two measurements on the same penguin, many quadrats in one study. To say when random
variables are independent, we first need joint distributions.

Consider the germination of two planted seeds. $X_1$ and $X_2$ record whether each seed
germinates (1) or not (0) after a fixed period. The **joint distribution** of $X_1$ and
$X_2$ assigns a probability to every combination of their values (the product space of
$X_1$ and $X_2$). On the slide, $P(0, 0)$ is short for $P(X_1 = 0, X_2 = 0)$, the
probability that neither seed germinates, and $P(1, 0)$ is the probability that only the
first seed germinates.

The distributions of $X_1$ and $X_2$ on their own are the **marginal distributions**,
because we recover them by adding over the rows or the columns and writing the sums in
the margins of the table. The marginal distribution of $X_2$ describes the second seed
regardless of what happens to the first: by the rule of addition, we add all the joint
probabilities in which the second seed germinates.

## Slide 21 — Independence

Two random variables are **independent** if knowing the value of one does not change the
probabilities for the other. Then the probability of any combination is the product of
the marginal probabilities, as in the equation.

With $P(X_1 = 1) = 0.6$ and $P(X_2 = 1) = 0.3$, the table fills in: for example, the
probability that neither seed germinates is $0.4 \times 0.7 = 0.28$. The margins add up
to the marginal probabilities, and the whole table to 1.

Independence is an assumption of the model. It is not guaranteed because observations
were collected at different locations or times. Chapter 7 shows how to relax it.

**Short activity — included in the three minutes**

Ask the question on the slide and take two answers. Expected answers (from the chapter):
the seeds share a parent plant, a soil patch, a drought or a hungry herbivore. In
general, lack of independence arises through spatial clustering, shared weather,
competition or repeated measurements of the same individual.

## Slide 22 — The joint distribution of two measurements

Joint distribution, marginal distribution and independence also apply to continuous
random variables, with densities in place of probabilities and integrals in place of
sums. The joint density is a surface over all combinations of the two values, and the
probability of a region is the volume under that surface. The marginal density of one
variable is obtained by integrating the joint density over the other, the continuous
version of adding over a row. Two continuous variables are independent if their joint
density is the product of their marginal densities.

The example uses the flipper length ($X$, in mm) and the body mass ($Y$, in g) of the
same 123 penguins. The marginal distributions are Normal: flipper length as before, and
body mass with a mean of 5100 g and a standard deviation of 500 g. For the joint
distribution we use a bivariate Normal distribution, which has one more parameter, the
**correlation**, which controls how strongly the two variables change together. We set
it to 0.7, so that penguins with long flippers also tend to be heavy. As before, these
are rounded values that describe the measurements well. For the bivariate Normal, a
correlation of zero means independence; this is not true for other distributions.

**Figure walkthrough — included in the three minutes**

The figure is a copy of the chapter figure. The blue points are the 123 penguins and the
vermillion lines are contours of the joint density: each joins combinations with the same
density, like the contour lines of a topographic map join places of equal elevation. The
contours are tilted, because a long flipper with a large mass has a higher density than a
long flipper with a small mass. Without correlation the contours would not be tilted.

Each marginal distribution is symmetric around its mean, so the probability of a flipper
longer than 217 mm is 0.5, and of a mass above 5100 g also 0.5. If the two were
independent, the probability of being above both means would be $0.5 \times 0.5 = 0.25$.
With a correlation of 0.7 it is approximately 0.37, because long flippers and large body
masses tend to occur together.

## Slide 23 — Independent and identically distributed

We often make a stronger working assumption: observations are both independent and
**identically distributed**, meaning that each follows the same probability
distribution. We call this **independent and identically distributed (i.i.d.)**. When we
take repeated observations of what we consider the same ecological phenomenon, we treat
them as i.i.d. The random samples generated by functions such as `rbinom()` are i.i.d.

Back to the two seeds: if they are of the same species and origin, treated in the same
way and buried in the same soil, we have no reason to believe that one is more likely to
germinate than the other, so we treat them as identically distributed. Independence is
a separate assumption that does not follow from the seeds being alike: the conditions
that they share can make their outcomes more alike (the causes of slide 21). With
$P(X_1 = 1) = P(X_2 = 1) = 0.3$ the joint probabilities are 0.49 (neither germinates),
0.21 and 0.21 (one of the two) and 0.09 (both).

The i.i.d. assumption is the basis of the estimation methods of Chapters 3 and 4.

## Slide 24 — Discussion: joint, marginal or independent?

This discussion applies the terms of slides 20 to 23 to ecological cases.

**Discussion and expected answers — included in the three minutes**

Give students one minute, then take one answer per item.

1. **Marginal:** the distribution of body mass regardless of flipper length (question 8
   of the chapter quiz).
2. **Joint:** a probability for a combination of both measurements needs the joint
   distribution.
3. **Independence doubtful:** under independence the probability of a pair of outcomes is
   the product of the separate probabilities, but shared weather or soil can make the
   two trees dependent (question 7 of the quiz).
4. **i.i.d. as a simplification:** the four visits share the conditions of the site, so
   independence is doubtful. The chapter treats the salamander counts this way (slide 28)
   and Chapter 7 deals with grouped observations.

## Slide 25 — Expectations and the mean

An **expectation** is a probability-weighted average of any quantity calculated from a
random variable. For a function $f(X)$, we multiply each value $f(x)$ by its probability
and add. For a continuous random variable we use an integral with the density instead of
the sum; note that $f$ is the function that we take the expectation of, and $f_X$ is the
density.

The **mean** of a distribution, $\mu$ or $E[X]$, also called the **expected value**, is
the expectation of $X$ itself, $f(X) = X$: the sum of each value times its probability.
For the seed model with $n = 4$ and $p = 0.4$, the mean is 1.6 seeds.

The mean is a property of the distribution and need not be a possible observation: no
quadrat can contain 1.6 surviving seeds. It describes the long-run average across many
comparable quadrats under the model.

## Slide 26 — Variance and standard deviation

The **variance** is the expectation of $(X - E[X])^2$, the expected squared distance from
the mean. It measures how widely a distribution spreads its probability; for two
distributions with comparable means, a smaller variance means that the values are more
concentrated near the mean. The **standard deviation** is its square root and has the
units of $X$, which usually makes it easier to interpret.

For the flipper model, integrating gives a mean of 217 mm and a variance of 42.25 mm², so
a standard deviation of 6.5 mm. These are the values of $\mu$ and $\sigma$ that we used
to define the model, because the parameters of the Normal distribution are its mean and
standard deviation. For most other distributions the mean and the variance are functions
of the parameters: the seed model has a mean of 1.6 and a variance of 0.96, and neither
is one of its parameters ($n = 4$ and $p = 0.4$).

The variance is an example of a **central moment**, the expectation of the $k$th power of
the distance from the mean (the variance is $k = 2$). Two standardised quantities come
from central moments: the **skewness**, which is zero for a symmetric distribution, and
the **kurtosis**, which measures how thick the tails are and is often reported as excess
kurtosis relative to the Normal distribution.

## Slide 27 — Choosing a distribution

In all the count examples we used the Binomial distribution, and the examples were
chosen to suit it. There are many other distributions for counts, each with its own
properties, such as how the mean and the variance are related. When the count has a
fixed upper limit (four seeds), the Binomial is the starting point; when it has none
(insects in a trap), the Poisson and the Negative Binomial are.

The same holds for continuous data. The supplement classifies continuous distributions by
the values that the random variable can take: **unconstrained** (any real value, the
Normal), **positive** (any value above zero, the LogNormal, for example for body mass) and
**constrained** (any value within a range, the Beta, for example for vegetation cover).

There is no correct distribution for a sample of data. The type and range of the values,
the mean–variance relationship and how well a distribution describes the data give us
plausible candidates, and often more than one remains. Ecological interpretation helps,
but a distribution is not restricted to the process from which it was first derived.
Formal methods to compare candidates come in Chapter 4 (AIC) and Chapter 6.

Students should read at least the supplement entries for the Binomial, Poisson, Negative
Binomial, Normal, LogNormal and Beta distributions; the practical uses them.

## Slide 28 — Overdispersion

The Poisson distribution is the common starting point when we count events in a fixed
unit of time, area or sampling effort (insects per trap-night, seedlings per quadrat),
so that there is no upper limit. It has one parameter, $\lambda$, the expected count per
sampling unit, and its mean and variance both equal $\lambda$. When the variance is
larger than the mean, we say that the data are **overdispersed** relative to the Poisson
distribution (the reference is often left implicit).

A first exploratory check is the **dispersion ratio**, the sample variance divided by the
sample mean. If the observations are reasonably described as independent Poisson counts
with the same mean, the two tend to be similar and the ratio is close to one; a much
larger ratio suggests overdispersion. A ratio well below one (underdispersion) is
possible but rare. For convenience we use `var()`; Chapter 3 explains how it differs from
the variance of a sample.

The example uses counts of salamanders from Price, Muncy, Bonner, Drayer and Barton
(2016), "Effects of mountaintop removal mining and valley filling on the occupancy and
abundance of stream salamanders", *Journal of Applied Ecology* 53, 459–468. They visited
23 stream sites four times each. We use the counts of the spring salamander
(*Gyrinophilus porphyriticus*, code `GP`) at the 12 sites not affected by mining: 48
counts, from the data set `Salamanders` of the package `glmmTMB`. Treating them as i.i.d.
is a simplification, because the four visits to a site share its conditions (Chapter 7).

**Figure walkthrough — included in the three minutes**

The grey bars are the relative frequencies of the 48 counts and the vermillion stems are a
Poisson distribution with the same mean (2.21). The counts have more zeros and more large
counts (6, 7 and 10 salamanders) than the Poisson allows, and fewer intermediate counts.
The mean is 2.21 and the variance 4.98, so the ratio is about 2.3: the variance is more
than twice that of a Poisson model with the same mean. The figure does not show a fitted
alternative; fitting comes in Chapter 4.

## Slide 29 — Distributions for overdispersed counts

When a sample is overdispersed, we need a distribution with an extra parameter that
controls the extra variation. The Negative Binomial distribution is the usual starting
model for counts without an upper limit. It has a mean $\mu$ and a shape $k$, and its
variance is $\mu + \mu^2/k$. The smaller $k$, the larger the variance; as $k$ becomes
large the distribution approaches the Poisson. (R calls the shape `size`.) It is a
candidate model for the salamander counts.

When a count has a fixed upper limit, overdispersion is defined relative to the Binomial,
and the Beta-Binomial plays the role that the Negative Binomial plays for the Poisson.
The Conway–Maxwell–Poisson distribution can describe both overdispersion and
underdispersion. All three are in the supplement.

**Short activity — included in the two minutes**

Ask the question on the slide and take two or three answers. Expected answers: habitat
differences among sites, clustering of salamanders, variation in detection between
visits, and dependence among repeated visits to the same site. Then say the caveat once:
overdispersion is a statistical description. The ratio tells us that the counts vary more
than a Poisson model allows; it does not identify the ecological cause. If the sources
could be identified and measured, the models of Chapter 7 could include them.

## Slide 30 — Live demo: expectations and overdispersion

The last demo calculates expectations as sums and integrals and the dispersion ratio of
the salamanders. Open the sections "Expectations and central moments" and
"Overdispersion".

**Live demo (16 minutes)**

1. **Mean and variance of the seed model (3 minutes).** Run the chunk that calculates
   `expected_value` (1.6) and then the variance chunk (0.96). Point out that each is a
   sum of values times probabilities, the equations of slides 25 and 26.
2. **Mean and variance of the flipper model (4 minutes); by minute 3, start here.** Run
   the two `integrate()` chunks (217 mm and 42.25 mm²). Explain the arguments `f`,
   `lower` and `upper` and the element `value`. Explain why the limits are 150 and
   280 mm: with infinite limits, `integrate()` evaluates the function at points spread
   over the whole real line and can miss a narrow peak far from zero; for this model it
   returns a value close to zero without a warning. If time allows, show it with
   `lower = -Inf, upper = Inf` (the mean comes out as practically 0 instead of 217 mm).
3. **The dispersion ratio (3 minutes); by minute 7, start here.** Run the two chunks of
   "A simple diagnostic for overdispersion": 48 counts, then the mean (2.21), the variance
   (4.98) and the ratio (about 2.3). Recall the caveat of slide 29 in one sentence.
4. **Practice: fruit set on orchid plants (5 minutes); by minute 10, start here.** Give
   students 2 minutes to try it, then run the chunk of the solution: a mean of 9.6 and a
   variance of 3.84 fruits. For question 3, flowers on the same plant may share
   physiological conditions or pollinator visits.
5. **Practice: variation in orchid stem counts (1 minute), if time allows.** The ratio is
   $12/3 = 4$: more variation than a Poisson model with the same mean, and the ratio
   alone cannot identify the cause.

**If the demo runs late**

Drop step 5 first, then the infinite-limits illustration of step 2. Keep step 3.

## Slide 31 — Course roadmap: from distributions to estimates

In this chapter the parameters were known, and we calculated the probabilities of
possible observations. Chapter 3 reverses the direction of the question: we have a sample
and want to learn about unknown parameters, so we study how samples and estimates vary.
Chapter 4 introduces maximum likelihood, with the uncertainty of the estimates and a first
comparison of models.

## Slide 32 — The Chapter 2 R practical

The practical has six exercises. The first two are worked examples on the page, one
discrete (the survival of 25 seedlings under a Binomial model) and one continuous (the
bill length of Chinstrap penguins under a Normal model); work through them before trying
the rest. Exercise 3 checks the insect counts of `InsectSprays` for overdispersion,
pooled and by spray. Exercises 4 to 6 use the Negative Binomial (quadrat counts), the
LogNormal (body mass) and the Beta (vegetation cover) distributions.

Read the supplement entries for these distributions first: they give the mass or density
function, the mean, the variance and the R functions that the exercises need. Try each
exercise before checking the solution.

## Slide 33 — Summary and closing questions

Go back to slide 3 and point to the distribution in the model box again; no new slide is
needed. A random variable keeps track of the possible values of an observation, and a
distribution assigns probabilities to all sets of those values. Discrete distributions
have a probability mass, continuous distributions a density, which is a probability per
unit and not the probability of a value. Every distribution has four faces, which R
implements with the prefixes `d`, `p`, `q` and `r`. Independence and the stronger i.i.d.
assumption are assumptions of the model, and they are the basis of estimation. The mean
and the variance are expectations. We choose a distribution by the type and range of the
values and the mean–variance relationship, and overdispersion tells us when the Poisson
is not enough.

Return to this slide for the two closing questions.

**Discussion and expected answers — allow about two minutes**

Question 1: `dnorm()` returns a density, a probability per millimetre. The probability of
any exact length is zero; the probability of a record of 217 mm is the area over the
interval from 216.5 to 217.5 mm, approximately $0.0614 \times 1 \approx 0.061$. The
density value also changes with the units.

Question 2: the variance of the counts is more than twice that of a Poisson model with
the same mean, so the counts are overdispersed relative to the Poisson, and a
distribution such as the Negative Binomial is a candidate. The ratio does not tell us why
(habitat, clustering, detection or dependence), and it is an exploratory check, not a
fitted model.

**Final transition**

The next steps are the practical and Chapter 3, where we turn the question around and use
samples to learn about the parameters.

## Adjustments during delivery

The slides take 85 minutes and leave 5 minutes of slack, which comes last. If discussion
overruns, use the slack first, then shorten in this order:

- Slide 6 to one sentence (aleatoric probability, as relative frequencies): recovers
  about one and a half minutes.
- Slide 23 merged into speech on slide 21 (one sentence on i.i.d., skip the table of
  numbers): about one and a half minutes.
- Slide 31 to one sentence (Chapter 3 reverses the question): about one and a half
  minutes.
- The second `Practice` callout of Demo 3 (orchid stem counts): one minute; the other
  demo cuts are listed in each demo section.

Keep the explanations of mass against density (slides 13 and 15), independence as an
assumption (slide 21) and the dispersion ratio as a description that does not identify a
cause (slides 28 and 29).

The breaks are placed after the first and the second demo (minutes 38 and 84). If a demo
runs over, shorten the demo rather than the following break, and catch up with the
adjustments above.
