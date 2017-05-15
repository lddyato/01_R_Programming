
## Loading and preprocessing the data

```{r}
if(!file.exists("data5")) dir.create("data5")
fileurl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(fileurl, destfile = "./data5/Factivity.zip")
unzip("./data5/Factivity.zip", exdir = "./data5")
activity <- read.csv("./data5/activity.csv")
dim(activity)
activity$date <- as.Date(activity$date, format="%Y-%m-%d")
```

##  What is mean total number of steps taken per day?
```{r}
totalstep <- aggregate(steps ~ date, activity, sum)
binsize <- diff(range(totalstep$steps))/8 
library(ggplot2)
ggplot(totalstep, aes(x=steps)) + geom_histogram(fill="lightgreen", colour = "black", binwidth = binsize) + ylab("The total number of steps")
meanstep <- aggregate(steps ~ date, activity, mean)
medianstep <- aggregate(steps ~ date, activity, median)
print(paste("The MEAN of the total number of steps taken on ", meanstep$date, " is ", round(meanstep$steps, 2)))
print(paste("The MEDIAN of the total number of steps taken on ", meanstep$date, " is ", round(medianstep$steps, 2)))
```
## What is the average daily activity pattern?
```{r}
interstep <- aggregate(steps ~ interval, activity, mean)
ggplot(interstep, aes(x=interval, y=steps)) + geom_line(colour="green") + xlab("5-minute interval") + ylab("The average number of steps")
maxinterval <- interstep[which.max(interstep$steps), ]$interval
```

## Imputing missing values
```{r}
nacount <- sum(is.na(activity))
print(paste("The total number of missing vlaues is", nacount))
nadata <- activity[is.na(activity$steps), ]
nadata$steps <- interstep$steps[match(nadata$interval, interstep$interval)]
newactivity <- rbind(activity[!is.na(activity$steps), ], nadata)
# Histogram of the total number of steps taken each day after missing values are imputed
newtotstep <- aggregate(steps ~ date, newactivity, sum)
binsize <- diff(range(newtotstep$steps))/8  
ggplot(newtotstep, aes(x=steps)) + geom_histogram(fill="lightgreen", colour = "black", binwidth = binsize) + ylab("The total number of steps")
# use new dataset to calculate and report the mean and median number of steps taken each day
newmeanstep <- aggregate(steps ~ date, newactivity, mean)
newmedianstep <- aggregate(steps ~ date, newactivity, median)
print(paste("The MEAN of the total number of steps taken on ", newmeanstep$date, " is ", round(newmeanstep$steps, 2)))
print(paste("The MEDIAN of the total number of steps taken on ", newmedianstep$date, " is ", round(newmedianstep$steps, 2)))
```
## Are there differences in activity patterns between weekdays and weekends?
```{r}
Sys.setlocale(category = "LC_ALL", locale = "english")
newactivity$daytype <- factor((weekdays(newactivity$date) %in% c("Saturday", "Sunday")), labels = c("Weekend", "weekday"))
newinterstep <- aggregate(steps ~ interval + daytype, newactivity, mean)
ggplot(newinterstep, aes(x=interval, y=steps)) + geom_line(aes(color = daytype)) + facet_grid(daytype ~ .) + ylab("Number of steps") + theme(legend.position="none")
```
