
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fleetbr <a href="https://jotasaraiva.github.io/fleetbr/"><img src="man/figures/logo.png" align="right" height="139" alt="fleetbr website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/jotasaraiva/fleetbr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jotasaraiva/fleetbr/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

The goal of `fleetbr` is to provide a dataset of nationwide vehicle
counts by state and mode of transportation in Brazil, provided by the
Brazilian Ministry of Transport.

The dataset is provided in
[`tibble`](https://github.com/tidyverse/tibble) format.

## Installation

You can install the development version of fleetbr from
[GitHub](https://github.com/jotasaraiva/fleetbr) with:

``` r
# install.packages("devtools")
devtools::install_github("jotasaraiva/fleetbr")
```

## Example

This is a basic example which shows how the data is displayed:

``` r
library(fleetbr)

head(fleetbr, 15)
#>    uf mes  ano           modal  frota
#> 1  AC   1 2011           TOTAL 152592
#> 2  AC   1 2011       AUTOMOVEL  51188
#> 3  AC   1 2011           BONDE      0
#> 4  AC   1 2011        CAMINHAO   5180
#> 5  AC   1 2011 CAMINHAO TRATOR    436
#> 6  AC   1 2011     CAMINHONETE  14719
#> 7  AC   1 2011       CAMIONETA   2630
#> 8  AC   1 2011   CHASSI PLATAF     12
#> 9  AC   1 2011      CICLOMOTOR     10
#> 10 AC   1 2011    MICRO-ONIBUS    174
#> 11 AC   1 2011     MOTOCICLETA  62683
#> 12 AC   1 2011        MOTONETA  12448
#> 13 AC   1 2011          ONIBUS    584
#> 14 AC   1 2011     QUADRICICLO      0
#> 15 AC   1 2011         REBOQUE   1180
```

### Citation

This package can be cited as follows:

``` r
citation("fleetbr")
#> To cite package 'fleetbr' in publications use:
#> 
#>   Saraiva JPM, Santos PAB (2024). _fleetbr: Brazilian Vehicle Fleet
#>   Dataset_. R package version 0.2.2,
#>   https://github.com/jotasaraiva/fleetbr,
#>   <https://jotasaraiva.github.io/fleetbr/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {fleetbr: Brazilian Vehicle Fleet Dataset},
#>     author = {João Pedro Melani Saraiva and Pedro Augusto Borges Santos},
#>     year = {2024},
#>     note = {R package version 0.2.2, https://github.com/jotasaraiva/fleetbr},
#>     url = {https://jotasaraiva.github.io/fleetbr/},
#>   }
```
