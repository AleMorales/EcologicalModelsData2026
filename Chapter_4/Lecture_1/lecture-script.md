# Chapter 4 lecture script, Lecture 1: Maximum likelihood estimation, the method

Draft for the course author's review. **Target: 150 minutes in total, with 125 minutes of
slides on 32 slides (including the discussion, the two practice questions and one live demo of 18
minutes), 5 minutes of slack and two breaks of 10 minutes.** The breaks separate the three
blocks of the lecture. The only code that is run live is the demo of slide 30, from the
script `demo-profile.R`.

This script follows the first part of the [Chapter 4 theory](../Theory.qmd), up to the section
"Parameterisation, slices and profiles", with a short introduction to the first part of the
[R practical](../Practicals/no_solution.qmd). Lecture 2
(`../Lecture_2/lecture-script.md`) covers the second part of the chapter: uncertainty, the
properties of maximum likelihood estimators and model comparison. The slides carry keywords
only; the narrative is here.

Slide 3 uses your diagram `ModelCycle.png` from the Chapter 1 lecture folder. Slide 15 uses the
schematic `optimiser-search.svg` and slide 17 the schematic `fit-pipeline.svg`. Slides 14
(`likelihood-curve.png`), 25 (`owl-fits.png`), 26 (`likelihood-surface.png`) and 27 and 29
(`slice-profile.png`, the same figure twice) use copies of the chapter figures `fig-likelihood_curve`,
`fig-owl_fits`, `fig-likelihood_surface` and `fig-slice_profile`. All are in `lecture-assets/`, and
`lecture-assets/figures.R` makes them from the code of the chapter. If the chapter figures change, run
that script again.

## Timing and slide sequence

Times are measured from the start of the session and include the breaks.

| Slide | Topic | Minutes | Elapsed time |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis | 1 | 0–1 |
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

Slides 125 minutes (blocks of 36, 47 and 42, the demo included), slack 5, breaks 20: 150 minutes.

## Slides 1 and 2 — Ecological Models and Data Analysis; Overview of the lecture

In this lecture, we learn how to estimate the parameters of a model by maximum likelihood. In
Chapter 3 we estimated parameters with the method of moments, which only uses the mean and the
variance of a sample, and we described the uncertainty of an estimate with a sampling
distribution, a standard error and a confidence interval. Maximum likelihood uses the
probability that the model assigns to every observation, so it applies to any model for which
we can write a probability mass or density function. That is why it is the method of
estimation in the rest of the course.

The chapter has two parts and each has its own session. This session builds the method: the
likelihood function, the estimate that maximises it, the way to find that estimate with an
optimiser, and what changes when a model has several parameters. The next session asks what we
can say once a model is fitted: how uncertain the estimates are, why the method works, and how
to compare models.

The session has three blocks, separated by two breaks. The first block is about the likelihood
and the log-likelihood and ends with the first practice question. The second is about
estimation: the maximum likelihood estimator, the fit in R with `optim()`, and the
transformations that keep parameters within their range. The third is about models with two
parameters, the shape of the likelihood surface, slices and profiles, and it contains the live
demo.

**Delivery**

Take the overview at the pace of the list: read each keyword and its question, and say in one
sentence that the questions are answered in that order. Do not explain any of the terms yet.

## Slide 3 — Where we are: the modelling cycle

On the diagram of the modelling cycle, this lecture is the "likelihood (4)" and "optimise (4)"
entries of the estimation box. Chapter 2 gave us the distributions of the model box and Chapter 3
the first tools of the estimation box, with confidence intervals (3). The likelihood
is the quantity from which the rest of the estimation box, including the confidence intervals of
Chapter 4, is calculated.

**Delivery**

One minute. Point to "likelihood (4)" and "optimise (4)" only; do not walk through the cycle
again.

## Slide 4 — From the method of moments to maximum likelihood

The method of moments uses two summaries of the sample, its mean and its variance, and chooses
the parameters so that the model reproduces them. Maximum likelihood uses more: the probability
that the model assigns to every single observation. Its only requirement is that we can write
a probability mass function or a density function for the observations, so it works for any
model of the course.

Everything that we learnt in Chapter 3 remains true. An estimator is a rule applied to a
sample, an estimate is the value that it returns for the data that we have, and its
uncertainty is described by its sampling distribution, its standard error and a confidence
interval. The only thing that changes is the estimator, so the new part of the chapter is how
the estimator is defined and calculated.

Two examples run through the chapter. The first is the count of balsam fir seedlings in 50
quadrats of the Chapter 3 lecture, with a Poisson model. The second is the number of calls made
by barn owl nestlings at 122 visits of a parent to a nest, with a Negative Binomial model that has
two parameters. The Poisson example is simple enough for calculations by hand, and the owls
show what changes when a model has two parameters.

## Slide 5 — The likelihood function

The **likelihood** of a sample is the joint probability of the observations, read as a function
of the parameters with the data held fixed. For observations $x_1,\ldots,x_n$ and a parameter
$\theta$ (as in Chapter 3, $\theta$ stands for a parameter in general), it is
$L(\theta\mid x_1,\ldots,x_n)=P(X_1=x_1,\ldots,X_n=x_n\mid\theta)$.

The vertical bar reads "for a given value of": $P(X=x\mid\theta)$ is the probability of $x$ for a
given value of $\theta$, and $L(\theta\mid x_1,\ldots,x_n)$ is the likelihood of $\theta$ for a given
sample. The same symbol is used for conditional distributions, which Chapter 7 introduces. The
second equality of the formula holds because the observations are independent, so their joint
probability is the product of their individual probabilities. That is the assumption that Chapter
2 announced would be fundamental for estimation, in the section on joint distributions and
independence. For continuous data each probability mass is replaced by the density of the
observation.

