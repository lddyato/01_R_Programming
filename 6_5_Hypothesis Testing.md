---
title       : Two group intervals
subtitle    : Statistical Inference
author      : Brian Caffo, Jeff Leek, Roger Peng
job         : Johns Hopkins Bloomberg School of Public Health
logo        : bloomberg_shield.png
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
url:
  lib: ../../librariesNew
  assets: ../../assets
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---



## Independent group $t$ confidence intervals

- Suppose that we want to compare the mean blood pressure between two groups in a randomized trial; those who received the treatment to those who received a placebo
- We cannot use the paired t test because the groups are independent and may have different sample sizes
- We now present methods for comparing independent groups

---

## Notation

- Let $X_1,\ldots,X_{n_x}$ be iid $N(\mu_x,\sigma^2)$
- Let $Y_1,\ldots,Y_{n_y}$ be iid $N(\mu_y, \sigma^2)$
- Let $\bar X$, $\bar Y$, $S_x$, $S_y$ be the means and standard deviations
- Using the fact that linear combinations of normals are again normal, we know that $\bar Y - \bar X$ is also normal with mean $\mu_y - \mu_x$ and variance $\sigma^2 (\frac{1}{n_x} + \frac{1}{n_y})$
- The pooled variance estimator $$S_p^2 = \{(n_x - 1) S_x^2 + (n_y - 1) S_y^2\}/(n_x + n_y - 2)$$ is a good estimator of $\sigma^2$

---

## Note

- The pooled estimator is a mixture of the group variances, placing greater weight on whichever has a larger sample size
- If the sample sizes are the same the pooled variance estimate is the average of the group variances
- The pooled estimator is unbiased
$$
    \begin{eqnarray*}
    E[S_p^2] & = & \frac{(n_x - 1) E[S_x^2] + (n_y - 1) E[S_y^2]}{n_x + n_y - 2}\\
            & = & \frac{(n_x - 1)\sigma^2 + (n_y - 1)\sigma^2}{n_x + n_y - 2}
    \end{eqnarray*}
$$
- The pooled variance  estimate is independent of $\bar Y - \bar X$ since $S_x$ is independent of $\bar X$ and $S_y$ is independent of $\bar Y$ and the groups are independent

---

## Result

- The sum of two independent Chi-squared random variables is Chi-squared with degrees of freedom equal to the sum of the degrees of freedom of the summands
- Therefore
$$
    \begin{eqnarray*}
      (n_x + n_y - 2) S_p^2 / \sigma^2 & = & (n_x - 1)S_x^2 /\sigma^2 + (n_y - 1)S_y^2/\sigma^2 \\ \\
      & = & \chi^2_{n_x - 1} + \chi^2_{n_y-1} \\ \\
      & = & \chi^2_{n_x + n_y - 2}
    \end{eqnarray*}
$$

---

## Putting this all together

- The statistic
$$
    \frac{\frac{\bar Y - \bar X - (\mu_y - \mu_x)}{\sigma \left(\frac{1}{n_x} + \frac{1}{n_y}\right)^{1/2}}}%
    {\sqrt{\frac{(n_x + n_y - 2) S_p^2}{(n_x + n_y - 2)\sigma^2}}}
    = \frac{\bar Y - \bar X - (\mu_y - \mu_x)}{S_p \left(\frac{1}{n_x} + \frac{1}{n_y}\right)^{1/2}}
$$
is a standard normal divided by the square root of an independent Chi-squared divided by its degrees of freedom 
- Therefore this statistic follows Gosset's $t$ distribution with $n_x + n_y - 2$ degrees of freedom
- Notice the form is (estimator - true value) / SE

---

## Confidence interval

- Therefore a $(1 - \alpha)\times 100\%$ confidence interval for $\mu_y - \mu_x$ is 
$$
    \bar Y - \bar X \pm t_{n_x + n_y - 2, 1 - \alpha/2}S_p\left(\frac{1}{n_x} + \frac{1}{n_y}\right)^{1/2}
$$
- Remember this interval is assuming a constant variance across the two groups
- If there is some doubt, assume a different variance per group, which we will discuss later

---


## Example
### Based on Rosner, Fundamentals of Biostatistics

- Comparing SBP for 8 oral contraceptive users versus 21 controls
- $\bar X_{OC} = 132.86$ mmHg with $s_{OC} = 15.34$ mmHg
- $\bar X_{C} = 127.44$ mmHg with $s_{C} = 18.23$ mmHg
- Pooled variance estimate

```r
sp <- sqrt((7 * 15.34^2 + 20 * 18.23^2) / (8 + 21 - 2))
132.86 - 127.44 + c(-1, 1) * qt(.975, 27) * sp * (1 / 8 + 1 / 21)^.5
```

```
[1] -9.521 20.361
```


---

```r
data(sleep)
x1 <- sleep$extra[sleep$group == 1]
x2 <- sleep$extra[sleep$group == 2]
n1 <- length(x1)
n2 <- length(x2)
sp <- sqrt( ((n1 - 1) * sd(x1)^2 + (n2-1) * sd(x2)^2) / (n1 + n2-2))
md <- mean(x1) - mean(x2)
semd <- sp * sqrt(1 / n1 + 1/n2)
md + c(-1, 1) * qt(.975, n1 + n2 - 2) * semd
```

