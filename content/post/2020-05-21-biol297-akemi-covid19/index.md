---
title: "Guest post by Akemi Santiago on COVID-19"

date: 2020-05-21T00:00:00
lastmod: 2020-05-21T08:00:00
draft: false

authors:
  - Akemi Santiago

math: true

tags: 
  - biol297
  - biostats
  - covid-19
  - teaching
  
summary: "Biostats final project on COVID-19"
---

**This is part of a series of guest posts from students in my Biostats class at UH Mānoa. For their final projects, students analyzed data to understand what factors explain variation in COVID-19 incidence. Read more about the project [here]({{< ref "post/2020-04-03-biol297-class-project.md" >}}).**

My study was motivated by the shocking news I began seeing recently on various national and local TV networks that were reporting how people of color all across the globe, specifically those of African heritage or black race, were being infected and dying of COVID-19 at higher rates than those of European heritage or white race. Being that there are no known studies (to my knowledge) proving how genetic background could make a person more or less prone to being infected by COVID-19 and/or to experience serious health risks because of the infection, it can be inferred that the reports of higher infection/death rates from COVID-19 are being caused by socio-economic disadvantages of people groups. With this information in mind, I decided to test this question myself: Are African Americans facing higher illness and death rates due to COVID-19 than white Americans and other people of color? I chose to focus on people of black race in America to narrow down my dataset to the country most relevant to my life, since I am an American citizen. 

Based on my question, I hypothesized that if black Americans make up 13% of the total US population and white Americans make up 62% of the total US population, then ~13% of overall COVID-19 deaths should be from black Americans and ~62% of COVID-19 deaths will be from white Americans. This hypothesis allowed me to analyze the data from an unbiased standpoint, despite what the television news stations were reporting. Therefore, my null hypothesis says that African Americans experience THE SAME infection rates and death rates due to COVID-19 as White Americans, and my alternative hypothesis says that African Americans experience DIFFERENT infection rates and death rates due to COVID-19 than White Americans. The keyword, “different,” makes this a two-tailed test.

I collected my data from the [APM (American Public Media) Research Lab’s online data log](https://www.apmresearchlab.org/covid/deaths-by-race) (updated weekly) to record information on deaths due to COVID-19 organized by race. From their data log, I collected information on each state included in the study including the percentage of the state population that is black, the percentage of the state population that is white, the percentage of deaths due to COVID-19 that were from black Americans, and the percentage of deaths due to COVID-19 that were from white Americans. I then calculated the difference between the percentage of the population and the percentage of overall deaths for both black and white communities per state.

Based on the data I collected, my explanatory variables (categorical) are (1) black Americans and (2) white Americans, and my response variable (numerical) is the difference between the percentage of the population and the percentage of overall deaths (% population - % death) per race included in my study (black or white). I chose this difference because if my hypothesis were to be proven correct, this difference should be zero or very close to zero, indicating that there is no difference in death rates between black and white Americans. Based on my chosen variables, I decided to conduct a two-sample *t*-test because my two explanatory variables are categorical, while my one response variable is numerical. 

I rejected my null hypothesis that African Americans experience THE SAME infection rates and death rates due to COVID-19 as White Americans in favor of the alternative hypothesis that the death rates are in fact different. The data that proved this was the miniscule *P*-value which was much smaller than the 5% significance level. Furthermore, the mean difference between percentage of population and percentage of overall deaths from COVID-19 per race per state was negative for black Americans, but positive for white Americans. The negative value for black Americans indicates that the percentage of overall COVID-19 deaths from black people is higher than the overall population percentage of black people per state. Alternatively, the positive value for white Americans indicates that the percentage of overall COVID-19 deaths from white people is lower than the overall population percentage of white people per state. This evidence is alarming, and proves that there is an underlying issue occurring within the socio-economic structure of America that is putting these communities of black Americans more at risk than white Americans. 

 {{< figure src="/img/santiago-fig1.png" >}}

In the violin plot above, the *x*-axis plots race, the explanatory variable, and the *y*-axis plots the difference in percentage of the population minus the percentage of overall deaths per state. The wider areas of the plot indicate the most common differences in population percentage vs death percentage per state. As seen in the ‘violin’ for black Americans, the highest concentration of differences lies around -5%, with values as low as -33%. Alternatively, the ‘violin’ for white Americans shows that the highest concentration of differences lies around 0% and 15%. This reveals that the percentage of COVID-19 deaths per state for white Americans are, on average, fair compared to their population size per state,  or at least puts white Americans at a clearly smaller risk of dying from COVID-19 than black Americans. Therefore, I can conclude that not only can I reject the hypothesis and the null hypothesis because there is strong evidence that African Americans experience HIGHER infection rates and death rates due to COVID-19 than White Americans. 

Despite these conclusions, the data included in this analysis was still limited. APM Research Lab’s data log did not include data from all 50 states, but instead only 40, as the excluded 10 states did not submit data regarding COVID-19 deaths organized by race. This causes my data to be biased, as the excluded data could have increased or decreased the mean differences of my response variable. In addition, there are several confounding variables to consider in this study. Firstly, there are many factors that could have contributed to these very large or very small differences in black/white overall percentage of the population minus the overall percentage of deaths from COVID-19 per state such as living conditions, choice of career, access to health care, weakened immune system due to stress from discrimination, etc. Secondly, these data only include COVID-19 deaths per state that were recorded and reported. There could have been many unrecorded deaths from both black and white Americans that could have greatly altered the data. 

Nonetheless, my research conclusions still raise more concerning questions and further support the statements that people of black race are dying at higher rates than people of white race, proving that these topics need to be addressed more in depth in order to solve this very unfair difference. 



