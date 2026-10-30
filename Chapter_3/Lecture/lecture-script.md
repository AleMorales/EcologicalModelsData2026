# Chapter 3 lecture script: From samples to estimates

Draft for the course author's review. **Target: 150 minutes in total, with 125 minutes of
slides on 34 slides (including the questions and discussions below), 5 minutes of slack and
two breaks of 10 minutes.** The breaks separate the three blocks of the lecture. There are
no live demos: whether to run code is decided during the lecture according to the time
left, and "Adjustments during delivery" lists the chunks that fit.

This script follows [Chapter 3 theory](../Theory.qmd), in its order, with a short
introduction to the [R practical](../Practicals/no_solution.qmd). The slides carry
keywords only; the narrative is here.

Slides 3 and 4 use your diagrams `ModelCycle.png` and `Estimation.png` from the Chapter 1
lecture folder. Slide 17 uses the schematic `hypothetical-samples.svg`. Slides 8
(`relative-frequency-convergence.png`), 9 (`fir-empirical-distribution.png`), 12
(`histogram-density.png`), 13 (`fig-ecdf_normal-1.png`), 19 (`sampling-distribution.png`),
26 (`dance-ci.png`) and 30 (`asymptotic-normality.png`) use copies of the chapter figures
`fig-relative-frequency-convergence`, `fig-ecdf`, `fig-histogram_density`,
`fig-ecdf_normal`, `fig-sampling_distribution`, `fig-dance_ci` and
`fig-asymptotic_normality`. All are in `lecture-assets/`, and the code of the PNG figures,
except the one of slide 13, is in `lecture-assets/figures.R`. If the chapter figures change,
run that script again and replace the copy of slide 13 by hand.

## Timing and slide sequence

Times are measured from the start of the session and include the breaks.

| Slide | Topic | Minutes | Elapsed time |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | From data to estimates | 2 | 4–6 |
| 5 | Samples and distributions | 4 | 6–10 |
| 6 | From frequency to probability | 5 | 10–15 |
| 7 | Relative frequencies in R | 3 | 15–18 |
| 8 | The law of large numbers | 5 | 18–23 |
| 9 | The empirical distribution | 4 | 23–27 |
| 10 | Summaries of a sample | 5 | 27–32 |
| 11 | Samples of continuous measurements | 3 | 32–35 |
| 12 | Density-scaled histograms | 6 | 35–41 |
| 13 | The empirical cumulative distribution | 3 | 41–44 |
| | Break | 10 | 44–54 |
| 14 | Parameters, estimators and estimates | 4 | 54–58 |
| 15 | The method of moments | 4 | 58–62 |
| 16 | Discussion: parameter, estimator or estimate? | 4 | 62–66 |
| 17 | The sampling distribution | 6 | 66–72 |
| 18 | Hypothetical samples in R | 3 | 72–75 |
| 19 | A simulated sampling distribution | 3 | 75–78 |
| 20 | Bias and variance | 6 | 78–84 |
| 21 | Mean squared error | 3 | 84–87 |
| 22 | Standard errors | 5 | 87–92 |
| 23 | Discussion: standard deviation or standard error? | 4 | 92–96 |
| | Break | 10 | 96–106 |
| 24 | Confidence intervals | 4 | 106–110 |
| 25 | Wald interval in R | 2 | 110–112 |
| 26 | The dance of the confidence intervals | 5 | 112–117 |
| 27 | Coverage checked by simulation | 4 | 117–121 |
| 28 | Estimation of two parameters | 5 | 121–126 |
| 29 | Consistency | 3 | 126–129 |
| 30 | Asymptotic normality | 5 | 129–134 |
| 31 | Discussion: empirical or sampling distribution? | 3 | 134–137 |
| 32 | Course roadmap: from samples to response curves | 2 | 137–139 |
| 33 | The Chapter 3 R practical | 2 | 139–141 |
| 34 | Summary and closing questions | 4 | 141–145 |
| | Slack for discussion | 5 | 145–150 |
| | **Total** | **150** | |

Slides 125 minutes (blocks of 44, 42 and 39), slack 5, breaks 20: 150 minutes.

## Slides 1 and 2 — Ecological Models and Data Analysis; Overview of the lecture

In this lecture, we learn how to relate samples of data to probability distributions and
how to use a sample to estimate the parameters of a model. The session has three blocks,
separated by two breaks.

The first block is about samples: how the relative frequencies of a sample of counts relate
to the probabilities of a model, and how we describe a sample of continuous measurements
with histograms and cumulative distributions.

The second block turns the question around. We define parameters, estimators and estimates,
calculate a first estimate with the method of moments, and ask how much that estimate would
change with another sample. That leads to the sampling distribution, bias,
variance, mean squared error and standard errors.

The third block covers confidence intervals and their coverage, the estimation of two
parameters, and what happens to estimators as the sample grows. It ends with the roadmap,
the practical and the summary.

The slides show only part of the code. The calculations are all on the Chapter 3 page, where
you can run them yourselves.

## Slides 3 and 4 — Where we are: the modelling cycle; From data to estimates

In Chapter 2 we chose the parameters of a distribution and calculated probabilities from
them: the distribution in the model box of the cycle. This chapter is the first step of
estimation: "confidence intervals (3)" in the estimation box. Chapter 4 continues with the
likelihood.

On slide 4, the diagram from Chapter 1. In Chapter 2 we went from parameters to data: the
parameters were known and we calculated the probabilities of possible observations. In
research we face the reverse problem: we have a limited sample of observations and want to
learn about the parameters of the model that we use to describe them. The dashed arrow
from the estimates to the parameters is the relationship that this lecture makes precise:
how close an estimate is likely to be to the parameter, and how we express that.

**Delivery**

One minute on slide 3 and two on slide 4. On slide 3, point to "Confidence intervals (3)" only; do not
walk through the cycle again. On slide 4, point to the dashed arrow from the estimates to
the parameters.

## Slide 5 — Samples and distributions

