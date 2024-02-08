library(tidyverse)
library(here)
library(rvest)
library(readxl)
library(tools)

page_list <- c(
  "https://www.gov.br/transportes/pt-br/assuntos/transito/arquivos-senatran/estatisticas/renavam/2011/frota_2011.zip",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/arquivos-senatran/estatisticas/renavam/2012/frota_2012.zip",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2013",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2014",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2015",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2016",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2017",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2018",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2019",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2020",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2021",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2022",
  "https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2023"
)

read_fleet <- function(file) {

  ext <- file_ext(file)

  if (ext == "zip") {

    temp <- tempfile()

    download.file(file, destfile = temp)

    file_name <- unzip(temp, list = T)$Name

    unzip(temp, exdir = tempdir())

    data <- read_excel(
      paste0(tempdir(),"/",file_name),
      sheet = 2,
      skip = 3
    )

    unlink(paste0(tempdir(),"/",file_name))
    unlink(temp)

    return(data)
  }

  else if (ext == "xlsx") {

    tryCatch(
      expr = {
        name <- "tempfile.xlsx"

        download.file(file, destfile = name, mode = "wb")

        data <- read_excel(name, sheet = 2, skip = 3)

        unlink(name)

        return(data)
      },
      error = function(e) {
        name <- "tempfile.xlsx"

        download.file(file, destfile = name, mode = "wb")

        data <- read_excel(name, sheet = 1, skip = 3)

        unlink(name)

        return(data)
      }
    )

  }

  else if (ext == "xls") {

    name <- "tempfile.xls"

    download.file(file, destfile = name, mode = "wb")

    data <- read_excel(name, sheet = 1, skip = 2)

    unlink(name)

    return(data)
  }

  else {
    data <- 0
    return(data)
  }
}

fleet_links <- function(url) {
  page <- read_html(url)

  links <- page |>
    html_elements("a") |>
    html_attr("href")

  link_texts <- page |>
    html_elements("a") |>
    html_text2()

  ids <- link_texts |>
    tolower() |>
    str_detect("por (município|municipio)") |>
    which(TRUE)

  files <- links[ids]

  return(files)
}

read_fleet_page <- function(page) {
  links <- rev(fleet_links(page))

  frota <- lapply(links, read_fleet)

  for (i in 1:length(frota)) {
    x <- frota[[i]]
    x <- x[x$UF != "UF", ]
    x$ANO <- str_extract(page, "(1|2)\\d{3}")
    x$MES <- i
    frota[[i]] <- x
  }

  frota <- lapply(frota, select, c(UF,TOTAL,AUTOMOVEL, BONDE, CAMINHAO, `CAMINHAO TRATOR`, CAMINHONETE, CAMIONETA, `CHASSI PLATAF`, CICLOMOTOR, `MICRO-ONIBUS`, MOTOCICLETA, MOTONETA, ONIBUS, QUADRICICLO, REBOQUE, `SEMI-REBOQUE`, `SIDE-CAR`, OUTROS, `TRATOR ESTEI`, `TRATOR RODAS`, TRICICLO, UTILITARIO, MES, ANO))
  frota <- lapply(
    frota,
    mutate,
    across(!UF, as.numeric)
  )

  frota <- reduce(frota, full_join)

  return(frota)
}

read_fleet2011 <- function() {

  folder <- here("data-raw","frota_mensal","frota_2011","Frota Munic. 2011")
  files <- str_sort(list.files(folder), numeric = T)
  paths <- paste(sep = "/", folder, files)

  frota <- lapply(paths, read_excel, sheet = 2, skip = 2)

  for (i in 1:length(frota)) {
    x <- frota[[i]]
    x <- x[x$UF != "UF", ]
    x$ANO <- 2011
    x$MES <- i
    frota[[i]] <- x
  }

  frota <- lapply(frota, select, c(UF,TOTAL,AUTOMOVEL, BONDE, CAMINHAO, `CAMINHAO TRATOR`, CAMINHONETE, CAMIONETA, `CHASSI PLATAF`, CICLOMOTOR, `MICRO-ONIBUS`, MOTOCICLETA, MOTONETA, ONIBUS, QUADRICICLO, REBOQUE, `SEMI-REBOQUE`, `SIDE-CAR`, OUTROS, `TRATOR ESTEI`, `TRATOR RODAS`, TRICICLO, UTILITARIO, MES, ANO))
  frota <- lapply(
    frota,
    mutate,
    across(!UF, as.numeric)
  )

  frota <- reduce(frota, full_join)

  return(frota)
}

