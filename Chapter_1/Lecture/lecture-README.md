# Chapter 1 lecture slides

`lecture.qmd` is a 19-slide Quarto Reveal.js presentation with the same slide text
and speaker notes as `lecture-script.md`. It is a draft for the course author's review.
Slide 1 is the title slide and slide 2 an overview of the lecture. The slides carry
keywords and very short sentences for students who do not know the course yet; the
narrative is in the speaker notes.

Each slide includes its planned duration and elapsed-time window in the notes, plus a
`data-timing` attribute for the speaker view's pacing timer. The slides take 57 minutes
and leave 3 minutes of slack for discussion, so the planned duration is 60 minutes.
When a slide or its notes change, change `lecture-script.md` in the same way.

Render from the repository root:

```powershell
quarto render Chapter_1/Lecture/lecture.qmd --to revealjs
```

This command writes `Chapter_1/Lecture/lecture.html`. The rendered presentation embeds
its figures, styles and Reveal.js resources in one HTML file. Open
`Chapter_1/Lecture/lecture.html` in a browser. Use arrow keys or Space to navigate,
Esc for an overview, F for full screen and S for speaker view. Speaker view
requires the browser to allow its popup; if local-file restrictions prevent it,
serve the repository locally and open the presentation through localhost.

The four PNGs in `lecture-assets` are unchanged copies of the rendered Chapter 1
figures from `_site-prod/Chapter_1/Theory_files/figure-html/`:

| Slide | Slide asset | Original figure |
|---:|---|---|
| 9 | `insect-counts.png` | `fig-observation-error-1.png` |
| 9 | `body-masses.png` | `fig-observation-error-2.png` |
| 10 | `spray-treatments.png` | `fig-process-error-1.png` |
| 12 | `parameter-uncertainty.png` | `fig-parameter-uncertainty-1.png` |

Their construction code and data provenance remain in `../Theory.qmd`. The body-mass
panel uses the original selection of masses no greater than 2000 kg. The
parameter-uncertainty panel retains all 28 species, including the three dinosaurs.
If those chapter figures change, rerender the chapter and refresh these copies.

Slides 7 and 14 show the author's `ModelCycle.png` and `Estimation.png`, unchanged.
The files next to `lecture.qmd` are copies of the ones in `Chapter_1/`; refresh them
if the originals change.

`feeding-response.svg` is a schematic for slide 5, with no numerical scales or
fitted parameter values. It shows a saturating curve (solid) and a straight line
(dashed) that follows the curve over part of the range and then keeps increasing.
`model-components.svg` is the schematic for slide 6: the same curve with hypothetical
observations scattered around it at seven prey densities. `lecture.scss` contains
presentation styling.
