complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating the location of
        ## the CSV files
        ## 'id' is an integer vector indicating the monitor ID numbers to be used
        ## Return a data frame of the form: id nobs 1 117 2 1041 ...  where 'id' is
        ## the monitor ID number and 'nobs' is the number of complete cases
        nobs = numeric()
        for (i in id) {
                newRead = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), 
                                         ".csv", sep = ""))
                nobs = c(nobs, sum(complete.cases(newRead)))
        }
        return(data.frame(id, nobs))
}

#> cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
#> print(cc$nobs)
#[1] 228 148 124 165 104 460 232
#> cc <- complete("specdata", 54)
#> print(cc$nobs)
#[1] 219
#> set.seed(42)
#> cc <- complete("specdata", 332:1)
#> use <- sample(332, 10)
#> print(cc[use, "nobs"])
#[1] 711 135  74 445 178  73  49   0 687 237