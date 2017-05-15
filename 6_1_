# Introduction_Statistical Inference
## Statistical inference defined

Statistical inference is the process of drawing formal conclusions from
data. 

In our class, we wil define formal statistical inference as settings where one wants to infer facts about a population using noisy
statistical data where uncertainty must be accounted for.

---

## Motivating example: who's going to win the election?

In every major election, pollsters would like to know, ahead of the
actual election, who's going to win. Here, the target of
estimation (the estimand) is clear, the percentage of people in 
a particular group (city, state, county, country or other electoral
grouping) who will vote for each candidate.

We can not poll everyone. Even if we could, some polled 
may change their vote by the time the election occurs.
How do we collect a reasonable subset of data and quantify the
uncertainty in the process to produce a good guess at who will win?

---

## Motivating example: is hormone replacement therapy effective? 

A large clinical trial (the Women’s Health Initiative) published results in 2002 that contradicted prior evidence on the efficacy of hormone replacement therapy for post menopausal women and suggested a negative impact of HRT for several key health outcomes. **Based on a statistically based protocol, the study was stopped early due an excess number of negative events.**

Here's there's two inferential problems. 

1. Is HRT effective?
2. How long should we continue the trial in the presence of contrary
evidence?

See WHI writing group paper JAMA 2002, Vol 288:321 - 333. for the paper and Steinkellner et al. Menopause 2012, Vol 19:616 621 for adiscussion of the long term impacts

---

## Motivating example: ECMO

In 1985 a group at a major neonatal intensive care center published the results of a trial comparing a standard treatment and a promising new extracorporeal membrane oxygenation treatment (ECMO) for newborn infants with severe respiratory failure. **Ethical considerations lead to a statistical randomization scheme whereby one infant received the control therapy, thereby opening the study to sample-size based criticisms.**

For a review and statistical discussion, see Royall Statistical Science 1991, Vol 6, No. 1, 52-88

---

## Summary

- These examples illustrate many of the difficulties of trying
to use data to create general conclusions about a population.
- Paramount among our concerns are:
  - Is the sample representative of the population that we'd like to draw inferences about?
  - Are there known and observed, known and unobserved or unknown and unobserved variables that contaminate our conclusions?
  - Is there systematic bias created by missing data or the design or conduct of the study?
  - What randomness exists in the data and how do we use or adjust for it? Here randomness can either be explicit via randomization
or random sampling, or implicit as the aggregation of many complex uknown processes.
  - Are we trying to estimate an underlying mechanistic model of phenomena under study?
- Statistical inference requires navigating the set of assumptions and
tools and subsequently thinking about how to draw conclusions from data.

--- 
## Example goals of inference

1. Estimate and quantify the uncertainty of an estimate of 
a population quantity (the proportion of people who will
  vote for a candidate).
2. Determine whether a population quantity 
  is a benchmark value ("is the treatment effective?").
3. Infer a mechanistic relationship when quantities are measured with
  noise ("What is the slope for Hooke's law?")