The example is the count of seedlings in each quadrat, $X_i\sim\operatorname{Poisson}(\lambda)$.
The data are the counts of balsam fir seedlings in 50 quadrats of five by five feet, laid out in
a grid of five rows of ten quadrats (Davison and Hinkley 1997, *Bootstrap Methods and Their
Application*, Cambridge University Press), which come with R as the data set `fir` of the
package `boot`. We treat the counts as i.i.d. Neighbouring quadrats of a grid may be more alike
than distant ones, so this is a simplification; Chapter 7 covers observations that are not
independent.

**Optional remark (history)**

Fisher introduced the method in 1912, in a paper written as an undergraduate student, and
called it an "absolute criterion". He introduced the word likelihood in 1921, to keep it apart
from a probability, and the name maximum likelihood in 1922. The idea of choosing the value under
which the observations are most probable goes back to Lambert, Daniel Bernoulli and Gauss. For
the history, see Aldrich (1997), "R. A. Fisher and the making of maximum likelihood 1912–1922",
*Statistical Science* 12: 162–176, and Stigler (2007), "The epic story of maximum likelihood",
*Statistical Science* 22: 598–620.

## Slide 6 — Probability and likelihood

The formula of the likelihood is the formula of a joint distribution from Chapter 2. What changes
is what we hold fixed. In Chapter 2 the parameters were fixed and we calculated the probability of
different possible samples, so the data varied. Now the sample has been observed, so the
observations are fixed numbers, and we look at how the probability of that sample changes as the
parameter varies. A parameter value under which the observed sample is more probable is better
supported by the data. That is the crucial idea behind likelihood, and everything in the rest of
the chapter, the estimates, their confidence intervals and the comparison of models, is calculated
from it.

The Poisson mass $e^{-\lambda}\lambda^{x}/x!$ is one expression that we can read in two ways. For
a fixed $\lambda$ it is a function of $x$: the probability of each possible count. For an observed
$x$ it is a function of $\lambda$: the likelihood of each possible mean.

**Delivery**

Allow one minute for the columns and one for the example. Write the expression once and point to
$x$, then to $\lambda$, saying which of the two is fixed in each reading.

## Slide 7 — A likelihood by hand

Each observation contributes its probability, and the contributions are multiplied. To compare two
parameter values, we compare their likelihoods: the ratio says how many times more probable the
sample is under one value than under the other. The value of a likelihood has no meaning by
itself. Every observation multiplies it by a probability smaller than one, so its value depends on
the number of observations, and only comparisons between parameter values for the same data are
used.

The example takes the first three quadrats, which contain 0, 1 and 2 seedlings. The three
contributions are $e^{-\lambda}\lambda^{0}/0!$, $e^{-\lambda}\lambda^{1}/1!$ and
$e^{-\lambda}\lambda^{2}/2!$, with $0!=1$, and their product is $e^{-3\lambda}\lambda^{3}/2$. At
$\lambda=1$ it is $e^{-3}/2\approx 0.0249$ and at $\lambda=2$ it is
$e^{-6}\,2^{3}/2\approx 0.0099$, so these three counts are about 2.5 times more probable under a
mean of 1 than under a mean of 2. That is not surprising, because their own mean is 1.

The comparison depends on the data. For all 50 quadrats the likelihood is $4.2\times10^{-50}$ at
$\lambda=1$ and $1.3\times10^{-39}$ at $\lambda=2$, so the order is reversed: the sample of 50
counts is about $3\times10^{10}$ times more probable under a mean of 2 than under a mean of 1.
Fifty quadrats discriminate between the two values far more strongly than three, and the mean of
the 50 counts is 2.14. Note how small both numbers are, which is the point of the second bullet.

**Delivery**

Do the first calculation on the board or by pointing along the slide, and stop after the
comparison of 0.0249 and 0.0099. Mention the numbers of the 50 quadrats in speech only; they are
not on the slide. These calculations are all in the chapter, where `dpois()` and `prod()` verify
them.

## Slide 8 — A likelihood is not the probability of a parameter value

A likelihood is calculated from probabilities, but it is not a probability distribution for the
parameter, for two reasons. First, we work with aleatoric probability (Chapter 2): probabilities
describe how data or estimates vary across hypothetical samples, whereas the parameter of the
model is a fixed quantity. In the model there is no variation about $\lambda$ to which a
probability could refer. Second, for a fixed $\lambda$ the probabilities of all possible samples
add up to one, but nothing forces the likelihoods of all possible values of $\lambda$ to do so for
a fixed sample. For the 50 counts, the area under the likelihood across all the values of
$\lambda$ is about $8.7\times10^{-40}$, very far from one.

So we use a likelihood to compare parameter values and never to say how probable one of them is.

**Optional remark (Bayesian inference)**

The likelihood is also at the core of Bayesian inference, where it is multiplied by a prior
distribution and rescaled to give a probability distribution for the parameter. Chapter 1
explains why this book stays with the Frequentist interpretation. One sentence is enough here.

## Slide 9 — Discussion: probability or likelihood?

This discussion checks the difference between the two readings before the next slide builds on
it.

**Discussion and expected answers — included in the three minutes**

Give students one minute to decide with a neighbour, then take one answer per item.

