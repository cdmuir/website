+++
title = "A computational platform for plant ecophysiology in R"

date = 2019-05-21T00:00:00
lastmod = 2019-05-21T00:00:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["phyteclub", "plant physiology", "rstats", "tealeaves", "photosynthesis", "gunit"]
summary = "A computational platform for plant ecophysiology"
+++

I want to provide an update on work I've been doing lately to improve the computational toolkit for plant ecophysiologists, specifically using [R](https://cran.r-project.org). This is very much a work-in-progress, but since I've recently released the first R packages related to this work on CRAN (see [here](https://CRAN.R-project.org/package=gunit), [here](https://CRAN.R-project.org/package=tealeaves), and [here](https://CRAN.R-project.org/package=photosynthesis)), so I wanted to write a short post explaining my motivation and how these packages fit into the big-picture changes I would like to make in plant ecophysiology and its integration with evolutionary biology.

# Motivation

I'm fundamentally interested in adaptation. How well are organisms adapted to their environment? What traits underlie adaptation to different environments? An essay I recently discovered by [Mark Olson and Alfonso Arroyo-Santos (2015)](https://doi.org/10.1086/681438) makes a persuasive case that studying adaptation requires integration of three approaches that they label: comparative, population, and optimality. I recommend you read it yourself! Here I want to focus on the last approach, optimality. Very basically, optimality models work by making some assumption about what organismal functions maximize fitness and then figuring out what traits optimize those competing functions in a given environment. In plant physiology, a classic optimality model involves finding the stomatal conductance that optimally balances photosynthesis and water loss (Tom Buckey, Lawren Sack, and Graham Farquhar summarize nicely summarize the state of stomatal optimization models in [this paper](https://doi.org/10.1111/pce.12823)). I won't belabor the details here, but the basic idea is that plants benefit from getting carbon through photosynthesis by opening their stomata but this causes them to lose water that has some carbon costs in terms of growing roots and transporting that water from roots to leaves. One could add additional factors, like nitrogen, that have a cost of acquisition and a benefit by going into enzymes that catalyze photosynthetic reactions. The upshot is that optimality models require some kind of model about how plants work in different environments: how do different plant traits affect their photosynthetic rate, water loss, and so on? They also require some assumptions about costs. What is the cost, in terms of carbon gained from photosynthesis, of acquiring more water, nitrogen, and so forth? See this classic paper by [Bloom *et al.*](https://doi.org/10.1146/annurev.es.16.110185.002051) on "exchange rates" of various resources.

It turns out there are lots of physical and chemical models of plant function that can be used to predict the optimal trait values in different environments. For example, see Park Nobel's masterpiece [Physicochemical and Environmental Plant Physiology](https://www.elsevier.com/books/physicochemical-and-environmental-plant-physiology/nobel/978-0-12-374143-1). This is what got me into plant physiology in the first place. But I was frustrated that when it came down to actually using these models in my research, there were few computational tools to help. Furthermore, papers often didn't provide enough detail to replicate their results.

In evolutionary biology, it's become fairly standard for researchers who develop new methods to release an R package implementing that method. For whatever reason, it's not the same in plant physiology. I think this really hampers dissemenation of computational methods and models to others. You either have to adapt Excel sheets or scripts from other researchers or try to implement the model *de novo*. I took the latter approach because both of the models I wanted to use were from old papers whose authors were not currently available to email or because the scripts were in something like an Excel sheet which is not conducive to reproducible science. And since I was making robust code that could implement complex plant physiology models for my own work, I realized it wouldn't be that much more difficult to make these tools available to others through R packages. My hope is that these packages, along with future improvements and extensions, make it easier to overcome the activiation energy to using these models.

# Current status

So far I've released three packages that have a narrow focus which I hope they achieve reasonably well.

1. [{gunit}](https://CRAN.R-project.org/package=gunit): This simply converts conductance (e.g. stomatal conductance) to different units. I found I was doing this a lot. Everytime I questioned whether I was doing it right, panicked that my whole career was a sham and I am a fraud, then came to the correct answer I'd derived a few weeks earlier. This was my way of writing down my work so I wouldn't repeat myself again in a few weeks.

2. [{tealeaves}](https://CRAN.R-project.org/package=tealeaves): This uses a leaf energy budget model to predict leaf temperature from a bunch of environmental parameters (light, wind, air temperature, etc.) and leaf parameters (size, stomatal conductance, etc.). It models heat exchange and evaporation separately for each side of a horizontally oriented leaf, which was important for my own questions about stomatal distribution on the leaf. You can read a manuscript about this package [here](https://doi.org/10.1101/529487).

3. [{photosynthesis}](https://CRAN.R-project.org/package=photosynthesis): This package implements the classic Farquhar-von Caemmerer-Berry C$_3$ biochemical model of photosynthesis and incorporates temperature responses. It integrates with {tealeaves} so you can automatically get the leaf temperature and photosynthetic parameters at that leaf temperature in a given environment.

These are pretty basic packages and there's lots of room for improvement. I welcome comments, suggestions for improvement, and contributions.

# Future

There are two more endeavors on the horizon. First, I put together {tealeaves} and {photosynthesis} for an optimality model of stomatal traits in different environments. To do this, I developed a package called [{leafoptimizer}](https://github.com/cdmuir/leafoptimizer), but it's very preliminary and I don't suggest anyone use it yet. Basically, I needed it for a specific project (see this [paper](https://doi.org/10.1101/601377)) and haven't yet made it the sort of generalized leaf-optimizer tool that I would like it to be.

Next, I'm turning more to the data analysis side to develop software that implements Bayesian analysis of $A-C_\mathrm{i}$ curves to estimate parameters of the Farquhar-von Caemmerer-Berry model (the same model in {photosynthesis}) in a hierarchical framework using [Stan](https://mc-stan.org/). I'm planning to call this package {bayCi}. The main advantages are: 

* Users can put priors on parameters for which they don't have direct measurements from their species, but has been measured in other species. This is better than fixing an unknown value to some value from another study, which is probably wrong.

* Users can decompose the variation in various parameters within and between individuals, populations, species, etc.

I have lots more ideas for models and packages that could interact with one another to study plant biology. I'm tentatively thinking of calling this package suite "phyteclub". TBD. I'll update here and social media as those projects progress. I'll be presenting on these themes at the [Gordon Research Conference on CO$_2$ Assimilation in June]({{< ref "/talk/2019-06-09-grc" >}})!
