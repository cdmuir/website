+++
title = "New R Package: tealeaves"

date = 2018-11-12T00:00:00
lastmod = 2018-11-20T00:00:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["plant physiology", "rstats", "tealeaves"]
summary = "An R package to model leaf temperature"
+++

<img alt = 'hex sticker' width='200' src='/img/tealeaves-hex-sticker.png' ALIGN = 'left'/>

I'm excited to release the first lab "product", an R package called `tealeaves` that models leaf temperature by balancing leaf energy budgets. The name originates from the fact that leaf temperature is often abbreviated $T_\text{leaf}$ (said "tee leaf"). I won't delve into the details of leaf energy balance here, suffice to say, it can get complex. If you want to learn more about the package and start using it right away, check out the [GitHub](https://github.com/cdmuir/tealeaves) repo. Please note that this package is a **work in progress** and will be updated regularly over the next couple months. In this post, I'll briefly go over my motivation for developing this package and extol some of its virtues.

## Motivation

This package is one part of a larger suite of packages I'm developing to model leaf traits, photosynthesis, and organismal performance/fitness across environmental gradients. Leaf temperature is a key part of that because gas exchange, photosynthesis, repspiration, etc. are all temperature sensitive processes. And leaf temperature can change dramatically across gradients of air temperature, irradiance, wind speed, humidity, etc. Because leaf temperature affects physiology and is effected by the environment, it's central to modeling the relationship between plant and climate. However, the tools to model leaf temperature in R are pretty limited, so I decided I needed to develop my own^[Remko Duursma's [`plantecophys`](https://cran.r-project.org/web/packages/plantecophys/index.html) package also models leaf temperature, but doesn't have all the features I needed].

## Advantages

The concept for this package is that it simply does one thing (model leaf temperature) well and almost nothing else. In a perfect world, you supply parameters to one or two functions and retrieve a tidy data.frame with everything you need for further analysis. Other than hopefully creating an easy R interface for leaf temperature, `tealeaves` has three advantageous features I haven't seen in other package:

- It uses the R packages [`units`](https://cran.r-project.org/web/packages/units/index.html) to ensure that all parameters are specified and calculated properly. If nothing else, this helps catch errors in the equations, as most errors will totally mess up the units. It also disambiguates calculations. For example, if you see something like:

```{r bad, echo = TRUE, eval = FALSE}

# VPD is vapour pressure deficit in kPa
VPD <- 1.5
1000 * VPD

```

Does this mean that VPD is being multiple by 1000 or that you are simply changing units from kPa to Pa? It's hard to tell, but `units` makes it unambiguous:

```{r good, echo = TRUE, eval = FALSE}

VPD <- set_units(1.5, "kPa")

# Multiply VPD by 1000
set_units(1000) * VPD

# Convert VPD by Pa
VPD %<>% set_units("Pa")

```

- `tealeaves` allows boundary layer conductances to heat and water vapour to vary between lower and upper leaf surfaces. This is important because leaf surfaces are often not identical, nor are the microclimates surrounding them. For example, stomatal conductance may be partitioned evenly between surfaces, or all on one surface, or somewhere in between. 

- `tealeaves` uses the `tidyr::crossing` function to easily creating (multiple) environmental and/or trait gradients over which to model leaf temperature. 

## Help!

This package is a work in progress and I would greatly appreciate comments and criticisms. At this time, I don't recommend using the package for serious analysis without carefully inspecting results. However, I hope that by releasing it, I will be able to work out bugs soon and provide a reliable, stable version in the near future.
