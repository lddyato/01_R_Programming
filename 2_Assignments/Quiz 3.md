
# Questions 1
Take a look at the ‘iris’ dataset that comes with R. The data can be loaded with the code:
```r
library(datasets)
data(iris)
```
A description of the dataset can be found by running
```r
?iris
```
There will be an object called ‘iris’ in your workspace. In this dataset, what is the mean of ‘Sepal.Length’ for the species virginica?
(Only enter the numeric result and nothing else.)

## Answer

The which function creates an index for virginica species, the $ operator singles out the Sepal.Length column, then the mean and round function do the rest.
```r
round(mean(iris[which(iris$Species == "virginica"),]$Sepal.Length))
 [1] 7
```

# Question 2

Continuing with the ‘iris’ dataset from the previous Question, what R code returns a vector of the means of the variables ‘Sepal.Length’, ‘Sepal.Width’, ‘Petal.Length’, and ‘Petal.Width’?

## Answer

Using Apply to aggregate column means
```r
> apply(iris[, 1:4], 2, mean)
Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
  5.843333     3.057333     3.758000     1.199333
```
# Question 3

Load the ‘mtcars’ dataset in R with the following code
```r
library(datasets)
data(mtcars)
```
There will be an object names ‘mtcars’ in your workspace. You can find some information about the dataset by running

?iris
How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)? Select all that apply.

# Answer

Different strokes
```r
with(mtcars, tapply(mpg, cyl, mean))
##        4        6        8 
## 26.66364 19.74286 15.10000

tapply(mtcars$mpg, mtcars$cyl, mean)
##        4        6        8 
## 26.66364 19.74286 15.10000

sapply(split(mtcars$mpg, mtcars$cyl), mean)
##        4        6        8 
## 26.66364 19.74286 15.10000
> split(mtcars$mpg, mtcars$cyl)
$`4`
 [1] 22.8 24.4 22.8 32.4 30.4 33.9 21.5 27.3 26.0 30.4 21.4

$`6`
[1] 21.0 21.0 21.4 18.1 19.2 17.8 19.7

$`8`
 [1] 18.7 14.3 16.4 17.3 15.2 10.4 10.4 14.7 15.5 15.2 13.3 19.2 15.8 15.0
```
OR
```r
mtcars %>% group_by(cyl) %>% summarise(meanmpg = mean(mpg))
# A tibble: 3 × 2
     cyl  meanmpg
  <fctr>    <dbl>
1      4 26.66364
2      6 19.74286
3      8 15.10000
```

# Question 4

Continuing with the ‘mtcars’ dataset from the previous Question, what is the absolute difference between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars?

(Please round your final answer to the nearest whole number. Only enter the numeric result and nothing else.)

## Answer

Using the built in looping tapply function to aggregate and then round/abs.
```r
new <- tapply(mtcars$hp, mtcars$cyl, mean)
round(abs(new[3]-new[1]))
   8 
  127

OR
> sub1 <- mtcars %>% group_by(cyl) %>% summarise(meanhp = mean(hp))
> round(sub1[3,2]-sub1[1,2])
  meanhp
1    127
```
# Question 5

If you run
```r
debug(ls)
```
What happens when you next call the ‘ls’ function?

## Answer
Execution of ‘ls’ will suspend at the beginning of the function and you will be in the browser.

Explanation:

Debug walks through each block of code to identify errors and bugs.