1. **Probability:** the parameter is fixed at 2 and the count varies. It is a value of the mass
   function, $e^{-2}2^{3}/3!\approx 0.18$.
2. **Likelihood:** the counts are fixed and we compare two parameter values. This is the
   comparison of slide 7, with a ratio of about 2.5 in favour of $\lambda=1$.
3. **Probability:** for a fixed $\lambda$ the probabilities of all possible counts add up to one.
4. **Likelihood:** a curve over values of $\lambda$ whose area is not one. The area of
   $8.7\times10^{-40}$ is the one of slide 8.

## Slide 10 — The log-likelihood

The **log-likelihood** is the natural logarithm of the likelihood,
$\ell(\theta)=\log(L(\theta))=\sum_{i=1}^{n}\log(P(X_i=x_i\mid\theta))$. It has three advantages.
The logarithm turns the product into a sum, which is easier to work with. It is an increasing
function, so a parameter value with a higher likelihood also has a higher log-likelihood and both
functions have their maximum at the same value of $\theta$. And a product of many probabilities
can become smaller than the smallest positive number that the computer can represent, whereas a
sum of their logarithms is an ordinary number. Once the data are fixed we write $L(\theta)$ and
$\ell(\theta)$ for short.

For continuous data the contributions are densities. Recall from Chapter 2 that a density has
units (one over the unit of the measurement), that it changes with the units and that it can be
larger than one. The log-likelihood inherits these properties: it can be positive, and its value
changes if we express the same measurements in other units. If body masses are converted from
grams to kilograms, the density of every mass is multiplied by 1,000, because the same probability
is spread over a thousand times fewer units, so the log-likelihood of $n$ masses increases by
$n\log(1000)$. This is a constant, so the differences between the log-likelihoods of two
parameter values, or of two models, are the same in both units. In general only differences
between log-likelihoods calculated from the same data are meaningful. The practical checks this
with body masses (Exercise 4).

The example simulates 1,000 counts from a Poisson distribution with $\lambda=4$ (seed 501). R
returns zero for `prod()` of their probabilities, although none of the probabilities is zero,
while the sum of the log probabilities is $-2094.6$.

## Slide 11 — Log-likelihoods in R

In R, all the `d*` functions have an argument `log`. With `log = TRUE` they return the logarithm
of the probability mass (or density), which is more accurate than calculating the probability and
taking its logarithm afterwards, and the log-likelihood is the sum of these values.

The chunk is the one of the chapter. `data()` loads the data set `fir` from the package `boot`
without attaching the package, and the counts are its column `count`. The chunk before it in the
chapter loads the packages RTMB and RTMBdist, RTMB first, as in Chapter 2: the distribution
functions that we use come from them. The log-likelihood at $\lambda=2$ is $-89.52$, and the second
line, which takes the logarithm of the product, gives the same number. We can do that here because
50 probabilities still give a product that R can represent; with the 1,000 counts of the previous
slide it would return minus infinity.

**Delivery**

Show the chunk without running it. If students ask about `getAll()` or `MakeADFun()`, say that
they appear four slides later.

## Slide 12 — Practice 1: crab burrows

**Short activity — allow about three minutes of work and two to discuss**

Students work on paper. Wait about three minutes and then go through the solution.

The likelihood is the product of the three contributions,
$e^{-\lambda}\lambda^{3}/3!\times e^{-\lambda}\lambda^{1}/1!\times e^{-\lambda}\lambda^{2}/2!=e^{-3\lambda}\lambda^{6}/12$.
For $\lambda=2$ it is $64e^{-6}/12\approx 0.0132$ and the log-likelihood is
$-6+\log(64/12)\approx -4.33$. For $\lambda=3$ it is $729e^{-9}/12\approx 0.0075$ and the
log-likelihood is $-9+\log(729/12)\approx -4.89$. The data are better supported by $\lambda=2$,
which is the mean of the three counts. The difference between the two log-likelihoods is 0.57, so
the counts are about 1.8 times more probable ($e^{0.57}$) under $\lambda=2$ than under
$\lambda=3$.

Common slips are to forget the factorials ($3!\,1!\,2!=12$) and to compare the log-likelihoods as
if they were likelihoods. Remind students that a difference of log-likelihoods is the logarithm of
a ratio of likelihoods.

Break (10 minutes).

## Slide 13 — The maximum likelihood estimator

The **maximum likelihood estimator** (MLE) of a parameter is the value for which the likelihood of
the observed sample is highest, $\hat\theta=\arg\max_\theta L(\theta\mid x_1,\ldots,x_n)$, and it
is the same as the value that maximises the log-likelihood. The symbol $\arg\max$ reads "the
value of $\theta$ at which the function reaches its maximum": $\max$ would give the height of the
highest point and $\arg\max$ gives its location. In plain English, the MLE is the parameter value
under which the model assigns the highest probability to the data that we observed. As in Chapter
3, the procedure of calculation is called the estimator and the value that it returns for a given
sample is the estimate, and we use the abbreviation MLE for both.

At the highest point of the log-likelihood its slope is zero. We can differentiate the
log-likelihood, set the derivative to zero and solve for the parameter. A solution that can be
written as a formula is called a closed-form solution, and it exists only for a few models. For
the others, the equations that we obtain cannot be solved with algebra, and we search for the
maximum numerically. That is the method that we use in the rest of the book, because it works for
any model for which we can write a likelihood.

