#!/usr/bin/env r
#
# run a named report, which will be an R markdown file.
#

library(rmarkdown)

report = argv[1]
report_file = file.path("./reports",paste0(report,".Rmd"))

daydir = format(Sys.time(),"%F")
output_dir = normalizePath(file.path("./outputs/",daydir))
dir.create(output_dir, showWarnings=FALSE, recursive=TRUE)
output_file = tempfile(pattern=paste0(report,"-"), tmpdir=output_dir, fileext=".pdf")

render(report_file, output_file=output_file)

