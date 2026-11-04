# Chapter 4 lecture script, Lecture 2: Uncertainty, properties and model comparison

Draft for the course author's review. **Target: 150 minutes in total, with 118 minutes of
slides on 30 slides (including the discussion, the two practice questions and one live demo of 18
minutes), 12 minutes of slack and two breaks of 10 minutes.** The breaks separate the three
blocks of the lecture. The only code that is run live is the demo of slide 23, from the script
`demo-properties.R`.

This script follows the second part of the [Chapter 4 theory](../Theory.qmd), from "Uncertainty
from the likelihood" to the recipe, with a short introduction to the second part of the
[R practical](../Practicals/no_solution.qmd). It continues
[Lecture 1](../Lecture_1/lecture-script.md), which covered the likelihood, maximum likelihood
estimation, transformations, models with several parameters, slices and profiles. The slides carry
keywords only; the narrative is here.

Slide 3 uses your diagram `ModelCycle.png` from the Chapter 1 lecture folder. Slides 7
(`curvature-information.png`), 10 (`wald-parabolas.png`), 13 (`three-intervals.png`), 16
(`joint-region.png`) and 18 (`coverage.png`) use figures in `lecture-assets/`; the code of all of them
is in `lecture-assets/figures.R`. The figures of slides 7, 10 and 13 are new (made from the data and
estimates of the chapter), and the others are copies of the chapter figures `fig-joint_region` and
`fig-coverage`. Slide 15 has no figure: it shows the table of intervals of the chapter. `sampling-distribution-k.png` is no
longer on a slide, because the demo draws the histograms. If the chapter figures change, run that
script again (it fits thousands of samples and takes a few minutes).

## Timing and slide sequence

Times are measured from the start of the session and include the breaks.

| Slide | Topic | Minutes | Elapsed time |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis | 1 | 0–1 |
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

Slides 118 minutes (blocks of 34, 42 and 42, the demo included), slack 12, breaks 20: 150 minutes.
The break before the demo lets you open R and run section 0 of `demo-properties.R`.

## Slides 1 and 2 — Ecological Models and Data Analysis; Overview of the lecture

In this lecture, we learn what we can say once a model is fitted by maximum likelihood. Lecture 1
built the method: the likelihood, the estimate that maximises it, the optimiser, and the
description of a model with several parameters. Here we ask how precise an estimate is, which
parameter values the data support, why the method works and when it fails, and which of several
models the data support.

The session has three blocks, separated by two breaks. The first block is about standard errors and
Wald intervals, and ends with the third practice question. The second is about likelihood profile
intervals, joint confidence regions and the check of their coverage by simulation. The third is about
the properties of maximum likelihood estimators, which we examine in a live demo, and about model
comparison with the Akaike information criterion. It ends with the recipe, the practical and the
summary.

**Delivery**

Read the overview at the pace of the list, one keyword and its question at a time, and do not explain
any term yet.

## Slides 3 and 4 — Where we are: the modelling cycle; Recap: the steps of a fit

On the modelling cycle, this lecture is the "confidence intervals (3 and 4)" entry of the estimation
box, where Chapter 3 introduced the standard error and the confidence interval for the method of
moments, and the "information criteria (4)" entry of the comparison box.

The recap lists the first five steps of the recipe that Lecture 1 followed: write the model (the random
variable, its distribution and the assumptions), write the NLL (two lists, `getAll()`, `log = TRUE`
and the transformations), connect and process it (`cmb()` and `MakeADFun()`), minimise it (`optim()`,
checking `convergence`), and transform the estimates back and compare the fitted model with the data.
The two examples are the same: the 50 fir quadrats, with $\hat\lambda=2.14$ seedlings per quadrat, and
the owls, with $\hat\mu\approx4.75$ calls per visit and $\hat k\approx0.33$. Today we answer three
questions about a fitted model: how uncertain it is, why it works, and which model to prefer.

**Delivery**

One minute on slide 3 (point to "confidence intervals (3 and 4)" and "information criteria (4)") and
two on slide 4. On slide 4 ask students, one step at a time, which function does it; the answers are
on the slide.

## Slide 5 — Uncertainty from the likelihood

In Chapter 3 we reported the uncertainty of an estimate with a standard error and a confidence
interval, and for the mean of Poisson counts we had a formula for the standard error. For most models
and parameters there is no such formula. We can instead calculate standard errors and intervals from
the likelihood itself, for any model that we fit with `optim()`.

A confidence interval can be calculated from the likelihood in at least two ways. The **Wald interval**
uses the curvature of the log-likelihood at its maximum together with the asymptotic normality of the
estimator. It is fast, and it is what software usually reports. The **likelihood profile interval**
uses the whole shape of the log-likelihood around the maximum. It is the reference method of the course,
and it needs many fits. The rest of the lecture explains both, shows where they differ and checks them
by simulation.

## Slide 6 — Asymptotic normality of the MLE

In Chapter 3 we defined the Wald interval as $\hat\theta\pm z_{0.975}\widehat{\operatorname{SE}}(\hat\theta)$
and justified it with an approximately Normal sampling distribution of the estimator, and the chapter
ended with the asymptotic normality of estimators. That result also applies to maximum likelihood
estimators: as the sample grows, the sampling distribution of an MLE approaches a Normal distribution
centred on the parameter. For one parameter it is
$\hat\theta\overset{\mathrm{approx}}{\sim}\operatorname{Normal}(\theta,\operatorname{SE}(\hat\theta)^2)$
for sufficiently large $n$, where the standard error is the standard deviation of the sampling
distribution. In plain English, across large hypothetical samples the estimates fall around the
parameter in the shape of a bell.

With several parameters the estimates jointly follow approximately a multivariate Normal distribution,
which extends the bivariate Normal distribution of Chapter 2 to any number of variables. Its means are
the parameters of the model, and its covariance matrix has the variance of each estimator on the diagonal
and the covariance between the estimators of each pair of parameters outside it. The Wald interval of one
parameter uses only its variance, through the standard error. What maximum likelihood adds to Chapter 3 is
a way to estimate the covariance matrix from the log-likelihood of the sample, for any model, also when
there is no formula for the variance of the estimator.

