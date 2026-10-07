# Chapter 1 lecture slides

`lecture.qmd` is a 20-slide Quarto Reveal.js presentation based on
`lecture-script.md`. It is a draft for the course author's review.
The opening slide counts as slide 1; there is no additional generated title slide.

The speaker notes preserve the script's spoken guidance, activities and delivery
instructions. Each slide includes its planned duration and elapsed-time window
in the notes, plus a `data-timing` attribute for the speaker view's pacing timer.
The total planned duration is 60 minutes.

Render from the repository root:

```powershell
quarto render Chapter_1/lecture.qmd --to revealjs
```

This command writes `Chapter_1/lecture.html`. The rendered presentation embeds
its figures, styles and Reveal.js resources in one HTML file. Open
`Chapter_1/lecture.html` in a browser. Use arrow keys or Space to navigate,
Esc for an overview, F for full screen and S for speaker view. Speaker view
requires the browser to allow its popup; if local-file restrictions prevent it,
serve the repository locally and open the presentation through localhost.

The four PNGs in `lecture-assets` are unchanged copies of the rendered Chapter 1
figures from `_site-prod/Chapter_1/Theory_files/figure-html/`:

| Slide asset | Original figure |
|---|---|
| `insect-counts.png` | `fig-observation-error-1.png` |
| `body-masses.png` | `fig-observation-error-2.png` |
| `spray-treatments.png` | `fig-process-error-1.png` |
| `parameter-uncertainty.png` | `fig-parameter-uncertainty-1.png` |

Their construction code and data provenance remain in `Theory.qmd`. The body-mass
panel uses the original selection of masses no greater than 2000 kg. The
parameter-uncertainty panel retains all 28 species, including the three dinosaurs.
If those chapter figures change, rerender the chapter and refresh these copies.

Slides 15 and 16 refer directly to the author's existing `ModelCycle.png` and
`Estimation.png`, preserving the original diagrams and arrow styles. A caption
on slide 15 clarifies that AIC is introduced in Chapter 4, because the diagram
places information criteria under Chapter 6.

`feeding-response.svg` is a schematic for slide 3, with no numerical scales or
fitted parameter values. `lecture.scss` contains presentation styling.
