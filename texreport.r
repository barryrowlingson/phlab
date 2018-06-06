#!/usr/bin/env r
#
# run a named report, which will be an R markdown file.
#
message("Running report")
report_dir = "./reports"

library(knitr)
library(rmarkdown)
library(docopt)


if(length(argv)==0){
    stop("No report specified")
    message("No report specified")
    reports = list.files(report_dir, "*.Rmd$")
    message("Reports: ")

    for(report in reports){
        report_name = sub(".Rmd","",report)
        message("\nReport Name: ",report_name,"\n")
        report_file = file.path(report_dir, report)
        meta = yaml_front_matter(report_file)
        message(meta$description)
        cat(meta$docopt)
        message("---------------------------")
    }
    stop()
}

report = argv[1]
report_file = normalizePath(file.path(getwd(), report_dir, paste0(report,".Rnw")))
report_yaml_file = normalizePath(file.path(report_dir, paste0(report,".yml")))

daydir = format(Sys.time(),"%F")
output_dir = normalizePath(file.path("./outputs/",daydir, tempfile(pattern=paste0(report,"-"),tmpdir="")))
output_dir = normalizePath(output_dir)
dir.create(output_dir, recursive=TRUE)
message("Output directory is ",output_dir)

# remove the report doc name
argv=argv[-1]

# args with spaces get broken unless protected, and this isn't called..
qs = function (x){
    ifelse(stringr::str_detect(x, "\\s"), shQuote(x), x)
}
argv=qs(argv)

message("Getting yaml")
yaml = yaml_front_matter(report_yaml_file)
message("Getting doc")
doc = yaml$docopt
message("Parsing doc")
opts = docopt(doc, argv)

message("Running report")
# stick things in the environment so it can be found in the document
e = new.env()
assign("argv",argv,e)
assign("opts",opts,e)
assign("doc",doc,e)
assign("yaml",yaml,e)
assign("output_dir",output_dir, e)

# render the document.
message("knitting")
setwd(output_dir)
opts_knit$set(base.dir=getwd())
knit2pdf(report_file)
#render(report_file, output_dir=output_dir, output_format="all", envir=e, quiet=TRUE)


