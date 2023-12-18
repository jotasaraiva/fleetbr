
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fleetbr <a href="https://jotasaraiva.github.io/fleetbr/"><img src="man/figures/logo.png" align="right" height="139" alt="fleetbr website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/jotasaraiva/fleetbr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jotasaraiva/fleetbr/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of `fleetbr` is to provide a dataset of nationwide vehicle
counts by state and mode of transportation in Brazil, provided by the
Brazilian Ministry of Transport.

The dataset is provided in
[`tibble`](https://github.com/tidyverse/tibble) format.

## Installation

You can install the development version of fleetbr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jotasaraiva/fleetbr")
```

## Example

This is a basic example which shows how the data is displayed:

``` r
library(fleetbr)

tail(fleetbr, 15)
#>       uf mes  ano       modal    frota
#> 28498 SP  12 2021   AUTOMOVEL 19305526
#> 28499 SP  12 2021 CAMINHONETE  2177477
#> 28500 SP  12 2021   CAMIONETA  1368114
#> 28501 SP  12 2021  UTILITARIO   404646
#> 28502 SP  12 2021 MOTOCICLETA  5119480
#> 28503 SP  12 2021  CICLOMOTOR    59006
#> 28504 SP  12 2021    MOTONETA  1076795
#> 28505 TO  12 2021       TOTAL   791463
#> 28506 TO  12 2021   AUTOMOVEL   247325
#> 28507 TO  12 2021 CAMINHONETE    78912
#> 28508 TO  12 2021   CAMIONETA    13475
#> 28509 TO  12 2021  UTILITARIO     6227
#> 28510 TO  12 2021 MOTOCICLETA   254724
#> 28511 TO  12 2021  CICLOMOTOR     1931
#> 28512 TO  12 2021    MOTONETA   106335
```

### Citation

This package can be cited as follows:

``` r
citation("fleetbr")
#> To cite package 'fleetbr' in publications use:
#> 
#>   Saraiva JPM, Santos PAB (2032). _fleetbr: Brazilian Road Fleet
#>   Dataset_. R package version 0.1.0,
#>   <https://jotasaraiva.github.io/fleetbr/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {fleetbr: Brazilian Road Fleet Dataset},
#>     author = {João Pedro Melani Saraiva and Pedro Augusto Borges Santos},
#>     year = {2032},
#>     note = {R package version 0.1.0},
#>     url = {https://jotasaraiva.github.io/fleetbr/},
#>   }
```
