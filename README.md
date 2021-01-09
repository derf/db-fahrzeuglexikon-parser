# db-fahrzeuglexikon-parser

db-fahrzeuglexikon-parser extracts PNG/SVG wagon images and accompanying JSON
data for DB long-distance carriages from a Fahrzeuglexikon PDF obtained from
[data.deutschebahn.com](https://data.deutschebahn.com/dataset/fahrzeuglexikon).

## Online Services

The latest JSON, PNG, and SVG output produced by db-fahrzeuglexikon-parser is
available online at
[dbdb/db\_wagen](https://lib.finalrewind.org/dbdb/db_wagen/).

Both Fahrzeuglexikon PDF and generated PNG/SVG/JSON files are Open Data.

* [DB Fahrzeuglexikon License](https://data.deutschebahn.com/dataset/fahrzeuglexikon)
* [PNG/SVG/JSON License](https://lib.finalrewind.org/dbdb/db_wagen/COPYING)

## Naming Schema

For standalone carriages (IC, IC2 Twindex), the filename is the wagon type.
E.g. "Bimmdzf.png" or "DBpza.png".

For ICE 1, 2, 3 (model 407), 4, and T (model 415) trains, the filename uses
positions 5 through 9 of the UIC wagon number. E.g. for IC2 KISS wagon 93 85 4
110 617-6: "41106.png".

For ICE 3 model 403/406 and ICE T model 411, the filename uses UIC positions 5
through 9, followed by a character indicating wether it is a series 1, series
2, or redesigned wagon. Example for a redesined ICE 3 (model 403) wagon:
"54037.r.png".

ICE Metropolitan and the 7-carriage ICE 4 variant are not supported.