For i.i.d. Poisson counts the closed-form solution is the mean of the sample,
$\hat\lambda=\overline x$, which for the 50 counts is 2.14 seedlings per quadrat. It is also the
method-of-moments estimator of Chapter 3. The derivation is in the chapter, in the box "Statistical
detail: deriving the Poisson estimator", and the calculus refresher has the rules of
differentiation. The Normal model is another case with a closed form: the MLE of $\mu$ is the
sample mean and the MLE of $\sigma^2$ is the variance with divisor $n$, so the MLE of the variance
is biased.

**Delivery**

Do not derive the Poisson estimator on the board. The derivative of the log-likelihood with
respect to a parameter is called the score; name it only if a student asks.

## Slide 14 — The likelihood curve

A **likelihood curve** is the log-likelihood of a model with one parameter, drawn as a function of
that parameter. We draw it as the relative log-likelihood, $\ell(\theta)-\ell(\hat\theta)$, so that
the curve is zero at the estimate and negative everywhere else. All the likelihood figures of the
chapter are on this scale, because only differences in log-likelihood are meaningful. How fast
the curve falls on each side of the maximum tells us how well the data discriminate between
parameter values, which is what Lecture 2 uses to calculate confidence intervals, and the curve
need not be symmetric.

The example uses the first ten quadrats, because the shape of the curve is easier to see in a small
sample; Lecture 2 compares ten quadrats with 50. They contain 22 seedlings, so the estimate is 2.2
seedlings per quadrat. The curve falls more steeply to the left of the maximum than to the right:
the relative log-likelihood is $-3.33$ at $\lambda=1.2$ and $-1.76$ at $\lambda=3.2$, which are both
one seedling away from the estimate, so a mean of 3.2 is better supported by these data than a mean
of 1.2.

**Figure walkthrough — included in the four minutes**

The figure is a copy of the chapter figure. The horizontal axis is the mean number of seedlings per
quadrat from 0.8 to 5 and the vertical axis is the relative log-likelihood, cut at $-8$. The
vermillion curve is the relative log-likelihood and the dashed line marks the estimate at 2.2,
where the curve is zero. Point to the two sides: the left side reaches $-8$ at about 0.8 and the
right side reaches it only at about 4.7. The chapter draws the curve by evaluating the
log-likelihood on a grid of values of $\lambda$ with a `for` loop; the code is on the chapter page.

## Slide 15 — Numerical optimisation

An **optimiser** is an algorithm that searches for the parameter values at which a function reaches
its minimum. It starts from values that we provide, evaluates the function, and moves step by step
towards lower values until it cannot improve any further. A grid shows us the curve, but to find the
highest point of a log-likelihood for any model, with any number of parameters, we use an
optimiser. In R we use `optim()`. Because it minimises, we do not give it the log-likelihood but
the **negative log-likelihood** (NLL), $-\ell(\theta)$: the parameter value with the lowest NLL is
the one with the highest likelihood.

**Figure walkthrough**

The schematic has no numbers. The vermillion curve is the NLL against a parameter, shaped like a
bowl. The dark green arrows are the steps of the optimiser, from the starting value on the left
down the curve to its lowest point, which is the estimate on the horizontal axis. The picture
cannot show how the optimiser chooses each step; the method that we use, called BFGS, is explained
in Chapter 8.

## Slide 16 — The negative log-likelihood in R

In this book every NLL is written in the same form, which the package RTMB needs. It is a function
with two arguments, both of them named lists: the first holds the parameters (`parms`) and the
second the data (`data`). Its first line calls `getAll()`, which makes the elements of both lists
available by their names, so that the rest of the function reads like the model. It returns minus
the sum of the log probabilities. For the Poisson model the list of parameters has one element,
`lambda`, and the list of data has one element, `counts`.

**Delivery**

Say explicitly that this is the form of every NLL in the course, and that the first argument is
always the parameters and the second the data. The chunk only defines a function; nothing is
calculated yet.

## Slide 17 — From the negative log-likelihood to a fit

Three steps take us from the function to the estimate, and each has one name in code format. First,
`cmb()` is a small helper that takes an NLL and a list of data and returns the NLL of those data as a
function of the parameters only. This way we can calculate the same likelihood later on other data,
as long as the variables of the list have the same names. Second, `MakeADFun()` processes the NLL so
that the tools that we use in the rest of the course can work with it (the details are explained
progressively through the course). It takes the function returned by `cmb()` and a list with the
starting value of every parameter, and it returns an object that has three elements that we need:
`par`, the starting values as a vector; `fn`, the NLL as a function of that vector; and `gr`, the
gradients of the NLL, which are the slope that RTMB supplies so that the optimiser can move
efficiently (Chapter 6 explains how, and Chapter 8 the method). Third, `optim()` minimises `fn`
starting from `par` and using `gr`.

**Figure walkthrough**

The schematic has four boxes joined by arrows, from left to right: the NLL (a function of parameters
and data), `cmb()` (which adds the data), `MakeADFun()` (which adds the starting values and returns
`par`, `fn` and `gr`) and `optim()` (which returns `par`, `value` and `convergence`, the next slide).
Follow the arrows once, box by box, and do not explain what happens inside `MakeADFun()`.

## Slide 18 — A fit in R

These are the three chunks of the chapter, shortened. In step 1 we define `cmb()`. In step 2 we
connect `poisson_nll_lambda` to the 50 counts and process it, with a starting value of one seedling
per quadrat for `lambda`; `silent = TRUE` stops `MakeADFun()` from printing its progress. In step 3
`optim()` minimises `fn` from `par` with the slope `gr`; the argument `method` chooses the algorithm
and we use `"BFGS"` in most cases because it is efficient. The same three steps apply to every model
in the course. Only the NLL, the data and the starting values change.