```
[1] -3.3639  0.2039
```

```r
t.test(x1, x2, paired = FALSE, var.equal = TRUE)$conf
```

```
[1] -3.3639  0.2039
attr(,"conf.level")
[1] 0.95
```

```r
t.test(x1, x2, paired = TRUE)$conf
```

```
[1] -2.4599 -0.7001
attr(,"conf.level")
[1] 0.95
```


---
## Ignoring pairing
<div class="rimage center"><img src="fig/unnamed-chunk-3.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" class="plot" /></div>


---

## Unequal variances

- Under unequal variances
$$
    \bar Y - \bar X \sim N\left(\mu_y - \mu_x, \frac{s_x^2}{n_x} + \frac{\sigma_y^2}{n_y}\right)
$$
- The statistic 
$$
    \frac{\bar Y - \bar X - (\mu_y - \mu_x)}{\left(\frac{s_x^2}{n_x} + \frac{\sigma_y^2}{n_y}\right)^{1/2}}
$$
approximately follows Gosset's $t$ distribution with degrees of freedom equal to
$$
    \frac{\left(S_x^2 / n_x + S_y^2/n_y\right)^2}
    {\left(\frac{S_x^2}{n_x}\right)^2 / (n_x - 1) +
      \left(\frac{S_y^2}{n_y}\right)^2 / (n_y - 1)}
$$

---

## Example

- Comparing SBP for 8 oral contraceptive users versus 21 controls
- $\bar X_{OC} = 132.86$ mmHg with $s_{OC} = 15.34$ mmHg
- $\bar X_{C} = 127.44$ mmHg with $s_{C} = 18.23$ mmHg
- $df=15.04$, $t_{15.04, .975} = 2.13$
- Interval
$$
132.86 - 127.44 \pm 2.13 \left(\frac{15.34^2}{8} + \frac{18.23^2}{21} \right)^{1/2}
= [-8.91, 19.75]
$$
- In R, `t.test(..., var.equal = FALSE)`

---
## Comparing other kinds of data
* For binomial data, there's lots of ways to compare two groups
  * Relative risk, risk difference, odds ratio.
  * Chi-squared tests, normal approximations, exact tests.
* For count data, there's also Chi-squared tests and exact tests.
* We'll leave the discussions for comparing groups of data for binary
  and count data until covering glms in the regression class.
* In addition, Mathematical Biostatistics Boot Camp 2 covers many special
  cases relevant to biostatistics.

## Hypothesis testing
* Hypothesis testing is concerned with making decisions using data
* A null hypothesis is specified that represents the status quo,
  usually labeled $H_0$
* The null hypothesis is assumed true and statistical evidence is required
  to reject it in favor of a research or alternative hypothesis 

---
## Example
* A respiratory disturbance index of more than $30$ events / hour, say, is 
  considered evidence of severe sleep disordered breathing (SDB).
* Suppose that in a sample of $100$ overweight subjects with other
  risk factors for sleep disordered breathing at a sleep clinic, the
  mean RDI was $32$ events / hour with a standard deviation of $10$ events / hour.
* We might want to test the hypothesis that 
  * $H_0 : \mu = 30$
  * $H_a : \mu > 30$
  * where $\mu$ is the population mean RDI.

---
## Hypothesis testing
* The alternative hypotheses are typically of the form $<$, $>$ or $\neq$
* Note that there are four possible outcomes of our statistical decision process

Truth | Decide | Result |
---|---|---|
$H_0$ | $H_0$ | Correctly accept null |
$H_0$ | $H_a$ | Type I error |
$H_a$ | $H_a$ | Correctly reject null |
$H_a$ | $H_0$ | Type II error |

---
## Discussion
* Consider a court of law; the null hypothesis is that the
  defendant is innocent
* We require evidence to reject the null hypothesis (convict)
* If we require little evidence, then we would increase the
  percentage of innocent people convicted (type I errors); however we
  would also increase the percentage of guilty people convicted
  (correctly rejecting the null)
* If we require a lot of evidence, then we increase the the
  percentage of innocent people let free (correctly accepting the
  null) while we would also increase the percentage of guilty people
  let free (type II errors)

---
## Example
* Consider our example again
* A reasonable strategy would reject the null hypothesis if
  $\bar X$ was larger than some constant, say $C$
* Typically, $C$ is chosen so that the probability of a Type I
  error, $\alpha$, is $.05$ (or some other relevant constant)
* $\alpha$ = Type I error rate = Probability of rejecting the null hypothesis when, in fact, the null hypothesis is correct

---
## Example continued


$$
\begin{align}
0.05  & =  P\left(\bar X \geq C ~|~ \mu = 30 \right) \\
      & =  P\left(\frac{\bar X - 30}{10 / \sqrt{100}} \geq \frac{C - 30}{10/\sqrt{100}} ~|~ \mu = 30\right) \\
      & =  P\left(Z \geq \frac{C - 30}{1}\right) \\
