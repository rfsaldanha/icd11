## code to prepare `mapping` dataset goes here

icd10_11 <- readr::read_tsv(
  file = "data-raw/icd11_raw_data/mapping/10To11MapToMultipleCategories.txt",
  col_types = c("cnccccn__c___")
) |>
  dplyr::rename(
    icd10_class = `10ClassKind`,
    icd10_depth = `Depth...2`,
    icd10_code = `icd10Code`,
    icd10_chapter = `icd10Chapter`,
    icd10_title = `icd10Title`,
    icd11_class = `11ClassKind`,
    icd11_depth = `Depth...7`,
    icd11_code = `icd11Code`
  )

# strsplit(x = as.character(icd10_11[16,8]), split = "&")

usethis::use_data(mapping, overwrite = TRUE)