The result needs conditions on the model, called regularity conditions. In words: the parameter is not on
the boundary of its range (for example a variance of exactly zero), the support of the distribution does
not depend on the parameter, the log-likelihood is a smooth function of the parameters, and the number of
parameters does not grow with the sample size. For the Poisson mean we already know the result from
Chapter 3, $\operatorname{Normal}(\lambda,\lambda/n)$. The demo examines the claim for the owl model.

**Optional remark (history)**

Fisher used the large-sample standard error of maximum likelihood estimators in 1922 and developed the
concept of information in 1925, with arguments that were not rigorous. The result was made rigorous by
Wald (1943) and by Cramér (1946), whose treatment states the conditions explicitly. The Wald interval is
named after Abraham Wald.

## Slide 7 — Curvature and standard errors

The Normal approximation of the sampling distribution has a counterpart in the shape of the log-likelihood:
in a large sample the log-likelihood near its maximum is close to a parabola,
$\ell(\theta)-\ell(\hat\theta)\approx-(\theta-\hat\theta)^2/(2\widehat{\operatorname{SE}}(\hat\theta)^2)$.
It is a polynomial of degree two in the parameter, with its maximum at the estimate and a width set by the
standard error. With several parameters it is a polynomial of degree two in all of them, with a squared term
for each parameter and a product term for each pair. The two approximations go together, and the Wald
interval relies on both: it amounts to replacing the log-likelihood by this parabola, which is why it is
also called a quadratic interval.

The **curvature** of the log-likelihood at its maximum measures how fast it falls as we move away from the
estimate, and it determines the standard error. A log-likelihood that falls slowly has a low curvature:
many parameter values are almost equally well supported, which corresponds to a large standard error. One
that falls quickly has a high curvature: the data discriminate well, and the standard error is small. For
one parameter the curvature of the parabola is $1/\widehat{\operatorname{SE}}(\hat\theta)^2$, so the
standard error is one over the square root of the curvature, and a log-likelihood that is four times as
sharply curved gives half the standard error. A larger sample contains more information about the
parameter, so it gives a more sharply curved log-likelihood and a smaller standard error. With several
parameters, the curvatures along each parameter and for each pair give the whole covariance matrix. The
approximation is good when the log-likelihood is close to a parabola on the scale of the parameter. When it
is not, for example when it is asymmetric like the curve of Lecture 1, slide 14, the standard error
describes only the curvature at the maximum and the Wald interval is less accurate.

**Figure walkthrough**

The figure draws the relative log-likelihood of the same Poisson model for the first ten quadrats (solid
vermillion curve) and for all 50 (dotted vermillion curve), against the mean number of seedlings per
quadrat. Both are zero near 2.2 (2.14 for the 50 quadrats). The curve of the 50 quadrats falls much faster
on both sides, so its curvature is larger: it reaches $-8$ at about 1.4 and 3.1, whereas the curve of the ten
quadrats reaches it at about 0.8 and 4.7. The standard errors that go with them are 0.47 seedlings per
quadrat for the ten quadrats and 0.207 for the 50.

**Optional remark (the boxes of the chapter)**

The mathematics is in statistical-detail boxes, which students can read later. In the box on Fisher
information, the curvature at the estimate is the observed information, $-\ell''(\hat\theta)$, and its
inverse estimates the variance. The expected information, the Fisher information, is the version
that the asymptotic result is usually stated with. For the Poisson model, $\hat{\mathcal I}=n/\hat\lambda$:
$10/2.2\approx4.55$ for the ten quadrats, a variance of 0.22 and a standard error of
$\sqrt{0.22}\approx0.47$, which is the plug-in standard error of Chapter 3 ($\sqrt{2.14/50}\approx0.207$ for
the 50 quadrats). With several parameters the curvatures form a matrix, the Hessian of the NLL, whose
inverse is the estimated covariance matrix. The next slide shows that TMB does all of this for us.

## Slide 8 — `sdreport()`: standard errors and correlations

The function `sdreport()` of RTMB calculates the standard errors of any model that was processed with
`MakeADFun()`. It takes the object after the fit (it reads the estimates from the object), calculates the
curvature of the NLL at the estimates and converts it into the covariance matrix of the estimates.
`summary()` of its result is a table with one row per parameter, on the scale that was optimised, with two
columns: `Estimate` and `Std. Error`. The covariance matrix is in the element `cov.fixed`. A covariance
divided by the two standard errors is the correlation, which Chapter 2 introduced as a parameter of the
bivariate Normal distribution, and `cov2cor()` converts a whole matrix.

For the owl model, the rows are `log_mu` and `log_k`: the estimates are 1.559 and $-1.116$, with standard
errors 0.164 and 0.165, all on the log scales. The correlation between the estimates of $\log(\mu)$ and
$\log(k)$ is zero to four decimals, because the contours of the surface in Lecture 1, slide 26, are not tilted.
In the parameterisation with $k$ and $p$ (Lecture 1, slides 27 and 29) the correlation between the estimates of
$\log(k)$ and $\operatorname{logit}(p)$ is 0.71: hypothetical samples that overestimate $k$ tend to overestimate
$p$ too. That is the tilt of the contours expressed as a number.

**Delivery**

Show the chunk without running it. The chapter also applies `sdreport()` to the ten quadrats, where the one
parameter that was optimised is $\log(\lambda)$ and the standard error is 0.213; slide 9 uses that number.
The correlation in the $k$, $p$ model needs `sdreport(owl_prob_obj)`, which is also in the chapter.

## Slide 9 — Back-transforming a standard error

The standard errors of `sdreport()` refer to the scale that was optimised. For the ten quadrats this is the
standard error of the estimate of $\log(\lambda)$, 0.213, and not of $\hat\lambda$. The estimate can be
transformed back with `exp()`, because by invariance the result is the MLE of $\lambda$. The standard error
cannot: `exp(0.213)` is 1.24, which is no standard error of $\hat\lambda$. It could not be one, because the
exponential of a positive number is always larger than one, so it would stay above one seedling per quadrat
however many quadrats we sampled, whereas a standard error becomes smaller as the sample grows. Say it in these
words: `exp()` of a standard error is not a "biased" standard error; it is no standard error at all.

