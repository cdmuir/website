+++
title = "BIOL 470: Gene tree and Coalescent simulations (Part 2)"

date = 2020-03-27T00:00:00
lastmod = 2020-03-29T13:37:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["biol470", "teaching", "gene tree", "phylogenetics", "coalescent"]
summary = "Simulations to learn about using gene trees to infer phylogenies"
+++

## Purpose

In the previous [post](https://cdmuir.netlify.com/post/2020-03-22-biol470-gene-trees1), we simulated gene trees for a single locus in a finite population. However, we didn't specify whether the allele copies actually had different sequences. This is important becuase if the copies are identical (i.e. have the exact same DNA sequence), it's impossible to reconstruct their relationships. Fortunately for us, DNA mutates and these mutations are passed on from one generation to the next. As we'll see, this allows us to identify which sequences are more closely related to one another and infer a phylogeny depicting the relationships among gene sequences. Later on, we'll see how multiple gene trees can be used to infer relationships among species.

Working through these simulations is self-paced. It builds off the previous [simulations](https://cdmuir.netlify.com/post/2020-03-22-biol470-gene-trees1), so I recommend doing those first. After that, I suggest the following order:

1. Read Emlen and Zimmer Chapter 8 up through section 8.5 (pg. 285)
2. Work through these simulations
 
Below I briefly introduce what's going in the simulations. Read these sections, then access the app to perform simulations on your own using the link below.

## Mutation

Previously, we simulated gene trees within a single population and examined their properties. Now we're going to add mutations. In previous simulations, we know the "true" evolutionary relationship among individuals in a population. In reality, we don't know these relationships, but we try to infer them by looking at DNA sequences. Individuals with more similar DNA are probably more closely related than those with less similar DNA. Why? Because DNA mutates and these mutations are inherited. If two individuals have the same base at the same site in their genome, it's often more likely that they inherited that mutation from a common ancestor than that they both independely acquired the identical mutation. The book discusses several methods for using variation in DNA sequences to determine evolutionary relationships and build phylogenies. We'll use simulations to work through why these methods often do a pretty good job of infering evolutionary relationships.

To do that, we'll simulate gene trees like we did previously. We'll ignore all the lineages that didn't survive to the present. On the simulated gene trees, we'll randomly place mutations on various branches. The probability of a mutation depends on the rate (how often do mutations occur at a site) and the branch length. Longer branches have more time for mutations to occur. Once a mutation occurs at a site, it's inherited by the next generation.

## Alignments

In addition to the gene tree and the mutations, the simulations produce an alignment of simulated DNA sequences. For simplicity, we're pretending that each site in the genome only has two states (blue and orange), whereas most DNA has 4 states corresponding to the different bases (A, T, C, and G). Alignments tell us whether two sequences differ or are identical at a given site. Usually, if two sites have the same character state at a site, it's likely that they inherited that character state from a common ancestor. Therefore, more similar DNA sequences are probably more closely related. However, sometimes sites are identical because of homoplasy rather than common descent. Most models used to infer phylogenies account for this possibility. Anyway, when performing simulations, you should look carefully at the mutations in the phylogeny and how those impact the sequence alignment.

## Inferred phylogenies

The simulations also infer a phylogeny from the simulated sequences and provide a measure of how close inferred trees are to the real tree. Biologists use these types of comparisons between simulated data and inferences to evaluate whether phylogenetic methods work well. You should adjust the input parameters and see how they effect the accuract of phylogenetic inference.

## Link to simulations

* [Coalescent simulations with mutations and alignments](https://cdmuir.shinyapps.io/genetree-to-phylogeny/)