**Delivery**

This is a slide to read slowly: take about a minute on each step. Say that any starting value from
which the optimiser reaches the maximum will do, and that the chapter will use the method of moments
for the owls only as one possible choice.

## Slide 19 — The result of `optim()`

`optim()` returns a list whose most relevant elements are `par`, the value of the parameter at the
minimum (the maximum likelihood estimate), `value`, the value of the NLL at that estimate, and
`convergence`, a code that is zero when the algorithm stopped normally. Check `convergence` after
every fit. If it is different from zero, the search did not finish normally and the values in `par`
are not estimates. For the 50 counts `par` is 2.14 seedlings per quadrat, the mean of the sample, as
the closed-form solution said.

**Delivery**

The chapter has a note callout "When a fit fails". Mention three things from it. While it searches,
`optim()` can try values for which the NLL cannot be calculated, and `fn` then returns `NaN` without
a warning; BFGS treats this as a failed step, so it is harmless when the search ends with convergence
code 0 and sensible estimates. When the NLL is `NaN` at the starting values, `optim()` stops with the
error "initial value in 'vmmin' is not finite". If a fit fails, check that every constrained
parameter is transformed inside the NLL, try other starting values and calculate the NLL at the
starting values, for example with `fn(par)` of the object. Chapter 8 explains why optimisers fail and
what else can be done.

## Slide 20 — Constraints and transformations

A **constraint** is a restriction on the values that a parameter can take. The mean of a Poisson
distribution must be positive, and a probability must lie between zero and one. An optimiser does not
know about these restrictions: it can try any real number, and for a negative $\lambda$ the function
`dpois()` returns `NaN`. In the fit above the search stayed among positive values, but that is not
guaranteed.

We deal with constraints by transforming the parameter. The optimiser works with a quantity that can
take any real value, and the NLL converts it into the parameter of the model. For a positive
parameter we use the logarithm, so the optimiser searches over $\log(\lambda)$ and `exp()` turns it
into a positive mean inside the NLL. For a probability we use the logit,
$\operatorname{logit}(p)=\log(p/(1-p))$, which covers all the real numbers as $p$ goes from zero to
one; `qlogis()` calculates it and `plogis()` is its inverse (the names come from the logistic
distribution). In the chunk the only change is the line `lambda = exp(log_lambda)`, and the list of
starting values now has `log_lambda`. The element `par` of the fit is the estimate of
$\log(\lambda)$, so we transform it back with `exp()` to report 2.14 seedlings per quadrat.

**Delivery**

The same NLL can be connected to the first ten quadrats by changing only the list of data, which
gives 2.2 seedlings per quadrat. This is the reason for `cmb()`, and both objects return in Lecture
2, so say that in one sentence and move on.

## Slide 21 — Invariance

Fitting on a transformed scale and reporting on the original scale relies on a property of maximum
likelihood called **invariance**: the MLE of a function of a parameter is that function of the MLE,
$\widehat{g(\theta)}=g(\hat\theta)$. The reason is that a transformation only relabels the horizontal
axis of the likelihood curve. Every value of $\log(\lambda)$ corresponds to one value of $\lambda$
with the same likelihood, so the highest point is the same on both scales. The optimiser found the
MLE of $\log(\lambda)$, and its exponential is the MLE of $\lambda$.

Invariance also gives the MLE of anything calculated from the parameter. Under the Poisson model the
probability that a quadrat has no seedlings is $e^{-\lambda}$, and its MLE is
$e^{-\hat\lambda}=e^{-2.14}\approx 0.12$. In the sample, 7 of the 50 quadrats are empty, a fraction
of 0.14. Invariance carries over the estimate but not unbiasedness: Chapter 3 showed that
$\hat\lambda$ is an unbiased estimator of $\lambda$ whereas $e^{-\hat\lambda}$ is a biased
estimator of $e^{-\lambda}$.

**Optional remark (citation)**

Zehna (1966), "Invariance of maximum likelihood estimators", *Annals of Mathematical Statistics* 37:
744, gives the general statement.

## Slide 22 — Practice 2: back to the ecological scale

**Short activity — allow about two minutes of work and one to discuss**

The colleague's two models are fitted with `optim()`. Students use R as a calculator, or
the calculator of their phone.

We apply the inverse of each transformation: `exp(0.92)` gives 2.5 ticks per lizard and
`plogis(q = -0.85)` gives a germination probability of 0.30. By invariance they are the maximum
likelihood estimates of the mean and of the probability, because the optimiser found the maximum
likelihood estimates of the logarithm and of the logit. Ask what would be wrong with reporting
`par` directly: it is on the scale of the optimiser, where a mean of 0.92 ticks and a probability
of $-0.85$ would not make sense. The break follows.

Break (10 minutes).

## Slide 23 — Models with several parameters

With several parameters the likelihood is a function of all of them jointly, and the MLE is the
combination of values with the highest likelihood. The definitions of the previous slides do not
change, but the likelihood is now a surface over the parameters and not a curve. This raises
questions that did not exist with one parameter: how to look at the likelihood, how the estimates of
the different parameters depend on each other, and what the data say about one of them. They matter
for the rest of the book, because the models of Chapters 6 and 7 always have several parameters.