The reason is that a non-linear function does not pass through an average. For a non-linear $g$ and a random
variable $X$ that varies, in general $E[g(X)]\neq g(E[X])$: the mean of a transformed variable is not the
transformation of the mean. A variance is an average, the expectation of the squared distance from the mean
(Chapter 2), and a standard error is its square root, so neither can be carried to a new scale by applying the
transformation to it. An estimate and the endpoints of an interval are values of the parameter and not averages,
which is why they can be transformed back. The difference in units between the two scales is not the reason.

The standard error on the new scale is calculated with the **delta method**, which treats the transformation as a
straight line near the estimate and multiplies the standard error by the slope of that line. It is an
approximation, because the transformation is not a straight line, and it is widely used. It does not remove a
bias; it approximates the standard error. Chapter 6 explains it in more detail. In TMB we ask for it with
`ADREPORT()`: placed inside the NLL, `ADREPORT(x)` tells `sdreport()` to report the quantity `x`, calculated from the
parameters, with its standard error, and TMB applies the delta method and adds a row for `x` to the table. For
the ten quadrats, `ADREPORT(lambda)` gives a standard error of 0.47 seedlings per quadrat, which is the estimate
times the standard error of $\log(\hat\lambda)$: $2.2\times0.213$. For the owls, `ADREPORT(k)` gives
$\hat k=0.327$ with a standard error of 0.054, which is $0.327\times0.165$. After adding `ADREPORT()` to an NLL,
process it and fit it again before calling `sdreport()`, because `sdreport()` reads the estimates from the processed
object (the estimates do not change).

**Delivery**

Take about three minutes for the left column and two for the right. The boxes of the chapter have the rest:
Jensen's inequality gives the direction of the difference ($E[g(X)]\ge g(E[X])$ for a convex $g$ such as the
exponential, and the reverse for a concave one such as the logarithm), with the worked case of a variable that is 0
or 2 with equal probabilities ($\exp(1)\approx2.72$ against $(\exp(0)+\exp(2))/2\approx4.19$). The delta method is
$\widehat{\operatorname{SE}}(g(\hat\theta))\approx|g'(\hat\theta)|\widehat{\operatorname{SE}}(\hat\theta)$, so for the
exponential the standard error is multiplied by the estimate, and for the inverse logit by $\hat p(1-\hat p)$.

## Slide 10 — A Wald interval depends on the scale

The Wald interval replaces the log-likelihood by a parabola, so it is good when the log-likelihood is close to a
parabola on the scale on which we calculate it. With the ten quadrats we can calculate it in two ways: on the
original scale, from the row `lambda` of `ADREPORT()`, which gives 1.28 to 3.12 seedlings per quadrat, or on the log
scale, from the row `log_lambda`, with the endpoints transformed back with `exp()`, which gives 1.45 to 3.34. The
two are 95% Wald intervals for the same parameter and the same data. For the owls the interval for $k$ is 0.221
to 0.434 on the original scale and 0.237 to 0.453 from the log scale.

Unlike a standard error, the endpoints of an interval can be transformed directly. The logarithm is an
increasing function: $\log(\lambda)$ lies between the two endpoints on the log scale exactly when $\lambda$ lies
between their exponentials. So the interval contains the parameter in the same hypothetical samples on both scales, and
its coverage is kept. The difference between the two intervals is not due to the back-transformation of the endpoints
but to how well the sampling distribution is Normal on each scale. The sampling distribution of a parameter that was
transformed to make it unconstrained approaches the Normal distribution faster, in terms of the sample size, than the
original scale, because constraints on parameter values make sampling distributions skewed when the standard error
is relatively large. In terms of the log-likelihood, the curve is closer to a parabola on the log scale. So the
transformation of parameters is useful not only for the optimiser: it also makes Wald intervals more reliable, which
is why we calculate them on the scale that was optimised. A positive parameter then stays positive, and the
asymmetry of the interval is captured.

**Figure walkthrough**

The solid vermillion curve is the relative log-likelihood of the ten quadrats. The dashed curve is the parabola on the
original scale and the dotted curve is the parabola on the log scale, both with the standard error from `sdreport()`,
and all three touch zero at 2.2. The horizontal grey line is at $-1.92$. Because $z_{0.975}^2/2=1.92$, the
Wald interval on the original scale is exactly where the dashed parabola crosses the grey line. Near that line the dashed
curve lies outside the solid curve on the left and inside it on the right, and the dotted curve does the opposite, so
the dotted parabola is the closer one overall. Slide 13 adds the likelihood profile interval to this figure.

## Slide 11 — Practice 3: an interval from the log scale

**Short activity — allow about three minutes of work and one to discuss**

Students use R, or a calculator, to calculate the interval. The standard error 0.141 is that of the estimate of the
logarithm of the mean, so we calculate the interval on the log scale and transform its endpoints:
`exp(0.92 + c(-1, 1) * qnorm(p = 0.975) * 0.141)` gives approximately 1.9 and 3.3 ticks per lizard, around an
estimate of 2.5. The interval is symmetric on the log scale, and `exp()` stretches the part above the estimate more than the
part below it, so it is not symmetric around the estimate. A common slip is to take `exp(0.141)` as the standard
error on the ecological scale: refer back to slide 9. The break follows.

Break (10 minutes).

## Slide 12 — Likelihood profile intervals

The Wald interval uses the curvature of the log-likelihood at one point, its maximum. The **likelihood profile
interval** uses the whole curve: it contains all the values of the parameter whose relative profile log-likelihood
is within 1.92 units of the maximum, that is, the values that the data support almost as well as the estimate. The
other parameters of the model are re-estimated for each value, as in the definition of a profile (Lecture 1, slide 28).
The cutoff is chosen so that, in a large sample, the interval contains the parameter in approximately 95% of hypothetical
samples. It is half the 0.95 quantile of a chi-squared distribution with one degree of freedom, 3.84, which is the square of
1.96, and `qchisq(p = 0.95, df = 1) / 2` calculates it: 1.92.

