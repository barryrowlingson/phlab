#!/usr/bin/env r
#
# run a named report, which will be an R markdown file.
#
message("Running report")
report_dir = "./reports"

library(rmarkdown)
library(docopt)

if(length(argv)==0){
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
report_file = file.path(report_dir, paste0(report,".Rmd"))

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

message("Getting yaml")
yaml = yaml_front_matter(report_file)
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
message("Rendering")
render(report_file, output_dir=output_dir, output_format="all", envir=e, quiet=TRUE)