read_fleet2012 <- function() {

  folder <- here("data-raw","frota_mensal","frota_2012","Frota Munic. 2012")
  files <- str_sort(list.files(folder), numeric = T)
  paths <- paste(sep = "/", folder, files)

  frota <- lapply(paths, read_excel, sheet = 2, skip = 2)

  for (i in 1:length(frota)) {
    x <- frota[[i]]
    x <- x[x$UF != "UF", ]
    x$ANO <- 2012
    x$MES <- i
    frota[[i]] <- x
  }

  frota <- lapply(frota, select, c(UF,TOTAL,AUTOMOVEL, BONDE, CAMINHAO, `CAMINHAO TRATOR`, CAMINHONETE, CAMIONETA, `CHASSI PLATAF`, CICLOMOTOR, `MICRO-ONIBUS`, MOTOCICLETA, MOTONETA, ONIBUS, QUADRICICLO, REBOQUE, `SEMI-REBOQUE`, `SIDE-CAR`, OUTROS, `TRATOR ESTEI`, `TRATOR RODAS`, TRICICLO, UTILITARIO, MES, ANO))
  frota <- lapply(
    frota,
    mutate,
    across(!UF, as.numeric)
  )

  frota <- reduce(frota, full_join)

  return(frota)
}

read_fleet2015 <- function() {
  folder <- here("data-raw","frota_mensal","frota_2015")
  files <- str_sort(list.files(folder), numeric = T)
  paths <- paste(sep = "/", folder, files)

  frota <- lapply(paths, read_excel, sheet = 2, skip = 2)

  for (i in 1:length(frota)) {
    x <- frota[[i]]
    x <- x[x$UF != "UF", ]
    x$ANO <- 2015
    x$MES <- i
    frota[[i]] <- x
  }

  frota <- lapply(frota, select, c(UF,TOTAL,AUTOMOVEL, BONDE, CAMINHAO, `CAMINHAO TRATOR`, CAMINHONETE, CAMIONETA, `CHASSI PLATAF`, CICLOMOTOR, `MICRO-ONIBUS`, MOTOCICLETA, MOTONETA, ONIBUS, QUADRICICLO, REBOQUE, `SEMI-REBOQUE`, `SIDE-CAR`, OUTROS, `TRATOR ESTEI`, `TRATOR RODAS`, TRICICLO, UTILITARIO, MES, ANO))
  frota <- lapply(
    frota,
    mutate,
    across(!UF, as.numeric)
  )

  frota <- reduce(frota, full_join)

  return(frota)
}

read_fleet2016 <- function() {
  folder <- here("data-raw","frota_mensal","frota_2016")
  files <- str_sort(list.files(folder), numeric = T)
  paths <- paste(sep = "/", folder, files)

  readfunc <- function(path) {
    tryCatch(
      expr = {
        frota <- read_excel(path, sheet = 2, skip = 3)
        return(frota)
      },
      error = function(e) {
        frota <- read_excel(path, sheet = 1, skip = 3)
        return(frota)
      }
    )
  }

  frota <- lapply(paths, readfunc)

  for (i in 1:length(frota)) {
    x <- frota[[i]]
    x <- x[x$UF != "UF", ]
    x$ANO <- 2016
    x$MES <- i
    frota[[i]] <- x
  }

  frota <- lapply(frota, select, c(UF,TOTAL,AUTOMOVEL, BONDE, CAMINHAO, `CAMINHAO TRATOR`, CAMINHONETE, CAMIONETA, `CHASSI PLATAF`, CICLOMOTOR, `MICRO-ONIBUS`, MOTOCICLETA, MOTONETA, ONIBUS, QUADRICICLO, REBOQUE, `SEMI-REBOQUE`, `SIDE-CAR`, OUTROS, `TRATOR ESTEI`, `TRATOR RODAS`, TRICICLO, UTILITARIO, MES, ANO))
  frota <- lapply(
    frota,
    mutate,
    across(!UF, as.numeric)
  )

  frota <- reduce(frota, full_join)

  return(frota)
}