The result behind the cutoff is Wilks' theorem. Let $\theta_0$ be the parameter value that generated the data. Across
hypothetical samples, twice the drop in log-likelihood from the maximum to the profile at $\theta_0$,
$2[\ell(\hat\theta)-\ell_{\mathrm{prof}}(\theta_0)]$, behaves in large samples like the square of a standard Normal variable,
which is a chi-squared variable with one degree of freedom. In plain English, the value that generated the data is rarely
far down the slope of the profile. So in about 95% of hypothetical samples the profile at $\theta_0$ is within
$3.84/2=1.92$ units of the maximum, and the interval contains $\theta_0$ in exactly those samples, which gives it a coverage of
approximately 95%. The theorem needs the regularity conditions of slide 6. The formal statement is in the box
"Statistical detail: Wilks' theorem".

**Delivery**

Say that the same result is the basis of the likelihood ratio test, which compares two nested models with a p-value; the
course does not use it (the chapter has a footnote). The theorem is given in words on the slide, with no equation.

## Slide 13 — Reading a likelihood profile interval

The calculation follows the same two steps for every model and parameter. First, the profile: the parameter of interest is
moved away from its estimate in small steps, the other parameters are re-estimated at each step by an optimisation of their
own (an **inner fit**), and the NLL is recorded. With a single parameter there is nothing to re-estimate, and the profile is
the log-likelihood itself. Second, the endpoints: the two values of the parameter, one below and one above the estimate,
at which the relative profile log-likelihood crosses the cutoff.

The interval follows the shape of the curve, so it need not be symmetric. It also does not depend on the scale, because a value
of $\lambda$ and its logarithm have the same likelihood: the endpoints are exactly the values of $\lambda$ at which the curve
crosses the cutoff, however we label the horizontal axis. For the ten quadrats the interval is 1.40 to 3.25 seedlings per
quadrat, which extends 0.80 below the estimate and 1.05 above it, following the asymmetry of the curve. A larger sample gives a
log-likelihood that is closer to a parabola around its maximum, so the quadratic approximation behind the Wald interval is better and the
intervals agree more closely. With all 50 quadrats the three intervals nearly coincide: 1.73 to 2.55 for the Wald interval on
the original scale, 1.77 to 2.59 from the log scale and 1.76 to 2.57 for the profile. With ten quadrats the method matters, with 50 it hardly does.

**Figure walkthrough**

The figure is the one of slide 10 with three dark horizontal segments added below the grey line at $-1.92$. They are the 95%
intervals: Wald on the original scale from 1.28 to 3.12, Wald from the log scale from 1.45 to 3.34, and the profile from 1.40 to
3.25, whose endpoints are where the solid curve crosses the grey line. The segment of the original scale is where the dashed parabola
crosses the line, and the one from the log scale is where the dotted parabola does. The code of the figure calculates the
endpoints itself; in an analysis we use TMB, as the next slide shows. In the chapter nothing is calculated by hand either.

## Slide 14 — `tmbprofile()` and `confint()`

We do not program the two steps of slide 13 ourselves, because two functions do them. `TMB::tmbprofile()` calculates the profile of one
parameter of a model that was processed with `MakeADFun()`. Its main arguments are the object and `name`, the name of the parameter
to profile as it is written in the list of parameters; `trace = FALSE` stops the printing of progress. It returns a data frame with the
values of the parameter and the NLL at each of them. The function belongs to the package TMB, on which RTMB is built and which is
installed with it, so we write `TMB::tmbprofile()`. `confint()` takes the result and finds the two crossings of the cutoff, that is,
the endpoints of the 95% likelihood profile interval.

The profile is calculated on the scale that was optimised, so we transform the endpoints back with `exp()`. The chunk gives
1.40 to 3.25 seedlings per quadrat for the ten quadrats, as on the previous slide, and 0.235 to 0.451 for the shape $k$ of the owl model.

**Delivery**

Show the chunk without running it. Mention that in the owl model, at every value of `log_k`, `tmbprofile()` makes an inner fit
that re-estimates `log_mu`; this is what the demo of Lecture 1 showed.

## Slide 15 — Profile intervals with several parameters

With several parameters, each parameter has its own profile, with the others re-estimated at each value. The owl model has
two, and the interval of each is calculated from its profile: at each value of $\log(k)$ that it visits, `tmbprofile()` makes an inner
fit that re-estimates $\log(\mu)$, and the other way round when we profile $\log(\mu)$. For both parameters the Wald interval from the log
scale is close to the likelihood profile interval: for $k$ it is 0.237 to 0.453 against 0.235 to 0.451, and for $\mu$ 3.45 to 6.55 against 3.49 to
6.68 calls per visit. The Wald interval for $k$ on the original scale, 0.221 to 0.434, is not: it is symmetric around the estimate, whereas
the profile interval extends further above the estimate than below it, so both of its endpoints are too low. This is why we calculate
Wald intervals on the scale that was optimised and transform their endpoints, and why the likelihood profile interval is the reference
with which we compare them.

**Delivery**

The table is the one that the chapter prints for the owls. The row of the Wald interval on the original scale has a value only for $k$,
because the chapter asks `ADREPORT()` for $k$ and not for $\mu$. Read the table by columns: the two intervals of $\mu$ are close, and for $k$
the original scale stands out. The asymmetry is the same as in the figure of slide 13, where the profile extends further to the right of the
estimate than to the left.

## Slide 16 — Joint confidence regions

A **joint confidence region** is the counterpart of a confidence interval for two parameters at once. It is defined in the same way as the
profile interval, with a cutoff of 3.00 units instead of 1.92: half the 0.95 quantile of a chi-squared distribution with two degrees of
freedom, `qchisq(p = 0.95, df = 2) / 2`, which is 5.99 divided by 2. The combinations of $\mu$ and $k$ whose relative log-likelihood is above
$-3.00$ form an approximate 95% joint confidence region, which is the area inside one contour of the likelihood surface. Wilks' theorem also
applies to two parameters at once: if we fix both, twice the drop follows approximately a chi-squared distribution with two degrees of freedom
(the distribution of the sum of the squares of two independent standard Normal variables).

The region extends beyond the profile interval of each parameter, because it answers a question about both parameters at once: in about 95%
of hypothetical samples it contains the pair of values that generated the data, which is more demanding than containing one of them. It is not
the rectangle formed by the two separate intervals; the shape of the contours matters. We use an interval when a question is about one parameter
and a region when it is about a combination of parameters. The practical asks students to draw the region and to check whether the
method-of-moments estimate is inside it (Exercise 2).

