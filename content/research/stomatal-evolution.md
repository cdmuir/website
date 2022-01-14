+++
# Date this page was created.
date = 2018-10-08T00:00:00

# Project title.
title = "Variation and constraint on stomatal evolution"

# Project summary to display on homepage.
summary = "Stomata are a model trait to study the causes leading to variation and constraint on phenotypic evolution."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "pimpinellifolium_upper_stomata.jpg"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["macroevolution", "stomata"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = true

# Optional featured image (relative to `static/img/` folder).
# [header]
# image = "headers/bubbles-wide.jpg"
# caption = "My caption :smile:"

+++

The major unresolved question in macroevolution is how fitness optima vary across large spans of time and space. Stomata are a fascinating trait for studying macroevolutionary processes because of their important but potentially conflicting roles in both abiotic and biotic interactions. Stomata are microscopic pores in a leaf that play an outsized role in plant ecology by allowing plants to tightly regulate water loss and CO$_2$ gain. Interestingly, stomata are also a major route of infection by foliar pathogens such as fungi and bacteria. I have been particularly interested in why most stomata are only on the lower surface of the leaf (hypostomy). Biophysical models actually predict that all plants should be amphistomatous (stomata on upper and lower leaf surfaces) to maximize photosynthesis, yet ~90% of plant species are hypostomatous. Across flowering plants, the relationship between stomatal ratio and growth indicates remarkably strong selection on efficient CO$_2$ supply in species with fast life histories (Muir 2015) from high light habitats (Muir 2018). Annual forbs from open habitats are nearly always amphistomatous; trees and shade tolerant herbs are nearly always hypostomatous. However, there must be a cost to amphistomy, otherwise it would be ubiquitous. Stomata on the upper surface might increase susceptibility to foliar pathogens that infect through stomata. Thus, stomata could mediate a tradeoff between photosynthesis and pathogen defense, but this is poorly studied.

I also discovered a wholly unanticipated aspect of stomatal evolution. Stomatal ratio is bimodal and occupies only part of the feasible trait space: plants are completely hypostomatous (all stomata on the lower surface) or have about half of their stomata on each surface, but intermediate trait values are rare. Lack of genetic variation and developmental constraints probably do not explain bimodality (Muir *et al*. 2015). Instead, mathematical models reveal that bimodality might be a consequence of a tradeoff between pathogen defense and photosynthesis (Muir 2015). Next, I plan to test this hypothesis using theory and experiments on wild tomatoes as a model system. There is nearly as much variation in stomatal ratio among tomato species as in all flowering plants (Muir *et al*. 2014). I have also identified large-effect loci that explain most of the difference between hypo- and amphistomatous species (Muir *et al*. 2014). Importantly, genetic tools in tomatoes will allow me to measure the effect of stomatal ratio on photosynthesis and pathogens in isolation from other traits. I will also develop `leafevolvr`, an R package using biophysical models to predict optimal stomatal and other leaf traits across key environmental gradients such as light.
