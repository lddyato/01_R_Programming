# Instructions

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

## Review criterialess 

For each question

* Does the plot appear to address the question being asked?
* Does the plot appear to address the question being asked?

## Data
The data for this assignment are available from the course web site as a single zip file:

<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>

The zip file contains two files:

PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. 
For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.
```r
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
```
* fips: A five-digit number (represented as a string) indicating the U.S. county
* SCC: The name of the source as indicated by a digit string (see source code classification table)
* Pollutant: A string indicating the pollutant
* Emissions: Amount of PM2.5 emitted, in tons
* type: The type of source (point, non-point, on-road, or non-road)
* year: The year of emissions recorded
* Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the readRDS() function in R. For example, reading in each file can be done with the following code:

```r
install.packages("ggplot2")
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```
as long as each of those files is in your current working directory (check by calling dir() and see if those files are in the listing).

## Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

#Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
Making and Submitting Plotsless 

For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.

```r
if(!file.exists('data4')) dir.create('data4')
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile = './data4/Nei_data.zip')
unzip('./data4/Nei_data.zip', exdir = './data4')

# read data into R
> NEI <- readRDS("summarySCC_PM25.rds")
> SCC <- readRDS("Source_Classification_Code.rds")
> dim(NEI)
[1] 6497651       6
> head(NEI)
    fips      SCC Pollutant Emissions  type year
4  09001 10100401  PM25-PRI    15.714 POINT 1999
8  09001 10100404  PM25-PRI   234.178 POINT 1999
12 09001 10100501  PM25-PRI     0.128 POINT 1999
16 09001 10200401  PM25-PRI     2.036 POINT 1999
20 09001 10200504  PM25-PRI     0.388 POINT 1999
24 09001 10200602  PM25-PRI     1.490 POINT 1999
> str(NEI)
'data.frame':   6497651 obs. of  6 variables:
 $ fips     : chr  "09001" "09001" "09001" "09001" ...
 $ SCC      : chr  "10100401" "10100404" "10100501" "10200401" ...
 $ Pollutant: chr  "PM25-PRI" "PM25-PRI" "PM25-PRI" "PM25-PRI" ...
 $ Emissions: num  15.714 234.178 0.128 2.036 0.388 ...
 $ type     : chr  "POINT" "POINT" "POINT" "POINT" ...
 $ year     : int  1999 1999 1999 1999 1999 1999 1999 1999 1999 1999 ...

# Plot1.png
> total <- aggregate(Emissions ~ year, NEI, sum)
> total
  year Emissions
1 1999   7332967
2 2002   5635780
3 2005   5454703
4 2008   3464206
> png('plot1.png', width = 480, height = 480, units='px')
> barplot(height = (total$Emissions)/1000, names.arg = total$year, xlab="years", ylab=expression('total PM'[2.5]*' emission (kilotons)'),main=expression('Total PM'[2.5]*' emissions from 1999 to 2008'))
> dev.off()
null device 
          1 

# Plot2.png
> subNEI <- subset(NEI, fips == "24510")
> totmaryland <- aggregate(Emissions ~ year, subNEI, sum)

> head(subNEI)
        fips      SCC Pollutant Emissions  type year
114288 24510 10100601  PM25-PRI     6.532 POINT 1999
114296 24510 10200601  PM25-PRI    78.880 POINT 1999
114300 24510 10200602  PM25-PRI     0.920 POINT 1999
114308 24510 30100699  PM25-PRI    10.376 POINT 1999
114325 24510 30183001  PM25-PRI    10.859 POINT 1999
114329 24510 30201599  PM25-PRI    83.025 POINT 1999
> head(totmaryland)
  year Emissions
1 1999  3274.180
2 2002  2453.916
3 2005  3091.354
4 2008  1862.282
> png('plot2.png', width = 480, height = 480, units='px')
> barplot(height = totmaryland$Emissions, names.arg = totmaryland$year, xlab="years", ylab=expression('total PM'[2.5]*' emission in Maryland (Tons)'),main=expression('Total PM'[2.5]*' emissions from 1999 to 2008'))
> dev.off()
null device 
          1 
          
#Plot3.png
> tottype <- aggregate(Emissions ~ year + type, subNEI, sum)
> tottype
   year     type  Emissions
1  1999 NON-ROAD  522.94000
2  2002 NON-ROAD  240.84692
3  2005 NON-ROAD  248.93369
4  2008 NON-ROAD   55.82356
5  1999 NONPOINT 2107.62500
6  2002 NONPOINT 1509.50000
7  2005 NONPOINT 1509.50000
8  2008 NONPOINT 1373.20731
9  1999  ON-ROAD  346.82000
10 2002  ON-ROAD  134.30882
11 2005  ON-ROAD  130.43038
12 2008  ON-ROAD   88.27546
13 1999    POINT  296.79500
14 2002    POINT  569.26000
15 2005    POINT 1202.49000
16 2008    POINT  344.97518
> library(ggplot2)
Warning message:
package ‘ggplot2’ was built under R version 3.2.5 
g <- ggplot(subNEI, aes(year, Emissions, color = type)) + geom_line()
> png('plot3.png')
# > ggplot(tottype, aes(x=factor(year), y=Emissions, fill=type)) + geom_bar(position = "dodge", stat = "identity")
> ggplot(tottype, aes(x=factor(year), y=Emissions, fill=type)) + geom_bar(stat = "identity") + facet_grid(.~type)
> dev.off()

# plot4.png
> str(SCC)
'data.frame':   11717 obs. of  15 variables:
 $ SCC                : Factor w/ 11717 levels "10100101","10100102",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ Data.Category      : Factor w/ 6 levels "Biogenic","Event",..: 6 6 6 6 6 6 6 6 6 6 ...
 $ Short.Name         : Factor w/ 11238 levels "","2,4-D Salts and Esters Prod /Process Vents, 2,4-D Recovery: Filtration",..: 3283 3284 3293 3291 3290 3294 3295 3296 3292 3289 ...
 $ EI.Sector          : Factor w/ 59 levels "Agriculture - Crops & Livestock Dust",..: 18 18 18 18 18 18 18 18 18 18 ...
 $ Option.Group       : Factor w/ 25 levels "","C/I Kerosene",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Option.Set         : Factor w/ 18 levels "","A","B","B1A",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ SCC.Level.One      : Factor w/ 17 levels "Brick Kilns",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ SCC.Level.Two      : Factor w/ 146 levels "","Agricultural Chemicals Production",..: 32 32 32 32 32 32 32 32 32 32 ...
 $ SCC.Level.Three    : Factor w/ 1061 levels "","100% Biosolids (e.g., sewage sludge, manure, mixtures of these matls)",..: 88 88 156 156 156 156 156 156 156 156 ...
 $ SCC.Level.Four     : Factor w/ 6084 levels "","(NH4)2 SO4 Acid Bath System and Evaporator",..: 4455 5583 4466 4458 1341 5246 5584 5983 4461 776 ...
 $ Map.To             : num  NA NA NA NA NA NA NA NA NA NA ...
 $ Last.Inventory.Year: int  NA NA NA NA NA NA NA NA NA NA ...
 $ Created_Date       : Factor w/ 57 levels "","1/27/2000 0:00:00",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Revised_Date       : Factor w/ 44 levels "","1/27/2000 0:00:00",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Usage.Notes        : Factor w/ 21 levels ""," ","includes bleaching towers, washer hoods, filtrate t

> coal<- grep("coal", SCC$EI.Sector, value=TRUE, ignore.case=TRUE)
> head(coal)
[1] "Fuel Comb - Electric Generation - Coal"
[2] "Fuel Comb - Electric Generation - Coal"
[3] "Fuel Comb - Electric Generation - Coal"
[4] "Fuel Comb - Electric Generation - Coal"
[5] "Fuel Comb - Electric Generation - Coal"
[6] "Fuel Comb - Electric Generation - Coal"
> length(coal)
[1] 99
> subSCC <- subset(SCC, EI.Sector %in% coal, select = SCC) 
> head(subSCC)
       SCC
1 10100101
2 10100102
3 10100201
4 10100202
5 10100203
6 10100204
> subNEIcoal <- subset(NEI, SCC %in%  subSCC$SCC)
> head(subNEIcoal)
       fips        SCC Pollutant Emissions     type year
9979  09011   10100217  PM25-PRI   479.907    POINT 1999
15882 23001 2102001000  PM25-PRI     0.054 NONPOINT 1999
15892 23001 2103002000  PM25-PRI     0.231 NONPOINT 1999
17790 23003 2102001000  PM25-PRI     0.032 NONPOINT 1999
17800 23003 2103002000  PM25-PRI     0.194 NONPOINT 1999
19504 23005   10200202  PM25-PRI     0.119    POINT 1999
> totcoal <- aggregate(Emissions ~ year, subNEIcoal, sum)
> totcoal
  year Emissions
1 1999  572126.5
2 2002  546789.2
3 2005  552881.5
4 2008  343432.2
> library(ggplot2)
> png("plot4.png", width = 480, height = 480, units='px')
> ggplot(totcoal, aes(factor(year), Emissions/1000)) + geom_bar(stat = "identity") + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions (Kilotons)")) + ggtitle("Total Emissions from coal from 1999 to 2008")
> dev.off()

#plot5.png
> veh <- grep("vehicle", SCC$EI.Sector, value=TRUE, ignore.case=TRUE)
> head(veh)
[1] "Mobile - On-Road Gasoline Light Duty Vehicles"
[2] "Mobile - On-Road Gasoline Light Duty Vehicles"
[3] "Mobile - On-Road Gasoline Light Duty Vehicles"
[4] "Mobile - On-Road Gasoline Light Duty Vehicles"
[5] "Mobile - On-Road Gasoline Light Duty Vehicles"
[6] "Mobile - On-Road Gasoline Light Duty Vehicles"
> length(veh)
[1] 1138
> SCCveh <- subset(SCC, EI.Sector %in% veh, select = SCC) 
> head(SCCveh)
           SCC
542 2201001000
543 2201001110
544 2201001111
545 2201001112
546 2201001113
547 2201001114
> NEIvehbt <- subset(NEI, SCC %in% SCCveh$SCC & fips == "24510")
> head(NEIvehbt)
        fips        SCC Pollutant Emissions    type year
114470 24510 220100123B  PM25-PRI      7.38 ON-ROAD 1999
114472 24510 220100123T  PM25-PRI      2.78 ON-ROAD 1999
114477 24510 220100123X  PM25-PRI     11.76 ON-ROAD 1999
114479 24510 220100125B  PM25-PRI      3.50 ON-ROAD 1999
114481 24510 220100125T  PM25-PRI      1.32 ON-ROAD 1999
114486 24510 220100125X  PM25-PRI      5.58 ON-ROAD 1999
> dim(NEIvehbt)
[1] 1119    6
> totvehbt <- aggregate(Emissions ~ year, NEIvehbt, sum)
> totvehbt
  year Emissions
1 1999 346.82000
2 2002 134.30882
3 2005 130.43038
4 2008  88.27546

> png("plot5.png", width = 480, height = 480, units='px')
> ggplot(totmotorBT, aes(factor(year), Emissions)) + geom_bar(stat = "identity") + xlab("year") + ylab(expression("Total PM'[2.5]*'Emissions")) + ggtitle("Total Emissions in Baltimore City from Motor from 1999 to 2008")
> dev.off()

#plot6.png
> NEIvehbt <- subset(NEI, SCC %in% SCCveh$SCC & fips == "24510")
> head(NEIvehbt)
        fips        SCC Pollutant Emissions    type year
114470 24510 220100123B  PM25-PRI      7.38 ON-ROAD 1999
114472 24510 220100123T  PM25-PRI      2.78 ON-ROAD 1999
114477 24510 220100123X  PM25-PRI     11.76 ON-ROAD 1999
114479 24510 220100125B  PM25-PRI      3.50 ON-ROAD 1999
114481 24510 220100125T  PM25-PRI      1.32 ON-ROAD 1999
114486 24510 220100125X  PM25-PRI      5.58 ON-ROAD 1999
> dim(NEIvehbt)
[1] 1119    6
> NEIvehla <- subset(NEI, SCC %in% SCCveh$SCC & fips == "06037")
> head(NEIvehla)
         fips        SCC Pollutant Emissions    type year
1541039 06037 2201001110  PM25-PRI      4.93 ON-ROAD 1999
1541043 06037 2201001130  PM25-PRI      8.22 ON-ROAD 1999
1541047 06037 2201001150  PM25-PRI      4.70 ON-ROAD 1999
1541051 06037 2201001170  PM25-PRI      4.62 ON-ROAD 1999
1541055 06037 2201001190  PM25-PRI      1.98 ON-ROAD 1999
1541059 06037 2201001210  PM25-PRI      1.71 ON-ROAD 1999
> dim(NEIvehla)
[1] 980   6
> NEIveh <- rbind(NEIvehbt, NEIvehla)
> head(NEIveh)
        fips        SCC Pollutant Emissions    type year
114470 24510 220100123B  PM25-PRI      7.38 ON-ROAD 1999
114472 24510 220100123T  PM25-PRI      2.78 ON-ROAD 1999
114477 24510 220100123X  PM25-PRI     11.76 ON-ROAD 1999
114479 24510 220100125B  PM25-PRI      3.50 ON-ROAD 1999
114481 24510 220100125T  PM25-PRI      1.32 ON-ROAD 1999
114486 24510 220100125X  PM25-PRI      5.58 ON-ROAD 1999
> dim(NEIveh)
[1] 2099    6
> totveh <- aggregate(Emissions ~ year + fips, NEIveh, sum)
> totveh
  year  fips  Emissions
1 1999 06037 3931.12000
2 2002 06037 4274.03020
3 2005 06037 4601.41493
4 2008 06037 4101.32100
5 1999 24510  346.82000
6 2002 24510  134.30882
7 2005 24510  130.43038
8 2008 24510   88.27546
> totveh$fips[totveh$fips == "06037"] <- "Baltimore, MD"
> totveh$fips[totveh$fips == "24510"] <- "Los Angeles, CA"
> totveh
  year            fips  Emissions
1 1999   Baltimore, MD 3931.12000
2 2002   Baltimore, MD 4274.03020
3 2005   Baltimore, MD 4601.41493
4 2008   Baltimore, MD 4101.32100
5 1999 Los Angeles, CA  346.82000
6 2002 Los Angeles, CA  134.30882
7 2005 Los Angeles, CA  130.43038
8 2008 Los Angeles, CA   88.27546
> png("plot6.png", width = 480, height = 480, units='px')
> ggplot(totveh, aes(x=factor(year), y=Emissions, fill=fips)) + geom_bar(position = "dodge", stat = "identity") + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions (Tons)")) + ggtitle("Total Emissions in Baltimore City from Motor vehicle sources from 1999 to 2008")
> dev.off()
```
