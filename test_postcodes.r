#!/usr/bin/env r

# given a CSV of postcodes, see how many exist in a lookup table.


library(RSQLite, warn.conflicts=FALSE, quietly=TRUE)
library(utils, warn.conflicts=FALSE, quietly=TRUE)
library(devtools, warn.conflicts=FALSE, quietly=TRUE)
load_all("./phlabr", quiet=TRUE)

pc_db = argv[1]
pc_csv = argv[2]
pc_column = argv[3]

testcodes = read_postcodes_file(pc_csv)
message("Testing ",nrow(testcodes)," records")

unique_testcodes = data.frame(postcode = unique(testcodes[[pc_column]]))

pc_db = get_postcodes_db(pc_db, "postcodes","postcode")

unique_testcodes$OK = test_postcodes(unique_testcodes[[pc_column]], pc_db$postcode)

total <- nrow(unique_testcodes)
found <- sum(unique_testcodes$OK)

message("Postcode database size: ",nrow(pc_db))

message("Looked up ",total," unique postcodes, matched ",found)







