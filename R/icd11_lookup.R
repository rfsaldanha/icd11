#' Look up ICD-11 code tables
#'
#' @param x character. ICD-11 code for exact match.
#' @param simple logical. \code{TRUE} return a simplified result, with chapter, code and title (default). \code{FALSE} return the all variables.
#' @param lang character. Language for title. Default is \code{en}.
#'
#' @return a data.frame
#' @export
#'
#' @examples
#' icd11_lookup("1A03.1")
#' icd11_lookup("1A03.1", simple = FALSE)
#' icd11_lookup("1A03.1", lang = "pt")
icd11_lookup <- function(x, simple = TRUE, lang = "en"){
  # Convert to uppercase
  x <- toupper(x)

  # Lookup
  res <- icd11::icd11[icd11::icd11$code %in% x,]

  # Simple output
  if(simple & lang == "en"){
    res <- res[,c("chapter","code", "title_en")]
  } else if(simple & lang == "pt"){
    res <- res[,c("chapter","code", "title_pt")]
  } else if(simple & lang == "es"){
    res <- res[,c("chapter","code", "title_es")]
  }

  # Remove row numbers
  rownames(res) <- NULL

  return(res)
}
