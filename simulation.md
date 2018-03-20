# Simulating Data Sets

With a CSV file having three columns like:

```
Total,Year,Specimen date
3,2012,01/01/2012
5,2012,02/01/2012
```

Then fit a Poisson GLM to time:

```
m = fit_time_file("data.csv")
```

Read in the postcode database:

```
pc = st_read("../StudyArea/Postcodes/postcodes.sqlite","postcodes")
```

Simulate the data:

```
ss = sim_data(m, pc)
```

which produces an `sf` object with `Date`, `postcode`, and `geometry`
columns, being the point location of the postcode.