The example is the barn owl data of the Chapter 3 practical. The data set `Owls` of the package
`glmmTMB` contains observations of barn owl nests (Roulin and Bersier 2007). For each visit of a
parent to a nest, the variable `SiblingNegotiation` is the number of calls that the nestlings made.
As in the practical, we keep the visits of the female parent to nests where the nestlings had been
fed (`Satiated`), so that all the counts can reasonably share one mean. There are 122 visits, from 24
nests, with a mean of 4.75 calls per visit and a variance of 42.3, almost nine times the mean.

Because of this overdispersion we use a Negative Binomial model with mean $\mu$ and shape $k$, with
$\operatorname{Var}(X_i)=\mu+\mu^2/k$ (the supplement describes the distribution). We assume that the visits are
i.i.d., which is a simplification because visits to the same nest may resemble each other; Chapter 7
covers models for such data.

## Slide 24 — A fit with two parameters in R

The NLL is written as before. The list of parameters now has one element for each parameter,
`log_mu` and `log_k`, and both parameters are positive, so we transform both with the logarithm. The
list of data has one element, `calls`. For the probability mass we use `dnbinom2()` of RTMBdist,
which is written in terms of the mean (`mu`) and the shape (`size`). The optimiser needs a starting
value for each parameter. The method-of-moments estimates, calculated as in the Chapter 3 practical
($\hat\mu\approx4.75$ and $\hat k\approx0.60$), are a sensible choice because they are quick to
calculate and estimate the same parameters, but any values from which the optimiser reaches the
maximum would do. `optim()` keeps the names of the parameters in its result, so we can select each
estimate by its name and transform it back.

The estimate of the mean is the mean of the sample, 4.75 calls per visit: for a Negative Binomial
model the MLE of the mean is the sample mean, whatever the value of $k$. The estimate of the shape is
$\hat k\approx 0.33$, far from the method-of-moments estimate of 0.60 at which the search started.
The two methods are different estimators, so they give different estimates from the same sample, and
Lecture 2 compares their precision.

**Delivery**

The chapter has a warning callout on the two functions called `dnbinom2()`. RTMB and RTMBdist both
have one, with different arguments (`mu` and `size` in RTMBdist, `mu` and `var` in RTMB). R uses the
one of the package attached last, so always load RTMB first and RTMBdist second and name the
arguments. If only RTMB is loaded, R stops with an error about an unused argument `size`. Say this
once and keep going.

## Slide 25 — Checking the fitted model

`optim()` returns estimates for any model that we give it, so after a fit we compare the fitted
model with the data. For counts we compare the relative frequency of each count in the sample with
the probability that the fitted model assigns to it. As a reference we add a simpler model, a Poisson
model with the same mean.

**Figure walkthrough — included in the three minutes**

The figure is a copy of the chapter figure. The grey bars are the relative frequencies of the number
of calls per visit, from 0 to about 26. The vermillion line with points is the fitted Negative
Binomial model and the dark grey line with points is the Poisson model. The bar at zero calls is
0.44 (54 of the 122 visits), and the Negative Binomial model gives it a probability of 0.41, whereas
the Poisson model gives about 0.009. The Negative Binomial model spreads the rest of its
probability over a wide range of counts, and the Poisson model concentrates it in a narrow peak
around 4 and 5 calls. The log-likelihood of the Negative Binomial model is about 335 units higher
($-299.44$ against $-634.16$). Lecture 2 compares the two models with a formal criterion, the Akaike
information criterion. The figure does not show that the Negative Binomial model is adequate; it
shows that it is much closer to the data than the reference.

## Slide 26 — The likelihood surface

With two parameters we can still evaluate the log-likelihood on a grid, which now has two dimensions:
one for the values of $\mu$ and one for the values of $k$. The chapter stores the results in a matrix
with one row per value of $\mu$ and one column per value of $k$, and fills it with two nested `for`
loops. Inside the loops it calls `fn` of the processed object, which returns the NLL for a vector of
parameters on the scale that was optimised, so we give it the logarithms of the candidate values and
change the sign of the result. `contour()`, from the Chapter 1 practical, draws the matrix.

Each contour joins the combinations of $\mu$ and $k$ with the same relative log-likelihood, like the
contours of a joint density in Chapter 2, and the MLE is at the top of the hill. The contours are not
tilted, which means that the estimates hardly depend on each other, because the best value of $\mu$
is the mean of the sample for every value of $k$. They are not symmetric either: the surface falls
more slowly towards large values of $\mu$ and of $k$ than towards small ones.

**Figure walkthrough**

The horizontal axis is the mean number of calls per visit (2.5 to 9) and the vertical axis is the
shape (0.12 to 0.75). The grey lines are contours and the vermillion circle is the MLE. Point to
the roughly upright egg-shaped inner contours and to the wider spacing towards the upper right.

**Optional minute (interactive page)**

If the connection allows, open Kristoffer Magnusson's page
<https://rpsychologist.com/likelihood/> for about a minute, inside the four minutes. It uses a Normal
model with a mean and a variance and a sample of ten observations. In "Likelihood Calculation" move
the sliders and watch how the contribution of each observation and the log-likelihood change, and in
"Finding the Maximum Likelihood Estimates" watch an algorithm climb the log-likelihood. The last part
of the page is about hypothesis tests, which the course does not use. The static figure is the
fallback.

## Slide 27 — Parameterisation

The same model can be written with different sets of parameters, each of which is a
**parameterisation**. By invariance, the maximum and the fitted model are the same in every
parameterisation, but the shape of the surface around the maximum is not. The Negative Binomial
distribution can also be written with the shape $k$ and a probability $p=k/(k+\mu)$, which are the
arguments `size` and `prob` of `dnbinom()`. In this parameterisation the maximum log-likelihood is
$-299.44$, the same as before, and $\hat p\approx 0.064$.

