#Exploratory Graphics

**Why do we use graphic in data analysis**

* To understand data properties
* To find partterns in data
* To suggest modeling strategies
* To ‘debug’ analysis
* To communicate results

**Characteristics of exploratory graphics**

* They are made quickly
* A large number are made
* The goal is for personal understanding
* Axes/legends are generally cleaned up
* Colors/size are primarily used for information

```r
download data set form internet
setwd('E:\\Dropbox\\coursera\\Exploratory Data Analysis')
if(!file.exists('data')) dir.create('data')
fileUrl <- 'https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv'
download.file(fileUrl, './data/pollution.csv')
# read data
pollution <- read.csv('./data/pollution.csv', header = TRUE)
head(pollution)
```

**Simple Summary of Data**

* One dimension
 + Five-number summary (Min, 1st Qu., Median, 3rd Qu., Max)
 + Boxplot
 + Histograms
 + Density plot
 + Barplot
```r
# Five number summary
summary(pollution$pm25)
# Boxplot
boxplot(pollution$pm25, col = 'blue')
# Histograms
hist(pollution$pm25, col = 'green')
rug(pollution$pm25)
hist(pollution$pm25, col = 'green', breaks = 100)
rug(pollution$pm25) #how many data points are in each bucket and where they lie within the buket
# Overlayng features
boxplot(pollution$pm25, col = 'blue')
abline(h = 12)
hist(pollution$pm25, col = 'green')
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = 'red')
# Barplot
barplot(table(pollution$region), col = 'wheat', main = 'NO. of counties in each region')
```

* Two dimesions
 + Multiple/overlayed 1-D plots(Lattice/ggplot2)
 + Scatterplot
 + Smooth scatter plot
```r
# Multiple boxplot
boxplot(pm25 ~ region, data = pollution, col = 'red')
# multiple histograms
par(mfrow = c(2,1), mar = c(4, 4, 2, 1)) # 2 rows and 1 column
hist(subset(pollution, region == 'east')$pm25, col = 'green')
hist(subset(pollution, region == 'west')$pm25, col = 'green')
# Scatter plot
par(mfrow = c(1,1))
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)
# scatter plot using color
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)
# multiple scatterplots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == 'east'), plot(latitude, pm25), main= 'East')
with(subset(pollution, region == 'west'), plot(latitude, pm25), main = 'West')
```
* More than two dimensions
 + Ovelayed/multiple 2-D plots,coplots
 + Use color, size, shape to add dimesions
 + Spinning plots
 + Actual 3-D plots(not that useful)

**Summary**

* Exploratory plots are ‘quick and dirty’
* Let you summarize the data(usually graphically) and highly any broad features
* Explore basic questions and hypotheses(and perhaps rule them out)
* Suggest modeling strategies for the ‘next step’

**Further resources**
* R Graph Gallery
* R Bloggers