In research we collect limited, often noisy samples of data and want to generalise from
them to the broader context in which they were collected. As discussed in Chapter 1, we use
statistical models as approximations of the data generating process. This means that we
treat the observations that we collect as if they were random samples from our
statistical model. For example, we might want to learn about the density of tree seedlings
in a forest while counting them only in some quadrats. To make that connection, we need
assumptions about how the quadrats were selected and how their counts vary from quadrat to
quadrat, and we describe that variation with a distribution that is (at least
qualitatively) compatible with the process.

The example of the chapter is a set of counts of balsam fir seedlings in 50 quadrats of
five by five feet, laid out in a grid of five rows of ten quadrats (Davison and Hinkley
1997, *Bootstrap Methods and Their Application*, Cambridge University Press). The data come
with R, as the data set `fir` of the package `boot`. The number of seedlings in a quadrat
has no fixed upper limit, so we use a Poisson distribution with a mean of 2.14 seedlings
per quadrat. That value is the mean of the 50 counts; slide 15 explains why it is a
reasonable value for the parameter. A Poisson distribution assigns a probability to every
count, however large, but with this mean the probability of more than eight seedlings in a
quadrat is below 0.001, so the comparisons stop at eight.

We treat the 50 counts as independent and identically distributed (i.i.d.). Neighbouring
quadrats of a grid may be more alike than distant ones, so this is a simplification; models
for observations that are not independent are the subject of Chapter 7.

## Slide 6 — From frequency to probability

For a sample of counts, the **relative frequency** of a value is the number of times it
appears divided by the sample size. The table puts the relative frequencies of the 50
quadrats beside the probabilities of the Poisson model. No quadrat has six or eight
seedlings. The relative frequencies lie between zero and one and sum to one, like
probabilities.

The two rows are similar, but they are not equal. For small samples, relative frequencies
and model probabilities can differ greatly; the next slides show what happens as the
sample grows.

**Short activity — included in the five minutes**

Ask the question on the slide and take two answers. Expected answers: part of the difference
is sampling variation. Even if the model were an exact description of the data generating
process, a sample of 50 quadrats would not reproduce its probabilities; another 50 quadrats
would give other frequencies. The other part is that the Poisson model is an approximation
of the process that produced the counts (and the quadrats may not be independent). From one
sample we cannot tell how much of the difference is due to each.

## Slide 7 — Relative frequencies in R

These are the chunks of the chapter that produce the table of slide 6. `data()` loads the
data set from the package `boot`, and the counts are the column `count`. `table()` counts
how often each value appears. Some possible counts may be absent from a sample, and
`table()` would then leave them out; setting the values from zero to eight as `factor()`
levels makes `table()` include those counts with frequency zero. Dividing by the number of
quadrats gives the relative frequencies, and `dpois()` gives the model probabilities for
the same counts.

As in Chapter 2, the distribution functions come from the packages RTMB and RTMBdist, which
the chapter loads once, RTMB first.

## Slide 8 — The law of large numbers

For i.i.d. observations, the relative frequency of each count approaches its model
probability as the sample size grows. This result is known as the **law of large numbers**.
It is a statement about probabilities and not about every sample: as the sample grows, a
large difference between the relative frequency and the model probability becomes less and
less likely, but a larger realised sample need not be closer to the model probability than
every smaller realised sample.

With real data we cannot make the sample larger, but in a simulation we can. The chapter
simulates one sample of each size from 10 to 100,000 quadrats with seed 123. One sequence
of samples cannot show convergence directly: in that table,
for example, the relative frequency of two seedlings is closer to the model probability at
100 quadrats than at 10,000. To show what usually changes with sample size, the figure
repeats the simulation 100 times at each size.

**Figure walkthrough — included in the five minutes**

The figure is a copy of the chapter figure. Each grey point is the relative frequency of
exactly three seedlings in one simulated sample; the horizontal axis is the sample size on
a logarithmic scale, and the vermillion line is the probability of three seedlings under
the Poisson model with a mean of 2.14. At 10 quadrats the relative frequency can only be a
multiple of 0.1, and the points range from 0 to 0.5. As the sample size grows, the points
concentrate around the line. Individual samples can still fall far from the line, but large
deviations become less likely.

**Optional remark**

The law of large numbers holds for one event at a time. Glivenko and Cantelli proved in
1933 that the empirical cumulative distribution of an i.i.d. sample (next slide) converges
to the cumulative distribution of the model for all values at once. The formal statements
are in the chapter's box "Statistical detail: the law of large numbers and the
Glivenko–Cantelli theorem".

## Slide 9 — The empirical distribution

Because of this relationship between relative frequencies and probabilities, we often
define the **empirical distribution** of a sample: we assign each observed count its
relative frequency and treat the result as if it were a probability mass function. In
principle it is just a way to tabulate a (potentially long) collection of observations, but
it lets us calculate properties of a sample, such as quantiles or expectations, that we can
relate to the same properties of the model.

Like any distribution, an empirical distribution has a cumulative function: the fraction of
observations at or below each count. When we compare the empirical and model cumulative
probability functions, we often use step plots, which show both functions side by side.
These plots are useful when we want to see how well a distribution matches a sample, that
is, whether a sample of observations could be treated as a random sample from a given
distribution. Later chapters return to this.

**Figure walkthrough — included in the four minutes**

The figure is a copy of the chapter figure. Left, the probability mass: the vermillion
stems are the Poisson probabilities and the blue points the relative frequencies of the 50
quadrats, the two rows of the table on slide 6. Right, the cumulative versions as steps:
the solid vermillion line is the model and the dashed blue line the sample. The two
cumulative functions are close everywhere, although the masses differ visibly at some
counts (zero and four seedlings are more common in the sample than in the model, three less
common).

