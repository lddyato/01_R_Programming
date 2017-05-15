## Confidence intervals

- In the previous, we discussed creating a confidence interval using the CLT
- In this lecture, we discuss some methods for small samples, notably Gosset's $t$ distribution
- To discuss the $t$ distribution we must discuss the Chi-squared distribution
- Throughout we use the following general procedure for creating CIs

  a. Create a **Pivot** or statistic that does not depend on the parameter of interest
  
  b. Solve the probability that the pivot lies between bounds for the parameter

---

## The Chi-squared distribution

- Suppose that $S^2$ is the sample variance from a collection of iid $N(\mu,\sigma^2)$ data; then 
$$
    \frac{(n - 1) S^2}{\sigma^2} \sim \chi^2_{n-1}
$$
which reads: follows a Chi-squared distribution with $n-1$ degrees of freedom
- The Chi-squared distribution is skewed and has support on $0$ to $\infty$
- The mean of the Chi-squared is its degrees of freedom 
- The variance of the Chi-squared distribution is twice the degrees of freedom

---

## Confidence interval for the variance

Note that if $\chi^2_{n-1, \alpha}$ is the $\alpha$ quantile of the
Chi-squared distribution then

$$
\begin{eqnarray*}
  1 - \alpha & = & P \left( \chi^2_{n-1, \alpha/2} \leq  \frac{(n - 1) S^2}{\sigma^2} \leq  \chi^2_{n-1,1 - \alpha/2} \right) \\ \\
& = &  P\left(\frac{(n-1)S^2}{\chi^2_{n-1,1-\alpha/2}} \leq \sigma^2 \leq 
\frac{(n-1)S^2}{\chi^2_{n-1,\alpha/2}} \right) \\
\end{eqnarray*}
$$
So that 
$$
\left[\frac{(n-1)S^2}{\chi^2_{n-1,1-\alpha/2}}, \frac{(n-1)S^2}{\chi^2_{n-1,\alpha/2}}\right]
$$
is a $100(1-\alpha)\%$ confidence interval for $\sigma^2$

---

## Notes about this interval

- This interval relies heavily on the assumed normality
- Square-rooting the endpoints yields a CI for $\sigma$

---
## Example
### Confidence interval for the standard deviation of sons' heights from Galton's data

```r
library(UsingR)
data(father.son)
x <- father.son$sheight
s <- sd(x)
n <- length(x)
round(sqrt((n - 1) * s^2/qchisq(c(0.975, 0.025), n - 1)), 3)
```

```
## [1] 2.701 2.939
```


---

## Gosset's $t$ distribution

- Invented by William Gosset (under the pseudonym "Student") in 1908
- Has thicker tails than the normal
- Is indexed by a degrees of freedom; gets more like a standard normal as df gets larger
- Is obtained as 
$$
\frac{Z}{\sqrt{\frac{\chi^2}{df}}}
$$
where $Z$ and $\chi^2$ are independent standard normals and
Chi-squared distributions respectively

---

## Result

- Suppose that $(X_1,\ldots,X_n)$ are iid $N(\mu,\sigma^2)$, then:
  a. $\frac{\bar X - \mu}{\sigma / \sqrt{n}}$ is standard normal
  b. $\sqrt{\frac{(n - 1) S^2}{\sigma^2 (n - 1)}} = S / \sigma$ is the square root of a Chi-squared divided by its df

- Therefore 
$$
\frac{\frac{\bar X - \mu}{\sigma /\sqrt{n}}}{S/\sigma}  
= \frac{\bar X - \mu}{S/\sqrt{n}}
$$
    follows Gosset's $t$ distribution with $n-1$ degrees of freedom

---

## Confidence intervals for the mean

- Notice that the $t$ statistic is a pivot, therefore we use it to create a confidence interval for $\mu$
- Let $t_{df,\alpha}$ be the $\alpha^{th}$ quantile of the t distribution with $df$ degrees of freedom
$$
  \begin{eqnarray*}
&   & 1 - \alpha \\
& = & P\left(-t_{n-1,1-\alpha/2} \leq \frac{\bar X - \mu}{S/\sqrt{n}} \leq t_{n-1,1-\alpha/2}\right) \\ \\
& = & P\left(\bar X - t_{n-1,1-\alpha/2} S / \sqrt{n} \leq \mu  
      \leq \bar X + t_{n-1,1-\alpha/2}S /\sqrt{n}\right)
  \end{eqnarray*}
$$
- Interval is $\bar X \pm t_{n-1,1-\alpha/2} S/\sqrt{n}$

---

## Note's about the $t$ interval

