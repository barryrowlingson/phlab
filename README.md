# phlab

# Test postcode lookup database:

docker run  -it --rm phlab ./test_postcodes.r ./test_data/postcodes.sqlite ./test_data/test1.csv postcode

# Production postcode lookup database:

# Set this to the PHE data folder. 

PHE=/data/rowlings/PHE/

docker run \
 --mount type=bind,source=$PHE,target=/phe \
 -it --rm phlab \
 ./test_postcodes.r /phe/Postcodes/postcodes.sqlite ./test_data/test1.csv postcode

