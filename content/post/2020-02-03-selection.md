+++
title = "Survivorship measures both relative and absolute fitness"

date = 2020-02-03T00:00:00
lastmod = 2020-02-03T16:20:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["evolution"]
summary = "Survivorship measures soft and hard selection"
+++

I recently reviewed a very good paper that (in the original version) claimed there was no way to turn surivorship (i.e. the proportion of a genotype or whatever that survives in a selection experiment) into relative fitness. This struck me as odd, but the authors are very knowledgeable in this area, so I did some digging. I came to realize that the probability of survival is both a measure of absolute and relative fitness. I'm sure this has been proven before, but I wasn't aware of it, so I wrote up the proof here with a mini-example, just in case it's useful to others. If you know of someone who has shown this previously, I'd appreciate the reference. Thanks!

### The probability of survival *is* a relative measure of relative fitness (and absolute fitness!).

In their original submission (since revised), the authors stated that they are only measuring absolute fitness for viability because "[i]t was not possible to evaluate relative fitness in a logistic regression framework." Here I want to show that the probability of survivorship, which is the parameter fit with logistic regression in this case, is a measure of *both* absolute and relative fitness. 

The key property of absolute fitness ($W_i$) is that it is proportional to the change in abundance from $t$ to $t + 1$:

$$ N_i(t + 1) = W_i N_i(t) $$

The key property of relative fitness ($w_i$) is that it is proportional to the change in genotype frequency from $t$ to $t + 1$:

$$ p_i(t + 1) = w_i p_i(t) $$

The probability of survivorship fulfills both of these relationships, as I'll show with a toy example (haploid, two-allele, one-locus system), but it should generalize to any number of genotypes or change in probability density if you're talking about a quantitative trait. 

Let's imagine two alleles $a$ and $A$ with proportions at time $t$, $p_a(t)$ and $p_A(t) = 1 - p_a(t)$. Assume that the proportion surviving from $t$ to $t + 1$ is $W_a$ and $W_A$. This is absolute fitness because if $W_i = 0.5$ and $N_i(t) = 100$, then $N_i(t + 1) = W_i N_i(t) = 50$. 

The average fitness is $\bar{W} = p_a W_a + p_A W_A$ and the relative fitnesses are $w_a = W_a / \bar{W}$ and $w_A = W_A / \bar{W}$.

If there are $N = 100$ individuals and 40 of them have $a$ and 60 have $A$, then $p_a = 0.4$, $p_A = 0.6$. Assume that 4/5 of $a$ survive and 3/5 of $A$ survive ($W_a = 0.8,~W_A = 0.6$), then the abundances in the next generation are $N p_a W_a = 100 \times 0.4 \times 0.8 = 32$ and $N p_A W_A = 100 \times 0.6 \times 0.6 = 36$. Hence, the allele frequencies in the next generation are $p_a(t + 1) = 32 / (32 + 36) = 0.47$ and $p_A(t + 1) = 36 / (32 + 36) = 0.53$. This fulfills the definition of relative fitness: $w_a = W_a / \bar{W} = 0.8 / (0.4 \times 0.8 + 0.6 \times 0.6) = 1.18$ and $w_A = W_A / \bar{W} = 0.6 / (0.4 \times 0.8 + 0.6 \times 0.6) = 0.88$, therefore it's true that $p_a(t + 1) = w_a p(t) = 1.18 \times 0.4 = 0.47$ and $p_A(t + 1) = w_A p(t) = 0.88 \times 0.6 = 0.53$

Below is some R code demonstrating these calculations.

```{r, message = FALSE}

# Libraries
library(magrittr)
library(tibble)

# Parameters
N <- 100
N_a <- 40
N_A <- N - N_a
p_a <- N_a / N
p_A <- 1 - p_a

W_a <- 0.8
W_A <- 0.6

W_bar <- p_a * W_a + p_A * W_A
w_a <- W_a / W_bar
w_A <- W_A / W_bar

# Calculations
tibble::tibble(
  Genotype = c("$a$", "$A$", "Total"),
  `$N(t)$` = c(N_a, N_A, N),
  `$p(t)$` = c(p_a, p_A, 1),
  `$W$` = c(W_a, W_A, p_a * W_a + p_A * W_A),
  `$\\bar{W}$` = p_a * W_a + p_A * W_A,
  `$w$` = `$W$` / `$\\bar{W}$`,
  `$N(t + 1)$` = `$N(t)$` * `$W$`,
  `$p(t + 1)$` = `$N(t + 1)$` / `$N(t + 1)$`[3]
) %>%
  
  # Print table
  knitr::kable(digits = 2)

```
