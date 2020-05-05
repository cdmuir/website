+++
title = "BIOL 297: Schedule for week of April 27-May 1"

date = 2020-04-27T00:00:00
lastmod = 2020-04-28T15:45:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "biostats", "t-test", "teaching"]
summary = "moar t-tests!"
+++

## Assignments:

* Catch up on labs 10 and 11 if you haven't finished

* There will be a regular lab assignment on the normal distribution in *R* due by next Tuesday.

* **Friday, May 1**: Data analysis plan for the final project

## Readings:

* Whitlock & Schluter, Chapter 12: Comparing two means

* Interleaf 7: Which test should I use? **Essential reading for your data analysis plan**

## Schedule

Note that on Tuesday, class will meet synchronously on Google Meet [meet.google.com/foi-xwhi-ape](https://meet.google.com/vhq-qczv-dew). Class will be recorded and posted online if you are unable to attend. Remaining instruction will be asynchronous, meaning you can work at your own pace and desired time.

### Tuesday, April 28 - synchronous

* *Read* Chapter 12 and Interleaf 7 from textbook

* *Watch* pre-recorded lecture by Dr. Yaniv Brandvain:

{{< youtube _7ZEnWchOao >}}

  - You only need to watch up until 27:14, the rest is optional, more advanced material
  - PDF of slides are posted on Laulima

* We will go over the *R* script that you will submit with your [final project](https://cdmuir.netlify.com/post/2020-04-03-biol297-class-project) 

* Recorded [video lecture/code demo](https://drive.google.com/open?id=15q8Fhu3r3U3pPvo2d7XwxJ2WErp_uXmG)

### Thursday, April 30 - lab

* Lab on ANOVA in *R* (I will post by Wednesday night)

* Join Google Meeting at 12: [meet.google.com/vhq-qczv-dew](https://meet.google.com/vhq-qczv-dew)

### Code demo: two-sample *t*-test (unpaired)

```{r}

# Demonstrate two-sample t-test (unpaired)

# Load libraries
library(dplyr)
library(ggplot2)

# EXAMPLE: question 15 in Chapter 12
# Beer group
Y_1 <- c(0.36, 0.46, 0.06, 0.18, 0.25, 0.18, -0.06, -0.14, 0.12, 0.39, 
         0.17, -0.16, -0.05, 0.19, 0.25, 0.31, 0.17, -0.03, 0.23, -0.03, 
         0.26, 0.30, 0.11, 0.13, 0.21)
# Water group
Y_2 <- c(0.04, 0, -0.08, -0.12, 0.201, -0.039, 0.10, 0.041, 0.02, 0.236, 0.05, 
         0.097, 0.122, -0.019, 0.021, -0.08, -0.165, -0.28)

ggplot(data.frame(
    Y = c(Y_1, Y_2), 
    group = rep(c("Y_1", "Y_2"), c(length(Y_1), length(Y_2)))
  ), aes(Y)) +
  facet_wrap(~ group, ncol = 1) +
  geom_histogram(fill = "tomato", binwidth = 0.1, color = "black") +
  xlab("Value") +
  ylab("Frequency") +
  theme_bw()

# 1. State H_0 and H_A ----

# H_0: The difference between the mean of Y_1 and Y_2 is mu_0
mu_0 <- 0 # null hypothesis is no difference between groups

# H_A: The difference between the mean of Y_1 and Y_2 is not mu_0

# 2. Calculate a test statistic ----

Ybar_1 <- mean(Y_1)
Ybar_2 <- mean(Y_2)
n_1 <- length(Y_1)
n_2 <- length(Y_2)
s2_1 <- var(Y_1)
s2_2 <- var(Y_2)
df_1 <- n_1 - 1
df_2 <- n_2 - 1

s2_p <- (df_1 * s2_1 + df_2 * s2_2) / (df_1 + df_2)
SE_dY <- sqrt(s2_p * (1 / n_1 + 1 / n_2))
test_stat <- (Ybar_1 - Ybar_2) / SE_dY

# 3. Generate the null distribution

sampling_dist <- data.frame(Y = seq(-4, 4, 0.1))
sampling_dist$probability <- dt(sampling_dist$Y, df = df_1 + df_2)

head(sampling_dist)

sampling_dist_plot <- ggplot(sampling_dist, aes(Y, probability)) +
  geom_area(fill = "tomato", alpha = 0.5) +
  geom_line() +
  xlab(expression(italic(t))) +
  ylab("Probability density") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  )

sampling_dist_plot

sampling_dist_plot +
  geom_vline(xintercept = test_stat, size = 2)

head(sampling_dist)

# 4. Find a critical value at specified alpha ----

alpha <- 0.05

critical_value <- qt(
  p = alpha / 2,
  df = df_1 + df_2,
  lower.tail = FALSE
)

critical_value

sampling_dist_plot + 
  geom_vline(xintercept = critical_value * c(-1, 1), size = 2)

# 5. Find the P-value

P_value <- 2 * pt(
  q = abs(test_stat),
  df = df_1 + df_2,
  lower.tail = FALSE
)

P_value

# Decide ----
P_value < alpha

# The quick way
t.test(Y_1, Y_2, var.equal = TRUE)
t.test(Y_1, Y_2, var.equal = FALSE) # safer

```
