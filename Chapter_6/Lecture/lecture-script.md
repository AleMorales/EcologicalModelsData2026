# Chapter 6 lecture script: Fitting ecological response curves

Draft for the course author's review. **Target: 150 minutes in total, with 117 minutes of
slides on 31 slides (including the discussion, the three practice questions and one live demo
of 18 minutes), 13 minutes of slack and two breaks of 10 minutes.** The breaks separate the three
blocks of the lecture. The only code that is run live is the demo of slide 23, from the script
`demo-cycle.R`.

This script follows the [Chapter 6 theory](../Theory.qmd) from the introduction to the recipe,
with a short introduction to the [R practical](../Practicals/no_solution.qmd). The lecture goes
round the modelling cycle once with one data set, the reed frog functional response: the
model, the fit, the uncertainty of the parameters and of the curve, the check with residuals,
the revision of the observation model and the comparison of candidate models. The slides carry
keywords only; the narrative is here.

Slide 3 uses your diagram `ModelCycle.png` from the Chapter 1 lecture folder. Slides 5
(`curve-distribution.png`), 11 (`fitted-curve.png`), 14 (`parameter-derivatives.png`), 17
(`curve-band.png`) and 21 (`residuals-binomial.png`) use figures in `lecture-assets/`. All five
are unchanged copies of chapter figures: `fig-curve_distribution`, `fig-fitted_curve`,
`fig-curve_band` and `fig-residuals_binomial` of Chapter 6, and `fig-parameter_derivatives` of
Chapter 5, because the Chapter 6 theory has no figure of partial derivatives. Their code is in
`lecture-assets/figures.R`, which runs the chapter's chunks in the chapter's order with the
chapter's seed, so the residual plot is the one on the chapter page. If the chapter figures
change, run that script again (it takes a few seconds).

## Timing and slide sequence

Times are measured from the start of the session and include the breaks.

| Slide | Topic | Minutes | Elapsed time |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | Two pillars: functions and distributions | 3 | 4–7 |
| 5 | A response curve as a parameter of a distribution | 4 | 7–11 |
| 6 | What the curve must return | 4 | 11–15 |
| 7 | Practice 1: seedlings and light | 3 | 15–18 |
| 8 | The likelihood of a response curve | 4 | 18–22 |
| 9 | The negative log-likelihood in R | 4 | 22–26 |
| 10 | Starting values and the fit | 4 | 26–30 |
| 11 | Reading the fitted curve | 3 | 30–33 |
| 12 | The gradient and automatic differentiation | 3 | 33–36 |
| | Break | 10 | 36–46 |
| 13 | Precision and correlation of curve parameters | 4 | 46–50 |
| 14 | Where the data lie | 4 | 50–54 |
| 15 | Likelihood profile intervals of curve parameters | 4 | 54–58 |
| 16 | The uncertainty of a fitted curve | 4 | 58–62 |
| 17 | A confidence band | 4 | 62–66 |
| 18 | Practice 2: handling time of a ladybird | 3 | 66–69 |
| 19 | Simulating from a fitted model | 3 | 69–72 |
| 20 | Scaled quantile residuals | 4 | 72–76 |
| 21 | Reading residual plots | 4 | 76–80 |
| 22 | Discussion: what does a residual pattern tell us? | 3 | 80–83 |
| | Break | 10 | 83–93 |
| 23 | Live demo: the modelling cycle for one model | 2 + 16 | 93–111 |
| 24 | Revising the observation model | 4 | 111–115 |
| 25 | Practice 3: fruit set in inflorescences | 3 | 115–118 |
| 26 | Candidate models | 3 | 118–121 |
| 27 | AIC, AICc and BIC | 5 | 121–126 |
| 28 | Comparing the candidates | 4 | 126–130 |
| 29 | A recipe for a response curve | 2 | 130–132 |
| 30 | The Chapter 6 R practical | 2 | 132–134 |
| 31 | Summary and closing questions | 3 | 134–137 |
| | Slack for discussion | 13 | 137–150 |
| | **Total** | **150** | |

Slides 117 minutes (blocks of 36, 37 and 44, the demo included), slack 13, breaks 20: 150
minutes. The break before the demo lets you open R and run section 0 of `demo-cycle.R`.

## Slides 1 and 2 — Ecological Models and Data Analysis; Overview of the lecture

In this lecture, we learn how to fit an ecological response curve to data: a deterministic
function of a predictor describes one parameter of the distribution of each observation, and
the parameters of the function are estimated by maximum likelihood. Once the curve is fitted,
we ask how precisely its parameters and the curve itself are estimated, whether the fitted
model describes the data, how to revise it where it does not, and which of several candidate
models the data support.

The session has three blocks, separated by two breaks. The first block builds the model and
fits it, and ends with the gradient that RTMB supplies to the optimiser. The second is about
the uncertainty of the parameters and of the curve, and about checking the fitted model with
residuals calculated by simulation. The third starts with a live demo of the whole cycle for
one model, then revises the observation model and compares four candidate models with
information criteria. It ends with the recipe, the practical and the
summary.

**Delivery**

Read the overview at the pace of the list, one keyword and its question at a time, and do not
explain any term yet.

## Slide 3 — Where we are: the modelling cycle

This lecture goes round the whole cycle once, with one data set. In the model box it is the entry
"covariates (5 and 6)": Chapter 5 studied the deterministic functions, and this chapter makes
one of them a parameter of a distribution. In the comparison box it adds BIC to the
AIC and AICc of Chapter 4, and it checks how well a fitted model describes the
data. A check that fails sends us back to the model, which is why modelling is a cycle, and the
lecture follows this path: model, estimation, check, revision, comparison, answer.

**Delivery**

One minute. Point to "covariates (5 and 6)" and "information criteria (4 and 6)", and to
the arrow that leads from comparison back to the model.

## Slide 4 — Two pillars: functions and distributions

The book has been built on two pillars. Chapters 2 to 4 gave us probability distributions for
the observations and estimated their parameters by maximum likelihood; in Chapter 4 every
observation had the same distribution. Chapter 5 studied deterministic functions that describe
how an expected response changes with a predictor, without any statistics. A response curve
joins the two: the curve gives a parameter of the distribution of each observation, so the
parameter changes from one observation to the next with the predictor.

One example runs through the lecture: the functional response of dragonfly larvae that prey on
reed frog tadpoles, from Vonesh and Bolker (2005), "Compensatory larval responses shift
trade-offs associated with predator-induced hatching plasticity", *Ecology* 86: 1580–1591. The
data are `ReedfrogFuncresp` in the package `emdbook`. Sixteen tanks were stocked with 5 to 100
tadpoles together with three dragonfly larvae, and the number of tadpoles killed in 14 days was
counted. These are the data that Chapter 5 used as a backdrop: it read an asymptote of about 60
tadpoles killed and a half-maximum of about 120 tadpoles per tank by eye, and those values
become our starting values on slide 10. We treat every tank as an independent observation;
Chapter 7 extends the models to observations that come in groups.

**Delivery**

