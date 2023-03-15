# DLPBParsing
Parsing DLPB dataset into ArangoDB

Using v14 of the DLPB citation network here: https://www.aminer.org/citation (note: around 6GB compressed and 18GB uncompressed).

# Instructions

This file is very large, so it's not possible to import it directly into Arango:

1. Create a new directory `splits`.

2. Run the `split.bash` script to split up the dataset and format each of these files into JSON arrays, which can then be imported into ArangoDB.

3. Run the `arango_import.bash` script to import that data into ArangoDB. Note it assumes you have a database called `DBLP_v14` with a `papers` collection and password `arangopass` - change as appropriate.

## TODO

Queries:
* Import Authors into separate collection
* Import Venues into separate collection
* Import Fields of Study into separate collection
* Tidy up Papers collection
* Add (all) edges