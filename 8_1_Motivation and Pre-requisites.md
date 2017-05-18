# Practical Machine Learning
This course covers the basic ideas behind machine learning/prediction
* Study design - training vs. test sets
* Conceptual issues - out of sample error, ROC curves
* Practical implementation - the caret package

## Who predicts?
* Local governments ­> pension payments
* Google ­> whether you will click on an ad
* Amazon ­> what movies you will watch
* Insurance companies ­> what your risk of death is
* Johns Hopkins ­> who will succeed in their programs

## Why predict?
* Glory
* Riches
* Sport
* Save lives

A useful package - the caret package

## What is prediction?

### components of a preditor
**question > input data > features > algorithm -> parameters -> evaluation**
### Step 1: Question
* Start with a general question    
Can I automatically detect emails that are SPAM that are not?
* Make it concrete     
Can I use quantitative characteristics of the emails to classify them as SPAM/HAM?

### Step 2: INput data
<http://rss.acs.edu/Rdoc/library/kernlab/html/spam.html>
"The combination of some data and an aching desire for an answer does not ensure that a reasonable answer can be extracted from a given body of data.----John Tukey

**Garbage in = Garbage out**
* May be easy (movie ratings -> new movie ratings)
* May be harder (gene expression data -> disease)
* Depends on what is a "good prediction".
* Often more data > better models
* The most important step!

### Step 3: features matter!
Properties of good features:
* Lead to data compression
* Retain relevant information
* Are created based on expert application knowledge

Common mistakes:
* Trying to automate feature selection
* Not paying attention to data-specific quirks
* Throwing away information unnecessarily

### Step 4: Algorithms matter less than you'd think
<img src="https://github.com/lddyato/R_Language/blob/master/SubFiles/08/illusiontable.png">

### The "Best" Machine Learning method
Prediction is about accuracy tradeoffs
* Interpretability versus accuracy
* Speed versus accuracy
* Simplicity versus accuracy
* Scalability versus accuracy

### SPAM Example
```r
 install.packages("kernlab")
library(kernlab)
data(spam)
head(spam)
str(spam)
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
``` 
### Step 4: alogrithm
```r
plot(density(spam$your[spam$type == "nonspam"]), col = "blue", main = "", xlab = "Frequency of 'your'")
lines(density(spam$your[spam$type == "spam"]), col = "red")
```
Our algorithm
* Find a value C
* frequency of 'your' > C predict 'spam'

### Step 5: parameters
```r
abline(v=0.5, col = "black")
```

### Step 6: evaluation
```r
prediction <- ifelse(spam$your > 0.5, "spam", "nonspam")
table(prediction, spam$type)/length(spam$type)
prediction   nonspam      spam
   nonspam 0.4590306 0.1017170
   spam    0.1469246 0.2923278
Accuracy = 0.459 + 0.292 = 0.751
```
## In sample versus out of sample
__In Sample Error__: The error rate you get on the same
data set you used to build your predictor. Sometimes
called resubstitution error.

__Out of Sample Error__: The error rate you get on a new
data set. Sometimes called generalization error. 

__Key ideas__

1. Out of sample error is what you care about
2. In sample error $<$ out of sample error
3. The reason is overfitting
  * Matching your algorithm to the data you have

---

## In sample versus out of sample errors


```r
library(kernlab); data(spam); set.seed(333)
smallSpam <- spam[sample(dim(spam)[1],size=10),]
spamLabel <- (smallSpam$type=="spam")*1 + 1
plot(smallSpam$capitalAve,col=spamLabel)
```
<img src="https://github.com/lddyato/R_Language/blob/master/SubFiles/08/loadData.png"

---

## Prediction rule 1

* capitalAve $>$ 2.7 = "spam"
* capitalAve $<$ 2.40 = "nonspam"
* capitalAve between 2.40 and 2.45 = "spam"
* capitalAve between 2.45 and 2.7 = "nonspam"

---

## Apply Rule 1 to smallSpam


```r
rule1 <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 2.7] <- "spam"
  prediction[x < 2.40] <- "nonspam"
  prediction[(x >= 2.40 & x <= 2.45)] <- "spam"
  prediction[(x > 2.45 & x <= 2.70)] <- "nonspam"
  return(prediction)
}
table(rule1(smallSpam$capitalAve),smallSpam$type)
```

```
         
          nonspam spam
  nonspam       5    0
  spam          0    5
```


---

## Prediction rule 2

* capitalAve $>$ 2.40 = "spam"
* capitalAve $\leq$ 2.40 = "nonspam"


---

## Apply Rule 2 to smallSpam



```r
rule2 <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 2.8] <- "spam"
  prediction[x <= 2.8] <- "nonspam"
  return(prediction)
}
table(rule2(smallSpam$capitalAve),smallSpam$type)
```

```
         
          nonspam spam
  nonspam       5    1
  spam          0    4
```


---

## Apply to complete spam data


```r
table(rule1(spam$capitalAve),spam$type)
```

```
         
          nonspam spam
  nonspam    2141  588
  spam        647 1225
```

```r
table(rule2(spam$capitalAve),spam$type)
```

```
         
          nonspam spam
  nonspam    2224  642
  spam        564 1171
```

```r
mean(rule1(spam$capitalAve)==spam$type)
```

```
[1] 0.7316
```

```r
mean(rule2(spam$capitalAve)==spam$type)
```

```
[1] 0.7379
```


---

## Look at accuracy


```r
sum(rule1(spam$capitalAve)==spam$type)
```

```
[1] 3366
```

```r
sum(rule2(spam$capitalAve)==spam$type)
```

```
[1] 3395
```



---

## What's going on? 

<center><rt> Overfitting </rt></center>

* Data have two parts
  * Signal
  * Noise
* The goal of a predictor is to find signal
* You can always design a perfect in-sample predictor
* You capture both signal + noise when you do that
* Predictor won't perform as well on new samples