**Figure walkthrough**

The grey contours are the surface of the owl model in $\mu$ and $k$, as in Lecture 1, slide 26, and the vermillion circle is the estimate. The
vermillion contour at $-3.00$ is the region. The dark segments along the axes are the two profile intervals, from about 3.49 to 6.68 for $\mu$ and
from about 0.235 to 0.451 for $k$. The vermillion contour extends beyond both segments.

## Slide 17 — Simulating from a fitted model

To check the coverage of the intervals, as in Chapter 3, we need hypothetical samples from a model whose parameters we know. For a model
written as an NLL, we mark the data inside it with `OBS()`. The object returned by `MakeADFun()` then has a function `simulate()` that draws one
hypothetical sample of the size of the data for the parameter values that we give it, on the scale that was optimised. It returns a list in which
the simulated data have the name that they have in the NLL, `calls`. The chunk is the complete NLL of the owl model, with `OBS()` and
`ADREPORT(k)`; after processing and fitting as before, we give `simulate()` the estimates on the log scale, which are in the element `par` of the
fit. The first 20 counts of one hypothetical sample of 122 visits are the result. To simulate a sample of another size, process the NLL with
placeholder data of that length. The values of the placeholder data are not used, only the length.

**Delivery**

Show the chunk without running it; the demo of slide 23 uses it. Seed 700 gives the sample of the chapter.

## Slide 18 — Coverage of Wald and profile intervals

For each hypothetical sample we calculate both intervals and record whether each contains the parameter that was used to simulate. The coverage is the
fraction of samples in which it does, and it should be near 0.95. We consider two cases with small samples, where the coverage is not guaranteed. The
first is a Poisson model with a mean of 0.5 seedlings per quadrat and 5,000 hypothetical samples of ten quadrats, which compares the Wald interval on
the original scale with the likelihood profile interval. The Wald coverage is 0.878, far from the intended 0.95, and that of the profile interval is
0.924. The second is the Negative Binomial model with the owl estimates as parameters and 2,000 samples of 20 visits, which compares, for the shape
$k$, the Wald interval calculated on the log scale with the profile interval. The coverages are 0.945 and 0.942, so here the two perform equally well.

So the Wald interval fails on the original scale when the counts are few, where the log-likelihood is far from a parabola, and the profile interval is clearly
better there. A Wald interval calculated on a suitable scale, such as the logarithm of a positive parameter, can be just as good as the profile interval and
needs one fit instead of many. A simulated coverage has its own noise: with 2,000 samples it is about 0.005, so differences in the third decimal mean nothing.
The practical (Exercise 5) simulates the coverage of the Wald interval for another model.

**Figure walkthrough — included in the four minutes**

The figure is a copy of the chapter figure. The dashed line is the intended level, 0.95. The left case is the Poisson model, with the Wald interval at 0.878
and the profile interval at 0.924; the right case is the Negative Binomial model, with both close to the dashed line. The figure does not show larger samples,
where all the intervals approach 0.95. The code of the simulation is not shown in the chapter. For the profile interval the simulation records whether the
profile at the generating value is within the cutoff, which takes one extra fit instead of a whole profile in every sample.

**Optional remark (the footnote)**

A sample in which all the quadrats are empty gives an estimate of zero, and the Wald interval on the original scale then collapses to $[0,0]$. The simulation
counts such a sample as a miss for both intervals, and it happens in less than 1% of these samples.

**Takeaway**

The chapter prefers profile intervals because in small samples their coverage tends to be closer to 95%, at the cost of many optimisations, which take longer
and give more fits that can fail. When this cost matters, a Wald interval on a scale where the log-likelihood is close to a parabola is the fast approximation.

## Slide 19 — Discussion: Wald or profile?

This discussion checks the difference between the two intervals before we turn to the properties of the estimators.

**Discussion and expected answers — included in the three minutes**

Give students one minute to decide with a neighbour, then take one answer per item.

1. **Wald:** it uses the curvature at the maximum.
2. **Profile:** it gives the same interval on any scale.
3. **Wald:** it needs a single fit.
4. **Wald on the original scale:** it can include negative values for a positive parameter. A Wald interval from the log scale cannot.

## Slide 20 — Consistency and asymptotic normality

An MLE is an estimator, so everything that we learnt in Chapter 3 applies to it: it has a sampling distribution across hypothetical samples, a bias, a variance and a
standard error, and in a finite sample we do not know that sampling distribution in general. For large samples the MLEs of a very wide class of models have three
properties: they are consistent and asymptotically normal, like the method-of-moments estimators of Chapter 3, and in addition they are asymptotically
efficient (slide 21). These results are the reason why this book uses maximum likelihood, and the standard errors and intervals of the first two blocks rely on them.

An estimator is **consistent** when the chance that it misses the parameter by more than any given margin becomes small as the sample grows. MLEs are consistent
when the observations are i.i.d. from the model. It is a statement about probabilities and not about every sample: a larger realised sample need not be closer to the
parameter than every smaller one. How large the sample needs to be for the Normal approximation of slide 6 depends on the model and on the parameter. When it is large
enough, the standard error from one fit describes the spread of the estimates across hypothetical samples.

The example is the simulation of the chapter: 2,000 hypothetical samples from a Negative Binomial model with the owl estimates as parameters ($\mu=4.75$ and
$k=0.327$), for 20, 122 (the size of the owl sample) and 500 visits, each fitted by maximum likelihood. The fraction of the estimates that miss $k$ by 0.1 or more is 45% with 20
visits, 7% with 122 and none with 500. With 20 visits the estimates of $k$ are strongly skewed: half of them are below 0.36, but a long tail to the right reaches values above 1, and
their mean is 0.40. With 500 visits the mean is 0.329 and the distribution is nearly symmetric and close to a Normal curve. The hypothetical samples of 122 visits have the size of the
owl data, so the standard deviation of their estimates of $\log(k)$, 0.162, is what the standard error from `sdreport()`, 0.165, approximates; with a sample of this size the standard
error from one fit describes the variation across hypothetical samples well.

**Delivery**

