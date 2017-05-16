
# Data

The zip file containing the data can be downloaded here:

[specdata.zip](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip) [2.4MB]

The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". Each file contains three variables:

* Date: the date of the observation in YYYY-MM-DD format (year-month-day)
* sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
* nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)
For this programming assignment you will need to unzip this file and create the directory 'specdata'. Once you have unzipped the zip file, do not make any modifications to the files in the 'specdata' directory. In each file you'll notice that there are many days where either sulfate or nitrate (or both) are missing (coded as NA). This is common with air pollution monitoring data in the United States.

## Part 1

Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. A prototype of the function is as follows

```r
pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
}
```
You can see some example output from this function. The function that you write should be able to match this output. Please save your code to a file named pollutantmean.R.

## Part 2

Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases. A prototype of this function follows

```r
complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
}
```
You can see some example output from this function. The function that you write should be able to match this output. Please save your code to a file named complete.R. To run the submit script for this part, make sure your working directory has the file complete.R in it.

## Part 3

Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0. A prototype of this function follows
```r
corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
}
```
For this function you will need to use the 'cor' function in R which calculates the correlation between two vectors. Please read the help page for this function via '?cor' and make sure that you know how to use it.

You can see some example output from this function. The function that you write should be able to match this output. Please save your code to a file named corr.R. To run the submit script for this part, make sure your working directory has the file corr.R in it.

## Question 1
```r
pollutantmean <- function(directory, pollutant, id = 1:332) {
    data = numeric()
    for (i in id) {
newRead = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
data = c(data, newRead[[pollutant]])
    }
    return(mean(data, na.rm = TRUE))
}
## Alternative
pollutantmean <- function(directory, pollutant, id = 1:332) {
    data = lapply(id, function(i) read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))[[pollutant]])
return(mean(unlist(data), na.rm = TRUE))
}

Example
data = lapply(1:10, function(i) read.csv(paste("specdata", "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))[["sulfate"]])
# this is a list, so you should unlist the data
mean(unlist(data), na.rm=TRUE)
# [1] 4.064128
```
## Answers
```r
> pollutantmean("specdata", "sulfate", 1:10)
[1] 4.064128
> pollutantmean("specdata", "nitrate", 70:72)
[1] 1.706047
> pollutantmean("specdata", "sulfate", 34)
[1] 1.477143
> pollutantmean("specdata", "nitrate")
[1] 1.702932
```
## Question 2
```r
complete <- function(directory, id = 1:332) {
    nobs = numeric()
    for (i in id) {
newRead = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
nobs = c(nobs, sum(complete.cases(newRead)))
    }
    return(data.frame(id, nobs))
}

## Alternative

complete <- function(directory, id = 1:332) {
    f <- function(i) {
        data = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
        sum(complete.cases(data))
    }
    nobs = sapply(id, f)
    return(data.frame(id, nobs))
}
```

## Answers
```r
> cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
> print(cc$nobs)
[1] 228 148 124 165 104 460 232
> cc
   id nobs
1   6  228
2  10  148
3  20  124
4  34  165
5 100  104
6 200  460
7 310  232

> cc <- complete("specdata", 54)
> print(cc$nobs)
[1] 219
> cc
  id nobs
1 54  219

> set.seed(42)
> cc <- complete("specdata", 332:1)
> use <- sample(332, 10)
> print(cc[use, "nobs"])
 [1] 711 135  74 445 178  73  49   0 687 237
> cc
     id nobs
1   332   16
2   331  284
3   330  447
4   329  439
5   328  967
6   327  162
7   326  215
8   325  817
9   324   34
10  323   34
... ... ...
320  13   46
321  12   96
322  11  443
323  10  148
324   9  275
325   8  192
326   7  442
327   6  228
328   5  402
329   4  474
330   3  243
331   2 1041
332   1  117
> use
 [1] 304 311  95 274 211 170 241  44 213 228
```

## Question 3
```r
corr <- function(directory, threshold = 0) {

    df = complete(directory)
    ids = df[df["nobs"] > threshold, ]$id
    corrr = numeric()
    for (i in ids) {
newRead = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
        dff = newRead[complete.cases(newRead), ]
        corrr = c(corrr, cor(dff$sulfate, dff$nitrate))
    }
    return(corrr)
}
```

## Answers
```r
> cr <- corr("specdata")  
> cr <- sort(cr) 
> set.seed(868) 
> out <- round(cr[sample(length(cr), 5)], 4)
> print(out)
[1]  0.2688  0.1127 -0.0085  0.4586  0.0447

> cr <- corr("specdata", 129)     
> cr <- sort(cr)
> n <- length(cr)
> set.seed(197) 
> out <- c(n, round(cr[sample(n, 5)], 4))
> print(out)
[1] 243.0000   0.2540   0.0504  -0.1462  -0.1680   0.5969

> cr <- corr("specdata", 2000)
> n <- length(cr)   
> cr <- corr("specdata", 1000)   
> cr <- sort(cr)
> print(c(n, round(cr, 4)))
[1]  0.0000 -0.0190  0.0419  0.1901
```



