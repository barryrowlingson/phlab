#!/usr/bin/env r

# fit a GLM to the temporal count data

library(devtools)
load_all("./phlabr")

message("Command args are...")
print(argv)

data=argv[1]

message("Reading from ",data)

m = fit_time_file(data)

print(summary(m))