The chapter has a box on why MLEs are consistent: the log-likelihood divided by $n$ converges, by the Glivenko–Cantelli theorem of Chapter 3, to an expectation that is highest at the
parameter that generated the data. Mention it only if asked. The simulation is not run on this slide: it is slow, and the demo of slide 23 runs it. Ask students to remember these numbers (45%, 7%, none)
and to look for them in the demo.

**Optional remark (citation)**

The consistency of maximum likelihood estimators was proved, under regularity conditions, by Abraham Wald (1949).

## Slide 21 — Efficiency

An estimator is more **efficient** than another estimator of the same parameter when its estimates vary less across hypothetical samples. This is the property that
separates maximum likelihood from the method of moments. Both estimators of $k$ are consistent, but they use different information from the sample: the method of moments
reproduces the mean and the variance of the sample, whereas maximum likelihood makes every observed count as probable as possible.

In the simulation, with 122 visits the standard deviation of the estimates is 0.055 for maximum likelihood and 0.086 for the method of moments, and with 500 visits it is 0.024 against 0.042. Standard
errors decrease with the square root of the sample size, so the method of moments needs about $(0.086/0.055)^2\approx2.5$ times as many visits to estimate $k$ with the precision that maximum likelihood
achieves with 122.

What the simulation shows for this model is a general property. An MLE is **asymptotically efficient**: in large samples no other regular estimator of the same parameter is more precise, because the variance that
an MLE approaches, the one given by the curvature of the log-likelihood (the inverse of the Fisher information), is the smallest that such an estimator can have. In your own analysis, this is the
reason to fit a model by maximum likelihood whenever you can write its likelihood.

**Delivery**

The box on the Cramér–Rao bound states that no unbiased estimator has a variance smaller than the inverse of the Fisher information, so the information in a sample sets a limit to the precision with which a parameter can be
estimated, whatever the method. The variance of an MLE approaches this limit as the sample grows, which is what asymptotic efficiency means. Name it in one sentence. The demo prints the standard deviations and
the mean squared errors of both estimators, so students will see the numbers there.

## Slide 22 — Bias in finite samples

As for the estimators of Chapter 3, the large-sample results say little about small samples, where MLEs are in general biased. The bias shrinks as the sample grows, faster than the standard error, so in a
large sample it is negligible compared with the variation of the estimates across hypothetical samples. For a small sample the properties of this block are approximations, and simulation is the way to check them:
simulate hypothetical samples from the fit, refit each, and compare the mean of the estimates with the value used to simulate.

In the simulation the relative bias of $\hat k$ is 21% with 20 visits (on average $\hat k$ is 21% larger than the $k$ used to simulate), 2.6% with 122 visits and 0.6% with 500.

**Optional remark (corrections)**

Corrections of the bias exist for particular models. Dividing by $n-1$ in the estimator of a variance is one of them (Chapter 3). Restricted maximum likelihood (REML) is the general approach to reduce the bias of the estimates of
variance parameters, and Chapter 7 uses it with the models for grouped observations (section "Restricted maximum likelihood").

Break (10 minutes).

## Slide 23 — Live demo: properties by simulation

The demo checks the properties of slides 20 to 22 for the owl model, with the script `demo-properties.R`. It needs the packages RTMB, RTMBdist and `glmmTMB` (for the data). The simulation is the one of the chapter
(seed 601), so with 2,000 samples per size the numbers agree with the chapter and the slides. Section 3 takes about a minute (it took about 57 seconds in a check in R 4.6.1); start it, then explain the loop while it runs.

During the break, open R and run section 0, "Packages, data and the fit". It loads the packages, the owl data and the method-of-moments estimates, defines `cmb()` and the complete NLL with `OBS()` and `ADREPORT(k)`, fits
the model (convergence 0) and runs `sdreport()`, whose table is the one of slide 8 with the extra row `k` (0.327, standard error 0.054). Keep the session open. Spend the two minutes at the slide reading the four steps and then switch
to R.

**Walkthrough of the script — 16 minutes**

1. **One hypothetical sample (about 2 minutes).** With seed 700, `owl_obj$simulate(owl_fit$par)$calls` draws one sample of the size of the data. The first 20 counts start 2, 6, 0, 4, 7, 9, and the sample has 122 visits with a
   mean of about 4.97, against 4.75 in the data: the same design and sample size, different values.
2. **Both estimates from one sample (about 2 minutes).** The method-of-moments estimate of $k$ exists only when the variance is larger than the mean. The maximum likelihood estimate comes from processing the NLL with the simulated data
   and fitting it, starting from $\log(\mu)=0$ and $\log(k)=0$ (any starting values from which the optimiser reaches the maximum will do). The output compares both estimates (about 0.44 and 0.43) with the $k$ used to
   simulate, 0.327. One sample tells us little about the properties of an estimator, which is why we need many.
3. **Many hypothetical samples (about 3 minutes, of which 1 minute of waiting).** `simulate()` draws samples of the size of the data of its object, so for each sample size we process the NLL with placeholder data of that length, whose values are
   not used. Each sample is fitted from fixed starting values and the loop keeps the estimate of $k$ and the sample itself. Explain the outer loop (three sample sizes), the inner loop (2,000 samples) and the two lines that simulate and fit while the
   loop runs. `head(sim_k_ml)` shows one column per sample size.
4. **Properties from the estimates (about 9 minutes).** Go through the results in this order, and ask the question to each:
   - **Consistency:** `colMeans(abs(sim_k_ml - k_mle) >= 0.1)` gives 0.447, 0.066 and 0 (slide 20: 45%, 7% and none).
   - **Asymptotic normality:** the histograms of the estimates of $k$ with 20 and 500 visits, with a Normal curve with their mean and standard deviation. The first is skewed with a long tail to the right and
     the second is nearly symmetric. The dashed line is the $k$ used to simulate.
   - **The standard error:** the standard deviation of the estimates of $\log(k)$ with 122 visits, 0.162, against 0.165 from `sdreport()`.
   - **Efficiency:** the method-of-moments estimates are calculated from the same samples, so the samples in the table are the same for both estimators. `efficiency_table` gives, for 122 visits, standard deviations of 0.055 and 0.086 and
     mean squared errors of 0.0031 and 0.0085; for 500 visits 0.024 and 0.042. The squared ratio of the standard deviations, 2.5 at 122 visits, is the number of times more visits that the method of moments needs. The `na.rm = TRUE` skips the samples
     in which the variance is not larger than the mean, where the method-of-moments estimate does not exist.
   - **Bias:** the relative bias, 21.3%, 2.6% and 0.6%.

