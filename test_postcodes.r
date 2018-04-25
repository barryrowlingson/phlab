#!/usr/bin/env r

# given a CSV of postcodes, see how many exist in a lookup table.


library(RSQLite, warn.conflicts=FALSE, quietly=TRUE)
library(utils, warn.conflicts=FALSE, quietly=TRUE)
library(devtools, warn.conflicts=FALSE, quietly=TRUE)
load_all("./phlabr", quiet=TRUE)
load_all("./UKpostcodes", quiet=TRUE)

pc_db = argv[1]
pc_csv = argv[2]
pc_column = argv[3]

message("Testing postcodes in column: \"",pc_column,"\" of file ",pc_csv)

testcodes = read_postcodes_file(pc_csv)
message("Testing ",nrow(testcodes)," records")

if(!(pc_column %in% names(testcodes))){
    stop("No column ", pc_column," in ",paste0(names(testcodes),collapse=","))
}

unique_testcodes = data.frame(postcode = gsub(" ","",unique(testcodes[[pc_column]])))

message("Using spaceless postcodes.")
pc_db = get_postcodes_db(sqlite=pc_db, table="postcodes",column="pcs")

print(head(pc_db))

code_ok = test_postcodes(unique_testcodes$postcode, pc_db$pcs)

total <- length(code_ok)
found <- sum(code_ok)

message("Postcode database size: ",nrow(pc_db))

message("Looked up ",total," unique postcodes, matched ",found)

message("Bad postcode summary")
bads = unique_testcodes$postcode[!code_ok]
print(pc_summaries(bads))
