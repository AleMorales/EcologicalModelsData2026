# Water infiltration on degraded and non-degraded soils in semi-arid Kenya

## Why infiltration matters

**Infiltration** is the entry of water into the soil through its surface. Water that does
not infiltrate runs off over the surface, where it can carry soil away, and it is not
stored in the soil for plants. In a semi-arid region, where rain is scarce and the
evaporative demand is high, how much of the rain enters the soil decides much of what
grows there.

The rate at which water enters a soil depends on its pores: how many there are, how large
they are and how well they are connected. When a soil is **physically degraded**, these
pores are lost or blocked. Raindrops break down the aggregates at the surface and the fine
particles that are released seal the spaces between the larger ones, forming a hard
**crust**; trampling by livestock or traffic **compacts** the soil; and on bare land the
topsoil may be washed away by **erosion** (thin sheets of soil, small channels called
rills, or deep gullies), exposing the denser soil below. All of these are expected to slow
infiltration, but degradation develops slowly, and a soil can lose part of its pore space
before any sign of it is visible at the surface.

The data come from a study that asked whether infiltration measured in the field can be
used to tell physically degraded soils from non-degraded ones, so that degradation could
be assessed over large areas and detected early.

## The study area

The measurements were made in the Upper Athi River basin in eastern Kenya, a watershed of
about 4,500 km² south-east of Nairobi. Most of the basin is gently sloping to almost flat
and lies below 1,000 m; the northern and southern parts are higher (above 1,500 m) and
have steep slopes. Annual rainfall is about 800 to 1,100 mm in the higher parts and 600 to
800 mm in the lower parts, and most of it falls in two rainy seasons: the long rains
(late March to early June) and the short rains (from September). The soils are mostly
silty loams to sands with few nutrients. Much of the land was covered by savannah or
forest until about the 1950s and has since been converted to cropland and grazing land;
the area is known for frequent droughts and food shortages.

## The sampling design

The field survey took place between December 2002 and March 2003, mostly in the dry
season between the two rainy seasons. Within the basin, 45 blocks of 1 km × 1 km were
placed at random. In each block, plots of 30 m × 30 m were laid out along the three arms
of a Y-shaped frame, and infiltration was measured on four of them (the plot at the centre
of the Y and the outermost plot of each arm). Within a plot, measurements were made at
three positions along the slope, at 5, 15 and 25 m from the edge of the plot. Only the
top 20 cm of the soil was studied. The plots were under different land uses: forest,
woodlots, shrubland, cropland and grassland.

The data set that we use is a part of this survey: one infiltration run on each of 30
plots. It does not say which block each plot belongs to or where in the plot the run was
made.

## How infiltration was measured

Infiltration was measured with a **single-ring infiltrometer**: a metal ring with an
inner diameter of 30 cm that is pushed into the soil surface and filled with water. The
surface inside the ring was wetted before the measurement started. The water was not
topped up during the run, so its level in the ring fell as water entered the soil (a
**falling-head** measurement). The fall of the water level was recorded at successive
times, at intervals of 1 minute at the start of a run and mostly 2 minutes later on.

The infiltration rate of a reading is the depth of water that entered the soil during the
interval divided by the length of the interval (a depth per unit of time, in cm/min). It
is therefore the average rate over that interval, not the rate at one instant. The depths
behind the rates are whole millimetres.

## The degradation classes

Before the measurements, each plot was inspected for visible signs of physical
degradation and assigned to one of three classes:

| Class | Description | Visible signs |
|---|---|---|
| `E0` | Non-degraded | No visible sign of degradation |
| `E1` | Moderately degraded | Signs of degradation of the soil in place: a crust or hard layer on the surface, a surface that is hard to auger, or signs of compaction (waterlogging, uneven growth of plants or grass, mottling or a hard layer in the subsoil) |
| `E2` | Severely degraded | Several signs of degradation, including signs of erosion: small heaps of washed sand, deposits of soil against obstacles, rills (channels up to 30 cm deep) with exposed roots, or gullies that expose the deeper soil |

The classes are a judgement made by eye in the field, not a measurement. In the 30 plots
of our data set, 7 are in class `E0`, 19 in `E1` and 4 in `E2`.

## The data

The file `infiltration.csv` has one row per reading and six columns:

| Column | Content | Units |
|---|---|---|
| `Sample` | Row number | none |
| `PlotNo` | Plot identifier (30 plots) | none |
| `Erosion` | Degradation class of the plot (`E0`, `E1`, `E2`) | none |
| `Time` | Time since the start of the run at the end of the interval | min |
| `Rate` | Infiltration rate over the interval that ends at `Time` | cm/min |
| `Cumrate` | Running sum of `Rate` within the plot, as supplied with the data | see `Rate` |

The rows are sorted by plot and by time. Each plot has between 15 and 54 readings, and the
runs lasted between 33 and 88 minutes.

The data were collected by C. T. Omuto (University of Nairobi) and are distributed as the
data set `infilt` of the R package HydroMe.
