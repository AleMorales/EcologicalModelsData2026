# Sources of the images on the introductory slides

The three photographs come from Wikimedia Commons (downloaded on 20 November 2026 as
960-pixel previews), cropped to 4:3 around the beetles and resized to 800 × 600 pixels.
The licences require attribution; the slide carries a short credit line.

| File | Shows | Author | Licence | Source |
|---|---|---|---|---|
| `ladybird-typica.jpg` | Non-melanic (*typica*) two-spot ladybird, Noordwijk, the Netherlands | Rudolphous | CC BY-SA 4.0 | https://commons.wikimedia.org/wiki/File:Noordwijk_-_Tweestippelig_lieveheersbeestje_(Adalia_bipunctata).jpg |
| `ladybird-melanic.jpg` | Mating pair of melanic two-spot ladybirds (form *quadrimaculata*) | jpuf | CC0 | https://commons.wikimedia.org/wiki/File:Adalia_bipunctata_197039227.jpg |
| `ladybird-mixed-pair.jpg` | Melanic and non-melanic two-spot ladybird mating | gailhampshire (Flickr) | CC BY 2.0 | https://commons.wikimedia.org/wiki/File:Forms_of_2-spot_Ladybird_Adalia_bipunctata._%5E_Coccinellidae._-_Flickr_-_gailhampshire.jpg |

Under CC BY-SA 4.0, the cropped version of `ladybird-typica.jpg` is shared under the same
licence.

`transects-map.png` and `data-1980.png` are drawn by `figures.R`:

- country outlines: Natural Earth, 1:10m admin 0 countries (public domain),
  https://github.com/nvkelso/natural-earth-vector, cut to the region of the map in
  `map-outline.csv`; at this scale some estuaries of the south-west Netherlands are drawn
  as land;
- localities: coordinates from OpenStreetMap (© OpenStreetMap contributors, ODbL),
  geocoded with Nominatim on 20 November 2026, in `localities.csv`;
- data: the 1980 survey of the east–west transect in `../../adalia.csv`.
