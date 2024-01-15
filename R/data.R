#' Brazilian Ministry of Transport Road Fleet data
#'
#' This is a long format dataset based on the road fleet databases
#' provided by the Brazilian Ministry of Transport. All variables
#' are encoded to Brazilian Portuguese.
#'
#' @format ## `fleetbr`
#' A `tibble` data frame with 78,408 and 5 columns:
#' \describe{
#'   \item{uf}{Federative Unit - Brazilian States Acronyms}
#'   \item{mes, ano}{Month and Year}
#'   \item{modal}{Mode of transport of observation}
#'   \item{frota}{Fleet size}
#' }
#' @source <https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/estatisticas-frota-de-veiculos-senatran>
"fleetbr"
