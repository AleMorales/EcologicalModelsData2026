# Sources of the images on the introductory slides

The three photographs come from Wikimedia Commons (downloaded on 20 November 2026 as
960-pixel previews, unchanged). The licences require attribution; the slides carry a short
credit line. None of the photographs shows a plot of the study.

| File | Shows | Author | Licence | Source |
|---|---|---|---|---|
| `machakos-landscape.jpg` | Semi-arid landscape along a road near Machakos, Kenya | Steve Andersen (Flickr) | CC BY-SA 2.0 | https://commons.wikimedia.org/wiki/File:Machakos-Kenia_Rd.jpg |
| `gully-erosion.jpg` | Gully erosion and soil degradation, Ghana | Suglo20 | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Gully_erosion_and_soil_degradation_in_Ghana.jpg |
| `infiltrometer-ring.jpg` | A single-ring infiltrometer filled with water, with a ruler | Soil Physics at English Wikipedia | Public domain | https://commons.wikimedia.org/wiki/File:Single_ring.JPG |

`kenya-map.png` and `data-three-plots.png` are drawn by `figures.R`:

- country outlines and lakes: Natural Earth, 1:50m admin 0 countries and lakes (public
  domain), https://github.com/nvkelso/natural-earth-vector, cut to the region of the map
  in `kenya-outline.csv`;
- Nairobi and Machakos: approximate coordinates; the circle marks the approximate
  position of the Upper Athi River basin (south-east of Nairobi, about 4,500 km²) and is
  not its boundary, which Natural Earth does not contain;
- data: three plots of `../../infiltration.csv`, one per class (the plot whose depth
  infiltrated in the first 30 minutes is closest to the median of its class: 19lP3,
  14lP3 and 5lP3).
