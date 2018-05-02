#!/usr/bin/env r
#
# run a named report, which will be an R markdown file.
#

library(rmarkdown)

report = argv[1]
report_file = file.path("./reports",paste0(report,".Rmd"))

daydir = format(Sys.time(),"%F")
output_dir = file.path("./outputs/",daydir, tempfile(pattern=paste0(report,"-"),tmpdir=""))
dir.create(output_dir, recursive=TRUE)
output_dir = normalizePath(output_dir)
message("Output directory is ",output_dir)

# remove the markdown doc name
argv=argv[-1]

# args with spaces get broken unless protected, and this isn't called..
qs = function (x){
    ifelse(stringr::str_detect(x, "\\s"), shQuote(x), x)
}
argv=qs(argv)

# stick argv in the environment so it can be found in the document
e = new.env()
assign("argv",argv,e)

# render the document.
render(report_file, output_dir=output_dir, output_format="all", envir=e)

yaml = yaml_front_matter(report_file)

