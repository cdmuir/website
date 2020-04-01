+++
title = "BIOL 297: Schedule for week of March 30-April 3"

date = 2020-03-30T00:00:00
lastmod = 2020-04-01T9:43:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "biostats", "frequency data", "teaching"]
summary = "BIOL/BOT 297 schedule for March 30-April 3"
+++

## Assignments:

* There will be a regular lab assignment on analyzing frequency data in *R* due by next Tuesday.

## Readings:

* Whitlock & Schluter, Chapter 8: Fitting Probability Models to Frequency Data

## Schedule

Note that on Tuesday, class will meet synchronously on Google Meet [meet.google.com/foi-xwhi-ape](https://meet.google.com/foi-xwhi-ape). Class will be recorded and posted online if you are unable to attend. Remaining instruction will be asynchronous, meaning you can work at your own pace and desired time.

In general, I strongly recommend attending synchronous meetings if you can. I also recommend establishing routine times that you work on asynchronous assignments. A routine will help you develop good work habits, keep you engaged in the class, and prevent you from having to cram later.

### Tuesday, March 31

* Join Google Meeting at 12 [meet.google.com/vhq-qczv-dew](https://meet.google.com/vhq-qczv-dew)

* Address questions about last week's mini-lab

* We will introduce *Fitting Probability Models to Frequency Data* using $\chi^2$-tests

* Go over class project

* *Read* chapter 8 from textbook

* *Watch* pre-recorded lecture by a friend of mine, Dr. Yaniv Brandvain:

{{< youtube 2d4rleMG9Uk >}}

This lecture covers tests of frequency data. You only need to watch through 24:00. The material after that is more advanced, so you are welcome to continue watching, but it's not material we'll cover in this class.

*R* Code demo on $\chi^2$ goodness-of-fit test

```{r}
# Demonstrate chi-squared goodness-of-fit test in R

# Load libraries
library(dplyr)
library(ggplot2)

# 1. State H_0 and H_A ----
#
# H_0: Population is in Hardy-Weinberg equilibrium.

# Frequencies are:
# Ho- Ho-: N * p^2
# Ho+ Ho-: N * 2 * p * q
# Ho+ Ho+: N * q ^ 2
# Note that q = 1 - p

# These will go into our "expected" frequency column below.

# H_A: Population is not in Hardy-Weinberg equilibrium.

N <- 200 # Number of individuals sampled
p <- 0.7 # Proportion of small-horned alleles in the population
q <- 1 - p # Proportion of large-horned alleles in the population
soaysheep <- data.frame(
  geno = c("homozygous_small", "heterzygous", "homozygous_large"),
  observed = c(90, 100, 10),
  expected = N * c(p ^ 2, 2 * p * q, q ^ 2)
)

# 2. Calculate a test statistic ----

# The chi-square test statistic.
# Make a column called 'chisq' with (Observed - Expected) ^ 2 / Expected
soaysheep$chisq <- (soaysheep$observed - soaysheep$expected) ^ 2 / soaysheep$expected

# Then sum to get test statistic
test_stat <- sum(soaysheep$chisq)

# 3. Generate the null distribution ----

# For the the chi-squared test, the sampling distribution under the null hypothesis is the chi-squared distribution with M-1, where M is the number of genotypes

M <- nrow(soaysheep)
sampling_dist <- data.frame(chisq = seq(0, 10, 0.01))
sampling_dist$Probability <- 
  dchisq(
    x = sampling_dist$chisq, 
    df = M - 1
  )

sampling_dist

gp <- ggplot(sampling_dist, aes(chisq, Probability)) +
  geom_area(fill = "tomato", color = "black") +
  xlab(expression(chi^2)) +
  theme_bw()

gp

gp + geom_vline(xintercept = test_stat, size = 2)

# 4. Find a critical value at specified alpha ----

alpha <- 0.05 # could change this depending on desired Type I error rate
qchisq(
  p = alpha,
  df = M - 1,
  # lower.tail because we are only interested in whether there's more deviation between observed and expected
  lower.tail = FALSE
)

# Critical value is ~6, but we observe 7.25

# 5. Find the P-value

# Don't multiply by 2 for one-tailed test

P_value <- pchisq(
  q = test_stat, 
  df = M - 1,
  lower.tail = FALSE
)

P_value

# 6. Decide ---

# Reject H_0 because P < alpha
P_value < alpha
```

### Thursday, April 3

* Lab on Frequency data in *R* (I will post by Wednesday)

* Join Google Meeting at 12 [meet.google.com/vhq-qczv-dew](https://meet.google.com/vhq-qczv-dew)

