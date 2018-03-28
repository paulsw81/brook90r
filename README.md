
<!-- README.md is generated from README.Rmd. Please edit that file -->
brook90r: run the LWF-BROOK90 hydrological model from within R

Motivation
==========

In hydrology, many R-packages exist that deal with pre- and post-processing of input data and results of hydrological process models. In addition, many ready-to-use algorithms exist in R that provide automatic calibration, sensitivity analysis, and parallelisation techniques. In order to make the vast resources of R directly available to the widely used 1D-SVAT model [LWF-BROOK90](https://www.lwf.bayern.de/boden-klima/wasserhaushalt/index.php), *brook90r* was developed to serve as an interface to the LWF-BROOK90 executable commandline program.

Basicly, brook90r features the following functionality in one function call:

-   write input files from climate driving data, model control options and parameters,
-   start the commandline-program LWF-BROOK90,
-   read and return the created output files.

The model control options thereby let you select different functions for defining aboveground stand dynamics, phenology, root length density distributions and soil hydraulic properties, just like the original MS Access GUI, which is distributed with the commandline tool.

Example
=======

Load brook90r

``` r
library(brook90r)
#> Warning: package 'data.table' was built under R version 3.2.5
```

Load sample meteo and soil data

``` r
data("meteo_slb1")
data("soil_slb1")
```

Set up lists containing model control options and model parameters

``` r
param.b90 <- MakeParam.B90()
options.b90 <- MakeIniControl.B90()
```

Set new start and end dates in model control options

``` r
options.b90$startdate <- as.Date("2002-01-01")
options.b90$enddate <- as.Date("2004-12-31")
```

Derive soil hydraulic properties from soil physical properties using a pedotransfer function

``` r
soil <- cbind(soil_slb1, hydpar_puh2(clay = soil_slb1$clay,
                                     silt = soil_slb1$silt,
                                     sand = soil_slb1$sand,
                                     bd = soil_slb1$bd,
                                     oc.pct = soil_slb1$c_org))
```

Run LWF-Brook90 and store the results in b90.results.slb1

``` r
b90.results.slb1 <- Run.B90(directory = "/example_run_b90/",
                            param = param.b90,
                            inicontrol = options.b90,
                            soil = soil,
                            climate = meteo_slb1,
                            path_b90.exe = "H:/B90/b90.exe"
                            )
```

Status
======

The package works as intended and is sufficiently documented, but needs testing and a detailed user manual (vignette).

Usage
=====

The package is not on CRAN, so use the devtools-package to install directly from github.com:

``` r
devtools::install_github("pschmidtwalter/brook90r")
```

Additionally, you will need to install Robert Nuske's *vegperiod* package, and the *data.table* package.

``` r
install.packages("vegperiod", repos="https://www.nw-fva.de/r-pkgs")
install.packages("data.table", repos="https://cran.rstudio.com/")
```

Requirements
============

You can use the built-in functions without carrying out any water balance simulations. However, the central function *Run.B90* will only work with the small windows commandline tool 'b90.exe' which is not publicly available. However, the interested user can obtain 'b90.exe' directly from the [Bavarian State Institute of Forestry (LWF)](http://www.lwf.bayern.de/), [Departement Soil and Climate.](https://www.lwf.bayern.de/boden-klima/wasserhaushalt/index.php)

Author
======

Paul Schmidt-Walter

License
=======

GPL-3 for the package. License for LWF-BROOK90 is unknown.
