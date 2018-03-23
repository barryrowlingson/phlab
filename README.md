# phlab

## Test postcode lookup database

This tests on a tiny postcode database with a small internal CSV file of postcodes in a column named `postcode`:

```
docker run  -it --rm barryrowlingson/phlab \
    ./test_postcodes.r ./test_data/postcodes.sqlite ./test_data/test1.csv postcode
```

## Production postcode lookup database:

The actual study area postcode database will live under `/phe`.  This example
tests the small postcode file against the full study area database:

```
# Set this to the PHE data folder:
export PHE=/data/rowlings/PHE/phe

docker run \
 --mount type=bind,source=$PHE,target=/phe \
 -it --rm barryrowlingson/phlab \
 ./test_postcodes.r /phe/postcodes.gpkg ./test_data/test1.csv postcode

# test with BB11AB style codes
docker run \
 --mount type=bind,source=$PHE,target=/phe \
 -it --rm barryrowlingson/phlab \
 ./test_postcodes.r /phe/postcodes.gpkg ./test_data/test_nospace.csv postcode
```

## Test on data outside the container

Suppose we have on our computer, outside the container, a CSV file
called `test1.csv` of postcodes in column names `postcode` in
`/testdata/path`, we mount that folder to `/test`:

```
export TESTDATA=/testdata/path/

docker run  --mount type=bind,source=$TESTDATA,target=/test \
            --mount type=bind,source=$PHE,target=/phe \
            -it --rm barryrowlingson/phlab \
            ./test_postcodes.r /phe/Postcodes/postcodes.gpkg /test/test1.csv postcode
```
