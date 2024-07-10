#' Convert ICD10 codes to ICD11
#'
#' This function used a mapping table (\code{mapping_icd10_11}) to look for matches.
#'
#' @param x character. ICD10 codes. If you supply only the start of the ICD10 code, it will match based on the start of the code.
#' @param ... arguments passed to \code{icd11_lookup}
#'
#' @return a list.
#' @export
#'
#' @examples
#' icd10to11("a01")
#' icd10to11("a01", lang = "pt")
#' icd10to11("A06.6", simple = TRUE)
#' icd10to11("A01", simple = FALSE)
icd10to11 <- function(x, ...){

  # Convert to uppercase
  x <- toupper(x)

  # Find matches starting with x on mapping table
  cat_mapping_icd10_11 <- icd11::mapping_icd10_11[icd11::mapping_icd10_11$icd10_class %in% c("category","modifiedcategory"),]
  sel <- grepl(pattern = paste0("^",x), x = cat_mapping_icd10_11$icd10_code)

  # Filter those matches
  res <- unique(cat_mapping_icd10_11[sel,"icd11_code"])

  # Replace / with &
  res <- gsub("/", "&", x = res)

  # Split result to a list
  res_ls <- strsplit(x = res, split = "&")

  # Look up mappings for each
  purrr::map(res_ls, icd11_lookup, ...)

}


