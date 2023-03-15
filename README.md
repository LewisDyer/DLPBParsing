# DLPBParsing
Parsing DLPB dataset into ArangoDB

Using v14 of the DLPB citation network here: https://www.aminer.org/citation (note: around 6GB compressed and 18GB uncompressed).

# Instructions

This file is very large, so it's not possible to import it directly into Arango:

1. Create a new directory `splits`.

2. Run the following command, splitting the dataset into 100 different files:

`$ split -l $(expr $(wc -l < dblp_v14.json) / 100 + 1) dblp_v14.json splits/file_`

3. Run the `fix_arrays.bash` script to format each of these files into JSON arrays, which can then be imported into ArangoDB.

