# Photosynthesis of *Arabidopsis* grown at two temperatures, with and without drought

## Photosynthesis and light

In **photosynthesis**, a leaf takes up carbon dioxide (CO₂) from the air and uses the
energy of light to fix it into sugars. At the same time, the leaf respires: it releases
CO₂ as it breaks down sugars for its own energy needs. An instrument that measures the
exchange of CO₂ between a leaf and the air therefore measures **net photosynthesis**, the
CO₂ fixed by photosynthesis minus the CO₂ released by respiration. In darkness there is no
photosynthesis, and the net exchange is negative: the leaf only releases CO₂. As light
increases, photosynthesis rises, and at some light level it balances respiration (the net
exchange is zero).

The light that plants use for photosynthesis (wavelengths from 400 to 700 nm,
photosynthetically active radiation) is measured as a flux of photons reaching a unit of
leaf surface, in µmol of photons per square metre per second (µmol/m²/s). For comparison,
full sunlight at midday is about 2,000 µmol/m²/s. Net photosynthesis is measured as a flux
of CO₂ per unit of leaf area, also in µmol/m²/s (of CO₂).

When light is scarce, the rate of photosynthesis is limited by the amount of light that
the leaf absorbs. When light is abundant, it is limited by the capacity of the leaf to use
that light: the amount and activity of the proteins that capture light energy, transport
electrons and fix CO₂. A **light response curve** is a series of measurements of net
photosynthesis on the same leaf at several light levels. It describes how the leaf
performs across the range from dim to bright light, which is why physiologists use it to
compare plants grown under different conditions.

## Acclimation to growth temperature

Plants respond to the temperature at which they grow by changing the make-up of their
leaves: the amounts of the proteins of photosynthesis, the composition of their membranes,
the thickness of the leaf and more. These slow changes, over days to weeks, are called
**acclimation**. They are different from the immediate effect of temperature on the speed
of the reactions in a leaf, which changes within minutes when the leaf is warmed or cooled.

To separate the two, every curve in this data set was measured at the same leaf
temperature, 22 °C, whatever the temperature at which the plant had grown. Differences
between plants grown at different temperatures are therefore differences in the leaves
themselves, not effects of the temperature during the measurement. The two growth
temperatures were 22 °C, a common temperature for growing *Arabidopsis* in the laboratory,
and 28 °C.

## Drought

When a soil dries, the plant closes the pores (stomata) through which its leaves exchange
gases with the air. This reduces the loss of water, but also the entry of CO₂ into the
leaf. A drought that lasts longer can also affect the photosynthetic machinery itself.

In this experiment the drought was **progressive**. The control plants were watered every
other day, from the bottom (several pots stood in one tray, and water was added to the
tray). The droughted plants were not watered for 7 days, during which the soil dried
gradually, and their light response curves were measured at the end of these 7 days. The
weight of the pots was checked from time to time, but the water content of the soil and
the water status of the plants were not recorded.

## The plants and how they were grown

The plants were *Arabidopsis thaliana*, accession Col-0, a small annual plant of the
mustard family that grows as a rosette of leaves and is widely used as a model species in
plant biology. Seeds were sown on a moist mixture of soil and perlite (1:2; Primasta BV,
Asten, The Netherlands) and kept in darkness at 4 °C for 4 days, which makes the seeds
germinate together. The pots were then placed in one of two climate-controlled rooms, one
at 22 °C and one at 28 °C (the same temperature by day and by night). Both rooms had a
relative humidity of 70% and a light intensity of 120 µmol/m²/s at plant height, from
fluorescent tubes, for 8 hours a day.

## The design

The plants were grown in five **batches**. The plants of a batch were sown on the same date
and grown together, and the batches were sown one week apart. Within each batch, plants
were grown at both temperatures, and the control or drought treatment started when the
plants were large enough to have leaves that filled the leaf chamber of the instrument
(see below). One light response curve was measured on each plant, so each curve comes
from a different plant. The number of curves in each batch and combination of treatments
is:

| Batch | 22 °C, control | 28 °C, control | 22 °C, drought | 28 °C, drought |
|---|---|---|---|---|
| 1 | 2 | 1 | 1 | 1 |
| 2 | 2 | 1 | 1 | 1 |
| 3 | 2 | 1 | 1 | 1 |
| 4 | 3 | 1 | 0 | 1 |
| 5 | 3 | 1 | 2 | 1 |
| Total | 12 | 5 | 5 | 5 |

## How the curves were measured

Net photosynthesis was measured with a portable gas exchange system (LI-6800, LI-COR) with
a leaf chamber of 6 cm². On each plant, the youngest leaf that was large enough to fill the
whole chamber was measured, so the leaf area in the chamber was always 6 cm². In the
chamber, the CO₂ concentration was kept at 400 µmol/mol (400 ppm), the leaf temperature
at 22 °C (measured with a thermocouple touching the leaf) and the relative humidity at
70%. The light came from light-emitting diodes in the chamber, 90% red and 10% blue.

Each curve has nine measurements, at light levels of 25, 50, 100, 150, 250, 350, 500, 750
and 1,000 µmol/m²/s, applied from the lowest to the highest. The leaf was kept at each
light level for 5 to 8 minutes before the reading. Stomata respond slowly to a change in
light, and at the higher light levels they may not have finished opening by the time of
the reading, so the rates at high light may be somewhat lower than those that the leaf
would reach after a longer time. No measurement was made in darkness. The recorded light
levels differ slightly from the values above, by at most a few hundredths of a µmol/m²/s.

## The data

The file `PhotosynthesisArabidopsisRaw.csv` has one row per measurement (243 rows, nine
for each of 27 curves) and six columns:

| Column | Content | Units |
|---|---|---|
| `Batch` | Batch of plants (1 to 5) | none |
| `T` | Growth temperature: `LT` (low, 22 °C) or `HT` (high, 28 °C) | none |
| `W` | Water: `C` (control, watered every other day) or `D` (drought, not watered for 7 days) | none |
| `Replicate` | Curve identifier, numbered 1 to 27 across all batches; each curve is a different plant | none |
| `P` | Net photosynthesis (net uptake of CO₂ by the leaf, per unit of leaf area) | µmol/m²/s |
| `I` | Light reaching the leaf | µmol/m²/s |

The rows are sorted by curve and, within a curve, from the lowest to the highest light,
which is also the order of the measurements. A negative value of `P` means that the leaf
released more CO₂ than it took up.

The data were collected by Alejandro Morales at Utrecht University in 2019 and 2020 and
have not been published.
