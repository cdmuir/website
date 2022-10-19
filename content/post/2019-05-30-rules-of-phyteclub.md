+++
title = "Rules of phyteclub"

date = 2019-05-30T00:00:00
lastmod = 2019-05-30T08:20:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Chris Muir"]

math = true

tags = ["phyteclub", "plant physiology", "tutorials"]
summary = "Getting started with **phyteclub**"
+++

{{< tweet user="BaxterTwi" id="1130910377322209280" >}}

I'm preparing my poster for the [Gordon Research Conference on CO$_2$ Assimilation]({{< ref "/talk/2019-06-09-grc" >}}), which will introduce what I'm provisionally calling **phyteclub**, a suite of R packages for modeling and data analysis in plant ecophysiology. My poster will include a very short tutorial on how to get started in **phyteclub**, so I'm reproducing that here as a blog post.

## Rules of **phyteclub**

1. The first rule of **phyteclub** is: you do talk about **phyteclub**! Please [email me](mailto:cdmuir@hawaii.edu) ot file issues on [GitHub](https://cdmuir.github.com).

2. The second rule of **phyteclub** is: you do talk about **phyteclub**! If you find one of these packages useful in your research or teaching, please cite it. You can find citation information using `citation("package_name")`. Mahalo!

3. [Install R](https://cran.r-project.org/)

4. (Optional but recommended) [Install RStudio](https://www.rstudio.com/products/RStudio/)

5. Install maturing^["The API (application programming interface) of a maturing package has been roughed out, but finer details likely to change. Once released to CRAN, we will strive to maintain backward compatibility, but the package needs wider usage in order to get more feedback and find the optimal API." https://www.tidyverse.org/lifecycle/] packages from [CRAN](https://cran.r-project.org/). Open the R application and install packages using the following code:
  
        install.packages("gunit")
        install.packages("photosynthesis")
        install.packages("tealeaves")

6. Install experimental^["An experimental package is in the very early stages of development. The API (application programming interface) will be changing frequently as we rapidly iterate and explore variations in search of the best fit. Experimental packages will make API breaking changes without deprecation, so you are generally best off waiting until the package is more mature before you use it. Experimental packages will not be released on CRAN." https://www.tidyverse.org/lifecycle/] packages from [GitHub](https://github.com/cdmuir). Open the R application and install packages using the following code:

        install.packages("remotes")
        remotes::install_github("leafoptimizer")

7. You're ready to go! See Vignettes associated with the [{tealeaves}](https://github.com/cdmuir/tealeaves) and [{photosynthesis}](https://github.com/cdmuir/photosynthesis) packages.


I want to provide an update on work I've been doing lately to improve the computational toolkit for plant ecophysiologists, specifically using [R](https://cran.r-project.org). This is very much a work-in-progress, but since I've recently released the first R packages related to this work on CRAN (see [here](https://CRAN.R-project.org/package=gunit), [here](https://CRAN.R-project.org/package=tealeaves), and [here](https://CRAN.R-project.org/package=photosynthesis)), I wanted to write a short post explaining my motivation and how these packages fit into the big-picture changes I would like to make in plant ecophysiology and its integration with evolutionary biology.
