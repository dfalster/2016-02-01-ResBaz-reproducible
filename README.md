# Example analysis

This repository contains some example code, used as during teaching of software carpentry bootcamps, e.g. [nicercode.github.io/2016-02-01-ResBaz/lessons](http://nicercode.github.io/2016-02-01-ResBaz/lessons/).

## Example 1 - Using the standard R tools



## Example 2 - Using the package `remake`

First install some dependencies from cran as follows:

```r
install.packages(c("R6", "yaml", "digest", "crayon", "optparse", "storr", "devtools"))
```

Now we'll install some packages from [github](github.com). For this, we'll use the package [devtools](https://github.com/hadley/devtools), which we installed above.

Then install the package

```r
devtools::install_github("richfitz/remake")
```
See the info in the [remake readme](https://github.com/richfitz/remake) for further details if needed.

### Running

Open up the folder `2-remake` and open up a new R session within that folder (e.g. by clicking on the folder `remake.Rproj`). We use a number of packages, these can be easily installed by remake:

```r
remake::install_missing_packages()
```

Then, to generate the figures and tables, run

```r
remake::make()
```

To generate the knitr report, run

```r
remake::make("report.docx")
```