4. Determine the impact of a policy? ("If we reduce polution levels,
  will asthma rates decline?")


---
## Example tools of the trade 

1. Randomization: concerned with balancing unobserved variables that may confound inferences of interest
2. Random sampling: concerned with obtaining data that is representative 
of the population of interest
3. Sampling models: concerned with creating a model for the sampling
process, the most common is so called "iid".
4. Hypothesis testing: concerned with decision making in the presence of uncertainty
5. Confidence intervals: concerned with quantifying uncertainty in 
estimation
6. Probability models: a formal connection between the data and a population of interest. Often probability models are assumed or are
approximated.
7. Study design: the process of designing an experiment to minimize biases and variability.
8. Nonparametric bootstrapping: the process of using the data to,
  with minimal probability model assumptions, create inferences.
9. Permutation, randomization and exchangeability testing: the process 
of using data permutations to perform inferences.

---
## Different thinking about probability leads to different styles of inference

We won't spend too much time talking about this, but there are several different
styles of inference. Two broad categories that get discussed a lot are:

1. Frequency probability: is the long run proportion of
 times an event occurs in independent, identically distributed 
 repetitions.
2. Frequency inference: uses frequency interpretations of probabilities
to control error rates. Answers questions like "What should I decide
given my data controlling the long run proportion of mistakes I make at
a tolerable level."
3. Bayesian probability: is the probability calculus of beliefs, given that beliefs follow certain rules.
4. Bayesian inference: the use of Bayesian probability representation
of beliefs to perform inference. Answers questions like "Given my subjective beliefs and the objective information from the data, what
should I believe now?"

Data scientists tend to fall within shades of gray of these and various other schools of inference. 

---
## In this class

* In this class, we will primarily focus on basic sampling models, 
basic probability models and frequency style analyses
to create standard inferences. 
* Being data scientists,  we will also consider some inferential strategies that  rely heavily on the observed data, such as permutation testing
and bootstrapping.
* As probability modeling will be our starting point, we first build
up basic probability.

---
## Where to learn more on the topics not covered

1. Explicit use of random sampling in inferences: look in references
on "finite population statistics". Used heavily in polling and
sample surveys.
2. Explicit use of randomization in inferences: look in references
on "causal inference" especially in clinical trials.
3. Bayesian probability and Bayesian statistics: look for basic itroductory books (there are many).
4. Missing data: well covered in biostatistics and econometric
references; look for references to "multiple imputation", a popular tool for
addressing missing data.
5. Study design: consider looking in the subject matter area that
  you are interested in; some examples with rich histories in design:
  1. The epidemiological literature is very focused on using study design to investigate public health.
  2. The classical development of study design in agriculture broadly covers design and design principles.
  3. The industrial quality control literature covers design thoroughly.
 
# Probability

## Notation

- The **sample space**, $\Omega$, is the collection of possible outcomes of an experiment
  - Example: die roll $\Omega = \{1,2,3,4,5,6\}$
- An **event**, say $E$, is a subset of $\Omega$ 
  - Example: die roll is even $E = \{2,4,6\}$
- An **elementary** or **simple** event is a particular result
  of an experiment
  - Example: die roll is a four, $\omega = 4$
- $\emptyset$ is called the **null event** or the **empty set**

---

## Interpretation of set operations

Normal set operations have particular interpretations in this setting

1. $\omega \in E$ implies that $E$ occurs when $\omega$ occurs
2. $\omega \not\in E$ implies that $E$ does not occur when $\omega$ occurs
3. $E \subset F$ implies that the occurrence of $E$ implies the occurrence of $F$
4. $E \cap F$  implies the event that both $E$ and $F$ occur
5. $E \cup F$ implies the event that at least one of $E$ or $F$ occur
6. $E \cap F=\emptyset$ means that $E$ and $F$ are **mutually exclusive**, or cannot both occur
7. $E^c$ or $\bar E$ is the event that $E$ does not occur

---

## Probability

A **probability measure**, $P$, is a function from the collection of possible events so that the following hold

1. For an event $E\subset \Omega$, $0 \leq P(E) \leq 1$
2. $P(\Omega) = 1$
3. If $E_1$ and $E_2$ are mutually exclusive events
  $P(E_1 \cup E_2) = P(E_1) + P(E_2)$.

Part 3 of the definition implies **finite additivity**

$$
P(\cup_{i=1}^n A_i) = \sum_{i=1}^n P(A_i)
$$
where the $\{A_i\}$ are mutually exclusive. (Note a more general version of
additivity is used in advanced classes.)


---


## Example consequences

- $P(\emptyset) = 0$
- $P(E) = 1 - P(E^c)$
- $P(A \cup B) = P(A) + P(B) - P(A \cap B)$
- if $A \subset B$ then $P(A) \leq P(B)$
- $P\left(A \cup B\right) = 1 - P(A^c \cap B^c)$
- $P(A \cap B^c) = P(A) - P(A \cap B)$
- $P(\cup_{i=1}^n E_i) \leq \sum_{i=1}^n P(E_i)$
- $P(\cup_{i=1}^n E_i) \geq \max_i P(E_i)$

---

## Example

The National Sleep Foundation ([www.sleepfoundation.org](http://www.sleepfoundation.org/)) reports that around 3% of the American population has sleep apnea. They also report that around 10% of the North American and European population has restless leg syndrome. Does this imply that 13% of people will have at least one sleep problems of these sorts?

---

## Example continued

Answer: No, the events are not mutually exclusive. To elaborate let:

$$
\begin{eqnarray*}
    A_1 & = & \{\mbox{Person has sleep apnea}\} \\
    A_2 & = & \{\mbox{Person has RLS}\} 
  \end{eqnarray*}
$$

Then 

$$
\begin{eqnarray*}
    P(A_1 \cup A_2 ) & = & P(A_1) + P(A_2) - P(A_1 \cap A_2) \\
   & = & 0.13 - \mbox{Probability of having both}
  \end{eqnarray*}
$$
Likely, some fraction of the population has both.

---

## Random variables

- A **random variable** is a numerical outcome of an experiment.
- The random variables that we study will come in two varieties,
  **discrete** or **continuous**.
- Discrete random variable are random variables that take on only a
countable number of possibilities.
  * $P(X = k)$
- Continuous random variable can take any value on the real line or some subset of the real line.
  * $P(X \in A)$

---

## Examples of variables that can be thought of as random variables

- The $(0-1)$ outcome of the flip of a coin
- The outcome from the roll of a die
- The BMI of a subject four years after a baseline measurement
- The hypertension status of a subject randomly drawn from a population

---

## PMF

A probability mass function evaluated at a value corresponds to the
probability that a random variable takes that value. To be a valid
pmf a function, $p$, must satisfy

  1. $p(x) \geq 0$ for all $x$
  2. $\sum_{x} p(x) = 1$

The sum is taken over all of the possible values for $x$.

---

## Example

Let $X$ be the result of a coin flip where $X=0$ represents
tails and $X = 1$ represents heads.
$$
p(x) = (1/2)^{x} (1/2)^{1-x} ~~\mbox{ for }~~x = 0,1
$$
Suppose that we do not know whether or not the coin is fair; Let
$\theta$ be the probability of a head expressed as a proportion
(between 0 and 1).
$$
p(x) = \theta^{x} (1 - \theta)^{1-x} ~~\mbox{ for }~~x = 0,1
$$

---

## PDF

A probability density function (pdf), is a function associated with
a continuous random variable 

  *Areas under pdfs correspond to probabilities for that random variable*

To be a valid pdf, a function $f$ must satisfy

1. $f(x) \geq 0$ for all $x$

2. The area under $f(x)$ is one.

---
## Example

Suppose that the proportion of help calls that get addressed in
a random day by a help line is given by
$$
f(x) = \left\{\begin{array}{ll}
    2 x & \mbox{ for } 1 > x > 0 \\
    0                 & \mbox{ otherwise} 
\end{array} \right. 
$$

Is this a mathematically valid density?

---


```r
x <- c(-0.5, 0, 1, 1, 1.5)
y <- c(0, 0, 2, 0, 0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")
```

![plot of chunk unnamed-chunk-1](assets/fig/unnamed-chunk-1.png) 


---

## Example continued

What is the probability that 75% or fewer of calls get addressed?

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 


---

```r
1.5 * 0.75/2
```

```
## [1] 0.5625
```

```r
pbeta(0.75, 2, 1)
```

```
## [1] 0.5625
```

---

## CDF and survival function

- The **cumulative distribution function** (CDF) of a random variable $X$ is defined as the function 
$$
F(x) = P(X \leq x)
$$
- This definition applies regardless of whether $X$ is discrete or continuous.
- The **survival function** of a random variable $X$ is defined as
$$
S(x) = P(X > x)
$$
- Notice that $S(x) = 1 - F(x)$
- For continuous random variables, the PDF is the derivative of the CDF

---

## Example

What are the survival function and CDF from the density considered before?

For $1 \geq x \geq 0$
$$
F(x) = P(X \leq x) = \frac{1}{2} Base \times Height = \frac{1}{2} (x) \times (2 x) = x^2
$$

$$
S(x) = 1 - x^2
$$


```r
pbeta(c(0.4, 0.5, 0.6), 2, 1)
```

```
## [1] 0.16 0.25 0.36
```


---

## Quantiles

- The  $\alpha^{th}$ **quantile** of a distribution with distribution function $F$ is the point $x_\alpha$ so that
$$
F(x_\alpha) = \alpha
$$
- A **percentile** is simply a quantile with $\alpha$ expressed as a percent
- The **median** is the $50^{th}$ percentile

---
## Example
- We want to solve $0.5 = F(x) = x^2$
- Resulting in the solution 

```r
sqrt(0.5)
```

```
## [1] 0.7071
```

- Therefore, about 0.7071 of calls being answered on a random day is the median.
- R can approximate quantiles for you for common distributions


```r
qbeta(0.5, 2, 1)
```

```
## [1] 0.7071
```


---

## Summary

- You might be wondering at this point "I've heard of a median before, it didn't require integration. Where's the data?"
- We're referring to are **population quantities**. Therefore, the median being
  discussed is the **population median**.
- A probability model connects the data to the population using assumptions.
- Therefore the median we're discussing is the **estimand**, the sample median will be the **estimator**