**Figure walkthrough — included in the four minutes**

The figure is the chapter figure of slide 29, and here only the left panel matters. It has $k$ on the
horizontal axis and $p$ on the vertical axis. The contours are elongated rings tilted upwards to the
right: a larger $k$ goes with a larger $p$, because the two together determine the mean, which the data
pin down well. Say that the two lines and the right panel are explained on the next slides, and ask
students to ignore them for now. Tilted contours describe estimates that depend on
each other. Whether they are tilted depends on the model, its parameterisation and the data, so one
example cannot be generalised.

The course writes distributions in terms of their mean where possible, because the models of later
chapters describe how the mean changes with covariates. The choice of parameters also matters for
numerical optimisation, which Chapter 8 covers.

## Slide 28 — Slices and profiles

A surface can only be drawn for two parameters, and even then we usually want to know what the data
say about one parameter at a time. There are two ways of reducing a likelihood surface to a curve
for one parameter, and they answer different questions. Let $\theta_1$ be the parameter of interest
and $\theta_2$ the other parameter, or parameters. A **slice** fixes the other parameters, normally at
their estimates, and varies the parameter of interest: it is a cut through the surface along a
straight line. A **profile** re-estimates the other parameters for every value of the parameter of
interest, $\ell_{\mathrm{prof}}(\theta_1)=\max_{\theta_2}\ell(\theta_1,\theta_2)$. In plain English, for
each value of $\theta_1$ we find the value of $\theta_2$ that maximises the log-likelihood with
$\theta_1$ held fixed, and we record that maximum. Which parameter we profile depends on the question.

In the example, $\ell(k,\hat p)$ is a slice and $\max_p\ell(k,p)$ is the profile of $k$.

**Delivery**

No name is introduced for the parameters that the profile re-estimates; say "the other parameters".
The slide does not say how the profile is calculated. Slide 29 shows what it is and the demo shows
how TMB calculates it.

## Slide 29 — Slice against profile

The slice follows the horizontal line at $\hat p$, which leaves the high part of the surface quickly
because the contours are tilted. The profile follows the ridge of the surface: for each $k$ it moves
to the best $p$. Both pass through the MLE, and everywhere else the profile is higher than the
slice, because it is a maximum over all the values of $p$. The slice is therefore narrower. It
describes what the data would say about $k$ if we knew $p$ exactly, whereas the profile takes into
account that $p$ is estimated from the same data. The profile does not depend on how the other
parameters are written, whereas a slice does: with $\mu$ and $k$, where the contours are not tilted,
the slice and the profile of $k$ coincide.

We use profiles to calculate confidence intervals, in Lecture 2. Slices need no optimisation, so they
are a quick way to inspect a fitted model, and they return as a diagnostic in Chapter 8.

**Figure walkthrough — included in the four minutes**

The figure is a copy of the chapter figure and has two panels. On the left, the tilted contours in
$k$ and $p$ with a dashed vermillion line at $\hat p$ (the slice) and a solid vermillion line along
the ridge (the profile), both passing through the circle of the estimate. On the right, the relative
log-likelihood against $k$ along the slice (dashed) and along the profile (solid). Both curves are zero
at about 0.33 and the profile is above the slice everywhere else. The figure draws no cutoff. Within
1.92 units of the maximum, which is the level that Lecture 2 justifies and that the example of the
slide uses to compare the two widths, the slice covers $k$ from 0.26 to 0.41 and the profile from 0.24
to 0.45. Leave the questions about how the profile is calculated for the demo.

## Slide 30 — Live demo: a likelihood profile in R

The demo shows on the owl model what slides 27 to 29 describe. It uses the script `demo-profile.R`,
which runs in a clean R session in a few seconds and needs the packages RTMB, RTMBdist, TMB and
`glmmTMB` (for the data). It writes the NLL in the parameterisation with $k$ and $p$, so that
the slice and the profile differ, and no profile is calculated by hand: TMB does it, as in the
chapter. The script has a section "0. Packages and data" and then one section for each of the four
steps of the slide.

Run section 0 during the second break, or while students arrive, and keep the R session open. It
loads RTMB first and RTMBdist second, loads the owl data, calculates the method-of-moments estimates
for the starting values and defines `cmb()`. Spend the two minutes at the slide reading the four
steps, and then switch to R.

**Walkthrough of the script — 16 minutes**

1. **The fit (section "The fit with k and p", about 4 minutes).** The NLL `nb_prob_nll` has two
   parameters, `log_k` and `logit_p`: `k = exp(log_k)` and `p = plogis(logit_p)`, and `dnbinom()` with
   `size = k` and `prob = p`. Process it, starting from the method-of-moments estimates, and fit it.
   `convergence` is 0. The estimates are $\hat k\approx 0.327$ and $\hat p\approx 0.064$, and the maximum
   log-likelihood is $-299.44$, the same as with $\mu$ and $k$. Ask students why (invariance, slide 21
   and slide 27). The surface of this model is the left panel of slides 27 and 29, calculated with the
   grid of `fn` of slide 26.
2. **The slice (section "The slice", about 3 minutes).** One `for` loop over a fine grid of $k$ with
   $p$ fixed at its estimate: each value needs only one call of `fn`, with `log(k)` and `qlogis(p_mle)`.
   Subtract the maximum log-likelihood to get the relative scale.
