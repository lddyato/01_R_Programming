# Air Polltion PM2.5 in 1999 and 2012.R
## setwd("~/CourseraModules/04_ExploratoryAnalysis/CaseStudy/pm25_data")

## Has fine particle pollution in the U.S. decreased from 1999 to
## 2012?

## Read in data from 1999

# ignore the lines that start with the hash symbol - comment.char = "#"
> pm0 <- read.table("RD_501_88101_1999-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
> pm1 <- read.table("RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
> dim(pm0)
[1] 117421     28
> dim(pm1)
[1] 1304287      28
> head(pm0)
  V1 V2 V3 V4 V5    V6 V7 V8  V9 V10      V11   V12    V13  V14 V15 V16  V17 V18 V19 V20 V21 V22 V23 V24 V25 V26 V27 V28
1 RD  I  1 27  1 88101  1  7 105 120 19990103 00:00     NA   AS   3  NA <NA>  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
2 RD  I  1 27  1 88101  1  7 105 120 19990106 00:00     NA   AS   3  NA <NA>  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
3 RD  I  1 27  1 88101  1  7 105 120 19990109 00:00     NA   AS   3  NA <NA>  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
4 RD  I  1 27  1 88101  1  7 105 120 19990112 00:00  8.841 <NA>   3  NA <NA>  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
5 RD  I  1 27  1 88101  1  7 105 120 19990115 00:00 14.920 <NA>   3  NA <NA>  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
6 RD  I  1 27  1 88101  1  7 105 120 19990118 00:00  3.878 <NA>   3  NA <NA>  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
> cnames <- readLines("RD_501_88101_1999-0.txt", 1)
> print(cnames)
[1] "# RD|Action Code|State Code|County Code|Site ID|Parameter|POC|Sample Duration|Unit|Method|Date|Start Time|Sample Value|Null Data Code|Sampling Frequency|Monitor Protocol (MP) ID|Qualifier - 1|Qualifier - 2|Qualifier - 3|Qualifier - 4|Qualifier - 5|Qualifier - 6|Qualifier - 7|Qualifier - 8|Qualifier - 9|Qualifier - 10|Alternate Method Detectable Limit|Uncertainty"
> cnames <- strsplit(cnames, "|", fixed = TRUE)
# The variable cnames now holds a list of the column headings
> print(cnames)
[[1]]
 [1] "# RD"                              "Action Code"                       "State Code"                       
 [4] "County Code"                       "Site ID"                           "Parameter"                        
 [7] "POC"                               "Sample Duration"                   "Unit"                             
[10] "Method"                            "Date"                              "Start Time"                       
[13] "Sample Value"                      "Null Data Code"                    "Sampling Frequency"               
[16] "Monitor Protocol (MP) ID"          "Qualifier - 1"                     "Qualifier - 2"                    
[19] "Qualifier - 3"                     "Qualifier - 4"                     "Qualifier - 5"                    
[22] "Qualifier - 6"                     "Qualifier - 7"                     "Qualifier - 8"                    
[25] "Qualifier - 9"                     "Qualifier - 10"                    "Alternate Method Detectable Limit"
[28] "Uncertainty"                      

> names(pm0) <- make.names(cnames[[1]])
> head(pm0)
  X..RD Action.Code State.Code County.Code Site.ID Parameter POC Sample.Duration Unit Method     Date Start.Time Sample.Value
1    RD           I          1          27       1     88101   1               7  105    120 19990103      00:00           NA
2    RD           I          1          27       1     88101   1               7  105    120 19990106      00:00           NA
3    RD           I          1          27       1     88101   1               7  105    120 19990109      00:00           NA
4    RD           I          1          27       1     88101   1               7  105    120 19990112      00:00        8.841
5    RD           I          1          27       1     88101   1               7  105    120 19990115      00:00       14.920
6    RD           I          1          27       1     88101   1               7  105    120 19990118      00:00        3.878
  Null.Data.Code Sampling.Frequency Monitor.Protocol..MP..ID Qualifier...1 Qualifier...2 Qualifier...3 Qualifier...4 Qualifier...5
1             AS                  3                       NA          <NA>            NA            NA            NA            NA
2             AS                  3                       NA          <NA>            NA            NA            NA            NA
3             AS                  3                       NA          <NA>            NA            NA            NA            NA
4           <NA>                  3                       NA          <NA>            NA            NA            NA            NA
5           <NA>                  3                       NA          <NA>            NA            NA            NA            NA
6           <NA>                  3                       NA          <NA>            NA            NA            NA            NA
  Qualifier...6 Qualifier...7 Qualifier...8 Qualifier...9 Qualifier...10 Alternate.Method.Detectable.Limit Uncertainty
1            NA            NA            NA            NA             NA                                NA          NA
2            NA            NA            NA            NA             NA                                NA          NA
3            NA            NA            NA            NA             NA                                NA          NA
4            NA            NA            NA            NA             NA                                NA          NA
5            NA            NA            NA            NA             NA                                NA          NA
6            NA            NA            NA            NA             NA                                NA          NA
> names(pm1) <- make.names(cnames[[1]])
> head(pm1)
  X..RD Action.Code State.Code County.Code Site.ID Parameter POC Sample.Duration Unit Method     Date Start.Time Sample.Value
1    RD           I          1           3      10     88101   1               7  105    118 20120101      00:00          6.7
2    RD           I          1           3      10     88101   1               7  105    118 20120104      00:00          9.0
3    RD           I          1           3      10     88101   1               7  105    118 20120107      00:00          6.5
4    RD           I          1           3      10     88101   1               7  105    118 20120110      00:00          7.0
5    RD           I          1           3      10     88101   1               7  105    118 20120113      00:00          5.8
6    RD           I          1           3      10     88101   1               7  105    118 20120116      00:00          8.0
  Null.Data.Code Sampling.Frequency Monitor.Protocol..MP..ID Qualifier...1 Qualifier...2 Qualifier...3 Qualifier...4 Qualifier...5
1           <NA>                  3                       NA          <NA>          <NA>          <NA>            NA            NA
2           <NA>                  3                       NA          <NA>          <NA>          <NA>            NA            NA
3           <NA>                  3                       NA          <NA>          <NA>          <NA>            NA            NA
4           <NA>                  3                       NA          <NA>          <NA>          <NA>            NA            NA
5           <NA>                  3                       NA          <NA>          <NA>          <NA>            NA            NA
6           <NA>                  3                       NA          <NA>          <NA>          <NA>            NA            NA
  Qualifier...6 Qualifier...7 Qualifier...8 Qualifier...9 Qualifier...10 Alternate.Method.Detectable.Limit Uncertainty
1            NA            NA            NA            NA             NA                                NA          NA
2            NA            NA            NA            NA             NA                                NA          NA
3            NA            NA            NA            NA             NA                                NA          NA
4            NA            NA            NA            NA             NA                                NA          NA
5            NA            NA            NA            NA             NA                                NA          NA
6            NA            NA            NA            NA             NA                                NA          NA
> dim(pm1)
[1] 1304287      28
> x0 <- pm0$Sample.Value
> class(x0)
[1] "numeric"
> x1 <- pm1$Sample.Value
> class(x1)
[1] "numeric"
> str(x0)
 num [1:117421] NA NA NA 8.84 14.92 ...
> summary(x0)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    7.20   11.50   13.74   17.90  157.10   13217 
> mean(is.na(x0))  
[1] 0.1125608  # a little over 11% of the 117000+ are missing
> summary(x1)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 -10.00    4.00    7.63    9.14   12.00  909.00   73133 
## Note that the Max has increased from 157 in 1999 to 909 in 2012. This is quite high and might reflect an error in the table or malfunctions in some monitors.

> mean(is.na(x1))  
[1] 0.05607125  ## only 5.6% of the particulate matter measurements are missing.That's about half the percentage as in 1999.

> ## Make a boxplot of both 1999 and 2012
> boxplot(x0, x1)
> boxplot(log10(x0), log10(x1))
Warning messages:
1: In boxplot.default(log10(x0), log10(x1)) : 产生了NaNs
2: In bplt(at[i], wid = width[i], stats = z$stats[, i], out = z$out[z$group ==  :
  boxplot1里没有画离群值(-Inf)
3: In bplt(at[i], wid = width[i], stats = z$stats[, i], out = z$out[z$group ==  :
  boxplot2里没有画离群值(-Inf)
> summary(x1)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 -10.00    4.00    7.63    9.14   12.00  909.00   73133 
 
 #check negative value in x1
> negative <- x1 < 0
> sum(negative, na.rm = T)
[1] 26474
> mean(negative, na.rm = T)
[1] 0.0215034
## just 2% of the x1 values are negative.  Perhaps that's a small enough percentage that we can ignore them. 

## Before we ignore them, though, let's see if they occur during certain times of the year.
> dates <- pm1$Date
> str(dates)
 int [1:1304287] 20120101 20120104 20120107 20120110 20120113 20120116 20120119 20120122 20120125 20120128 ...
> dates <- as.Date(as.character(dates), "%Y%m%d")
> str(dates)
 Date[1:1304287], format: "2012-01-01" "2012-01-04" "2012-01-07" "2012-01-10" "2012-01-13" "2012-01-16" "2012-01-19" "2012-01-22" ...
> hist(dates, "month")  ## Check what's going on in months 1--6
> hist(dates[negative], "month") ## plot a histogram of the months when the particulate matter measurements are negative. 
## We see the bulk of the negative measurements were taken in the winter months, with a spike in May. 
## Not many of these negative measurements occurred in summer months. We can take a guess that because particulate measures tend to be low in winter and high in summer, coupled with the
## fact that higher densities are easier to measure, that measurement errors occurred when the values were low. For now we'll attribute these negative
## measurements to errors. Also, since they account for only 2% of the 2012 data, we'll ignore them.

## Plot a subset for one monitor at both times

## Find a monitor for New York State that exists in both datasets
> site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
> site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
> dim(site0)
[1] 33  2
> dim(site1)
[1] 18  2
> site0 <- paste(site0[,1], site0[,2], sep = ".")
> site1 <- paste(site1[,1], site1[,2], sep = ".")
> head(site0)
[1] "1.5"   "1.12"  "5.73"  "5.80"  "5.83"  "5.110"
> site0
 [1] "1.5"     "1.12"    "5.73"    "5.80"    "5.83"    "5.110"   "13.11"   "27.1004" "29.2"    "29.5"    "29.1007" "31.3"    "47.11"  
[14] "47.76"   "55.6001" "59.5"    "59.8"    "59.11"   "61.10"   "61.56"   "61.62"   "63.2008" "65.2001" "67.19"   "67.1015" "81.94"  
[27] "81.97"   "85.55"   "85.67"   "89.3001" "93.3"    "101.3"   "103.1"  
> site1
 [1] "1.5"     "1.12"    "5.80"    "5.133"   "13.11"   "29.5"    "31.3"    "47.122"  "55.1007" "61.79"   "61.134"  "63.2008" "67.1015"
[14] "71.2"    "81.124"  "85.55"   "101.3"   "103.2"  
> str(site0)
 chr [1:33] "1.5" "1.12" "5.73" "5.80" "5.83" "5.110" "13.11" "27.1004" "29.2" "29.5" "29.1007" "31.3" ...
> str(site1)
 chr [1:18] "1.5" "1.12" "5.80" "5.133" "13.11" "29.5" "31.3" "47.122" "55.1007" "61.79" "61.134" "63.2008" ...
> both <- intersect(site0, site1)
> both
 [1] "1.5"     "1.12"    "5.80"    "13.11"   "29.5"    "31.3"    "63.2008" "67.1015" "85.55"   "101.3"  
 
 ## Find how many observations available at each monitor
> pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
> pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
> str(pm0$county.site)
 chr [1:117421] "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" "27.1" ...
> str(pm1$county.site)
 chr [1:1304287] "3.10" "3.10" "3.10" "3.10" "3.10" "3.10" "3.10" "3.10" "3.10" "3.10" "3.10" "3.10" ...
> cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
> cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
> str(cnt0)
'data.frame':   952 obs. of  29 variables:
 $ X..RD                            : Factor w/ 1 level "RD": 1 1 1 1 1 1 1 1 1 1 ...
 $ Action.Code                      : Factor w/ 1 level "I": 1 1 1 1 1 1 1 1 1 1 ...
 $ State.Code                       : int  36 36 36 36 36 36 36 36 36 36 ...
 $ County.Code                      : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Site.ID                          : int  5 5 5 5 5 5 5 5 5 5 ...
 $ Parameter                        : int  88101 88101 88101 88101 88101 88101 88101 88101 88101 88101 ...
 $ POC                              : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Sample.Duration                  : int  7 7 7 7 7 7 7 7 7 7 ...
 $ Unit                             : int  105 105 105 105 105 105 105 105 105 105 ...
 $ Method                           : int  118 118 118 118 118 118 118 118 118 118 ...
 $ Date                             : int  19990702 19990705 19990708 19990711 19990714 19990717 19990720 19990723 19990726 19990729 ...
 $ Start.Time                       : Factor w/ 11 levels "00:00","01:00",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Sample.Value                     : num  NA NA NA NA 11.8 49.4 8.1 20 NA 16.9 ...
 $ Null.Data.Code                   : Factor w/ 32 levels "AA","AB","AC",..: 17 17 14 14 NA NA NA NA 13 NA ...
 $ Sampling.Frequency               : int  3 3 3 3 3 3 3 3 3 3 ...
 $ Monitor.Protocol..MP..ID         : logi  NA NA NA NA NA NA ...
 $ Qualifier...1                    : Factor w/ 21 levels "1","2","3","4",..: NA NA NA NA NA NA NA NA NA NA ...
 $ Qualifier...2                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...3                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...4                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...5                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...6                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...7                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...8                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...9                    : logi  NA NA NA NA NA NA ...
 $ Qualifier...10                   : logi  NA NA NA NA NA NA ...
 $ Alternate.Method.Detectable.Limit: logi  NA NA NA NA NA NA ...
 $ Uncertainty                      : logi  NA NA NA NA NA NA ...
 $ county.site                      : chr  "1.5" "1.5" "1.5" "1.5" ...
> sapply(split(cnt0, cnt0$county.site), nrow)
   1.12     1.5   101.3   13.11    29.5    31.3    5.80 63.2008 67.1015   85.55 
     61     122     152      61      61     183      61     122     122       7 
> sapply(split(cnt1, cnt1$county.site), nrow)
   1.12     1.5   101.3   13.11    29.5    31.3    5.80 63.2008 67.1015   85.55 
     31      64      31      31      33      15      31      30      31      31 
> ## Choose county 63 and side ID 2008
> pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
> pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
> dim(pm1sub)
[1] 30 29
> dim(pm0sub)
[1] 122  29

> ## Plot data for 2012
> dates1 <- pm1sub$Date
> x1sub <- pm1sub$Sample.Value
> plot(dates1, x1sub)
> dates1 <- as.Date(as.character(dates1), "%Y%m%d")
> str(dates1)
 Date[1:30], format: "2012-01-01" "2012-01-04" "2012-01-07" "2012-01-10" "2012-01-13" "2012-01-16" "2012-01-19" "2012-01-22" ...
> plot(dates1, x1sub)

> ## Plot data for 1999
> dates0 <- pm0sub$Date
> dates0 <- as.Date(as.character(dates0), "%Y%m%d")
> x0sub <- pm0sub$Sample.Value
> plot(dates0, x0sub)

> ## Plot data for both years in same panel
> par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
> plot(dates0, x0sub, pch = 20)
> abline(h = median(x0sub, na.rm = T))
> plot(dates1, x1sub, pch = 20)  ## Whoa! Different ranges
> abline(h = median(x1sub, na.rm = T))

> ## Find global range
> rng <- range(x0sub, x1sub, na.rm = T)
> rng
[1]  3.0 40.1
> par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
> plot(dates0, x0sub, pch = 20, ylim = rng)
> abline(h = median(x0sub, na.rm = T))
> plot(dates1, x1sub, pch = 20, ylim = rng)
> abline(h = median(x1sub, na.rm = T))

> ## Show state-wide means and make a plot showing trend
> head(pm0)
  X..RD Action.Code State.Code County.Code Site.ID Parameter POC Sample.Duration Unit Method     Date Start.Time Sample.Value
1    RD           I          1          27       1     88101   1               7  105    120 19990103      00:00           NA
2    RD           I          1          27       1     88101   1               7  105    120 19990106      00:00           NA
3    RD           I          1          27       1     88101   1               7  105    120 19990109      00:00           NA
4    RD           I          1          27       1     88101   1               7  105    120 19990112      00:00        8.841
5    RD           I          1          27       1     88101   1               7  105    120 19990115      00:00       14.920
6    RD           I          1          27       1     88101   1               7  105    120 19990118      00:00        3.878
  Null.Data.Code Sampling.Frequency Monitor.Protocol..MP..ID Qualifier...1 Qualifier...2 Qualifier...3 Qualifier...4 Qualifier...5
1             AS                  3                       NA          <NA>            NA            NA            NA            NA
2             AS                  3                       NA          <NA>            NA            NA            NA            NA
3             AS                  3                       NA          <NA>            NA            NA            NA            NA
4           <NA>                  3                       NA          <NA>            NA            NA            NA            NA
5           <NA>                  3                       NA          <NA>            NA            NA            NA            NA
6           <NA>                  3                       NA          <NA>            NA            NA            NA            NA
  Qualifier...6 Qualifier...7 Qualifier...8 Qualifier...9 Qualifier...10 Alternate.Method.Detectable.Limit Uncertainty county.site
1            NA            NA            NA            NA             NA                                NA          NA        27.1
2            NA            NA            NA            NA             NA                                NA          NA        27.1
3            NA            NA            NA            NA             NA                                NA          NA        27.1
4            NA            NA            NA            NA             NA                                NA          NA        27.1
5            NA            NA            NA            NA             NA                                NA          NA        27.1
6            NA            NA            NA            NA             NA                                NA          NA        27.1
> mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = T))
> str(mn0)
 num [1:53(1d)] 19.96 6.67 10.8 15.68 17.66 ...
 - attr(*, "dimnames")=List of 1
  ..$ : chr [1:53] "1" "2" "4" "5" ...
> summary(mn0)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  4.862   9.519  12.310  12.410  15.640  19.960 
> mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = T))
> str(mn1)
 num [1:52(1d)] 10.13 4.75 8.61 10.56 9.28 ...
 - attr(*, "dimnames")=List of 1
  ..$ : chr [1:52] "1" "2" "4" "5" ...
> summary(mn1)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  4.006   7.355   8.729   8.759  10.610  11.990 

> ## Make separate data frames for states / years
> d0 <- data.frame(state = names(mn0), mean = mn0)
> d1 <- data.frame(state = names(mn1), mean = mn1)
> mrg <- merge(d0, d1, by = "state")
> dim(mrg)
[1] 52  3
> head(mrg)
  state    mean.x    mean.y
1     1 19.956391 10.126190
2    10 14.492895 11.236059
3    11 15.786507 11.991697
4    12 11.137139  8.239690
5    13 19.943240 11.321364
6    15  4.861821  8.749336
> head(d0)
  state      mean
1     1 19.956391
2     2  6.665929
4     4 10.795547
5     5 15.676067
6     6 17.655412
8     8  7.533304
> head(d1)
  state      mean
1     1 10.126190
2     2  4.750389
4     4  8.609956
5     5 10.563636
6     6  9.277373
8     8  4.117144


> ## Connect lines
> par(mfrow = c(1, 1))
> with(mrg, plot(rep(1, 52), mrg[, 2], xlim = c(.5, 2.5)))
##  rep(1,52) tells the plot routine that the x coordinates for all 52 points are 1. 
## The second argument is the second column of mrg or mrg[,2] which holds the 1999 data. 
> with(mrg, points(rep(2, 52), mrg[, 3]))
> segments(rep(1, 52), mrg[, 2], rep(2, 52), mrg[, 3]) 
## connect the dots.The first 2 are the x and y coordinates of the 1999 points and the last 2 are the x and y coordinates of the 2012 points.
> mrg[mrg$mean.x < mrg$mean.y, ] ## see which states had higher means in 2012 than in 1999.
   state    mean.x    mean.y
6     15  4.861821  8.749336
23    31  9.167770  9.207489
27    35  6.511285  8.089755
33    40 10.657617 10.849870