- The $t$ interval technically assumes that the data are iid normal, though it is robust to this assumption
- It works well whenever the distribution of the data is roughly symmetric and mound shaped
- Paired observations are often analyzed using the $t$ interval by taking differences
- For large degrees of freedom, $t$ quantiles become the same as standard normal quantiles; therefore this interval converges to the same interval as the CLT yielded
- For skewed distributions, the spirit of the $t$ interval assumptions are violated
- Also, for skewed distributions, it doesn't make a lot of sense to center the interval at the mean
- In this case, consider taking logs or using a different summary like the median
- For highly discrete data, like binary, other intervals are available

---

## Sleep data

In R typing `data(sleep)` brings up the sleep data originally
analyzed in Gosset's Biometrika paper, which shows the increase in
hours for 10 patients on two soporific drugs. R treats the data as two
groups rather than paired.

---
## The data

```r
data(sleep)
head(sleep)
```

```
##   extra group ID
## 1   0.7     1  1
## 2  -1.6     1  2
## 3  -0.2     1  3
## 4  -1.2     1  4
## 5  -0.1     1  5
## 6   3.4     1  6
```


---

```r
g1 <- sleep$extra[1:10]
g2 <- sleep$extra[11:20]
difference <- g2 - g1
mn <- mean(difference)
s <- sd(difference)
n <- 10
mn + c(-1, 1) * qt(0.975, n - 1) * s/sqrt(n)
```

```
## [1] 0.7001 2.4599
```

```r
t.test(difference)$conf.int
```

```
## [1] 0.7001 2.4599
## attr(,"conf.level")
## [1] 0.95
```

## Likelihood

- A common and fruitful approach to statistics is to assume that the data arises from a family of distributions indexed by a parameter that represents a useful summary of the distribution
- The **likelihood** of a collection of data is the joint density evaluated as a function of the parameters with the data fixed
- Likelihood analysis of data uses the likelihood to perform inference regarding the unknown parameter

---

## Likelihood

Given a statistical probability mass function or density, say $f(x, \theta)$, where $\theta$ is an unknown parameter, the **likelihood** is $f$ viewed as a function of $\theta$ for a fixed, observed value of $x$. 

---

## Interpretations of likelihoods

The likelihood has the following properties:

1. Ratios of likelihood values measure the relative evidence of one value of the unknown parameter to another.
2. Given a statistical model and observed data, all of the relevant information contained in the data regarding the unknown parameter is contained in the likelihood.
3. If $\{X_i\}$ are independent random variables, then their likelihoods multiply.  That is, the likelihood of the parameters given all of the $X_i$ is simply the product of the individual likelihoods.

---

## Example

- Suppose that we flip a coin with success probability $\theta$
- Recall that the mass function for $x$
  $$
  f(x,\theta) = \theta^x(1 - \theta)^{1 - x}  ~~~\mbox{for}~~~ \theta \in [0,1].
  $$
  where $x$ is either $0$ (Tails) or $1$ (Heads) 
- Suppose that the result is a head
- The likelihood is
  $$
  {\cal L}(\theta, 1) = \theta^1 (1 - \theta)^{1 - 1} = \theta  ~~~\mbox{for} ~~~ \theta \in [0,1].
  $$
- Therefore, ${\cal L}(.5, 1) / {\cal L}(.25, 1) = 2$, 
- There is twice as much evidence supporting the hypothesis that $\theta = .5$ to the hypothesis that $\theta = .25$

---

## Example continued

- Suppose now that we flip our coin from the previous example 4 times and get the sequence 1, 0, 1, 1
- The likelihood is:
$$
  \begin{eqnarray*}
  {\cal L}(\theta, 1,0,1,1) & = & \theta^1 (1 - \theta)^{1 - 1}
  \theta^0 (1 - \theta)^{1 - 0}  \\
& \times & \theta^1 (1 - \theta)^{1 - 1} 
   \theta^1 (1 - \theta)^{1 - 1}\\
& = &  \theta^3(1 - \theta)^1
  \end{eqnarray*}
$$
- This likelihood only depends on the total number of heads and the total number of tails; we might write ${\cal L}(\theta, 1, 3)$ for shorthand
- Now consider ${\cal L}(.5, 1, 3) / {\cal L}(.25, 1, 3) = 5.33$
- There is over five times as much evidence supporting the hypothesis that $\theta = .5$ over that $\theta = .25$

---

## Plotting likelihoods

- Generally, we want to consider all the values of $\theta$ between 0 and 1
- A **likelihood plot** displays $\theta$ by ${\cal L}(\theta,x)$
- Because the likelihood measures *relative evidence*, dividing the curve by its maximum value (or any other value for that matter) does not change its interpretation

---

```r
pvals <- seq(0, 1, length = 1000)
plot(pvals, dbinom(3, 4, pvals) / dbinom(3, 4, 3/4), type = "l", frame = FALSE, lwd = 3, xlab = "p", ylab = "likelihood / max likelihood")
```

