+++
title = "BIOL 297: Schedule for week of April 20-24"

date = 2020-04-20T00:00:00
lastmod = 2020-04-21T12:45:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "biostats", "t-test", "teaching"]
summary = "t-tests!"
+++

## Assignments:

* There will be a regular lab assignment on the normal distribution in *R* due by next Tuesday.

* **Friday, April 24**: Get all data you will need to complete final project

## Readings:

* Whitlock & Schluter, Chapter 11: Inference from a normal population

## Schedule

### Tuesday, April 21 - asynchronous

* *Read* chapter 11 from textbook

* *Watch* pre-recorded lecture by Dr. Yaniv Brandvain:

{{< youtube ktu3zuEIOPo >}}

  - You only need to watch up until 20:13, the rest is optional, more advanced material
  - PDF of slides are posted on Laulima

* *Watch* [code demo](https://drive.google.com/file/d/1thKKbgOKLjYn8Uz6Cbbe_wZ9qvzPwIb9/view?usp=sharing) of one-sample *t*-test (code below):

### Thursday, April 23 - lab

* Lab on the one-sample *t*-test in *R* (I will post by Wednesday night)

* Join Google Meeting at 12: [meet.google.com/vhq-qczv-dew](https://meet.google.com/vhq-qczv-dew)

### Code demo: one-sample *t*-test

```{r}

# Demonstrate one-sample t-test

# Load libraries
library(dplyr)
library(ggplot2)
library(scales)

# Body temperature data from Example 11.3
Y <- c(98.4, 99.0, 98.0, 99.1, 97.5, 98.6, 98.2, 99.2, 98.4, 98.8, 97.8, 98.8,
       99.5, 97.6, 98.6, 98.8, 98.8, 99.4, 97.4, 100.0, 97.9, 99.0, 98.4, 97.5, 
       98.4)

ggplot(data.frame(Y = Y), aes(Y)) +
  geom_histogram(fill = "tomato", binwidth = 0.5, color = "black") +
  scale_x_continuous(
    breaks = seq(97, 100.5, 0.5),
    label = label_number(accuracy = 0.1, suffix = "°F")
  ) +
  xlab("Body Temperature") +
  ylab("Frequency") +
  theme_bw()

# 1. State H_0 and H_A ----

# H_0: The mean of Y is mu_0
mu_0 <- 98.6 # null hypothesis is that human body temperature if 98.6 F

# H_A: The mean of Y i not mu_0

# 2. Calculate a test statistic ----

SE_Y <- sd(Y) / sqrt(length(Y))
Y_bar <- mean(Y)
test_stat <- (Y_bar - mu_0) / SE_Y

# 3. Generate the null distribution

# degrees of freedom
df <- length(Y) - 1
sampling_dist <- data.frame(t = seq(-3, 3, 0.1))
sampling_dist$Probability <-
  dt(
    x = sampling_dist$t,
    df = df
  )

head(sampling_dist)

gp <- ggplot(sampling_dist, aes(t, Probability)) +
  geom_area(fill = "tomato", color = "black") +
  xlab(expression(italic(t))) +
  theme_bw()

gp

gp + geom_vline(xintercept = test_stat, size = 2)

# 4. Find a critical value at specified alpha ----

alpha <- 0.05

critical_value <- qt(
  p = alpha / 2,
  df = df,
  lower.tail = FALSE
)

critical_value

gp + geom_vline(xintercept = critical_value * c(-1, 1), size = 2)

# 5. Find the P-value

P_value <- 2 * pt(
  q = abs(test_stat),
  df = df,
  lower.tail = FALSE
)

P_value

# Decide ----
P_value < alpha

# Why we learn to do it by hand
t.test(Y) # totally different result. Why?

# t.test() assumes mu_0 = 0!
t.test(Y, mu = 98.6)

```