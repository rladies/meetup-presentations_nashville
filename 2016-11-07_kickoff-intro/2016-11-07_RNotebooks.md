---
title: "Resources for R Notebooks and Reproducible Research"
author: "R-Ladies Nashville"
date: "11/7/2016"
output:
  html_document:
    default
  github_document:
    default
---

# Key Points
- Reproducible reporting: Create reports that can be rerun or updated with minimal effort if, say, your data is updated.
- Literate programming: Interweave "chunks" of plain language and code, which is great for documentation of both code and analytic decisions.
- R Notebooks: Way to have code, explanatory text, and results all in a single file with complete transparency and reproducibility, due to ease of showing/hiding *all* code and ability to download complete .Rmd file which created it. Output can be shown right beneath input.

# Incomplete list of related resources

### Reproducible Research/Literate Programming
- [Intro to reproducible research from rOpenSci](http://ropensci.github.io/reproducibility-guide/sections/introduction/)
- [`knitr` package](http://yihui.name/knitr/)
- ["knitr in a knutshell" from Karl Broman](http://kbroman.org/Tools4RR/assets/lectures/03_knitr_Rmd_withnotes.pdf) (PDF)
- [RMarkdown info from RStudio](http://rmarkdown.rstudio.com/lesson-1.html)

### Markdown Syntax
- [Markdown main page](http://daringfireball.net/projects/markdown/)
- [Markdown authoring from RStudio](http://rmarkdown.rstudio.com/authoring_basics.html)

### R Notebooks
- [RStudio IDE](https://www.rstudio.com); need version 1.0 or higher for RNotebook capabilities
- [R Notebooks main page](http://rmarkdown.rstudio.com/r_notebooks.html)
- Formatting:
    - [pandoc library](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html#pandoc_markdown)
    - `html()` function in [Hmisc package](http://biostat.mc.vanderbilt.edu/wiki/Main/Hmisc) (latest release, November 2016); Harrell's [example](http://data.vanderbilt.edu/fh/R/Hmisc/examples.nb.html) of using Hmisc in an R Notebook
- [plotly](https://plot.ly/r/) for interactive graphics
