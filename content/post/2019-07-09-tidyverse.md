+++
title = "Why I like the Tidyverse"

date = 2019-07-09T00:00:00
lastmod = 2019-07-09T00:00:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["R", "tidyverse"]
summary = "It's the shill bucks"
+++

{{< tweet 1147885159661867008>}}

# TL;DR

- Norm Matloff, a computer science professor at UC Davis, [wrote about why he's a Tidyverse skeptic](https://github.com/matloff/TidyverseSkeptic). This essay was mentioned by several evolutionary biologists on Twitter that I follow (see above).
- Matloff makes some accurate criticisms of the [Tidyverse](https://www.tidyverse.org/), but these are probably not relevant for most R users, at least in biology.
- I disagree that the Tidyverse is successful because [RStudio](https://www.rstudio.com/) is a monopolist. Rather, the Tidyverse has attracted users in a competitive marketplace despite base-R's strong incumbency advantage. This suggests it provides real utility to many R users.
- I personally find the Tidyverse dialect highly useful, despite having learned on and used base-R almost daily for 10 years. However, YMMV and that's fine.

# Many biologists might like the Tidyverse dialect

From various mentions on Twitter, I vaguely understand that there is some conflict between Tidyverse and base-R aficianados, but I don't follow this debate and consequently have no idea what the main arguments are. However, several evolutionary biologists on Twitter retweeted a [recent post](https://github.com/matloff/TidyverseSkeptic) by Tidyverse skeptic, Norm Matloff. His essay makes some useful points that I was not aware of, but the harms he identifies seem minor compared to the apparent benefits reaped by the many R users who opt to use the Tidyverse dialect. My post is geared toward biologists like myself. I think biologists who use R should give Tidyverse a try, but if you don't see a benefit, that's fine too.

First, some background on where I'm coming from (skip this if you don't care). I first learned base-R coding my senior year of college (2006) in a biostatistics course (I was biology major, but took a few math classes too). I used R almost daily for 10 years during my PhD (Evolutionary Biology, 2007-13) and postdoc (2013-16). I felt very comfortable with base-R syntax, graphics, and GUI. Lots of peers were getting into ggplot, RStudio, (d)plyr, pipes, etc., but I either didn't understand these tools or didn't see the benefit. In 2016, I started working as a computational biologist for [Poisson Consulting](https://www.poissonconsulting.ca/) where [Joe Thorley](https://www.poissonconsulting.ca/authors/joe/) gave me a deeper introduction to all of these tools. For whatever reason, at this point, the logic of the Tidyverse clicked and I haven't looked back since. I'm not cultish about it and make no apologies for using "untidy" code when I think it's better, but I have found the Tidyverse extremely useful and easy to adopt, even after achieving proficiency in base-R. In part, I think the packages, especially their integration with each other and RStudio, had matured by 2016 to the point that they really worked well together. This was not true, or not apparent to me, in previous years. Also, I had started doing more sophisticated statistics, especially Bayesian MCMC, where the benefits of tidy style were very obvious. Currently, I'm a new Assistant Professor at the University of Hawai'i who uses R all the time for biological data analysis and modeling. You can find examples of my recent code [here](https://github.com/cdmuir/stomata-light) and some R packages I've developed [here]({{< ref "/post/2019-05-21-phyteclub" >}}). 

# There are problems in the Tidyverse

Next, I want to point out that I agree with four of Matloff's main premises:

- Many Tidyverse functions are slower than their base-R counterparts [^1] 
- Tidyverse packages crowd out other high-quality packages. For example, Matloff argues that **dplyr** has hurt **data.table**, which is must faster.
- I have no opinion about whether the Tidyverse is easier to learn than base-R, but I agree that user testimonials are not good evidence.
- Tidyverse functions are harder to debug (I don't really know how true this is, but more experienced R developers say this and I believe them).

# These costs seem minor for many users

There are some problems with the Tidyverse, but so what? Do these problems actually cause much harm? For the vast majority of users, even relatively advanced users like myself, compute time is rarely the limiting step. Any tool which makes it faster to write and edit code would probably make up for the computational overhead in most situations. For me, coding and data analysis are simply not the rate-limiting steps in my research; thinking and writing take much more time. The same may not be true for biologists who use more computationally intensive methods.

The popularity of the Tidyverse probably does reduce the use of high-quality competing packages. But why is this a problem? Matloff gives the example of **dplyr** versus **data.table**. The latter is much faster, but not as widely used. To me, this suggests that **dplyr** provides real utility over **data.table** *despite* the fact that it's slower. Also, many users simply may not work with large enough datasets to notice the difference.

I don't have enough experience with base-R versus Tidyverse for debugging and teaching R to form an opinion, but it seems that people can easily choose one or the other based on their personal preference or interaction with students, so I don't see how the Tidyverse is hurting anyone here.

# The benefits of Tidyverse seem real and large

I made the switch from base-R to Tidyverse very quickly after 10 years of the former, but I have trouble articulating why. I do find the pipe syntax (`%>%`, `%<>%`) more readable, it cuts down on intermediate variables, and it's easier to edit because I can often cut-and-paste whole lines of code. I had of course developed other ways to do what `dplyr`, `purrr`, `tidyr`, etc. do, but my solutions were usually clunky and error-prone. These packages found general solutions to problems I often had and it was easy for me to grasp their utility quickly. I also find packages like `stringr`, `readr`, and `glue` more intuitive than their base-R counterparts, even though the functionality is basically the same. These are some reasons I give to colleagues about why they should give the Tidyverse a try.

But honestly, it doesn't really matter what I think because the market has spoken. Thousands of R users download packages, try them, and continue to use them (or not) if they provide a benefit (or not), so we can observe whether a package provides utility (or not). This is the [revealed preference](https://en.wikipedia.org/wiki/Revealed_preference) in economics jargon. And several Tidyverse packages are among [the most downloaded](https://www.r-pkg.org/downloaded). But **data.table** is pretty high up too, yay! In contrast, my niche plant ecophysiology packages are not because most R users have no use for them, and that's fine.

# Is RStudio a monolopy?

Matloff claims RStudio is a "classic" monopoly because:

> Given the dynamics described above, we will eventually, maybe rather soon, reach a point at which most R users will be Tidy, and have indeed "Never heard of Matt Dowle." This will make things very difficult for the non-Tidy R people: Non-Tidy job seekers who are excellent R coders will find that they are dismissed out of hand by Tidy interviewers; authors of non-Tidy CRAN code will find their contribution is considered useless; academics submitting data science research manuscripts or grant proposals will find that Tidy reviewers give them low scores. In short, R will have to bend to RStudio's wishes.

I want to give Matloff the benefit of the doubt, but I honestly find this claim bizarre, maybe because I am approaching R from a very different perspective. I have no idea who Matt Dowle is, but I've published 18 papers with substantial amounts of R code, worked as an applied statistician using R for 1.5 years, and contributed 3 small packages to CRAN, all without knowing who Matt Dowle is. This leads me to the conclusion that knowledge of Matt Dowle is not essential for using R well [^2]. I do know the names of a couple RStudio developers because I follow them on Twitter. Otherwise, I probably can't name more than a handful R developers outside of evolutionary biology. I do not think this is because RStudio has a monopoly; I think it's because most R users don't know or care who the developers are as long as the package does what they want. As such, I think the hypothetical problems that Matloff itemizes are not as serious as he suggests. The barriers to entry for developing R packages are low and if you can develop a package that solves a common problem, people will use it. My alternative explanation for why **data.table** is not more popular is than **dplyr** is that **data.table** doesn't solve a problem as many people have because many people are not overly concerned about speed; conversely **dplyr** helps some people manipulate data.frames more easily.

In reality, it's hard to know if RStudio has monopoly power because there are no prices and it's not even clear what the relevant market is (Is it just the R language? Probably not, because people can always switch to competing languages). I think it's unlikely a firm could have monopoly power because the barriers to entry are low and it's easy for consumers get information on and switch packages, but this is just my opinion.

# Has RStudio done anything wrong?

Nothing about the Tidyverse prevents someone else from using base-R if they prefer, so the complaint is that by promoting the Tidyverse, RStudio is making too many other people use the Tidyverse. Again, I'm not sure why this is a problem. But also, isn't this a good thing? A for-profit company is:

1. developing a bunch of R packages based on a consistent system (the Tidyverse)
2. developing an application (RStudio) that works well with these packages
3. giving packages and RStudio basic away freely 

The fact that people use these tools together suggests that it's a decent system that provides real benefits. So they made an "end-run" around the R Core Group to deliver products people want to use? Good for them! Do they convince some of those users to pay for more advanced products? Again, good for them, people need to make a living. I am assuming that R users are making informed choices based on their experience rather than being forced to adopt a certain dialect through monopoly power. I find the popularity of these packages all the more remarkable given the fact that base-R should have a strong incumbency advantage. I for one would never have switched from a dialect I was well-versed in unless there was a large benefit.

# In conclusion

I think the problems with the Tidyverse are not important but the potential benefits are substantial for many users in my field (academic biology). But I'm a pluralist and respect that others will not share my preferences, so you know, [Do Whatcha Wanna](https://www.youtube.com/watch?v=X_AOwrXev60). 

[^1]: In my own experience trying to speed up functions in this [packge](https://CRAN.R-project.org/package=tealeaves), I found the time savings of switching to base-R miniscule compared to other inefficiencies in my code.

[^2]: Apologies to Matt Dowle, who is probably a great developer. 