+++
title = "BIOL 297: Class project analyzing COVID-19 pandemic data"

date = 2020-04-03T00:00:00
lastmod = 2020-04-20T23:00:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "teaching", "covid19", "biostats"]
summary = "What explains variation in the COVID-19 pandemic across US states"
+++

## Description

In response to moving the course online, I have decided to combine the final project and exam into a larger project that will be 35% of your final grade. As decided in class, everyone will analyze by, themselves or with a partner, a dataset to test a hypothesis that could explain why COVID-19 has spread more rapidly in some US states than others. This page is a placeholder for further information on this project. I will notify you via email when I make important updates.

## Learning objectives

* translate questions and scientific hypotheses into testable statistical hypotheses
* synthesize data from online sources
* analyze data using a null hypothesis testing framework
* draw appropriate conclusions
* communicate quantitative information effectively through written and visual media

## Timeline:

* **Friday, April 10**: One paragraph proposal of scientific question and hypothesis

* **Friday, April 24**: Get all data you will need to complete project

* **Friday, May 1**: 1-2 paragraph data analysis plan

* **Thursday, May 14**

  - *R* script and data files to perform all analyses ({{% staticref "img/example-final.pdf" %}}see explanation and example{{% /staticref %}})
  - Code and blog-style report for lay readers due
  - Online symposium of results with 5-10 minute presentations
  
## Getting started

I will create a GitHub repo that you can access via *RStudio Cloud* for the final project. For now, you can look at up-to-date data from the [COVID Tracking Project](https://covidtracking.com) by copying and pasting the code below into R. You should get a figure like the one below. Notice this code uses some nifty *R* functions we haven't encountered yet, like the pipe operator `%>%` and `mutate()`. Read about them and try to understand what they do (I use them *all the time*).

```{r}

library(cowplot)
library(lubridate)
library(tidyverse)

covid <- read_csv(
  "https://covidtracking.com/api/states/daily.csv", 
  col_types = cols(
    date = col_character(),
    state = col_character(),
    positive = col_double(),
    negative = col_double(),
    pending = col_double(),
    hospitalized = col_double(),
    death = col_double(),
    total = col_double(),
    hash = col_character(),
    dateChecked = col_datetime(format = ""),
    totalTestResults = col_double(),
    fips = col_character(),
    deathIncrease = col_double(),
    hospitalizedIncrease = col_double(),
    negativeIncrease = col_double(),
    positiveIncrease = col_double(),
    totalTestResultsIncrease = col_double()
  )
) %>%
  mutate(date = ymd(date))

covid %>%
  filter(state == "HI") %>%
  ggplot(aes(date, positive)) +
  scale_y_log10() +
  geom_line() +
  geom_point() +
  theme_cowplot()
  
```

<img alt = 'covid-in-hi' width='600' src='/img/covid-in-hi.png' ALIGN = 'center'/>


  