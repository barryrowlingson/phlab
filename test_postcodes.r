#!/usr/bin/env r

# given a CSV of postcodes, see how many exist in a lookup table.


library(RSQLite, warn.conflicts=FALSE, quietly=TRUE)
library(utils, warn.conflicts=FALSE, quietly=TRUE)
library(devtools, warn.conflicts=FALSE, quietly=TRUE)
load_all("./phlabr", quiet=TRUE)

pc_db = argv[1]
pc_csv = argv[2]
pc_column = argv[3]

message("Testing postcodes in column: \"",pc_column,"\" of file ",pc_csv)

testcodes = read_postcodes_file(pc_csv)
message("Testing ",nrow(testcodes)," records")

unique_testcodes = data.frame(postcode = gsub(" ","",unique(testcodes[[pc_column]])))


message("Using spaceless postcodes.")
pc_db = get_postcodes_db(pc_db, "postcodes","pcs")

unique_testcodes$OK = test_postcodes(unique_testcodes$postcode, pc_db$pcs)

total <- nrow(unique_testcodes)
found <- sum(unique_testcodes$OK)

message("Postcode database size: ",nrow(pc_db))

message("Looked up ",total," unique postcodes, matched ",found)