<div class="rimage center"><img src="fig/unnamed-chunk-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" class="plot" /></div>



---

## Maximum likelihood

- The value of $\theta$ where the curve reaches its maximum has a special meaning
- It is the value of $\theta$ that is most well supported by the data
- This point is called the **maximum likelihood estimate** (or MLE) of $\theta$
  $$
  MLE = \mathrm{argmax}_\theta {\cal L}(\theta, x).
  $$
- Another interpretation of the MLE is that it is the value of $\theta$ that would make the data that we observed most probable

---
## Some results
* $X_1, \ldots, X_n \stackrel{iid}{\sim} N(\mu, \sigma^2)$ the MLE of $\mu$ is $\bar X$ and the ML of $\sigma^2$ is the biased sample variance estimate.
* If $X_1,\ldots, X_n \stackrel{iid}{\sim} Bernoulli(p)$ then the MLE of $p$ is $\bar X$ (the sample proportion of 1s).
* If $X_i \stackrel{iid}{\sim} Binomial(n_i, p)$ then the MLE of $p$ is $\frac{\sum_{i=1}^n X_i}{\sum_{i=1}^n n_i}$ (the sample proportion of 1s).
* If $X \stackrel{iid}{\sim} Poisson(\lambda t)$ then the MLE of $\lambda$ is $X/t$.
* If $X_i \stackrel{iid}{\sim} Poisson(\lambda t_i)$ then the MLE of $\lambda$ is
  $\frac{\sum_{i=1}^n X_i}{\sum_{i=1}^n t_i}$

---
## Example
* You saw 5 failure events per 94 days of monitoring a nuclear pump. 
* Assuming Poisson, plot the likelihood

---

```r
lambda <- seq(0, .2, length = 1000)
likelihood <- dpois(5, 94 * lambda) / dpois(5, 5)
plot(lambda, likelihood, frame = FALSE, lwd = 3, type = "l", xlab = expression(lambda))
lines(rep(5/94, 2), 0 : 1, col = "red", lwd = 3)
lines(range(lambda[likelihood > 1/16]), rep(1/16, 2), lwd = 2)
lines(range(lambda[likelihood > 1/8]), rep(1/8, 2), lwd = 2)
```

<div class="rimage center"><img src="fig/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" class="plot" /></div>


## Bayesian analysis
- Bayesian statistics posits a *prior* on the parameter
  of interest
- All inferences are then performed on the distribution of 
  the parameter given the data, called the posterior
- In general,
  $$
  \mbox{Posterior} \propto \mbox{Likelihood} \times \mbox{Prior}
  $$
- Therefore (as we saw in diagnostic testing) the likelihood is
  the factor by which our prior beliefs are updated to produce
  conclusions in the light of the data

---
## Prior specification
- The beta distribution is the default prior
  for parameters between $0$ and $1$.
- The beta density depends on two parameters $\alpha$ and $\beta$
$$
\frac{\Gamma(\alpha +  \beta)}{\Gamma(\alpha)\Gamma(\beta)}
 p ^ {\alpha - 1} (1 - p) ^ {\beta - 1} ~~~~\mbox{for} ~~ 0 \leq p \leq 1
$$
- The mean of the beta density is $\alpha / (\alpha + \beta)$
- The variance of the beta density is 
$$\frac{\alpha \beta}{(\alpha + \beta)^2 (\alpha + \beta + 1)}$$
- The uniform density is the special case where $\alpha = \beta = 1$

---

```
## Exploring the beta density
library(manipulate)
pvals <- seq(0.01, 0.99, length = 1000)
manipulate(
    plot(pvals, dbeta(pvals, alpha, beta), type = "l", lwd = 3, frame = FALSE),
    alpha = slider(0.01, 10, initial = 1, step = .5),
    beta = slider(0.01, 10, initial = 1, step = .5)
    )
```

---
## Posterior 
- Suppose that we chose values of $\alpha$ and $\beta$ so that
  the beta prior is indicative of our degree of belief regarding $p$
  in the absence of data
- Then using the rule that
  $$
  \mbox{Posterior} \propto \mbox{Likelihood} \times \mbox{Prior}
  $$
  and throwing out anything that doesn't depend on $p$, we have that
$$
\begin{align}
\mbox{Posterior} &\propto  p^x(1 - p)^{n-x} \times p^{\alpha -1} (1 - p)^{\beta - 1} \\
                 &  =      p^{x + \alpha - 1} (1 - p)^{n - x + \beta - 1}
\end{align}
$$
- This density is just another beta density with parameters
  $\tilde \alpha = x + \alpha$ and $\tilde \beta = n - x + \beta$


---
## Posterior mean