\end{align}
$$

* Hence $(C - 30) / 1 = 1.645$ implying $C = 31.645$
* Since our mean is $32$ we reject the null hypothesis

---
## Discussion
* In general we don't convert $C$ back to the original scale
* We would just reject because the Z-score; which is how many
  standard errors the sample mean is above the hypothesized mean
  $$
  \frac{32 - 30}{10 / \sqrt{100}} = 2
  $$
  is greater than $1.645$
* Or, whenever $\sqrt{n} (\bar X - \mu_0) / s > Z_{1-\alpha}$

---
## General rules
* The $Z$ test for $H_0:\mu = \mu_0$ versus 
  * $H_1: \mu < \mu_0$
  * $H_2: \mu \neq \mu_0$
  * $H_3: \mu > \mu_0$ 
* Test statistic $ TS = \frac{\bar{X} - \mu_0}{S / \sqrt{n}} $
* Reject the null hypothesis when 
  * $TS \leq -Z_{1 - \alpha}$
  * $|TS| \geq Z_{1 - \alpha / 2}$
  * $TS \geq Z_{1 - \alpha}$

---
## Notes
* We have fixed $\alpha$ to be low, so if we reject $H_0$ (either
  our model is wrong) or there is a low probability that we have made
  an error
* We have not fixed the probability of a type II error, $\beta$;
  therefore we tend to say ``Fail to reject $H_0$'' rather than
  accepting $H_0$
* Statistical significance is no the same as scientific
  significance
* The region of TS values for which you reject $H_0$ is called the
  rejection region

---
## More notes
* The $Z$ test requires the assumptions of the CLT and for $n$ to be large enough
  for it to apply
* If $n$ is small, then a Gossett's $T$ test is performed exactly in the same way,
  with the normal quantiles replaced by the appropriate Student's $T$ quantiles and
  $n-1$ df
* The probability of rejecting the null hypothesis when it is false is called *power*
* Power is a used a lot to calculate sample sizes for experiments

---
## Example reconsidered
- Consider our example again. Suppose that $n= 16$ (rather than
$100$). Then consider that
$$
.05 = P\left(\frac{\bar X - 30}{s / \sqrt{16}} \geq t_{1-\alpha, 15} ~|~ \mu = 30 \right)
$$
- So that our test statistic is now $\sqrt{16}(32 - 30) / 10 = 0.8 $, while the critical value is $t_{1-\alpha, 15} = 1.75$. 
- We now fail to reject.

---
## Two sided tests
* Suppose that we would reject the null hypothesis if in fact the 
  mean was too large or too small
