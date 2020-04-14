+++
title = "BIOL 297: Schedule for week of April 13-17"

date = 2020-04-13T00:00:00
lastmod = 2020-04-14T13:12:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "biostats", "normal", "teaching"]
summary = "The Normal Distribution!"
+++

## Assignments:

* There will be a regular lab assignment on the normal distribution in *R* due by next Tuesday.

* If you haven't already, make sure you complete your proposal for the final that was due Friday.

## Readings:

* Whitlock & Schluter, Chapter 10: The normal distribution

## Schedule

Note that on Tuesday, class will meet synchronously on Google Meet [meet.google.com/foi-xwhi-ape](https://meet.google.com/vhq-qczv-dew). Class will be recorded and posted online if you are unable to attend. Remaining instruction will be asynchronous, meaning you can work at your own pace and desired time.

### Tuesday, April 14 - synchronous

* We will go over the *Normal Distribution* in more detail to prepare for analyzing continuous variables

* We will go over the [Class Project](https://cdmuir.netlify.com/post/2020-04-03-biol297-class-project) 

* *Read* chapter 10 from textbook

* *Watch* pre-recorded lecture by Dr. Yaniv Brandvain:

{{< youtube qP39GdBAVSw >}}

  - PDF of slides are posted on Laulima
  
### Thursday, April 16 - lab

* Lab on the Normal Distribution in *R* (I will post by Wednesday night)

* Join Google Meeting at 12: [meet.google.com/vhq-qczv-dew](https://meet.google.com/vhq-qczv-dew)

### Code demo on the Normal distribution

```{r}

# Demonstrate the Normal distribution

# Load libraries
library(dplyr)
library(ggplot2)

# Plot standard normal ----
df <- data.frame(Y = seq(-3, 3, 0.01))
df$prob_density <- dnorm(df$Y, mean = 0, sd = 1)
ggplot(df, aes(Y, prob_density)) +
  geom_area(fill = "tomato") +
  geom_line() +
  xlab("Value of numerical variable") +
  ylab("Probability density") +
  theme_bw()

# Integrate area between an interval ----
# Approximately 2/3 (68.3%) of probability falls within +/- 1 sd
pnorm(1, mean = 0, sd = 1) - pnorm(-1, mean = 0, sd = 1)

sigma <- 2
pnorm(sigma, mean = 0, sd = sigma) - pnorm(-sigma, mean = 0, sd = sigma)

mu <- 1
sigma <- 2
pnorm(sigma + mu, mean = mu, sd = sigma) - 
  pnorm(-sigma + mu, mean = mu, sd = sigma)

# Approximately 95% of probability falls within +/- 2 sd
mu <- 1
sigma <- 2
pnorm(2 * sigma + mu, mean = mu, sd = sigma) - 
  pnorm(-2 * sigma + mu, mean = mu, sd = sigma)

# Z-transform ----
# Convert any normal distribution to standard normal with mu = 0, sigma = 1

N <- 100 # our sample size
Y <- rnorm(100, mean = 100, sd = 10)
mu <- mean(Y)
mu

sigma <- sd(Y)
sigma

Z <- (Y - mu) / sigma
mean(Z)
sd(Z)

head(cbind(Y, Z))

df <- data.frame(
  value = c(Y, Z),
  facet = rep(c("Y", "Z"), each = N)
)
ggplot(df, aes(value)) +
  facet_grid(~ facet, scales = "free") +
  geom_histogram(fill = "tomato") +
  theme_bw()

# Transforming data ----
# data from OpenNahele
open_nahele <- read.csv("https://bdj.pensoft.net/article/download/suppl/4411035/")

# Plot raw data (right-skewed)
ggplot(open_nahele, aes(D95)) +
  geom_histogram(fill = "tomato") +
  theme_bw()

open_nahele$log_D95 <- log(open_nahele$D95)

# Plot transformed data
ggplot(open_nahele, aes(log_D95)) +
  geom_histogram(fill = "tomato") +
  theme_bw()

# Is that better? Use QQ plots
ggplot(open_nahele, aes(sample = D95)) +
  geom_qq() +
  geom_qq_line() +
  ggtitle("Not very normal") +
  theme_bw()

ggplot(open_nahele, aes(sample = log_D95)) +
  geom_qq() +
  geom_qq_line() +
  ggtitle("Normalish") +
  theme_bw()

```
