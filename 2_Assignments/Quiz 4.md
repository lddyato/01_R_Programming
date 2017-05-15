# Questions 1. What is produced at the end of this snippet of R code?
```r
set.seed(1)
rpois(5, 2)
```
## Answer: [1] 1 1 2 4 1

A vector with the numbers 1, 1, 2, 4, 1

set.seed(1)
rpois(5, 2)
## [1] 1 1 2 4 1

# Question 2. What R function can be used to generate standard Normal random variables?

## Answer: rnorm
```r
rnorm(10, 0, 1)
##  [1]  1.272429321  0.414641434 -1.539950042 -0.928567035 -0.294720447
##  [6] -0.005767173  2.404653389  0.763593461 -0.799009249 -1.147657009
```
# Question 3

When simulating data, why is using the set.seed() function important? Select all that apply.

It ensures that the sequence of random numbers starts in a specific place and is therefore reproducible.

## Explanation:

Set.seed allows other to get the same psuedorandom sequence to verify results.

set.seed(22)

# Question 4. Which function can be used to evaluate the inverse cumulative distribution function for the Poisson distribution?


## Answer: qpois
See documentation ?qpois

# Question 5. What does the following code do?
```
set.seed(10)
x <- rep(0:1, each = 5)
> x
 [1] 0 0 0 0 0 1 1 1 1 1
e <- rnorm(10, 0, 20)
> e
 [1]   0.3749234  -3.6850508 -27.4266110 -11.9833543   5.8909025   7.7958860 -24.1615235
 [8]  -7.2735203 -32.5334536  -5.1295679
y <- 0.5 + 2 * x + e
```
Generate data from a Normal linear model

# Question 6. What R function can be used to generate Binomial random variables?

## Answer: rbinom

# Question 7. What aspect of the R runtime does the profiler keep track of when an R expression is evaluated?

## Answer: the function call stack

# Question 8. Consider the following R code
```r
library(datasets) 
Rprof() 
fit <- lm(y ~ x1 + x2) 
Rprof(NULL)
```
(Assume that y, x1, and x2 are present in the workspace.) Without running the code, 
what percentage of the run time is spent in the 'lm' function, 
based on the 'by.total' method of normalization shown in 'summaryRprof()'?

## Answer: 100% (when using 'by.total' normalization, the top-level function (in this case, 'lm()') always takes 100% of the time.


# Question 9. When using ‘system.time()’, what is the user time?

## Answer: It is the time spent by the CPU evaluating an expression

# Question 10. If a computer has more than one available processor and R is able to take advantage of that, then which of the following is true when using ‘system.time()’?

## Answer: Elapsed time may be smaller than user time
