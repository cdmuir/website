+++
title = "Within species comparative methods"

date = 2018-10-26T00:00:00
lastmod = 2018-10-26T00:00:00
draft = true

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

tags = ["comparative methods", "science"]
summary = "Extending between species methods to within species is hard."

# Does the does blog post use math formatting?
math = true

+++

Many evolutionary biologists and biologists in other fields are now familiar with using phylogenies in their comparative studies and phylogenetic comparative methods (PCMs) continue to develop rapidly. One of the problems PCMs attempt to solve is the fact that species and other taxanomic units are not statistically independent of one another. Obviously the same concern applies to populations within species, which vary in their relatedness due to both common ancestry and ongoing migration. Yet many researchers who would get a case of the vapors if they published a nonphylogenetic between-species comparative study, readily analyze within-species datasets as if populations are independent units (including [myself]({{< ref "/publication/muir-angert-2017.md" >}})).

Why this double-standard and what should we do about it? This problem has come up in my own work and my answer was "do nothing". I justified this on two grounds. I couldn't find a suitable method that wasn't:

1. likely to confound the very pattern I was testing for; and
2. used data I had access to in a reasonable timeframe.

Example equation:

$$ y = m x + b $$

Example code chunk:

```{r example}

x <- 1:10
x

```

More words