The two columns appear one at a time, then the example and the takeaway. Ask students what the
response and the predictor are in these data before the example appears (the number killed; the
initial number of tadpoles).

## Slide 5 — A response curve as a parameter of a distribution

A **response curve** gives one parameter of the distribution of each observation as a function
of a predictor. Let $Y_i$ be the $i$-th observation and $x_i$ the value of the predictor at
which it was made. The parameter of its distribution is $\theta_i=f(x_i;\boldsymbol\beta)$,
where $f$ is a deterministic function of the kind studied in Chapter 5 and $\boldsymbol\beta$
is the vector of its parameters (the semicolon separates the input of the function from its
parameters). Usually $\theta_i$ is the mean, because the curves of Chapter 5 describe how an
expected response changes with a predictor. The other parameters of the distribution, such as
the standard deviation of a Normal model or the shape of a Negative Binomial model, are often
shared by all the observations.

So every observation has a distribution of the same family, with its own value of the parameter
that follows the curve. We still treat the observations as independent, but they are no longer
identically distributed: two observations made at different values of the predictor have
different distributions, and the distribution of each depends on the known value of its
predictor. This is the change from Chapter 4. The observation model is a choice, in the same way
as the curve is (Chapter 2, "Choosing a distribution"), and in this lecture we will revise it
(slide 24).

For the reed frogs, $K_i$ is the number killed in tank $i$, which was stocked with $N_i$
tadpoles. Each tadpole of a tank is either killed or not, so we use a Binomial model with $N_i$
trials, in which the curve gives the probability that a tadpole is killed,
$p(N)=\alpha/(1+\alpha HN)$. Here $\alpha$ is the attack rate and $H$ the handling time of the
Holling type II form of the disc equation (Chapter 5, "Reparameterisation"). The predictor, the
initial number of tadpoles, is also the number of trials.

**Figure walkthrough**

The blue points are the 16 tanks. The vermillion line is the expected number killed under the
curve with the values read by eye in Chapter 5, $\alpha=0.5$ per experiment and $H=1/60$
experiments per tadpole killed. At 10, 50 and 100 tadpoles per tank, the horizontal bars show the
Binomial probability of each possible number killed, with a length proportional to the
probability. They are the distributions of three tanks: each tank has its own, centred on the
curve, and the spread increases with the number of tadpoles in the tank. The figure shows the
model before any fitting; the next slides fit it.

## Slide 6 — What the curve must return

The curve must return a value in the range of the parameter that it describes. A mean count
cannot be negative and a probability must lie between 0 and 1, whereas the functions of Chapter
5 are not restricted in this way for every value of their parameters and of $x$. The table gives
the usual cases. For a Normal mean any curve will do. For the mean of a Poisson or Negative
Binomial distribution we need a curve that is positive for every $x$, or the exponential of
another curve. For a Binomial probability we need a curve between 0 and 1 for every $x$, or the
inverse logit of another curve. Chapter 5 ("Range and composition") showed how an outer function
gives a curve the range that a quantity requires.

For the reed frogs the curve describes the probability and not the number killed, because a
Binomial distribution is written in terms of the number of trials and a probability. The
expected number killed is then $N\,p(N)=\alpha N/(1+\alpha HN)$, which is the disc equation of
Chapter 5. Under the assumptions of the disc equation, the probability of being killed decreases
with density because the larvae spend more of their time handling the prey that they have
caught. The units follow from Chapter 5: the tadpoles killed were counted over the whole
experiment, so $\alpha$ is a fraction per experiment (at low density, a tadpole is killed with
probability close to $\alpha$), and $H$ is in experiments per tadpole killed. With $0<\alpha<1$
and $H>0$, $p(N)$ lies between 0 and $\alpha$ for every density, so this curve has the range that
the Binomial distribution requires without an outer function. When we fit it, we keep $\alpha$
between 0 and 1 and $H$ positive with the transformations of Chapter 4 (slide 9).

The takeaway is the general point: the range of the curve is part of the model, and it is
chosen together with the observation model.

**Transition**

The next slide asks students to apply this to another distribution.

## Slide 7 — Practice 1: seedlings and light

**Short activity — allow about two minutes of work and one to discuss**

Students work on paper. Expected answers, from the chapter's solution:

1. The curve describes the mean $\lambda$ of the Poisson distribution, the expected number of
   seedlings per quadrat, which must be positive.
2. No: the straight line becomes negative for some values of $x$ unless $a$ and $b$ are
   restricted. Its exponential, $e^{a+bx}$, is positive for any $a$, $b$ and $x$.
3. Not if some quadrats have no light. The Michaelis–Menten function is positive for $x>0$, but
   it is zero at $x=0$. A Poisson distribution with a mean of zero gives probability one to a
   count of zero, so a quadrat without light that contains a seedling would have a probability of
   zero under the model, and the log-likelihood could not be calculated.

The third answer is the one that students usually miss: a curve can have the right range almost
everywhere and still fail at a value of the predictor that occurs in the data.

## Slide 8 — The likelihood of a response curve

The likelihood of a response curve is calculated as in Chapter 4: the observations are
independent, so the log-likelihood is the sum of the log probabilities (or densities) of the
observations. The difference is that each probability is calculated with the parameter of its own
distribution, which the curve gives at the predictor value of that observation. In the equation,
$y_i$ is the observed value of $Y_i$ and $P(Y_i=y_i\mid\boldsymbol\beta)$ is the probability that
the model assigns to it when the parameter of its distribution is $f(x_i;\boldsymbol\beta)$; any
shared parameter of the distribution is added to $\boldsymbol\beta$.

Everything else is the same as in Chapter 4: we write the negative log-likelihood (NLL) with two
lists, transform the constrained parameters, connect the NLL to the data with `cmb()`, process it
with `MakeADFun()`, minimise it with `optim()` and check the convergence. Two things are new. The
list of data holds the predictor as well as the response, and the starting values of the
parameters of the curve are read from a plot of the data, as in "Starting values by eye" in
Chapter 5.

For the reed frogs, each term of the sum is the log of the Binomial probability of the observed
number killed in one tank, with $N_i$ trials and the probability $p(N_i)$ of that tank, and the
log-likelihood adds up the 16 terms. It is a function of $\alpha$ and $H$ only, because the
numbers of tadpoles and the numbers killed are fixed by the data.

## Slide 9 — The negative log-likelihood in R

We load RTMB and RTMBdist (in that order, as in every chapter since Chapter 2) and the data, and
put the two variables that the NLL uses in the list of data: `initial`, the number of tadpoles
at the start of the experiment in each tank (the predictor and the number of trials), and
`killed`, the number killed (the response).

The NLL has the form of Chapter 4. `getAll()` makes the elements of both lists available by
name. The attack rate is a probability, so the optimiser works with its logit, `logit_alpha`,
which `plogis()` turns back into $\alpha$; the handling time is positive, so the optimiser works
with its logarithm, `log_H`, which `exp()` turns back into $H$. Because `initial` is a vector,
the line of the curve returns a vector with one probability for each tank, and `dbinom()` uses
the number of trials and the probability of each tank. The sum of the log probabilities, with
a minus sign, is the NLL.