**Optional remark (the chapter's footnote)**

Andrey Kolmogorov first formalised and defined the empirical distribution function (the
cumulative version) in 1933.

## Slide 10 — Summaries of a sample

Just like for any probability distribution of Chapter 2, we can calculate expectations such
as means and variances from an empirical distribution, and quantiles by inverting the
empirical cumulative distribution: we replace the probabilities in the formulae by the
relative frequencies of the sample.

Strictly speaking, a data sample is just a collection of values. We can always calculate
the arithmetic mean of those values, but in this course a mean and a variance are
properties of distributions. So when we say "sample mean" or "sample variance", we mean the
mean or the variance of the empirical distribution. The mean of the empirical distribution
equals the arithmetic mean of the sample, 2.14 seedlings per quadrat. The variance of the
empirical distribution divides by the number of observations $n$ and gives 2.36, whereas
`var()` divides by $n - 1$ and gives 2.41. What most people call the sample variance is an
estimator of the variance of the model, a different concept; slide 28 explains why it uses
a different divisor. The median, the 0.5 quantile, is the smallest observed count whose
empirical cumulative probability reaches 0.5: 2 seedlings. R has nine ways of computing a
quantile, and `quantile()` with `type = 1` returns the smallest observed count whose
empirical cumulative probability reaches the requested value, which is what we want for
counts.

For independent observations from the same distribution, the empirical distribution
converges to the model distribution as the sample size grows. Its moments (the mean, the
variance and others) converge to those of the model, provided that those moments exist in
the model, and a quantile converges where the cumulative probability function of the model
is not flat at that quantile. All the moments of a Poisson distribution exist, so the mean
and the variance of our sample would converge to those of the model if the counts were
i.i.d. Poisson. A finite sample can sometimes agree exactly, but agreement is not
guaranteed at any finite size.

In practice we never have an infinite sample, but the larger the sample, the better we can
judge whether a model describes the data. Larger samples are also more stable: there is
less variation across hypothetical samples of the same size, which is the topic of the
second block. Note that agreement between a sample and a model does not show that the
observations are independent; independence remains an assumption.

## Slide 11 — Samples of continuous measurements

The relationship between samples and distributions is the same for continuous
measurements, but the tools to describe a sample need to be adapted. A continuous random
variable takes any particular value with probability zero, so in a sample of exact
measurements we would not expect any value to be repeated: the relative frequency of every
observed value would be $1/n$, and a table of relative frequencies would tell us nothing.

The example is the flipper lengths of the 123 Gentoo penguins of Chapter 2 (the data set
`penguins`, built into R 4.5.0 and later; one penguin without measurements is removed), with
the Normal model of that chapter: a mean of 217 mm and a standard deviation of 6.5 mm. The
lengths were recorded to the nearest millimetre, so some values do appear more than once,
but the 123 penguins are spread over 25 different values.

A **histogram** is the continuous counterpart of the table of relative frequencies. We
divide the range of the measurements into intervals, called **bins**, and count the
observations in each bin. Dividing the count by the sample size gives the relative
frequency of the bin, which we can compare with the probability that the model assigns to
that interval. We place the limits of the bins halfway between two millimetres, so that no
recorded length falls on a limit. For the bin from 214.5 to 218.5 mm, 31 of the 123
penguins give a relative frequency of about 0.252, and the model probability is about
0.241. As with counts, the relative frequency of a bin converges to the model probability
of the interval as the sample grows, when the observations are i.i.d. from the model.

## Slide 12 — Density-scaled histograms

To compare a histogram with a probability density function we need the same units. In a
**density-scaled histogram** the height of each bar is the relative frequency divided by
the width of the bin, so that the area of the bar equals the relative frequency and the
areas of all bars add up to one. For the bin of slide 11, the height is
$0.252/4 = 0.063$/mm, against a Normal density of about 0.061/mm in the middle of the bin. In R, `hist()`
draws a histogram of counts by default and a density-scaled histogram with the argument
`probability = TRUE`.

The width of the bins is our choice, and it changes how the same sample looks. Narrow bins
contain few observations each, so the heights of the bars vary a lot from bin to bin. Wide
bins are more stable, but hide the shape of the distribution within each bin. There is no
correct bin width; the larger the sample, the narrower the bins can be.

The dashed blue curve is a **kernel density estimate**, a smooth alternative to the
histogram. Instead of counting observations in bins, it places a small smooth curve (the
kernel, by default a Normal density) on top of every observation and averages these curves.
The standard deviation of the kernel is called the **bandwidth**, and it plays the same role
as the bin width: a small bandwidth gives a wiggly estimate and a large bandwidth a very
smooth one. In R, `density()` calculates it and chooses the bandwidth from the sample.

A kernel density estimate is calculated from the sample without assuming a model, whereas
the vermillion curve is the density of the model that we chose. The two curves differ for
two possible reasons: a sample of 123 penguins varies from one sample to the next (sampling
variation), and the Normal model is an approximation of the data generating process. From
one sample we cannot tell how much of the difference is due to each.

**Figure walkthrough**

The figure is a copy of the chapter figure: the same 123 lengths with bins of 1, 4 and
12 mm. Point to the middle panel, where the bar from 214.5 to 218.5 mm is the one calculated
above, then to the left panel (bars jump up and down) and the right panel (the shape is
lost).

**Short activity — included in the six minutes**

Ask the two questions on the slide (the chapter's "Practice: bins and samples"). Expected
answers: other penguins give a different sample, so the histogram would change, although
with 123 penguins its overall shape should remain similar. The bin width only changes how
the sample is displayed: the values in the sample stay the same, and so does their mean.

## Slide 13 — The empirical cumulative distribution

The empirical cumulative distribution needs no adaptation for continuous data: it is still
the fraction of observations at or below each value, and it requires neither bins nor a
bandwidth. With continuous data it increases by $1/n$ at each observation (and by a multiple
of $1/n$ where several rounded measurements coincide), whereas the cumulative probability
function of the model is a smooth curve. In R, `ecdf()` returns the empirical cumulative
distribution of a sample as a function that we can evaluate at any value.

For a flipper length of 225 mm, 88% of the penguins have a flipper of at most that length,
while the model assigns a probability of about 0.89 to that event. The mean, variance and
quantiles of a continuous sample are calculated as before (for continuous data the default
`type` of `quantile()` is appropriate), and the asymptotic convergence of slide 10 also
holds: for i.i.d. observations from a model, the empirical cumulative distribution converges
to the cumulative probability function of that model as the sample grows.

**Figure walkthrough — included in the three minutes**

The figure is a copy of the chapter figure. The solid vermillion curve is the Normal model
and the dashed blue steps are the 123 penguins. Point to the steps, which are larger where
several rounded lengths coincide, and then to 225 mm on the horizontal axis, where the two
lines are close (0.88 and 0.89).

Break (10 minutes).

## Slide 14 — Parameters, estimators and estimates

A **parameter** is a quantity that defines a model distribution, such as the probability
$p$ of a Binomial distribution or the mean $\mu$ and standard deviation $\sigma$ of a Normal
distribution. In Chapter 2 the values of the parameters were given. With real data they are
unknown, and we want to learn about them from a sample.

We return to the fir seedlings. Let $X_i$ be the number of seedlings in quadrat $i$. We
model the counts with a Poisson distribution, where $\lambda$ is the expected number of
seedlings per quadrat, and we assume that the counts are i.i.d. That is, all quadrats have
the same area and the same expected count, and the count in one quadrat does not change the
probabilities for the others. The parameter $\lambda$ is unknown.

An **estimator** is a rule (a function) that we apply to a sample to calculate a value for a
parameter. Since we treat the observations as random variables, an estimator is also a
random variable: a different sample would give a different result. An **estimate** is the
value that the estimator returns for the sample that we actually observed. We mark
estimators and estimates with a hat, for example $\hat\lambda$ for the parameter
$\lambda$.

## Slide 15 — The method of moments

The mean of the 50 counts is 2.14 seedlings per quadrat. As $\lambda$ is the mean of the
Poisson distribution, the mean of the sample seems a reasonable estimate of $\lambda$, and
it is the value that we gave to the model on slide 5. The **method of moments** turns this
intuition into a general procedure: it equates expectations of the model distribution to
the same expectations of the empirical distribution of the sample, and solves the resulting
equations for the parameters. A model with one parameter needs one equation, normally the
mean; a model with two parameters needs a second equation, normally the variance (slide
28).

For a Poisson distribution $E[X_i] = \lambda$, and the mean of the empirical distribution is
the mean of the $n$ counts, $\overline X$. Equating the two gives the estimator
$\hat\lambda = \overline X$, and for the 50 quadrats the estimate is 2.14 seedlings per
quadrat.

The justification for the method is the convergence of slide 10: if the moments of the
empirical distribution converge to the moments of the model as the sample grows, a
parameter calculated from the former should be close to the parameter of the model when the
sample is large enough.

Maximum likelihood (Chapter 4) is the method of estimation that we use in the rest of the
course. We start with the method of moments because its estimators are short formulae,
which makes it easier to study how estimates vary across samples. The concepts of the rest
of this lecture (sampling distribution, standard error and confidence interval) apply to
any estimator.

**Optional remark (the chapter's footnote)**

Formally, the method of moments equates the raw moments $E[X^k]$ of the model and the
empirical distribution. The central moments are functions of the raw moments, so equating
them gives the same estimators; the chapter uses central moments because the mean and the
variance are the summaries that we are used to interpreting.

## Slide 16 — Discussion: parameter, estimator or estimate?

This discussion checks the three terms of slide 14 before we use them in the rest of the
block.

**Discussion and expected answers — included in the four minutes**

Give students one minute, then take one answer per item.

1. **Parameter:** $\lambda$ is a fixed, unknown quantity of the model.
2. **Estimator:** a rule that we apply to a sample; here it is $\hat\lambda = \overline X$.
3. **Estimate:** the number that the rule gives for the sample that we observed.
4. **Estimator:** next year's quadrats have not been counted yet, so their mean is a random
   variable. Once the colleague counts them, it becomes an estimate. This is the item that
   leads to the next slide: the value of an estimator varies from sample to sample.

## Slide 17 — The sampling distribution

The **sampling distribution** of an estimator is the distribution of its estimates across
repeated hypothetical samples. A hypothetical sample is another sample that the data
generating process could have produced. The design and the sample size are part of that
process, so every hypothetical sample has the same design and sample size as the data,
and each gives a new estimate. Because we treat the data as if they were a random sample
from the model (slide 5), we obtain hypothetical samples by sampling from the model. The
sampling distribution tells us how much an estimate could have changed if the data
generating process had produced another sample, so we use it to quantify the uncertainty
of an estimate (slides 22 and 24). It is an imaginary construct: in a real study we observe
one realisation of the data generating process, obtain one estimate, and never observe the
sampling distribution itself.

There are two distributions and two kinds of repetition. Within one sample, the quadrats
are the replicates, and the Poisson distribution describes the variation of the counts
across them. Between samples, the sampling distribution of $\hat\lambda$ describes the
variation of the mean of the $n$ quadrats of a sample across hypothetical samples. Adding
quadrats to a sample increases $n$; it does not produce another sample. In the same way,
if the quadrats had been counted in two field campaigns and we analysed all the counts
together, they would form one sample: a single realisation of a data generating process
that includes both campaigns.

For a finite sample, the shape of the sampling distribution is in general unknown, except
in special cases where it can be derived mathematically. The general way to study it is a
simulation, where we choose the parameter of the model and draw as many hypothetical
samples as we want.

**Optional remark (the chapter's footnote)**

Many statistics textbooks call each hypothetical sample an "experiment" and speak of
repeating the experiment. The course avoids that term: much ecological data comes from
surveys and monitoring campaigns rather than experiments, and an experiment is usually
understood as a unit fixed in time and space, whereas what counts as one sample depends
only on the data that we analyse (it may combine several field experiments or use part of
one). Students who read other textbooks will meet the term.

**Figure walkthrough**

The schematic has no numbers. Point to the model on the left, then to one row of quadrats
(one sample, with the variation among quadrats), then to the estimate of each sample and
to the histogram that gathers them (the variation among samples).

## Slide 18 — Hypothetical samples in R

We assume a Poisson model with $\lambda = 2.14$ (the estimate from the fir seedlings) and
samples of 50 quadrats, as in the data, and draw 2,000 hypothetical samples. For each one
we calculate the estimate of $\lambda$. The seed is set once, before the whole batch of
repetitions.

We repeat the sampling with `replicate()`, which evaluates an expression (`expr`) a number
of times (`n`) and collects the results in a vector. Here the expression simulates the
counts of one sample with `rpois()` and returns their mean, so the vector
`lambda_estimates` holds one estimate per hypothetical sample. The last two lines
summarise it with its mean and its standard deviation; the next slide shows the result.

## Slide 19 — A simulated sampling distribution

The mean of the 2,000 estimates is close to the parameter that we gave to the simulation,
and their standard deviation, about 0.205 seedlings per quadrat, measures how much the
estimate changes from one sample to the next. We use both values on the next slides.

**Figure walkthrough — included in the three minutes**

The figure is a copy of the chapter figure. The grey histogram is the distribution of the
2,000 estimates, which approximates the sampling distribution of $\hat\lambda$, and the
vermillion line is the parameter used in the simulation. The horizontal axis is a mean count
per quadrat, which is why its values are not restricted to integers. The histogram is a
simulation: with real data we would have only one of these estimates.

## Slide 20 — Bias and variance

We describe a sampling distribution with its mean and its variance, which tell us whether
the estimator is centred on the parameter and how much the estimates vary around that
centre. The **bias** of an estimator is the difference between the mean of its sampling
distribution and the parameter that it estimates; $\theta$ stands for a parameter in general
and $\hat\theta$ for its estimator. An estimator is **unbiased** when its bias is zero.

For i.i.d. Poisson counts, $E[\hat\lambda] = \lambda$, so the mean of the sample is an
unbiased estimator of $\lambda$ (the mean of the sample is unbiased for the mean of the
model for any distribution). However, unbiasedness is the exception and not the rule. Most
estimators are biased in finite samples, such as the method-of-moments estimator of a
variance (slide 28) or a non-linear function of an unbiased estimator, such as
$e^{-\hat\lambda}$ as an estimator of the probability $e^{-\lambda}$ of an empty quadrat. In
general, we can only expect the bias of an estimator to become small as the sample grows
(slide 29). Bias is a property of the whole sampling distribution: individual estimates of
an unbiased estimator still fall above or below the parameter, as the histogram of slide
19 shows.

The **variance of an estimator** is the variance of its sampling distribution. For the mean
of $n$ i.i.d. Poisson counts it is $\lambda/n$: it decreases as the sample grows. The
variance of the counts in individual quadrats remains $\lambda$; what decreases is the
variation among the means of hypothetical samples. The simulated values on the slide
are close to these results, and they do not match exactly because 2,000 hypothetical
samples are still a finite number of repetitions.

The formula $\lambda/n$ is a special case of a general result: the mean of $n$ i.i.d.
observations has variance $\sigma^2/n$, where $\sigma^2$ is the variance of the model (which
equals $\lambda$ for a Poisson distribution). Exact formulae like this exist for only a few
estimators, such as the mean. For the others, we rely on large-sample approximations
(slides 29 and 30) or on simulation.

**Short activity — included in the six minutes**

Ask the questions on the slide (the chapter's "Practice: what varies?"). Expected answers:
the samples, and therefore the estimates, vary; the parameter $\lambda$ of the model is the
same in both studies. Bias is the difference between the mean of the sampling distribution
and the parameter, and two estimates are not enough to describe a sampling distribution
(also, in a real study we would not know $\lambda$).

## Slide 21 — Mean squared error

The **mean squared error** (MSE) combines bias and variance into one measure of the quality
of an estimator. It is the expected squared distance between the estimator and the
parameter, and it equals the variance plus the squared bias. For an unbiased estimator the
MSE equals its variance, so for the mean of Poisson counts it is $\lambda/n$; in the
simulation it is about 0.0418.

The MSE is useful to compare estimators of the same parameter. A biased estimator can have
a smaller MSE than an unbiased one if its variance is sufficiently smaller. We see an
example with two estimators of a variance on slide 28, and students compare them by
simulation in Exercise 3 of the practical.

**Optional remark (the chapter's footnote)**

Classical statistics put a strong emphasis on unbiased estimators. Many fields of research
now favour biased estimators when this substantially reduces the mean squared error; the
keyword for further reading is the bias–variance trade-off.

## Slide 22 — Standard errors

The **standard error** (SE) of an estimator is the standard deviation of its sampling
distribution. We prefer it to the variance when reporting uncertainty because it has the
units of the estimate. For the mean of Poisson counts it is $\sqrt{\lambda/n}$; in the
simulation that is $\sqrt{2.14/50} \approx 0.207$, close to the standard deviation of the
2,000 estimates (0.205).

With real data we do not know $\lambda$, so we cannot calculate the standard error. Instead
we replace the parameter with its estimate. This is a **plug-in estimate**: the standard
error that we report is itself an estimate, and a rough one in small samples. For the 50
quadrats it is about 0.21 seedlings per quadrat. That is, across hypothetical samples
of 50 quadrats each, we would expect the estimates of $\lambda$ to vary with a standard
deviation of about 0.21 seedlings per quadrat. It is the same value as in the simulation
because we gave the simulation the estimate as its parameter.

This calculation relies on the Poisson model. If the counts are overdispersed with respect
to the Poisson distribution (Chapter 2), the formula underestimates the variation across
hypothetical samples; Exercise 1 of the practical shows an example with the barn owls.

## Slide 23 — Discussion: standard deviation or standard error?

These two terms are often confused. This discussion separates them with the numbers of the
fir seedlings.

**Discussion and expected answers — included in the four minutes**

Give students one minute, then take one answer per item.

1. **Standard deviation:** the variation among the observations, the counts of individual
   quadrats (`sd()` of the 50 counts).
2. **Standard error:** the variation of the estimate across hypothetical samples.
3. **Standard error:** the histogram of slide 19 is a simulated sampling distribution, so
   its spread approximates the standard error.
4. **Standard deviation:** the variation of the count of one quadrat under the model,
   $\sqrt{\lambda}$.

Then say the chapter's warning once: a larger sample reduces the standard error, but it does
not reduce the standard deviation of the observations.

Break (10 minutes).

## Slide 24 — Confidence intervals

A **confidence interval** is a range of values for a parameter, calculated from a sample
with a procedure whose behaviour across repeated hypothetical samples we can describe,
exactly in special cases and approximately in general. The **confidence level** (for
example 95%) is the fraction of hypothetical samples for which the interval calculated
with that procedure would contain the parameter. We use confidence intervals to report the
uncertainty of parameter estimates in the rest of the course.

A simple procedure is available when the sampling distribution of the estimator is
approximately Normal; slide 30 discusses when this is the case. An approximate 95%
confidence interval is then the estimate plus and minus $z_{0.975}$ times the estimated
standard error, where $z_{0.975} \approx 1.96$ is the 0.975 quantile of the standard Normal
distribution (mean 0 and standard deviation 1). This quantile leaves a probability of 0.025
in each tail, hence 95% in between. This type of interval is known as a **Wald interval**.

**Optional remark (the chapter's footnote)**

When the observations are i.i.d. from a Normal distribution, there is an interval for the
mean with exactly 95% coverage, which replaces $z_{0.975}$ by a quantile of Student's $t$
distribution; it is a special case that does not extend to other models.

## Slide 25 — Wald interval in R

The first three lines repeat the plug-in standard error of slide 22. `qnorm()` gives the
0.975 quantile of the standard Normal distribution, and the last line calculates both
endpoints at once: `c(-1, 1)` subtracts and adds the same amount. The endpoints are in the
comment.

It is an interval for the parameter $\lambda$, the mean count, so it says nothing about the
range of counts in individual quadrats: most quadrats have counts outside it.

## Slide 26 — The dance of the confidence intervals

The parameter is fixed and the interval is random: its endpoints change from one
hypothetical sample to the next. If we had many hypothetical samples and calculated an
interval from each with the same procedure, about 95% of those intervals would contain the
parameter. Once an interval has been calculated, it either
contains the parameter or it does not, so we do not say that the parameter has a
probability of 95% of being inside it.

**Figure walkthrough — included in the five minutes**

If the connection allows, open Geoff Cumming's animation of the "dance of the confidence
intervals" at <https://logarithmic.net/2017/dance/> for about one minute: estimates and
their intervals bounce and shift from one sample to the next. Otherwise use the static
version on the slide.

The figure is a copy of the chapter figure, for the Poisson model of the seedling counts.
At the top, the simulated sampling distribution of slide 19; below it, the estimates
(points) and 95% Wald intervals (lines) of 20 hypothetical samples, on the same
horizontal axis. The dashed line is the parameter. Nineteen intervals cross it; the sixth
sample, in vermillion, has a low estimate, and its interval misses the parameter. With
20 samples, one miss is what a 95% procedure leads us to expect on average, but another
set of 20 could have none or several.

## Slide 27 — Coverage checked by simulation

The fraction of hypothetical samples in which the interval actually contains the
parameter is called the **coverage** of the procedure. The Wald interval relies on an
approximation (and on a plug-in standard error), so its coverage may differ from the
confidence level that we intended. We can check this with a simulation, where we know
$\lambda$: for each simulated sample we calculate the interval and record whether it
contains the parameter. The code is on the chapter page.

With a mean of 2.14 and 50 quadrats, the simulated coverage is very close to the intended
0.95. This result is specific to these values. When the expected total count $n\lambda$ is
small, the sampling distribution of $\hat\lambda$ is far from Normal and the coverage of the
Wald interval can be noticeably lower than 95%. The lower endpoint can even be negative,
which is not a possible value for the mean of a Poisson distribution.

**Short activity — included in the four minutes**

Ask the questions on the slide (the chapter's "Practice: interpret an interval"). Expected
answers: the 95% refers to the coverage of the procedure across hypothetical samples:
about 95% of the intervals calculated in this way would contain the parameter. For a Wald
interval based on a Poisson model, we would check whether the counts can be treated as
i.i.d. Poisson (for example, whether they are overdispersed) and whether the sample is large
enough for the Normal approximation.

## Slide 28 — Estimation of two parameters

The concepts above apply in the same way to continuous measurements and to models with more
than one parameter. We return to the flipper lengths and assume that they are i.i.d. Normal,
where $\mu$ is the mean of the model (in mm) and $\sigma^2$ its variance (in mm²). Remember
that the argument `sd` of `rnorm()` and related functions takes the standard deviation
$\sigma$.

The model has two parameters, so the method of moments needs two equations. The mean gives
$\hat\mu = \overline X$ as before. The variance of the model is $\sigma^2$, and its
counterpart in the empirical distribution is the mean of the squared deviations of the
flipper lengths from the mean of the sample: the equation on the slide, with divisor $n$.
That is, the method-of-moments estimators of $\mu$ and $\sigma^2$ are the mean and the
variance of the empirical distribution (slide 10).

For the 123 penguins the two estimates of the variance differ, and these estimates are
behind the rounded values of 217 mm and 6.5 mm that we have used for the Normal model since
Chapter 2. We now explain the difference that we found on slide 10. The method-of-moments
estimator divides the sum of squared deviations by $n$, whereas `var()` divides it by
$n - 1$. For i.i.d. observations, the method-of-moments estimator of the variance is biased:
on average it underestimates $\sigma^2$, by a fraction $1/n$ of it. This happens because the
deviations are calculated from $\overline X$, which is estimated from the same sample and is
therefore closer to the observations than $\mu$. Dividing by $n - 1$ removes the bias, and
that is the estimator that most people call the sample variance. This unbiasedness does not
carry over to transformations: the square root of the result of `var()`, which is what
`sd()` calculates, is a biased estimator of $\sigma$.

The bias of the method-of-moments estimator decreases as the sample grows. We do not know
$\sigma^2$, but if we plug in the estimate of 42.1 mm², the bias would be about $-0.34$ mm²
for a sample of 123 penguins and about $-1.68$ mm² for a sample of 25 penguins. Being
unbiased does not imply having the smallest MSE: in Exercise 3 of the practical, students
compare the MSE of the two estimators by simulation.

**Optional remark (the chapter's box "Statistical detail: the bias of the variance
estimator")**

The $n - 1$ divisor is known as Bessel's correction. It was originally proved by Gauss in
1823 and popularised by Bessel in a paper from 1838. The current explanation, that we remove
one degree of freedom because the estimate of the variance relies on the estimate of the
mean and not on the mean of the model, is due to Fisher, about a hundred years later.

## Slide 29 — Consistency

On slide 10 we saw that the mean, variance and quantiles of the empirical distribution
converge to those of the model as the sample grows. Method-of-moments estimators are
calculated from the moments of the empirical distribution, so they inherit this behaviour.
An estimator is **consistent** if its estimates are increasingly unlikely to miss the
parameter by any given margin as the sample grows. This is the same statement that we made
for relative frequencies on slide 8, now applied to an estimator, and it should be read in
the same way: it is about probabilities and not about every sample. The mean of i.i.d.
Poisson counts is a consistent estimator of $\lambda$. The method-of-moments estimator of
the variance of the Normal model is also consistent, although it is biased for any finite
sample. The formal statement is in the chapter's box "Statistical detail: consistency".

The standard error tells us how fast an estimator approaches the parameter. For the mean of
Poisson counts it is $\sqrt{\lambda/n}$, so we need a sample four times larger to halve the
standard error.

**Short activity — included in the three minutes**

Ask the question on the slide (the chapter's "Practice: two studies of different size").
Expected answer: no. Consistency states that the probability of an error larger than any
given margin decreases towards zero as the sample grows. It does not state that every
larger sample is closer to the parameter than every smaller one, so the smaller study can
produce the closer estimate by chance.

## Slide 30 — Asymptotic normality

Large samples have a second consequence. As the sample grows, the sampling distribution of
most estimators approaches a Normal distribution centred on the parameter, whatever the
distribution of the individual observations. An estimator with this behaviour is said to be
**asymptotically normal**. This is a general behaviour of estimators and not a special
feature of the mean of a sample, although the mean is the case with its own name: for the
mean of $n$ i.i.d. observations from a distribution with finite variance, the result is the
**central limit theorem**. For the mean of Poisson counts, the approximating Normal
distribution has the parameter $\lambda$ as its mean and the standard error
$\sqrt{\lambda/n}$ as its standard deviation, which is the equation on the slide. The formal
statement is in the chapter's box "Statistical detail: the central limit theorem".

Other method-of-moments estimators behave in the same way. The moments of the empirical
distribution are themselves means of i.i.d. quantities, so the theorem applies to each of
them. The estimate of a parameter is calculated from these moments with a smooth function,
and in a large sample the moments vary so little that the function is nearly a straight line
over that range, which preserves the Normal shape. So the method-of-moments estimator of the
variance of the Normal model is asymptotically normal, and so are the estimators of the
Negative Binomial model in the practical. Chapter 4 gives the same result for maximum
likelihood estimators, with a way to calculate their standard errors.

Asymptotic normality is the justification for the Wald interval of slide 24, and because it
is a general behaviour the same interval can be used with estimators other than the mean.
How large $n$ needs to be depends on the model and on the estimator. For Normal observations
the sampling distribution of the mean is exactly Normal at any sample size, whereas that of
the method-of-moments estimator of the variance has a skewness of approximately 1.4 for 5
observations and is still slightly skewed for 123 (approximately 0.26).

**Figure walkthrough — included in the five minutes**

The figure is a copy of the chapter figure: 2,000 simulated means for samples of 5 and of
100 quadrats, each with its Normal approximation. For 5 quadrats the sampling distribution
is discrete (the mean of five counts can only change in steps of 0.2, so each bar is one
possible value) and slightly asymmetric, with a longer tail to the right. For 100 quadrats
the Normal approximation is close. The counts in individual quadrats still follow a Poisson
distribution in both cases; it is the distribution of their mean that approaches a Normal
distribution.

**Two cautions, said once**

The chapter's warning "Finite samples and special cases": in a finite sample an estimator
is in general biased and the shape of its sampling distribution is unknown. Exact results,
such as the $t$ interval for the mean of Normal observations, exist for only a few
estimators and models. For the models of this course we can make confident statements about
bias, variance, standard errors and confidence intervals only for large samples; for small
samples they are approximations, and simulation is the tool to check how good they are.

Consistency, coverage and asymptotic normality are all derived under the assumed model, in
our case i.i.d. Poisson counts. In a real forest the expected count may change with
habitat, seedlings may be clustered, or some seedlings may be missed. A larger sample does
not correct for this. Instead, we need a model that describes those sources of variation,
such as the distributions for overdispersed counts of Chapter 2 or the models for grouped
observations of Chapter 7.

## Slide 31 — Discussion: empirical or sampling distribution?

This discussion separates the two distributions of the lecture.

**Discussion and expected answers — included in the three minutes**

Give students one minute, then take one answer per item.

1. **Empirical distribution:** a histogram of individual observations.
2. **Sampling distribution**, approximated by simulation: each value in the histogram is
   one estimate calculated from a whole sample of 50 quadrats.
3. **Empirical distribution:** the relative frequencies of the observed counts.
4. **Sampling distribution:** the standard error is its standard deviation.

## Slide 32 — Course roadmap: from samples to response curves

In this chapter we learned how a sample relates to a model and how estimates vary across
hypothetical samples. Chapter 4 replaces the method of moments by maximum likelihood, a
general method of estimation that we use in the rest of the course. The estimators change,
but we describe their uncertainty with the concepts of today: standard errors, confidence
intervals, coverage and asymptotic normality. Chapter 5 turns to the deterministic functions
that describe ecological responses, which Chapter 6 combines with the distributions. The
observations that we treated as i.i.d. as a simplification (neighbouring quadrats, visits to
the same nest) come back in Chapter 7.

## Slide 33 — The Chapter 3 R practical

The practical has four exercises. The first, on barn owl calls, is worked on the page, so
read it first: a Negative Binomial model fitted by the method of moments, a standard error
and a Wald interval. It uses the second and third blocks together and shows how the
practical works. The Poisson formula would give a standard error of about a third of the
Negative Binomial one, which is the warning of slide 22. The 122 visits come from only 24
nests, so treating them as i.i.d. is a simplification that we accept in this chapter;
Chapter 7 covers observations nested in groups. Exercise 2 simulates samples of 10 and 1,000 leaves from
a Beta model of leaf damage, with several seeds, to see how the properties of a sample
behave as the sample grows. Exercise 3 uses the heights of 31 black cherry trees: two
estimators of the variance, compared by simulation for bias and mean squared error.
Exercise 4 simulates the body mass of small mammals under a LogNormal model and checks the
coverage of Wald intervals for the mean mass at two sample sizes.

Read the Beta and LogNormal entries of the supplement first: they give the mean, the
variance and the R functions that the exercises need. Try each exercise before checking the
solution.

## Slide 34 — Summary and closing questions

Go back to slide 4 by speaking about it again; no new slide is needed. We treat a sample as
random draws from a model, and we compare the sample with the model through relative
frequencies, histograms and empirical cumulative distributions. An estimator is a rule that
calculates a value for a parameter from a sample, and an estimate is its result for one
sample. The sampling distribution of an estimator describes how its estimates vary across
hypothetical samples: its mean gives the bias, its standard deviation is the standard
error, and the mean squared error combines both. A confidence interval comes from a
procedure that contains the parameter in a given fraction of hypothetical samples, and
we can check that coverage by simulation. Consistency and asymptotic normality describe large
samples; for small samples we check by simulation. On the diagram of slide 4, the dashed
arrow from the estimates to the parameters now comes with a standard error and an interval.

Return to this slide for the two closing questions.

**Discussion and expected answers — allow about two minutes**

Question 1: the standard deviation of the counts describes the variation among individual
quadrats, which is a property of the process and does not depend on how many quadrats we
count ($\sqrt{2.14} \approx 1.46$ seedlings per quadrat under the model). The standard error
describes the variation of the mean across hypothetical samples; averaging more
quadrats cancels more of the variation among them, so it shrinks as $\sqrt{\lambda/n}$.

Question 2: the 95% describes the procedure: across hypothetical samples, about 95% of
the intervals calculated in this way contain the parameter, if the coverage of the
procedure equals its confidence level. One calculated interval either contains the
parameter or it does not.

**Final transition**

The next steps are the practical and Chapter 4, where maximum likelihood replaces the method
of moments and the same concepts describe the uncertainty of the estimates.

## Adjustments during delivery

The slides take 125 minutes and leave 5 minutes of slack, which comes last. If discussion
overruns, use the slack first, then shorten in this order:

- Slide 3 to one sentence ("this lecture is the first step of estimation"): recovers about
  half a minute.
- Slide 13 merged into speech on slide 12 (one sentence on `ecdf()` and the 88% at
  225 mm): about two and a half minutes.
- Slide 21 to one sentence on slide 20 (the MSE is the variance plus the squared bias):
  about two and a half minutes.
- Slides 7 and 18 to their definition box (the `factor()` levels; `replicate()`): about two
  minutes each.
- Slide 32 to one sentence (Chapter 4 replaces the method of moments by maximum
  likelihood): about one and a half minutes.

Keep the explanations of the two kinds of repetition (slide 17), standard deviation against
standard error (slides 22 and 23), what 95% means (slides 26 and 27), and that all the
properties are derived under the assumed model (slide 30).

The breaks are placed between the blocks, after slides 13 and 23 (minutes 44 and 96). If a
block runs over, shorten the block rather than the following break, and catch up with the
adjustments above.

**If time is left: code to run**

All of these chunks are visible on the chapter page or the practical page, so students can
follow along and nothing needs to be typed. Start with the chunks that load `fir`, RTMB and
RTMBdist, and `penguins`, and keep one R session open across the breaks, because later
chunks use their objects.

- **After slide 13** (*Samples and distributions*, *Samples of continuous measurements*): the
  `table(factor())` chunk (slide 7), the convergence loop with seed 123 (slide 8), the
  `quantile()` chunk (slide 10), and the bin, `density()` and `ecdf()` chunks (slides 11 to
  13). "Practice: fruit-set frequency" is done by hand ($15/24 = 0.625$). "Practice: orchid
  flowering across plots" (seed 246) goes last, because it redefines `count_values`.
- **After slide 23** (*Parameters, estimators and estimates*, *Sampling distributions*,
  *Standard errors*): the `replicate()` chunk with seed 401 (slide 18), the bias, variance
  and mean squared error chunks (slides 20 and 21) and the plug-in standard error (slide
  22). Two practices are done by hand: "Practice: estimate from quadrats" (3 seedlings per
  quadrat) and "Practice: change the sample size" (0.207 becomes 0.103 seedlings per quadrat
  with 200 quadrats).
- **After slide 31** (*Confidence intervals*, *Estimation of two parameters*, then the
  practical page): the Wald interval (slide 25, after the plug-in standard error), the
  coverage chunk with seed 402 (slide 27), the two estimates of the flipper variance (slide
  28) and Exercise 1 on barn owl calls.
