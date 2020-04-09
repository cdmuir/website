+++
title = "BIOL 297: Schedule for week of April 6-10"

date = 2020-04-06T00:00:00
lastmod = 2020-04-08T17:00:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "biostats", "contingency tests", "categorical variables", "teaching"]
summary = "BIOL/BOT 297 schedule for April 6-10"
+++

## Assignments:

* There will be a regular lab assignment on analyzing frequency data in *R* due by next Tuesday.

* Final project: turn in one paragraph proposal of scientific question and hypothesis by **Friday, April 10** @ 11:59 PM HST.

## Readings:

* Whitlock & Schluter, Chapter 9: Contingency analysis

## Schedule

<!-- Note that on Tuesday, class will meet synchronously on Google Meet [meet.google.com/foi-xwhi-ape](https://meet.google.com/foi-xwhi-ape). Class will be recorded and posted online if you are unable to attend. Remaining instruction will be asynchronous, meaning you can work at your own pace and desired time. -->

We will **not** meet synchronously this Tuesday. I will post some things later on Tuesday, or more likely Wednesday morning. You can work at your own pace and desired time.

### Tuesday, April 7

* We will introduce *Contingency analysis* using $\chi^2$ contingency tests (different than the $\chi^2$ test from last week!) and Fisher's Exact Test

* I've updated the [Class Project](https://cdmuir.netlify.com/post/2020-04-03-biol297-class-project) page with

* *Read* chapter 9 from textbook

* *Watch* pre-recorded lecture by a friend of mine, Dr. Yaniv Brandvain:

{{< youtube Y27HH4sEbhs >}}

This lecture covers tests of contingency analysis.

* *Watch* pre-recorded lecture with code deom on $\chi^2$ contigency tests

 - [Link to video](https://drive.google.com/file/d/1eZNK-tDw5JY7cFXmMP2Z2V25N_RLAhwZ/view?usp=sharing)
 - Code used in video
 
```{r}

# Demonrate chi-squared contingency test

# Load libraries
library(dplyr)
library(forcats)
library(ggplot2)

# data from OpenNahele
fig2 <- read.csv("https://raw.githubusercontent.com/dylancraven/Hawaii_diversity/master/Data/Hawaii_Div_Macro_SIE.csv") %>%
  filter(species_group != "all") %>%
  rename(N_observed = SppN) %>%
  mutate(
    Island = fct_relevel(geo_entity2, c("Hawai'i Island", "Maui Nui", "O'ahu Island", "Kaua'i Island")),
    Status = fct_recode(species_group, Alien = "exotic", Native = "native", `Single Island Endemic` = "nSIE"),
    Status = fct_relevel(Status, c("Single Island Endemic", "Native", "Alien"))
  ) %>%
  select(Island, Status, N_observed) %>%
  arrange(Island, Status)

ggplot(fig2, aes(Island, N_observed, fill = Status)) +
  geom_col(position = position_dodge()) +
  ylab("Species Richness") +
  theme_bw()


# 1. State H_0 and H_A ----

# H_0: The frequency of different groups (Endemic, Native, and Alien) is the same on every island
# N_observed is approximately equal to N_expected

# H_A: The frequency of different groups (Endemic, Native, and Alien) is NOT the same on every island
# N_observed != N_expected

# 2. Calculate a test statistic ----

# Make into a table
fig2_table1 <- matrix(fig2$N_observed, ncol = 4)
# library(tidyr)
# fig2_table2 <- fig2 %>%
#   pivot_wider(names_from = Island, values_from = N_observed)

# Shortcut for calculating expected frequencies
N_expected <- (matrix(rowSums(fig2_table1), ncol = 1) %*% 
    matrix(colSums(fig2_table1), nrow = 1)) / 
  sum(fig2_table1)

fig2$N_expected <- c(N_expected) # This works, but be careful!
fig2$chisq <- (fig2$N_expected - fig2$N_observed) ^ 2 / fig2$N_expected
test_stat <- sum(fig2$chisq)  

# 3. Generate the null distribution

# degrees of freedom is:
df <- (nrow(fig2_table1) - 1) * (ncol(fig2_table1) - 1)

sampling_dist <- data.frame(chisq = seq(0, 70, 0.1))
sampling_dist$Probability <-
  dchisq(
    x = sampling_dist$chisq,
    df = df
  )

head(sampling_dist)

gp <- ggplot(sampling_dist, aes(chisq, Probability)) +
  geom_area(fill = "tomato", color = "black") +
  xlab(expression(chi^2)) +
  theme_bw()

gp

gp + geom_vline(xintercept = test_stat, size = 2)

# 4. Find a critical value at specified alpha ----

alpha <- 0.05

qchisq(
  p = alpha,
  df = df,
  lower.tail = FALSE
)

gp + geom_vline(xintercept = 12.59159, size = 2)

# 5. Find the P-value

P_value <- pchisq(
  q = test_stat,
  df = df,
  lower.tail = FALSE
)

P_value

# Decide ----
P_value < alpha

```

### Thursday, April 3

* Lab on Contingency analysis in *R* (I will post by Wednesday night)

* Join Google Meeting at 12: [meet.google.com/vhq-qczv-dew](https://meet.google.com/vhq-qczv-dew)