$$
\begin{align}
E[p ~|~ X] & =   \frac{\tilde \alpha}{\tilde \alpha + \tilde \beta}\\ \\
& =  \frac{x + \alpha}{x + \alpha + n - x + \beta}\\ \\
& =  \frac{x + \alpha}{n + \alpha + \beta} \\ \\
& =  \frac{x}{n} \times \frac{n}{n + \alpha + \beta} + \frac{\alpha}{\alpha + \beta} \times \frac{\alpha + \beta}{n + \alpha + \beta} \\ \\
& =  \mbox{MLE} \times \pi + \mbox{Prior Mean} \times (1 - \pi)
\end{align}
$$

---
## Thoughts

- The posterior mean is a mixture of the MLE ($\hat p$) and the
  prior mean
- $\pi$ goes to $1$ as $n$ gets large; for large $n$ the data swamps the prior
- For small $n$, the prior mean dominates 
- Generalizes how science should ideally work; as data becomes
  increasingly available, prior beliefs should matter less and less
- With a prior that is degenerate at a value, no amount of data
  can overcome the prior

---
## Example

- Suppose that in a random sample of an at-risk population
$13$ of $20$ subjects had hypertension. Estimate the prevalence
of hypertension in this population.
- $x = 13$ and $n=20$
- Consider a uniform prior, $\alpha = \beta = 1$
- The posterior is proportional to (see formula above)
$$
p^{x + \alpha - 1} (1 - p)^{n - x + \beta - 1} = p^x (1 - p)^{n-x}
$$
That is, for the uniform prior, the posterior is the likelihood
- Consider the instance where $\alpha = \beta = 2$ (recall this prior
is humped around the point $.5$) the posterior is
$$
p^{x + \alpha - 1} (1 - p)^{n - x + \beta - 1} = p^{x + 1} (1 - p)^{n-x + 1}
$$
- The "Jeffrey's prior" which has some theoretical benefits
  puts $\alpha = \beta = .5$

---
```
pvals <- seq(0.01, 0.99, length = 1000)
x <- 13; n <- 20
myPlot <- function(alpha, beta){
    plot(0 : 1, 0 : 1, type = "n", xlab = "p", ylab = "", frame = FALSE)
    lines(pvals, dbeta(pvals, alpha, beta) / max(dbeta(pvals, alpha, beta)), 
            lwd = 3, col = "darkred")
    lines(pvals, dbinom(x,n,pvals) / dbinom(x,n,x/n), lwd = 3, col = "darkblue")
    lines(pvals, dbeta(pvals, alpha+x, beta+(n-x)) / max(dbeta(pvals, alpha+x, beta+(n-x))),
        lwd = 3, col = "darkgreen")
    title("red=prior,green=posterior,blue=likelihood")
}
manipulate(
    myPlot(alpha, beta),
    alpha = slider(0.01, 10, initial = 1, step = .5),
    beta = slider(0.01, 10, initial = 1, step = .5)
    )
```

---
## Credible intervals
- A Bayesian credible interval is the  Bayesian analog of a confidence
  interval
- A $95\%$ credible interval, $[a, b]$ would satisfy
  $$
  P(p \in [a, b] ~|~ x) = .95
  $$
- The best credible intervals chop off the posterior with a horizontal
  line in the same way we did for likelihoods 
- These are called highest posterior density (HPD) intervals

---
## Getting HPD intervals for this example
- Install the \texttt{binom} package, then the command

```r
library(binom)
binom.bayes(13, 20, type = "highest")
```

```
  method  x  n shape1 shape2   mean  lower  upper  sig
1  bayes 13 20   13.5    7.5 0.6429 0.4423 0.8361 0.05
```

gives the HPD interval. 
- The default credible level is $95\%$ and
the default prior is the Jeffrey's prior.

---
```
pvals <- seq(0.01, 0.99, length = 1000)
x <- 13; n <- 20
myPlot2 <- function(alpha, beta, cl){
    plot(pvals, dbeta(pvals, alpha+x, beta+(n-x)), type = "l", lwd = 3,
    xlab = "p", ylab = "", frame = FALSE)
    out <- binom.bayes(x, n, type = "highest", 
        prior.shape1 = alpha, 
        prior.shape2 = beta, 
        conf.level = cl)
    p1 <- out$lower; p2 <- out$upper
    lines(c(p1, p1, p2, p2), c(0, dbeta(c(p1, p2), alpha+x, beta+(n-x)), 0), 
        type = "l", lwd = 3, col = "darkred")
}
manipulate(
    myPlot2(alpha, beta, cl),
    alpha = slider(0.01, 10, initial = 1, step = .5),
    beta = slider(0.01, 10, initial = 1, step = .5),
    cl = slider(0.01, 0.99, initial = 0.95, step = .01)
    )
```