**Questions to ask during the demo (about 1 minute)**

Ask "which property?" for each item, and take one answer:

1. None of the 2,000 estimates from 500 visits misses $k$ by 0.1: consistency.
2. A histogram of the estimates that has become bell-shaped: asymptotic normality.
3. One method needs 2.5 times the visits of another: efficiency.
4. A mean estimate 21% too high with 20 visits: bias in a finite sample.

## Slide 24 — Misspecified models

This section can be skipped at a first reading of the chapter, and the rest does not depend on it. All the properties above assume that the observations are a random sample from the model. Chapter 1 described the model as an approximation of
the data generating process, so this assumption is never exactly right. A model is **misspecified** when it does not contain the distribution of the data generating process, whatever the values of its parameters. What does the MLE estimate in that case?

As the sample grows, the MLE converges to the parameter values for which the model distribution is closest to the distribution of the data generating process. That is, the fitted model is the best approximation that the model can offer, and the
estimates are the parameters of that approximation. Closeness is measured by the Kullback–Leibler divergence, which is named on the slide and defined in the chapter's box: the average, over the values that the data generating process produces, of the logarithm of the
ratio between the probability of a value and the probability that the model gives to it. Maximising the likelihood amounts to minimising that divergence. The standard errors and intervals of the first two blocks are calculated as if the model had generated the data, so with a
misspecified model they are approximations too.

**Delivery**

The slide has no example: keep the discussion general. Name the divergence and do not write its equation. It returns on slide 25.

**Optional remark (citations)**

Kullback and Leibler (1951) introduced the measure; maximum likelihood estimation under a misspecified model is studied by White (1982), "Maximum likelihood estimation of misspecified models", *Econometrica*, and Huber (1967) is an earlier treatment.

## Slide 25 — The Akaike information criterion

More than one model can be plausible for the same data. Chapter 2 gave heuristics for choosing a distribution and announced formal tools, and the likelihood provides the first of them. We compared parameter values of one model through their
log-likelihoods, so it is natural to compare two models through their maximum log-likelihoods. That comparison is not fair when the models have different numbers of parameters. A model with more parameters has more freedom to adapt to the particular sample, including its accidental features.
When one model contains the other as a special case (the Negative Binomial distribution approaches the Poisson distribution as $k$ grows), its maximum log-likelihood can never be lower.

The **Akaike information criterion** (AIC) corrects the maximum log-likelihood for the number of parameters: $\mathrm{AIC}=2K-2\ell(\hat\theta)$, where $K$ is the number of estimated parameters (we write $K$ because $k$ is the shape of the Negative Binomial). The
log-likelihood enters with a minus sign, so among models fitted to the same data the one with the lowest AIC is preferred. Like the value of a log-likelihood, the AIC of one model means nothing by itself: only differences between models fitted to the same observations, in the same units,
are meaningful. Apart from a constant that is the same for all models, AIC estimates how far the fitted model is from the data generating process when it is used to predict new data from the same process, and the distance is the Kullback–Leibler divergence of slide 24. The maximum
log-likelihood alone is too optimistic for that purpose because the same data were used to fit the model and to evaluate it, and the term $2K$ corrects for this. In plain English, AIC rewards a model for assigning a high probability to the data and penalises it for each parameter that it needed to do so.

The example compares the Poisson model, with $K=1$ and a maximum log-likelihood of $-634.16$, with the Negative Binomial model, with $K=2$ and $-299.44$, for the owl data. The Poisson model is evaluated at its estimate, the mean of the sample. The AIC are 1270.3 and 602.9, a difference of about
667 units in favour of the Negative Binomial model, which is very large compared with the two units that its additional parameter costs, and agrees with the figure of Lecture 1, slide 25.

The last bullet is the corrected AIC. The justification of AIC is asymptotic, and when the number of observations $n$ is small compared with the number of parameters $K$ the term $2K$ is too small to penalise complex models properly. The corrected AIC adds
$2K(K+1)/(n-K-1)$, which is large when $n$ is close to $K$ and disappears as $n$ grows, so each parameter costs $2n/(n-K-1)$ units instead of two. It needs $n>K+1$ and is used in the same way, as a difference between models fitted to the same observations. For the owls the additional penalty is negligible (0.03 units
for the Poisson model and 0.10 for the Negative Binomial model), because 122 visits are many more than one or two parameters. The expression comes from linear regression with Normal errors, so for the non-linear models with other distributions of this course it is an approximation, as there is no general formula for the small-sample
bias of AIC. It is nevertheless common in the ecological literature, where samples are often small, and a correction that is approximately right is better than none. The practical reports both wherever it compares models.

**Optional remark (citations)**

Akaike (1973, 1974) derived the criterion as an estimate of a loss based on the Kullback–Leibler divergence. AICc was derived by Sugiura (1978) for linear regression with Normal errors and extended by Hurvich and Tsai (1989), "Regression and time series model selection in small samples", *Biometrika*. Burnham and Anderson (2002), *Model selection and multimodel
inference*, recommend AICc whenever $n/K$ is smaller than about 40.

## Slide 26 — Using AIC

AIC ranks the candidate models that we give it. It does not tell us whether the best of them describes the data well: the Negative Binomial model is far better than the Poisson model for the owls, and it is still an approximation of the data generating process (for one thing, we treated visits to the same nest as i.i.d.).
Chapter 6 returns to model comparison with further tools (BIC and cross-validation) and with checks of goodness of fit.

The chapter also points to a common use of AIC. Many authors use it to reject models that differ largely from the best model, which may be used as a form of hypothesis testing: if adding a new term does not lower the AIC by more than two units, that model is rejected. This is a form of null hypothesis testing in disguise, and the new term is treated as if it was "not
significant". It carries over all the issues of null hypothesis testing discussed in Chapter 1, and it may actually be worse: traditional statistics has developed several techniques to control false positive error rates (for example when testing many hypotheses at the same time) which do not exist for AIC. Instead, we can have a more nuanced view of model comparison, where AIC is one of the criteria that
we use to contrast models and in many cases there might not be a real reason to make a choice: research may not be about choices but about evaluating the strength of evidence in favour of alternative hypotheses, and about making predictions supported by evidence.