3. **The profile (section "The profile", about 5 minutes).** `TMB::tmbprofile(owl_prob_obj, name =
   "log_k", ytol = 6, trace = FALSE)`. Explain the arguments: the processed object, the name of the
   parameter as it is written in the list of parameters, and `trace = FALSE` to stop printing. The
   prefix `TMB::` is needed because RTMB does not export the function. At every value of `log_k` that it
   visits, `tmbprofile()` runs an inner fit that re-estimates `logit_p`, so this is the definition of
   slide 28 carried out by TMB. By default it stops about two units below the maximum, which is enough
   for a 95% interval; `ytol = 6` continues it to the lower limit of the plot. The data frame has the
   columns `log_k` and `value` (the NLL), which we convert to $k$ and to the relative log-likelihood.
4. **Both curves (section "Both curves", about 3 minutes).** The plot shows the profile as a solid line
   and the slice as a dashed line, on the relative log-likelihood. The slice is narrower, and the
   profile is above it everywhere except at the maximum: the right panel of slide 29, drawn in base R.
   Ask the questions below.

**Questions to ask during the demo (about 1 minute)**

Ask "slice or profile?" for each item and take one answer:

1. $k$ varies with $p$ fixed at its estimate: a slice.
2. $k$ varies with $p$ re-estimated at each value: a profile.
3. What the data would say about $k$ if we knew $p$ exactly: a slice.
4. A curve that takes into account that $p$ is estimated from the same data: a profile.

If time allows, use question 6 of the chapter quiz, "two curves for one parameter".

## Slide 31 — The Chapter 4 R practical: first part

The practical has five exercises. After this lecture, students can do the first two partly.
Exercise 1 is worked on the page, so read it first. It uses the survival of reed frog tadpoles in the
24 tanks with predators (`ReedfrogPred` of `emdbook`; Vonesh and Bolker 2005) under a Binomial model
with one survival probability. Questions 1 to 3 apply this lecture: the likelihood contributions of
the first three tanks by hand, the maximum likelihood estimator by differentiating the log-likelihood,
and the NLL with the logit of $p$ as the parameter, fitted with `optim()`. Question 3 also asks for
standard errors, which belong to Lecture 2, so students leave them for later. Exercise 2 uses the
number of glacier lily seedlings in 256 quadrats (`Lily_sum` of `emdbook`) under a Negative Binomial
model, like the owls. Questions 1 to 3 are the method of moments, the fit and the contours of the
surface; the joint confidence region of question 3 belongs to Lecture 2.

Try each question before opening the solution.

## Slide 32 — Summary and closing questions

Go back to slide 3 by speaking about it again; no new slide is needed. The likelihood is the
probability of the sample, read as a function of the parameters, and it is used to compare parameter
values. The log-likelihood is a sum, and only differences between log-likelihoods are meaningful. The
MLE is the value with the highest likelihood, and we find it with `optim()` after writing the NLL in
the form of the course, connecting it to the data with `cmb()` and processing it with `MakeADFun()`.
Transformations keep parameters in range and invariance carries the estimate back to the ecological
scale. With several parameters the likelihood is a surface whose shape depends on the
parameterisation, although the maximum does not. A slice fixes the other parameters and a profile
re-estimates them, and `TMB::tmbprofile()` calculates profiles for us.

Return to this slide for the two closing questions.

**Discussion and expected answers — allow about two minutes**

Question 1: because a likelihood is the probability of the data for a given value of the parameter,
and the parameter is a fixed quantity of the model; there is no probability that refers to it. Also,
the likelihoods of all possible parameter values need not add up or integrate to one.

Question 2: because a slice treats the other parameters as known, at their estimates, whereas a profile
re-estimates them for every value of the parameter of interest, and so it never falls below the slice.
When the other parameters are poorly determined, or their estimates depend on the parameter of
interest, the difference is large.

**Final transition**

After a short practical session, Lecture 2 asks how uncertain these estimates are: what the curvature
of the log-likelihood tells us about standard errors, how likelihood profile intervals are calculated,
and why maximum likelihood works.

## Adjustments during delivery

The slides take 125 minutes and leave 5 minutes of slack, which comes last. The demo is kept whole; if
it overruns, it takes the slack first. If discussion overruns, use the slack first, then shorten in
this order:

- Slide 3 to one sentence ("this lecture is the likelihood and the optimiser"): recovers about half a
  minute.
- Slide 4 to the table of the two columns: about one minute.
- Slide 19 to its bullets, with the callout on failed fits left to the chapter: about one minute.
- Slide 25 to the figure alone, without the sentence on the Poisson model: about one minute.
- Slide 26 without the optional minute of Magnusson's page: about one minute.
- In the demo, skip the slice code and show only its curve in the final plot: about three minutes.

Keep the difference between probability and likelihood (slides 6 and 8), the steps of a fit (slides
16 to 19), and slice against profile (slides 28 and 29).

The breaks are placed between the blocks, after slides 12 and 24 (minutes 36 and 93). If a block runs
over, shorten the block rather than the following break.

**If time is left: code to run**

No code is run live apart from the demo. Students can follow the chunks of the chapter page at home,
by section: "The likelihood function" (`prod(dpois())` for the first three quadrats and the 50 counts),
"The log-likelihood" (the 1,000 simulated counts with seed 501), "The likelihood curve" (the grid
and the `for` loop for the ten quadrats), "Numerical optimisation" and "Constraints and
transformations" (the fits of the Poisson model), and "Models with several parameters" (the owl fit
and the grid of nested `for` loops for the surface).
