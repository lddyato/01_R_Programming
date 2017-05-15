# Reproducible Research
# Steps in a data analysis
* Define the question
* Define the ideal data set
* Determine what data you can access
* Obtain the data
* Clean the data
* Exploratory data analysis
* Statistical prediction/modeling
* Interpret results
* Challenge results
* Synthesize/write up results
* Create reproducible code

## step 1: Defining a question
* Statistical methods development
* Danger Zone!!!
* Proper data analysis
 
### Our Example
* Start with a general question   
Can I automatically detect emails that are SPAM that are not?
* Make it concrete   
Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?

## step 2: Define the ideal data set
* The data set may depend on your goal
 + Descriptive - a whole population
 + Exploratory - a random sample with many variables measured
 + Inferential - the right population, randomly sampled
 + Predictive - a training and test data set from the same population
 + Causal - data from a randomized study
 + Mechanistic - data about all components of the system
<http://www.google.com/about/datacenters/inside/>

## step 3: Determine what data you can access
* Sometimes you can find data free on the web
* Other times you may need to buy the data
* Be sure to respect the terms of use
* If the data don't exist, you may need to generate it yourself

## step 4: Obtain the data
* Try to obtain the raw data
* Be sure to reference the source
* Polite emails go a long way
* If you will load the data from an internet source, record the url and time accessed
* our data set <http://search.r-project.org/library/kernlab/html/spam.html>

## step 5: Clean the data
* Raw data often needs to be processed
* If it is pre-processed, make sure you understand how
* Understand the source of the data (census, sample, convenience sample, etc.)
* May need reformating, subsampling - record these steps
* **Determine if the data are good enough** - if not, quit or change data

### Our cleaned data set
```r
# If it isn't installed, install the kernlab package with install.packages()
install.packages("kernlab")
library(kernlab)
data(spam)
str(spam[, 1:5])
> dim(spam)
[1] 4601   58
> str(spam[,1:5])
'data.frame':   4601 obs. of  5 variables:
 $ make   : num  0 0.21 0.06 0 0 0 0 0 0.15 0.06 ...
 $ address: num  0.64 0.28 0 0 0 0 0 0 0 0.12 ...
 $ all    : num  0.64 0.5 0.71 0 0 0 0 0 0.46 0.77 ...
 $ num3d  : num  0 0 0 0 0 0 0 0 0 0 ...
 $ our    : num  0.32 0.14 1.23 0.63 0.63 1.85 1.92 1.88 0.61 0.19 ...
> str(spam)
'data.frame':   4601 obs. of  58 variables:
 $ make             : num  0 0.21 0.06 0 0 0 0 0 0.15 0.06 ...
 $ address          : num  0.64 0.28 0 0 0 0 0 0 0 0.12 ...
 $ all              : num  0.64 0.5 0.71 0 0 0 0 0 0.46 0.77 ...
 $ num3d            : num  0 0 0 0 0 0 0 0 0 0 ...
 $ our              : num  0.32 0.14 1.23 0.63 0.63 1.85 1.92 1.88 0.61 0.19 ...
 $ over             : num  0 0.28 0.19 0 0 0 0 0 0 0.32 ...
 $ remove           : num  0 0.21 0.19 0.31 0.31 0 0 0 0.3 0.38 ...
 $ internet         : num  0 0.07 0.12 0.63 0.63 1.85 0 1.88 0 0 ...
 $ order            : num  0 0 0.64 0.31 0.31 0 0 0 0.92 0.06 ...
 $ mail             : num  0 0.94 0.25 0.63 0.63 0 0.64 0 0.76 0 ...
 $ receive          : num  0 0.21 0.38 0.31 0.31 0 0.96 0 0.76 0 ...
 $ will             : num  0.64 0.79 0.45 0.31 0.31 0 1.28 0 0.92 0.64 ...
 $ people           : num  0 0.65 0.12 0.31 0.31 0 0 0 0 0.25 ...
 $ report           : num  0 0.21 0 0 0 0 0 0 0 0 ...
 $ addresses        : num  0 0.14 1.75 0 0 0 0 0 0 0.12 ...
 $ free             : num  0.32 0.14 0.06 0.31 0.31 0 0.96 0 0 0 ...
 $ business         : num  0 0.07 0.06 0 0 0 0 0 0 0 ...
 $ email            : num  1.29 0.28 1.03 0 0 0 0.32 0 0.15 0.12 ...
 $ you              : num  1.93 3.47 1.36 3.18 3.18 0 3.85 0 1.23 1.67 ...
 $ credit           : num  0 0 0.32 0 0 0 0 0 3.53 0.06 ...
 $ your             : num  0.96 1.59 0.51 0.31 0.31 0 0.64 0 2 0.71 ...
 $ font             : num  0 0 0 0 0 0 0 0 0 0 ...
 $ num000           : num  0 0.43 1.16 0 0 0 0 0 0 0.19 ...
 $ money            : num  0 0.43 0.06 0 0 0 0 0 0.15 0 ...
 $ hp               : num  0 0 0 0 0 0 0 0 0 0 ...
 $ hpl              : num  0 0 0 0 0 0 0 0 0 0 ...
 $ george           : num  0 0 0 0 0 0 0 0 0 0 ...
 $ num650           : num  0 0 0 0 0 0 0 0 0 0 ...
 $ lab              : num  0 0 0 0 0 0 0 0 0 0 ...
 $ labs             : num  0 0 0 0 0 0 0 0 0 0 ...
 $ telnet           : num  0 0 0 0 0 0 0 0 0 0 ...
 $ num857           : num  0 0 0 0 0 0 0 0 0 0 ...
 $ data             : num  0 0 0 0 0 0 0 0 0.15 0 ...
 $ num415           : num  0 0 0 0 0 0 0 0 0 0 ...
 $ num85            : num  0 0 0 0 0 0 0 0 0 0 ...
 $ technology       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ num1999          : num  0 0.07 0 0 0 0 0 0 0 0 ...
 $ parts            : num  0 0 0 0 0 0 0 0 0 0 ...
 $ pm               : num  0 0 0 0 0 0 0 0 0 0 ...
 $ direct           : num  0 0 0.06 0 0 0 0 0 0 0 ...
 $ cs               : num  0 0 0 0 0 0 0 0 0 0 ...
 $ meeting          : num  0 0 0 0 0 0 0 0 0 0 ...
 $ original         : num  0 0 0.12 0 0 0 0 0 0.3 0 ...
 $ project          : num  0 0 0 0 0 0 0 0 0 0.06 ...
 $ re               : num  0 0 0.06 0 0 0 0 0 0 0 ...
 $ edu              : num  0 0 0.06 0 0 0 0 0 0 0 ...
 $ table            : num  0 0 0 0 0 0 0 0 0 0 ...
 $ conference       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ charSemicolon    : num  0 0 0.01 0 0 0 0 0 0 0.04 ...
 $ charRoundbracket : num  0 0.132 0.143 0.137 0.135 0.223 0.054 0.206 0.271 0.03 ...
 $ charSquarebracket: num  0 0 0 0 0 0 0 0 0 0 ...
 $ charExclamation  : num  0.778 0.372 0.276 0.137 0.135 0 0.164 0 0.181 0.244 ...
 $ charDollar       : num  0 0.18 0.184 0 0 0 0.054 0 0.203 0.081 ...
 $ charHash         : num  0 0.048 0.01 0 0 0 0 0 0.022 0 ...
 $ capitalAve       : num  3.76 5.11 9.82 3.54 3.54 ...
 $ capitalLong      : num  61 101 485 40 40 15 4 11 445 43 ...
 $ capitalTotal     : num  278 1028 2259 191 191 ...
 $ type             : Factor w/ 2 levels "nonspam","spam": 2 2 2 2 2 2 2 2 2 2 ...

## subsampling our data set
# Perform the subsampling
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)
## trainIndicator
##    0    1 
## 2314 2287 
trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]
names(trainSpam)
table(trainSpam$type)
# nonspam    spam 
#    1381     906 
```