read_fleet2021 <- function() {
  links <- rev(fleet_links("https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2021"))

  readfleet <- function(path) {
    tryCatch(
      expr = {
        ext <- file_ext(path)
        name <- paste0("tempfile.",ext)
        download.file(path, destfile = name, mode = "wb")
        data <- read_excel(name, sheet = 2, skip = 2)
        unlink(name)
        return(data)
      },
      error = function(e) {
        ext <- file_ext(path)
        name <- paste0("tempfile.",ext)
        download.file(path, destfile = name, mode = "wb")
        data <- read_excel(name, sheet = 1, skip = 2)
        unlink(name)
        return(data)
      }
    )
  }

  frota <- lapply(links, readfleet)

  for (i in 1:length(frota)) {
    x <- frota[[i]]
    x <- x[x$UF != "UF", ]
    x$ANO <- 2021
    x$MES <- i
    frota[[i]] <- x
  }

  frota <- lapply(frota, select, c(UF,TOTAL,AUTOMOVEL, BONDE, CAMINHAO, `CAMINHAO TRATOR`, CAMINHONETE, CAMIONETA, `CHASSI PLATAF`, CICLOMOTOR, `MICRO-ONIBUS`, MOTOCICLETA, MOTONETA, ONIBUS, QUADRICICLO, REBOQUE, `SEMI-REBOQUE`, `SIDE-CAR`, OUTROS, `TRATOR ESTEI`, `TRATOR RODAS`, TRICICLO, UTILITARIO, MES, ANO))
  frota <- lapply(
    frota,
    mutate,
    across(!UF, as.numeric)
  )

  frota <- reduce(frota, full_join)

  return(frota)
}

read_fleet2022 <- function() {
  links <- rev(fleet_links("https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/frota-de-veiculos-2022"))

  readfleet <- function(path) {
    tryCatch(
      expr = {
        ext <- tools::file_ext(path)
        name <- paste0("tempfile.",ext)
        download.file(path, destfile = name, mode = "wb")
        data <- readxl::read_excel(name, sheet = 2, skip = 2)
        unlink(name)
        return(data)
      },
      error = function(e) {
        ext <- tools::file_ext(path)
        name <- paste0("tempfile.",ext)
        download.file(path, destfile = name, mode = "wb")
        data <- readxl::read_excel(name, sheet = 1, skip = 2)
        unlink(name)
        return(data)
      }
    )
  }

  frota <- lapply(links, readfleet)

  for (i in 1:length(frota)) {
    x <- frota[[i]]
    x <- x[x$UF != "UF", ]
    x$ANO <- 2022
    x$MES <- i
    frota[[i]] <- x
  }

  frota <- lapply(frota, select, c(UF,TOTAL,AUTOMOVEL,CAMINHONETE,
                                   CAMIONETA,UTILITARIO,MOTOCICLETA,
                                   CICLOMOTOR,MOTONETA,MES,ANO))
  frota <- lapply(
    frota,
    mutate,
    across(!UF, as.numeric)
  )

  frota <- reduce(frota, full_join)

  return(frota)
}

fleet_transform <- function(path) {
  ano <- str_extract(path, "(1|2)\\d{3}")

  if (ano == "2011") {
    frota <- read_fleet2011()
  }
  else if (ano == "2012") {
    frota <- read_fleet2012()
  }
  else if (ano == "2015") {
    frota <- read_fleet2015()
  }
  else if (ano == "2016") {
    frota <- read_fleet2016()
  }
  else if (ano == "2021") {
    frota <- read_fleet2021()
  }
  else if (ano == "2022") {
    frota <- read_fleet2022()
  } else {
    frota <- read_fleet_page(path)
  }

  return(frota)
}

fleetbr <- lapply(page_list, fleet_transform) |>
  reduce(full_join) |>
  pivot_longer(-c(UF, MES,ANO), names_to = "modal", values_to = "frota") |>
  rename(mes = MES,
         ano = ANO,
         uf = UF) |>
  summarise(
    .by = c("uf","mes","ano","modal"),
    frota = sum(frota)
  )

usethis::use_data(fleetbr, overwrite = TRUE)
