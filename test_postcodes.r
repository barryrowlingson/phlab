#!/usr/bin/env r

# given a CSV of postcodes, see how many exist in a lookup table.

library(devtools, warn.conflicts=FALSE, quietly=TRIE)
load_all("./phlabr", quiet=TRUE)

pc_db = argv[1]
pc_csv = argv[2]
pc_column = argv[3]

testcodes = read_postcodes_file(pc_csv)
testcodes = data.frame(postcode = unique(testcodes[[pc_column]]))

pc_db = get_postcodes_db(pc_db, "postcodes","postcode")

testcodes$OK = test_postcodes(testcodes[[pc_column]], pc_db$postcode)

total <- nrow(testcodes)
found <- sum(testcodes$OK)

message("Postcode database size: ",nrow(pc_db))

message("Looked up ",total," postcodes, matched ",found)