## step 6: Exploratory data analysis
* Look at summaries of the data
* Check for missing data
* Create exploratory plots
* Perform exploratory analyses (e.g. clustering)
```r
plot(trainSpam$capitalAve ~ trainSpam$type)
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)
plot(log10(trainSpam[, 1:4] + 1))
# Clustering
hCluster = hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)
# New Clustering
hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)
```
## step 7: Statistical prediction/modeling
* Should be informed by the results of your exploratory analysis
* Exact methods depend on the question of interest
* Transformations/processing should be accounted for when necessary
* Measures of uncertainty should be reported

```r
trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for (i in 1:55) {
lmFormula = reformulate(names(trainSpam)[i], response = "numType")
glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}
## Which predictor has minimum cross-validated error?
names(trainSpam)[which.min(cvError)]
## [1] "charDollar"

## Get a measure of uncertainty
## Use the best model from the group
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)
## Get predictions on the test set
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonspam", dim(testSpam)[1])
## Classify as `spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"

## Classification table
table(predictedSpam, testSpam$type)
##
## predictedSpam nonspam spam
## nonspam 1346 458
## spam 61 449
## Error rate
(61 + 458)/(1346 + 458 + 61 + 449)
## [1] 0.2243
```

## Step 8: Interpret results
* Use the appropriate language
 + describes
 + correlates with/associated with
 + leads to/causes
 + predicts
* Give an explanation
* Interpret coefficients
* Interpret measures of uncertainty

### Our example
* The fraction of charcters that are dollar signs can be used to predict if an email is Spam
* Anything with more than 6.6% dollar signs is classified as Spam
* More dollar signs always means more Spam under our prediction
* Our test set error rate was 22.4%

## Step 9: Challenge results
* Challenge all steps:
 + Question
 + Data source
 + Processing
 + Analysis
 + Conclusions
* Challenge measures of uncertainty
* Challenge choices of terms to include in models
* Think of potential alternative analyses

## Step 10: Synthesize/write-up results
* Lead with the question
* Summarize the analyses into the story
* Don't include every analysis, include it
 + If it is needed for the story
 + If it is needed to address a challenge
* Order analyses according to the story, rather than chronologically
* Include "pretty" figures that contribute to the story

### Our example
* Lead with the question
 + Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?
* Describe the approach
 + Collected data from UCI -> created training/test sets
 + Explored relationships
 + Choose logistic model on training set by cross validation
 + Applied to test, 78% test set accuracy
* Interpret results
 + Number of dollar signs seems reasonable, e.g. "Make money with Viagra $ $ $ $!"
* Challenge results
 + 78% isn't that great
 + I could use more variables
 + Why logistic regression?

## Step 11: Create reproducible code
