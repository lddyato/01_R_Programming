## Prediction study design

1. Define your error rate
2. Split data into:
  * Training, Testing, Validation (optional)
3. On the training set pick features
  * Use cross-validation
4. On the training set pick prediction function
  * Use cross-validation
6. If no validation 
  * Apply 1x to test set
7. If validation
  * Apply to test set and refine
  * Apply 1x to validation 

## Study design
<img src="https://github.com/lddyato/R_Language/blob/master/SubFiles/08/studyDesign.png">

## Avoid small sample sizes

* Suppose you are predicting a binary outcome 
  * Diseased/healthy
  * Click on ad/not click on ad 
* One classifier is flipping a coin
* Probability of perfect classification is approximately:
  * $\left(\frac{1}{2}\right)^{sample \; size}$
  * $n = 1$ flipping coin 50% chance of 100% accuracy
  * $n = 2$ flipping coin 25% chance of 100% accuracy
  * $n = 10$ flipping coin 0.10% chance of 100% accuracy

## Rules of thumb for prediction study design

* If you have a large sample size
  * 60% training
  * 20% test
  * 20% validation
* If you have a medium sample size
  * 60% training
  * 40% testing
* If you have a small sample size
  * Do cross validation
  * Report caveat of small sample size

## Some principles to remember

* Set the test/validation set aside and _don't look at it_
* In general _randomly_ sample training and test
* Your data sets must reflect structure of the problem
  * If predictions evolve with time split train/test in time chunks (called[backtesting](http://en.wikipedia.org/wiki/Backtesting) in finance)
* All subsets should reflect as much diversity as possible
  * Random assignment does this
  * You can also try to balance by features - but this is tricky

## Types of Errors
### Basic terms
In general, __Positive__ = identified and __negative__ = rejected. Therefore:

__True positive__ = correctly identified

__False positive__ = incorrectly identified

__True negative__ = correctly rejected

__False negative__ = incorrectly rejected

_Medical testing example_:

__True positive__ = Sick people correctly diagnosed as sick

__False positive__= Healthy people incorrectly identified as sick

__True negative__ = Healthy people correctly identified as healthy

__False negative__ = Sick people incorrectly identified as healthy.

## Key quantities

<img class=center src=https://github.com/lddyato/R_Language/blob/master/SubFiles/08/0001.png height=500>

## Key quantities as fractions


<img class=center src=https://github.com/lddyato/R_Language/blob/master/SubFiles/08/0002.png height=500>

## Screening tests


<img class=center src=https://github.com/lddyato/R_Language/blob/master/SubFiles/08/0003.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

## General population


<img class=center src=https://github.com/lddyato/R_Language/blob/master/SubFiles/08/0004.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

## General population as fractions


<img class=center src=https://github.com/lddyato/R_Language/blob/master/SubFiles/08/0005.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

## At risk subpopulation

<img class=center src=https://github.com/lddyato/R_Language/blob/master/SubFiles/08/0006.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/

---

## At risk subpopulation as fraction

<img class=center src=https://github.com/lddyato/R_Language/blob/master/SubFiles/08/0007.png height=500>
http://www.biostat.jhsph.edu/~iruczins/teaching/140.615/


## For continuous data

__Mean squared error (MSE)__:

$$\frac{1}{n} \sum_{i=1}^n (Prediction_i - Truth_i)^2$$

__Root mean squared error (RMSE)__:

$$\sqrt{\frac{1}{n} \sum_{i=1}^n(Prediction_i - Truth_i)^2}$$

---

## Common error measures

1. Mean squared error (or root mean squared error)
  * Continuous data, sensitive to outliers
2. Median absolute deviation 
  * Continuous data, often more robust
3. Sensitivity (recall)
  * If you want few missed positives
4. Specificity
  * If you want few negatives called positives
5. Accuracy
  * Weights false positives/negatives equally
6. Concordance
  * One example is [kappa](http://en.wikipedia.org/wiki/Cohen%27s_kappa)
5. Predictive value of a positive (precision)
  * When you are screeing and prevelance is low
