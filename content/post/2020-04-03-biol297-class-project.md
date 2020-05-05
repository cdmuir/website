+++
title = "BIOL 297: Class project analyzing COVID-19 pandemic data"

date = 2020-04-03T00:00:00
lastmod = 2020-04-28T16:00:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol297", "teaching", "covid19", "biostats"]
summary = "What explains variation in the COVID-19 pandemic across US states?"
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

* **Friday, May 1**: Data analysis plan due. Step-by-step explanation below on how to complete this on *RStudio Cloud*. If you want, you can work on a local project and email it to me.

  - Create project on [*RStudio Cloud*](https://rstudio.cloud/). Call it "last-first-final" (e.g. "muir-chris-final"). You can simply click "New Project"; you don't need to import GitHub Repo, as in labs.

{{< figure src="/img/biol297-final-setup1.png" title="Start a new project" >}}

{{< figure src="/img/biol297-final-setup2.png" title="Give your project a name" >}}

  - If necessary, move data files into project directory using the upload tool. Once files are uploaded, you will see them in your Files tab:
  
  {{< figure src="/img/biol297-final-setup4.png" title="I've uploaded state-govenors.csv and stats-daily.csv" >}}

  - If you need to get data entered into a CSV files, look at Section 2.6 in the textbook called "How to make data files" for guidance.
  
  - Create new *R* script for your code.
  
  - Install any packages you need.
  
  - In script, complete a draft of the "Question", "Hypotheses", and "Test you will use" sections, as in the {{% staticref "img/example-final.pdf" %}}example final{{% /staticref %}}. It would look like:
  
  {{< figure src="/img/biol297-final-setup5.png" title="Example script with data analysis plan." >}}

* **Thursday, May 14**

  - *R* script and data files to perform all analyses ({{% staticref "img/example-final.pdf" %}}see explanation and example{{% /staticref %}})
  - Blog-style report for lay readers due
  - Online symposium of results with 5-10 minute presentations
  
## Getting started

You can look at up-to-date data from the [COVID Tracking Project](https://covidtracking.com) by copying and pasting the code below into R. You should get a figure like the one below. Notice this code uses some nifty *R* functions we haven't encountered yet, like the pipe operator `%>%` and `mutate()`. Read about them and try to understand what they do (I use them *all the time*).

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


  