**Delivery**

Show the chunk without running it; the demo of slide 23 runs it. Point at the line of the curve
and say that this is the only line that a response curve adds to an NLL of Chapter 4: the rest
is the same recipe.

## Slide 10 — Starting values and the fit

Chapter 5 read $a=60$ tadpoles killed and $b=120$ tadpoles per tank from a plot of these data, in
the Michaelis–Menten form $ax/(b+x)$. They correspond to $\alpha=a/b=0.5$ per experiment and
$H=1/a=1/60$ experiments per tadpole killed. We give them to `MakeADFun()` on the transformed
scales, $\operatorname{logit}(0.5)=0$ and $\log(1/60)$, connect the NLL to the data with `cmb()`,
and minimise it with `optim()`, BFGS and the gradient `gr` (slide 12 says what the gradient is).
A convergence code of zero is the first check. The estimates are then transformed back to the
original scale: $\hat\alpha\approx0.526$ per experiment and $\hat H\approx0.0166$ experiments per
tadpole killed.

Starting values read from a plot are the general route for a response curve: the curve has
parameters with a meaning (an initial slope, an asymptote, a half-maximum), and Chapter 5 taught
how to read them from the data. Any starting values from which the optimiser reaches the maximum
will do; values by eye are a reliable way to find such values.

**Delivery**

Show the chunk without running it. The two estimates are in the comments.

## Slide 11 — Reading the fitted curve

A figure of a fitted response curve shows the observations as points and the expected response
under the fitted model as a line. By invariance (Chapter 4), the estimates of other quantities of
the curve follow from the estimates of its parameters. Two are useful here: the largest number of
tadpoles that the larvae could kill in one experiment, $1/H$, which is the asymptote of the
expected number killed, and the density at which the expected number killed reaches half of that
asymptote, $1/(\alpha H)$. These are the parameters $a$ and $b$ of the Michaelis–Menten form.

With the estimates, the larvae could kill at most about 60 tadpoles in one experiment, and the
expected number killed reaches half of this at about 115 tadpoles per tank. These values are close
to the 60 and 120 that Chapter 5 read by eye. That is not surprising: the initial slope of the
curve can be read from the tanks at low density, and the asymptote that Chapter 5 chose happened
to be close to the estimate. Chapter 5 also found that these data say little about the asymptote,
and slides 13 to 15 show what this means for the uncertainty of the estimates.

A convergence code of zero is the first check of a fit. The next is whether the fitted model
describes the data, which we check with residuals in slides 19 to 21. When the code is not zero,
the note "When a fit fails" in Chapter 4 says what to try.

**Figure walkthrough**

The blue points are the 16 tanks. The solid vermillion curve is the expected number killed under
the Binomial model fitted by maximum likelihood, and the dashed curve the one with the values read
by eye. The two nearly coincide over the range of the data, and both are still rising at 100
tadpoles per tank. The figure does not show how uncertain the fitted curve is; that is slide 17.

## Slide 12 — The gradient and automatic differentiation

