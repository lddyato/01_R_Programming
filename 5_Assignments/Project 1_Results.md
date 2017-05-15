```r
> # Loading and preprocessing the data
> if(!file.exists("data5")) dir.create("data5")
> fileurl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
> download.file(fileurl, destfile = "./data5/Factivity.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip'
Content type 'application/zip' length 53559 bytes (52 KB)
downloaded 52 KB

> unzip("./data5/Factivity.zip", exdir = "./data5")
> activity <- read.csv("./data5/activity.csv")
> dim(activity)
[1] 17568     3
> head(activity)
  steps       date interval
1    NA 2012-10-01        0
2    NA 2012-10-01        5
3    NA 2012-10-01       10
4    NA 2012-10-01       15
5    NA 2012-10-01       20
6    NA 2012-10-01       25
> View(activity)
> activity$date <- as.Date(activity$date, format="%Y-%m-%d")
> 
> # What is mean total number of steps taken per day?
> totalstep <- aggregate(steps ~ date, activity, sum)
> head(totalstep)
        date steps
1 2012-10-02   126
2 2012-10-03 11352
3 2012-10-04 12116
4 2012-10-05 13294
5 2012-10-06 15420
6 2012-10-07 11015
> totalstep01 <- tapply(activity$steps, activity$date, sum, na.rm = T)
> head(totalstep01)
2012-10-01 2012-10-02 2012-10-03 2012-10-04 2012-10-05 2012-10-06 
         0        126      11352      12116      13294      15420 
> binsize <- diff(range(totalstep$steps))/4 
> library(ggplot2)
> ggplot(totalstep, aes(x=steps)) + geom_histogram(fill="lightgreen", colour = "black", binwidth = binsize) + ylab("The total number of steps")
> hist(totalstep$steps, xlab = "sum", main = "steps per day")
> 
> meanstep <- aggregate(steps ~ date, activity, mean)
> head(meanstep)
        date    steps
1 2012-10-02  0.43750
2 2012-10-03 39.41667
3 2012-10-04 42.06944
4 2012-10-05 46.15972
5 2012-10-06 53.54167
6 2012-10-07 38.24653
> medianstep <- aggregate(steps ~ date, activity, median)
> head(medianstep)
        date steps
1 2012-10-02     0
2 2012-10-03     0
3 2012-10-04     0
4 2012-10-05     0
5 2012-10-06     0
6 2012-10-07     0
> meanstep01<- mean(totalstep$steps)
> meanstep01
[1] 10766.19
> medianstep01<- median(totalstep$steps)
> medianstep01
[1] 10765
> print(paste("The MEAN of the total number of steps taken on ", meanstep$date, " is ", round(meanstep$steps, 2)))
 [1] "The MEAN of the total number of steps taken on  2012-10-02  is  0.44" 
 [2] "The MEAN of the total number of steps taken on  2012-10-03  is  39.42"
 [3] "The MEAN of the total number of steps taken on  2012-10-04  is  42.07"
 [4] "The MEAN of the total number of steps taken on  2012-10-05  is  46.16"
 [5] "The MEAN of the total number of steps taken on  2012-10-06  is  53.54"
 [6] "The MEAN of the total number of steps taken on  2012-10-07  is  38.25"
 [7] "The MEAN of the total number of steps taken on  2012-10-09  is  44.48"
 [8] "The MEAN of the total number of steps taken on  2012-10-10  is  34.38"
 [9] "The MEAN of the total number of steps taken on  2012-10-11  is  35.78"
[10] "The MEAN of the total number of steps taken on  2012-10-12  is  60.35"
[11] "The MEAN of the total number of steps taken on  2012-10-13  is  43.15"
[12] "The MEAN of the total number of steps taken on  2012-10-14  is  52.42"
[13] "The MEAN of the total number of steps taken on  2012-10-15  is  35.2" 
[14] "The MEAN of the total number of steps taken on  2012-10-16  is  52.38"
[15] "The MEAN of the total number of steps taken on  2012-10-17  is  46.71"
[16] "The MEAN of the total number of steps taken on  2012-10-18  is  34.92"
[17] "The MEAN of the total number of steps taken on  2012-10-19  is  41.07"
[18] "The MEAN of the total number of steps taken on  2012-10-20  is  36.09"
[19] "The MEAN of the total number of steps taken on  2012-10-21  is  30.63"
[20] "The MEAN of the total number of steps taken on  2012-10-22  is  46.74"
[21] "The MEAN of the total number of steps taken on  2012-10-23  is  30.97"
[22] "The MEAN of the total number of steps taken on  2012-10-24  is  29.01"
[23] "The MEAN of the total number of steps taken on  2012-10-25  is  8.65" 
[24] "The MEAN of the total number of steps taken on  2012-10-26  is  23.53"
[25] "The MEAN of the total number of steps taken on  2012-10-27  is  35.14"
[26] "The MEAN of the total number of steps taken on  2012-10-28  is  39.78"
[27] "The MEAN of the total number of steps taken on  2012-10-29  is  17.42"
[28] "The MEAN of the total number of steps taken on  2012-10-30  is  34.09"
[29] "The MEAN of the total number of steps taken on  2012-10-31  is  53.52"
[30] "The MEAN of the total number of steps taken on  2012-11-02  is  36.81"
[31] "The MEAN of the total number of steps taken on  2012-11-03  is  36.7" 
[32] "The MEAN of the total number of steps taken on  2012-11-05  is  36.25"
[33] "The MEAN of the total number of steps taken on  2012-11-06  is  28.94"
[34] "The MEAN of the total number of steps taken on  2012-11-07  is  44.73"
[35] "The MEAN of the total number of steps taken on  2012-11-08  is  11.18"
[36] "The MEAN of the total number of steps taken on  2012-11-11  is  43.78"
[37] "The MEAN of the total number of steps taken on  2012-11-12  is  37.38"
[38] "The MEAN of the total number of steps taken on  2012-11-13  is  25.47"
[39] "The MEAN of the total number of steps taken on  2012-11-15  is  0.14" 
[40] "The MEAN of the total number of steps taken on  2012-11-16  is  18.89"
[41] "The MEAN of the total number of steps taken on  2012-11-17  is  49.79"
[42] "The MEAN of the total number of steps taken on  2012-11-18  is  52.47"
[43] "The MEAN of the total number of steps taken on  2012-11-19  is  30.7" 
[44] "The MEAN of the total number of steps taken on  2012-11-20  is  15.53"
[45] "The MEAN of the total number of steps taken on  2012-11-21  is  44.4" 
[46] "The MEAN of the total number of steps taken on  2012-11-22  is  70.93"
[47] "The MEAN of the total number of steps taken on  2012-11-23  is  73.59"
[48] "The MEAN of the total number of steps taken on  2012-11-24  is  50.27"
[49] "The MEAN of the total number of steps taken on  2012-11-25  is  41.09"
[50] "The MEAN of the total number of steps taken on  2012-11-26  is  38.76"
[51] "The MEAN of the total number of steps taken on  2012-11-27  is  47.38"
[52] "The MEAN of the total number of steps taken on  2012-11-28  is  35.36"
[53] "The MEAN of the total number of steps taken on  2012-11-29  is  24.47"
> print(paste("The MEDIAN of the total number of steps taken on ", meanstep$date, " is ", round(medianstep$steps, 2)))
 [1] "The MEDIAN of the total number of steps taken on  2012-10-02  is  0"
 [2] "The MEDIAN of the total number of steps taken on  2012-10-03  is  0"
 [3] "The MEDIAN of the total number of steps taken on  2012-10-04  is  0"
 [4] "The MEDIAN of the total number of steps taken on  2012-10-05  is  0"
 [5] "The MEDIAN of the total number of steps taken on  2012-10-06  is  0"
 [6] "The MEDIAN of the total number of steps taken on  2012-10-07  is  0"
 [7] "The MEDIAN of the total number of steps taken on  2012-10-09  is  0"
 [8] "The MEDIAN of the total number of steps taken on  2012-10-10  is  0"
 [9] "The MEDIAN of the total number of steps taken on  2012-10-11  is  0"
[10] "The MEDIAN of the total number of steps taken on  2012-10-12  is  0"
[11] "The MEDIAN of the total number of steps taken on  2012-10-13  is  0"
[12] "The MEDIAN of the total number of steps taken on  2012-10-14  is  0"
[13] "The MEDIAN of the total number of steps taken on  2012-10-15  is  0"
[14] "The MEDIAN of the total number of steps taken on  2012-10-16  is  0"
[15] "The MEDIAN of the total number of steps taken on  2012-10-17  is  0"
[16] "The MEDIAN of the total number of steps taken on  2012-10-18  is  0"
[17] "The MEDIAN of the total number of steps taken on  2012-10-19  is  0"
[18] "The MEDIAN of the total number of steps taken on  2012-10-20  is  0"
[19] "The MEDIAN of the total number of steps taken on  2012-10-21  is  0"
[20] "The MEDIAN of the total number of steps taken on  2012-10-22  is  0"
[21] "The MEDIAN of the total number of steps taken on  2012-10-23  is  0"
[22] "The MEDIAN of the total number of steps taken on  2012-10-24  is  0"
[23] "The MEDIAN of the total number of steps taken on  2012-10-25  is  0"
[24] "The MEDIAN of the total number of steps taken on  2012-10-26  is  0"
[25] "The MEDIAN of the total number of steps taken on  2012-10-27  is  0"
[26] "The MEDIAN of the total number of steps taken on  2012-10-28  is  0"
[27] "The MEDIAN of the total number of steps taken on  2012-10-29  is  0"
[28] "The MEDIAN of the total number of steps taken on  2012-10-30  is  0"
[29] "The MEDIAN of the total number of steps taken on  2012-10-31  is  0"
[30] "The MEDIAN of the total number of steps taken on  2012-11-02  is  0"
[31] "The MEDIAN of the total number of steps taken on  2012-11-03  is  0"
[32] "The MEDIAN of the total number of steps taken on  2012-11-05  is  0"
[33] "The MEDIAN of the total number of steps taken on  2012-11-06  is  0"
[34] "The MEDIAN of the total number of steps taken on  2012-11-07  is  0"
[35] "The MEDIAN of the total number of steps taken on  2012-11-08  is  0"
[36] "The MEDIAN of the total number of steps taken on  2012-11-11  is  0"
[37] "The MEDIAN of the total number of steps taken on  2012-11-12  is  0"
[38] "The MEDIAN of the total number of steps taken on  2012-11-13  is  0"
[39] "The MEDIAN of the total number of steps taken on  2012-11-15  is  0"
[40] "The MEDIAN of the total number of steps taken on  2012-11-16  is  0"
[41] "The MEDIAN of the total number of steps taken on  2012-11-17  is  0"
[42] "The MEDIAN of the total number of steps taken on  2012-11-18  is  0"
[43] "The MEDIAN of the total number of steps taken on  2012-11-19  is  0"
[44] "The MEDIAN of the total number of steps taken on  2012-11-20  is  0"
[45] "The MEDIAN of the total number of steps taken on  2012-11-21  is  0"
[46] "The MEDIAN of the total number of steps taken on  2012-11-22  is  0"
[47] "The MEDIAN of the total number of steps taken on  2012-11-23  is  0"
[48] "The MEDIAN of the total number of steps taken on  2012-11-24  is  0"
[49] "The MEDIAN of the total number of steps taken on  2012-11-25  is  0"
[50] "The MEDIAN of the total number of steps taken on  2012-11-26  is  0"
[51] "The MEDIAN of the total number of steps taken on  2012-11-27  is  0"
[52] "The MEDIAN of the total number of steps taken on  2012-11-28  is  0"
[53] "The MEDIAN of the total number of steps taken on  2012-11-29  is  0"
> print(paste("The MEAN of the total number of steps taken is", round(meanstep01, 2)))
[1] "The MEAN of the total number of steps taken is 10766.19"
> print(paste("The MEDIAN of the total number of steps taken is", round(medianstep01, 2)))
[1] "The MEDIAN of the total number of steps taken is 10765"
> 
> # What is the average daily activity pattern?
> interstep <- aggregate(steps ~ interval, activity, mean)
> head(interstep)
  interval     steps
1        0 1.7169811
2        5 0.3396226
3       10 0.1320755
4       15 0.1509434
5       20 0.0754717
6       25 2.0943396
> ggplot(interstep, aes(x=interval, y=steps)) + geom_line(colour="green") + xlab("5-minute interval") + ylab("The average number of steps")
> interstep01 <- tapply(activity$steps, activity$interval, mean, na.rm=T)
> head(interstep01)
        0         5        10        15        20        25 
1.7169811 0.3396226 0.1320755 0.1509434 0.0754717 2.0943396 
> 
> 
> interstep[which.max(interstep$steps), ]
    interval    steps
104      835 206.1698
> maxinterval <- interstep[which.max(interstep$steps), ]$interval
> interstep01[which.max(interstep01)]
     835 
206.1698 
> maxinterval
[1] 835
> 
> # Imputing missing values
> nacount01 <- table(is.na(activity))
> nacount01

FALSE  TRUE 
50400  2304 
> nacount <- sum(is.na(activity))
> nacount
[1] 2304
> print(paste("The total number of missing vlaues is", nacount))
[1] "The total number of missing vlaues is 2304"
> 
> nadata <- activity[is.na(activity$steps), ]
> nadata$steps <- interstep$steps[match(nadata$interval, interstep$interval)]
> head(nadata)
      steps       date interval
1 1.7169811 2012-10-01        0
2 0.3396226 2012-10-01        5
3 0.1320755 2012-10-01       10
4 0.1509434 2012-10-01       15
5 0.0754717 2012-10-01       20
6 2.0943396 2012-10-01       25
> newactivity <- rbind(activity[!is.na(activity$steps), ], nadata)
> head(newactivity)
    steps       date interval
289     0 2012-10-02        0
290     0 2012-10-02        5
291     0 2012-10-02       10
292     0 2012-10-02       15
293     0 2012-10-02       20
294     0 2012-10-02       25
> 
> newtotstep <- aggregate(steps ~ date, newactivity, sum)
> head(newtotstep)
        date    steps
1 2012-10-01 10766.19
2 2012-10-02   126.00
3 2012-10-03 11352.00
4 2012-10-04 12116.00
5 2012-10-05 13294.00
6 2012-10-06 15420.00
> binsize <- diff(range(newtotstep$steps))/8  
> ggplot(newtotstep, aes(x=steps)) + geom_histogram(fill="lightgreen", colour = "black", binwidth = binsize) + ylab("The total number of steps")
> 
> # use new dataset to calculate and report the mean and median number of steps taken each day
> newmeanstep <- aggregate(steps ~ date, newactivity, mean)
> head(newmeanstep)
        date    steps
1 2012-10-01 37.38260
2 2012-10-02  0.43750
3 2012-10-03 39.41667
4 2012-10-04 42.06944
5 2012-10-05 46.15972
6 2012-10-06 53.54167
> newmedianstep <- aggregate(steps ~ date, newactivity, median)
> head(newmedianstep)
        date    steps
1 2012-10-01 34.11321
2 2012-10-02  0.00000
3 2012-10-03  0.00000
4 2012-10-04  0.00000
5 2012-10-05  0.00000
6 2012-10-06  0.00000
> newmeanstep01 <- mean(newtotstep$steps)
> newmeanstep01
[1] 10766.19
> newmedianstep01 <- median(newtotstep$steps)
> newmedianstep01
[1] 10766.19
> newold <- rbind(data.frame(mean = c(meanstep01, newmeanstep01), median = c(medianstep01, newmedianstep01)))
> rownames(newold) <- c("with NA's", "without NA's")
> print(newold)
                 mean   median
with NA's    10766.19 10765.00
without NA's 10766.19 10766.19
> 
> # Are there differences in activity patterns between weekdays and weekends?
> Sys.setlocale(category = "LC_ALL", locale = "english")
[1] "LC_COLLATE=English_United States.1252;LC_CTYPE=English_United States.1252;LC_MONETARY=English_United States.1252;LC_NUMERIC=C;LC_TIME=English_United States.1252"
> newactivity$daytype <- factor((weekdays(newactivity$date) %in% c("Saturday", "Sunday")), labels = c("Weekend", "weekday"))
> head(newactivity)
    steps       date interval daytype
289     0 2012-10-02        0 Weekend
290     0 2012-10-02        5 Weekend
291     0 2012-10-02       10 Weekend
292     0 2012-10-02       15 Weekend
293     0 2012-10-02       20 Weekend
294     0 2012-10-02       25 Weekend
> 
> newinterstep <- aggregate(steps ~ interval + daytype, newactivity, mean)
> head(newinterstep)
  interval daytype      steps
1        0 Weekend 2.25115304
2        5 Weekend 0.44528302
3       10 Weekend 0.17316562
4       15 Weekend 0.19790356
5       20 Weekend 0.09895178
6       25 Weekend 1.59035639
> ggplot(newinterstep, aes(x=interval, y=steps)) + geom_line(aes(color = daytype)) + facet_grid(daytype ~ .) + ylab("Number of steps") + theme(legend.position="none")
```
