+++
title = "New R Package: photosynthesis"

date = 2018-11-19T00:00:00
lastmod = 2018-11-19T00:00:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["plant physiology", "photosynthesis", "rstats"]
summary = "An R package to simulate C3 photosynthesis"
+++


<H ALIGN=right> <img alt = 'hex sticker' width='200' display='inline-block' src='/img/photosynthesis-hex-sticker.png' /> </H>

I'm excited to release an R package called `photosynthesis`. It's very much a work-in-progress, but it simulates C3 photosynthesis using the classic Farquhar-von Caemmerer-Berry (FvCB) biochemical model. The structure and syntax closely follows that of the [tealeaves]({{< ref "post/2018-11-12-tealeaves" >}}) package I released last week (even much of this blog post is copied-and-pasted from that). Indeed, the idea is that you can use these two packages together to simultaneously model leaf temperature, transpiration, and photosynthetic rate. I'll demonstrate their integration shortly, but I want to show `photosynthesis`'s standalone utility here. To learn more about the package and start using it right away, check out the [GitHub](https://github.com/cdmuir/photosynthesis) repo. Please note that this package is a **work in progress** and will be updated regularly over the next couple months. In this post, I'll briefly go over my motivation for developing this package and extol some of its virtues. 

## Motivation

This package is one part of a larger suite of packages I'm developing to model leaf traits, photosynthesis, and organismal performance/fitness across environmental gradients. At the center of that, I wanted a flexible tool to simulate leaf photosynthetic rate in response to the environment as a function of leaf traits such as biochemsitry and anatomy. The FvCB biochemical model of C3 photosynthesis accurately captures how photosynthetic rate responds to environmental and leaf parameters such as CO2 concentration, light, and stomatal conductance. It is used very widely in plant scinece. While there are several existing tools to simulate and fit data to the FvCB model (even in R^[Remko Duursma's [`plantecophys`](https://cran.r-project.org/web/packages/plantecophys/index.html) package also implements the FcVB model].), the tools to simulate photosynthesis in R are pretty limited.

## Advantages

The concept for this package is that it simply does one thing (simulate photosynthetic rate) well and almost nothing else. In a perfect world, you supply parameters to one or two functions and retrieve a tidy data.frame with everything you need for further analysis. Other than hopefully creating an easy R interface for photosynthesis, `photosynthesis` has three advantageous features I haven't seen in other package:

- **Units**: it uses the R package [`units`](https://cran.r-project.org/web/packages/units/index.html) to ensure that all parameters are specified and calculated properly. If nothing else, this helps catch errors in the equations, as most errors will totally mess up the units. It also disambiguates calculations. For example, if you see something like:

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

- **Temperature responses are "baked" into calculations automatically:** Most key biochemical and diffusion parameters are temperature sensitive and scientists have parameterized temperature response curves. In `photosynthesis`, a user supplies these parameters at a reference temperature (25 °C by convention) and these parameters get "baked" to the correct leaf temperature using the `bake` function. I have programmed default temperature response parameters, but users can of course provide different ones.

- **Environmental/trait gradients:** like `tealeaves`, this packages uses the `tidyr::crossing` function to easily create (multiple) environmental and/or trait gradients over which to simulate. For example, you could easily simulate photosynthetic responses to CO2 concentration (aka, the A-Cc curve) this way:

```{r ACc, echo = TRUE, eval = FALSE}

leaf_par <- make_leafpar()
enviro_par <- make_enviropar(
  replace = list(
    C_air = set_units(seq(1, 200, length.out = 20), "Pa")
  )
)
bake_par <- make_bakepar()
constants <- make_constants()

photosynthesis(leaf_par, enviro_par, bake_par, constants)

```

## Help!

This package is a work in progress and I would greatly appreciate comments and criticisms, especially ideas for new features or better interface. At this time, I don't recommend using the package for serious analysis without carefully inspecting results. However, I hope that by releasing it, I will be able to work out bugs soon and provide a reliable, stable version in the near future.