Since Chapter 4 we have given every NLL to `MakeADFun()` before fitting it, and we said that RTMB
supplies the slope that BFGS uses. We can now say what that slope is. The **gradient** of the NLL
is the vector of its partial derivatives with respect to the parameters (Chapter 5, "Derivatives
with respect to parameters"), that is, its slope in the direction of each parameter. RTMB
calculates it by **automatic differentiation**: from the code of the NLL, exactly up to rounding
error, and without a formula from us. The element `gr` of the object returns the gradient at the
parameter values that we give it, on the scale that is optimised, with one column per parameter.

At the starting values the gradient is $-4.30$ for `logit_alpha` and $3.20$ for `log_H`. Its
signs tell BFGS in which direction to move each parameter to lower the NLL: a negative slope means
that increasing the parameter lowers the NLL, so $\alpha$ should go up; a positive one that $H$
should go down. The estimates moved that way, slightly. At the estimates both elements are close
to zero, as they should be at a minimum.

An exact gradient matters for response curves for three reasons. First, BFGS uses it at every
step. Without `gr`, `optim()` approximates the gradient by evaluating the NLL at nearby values of
every parameter (Chapter 8 explains how), which costs time and accuracy. Second, the parameters
of a curve are often correlated (slide 13), so the NLL forms a narrow and tilted valley like the
one of the owl model in Chapter 4. In such a valley the direction of the next step depends on
small differences between the partial derivatives, and an inexact gradient can stop the search
before it reaches the minimum. Third, the same derivatives are behind the other tools of the
course: `sdreport()` calculates the curvature of the NLL from them, `ADREPORT()` uses them for the
standard errors of quantities calculated from the parameters (slide 16), and in Chapter 7 they are
needed to integrate random effects out of the likelihood.

For RTMB to calculate these derivatives, the NLL must be written with operations and functions
that RTMB knows, which is why the probability functions of the course come from RTMB and
RTMBdist. RTMB works out the derivatives from the calculations that the NLL carried out when
`MakeADFun()` ran it at the starting values, so every calculation that involves a parameter must
have a derivative. A branch that depends on a parameter (an `if` that compares a parameter with a
value) does not: if it were recorded, only the side taken at the starting values would be used
afterwards. RTMB therefore refuses such a comparison, and `MakeADFun()` stops with the error
"Comparison is generally unsafe for AD types". In the same way, a curve with a sharp change at an
unknown threshold has no derivative at the change, and a smooth curve that approximates the sharp
change is the usual solution. The practical advice of the chapter: call the NLL directly with two
lists on sensible parameter values first, and inspect `fn` and `gr` at the starting values before
fitting.

**Optional remark**

The chapter explains in a box how automatic differentiation records and combines the operations of the NLL; mention it only if asked.

Break (10 minutes).

## Slide 13 — Precision and correlation of curve parameters

The uncertainty of the estimates is calculated from the likelihood, as in Chapter 4, and
`sdreport()` gives the standard errors and the covariance matrix from the curvature of the NLL. Two
features are typical of the parameters of a curve. Their estimates are often strongly correlated,
because different combinations of the parameters give similar curves over the range of the data.
And how precisely each parameter is estimated depends on where along $x$ the observations lie,
which is the subject of slide 14. The correlation also depends on the parameterisation, whereas the
fit does not, as Chapter 4 showed for the owl model in two parameterisations.

For the tanks, the standard errors on the optimised scales are 0.285 for
$\operatorname{logit}(\hat\alpha)$ and 0.294 for $\log(\hat H)$, and the correlation between the
two estimates is 0.82. It is positive because a steeper initial rise of the curve (a larger
$\alpha$) must be compensated by a stronger levelling off (a larger $H$) for the curve to pass
through the tanks at high density, so hypothetical samples that overestimate one parameter tend to
overestimate the other. In the Michaelis–Menten form, with $\log(a)$ and $\log(b)$, the same model
has the same maximum and a correlation of 0.98: the estimates of the asymptote and of the
half-maximum are almost interchangeable, because the data determine mainly their ratio, the
initial slope $a/b=\alpha$. This is what Chapter 5 found when it read starting values from these
data.

The two standard errors are similar on the optimised scales, but that does not make the two
parameters equally well determined: the next two slides show that the tanks determine $\alpha$
much better than $H$.

**Delivery**

Show the chunk without running it. The fit in the Michaelis–Menten form is a hidden chunk of the
chapter; quote its correlation without showing code.

## Slide 14 — Where the data lie

Chapter 5 showed with partial derivatives that a curve responds to each parameter in a different
part of its range. A **partial derivative** with respect to a parameter says how much the curve
moves at each $x$ when that parameter changes and the others stay fixed. The observations that
inform a parameter are those made where the curve responds to it. So data that cover only the rise
of a saturating curve determine its initial slope better than its asymptote, and the design of a
study (where along $x$ the observations are made) determines what can be estimated.

The densities of the reed frog experiment stop at 100 tadpoles per tank, below the estimated
half-maximum of 115, so the tanks cover less than half of the rise of the curve. They determine
$\alpha$, which describes the start of the curve, much better than $H$, which describes its end.

**Figure walkthrough**

The figure is Chapter 5's figure of the two partial derivatives of $ax/(b+x)$ with $a=60$ and
$b=120$, the values read by eye, for $x$ from 0 to 600. On the left, the derivative with respect
to the asymptote $a$ rises from 0 towards 1: a change in $a$ moves the curve most at large $x$,
where the curve is close to its asymptote. It is 0.5 at $x=120$. On the right, the derivative with
respect to the half-maximum $b$ is negative (a larger half-maximum means a lower curve), zero at
both ends and largest in size at $x=b$ (the dashed line), where it is $-a/(4b)=-0.125$. Point at
the part of the horizontal axis between 5 and 100, where the tanks lie: there the derivative with
respect to $a$ is still below one half, and both derivatives grow in size together, so a change in
one parameter can largely be compensated by a change in the other. That is the correlation of 0.98 of
slide 13. The axis labels of this copy are small at slide size; read the values aloud.

**Transition**

The intervals of the next slide put numbers on "well determined" and "poorly determined".

## Slide 15 — Likelihood profile intervals of curve parameters

Likelihood profile intervals are calculated with `TMB::tmbprofile()` and `confint()`, as in Chapter
4, and they remain the reference method. With a response curve, the profile of a poorly determined
parameter is often asymmetric, because the data rule out values on one side of the estimate much
more strongly than on the other. The endpoints of the interval can be transformed with any
monotonic function to give an interval for a quantity calculated from the parameter: an increasing
function keeps their order and a decreasing function swaps them. The coverage is kept, because the
transformed interval contains the transformed quantity in exactly the hypothetical samples in which
the original interval contains the parameter.

For the reed frogs, the interval for the attack rate runs from 0.40 to 0.68 per experiment, which
is narrow compared with the interval for the handling time, 0.0070 to 0.026 experiments per tadpole
killed, almost a factor of four. The largest number of tadpoles that the larvae could kill in one
experiment, $1/H$, decreases with $H$, so the endpoints swap: its interval runs from 38 to 143
around an estimate of 60. It extends 22 tadpoles below the estimate and 83 above it, and its upper
end lies beyond the largest density of the experiment. The data rule out a low asymptote, because
the larvae killed up to 35 tadpoles in one tank, but not a high one. The profile is asymmetric even
on the log scale, so the Wald interval from the log scale, 34 to 107 tadpoles, misses most of the
upper part of the profile interval.

**Delivery**

Show the chunk without running it; the demo draws the profile of `log_H`. `confint()` warns
"collapsing to unique 'x' values", because each profile contains the estimate twice; the warning can
be ignored, and the chapter's chunk suppresses it with a comment.

## Slide 16 — The uncertainty of a fitted curve

A point of the curve, such as the expected number killed at a given density, is a quantity
calculated from all the parameters. Its standard error is requested with `ADREPORT()`, as in Chapter
4, and TMB applies the delta method. `ADREPORT()` of a vector reports every element with its own
standard error. So if we pass a grid of predictor values in the list of data and calculate the
curve on that grid inside the NLL, `sdreport()` returns the curve and its standard error at every
point of the grid. From them we calculate a Wald interval at each point, on a scale on which the
quantity is unbounded, and transform the endpoints back, for the same reasons as for the parameters
in Chapter 4: the interval cannot cross a bound, and the log-likelihood is usually closer to a
parabola on that scale. For a probability, that scale is the logit. Together the intervals form a
**confidence band**.

The band is **pointwise**: at each value of $x$, the interval contains the value of the curve under
the data generating process at that $x$ in approximately 95% of hypothetical samples. A band that
contained the whole curve in 95% of hypothetical samples would be wider.

For the reed frogs, the grid holds the densities from 0 to 100 tadpoles per tank, as
`initial_grid` in the list of data, and the NLL gains three lines: the probability that a tadpole is
killed at every density of the grid, its logit with `qlogis()`, and `ADREPORT()` of that vector. We
process the new NLL and fit it again (the estimates do not change), and `summary()` of
`sdreport()` with `select = "report"` returns one row per density of the grid. The Wald interval of
each row is calculated on the logit scale, its endpoints are transformed back with `plogis()` and
multiplied by the density to give the band for the expected number killed.

Whether these intervals have a coverage close to 95% with 16 tanks can be checked by simulation, in
the same way as in "Coverage checked by simulation" in Chapter 4. The chapter does not do it; the
extra exercise of the practical does it for a quantity of a fitted curve.

**Optional remark**

The chapter gives the delta method for several parameters in a box; do not write the formula on the board unless asked.

## Slide 17 — A confidence band

A confidence band is read point by point: at each value of the predictor, the shaded interval is the
95% confidence interval of the expected response at that value. It describes the uncertainty of the
curve and says nothing about where the observations of new tanks would fall. That is described by the
distribution of the observations around the curve (slide 5), which is much wider, so many observations
lie outside a confidence band and this is no sign that something is wrong. Beyond the range of the data
the band widens quickly, because there the curve depends more and more on the parameters that the
data determine poorly.

For the reed frogs, on the logit scale the band is narrowest near 50 tadpoles per tank and wider towards
both ends. The tanks at low density hold few tadpoles each, so most of the information about the curve
comes from the denser tanks, and the band widens away from the middle of that information. For the
expected number killed the band also widens with density, because the probability is multiplied by the
number of tadpoles. At 100 tadpoles per tank it runs from 23.5 to 33.1 tadpoles killed, around an
expected 28. Within the range of the data the curve is well determined, although its asymptote is not.

**Figure walkthrough**

The blue points are the 16 tanks, the vermillion line is the fitted expected number killed, and the
light vermillion shading is the pointwise 95% band, calculated from Wald intervals on the logit scale.
Point out how many tanks lie outside the band, and ask why (the answer is the second bullet). The inset
gives the model, the estimates and their likelihood profile intervals: $\alpha$ is per experiment, $H$
in experiments per tadpole killed and $1/H$ in tadpoles killed per experiment. A figure that reports a
fitted response should show these together: data, curve, uncertainty, the model and the estimates
with their intervals.

## Slide 18 — Practice 2: handling time of a ladybird

**Short activity — allow about two minutes of work and one to discuss**

Students use R, or a calculator. Expected answers, from the chapter's solution:

1. The standard error belongs to $\log(\hat H)$, so the interval is calculated on the log scale and its
   endpoints transformed with `exp()`: `H_wald = exp(-3.2 + c(-1, 1) * qnorm(p = 0.975) * 0.20)` gives
   approximately 0.028 to 0.060 hours per aphid.
2. The inverse of the two endpoints, in reverse order, `rev(1 / H_wald)`: approximately 17 to 36
   aphids/hour, around an estimate of $1/e^{-3.2}\approx24.5$.
3. The function $1/H$ decreases as $H$ increases, so the lower endpoint of $H$ gives the upper endpoint
   of $1/H$, and the other way round. Because the function is monotonic, the second interval contains
   $1/H$ in exactly the hypothetical samples in which the first contains $H$, so it has the same
   coverage.

A common slip is to take `exp(0.20)` as a standard error of $\hat H$; recall Chapter 4: `exp()` of a
standard error is no standard error at all.

## Slide 19 — Simulating from a fitted model

A fitted model describes the whole distribution of every observation, and not only its expected value.
**Checking** the model means comparing that description with the data. In Chapter 3 the observations
had a common distribution, so we could compare their empirical distribution with the model distribution.
With a response curve each observation has a distribution of its own, and only one observation comes
from each of them. We therefore simulate many values from the distribution of each observation and see
where the observed value falls among them.

With its parameters at the estimates, a fitted model is a data generating process from which we can
simulate. As in Chapter 4, we mark the response with `OBS()` inside the NLL, and the function
`simulate()` of the processed object then draws one hypothetical sample for the parameter values that we
give it. A hypothetical sample has the same design as the data: the same observations, with the same
values of the predictor. Each simulated value is drawn from the distribution of its observation, so the
simulation contains the variation of the observations around the curve, which is what the check needs.

For the reed frogs, the NLL gains one line, `killed = OBS(killed)`, and we process and fit it again
(the estimates do not change). Each call to `simulate()` returns the numbers killed in 16 simulated
tanks with the initial numbers of the experiment, and the loop stores 1,000 hypothetical samples in a
matrix with one row per tank and one column per hypothetical sample.

**Delivery**

Show the chunk without running it; the demo runs it. Seed 601 gives the simulations of the chapter, and
so the residuals of slides 20 and 21.

## Slide 20 — Scaled quantile residuals

The **scaled quantile residual** of an observation is the fraction of its simulated values that are
smaller than the observed value. An observation in the middle of its simulated values has a residual
close to 0.5, one below all of them a residual of 0, and one above all of them a residual of 1. For a
discrete response, the observed value is often equal to some of the simulated values, and the residual is
then drawn at random between the fraction of simulated values that are smaller and the fraction that are
smaller or equal.

If the model describes the data generating process, each observation behaves like one more draw from its
own distribution, so it is equally likely to fall anywhere among its simulated values. The residuals are
then approximately uniform between 0 and 1, whatever the distribution of the observations and whatever
the values of the predictor. This is what makes them useful for response curves: they put observations
with different distributions on one common scale.

The package DHARMa calculates them. `DHARMa::createDHARMa()` takes the matrix of simulated values (one row
per observation, `simulatedResponse`), the observed values (`observedResponse`), the expected value of
each observation under the fitted model (`fittedPredictedResponse`, which DHARMa uses in its plots and in
the dispersion statistic of slide 21), and `integerResponse = TRUE` for a discrete response, so that ties
are drawn at random as described above.

For the reed frogs, one tank, with 50 tadpoles of which 5 were killed, lies below all its 1,000 simulated
values, so its residual is 0.

**Optional remark (citations)**

Dunn and Smyth (1996), "Randomized quantile residuals", *Journal of Computational and Graphical
Statistics* 5: 236–244, defined these residuals from the cumulative probability function of the model and
transformed them to the scale of a standard Normal distribution. DHARMa (Hartig, R package version 0.5.0)
calculates them from simulations and keeps them between 0 and 1.

## Slide 21 — Reading residual plots

Three kinds of pattern show that the model disagrees with the data. A distribution of the residuals that
is not uniform: too many residuals near 0 and 1 mean that the observations vary more around the curve
than the model allows, and too many near 0.5 that they vary less. A trend of the residuals against the
predictor or against the fitted values, which means that the curve misses a systematic change of the
response. And residuals of exactly 0 or 1, from observations outside the range of all their simulated
values, which DHARMa marks as outliers.

`plot()` of the result of `createDHARMa()` draws two panels: on the left a quantile–quantile plot of the
residuals against a uniform distribution, and on the right the residuals against the fitted values, on
the scale of their ranks, with the quartiles 0.25, 0.5 and 0.75 as dashed lines.
`DHARMa::plotResiduals()` with the argument `form` draws the residuals against any predictor. For the
reed frogs the expected number killed increases with the initial number of tadpoles, so the right panel
already shows the residuals in the order of the densities.

DHARMa summarises the spread with a **dispersion statistic**: the variance of the observed values around
their expected values, divided by the average of the same variance in the simulated samples. It is close
to one when the model allows the right amount of variation. For the reed frogs it is 2.9: the numbers
killed vary around the curve almost three times as much (as a variance) as the Binomial model allows.
This is **overdispersion** relative to the Binomial distribution, which Chapter 2 introduced for counts
relative to the Poisson distribution. The two tanks with 50 tadpoles, with 5 and 21 killed, show it in the
data: under the Binomial model they share the same distribution, in which 5 killed is very unlikely. The
model assumes that every tadpole of a tank has the same probability of being killed, independently of the
other tadpoles, and these tanks differ more than that assumption allows.

DHARMa also prints tests with p-values, on its plots and in functions such as `testDispersion()`. We read
the plots and the dispersion statistic as exploratory evidence and do not rest decisions on the p-values,
for the reasons given in Chapter 1 and at the end of Chapter 4: with 16 tanks a large p-value mainly says
that there are few data, and a small one does not say how much the disagreement matters.

The takeaway is the chapter's warning: a check shows where a fitted model disagrees with the data, not
which assumption is wrong. Overdispersion can come from the distribution, from a predictor that is missing
from the curve, or from observations that are not independent. Nor does a plot without a pattern show
that the model is right; with few observations only large disagreements are visible.

**Figure walkthrough**

The figure is DHARMa's own plot, as the chapter draws it. On the left, the lower points lie close to the
diagonal and the upper half of the residuals lies above it: more tanks than expected have residuals close
to 1. The star on the right panel, at zero, is the tank with 5 of 50 killed. On the right, the lines fitted
to the quartiles of the residuals lie on or outside the dashed lines, the upper one well above 0.75: the
tanks spread further from the middle of their simulated values than the model allows. There is no clear
trend against density, so the curve itself does not miss a systematic change. The printed tests are on the
figure because DHARMa draws them; point at the dispersion statistic in the example box instead.

## Slide 22 — Discussion: what does a residual pattern tell us?

This discussion applies the three kinds of pattern and the warning of slide 21.

**Discussion and expected answers — included in the three minutes**

Give students two minutes to label the four patterns with a neighbour, then take one answer per item.

1. **Curve:** the observations are lower than the model predicts at low $x$ and higher at high $x$, so the
   curve misses a systematic change: its shape is wrong, or a predictor that changes with $x$ is missing.
   It says nothing in particular about the distribution (quiz question 6 of the chapter).
2. **Distribution**, with the caveat of slide 21: the observations vary more than the model allows at
   every $x$, which a distribution with more variation (slide 24) may describe. A missing predictor or a
   lack of independence can produce the same pattern, so accept "cannot tell" if the student says why.
3. **Independence:** residuals of neighbouring quadrats that are alike mean that the observations share
   something that the model does not contain. Chapter 7 deals with observations that come in groups.
4. **Cannot tell:** with eight observations only large disagreements are visible, and a plot without a
   pattern does not show that the model is right.

Break (10 minutes).

## Slide 23 — Live demo: the modelling cycle for one model

The demo runs the steps of slides 8 to 21 for one model, the Binomial model with the Holling type II
curve, from the fit to the residuals, with the script `demo-cycle.R`. It has no model comparison: the
comparison follows on slides 26 to 28. The script needs the packages RTMB, RTMBdist, TMB (for
`tmbprofile()`), `emdbook` (for the data) and DHARMa. Its code and object names are those of the chapter,
and the simulation uses the chapter's seed (601), so the numbers and the residual plot agree with the
chapter and the slides. The whole script runs in a few seconds (about 6 seconds in a check in R 4.6.1),
so there is no waiting.

During the break, open R and run section 0, "Packages and data". It loads RTMB and RTMBdist (with their
messages about masked functions), prints the 16 tanks, builds the list of data `frog_data` and defines
`cmb()`. Keep the session open. Spend the two minutes at the slide reading the five steps, then switch to
R and run the sections one at a time.

**Walkthrough of the script — 16 minutes**

1. **The NLL and the fit (about 4 minutes).** Define the NLL and call it directly with two lists, the
   values by eye and the data: it returns 46.95. This is the check of slide 12, before processing. Then
   process it and print the gradient at the starting values, $-4.30$ and $3.20$: ask which way each
   parameter must move (up for $\operatorname{logit}(\alpha)$, down for $\log(H)$). Fit, and show the
   convergence code 0 and the gradient at the estimates (about 0.002 and $-0.005$, close to zero).
2. **Estimates and the curve (about 2 minutes).** $\hat\alpha=0.526$ per experiment,
   $\hat H=0.0166$ experiments per tadpole killed, an asymptote of 60.2 tadpoles killed and a half-maximum
   of 114.6 tadpoles per tank. The plot draws the tanks, the fitted curve (solid, vermillion) and the curve
   by eye (dashed). Point out that the two curves nearly coincide and that both are still rising at 100
   tadpoles per tank.
3. **Uncertainty of the parameters (about 3 minutes).** `summary()` of `sdreport()`: 0.104 with a standard
   error of 0.285 for `logit_alpha` and $-4.098$ with 0.294 for `log_H`; `cov2cor()` gives 0.82. The plot
   of the profile of `log_H` shows its asymmetry: it falls more slowly towards low values of $H$, that is,
   towards a high asymptote $1/H$, which the data rule out less strongly than a low one. `confint()` gives 0.0070 to 0.0264 for $H$ and, with the endpoints swapped,
   37.9 to 143.1 for $1/H$. R prints the warning "collapsing to unique 'x' values" twice; it can be ignored
   (slide 15).
4. **Uncertainty of the curve (about 3 minutes).** The grid of densities from 0 to 100 goes into the list of
   data, and the NLL gains `OBS()` (used in section 5; it does not change the fit) and the three lines of
   `ADREPORT()`. After the new fit, `head(band_summary)` shows one row per density; ask why the first row
   equals the row of `logit_alpha` of section 3 (0.104 and 0.285): at a density of zero, $p(0)=\alpha$. The
   band at 100 tadpoles per tank runs from 23.5 to 33.1 around 28.1 killed. The plot draws the band as
   dashed lines.
5. **Simulation and residuals (about 4 minutes).** One hypothetical sample first: the numbers killed in 16
   simulated tanks with the densities of the data. It is drawn before the seed is set, so its values differ
   at every run; that is the point (same design, different values). Then the 1,000 samples with seed 601,
   the expected values and `createDHARMa()`; `plot()` draws the figure of slide 21. The table of residuals
   shows the tank with 5 of 50 killed at 0.000, and six of the 16 tanks below 0.1 or above 0.9 (0.000,
   0.072, 0.078, 0.921, 0.961 and 0.978), where about three would be expected if the residuals were
   uniform. The dispersion statistic is 2.93. End by saying that this is where the cycle sends us back to
   the model: slide 24.

**Questions to ask during the demo (about 1 minute, within the sections above)**

1. In section 1, "What would happen if the NLL contained `if (H > 0.02)`?" `MakeADFun()` would stop with an
   error, because RTMB refuses a comparison of a parameter with a value (slide 12). Do not run it.
2. In section 4, "Do 95% of the tanks lie inside the band?" No: the band is for the expected number killed,
   and the tanks vary around it according to the Binomial distribution (slide 17).
3. In section 5, "Is the tank with 5 of 50 killed an error in the data?" The residuals cannot say: it is
   very unlikely under this model, which is what overdispersion means, and a model in which the probability
   varies among tanks may allow it (slide 24).

## Slide 24 — Revising the observation model

When the probability of an outcome varies among sampling units beyond what the predictor explains, the
counts vary more than a Binomial model allows. The **Beta-Binomial** distribution describes this situation:
the probability of each sampling unit is drawn from a Beta distribution, and the count of that unit follows
a Binomial distribution with this probability. With a response curve we parameterise it with the mean
probability $p$, which the curve gives, and the **precision** $\kappa$ (in the supplement $\kappa=a+b$, the
sum of the two shape parameters of the Beta distribution, so $a=\kappa p$ and $b=\kappa(1-p)$).

For a unit with $N$ trials, the mean is $Np$, as for the Binomial distribution, and the variance is the
Binomial variance $Np(1-p)$ multiplied by the factor $(\kappa+N)/(\kappa+1)$. The factor is larger than one
whenever $N>1$ and approaches one as $\kappa$ grows, so a small $\kappa$ means much variation among units
and a large $\kappa$ gives almost a Binomial distribution. Note that the factor grows with $N$: the
variation of the probability among units matters more when each unit has more trials. The precision is
positive, so we optimise $\log(\kappa)$.

The curve does not change: only the observation model is revised, so that the probability that a tadpole
is killed varies among tanks around $p(N)$. This is the step of the modelling cycle in which a check sends
us back to the model. The NLL uses `dbetabinom()` of RTMBdist, with the shape parameters $\kappa p$ and
$\kappa(1-p)$, and includes `OBS()` from the start, because this model is checked in the same way. The fit
starts from the estimates of the Binomial model and a precision of 10. The slide shows the call in words:
`dbetabinom()` takes the two shapes.

The estimates of the curve hardly change: $\hat\alpha\approx0.54$ per experiment and $\hat H\approx0.018$
experiments per tadpole killed. Their standard errors on the optimised scales are larger, 0.38 against 0.29
for $\operatorname{logit}(\hat\alpha)$ and 0.46 against 0.29 for $\log(\hat H)$. The Binomial model treated
every tadpole as an independent trial, so it took the tanks as more informative than they are. When the
probability varies among tanks, the tadpoles of a tank share part of their fate, and the information about
the curve depends more on the number of tanks than on the number of tadpoles; that is the takeaway. The
estimated precision, $\hat\kappa\approx26$, gives a variance factor of about 1.3 for a tank with 10
tadpoles and about 4.6 for a tank with 100. The check is repeated with the new object: the dispersion
statistic is now 0.92, and the tank with 5 of 50 killed lies within the range of its simulated values. The
Beta-Binomial model allows about as much variation among tanks as the data show.

**Delivery**

The code is on the chapter page ("A model for overdispersed proportions"); it is not run live. If a student
asks, the Beta-Binomial entry of the distribution supplement gives the other parameterisation.

## Slide 25 — Practice 3: fruit set in inflorescences

**Short activity — allow about two minutes of work and one to discuss**

Students work on paper. Expected answers, from the chapter's solution:

1. The Binomial variance is $20\times0.4\times0.6=4.8$. With $\kappa=5$ the factor is
   $(5+20)/(5+1)\approx4.17$, so the Beta-Binomial variance is $4.8\times25/6=20$, more than four times
   larger.
2. For a variance 10% larger the factor must be 1.1: $(\kappa+20)/(\kappa+1)=1.1$ gives
   $\kappa+20=1.1\kappa+1.1$, so $\kappa=189$.

The chapter's callout also asks students to verify the variance for $\kappa=5$ in R from the probability
mass; they can do that at home. The second answer shows how large $\kappa$ must be before a Beta-Binomial
model with 20 trials per unit is close to a Binomial one.

## Slide 26 — Candidate models

The candidate models of a comparison should represent plausible ecological or statistical alternatives,
and they must all be fitted to the same observations: the same rows, the same response and the same units.
Often some candidates are nested in others: a model is **nested** in another when it is the special case
obtained by fixing a parameter of the other at a particular value, as for the curves of Chapter 5 ("Nested
functions").

For the reed frogs we have two questions. Does the probability that a tadpole is killed decrease with
density? And do the tanks vary more than a Binomial model allows? Each question gives two alternatives, and
together they give four candidates: two curves crossed with two distributions. The constant probability is
the Holling type II curve with $H=0$: the larvae kill the same fraction of the tadpoles at every density, so
the expected number killed, $\alpha N$, increases in proportion to the density. The Binomial distribution is
the limit of the Beta-Binomial distribution as $\kappa$ grows without bound. So the model with a constant
probability and a Binomial distribution is nested in each of the others, and each Binomial model is nested
in the Beta-Binomial model with the same curve. The Holling type II curve with a Binomial distribution and
the constant probability with a Beta-Binomial distribution are not nested in each other, but they can still
be compared, because they are fitted to the same observations. The last bullet of the slide
gives the reason for the next slides: the maximum log-likelihood is highest for the model with the
most parameters, as it must be for nested models, so a comparison needs criteria that penalise the
number of parameters $K$.

**Delivery**

The special values $H=0$ and $\kappa=\infty$ cannot be reached on the optimised scales (they would be
$\log(H)=-\infty$ and $\log(\kappa)=\infty$), so the two models with a constant probability have NLLs of
their own in the chapter. The chapter fits all four with a small function, `fit_model()`, and a loop (the
slide says only that they are fitted in a loop); all four fits converged.

## Slide 27 — AIC, AICc and BIC

Chapter 4 introduced AIC and its corrected version AICc, where $K$ is the number of estimated parameters,
$n$ the number of observations and $\ell(\hat\theta)$ the maximum log-likelihood; do not repeat its
derivation. With 16 observations and up to three parameters the correction of AICc is not negligible: it
adds 2 units to the model with three parameters, against about 0.3 for the model with one.

The **Bayesian information criterion** (BIC) has a penalty that grows with the number of observations: each
parameter costs $\log(n)$ units instead of two, which is more than two when $n$ is larger than
$e^2\approx7.4$ (for 16 tanks, $\log(16)\approx2.8$). So for most data sets BIC penalises additional
parameters more strongly than AIC. The two criteria also have different aims. AIC estimates how well the
fitted model would predict new data from the same process. BIC tends, as the sample grows, to select the
model with the fewest parameters among the candidates that contain the data generating process. So in large
samples BIC tends to prefer simpler models than AIC does, and the two criteria can rank the same candidates
differently. Like AIC, BIC is used as a difference between
models fitted to the same observations, the lowest value is preferred, and it ranks the candidates without
showing that the best of them describes the data well.

In AICc and BIC, $n$ is the number of independent observations, which is the number of tanks, 16, and not
the 610 tadpoles that they contained: under the Beta-Binomial model the tadpoles of a tank share the
probability of that tank, so they are not independent observations. The same $n$ must be used for every
model that is compared.

**Delivery**

If a student asks whether $n$ could be 610 for the two Binomial models, say that the same $n$ must be used
for all the models that are compared, and that Chapter 7 returns to the question of what counts as an
independent observation.

**Optional remark (citation)**

Schwarz (1978), "Estimating the dimension of a model", *Annals of Statistics* 6: 461–464. The name comes from
its derivation, as a large-sample approximation in Bayesian inference, but it is used in the same way as AIC.

## Slide 28 — Comparing the candidates

Only differences between models matter for each criterion, so the table gives the difference (Δ) of each model
from the one with the lowest value of that criterion. The second bullet of the slide is where the comparison
ends: the ecological answer comes from the estimates and likelihood profile intervals of the preferred model,
in units, with what remains uncertain.

For the variation among tanks the criteria agree: with either curve, every criterion prefers the
Beta-Binomial model to the Binomial model, by 6.7 (Holling type II) and 13.0 (constant probability) units of
AIC. This agrees with the residuals of slide 21.

For the density dependence of the risk the answer depends on the distribution. Under the Binomial models, the
Holling type II curve is clearly better than a constant probability (9.0 units of AIC). Under the
Beta-Binomial models AIC, AICc and BIC still prefer the Holling type II curve, but only by 2.7, 1.6 and 2.0
units. The Binomial models overstated the evidence for density dependence
for the same reason that they understated the standard errors: they treated the tadpoles as independent
trials. With 16 tanks that vary among themselves, the data say clearly that a tadpole is killed with a
probability of about one half at low density and that the tanks vary more than a Binomial model allows, but
they hardly distinguish a probability that decreases with density from a constant one over densities of 5 to
100 tadpoles per tank.

For the ecological answer the chapter uses the Beta-Binomial model with the Holling type II curve, which all three
criteria prefer, by a small margin, and which contains the constant probability as the case $H=0$. Its attack rate is
estimated at 0.54 per experiment, with a likelihood profile interval from 0.38 to 0.76: at low density,
between about two fifths and three quarters of the tadpoles are killed on average in the 14 days. Its handling
time is estimated at 0.018 experiments per tadpole killed, with an interval from 0.0019 to 0.038, so the
largest number of tadpoles that three larvae could kill in one experiment, about 56, has an interval from 27
to more than 500. The lower end of the interval of $H$ is close to zero, which is the constant probability, and
this agrees with the comparison. To estimate the handling time, an experiment would need tanks with densities
well above the half-maximum, where the curve levels off (slide 14).

**Delivery**

Read the table by columns, then by rows: the two rows of the Binomial models are far from the best for every
criterion; the two rows of the Beta-Binomial models are close. The takeaway is the general point: a model that
ignores the variation among units overstates the evidence for the curve (the Binomial rows). Add that the criteria
rank the candidates, while what the ranking means for the question is a matter of ecological interpretation. Do
not present the choice of the last model as settled by the criteria: under the Beta-Binomial the differences are
small, and the interval of $H$ reaches almost to zero.

## Slide 29 — A recipe for a response curve

The steps of this chapter extend the recipe of Chapter 4 to models in which a curve describes a parameter of
the distribution of each observation, and the chapter collects them in a note callout before the summary.
Read the ten steps with the tool of each: choose the curve and the observation model, with the range that the
parameter requires; write the NLL with the predictor and the response in the list of data; read starting values
from a plot; fit, check `convergence` and plot the curve over the data; standard errors and correlations with
`sdreport()`, likelihood profile intervals with `TMB::tmbprofile()` and `confint()`; the curve on a grid with
`ADREPORT()` and its band; `OBS()`, `obj$simulate()` and the scaled quantile residuals; revise the curve or the
observation model and check the revised model in the same way; compare the candidates with AIC, AICc and BIC;
and interpret the estimates and intervals of the preferred model in units, in
terms of the ecological question, saying what the data leave uncertain.

**Delivery**

About two minutes. Steps 2, 4 and 5 are those of Chapter 4; point at the new ones (1, 3, 6 to 8 and 10). The
practical follows the same sequence.

## Slide 30 — The Chapter 6 R practical

The practical fits response curves to three data sets that the Chapter 5 practical used as a backdrop for curves
placed by eye. Exercises 1 to 3 are the core and Exercise 4 is extra practice. Exercise 1, on the titre of the
myxoma virus in infected rabbits (`emdbook`), is worked on the page: a Ricker curve with a Normal observation
model, Wald intervals of the time and the height of the peak from `ADREPORT()`, the likelihood profile interval of
the time of the peak, residuals with DHARMa, and a Gamma observation model compared with AIC, AICc and BIC.
Exercise 2, on the rate of an enzymatic reaction (`Puromycin`), fits a Michaelis–Menten curve with one asymptote
per state (cells treated with puromycin or not), the difference between the asymptotes from `ADREPORT()`, and a
comparison with information criteria. Exercise 3, on the fecundity of fir trees
(`emdbook`), fits a power law with Poisson and Negative Binomial models and asks whether the data support a
fecundity proportional to the cross-sectional area of the trunk. Exercise 4 simulates the coverage of the Wald
interval of the time of the peak of Exercise 1, with a skeleton function that students complete.

Try each exercise before checking the solution.

## Slide 31 — Summary and closing questions

Go back to slide 3 by speaking about it again; no new slide is needed. A response curve describes one parameter
of the distribution of each observation, usually its mean or, for a Binomial distribution, its probability, and it
must return values in the range of that parameter. The observations are treated as independent, but each has its
own distribution. The log-likelihood is the sum of the log probabilities of the observations, each at its own value
of the predictor, and it is maximised with the tools of Chapter 4, with RTMB supplying the exact gradient. The
parameters of a curve are often strongly correlated, and their precision depends on where the observations lie
along the predictor. `ADREPORT()` on a grid gives a pointwise confidence band, calculated on an unbounded scale.
Simulated residuals show where a fitted model disagrees with the data, but not why; for the reed frogs they showed
overdispersion, and a Beta-Binomial model with the same curve described the variation among tanks. Candidate models
fitted to the same observations are compared with AIC, AICc and BIC, with the number of
independent observations as $n$. On the diagram of slide 3, the lecture went once round the whole cycle:
model, estimation, check, revision, comparison and answer.

Return to this slide for the two closing questions.

**Discussion and expected answers — allow about two minutes**

Question 1: observations inform a parameter where the curve responds to it. On the rise of a saturating curve the
curve responds mainly to its initial slope; the asymptote matters only where the curve levels off. So many
combinations of asymptote and half-maximum with the same initial slope give similar curves over the data: the
estimates are strongly correlated and the interval of the asymptote is wide and asymmetric (slides 13 to 15).

Question 2: which assumption is wrong. A pattern can come from the distribution, from a predictor that is missing
from the curve or from observations that are not independent; and a plot without a pattern does not show that the
model is right, especially with few observations (slide 21).

**Final transition**

In this chapter every tank was an independent observation. In Chapter 7 the observations come in groups, such as
leaves of the same plant, visits to the same nest or plots at the same site, which are not independent of each
other, and the parameters of the curve vary among groups. The practical comes first.

## Adjustments during delivery

The slides take 117 minutes and leave 13 minutes of slack, which comes last. The demo is kept whole; if it overruns,
it takes the slack first. If discussion overruns, use the slack first, then shorten in this order:

- Slide 3 to one sentence: recovers about half a minute.
- Slide 4 to the two columns and the takeaway, with the provenance in one sentence: about one minute.
- Slide 11 to the figure and the example box: about one minute.
- Slide 14 to the takeaway, pointing at the figure once: about two minutes.
- Slide 22 to two of the four patterns (1 and 2): about one and a half minutes.
- Slide 25 given as homework, with the answers in one sentence: about two and a half minutes.
- Slides 29 and 30 to one sentence each: about two minutes together.

Keep the response curve as a parameter of a distribution and its range (slides 5 and 6), the likelihood of a
response curve (slide 8), the correlation and precision of curve parameters (slide 13), the uncertainty of the curve
(slide 16), the definition of the scaled quantile residuals (slide 20) and the revision of the observation model
(slide 24).

The breaks are placed between the blocks, after slides 12 and 22 (minutes 36 and 83). If a block runs over, shorten
the block rather than the following break.

**If time is left: code to run**

No code is run live apart from the demo, which stops before the comparison. Students can follow the chunks of the
chapter page at home, by section: "A model for overdispersed proportions" (the Beta-Binomial NLL with
`dbetabinom()`, its fit, its simulations and its dispersion statistic), "Comparing candidate models" (the two NLLs
with a constant probability, `fit_model()`, the list `models` and the loop that fits the four candidates),
"Information criteria" (AIC, AICc and BIC with `n_tanks`, the table of differences and the likelihood profile
intervals of the Beta-Binomial model).
