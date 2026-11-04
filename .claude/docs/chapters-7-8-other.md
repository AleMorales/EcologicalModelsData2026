# Decisions: Chapters 7 and 8, lectures and other

Moved from AGENTS.md. Read this before working on the pages it covers; AGENTS.md points here.

### Lectures

The Chapter 3 lecture has no live demos (author's decision of 30 October); the Chapter 2
lecture has three, each Chapter 4 lecture has one of 18 minutes from a standalone
script, `demo-profile.R` and `demo-properties.R`, and the Chapter 6 lecture has one of 18
minutes from `demo-cycle.R` (author's decisions of 3 November). Slides state the general definition, rule or property
and then the result for the example, never the example alone (author's decision of 30
October), and the main takeaways stand on the slide, not only in the script (author's
decision of 3 November). The rules are in `STYLE_GUIDE_LECTURE.md`.

### Chapters 7 and 8

- They predate the rewrite of Chapters 4 to 6 and received consistency fixes only; the
  full rewrite is a separate plan. Where their terms differ from Chapters 4 and 6, follow
  Chapters 4 and 6 in new work.
- The rewrite of Chapter 7 (theory, practical, one lecture) follows
  `Chapter_7/rewrite-handoff.md`: seven stages with the author's decisions of 4 November
  (one example, the CO₂ uptake curves of `datasets::CO2` with a random asymptote per plant;
  conditional distributions, the Laplace approximation and REML; AIC and leave-one-group-out
  cross-validation; four real data sets in the practical). Its last stage moves the durable
  decisions into this file.
- Chapter 7 introduces `shapes1.csv` (light response of five leaves) itself; it no longer
  relies on Chapter 6 for these data or for the `%~%` notation.
- Not converted: the Chapter 7 theory and practical still use `%~%`, one parameter list,
  data read from the workspace and `obj$he()`; Chapter 8 passes plain functions to
  `optim()` with `hessian = TRUE`; the learning goals of Chapter 7 keep the old format.
- Chapter 4 points to Chapter 7 for REML, which Chapter 7 does not cover yet.
- Technical difficulties of optimisation appear in Chapter 7 only as examples, with a
  pointer to Chapter 8 and no mechanics (author's decision of 4 November). The first is
  Exercise 5 of the Chapter 7 practical: a few REML fits stop at a practically zero
  variance among sites with convergence code 0. A note callout in Chapter 8 ("Hybrid global
  and local optimisation") says that several random starting values find the maximum; the
  rewrite of Chapter 8 works through this example.

### Other

- The Chapter 1 practical has a step that installs the course packages, and it teaches
  contour plots with `outer()` and `contour()` in base R, so later chapters use them
  without introduction.
- Figures that the author decided to keep outside the plotting rules: the `theme_bw()`
  figure of the Chapter 3 theory and the two starting-value figures of the Chapter 5
  theory (base R, `plot()` with `curve()`). Awaiting the author's confirmation: the DHARMa
  residual plots of Chapter 6 (theory and lecture) are the package's own base-graphics
  plots, shown with visible code because the tool is the lesson.
- The glossary was updated for RTMB.
- **Numbered practice callouts** (author's decision, issue 8): the `Practice` callouts of
  the theory pages of Chapters 2 to 6 are numbered per page ("Practice 3"), so that
  students' scripts and the lectures can refer to them; the chapter number is not shown
  on the page and is added by hand when a reference must be unique across the book. The
  supplements and Chapters 7 and 8 are not numbered yet. The Chapter 2 lecture (slides,
  script and handoff) names the callouts by number; `lecture-script.pdf` was not
  regenerated. The pattern is in `STYLE_GUIDE.md`.

