#!/usr/bin/env r
#
# run a named report, which will be an R markdown file.
#

library(rmarkdown)

report = argv[1]
report_file = file.path("./reports",paste0(report,".Rmd"))

daydir = format(Sys.time(),"%F")
output_dir = file.path("./outputs/",daydir)
dir.create(output_dir, recursive=TRUE)
output_dir = normalizePath(output_dir)
message("Output directory is ",output_dir)

output_file =  tempfile(pattern=paste0(report,"-"), tmpdir=output_dir, fileext=".pdf")

message("Output file is ",output_file)

render(report_file, output_file=output_file)