**Delivery**

Keep the chapter's wording and add no opinion of your own. Take about two minutes for the slide and one for questions.

## Slide 27 — Practice 4: waiting for a pollinator

**Short activity — allow about two minutes of work and two to discuss**

Students work on paper. For the Exponential model, $\mathrm{AIC}=2\times1+2\times231.0=464.0$, and for the Gamma model $\mathrm{AIC}=2\times2+2\times230.4=464.8$. The Exponential model has the lower AIC,
although its log-likelihood is lower: the improvement of 0.6 units of log-likelihood does not compensate for the additional parameter. A difference of 0.8 units of AIC is very small, so these data hardly distinguish the two models.

The log-likelihood of the Gamma model could not have been the lower of the two, because the Exponential distribution is a Gamma distribution with a shape of one, and a model that contains another as a special case fits the same data at least as well (slide 25).

## Slide 28 — A recipe for a fit

The steps of this chapter are the same for every model that we fit in the rest of the book, so the chapter collects them as a recipe, in a note callout before the summary. Read the eight steps, with the function of each: write the model; write the NLL (`getAll()`, `log = TRUE` and transformations); connect and
process it (`cmb()`, `MakeADFun()`, starting values); minimise it (`optim()`, `method = "BFGS"`, `convergence`); transform back and compare with the data; calculate standard errors and Wald intervals (`sdreport()`, `ADREPORT()`); calculate likelihood profile intervals (`TMB::tmbprofile()`, `confint()`); and compare the candidates with AIC.

**Delivery**

About two minutes. Steps 1 to 5 are the recap of slide 4, so only point at steps 6 to 8. The practical follows the same sequence.

## Slide 29 — The Chapter 4 R practical

The practical has five exercises. Exercises 1 to 4 are the core and Exercise 5 is extra practice. Exercise 1, on reed frog tadpoles, is worked on the page: questions 3 to 6 are the standard error (calculated by hand from the Hessian of `optim()`
and with `sdreport()`), the likelihood interval with `TMB::tmbprofile()`, a check of the adequacy of the Binomial model, and a comparison of one survival probability with one per predator treatment, with AIC and AICc and the standard error of the difference. Exercise 2, on glacier lily seedlings, includes the
joint confidence region, the Wald and profile intervals of $k$, and AIC and AICc for the Negative Binomial and the Poisson model. Exercise 3 asks students to write a zero-inflated Poisson mass function by hand and to verify it against the one of RTMBdist. Exercise 4 fits a Gamma model to the volume of black cherry trees and a LogNormal model to the body mass of penguins, with attention to units. Exercise 5 simulates the coverage of a Wald interval, with a
skeleton function that students complete.

Try each exercise before checking the solution.

## Slide 30 — Summary and closing questions

Go back to slide 3 by speaking about it again; no new slide is needed. In a large sample an MLE is approximately Normal, with a covariance matrix that comes from the curvature of the log-likelihood: the more slowly the log-likelihood falls from its maximum, the larger the standard errors. `sdreport()` gives standard errors on the scale that was optimised, Wald
intervals are calculated there, and their endpoints transform back; a standard error needs `ADREPORT()` to be reported on another scale. Likelihood profile intervals follow the shape of the log-likelihood, do not depend on the scale and are the reference in the course. Simulation checks both coverage and the properties of estimators: MLEs are consistent and asymptotically
efficient, and in small samples they are biased and their sampling distribution can be far from Normal. AIC ranks the candidate models, and shows nothing about whether they are good. On the diagram of slide 3, the confidence intervals of the estimation box and the information criteria of the comparison box are now filled in.

Return to this slide for the two closing questions.

**Discussion and expected answers — allow about two minutes**

Question 1: the endpoints of an interval are values of the parameter, and the transformation is increasing, so the interval contains the parameter in the same hypothetical samples on both scales and keeps its coverage. A standard error is the square root of a variance, which is an average, and a non-linear function does not pass through an average, so applying the transformation to a standard error gives
no standard error. We use `ADREPORT()`, which applies the delta method, an approximation.

Question 2: AIC does not tell us whether the best model describes the data well, only that it ranks above the others that we gave it. It compares models fitted to the same observations in the same units, and it does not control error rates like a test.

**Final transition**

So far every observation had the same distribution. Chapter 5 studies deterministic functions that describe how an expected response changes with a predictor, with no statistics; Chapter 6 combines them with the likelihood of this chapter to fit ecological response curves.

## Adjustments during delivery

The slides take 118 minutes and leave 12 minutes of slack, which comes last. The demo is kept whole; if it overruns, it takes the slack first. If discussion overruns, use the slack first, then shorten in this order:

- Slide 3 to one sentence: recovers about half a minute.
- Slide 4 to the list, with no questions to students: about one minute.
- Slide 14 to its bullets, without the chunk: about one minute.
- Slide 24 to the definition, with the rest in one sentence: about two minutes.
- Slides 28 and 29 to one sentence each: about two minutes together.
- In the demo, show only the histograms and the table of efficiency, and skip section 2: about three minutes.

Keep the difference between endpoints and standard errors (slide 9), what a likelihood profile interval is (slides 12 and 13), and that AIC ranks candidates without judging them (slide 26).

The breaks are placed between the blocks, after slides 11 and 22 (minutes 34 and 86). If a block runs over, shorten the block rather than the following break.

**If time is left: code to run**

No code is run live apart from the demo. Students can follow the chunks of the chapter page at home, by section: "Standard errors with TMB" (`sdreport()` with `summary()` and `cov2cor()`), "Standard errors on the original scale" (the NLL with `ADREPORT()`), "Wald intervals on the original and log scales", "Likelihood profile intervals" (`qchisq()`, `TMB::tmbprofile()`
and `confint()`), "Joint confidence regions" and "Model comparison with AIC" (the table of AIC and the difference between models).
