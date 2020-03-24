+++
title = "BIOL 297: Schedule for week of March 23-27"

date = 2020-03-23T00:00:00
lastmod = 2020-03-24T00:13:18
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "teaching"]
summary = "BIOL/BOT 297 schedule for March 23-27"
+++

## Summary

This will be our first week of class completely online. Please be patient and flexible; I will do likewise. Please let me know if you are having issues learning remotely so we can address problems right away. This schedule is tentative and subject to change.

## Assignments:

* Complete any remaining labs 1--6 by Tuesday if you still want credit

* There will be a mini-lab assignment on analyzing proportions in *R* due by next Tuesday.

## Readings:

* Whitlock & Schluter, Chapter 7: Analyzing proportions

## Schedule

Note that on Tuesday, class will meet synchronously on Google Meet [meet.google.com/foi-xwhi-ape](https://meet.google.com/foi-xwhi-ape). Class will be recorded and posted online if you are unable to attend. Remaining instruction will be asynchronous, meaning you can work at your own pace and desired time.

In general, I strongly recommend attending synchronous meetings if you can. I also recommend establishing routine times that you work on asynchronous assignments. A routine will help you develop good work habits, keep you engaged in the class, and prevent you from having to cram later.

### Tuesday, March 24

* Go over Midterm Exam 2

* We will introduce Analysis of Proportions

* Address questions and concerns about online instruction

* *Read* chapter 7 from textbook

* *Watch* pre-recorded lecture by a friend of mine, Dr. Yaniv Brandvain: https://www.youtube.com/watch?v=5B7wGrgpioQ&feature=youtu.be

This lecture covers tests of proportion data. Yaniv teaches a similar class at University of Minnesota and uses the same textbook. You only need to watch through 21:48. The material after that is more advanced, so you are welcome to continue watching, but it's not material we'll cover in this class.

#### Code demo from class:

```{r, echo = TRUE, eval = FALSE}

# Demonstrate binomial test in R

# Load libraries
library(dplyr)
library(ggplot2)

# 1. State H_0 and H_A ----
#
# H_0: The probability that a spermatogenesis gene falls on the X chromosome is p = 0.061
# H_A: The probability that a spermatogenesis gene falls on the X chromosome is something other than 0.061 (p != 0.061)

p_0 <- 0.061 # p_0 is p under the null hypothesis

# 2. Calculate a test statistic ----

n_X <- 10 # successes: number of spermatogenesis genes on the X
n_total <- 25 # trials: total number of spermatogenesis genes

test_stat <- n_X # for binomial test, test statistic is number of successes

# 3. Generate the null distribution ----

# For the the binomial test, the sampling distribution under the null hypothesis is the Binomial distribution with n trials and p = p_0 (the proportion under the null hypothesis)

sampling_dist <- data.frame(Successes = 0:n_total)
sampling_dist$Probability <- 
  dbinom(
    x = sampling_dist$Successes, 
    size = n_total,
    p = p_0
  )

sampling_dist

p <- ggplot(sampling_dist, aes(Successes, Probability)) +
  geom_col(fill = "tomato") +
  theme_bw()

p

p + geom_vline(xintercept = test_stat, size = 2)

# 4. Find a critical value at specified alpha ----

alpha <- 0.05 # could change this depending on desired Type I error rate
qbinom(
  p = alpha,
  size = n_total,
  prob = p_0,
  # lower.tail because we are more interested in excess of X-linked genes
  lower.tail = FALSE
)

# Critical value is 4, but we observe 10, so we know this is unlikely under the null hypothesis. How unlikely?

# 5. Find the *P*-value

# Multiply by 2 to for two-tailed test

P_value <- 2 * pbinom(
  # subtract 1 because we want probability of greater than OR equal to test_stat
  q = test_stat - 1, 
  size = n_total,
  prob = p_0,
  lower.tail = FALSE
)

P_value

# 6. Decide

# Reject H_0 because P < alpha
P_value < alpha

```


### Thursday, March 26

Kuhio day - no class

### On your own

Since there is no official lab this week because of Kuhio day, we will have a mini-Lab 7 on Proportions in *R*! I will notify when I post this. The lab structure will be similar to previous labs, but it will be more of an assignment to give you practice analyzing proportions. 
