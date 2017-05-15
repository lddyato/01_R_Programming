# Question 1
R was developed by statisticians working at
## Answer
```
The University of Auckland
```
-----------------------------
# Question 2
The definition of free software consists of four freedoms (freedoms 0 through 3). Which of the following is NOT one of the freedoms that are part of the definition?
## Answer
```
The freedom to improve the program, and release your improvements to the public, 
so that the whole community benefits.
```
-------------------------
# Question 3
In R the following are all atomic data types EXCEPT
## Answer
```
matrix
```
----------------------
# Question 4
If I execute the expression x <- 4 in R, what is the class of the object 'x' as determined by the 'class()' function?
## Answer
```
numeric
```
----------------------
# Question 5
What is the class of the object defined by the expression x <- c(4, "a", TRUE)?
## Answer
```
character
```
## Explanation
```
> x <- c(4, "a", TRUE)
> class(x)
[1] "character"
```
------------------
# Question 6
If I have two vectors x <- c(1,3, 5) and y <- c(3, 2, 10), what is produced by the expression cbind(x, y)?
## Answer
```
 a numeric matrix with 3 rows and 2 columns
```
## Explanation
```
> x <- c(1,3, 5)
> y <- c(3, 2, 10)
> cbind(x,y)
     x  y
[1,] 1  3
[2,] 3  2
[3,] 5 10
```
-----------------------
# Question 7
A key property of vectors in R is that
## Answer
```
elements of a vector all must be of the same class
```
------------------------------
# Question 8
Suppose I have a list defined as x <- list(2, "a", "b", TRUE). What does x[[1]] give me?
## Answer
```
a numeric vector containing the element 2.
```
------------------------
# Question 9
Suppose I have a vector x <- 1:4 and y <- 2:3. What is produced by the expression x + y?
## Answer
```
an integer vector with the values 3, 5, 5, 7.
```
## Explanation
```
> x <- 1:4
> y <- 2:3
> x+y
[1] 3 5 5 7
```
--------------------
# Question 10
Suppose I have a vector x <- c(17, 14, 4, 5, 13, 12, 10) and I want to set all elements of this vector that are greater than 10 to be equal to 4. What R code achieves this?
## Answer
```
x[x == 10] <- 4
```
----------------
# Question 11
In the dataset provided for this Quiz, what are the column names of the dataset?
1, 2, 3, 4, 5, 6
## Answer
Ozone, Solar.R, Wind, Temp, Month, Day
## Explanation
```r
quiz1 <- download.file('https://d396qusza40orc.cloudfront.net/rprog/data/quiz1_data.zip', destfile ="quiz1data.zip")
zipquiz1 <- unzip("quiz1data.zip")
data1 <- read.csv("hw1_data.csv")
names(data1)
[1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"  
```
-------------------------------
# Question 12
Extract the first 2 rows of the data frame and print them to the console. What does the output look like?

## Answer
```r
  Ozone Solar.R Wind Temp Month Day
1    41   190   7.4   67     5   1
2    36   118   8.0   72     5   2
```
## Explanation
```r
> head(data,2)
Ozone Solar.R Wind Temp Month Day
1 41 190 7.4 67 5 1
2 36 118 8.0 72 5 2
```
------------------------------------
# Question 13
How many observations (i.e. rows) are in this data frame?
## Answer
```r
153
```
## Explanation
```r
> nrow(data)
[1] 153
```
------------------------------
# Question 14
Extract the last 2 rows of the data frame and print them to the console. What does the output look like?
## Answer
```r
Ozone Solar.R Wind Temp Month Day
152    18     131  8.0   76     9  29
153    20     223 11.5   68     9  30
```
## Explanation
```r
> tail(data,2)
Ozone Solar.R Wind Temp Month Day
152 18 131 8.0 76 9 29
153 20 223 11.5 68 9 30
```
-------------------------
# Question 15
What is the value of Ozone in the 47th row?
## Answer
```r
21
```
## Explanation
```
> data[47,]
     Ozone Solar.R Wind Temp Month Day
47    21     191 14.9   77     6  16
```
-------------------------------------
# Question 16
How many missing values are in the Ozone column of this data frame?
## Answer
```
37
```
## Explanation
```r
#Calculate how many missing data
> length(which(is.na(data))) 
[1] 44
#Calculate how many missing date with column name of Ozone
> datana<-subset(data,is.na(Ozone))
> nrow(datana)
[1] 37

# OR

> sum(is.na(data1))
[1] 44
> sum(is.na(data1$Ozone))
[1] 37
```
-------------------------------
# Question 17
What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.
## Answer
```r
42.1
```
## Explanation
```r
> datanotna<-subset(data,!is.na(Ozone))
> apply(datanotna,2,mean)
    Ozone   Solar.R      Wind      Temp     Month       Day 
42.129310        NA  9.862069 77.870690  7.198276 15.534483 
```
OR
```r
> mean(data1$Ozone, na.rm=T)
# [1] 42.12931
```
-----------------------------
# Question 18
Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
## Answer
```r
212.8
```
## Explanation
```r
> datasub18<-subset(data,data$Ozone>31 & data$Temp>90,select=Solar.R)
> apply(datasub18,2,mean)
Solar.R 
  212.8 
```
or
```r
> subdata <- subset(data1,Ozone > 31 & Temp > 90)
> head(subdata)
    Ozone Solar.R Wind Temp Month Day
69     97     267  6.3   92     7   8
70     97     272  5.7   92     7   9
120    76     203  9.7   97     8  28
121   118     225  2.3   94     8  29
122    84     237  6.3   96     8  30
123    85     188  6.3   94     8  31
> mean(subdata$Solar.R,na.rm = T)
[1] 212.8
```
OR
```r
> mean(data1[which(data1$Ozone >31 & data1$Temp > 90),]$Solar.R)
[1] 212.8
```
----------------------------------
# Question 19
What is the mean of "Temp" when "Month" is equal to 6?
## Answer
```
79.1
```
## Explanation
```r
> datasub19<-subset(data,data$Month==6,select=Temp)
> apply(datasub19,2,mean)
Temp 
79.1 

#or
> sub1 <- subset(data1, Month == 6) # 如果不加select=，则默认是选择所有变量
> head(sub1)
   Ozone Solar.R Wind Temp Month Day
32    NA     286  8.6   78     6   1
33    NA     287  9.7   74     6   2
34    NA     242 16.1   67     6   3
35    NA     186  9.2   84     6   4
36    NA     220  8.6   85     6   5
37    NA     264 14.3   79     6   6
> mean(sub1$Temp,na.rm=T)
[1] 79.1

# oR
> mean(data1[which(data1$Month == 6),]$Temp)
[1] 79.1
```
-----------------------------
# Question 20
What was the maximum ozone value in the month of May (i.e. Month = 5)?
## Answer
```r
115
```
## Explanation
```r
> datasub20<-subset(data,!is.na(Ozone)&data$Month==5,select=Ozone)
> apply(datasub20,2,max)
Ozone 
  115

# OR
> sub1 <- subset(data1, Month == 5)
> max(sub1$Ozone,na.rm=T)
[1] 115

# OR
> max(data1[which(data1$Month == 5),]$Ozone, na.rm = TRUE)
[1] 115
```

