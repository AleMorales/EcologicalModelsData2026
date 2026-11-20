# Melanism in the two-spot ladybird along transects in the Netherlands

## The two-spot ladybird and its colour morphs

The **two-spot ladybird**, *Adalia bipunctata*, is a common ladybird beetle of gardens,
parks, hedges and trees, where adults and larvae feed on aphids. It is **polymorphic** in
colour: individuals of the same population belong to genetically distinct colour forms,
or **morphs**. The morphs fall into two classes:

- **non-melanics** (also called *typica*): red with black spots, usually one spot on each
  wing case;
- **melanics**: mostly black with red spots (there are several melanic morphs, which
  differ in the number and size of the spots).

The colour is inherited. The alleles for melanism are dominant over the allele for the
non-melanic form, so a beetle with at least one melanic allele is black. The frequency of
melanics in a population therefore reflects the frequency of the melanic alleles.

In the Netherlands there are about two generations of beetles each year. The adults
overwinter and emerge in spring to feed on aphids and reproduce.

## Why the colour might matter

The proportion of melanics differs between places, in the Netherlands and in other
countries. One explanation that has been studied in this species is **thermal melanism**.
Ladybirds can only fly, feed and mate when their body is warm enough, and in spring they
warm up mainly by absorbing sunlight. A black beetle absorbs more radiation than a red
one, and laboratory measurements showed that melanic beetles reach higher body
temperatures and are more active under the same conditions. This advantage is expected
to be largest when the air is cool, the wind is light, the sunshine is intermittent and
the radiation is strong, and to be small when it is warm or windy. Other differences
between the morphs have also been proposed, for example in winter survival, in mate
choice and in their interactions with prey, predators and parasites, so the frequency of
melanics in a place may reflect several effects.

## The study area

The localities lie in the south-west of the Netherlands, in the provinces of South
Holland and North Brabant, and one in Belgium. The landscape is flat and the climate is
maritime, but it changes with the distance to the North Sea. Records of the national
weather service at stations near the localities show that, in spring, the coast has more
hours of sunshine and stronger winds than the interior, and that both decline with the
distance from the coast. In April and May, the daily maximum temperature tends to be
higher inland and the daily minimum temperature lower inland than at the coast.

## The transects

Populations of the two-spot ladybird were sampled along two **transects**, bands about
10 km wide that run from the coast inland:

- The **east–west transect** runs over about 115 km from Ouddorp, near the coast, to
  Waalre near Eindhoven. It has 16 localities (villages and towns), each described by its
  distance to the coast (km). From the coast inland they are: Ouddorp, Goedereede,
  Stellendam, Dirksland, Middelharnis, Oude Tonge, Achthuizen, Ooltgensplaat, Willemstad,
  Klundert, Oudenbosch, Zevenbergen, Etten-Leur, Prinsenbeek, Tilburg and Waalre.
- The **north–south transect** runs over about 90 km from Delft, near the coast, south to
  Antwerpen in Belgium. It has 14 localities, each described by its distance from Delft
  (km), which is not the distance to the coast. From Delft southwards they are: Delft,
  Rotterdam, Rhoon, Barendrecht, Heinenoord, Mijnsheerenland, Klaaswaal, Numansdorp,
  Willemstad, Helwijk, Dinteloord, Steenbergen, Bergen op Zoom and Antwerpen.

The two transects cross at Willemstad, a locality that belongs to both. Because the two
transects measure distance from different points, a distance of 30 km does not mean the
same thing on both.

## The surveys

The east–west transect was sampled in five **surveys**, labelled 1980, 1991, 1995, 1998
and 2004. The survey labelled 1980 combines collections made between 1978 and 1981. The
north–south transect was sampled in the 1980 survey and once more about ten years later
(labelled 1991 in the data); one of its localities, Numansdorp, was sampled again in 2004.
Not every locality was sampled in every survey.

At each locality, adults and pupae were collected, mainly from lime trees (*Tilia*),
shrubs such as *Rosa rugosa* and *Euonymus*, and other plants. Pupae were kept in the
laboratory until the adults emerged. Every beetle was then scored as melanic or
non-melanic. A **sample** is all the beetles scored at one locality in one survey.

From about 2002 the harlequin ladybird *Harmonia axyridis*, an invasive species from
Asia, spread through the region and reduced the numbers of native ladybirds, including
the two-spot ladybird. In 2004 it was therefore harder to find beetles: the samples are
smaller than in earlier surveys, and several localities could not be sampled at all.

## The data

The file `adalia.csv` has one row per sample and six columns:

| Column | Content | Units |
|---|---|---|
| `transect` | `EW` (east–west) or `NS` (north–south) | none |
| `place` | Locality (some names are abbreviated: `Etten L.` is Etten-Leur, `Mijnsheerenl.` Mijnsheerenland, `Bergen op z.` Bergen op Zoom, and `Waalre` stands for Waalre/Eindhoven) | none |
| `year` | Survey (1980 stands for the collections of 1978 to 1981) | year |
| `distance_km` | For `EW`, the distance of the locality to the coast; for `NS`, the distance from Delft | km |
| `black` | Number of melanic beetles in the sample | beetles |
| `red` | Number of non-melanic beetles in the sample | beetles |

The number of beetles in a sample is `black + red`; it ranges from 35 to several thousand.
The distance is a property of the locality, so it is the same in every survey. The rows
are sorted by transect, survey and distance. There are 70 samples from the east–west
transect and 29 from the north–south transect. Willemstad appears in both transects, with
a different distance in each; its 1980 sample is the same collection in both.

The data were collected by P. M. Brakefield and P. W. de Jong (Leiden University) and
their colleagues.