* That is, we want to test the alternative $H_a : \mu \neq 30$
  (doesn't make a lot of sense in our setting)
* Then note
$$
 \alpha = P\left(\left. \left|\frac{\bar X - 30}{s /\sqrt{16}}\right| > t_{1-\alpha/2,15} ~\right|~ \mu = 30\right)
$$
* That is we will reject if the test statistic, $0.8$, is either
  too large or too small, but the critical value is calculated using
  $\alpha / 2$
* In our example the critical value is $2.13$, so we fail to reject.

---
## T test in R

```r
library(UsingR); data(father.son)
t.test(father.son$sheight - father.son$fheight)
```

```

	One Sample t-test

data:  father.son$sheight - father.son$fheight
t = 11.79, df = 1077, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 0
95 percent confidence interval:
 0.831 1.163
sample estimates:
mean of x 
    0.997 
```


---
## Connections with confidence intervals
* Consider testing $H_0: \mu = \mu_0$ versus $H_a: \mu \neq \mu_0$
* Take the set of all possible values for which you fail to reject $H_0$, this set is a $(1-\alpha)100\%$ confidence interval for $\mu$
* The same works in reverse; if a $(1-\alpha)100\%$ interval
  contains $\mu_0$, then we *fail  to* reject $H_0$

---
## Exact binomial test
- Recall this problem, *Suppose a friend has $8$ children, $7$ of which are girls and none are twins*
- Perform the relevant hypothesis test. $H_0 : p = 0.5$ $H_a : p > 0.5$
  - What is the relevant rejection region so that the probability of rejecting is (less than) 5%?
  
Rejection region | Type I error rate |
---|---|
[0 : 8] | 1
[1 : 8] | 0.9961
[2 : 8] | 0.9648
[3 : 8] | 0.8555
[4 : 8] | 0.6367
[5 : 8] | 0.3633
[6 : 8] | 0.1445
[7 : 8] | 0.0352
[8 : 8] | 0.0039

---
## Notes
* It's impossible to get an exact 5% level test for this case due to the discreteness of the binomial. 
  * The closest is the rejection region [7 : 8]
  * Any alpha level lower than 0.0039 is not attainable.
* For larger sample sizes, we could do a normal approximation, but you already knew this.
* Two sided test isn't obvious. 
  * Given a way to do two sided tests, we could take the set of values of $p_0$ for which we fail to reject to get an exact binomial confidence interval (called the Clopper/Pearson interval, BTW)
* For these problems, people always create a P-value (next lecture) rather than computing the rejection region.

## P-values

* Most common measure of "statistical significance"
* Their ubiquity, along with concern over their interpretation and use
  makes them controversial among statisticians
  * [http://warnercnr.colostate.edu/~anderson/thompson1.html](http://warnercnr.colostate.edu/~anderson/thompson1.html)
  * Also see *Statistical Evidence: A Likelihood Paradigm* by Richard Royall 
  * *Toward Evidence-Based Medical Statistics. 1: The P Value Fallacy* by Steve Goodman
  * The hilariously titled: *The Earth is Round (p < .05)* by Cohen.
* Some positive comments
  * [simply statistics](http://simplystatistics.org/2012/01/06/p-values-and-hypothesis-testing-get-a-bad-rap-but-we/)
  * [normal deviate](http://normaldeviate.wordpress.com/2013/03/14/double-misunderstandings-about-p-values/)
  * [Error statistics](http://errorstatistics.com/2013/06/14/p-values-cant-be-trusted-except-when-used-to-argue-that-p-values-cant-be-trusted/)

---


## What is a P-value? 

__Idea__: Suppose nothing is going on - how unusual is it to see the estimate we got?

__Approach__: 

1. Define the hypothetical distribution of a data summary (statistic) when "nothing is going on" (_null hypothesis_)
2. Calculate the summary/statistic with the data we have (_test statistic_)
3. Compare what we calculated to our hypothetical distribution and see if the value is "extreme" (_p-value_)

---
## P-values
* The P-value is the probability under the null hypothesis of obtaining evidence as extreme or more extreme than would be observed by chance alone
* If the P-value is small, then either $H_0$ is true and we have observed a rare event or $H_0$ is false
*  In our example the $T$ statistic was $0.8$. 
  * What's the probability of getting a $T$ statistic as large as $0.8$?

```r
pt(0.8, 15, lower.tail = FALSE) 
```

```
[1] 0.2181
```

* Therefore, the probability of seeing evidence as extreme or more extreme than that actually obtained under $H_0$ is 0.2181

---
## The attained significance level
* Our test statistic was $2$ for $H_0 : \mu_0  = 30$ versus $H_a:\mu > 30$.
* Notice that we rejected the one sided test when $\alpha = 0.05$, would we reject if $\alpha = 0.01$, how about $0.001$?
* The smallest value for alpha that you still reject the null hypothesis is called the *attained significance level*
* This is equivalent, but philosophically a little different from, the *P-value*

---
## Notes
* By reporting a P-value the reader can perform the hypothesis
  test at whatever $\alpha$ level he or she choses
* If the P-value is less than $\alpha$ you reject the null hypothesis 
* For two sided hypothesis test, double the smaller of the two one
  sided hypothesis test Pvalues

---
## Revisiting an earlier example
- Suppose a friend has $8$ children, $7$ of which are girls and none are twins
- If each gender has an independent $50$% probability for each birth, what's the probability of getting $7$ or more girls out of $8$ births?

```r
choose(8, 7) * .5 ^ 8 + choose(8, 8) * .5 ^ 8 
```

```
[1] 0.03516
```

```r
pbinom(6, size = 8, prob = .5, lower.tail = FALSE)
```

```
[1] 0.03516
```


---
## Poisson example
- Suppose that a hospital has an infection rate of 10 infections per 100 person/days at risk (rate of 0.1) during the last monitoring period.
- Assume that an infection rate of 0.05 is an important benchmark. 
- Given the model, could the observed rate being larger than 0.05 be attributed to chance?
- Under $H_0: \lambda = 0.05$ so that $\lambda_0 100 = 5$
- Consider $H_a: \lambda > 0.05$.


```r
ppois(9, 5, lower.tail = FALSE)
```

```
[1] 0.03183
```

## Power
- Power is the probability of rejecting the null hypothesis when it is false
- Ergo, power (as it's name would suggest) is a good thing; you want more power
- A type II error (a bad thing, as its name would suggest) is failing to reject the null hypothesis when it's false; the probability of a type II error is usually called $\beta$
- Note Power  $= 1 - \beta$

---
## Notes
- Consider our previous example involving RDI
- $H_0: \mu = 30$ versus $H_a: \mu > 30$
- Then power is 
$$P\left(\frac{\bar X - 30}{s /\sqrt{n}} > t_{1-\alpha,n-1} ~|~ \mu = \mu_a \right)$$
- Note that this is a function that depends on the specific value of $\mu_a$!
- Notice as $\mu_a$ approaches $30$ the power approaches $\alpha$


---
## Calculating power for Gaussian data
Assume that $n$ is large and that we know $\sigma$
$$
\begin{align}
1 -\beta & = 
P\left(\frac{\bar X - 30}{\sigma /\sqrt{n}} > z_{1-\alpha} ~|~ \mu = \mu_a \right)\\
& = P\left(\frac{\bar X - \mu_a + \mu_a - 30}{\sigma /\sqrt{n}} > z_{1-\alpha} ~|~ \mu = \mu_a \right)\\ \\
& = P\left(\frac{\bar X - \mu_a}{\sigma /\sqrt{n}} > z_{1-\alpha} - \frac{\mu_a - 30}{\sigma /\sqrt{n}} ~|~ \mu = \mu_a \right)\\ \\
& = P\left(Z > z_{1-\alpha} - \frac{\mu_a - 30}{\sigma /\sqrt{n}} ~|~ \mu = \mu_a \right)\\ \\
\end{align}
$$

---
## Example continued
-  Suppose that we wanted to detect a increase in mean RDI
  of at least 2 events / hour (above 30). 
- Assume normality and that the sample in question will have a standard deviation of $4$;
- What would be the power if we took a sample size of $16$?
  - $Z_{1-\alpha} = 1.645$ 
  - $\frac{\mu_a - 30}{\sigma /\sqrt{n}} = 2 / (4 /\sqrt{16}) = 2$ 
  - $P(Z > 1.645 - 2) = P(Z > -0.355) = 64\%$

```r
pnorm(-0.355, lower.tail = FALSE)
```

```
[1] 0.6387
```


---
## Note
- Consider $H_0 : \mu = \mu_0$ and $H_a : \mu > \mu_0$ with $\mu = \mu_a$ under $H_a$.
- Under $H_0$ the statistic $Z = \frac{\sqrt{n}(\bar X - \mu_0)}{\sigma}$ is $N(0, 1)$
- Under $H_a$ $Z$ is $N\left( \frac{\sqrt{n}(\mu_a - \mu_0)}{\sigma}, 1\right)$
- We reject if $Z > Z_{1-\alpha}$

```
sigma <- 10; mu_0 = 0; mu_a = 2; n <- 100; alpha = .05
plot(c(-3, 6),c(0, dnorm(0)), type = "n", frame = false, xlab = "Z value", ylab = "")
xvals <- seq(-3, 6, length = 1000)
lines(xvals, dnorm(xvals), type = "l", lwd = 3)
lines(xvals, dnorm(xvals, mean = sqrt(n) * (mu_a - mu_0) / sigma), lwd =3)
abline(v = qnorm(1 - alpha))
```

---
<div class="rimage center"><img src="fig/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" class="plot" /></div>



---
## Question
- When testing $H_a : \mu > \mu_0$, notice if power is $1 - \beta$, then 
$$1 - \beta = P\left(Z > z_{1-\alpha} - \frac{\mu_a - \mu_0}{\sigma /\sqrt{n}} ~|~ \mu = \mu_a \right) = P(Z > z_{\beta})$$
- This yields the equation
$$z_{1-\alpha} - \frac{\sqrt{n}(\mu_a - \mu_0)}{\sigma} = z_{\beta}$$
- Unknowns: $\mu_a$, $\sigma$, $n$, $\beta$
- Knowns: $\mu_0$, $\alpha$
- Specify any 3 of the unknowns and you can solve for the remainder

---
## Notes
- The calculation for $H_a:\mu < \mu_0$ is similar
- For $H_a: \mu \neq \mu_0$ calculate the one sided power using
  $\alpha / 2$ (this is only approximately right, it excludes the probability of
  getting a large TS in the opposite direction of the truth)
- Power goes up as $\alpha$ gets larger
- Power of a one sided test is greater than the power of the
  associated two sided test
- Power goes up as $\mu_1$ gets further away from $\mu_0$
- Power goes up as $n$ goes up
- Power doesn't need $\mu_a$, $\sigma$ and $n$, instead only $\frac{\sqrt{n}(\mu_a - \mu_0)}{\sigma}$
  - The quantity $\frac{\mu_a - \mu_0}{\sigma}$ is called the effect size, the difference in the means in standard deviation units.
  - Being unit free, it has some hope of interpretability across settings

---
## T-test power
-  Consider calculating power for a Gossett's $T$ test for our example
-  The power is
  $$
  P\left(\frac{\bar X - \mu_0}{S /\sqrt{n}} > t_{1-\alpha, n-1} ~|~ \mu = \mu_a \right)
  $$
- Calcuting this requires the non-central t distribution.
- `power.t.test` does this very well
  - Omit one of the arguments and it solves for it

---
## Example

```r
power.t.test(n = 16, delta = 2 / 4, sd=1, type = "one.sample",  alt = "one.sided")$power
```

```
[1] 0.604
```

```r
power.t.test(n = 16, delta = 2, sd=4, type = "one.sample",  alt = "one.sided")$power
```

```
[1] 0.604
```

```r
power.t.test(n = 16, delta = 100, sd=200, type = "one.sample", alt = "one.sided")$power
```

```
[1] 0.604
```


---
## Example

```r
power.t.test(power = .8, delta = 2 / 4, sd=1, type = "one.sample",  alt = "one.sided")$n
```

```
[1] 26.14
```

```r
power.t.test(power = .8, delta = 2, sd=4, type = "one.sample",  alt = "one.sided")$n
```

```
[1] 26.14
```

```r
power.t.test(power = .8, delta = 100, sd=200, type = "one.sample", alt = "one.sided")$n
```

```
[1] 26.14
```
## Key ideas

* Hypothesis testing/significance analysis is commonly overused
* Correcting for multiple testing avoids false positives or discoveries
* Two key components
  * Error measure
  * Correction


---

## Three eras of statistics

__The age of Quetelet and his successors, in which huge census-level data sets were brought to bear on simple but important questions__: Are there more male than female births? Is the rate of insanity rising?

The classical period of Pearson, Fisher, Neyman, Hotelling, and their successors, intellectual giants who __developed a theory of optimal inference capable of wringing every drop of information out of a scientific experiment__. The questions dealt with still tended to be simple Is treatment A better than treatment B? 

__The era of scientific mass production__, in which new technologies typified by the microarray allow a single team of scientists to produce data sets of a size Quetelet would envy. But now the flood of data is accompanied by a deluge of questions, perhaps thousands of estimates or hypothesis tests that the statistician is charged with answering together; not at all what the classical masters had in mind. Which variables matter among the thousands measured? How do you relate unrelated information?

[http://www-stat.stanford.edu/~ckirby/brad/papers/2010LSIexcerpt.pdf](http://www-stat.stanford.edu/~ckirby/brad/papers/2010LSIexcerpt.pdf)

---

## Reasons for multiple testing

<img class=center src=fig/datasources.png height=450>


---

## Why correct for multiple tests?

<img class=center src=fig/jellybeans1.png height=450>


[http://xkcd.com/882/](http://xkcd.com/882/)

---

## Why correct for multiple tests?

<img class=center src=fig/jellybeans2.png height=400>

[http://xkcd.com/882/](http://xkcd.com/882/)


---

## Types of errors

Suppose you are testing a hypothesis that a parameter $\beta$ equals zero versus the alternative that it does not equal zero. These are the possible outcomes. 
</br></br>

                    | $\beta=0$   | $\beta\neq0$   |  Hypotheses
--------------------|-------------|----------------|---------
Claim $\beta=0$     |      $U$    |      $T$       |  $m-R$
Claim $\beta\neq 0$ |      $V$    |      $S$       |  $R$
    Claims          |     $m_0$   |      $m-m_0$   |  $m$

</br></br>

__Type I error or false positive ($V$)__ Say that the parameter does not equal zero when it does

__Type II error or false negative ($T$)__ Say that the parameter equals zero when it doesn't 


---

## Error rates

__False positive rate__ - The rate at which false results ($\beta = 0$) are called significant: $E\left[\frac{V}{m_0}\right]$*

__Family wise error rate (FWER)__ - The probability of at least one false positive ${\rm Pr}(V \geq 1)$

__False discovery rate (FDR)__ - The rate at which claims of significance are false $E\left[\frac{V}{R}\right]$

* The false positive rate is closely related to the type I error rate [http://en.wikipedia.org/wiki/False_positive_rate](http://en.wikipedia.org/wiki/False_positive_rate)

---

## Controlling the false positive rate

If P-values are correctly calculated calling all $P < \alpha$ significant will control the false positive rate at level $\alpha$ on average. 

<redtext>Problem</redtext>: Suppose that you perform 10,000 tests and $\beta = 0$ for all of them. 

Suppose that you call all $P < 0.05$ significant. 

The expected number of false positives is: $10,000 \times 0.05 = 500$  false positives. 

__How do we avoid so many false positives?__


---

## Controlling family-wise error rate (FWER)


The [Bonferroni correction](http://en.wikipedia.org/wiki/Bonferroni_correction) is the oldest multiple testing correction. 

__Basic idea__: 
* Suppose you do $m$ tests
* You want to control FWER at level $\alpha$ so $Pr(V \geq 1) < \alpha$
* Calculate P-values normally
* Set $\alpha_{fwer} = \alpha/m$
* Call all $P$-values less than $\alpha_{fwer}$ significant

__Pros__: Easy to calculate, conservative
__Cons__: May be very conservative


---

## Controlling false discovery rate (FDR)

This is the most popular correction when performing _lots_ of tests say in genomics, imaging, astronomy, or other signal-processing disciplines. 

__Basic idea__: 
* Suppose you do $m$ tests
* You want to control FDR at level $\alpha$ so $E\left[\frac{V}{R}\right]$
* Calculate P-values normally
* Order the P-values from smallest to largest $P_{(1)},...,P_{(m)}$
* Call any $P_{(i)} \leq \alpha \times \frac{i}{m}$ significant

__Pros__: Still pretty easy to calculate, less conservative (maybe much less)

__Cons__: Allows for more false positives, may behave strangely under dependence

---

## Example with 10 P-values

<img class=center src=fig/example10pvals.png height=450>

Controlling all error rates at $\alpha = 0.20$

---

## Adjusted P-values

* One approach is to adjust the threshold $\alpha$
* A different approach is to calculate "adjusted p-values"
* They _are not p-values_ anymore
* But they can be used directly without adjusting $\alpha$

__Example__: 
* Suppose P-values are $P_1,\ldots,P_m$
* You could adjust them by taking $P_i^{fwer} = \max{m \times P_i,1}$ for each P-value.
* Then if you call all $P_i^{fwer} < \alpha$ significant you will control the FWER. 

---

## Case study I: no true positives


```r
set.seed(1010093)
pValues <- rep(NA,1000)
for(i in 1:1000){
  y <- rnorm(20)
  x <- rnorm(20)
  pValues[i] <- summary(lm(y ~ x))$coeff[2,4]
}

# Controls false positive rate
sum(pValues < 0.05)
```

```
[1] 51
```


---

## Case study I: no true positives


```r
# Controls FWER 
sum(p.adjust(pValues,method="bonferroni") < 0.05)
```

```
[1] 0
```

```r
# Controls FDR 
sum(p.adjust(pValues,method="BH") < 0.05)
```

```
[1] 0
```



---

## Case study II: 50% true positives


```r
set.seed(1010093)
pValues <- rep(NA,1000)
for(i in 1:1000){
  x <- rnorm(20)
  # First 500 beta=0, last 500 beta=2
  if(i <= 500){y <- rnorm(20)}else{ y <- rnorm(20,mean=2*x)}
  pValues[i] <- summary(lm(y ~ x))$coeff[2,4]
}
trueStatus <- rep(c("zero","not zero"),each=500)
table(pValues < 0.05, trueStatus)
```

```
       trueStatus
        not zero zero
  FALSE        0  476
  TRUE       500   24
```


---


## Case study II: 50% true positives


```r
# Controls FWER 
table(p.adjust(pValues,method="bonferroni") < 0.05,trueStatus)
```

```
       trueStatus
        not zero zero
  FALSE       23  500
  TRUE       477    0
```

```r
# Controls FDR 
table(p.adjust(pValues,method="BH") < 0.05,trueStatus)
```

```
       trueStatus
        not zero zero
  FALSE        0  487
  TRUE       500   13
```



---


## Case study II: 50% true positives

__P-values versus adjusted P-values__

```r
par(mfrow=c(1,2))
plot(pValues,p.adjust(pValues,method="bonferroni"),pch=19)
plot(pValues,p.adjust(pValues,method="BH"),pch=19)
```

<div class="rimage center"><img src="fig/unnamed-chunk-3.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" class="plot" /></div>



---


## Notes and resources

__Notes__:
* Multiple testing is an entire subfield
* A basic Bonferroni/BH correction is usually enough
* If there is strong dependence between tests there may be problems
  * Consider method="BY"

__Further resources__:
* [Multiple testing procedures with applications to genomics](http://www.amazon.com/Multiple-Procedures-Applications-Genomics-Statistics/dp/0387493166/ref=sr_1_2/102-3292576-129059?ie=UTF8&s=books&qid=1187394873&sr=1-2)
* [Statistical significance for genome-wide studies](http://www.pnas.org/content/100/16/9440.full)
* [Introduction to multiple testing](http://ies.ed.gov/ncee/pubs/20084018/app_b.asp)

## The jackknife

- The jackknife is a tool for estimating standard errors  and the bias of estimators 
- As its name suggests, the jackknife is a small, handy tool; in contrast to the bootstrap, which is then the moral equivalent of a giant workshop full of tools
- Both the jackknife and the bootstrap involve *resampling* data; that is, repeatedly creating new data sets from the original data

---

## The jackknife

- The jackknife deletes each observation and calculates an estimate based on the remaining $n-1$ of them
- It uses this collection of estimates to do things like estimate the bias and the standard error
- Note that estimating the bias and having a standard error are not needed for things like sample means, which we know are unbiased estimates of population means and what their standard errors are

---

## The jackknife

- We'll consider the jackknife for univariate data
- Let $X_1,\ldots,X_n$ be a collection of data used to estimate a parameter $\theta$
- Let $\hat \theta$ be the estimate based on the full data set
- Let $\hat \theta_{i}$ be the estimate of $\theta$ obtained by *deleting observation $i$*
- Let $\bar \theta = \frac{1}{n}\sum_{i=1}^n \hat \theta_{i}$

---

## Continued

- Then, the jackknife estimate of the bias is
   $$
   (n - 1) \left(\bar \theta - \hat \theta\right)
   $$
   (how far the average delete-one estimate is from the actual estimate)
- The jackknife estimate of the standard error is
   $$
   \left[\frac{n-1}{n}\sum_{i=1}^n (\hat \theta_i - \bar\theta )^2\right]^{1/2}
   $$
(the deviance of the delete-one estimates from the average delete-one estimate)

---

## Example
### We want to estimate the bias and standard error of the median


```r
library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)
theta <- median(x)
jk <- sapply(1 : n,
             function(i) median(x[-i])
             )
thetaBar <- mean(jk)
biasEst <- (n - 1) * (thetaBar - theta) 
seEst <- sqrt((n - 1) * mean((jk - thetaBar)^2))
```


---

## Example


```r
c(biasEst, seEst)
```

```
[1] 0.0000 0.1014
```

```r
library(bootstrap)
temp <- jackknife(x, median)
c(temp$jack.bias, temp$jack.se)
```

```
[1] 0.0000 0.1014
```


---

## Example

- Both methods (of course) yield an estimated bias of 0 and a se of 0.1014
- Odd little fact: the jackknife estimate of the bias for the median is always $0$ when the number of observations is even
- It has been shown that the jackknife is a linear approximation to the bootstrap
- Generally do not use the jackknife for sample quantiles like the median; as it has been shown to have some poor properties

---

## Pseudo observations

- Another interesting way to think about the jackknife uses pseudo observations
- Let
$$
      \mbox{Pseudo Obs} = n \hat \theta - (n - 1) \hat \theta_{i}
$$
- Think of these as ``whatever observation $i$ contributes to the estimate of $\theta$''
- Note when $\hat \theta$ is the sample mean, the pseudo observations are the data themselves
- Then the sample standard error of these observations is the previous jackknife estimated standard error.
- The mean of these observations is a bias-corrected estimate of $\theta$

---

## The bootstrap

- The bootstrap is a tremendously useful tool for constructing confidence intervals and calculating standard errors for difficult statistics
- For example, how would one derive a confidence interval for the median?
- The bootstrap procedure follows from the so called bootstrap principle

---

## The bootstrap principle

- Suppose that I have a statistic that estimates some population parameter, but I don't know its sampling distribution
- The bootstrap principle suggests using the distribution defined by the data to approximate its sampling distribution

---

## The bootstrap in practice

- In practice, the bootstrap principle is always carried out using simulation
- We will cover only a few aspects of bootstrap resampling
- The general procedure follows by first simulating complete data sets from the observed data with replacement

  - This is approximately drawing from the sampling distribution of that statistic, at least as far as the data is able to approximate the true population distribution

- Calculate the statistic for each simulated data set
- Use the simulated statistics to either define a confidence interval or take the standard deviation to calculate a standard error

---
## Nonparametric bootstrap algorithm example

- Bootstrap procedure for calculating confidence interval for the median from a data set of $n$ observations

  i. Sample $n$ observations **with replacement** from the observed data resulting in one simulated complete data set
  
  ii. Take the median of the simulated data set
  
  iii. Repeat these two steps $B$ times, resulting in $B$ simulated medians
  
  iv. These medians are approximately drawn from the sampling distribution of the median of $n$ observations; therefore we can
  
    - Draw a histogram of them
    - Calculate their standard deviation to estimate the standard error of the median
    - Take the $2.5^{th}$ and $97.5^{th}$ percentiles as a confidence interval for the median

---

## Example code


```r
B <- 1000
resamples <- matrix(sample(x,
                           n * B,
                           replace = TRUE),
                    B, n)
medians <- apply(resamples, 1, median)
sd(medians)
```

```
[1] 0.08546
```

```r
quantile(medians, c(.025, .975))
```

```
 2.5% 97.5% 
68.43 68.82 
```


---
## Histogram of bootstrap resamples


```r
hist(medians)
```

<div class="rimage center"><img src="fig/unnamed-chunk-4.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" class="plot" /></div>


---

## Notes on the bootstrap

- The bootstrap is non-parametric
- Better percentile bootstrap confidence intervals correct for bias
- There are lots of variations on bootstrap procedures; the book "An Introduction to the Bootstrap"" by Efron and Tibshirani is a great place to start for both bootstrap and jackknife information


---
## Group comparisons
- Consider comparing two independent groups.
- Example, comparing sprays B and C


```r
data(InsectSprays)
boxplot(count ~ spray, data = InsectSprays)
```

<div class="rimage center"><img src="fig/unnamed-chunk-5.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" class="plot" /></div>


---
## Permutation tests
-  Consider the null hypothesis that the distribution of the observations from each group is the same
-  Then, the group labels are irrelevant
-  We then discard the group levels and permute the combined data
-  Split the permuted data into two groups with $n_A$ and $n_B$
  observations (say by always treating the first $n_A$ observations as
  the first group)
-  Evaluate the probability of getting a statistic as large or
  large than the one observed
-  An example statistic would be the difference in the averages between the two groups;
  one could also use a t-statistic 

---
## Variations on permutation testing
Data type | Statistic | Test name 
---|---|---|
Ranks | rank sum | rank sum test
Binary | hypergeometric prob | Fisher's exact test
Raw data | | ordinary permutation test

- Also, so-called *randomization tests* are exactly permutation tests, with a different motivation.
- For matched data, one can randomize the signs
  - For ranks, this results in the signed rank test
- Permutation strategies work for regression as well
  - Permuting a regressor of interest
- Permutation tests work very well in multivariate settings

---
## Permutation test for pesticide data

```r
subdata <- InsectSprays[InsectSprays$spray %in% c("B", "C"),]
y <- subdata$count
group <- as.character(subdata$spray)
testStat <- function(w, g) mean(w[g == "B"]) - mean(w[g == "C"])
observedStat <- testStat(y, group)
permutations <- sapply(1 : 10000, function(i) testStat(y, sample(group)))
observedStat
```

```
[1] 13.25
```

```r
mean(permutations > observedStat)
```

```
[1] 0
```


---
## Histogram of permutations
<div class="rimage center"><img src="fig/unnamed-chunk-7.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" class="plot" /></div>









