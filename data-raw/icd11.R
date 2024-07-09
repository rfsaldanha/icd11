## code to prepare `icd11en` dataset goes here

icd11en <- readr::read_tsv(
  file = "data-raw/icd11_raw_data/SimpleTabulation-ICD-11-MMS-en/SimpleTabulation-ICD-11-MMS-en.txt",
  col_types = c("__ccccilc_llccccc_")
) |>
  dplyr::rename(TitleEN = Title)

icd11pt <- readr::read_tsv(
  file = "data-raw/icd11_raw_data/SimpleTabulation-ICD-11-MMS-pt/SimpleTabulation-ICD-11-MMS-pt.txt",
  col_types = c("__cccccilc_llccccc_")
) |>
  dplyr::rename(TitlePT = Title) |>
  dplyr::select("TitlePT", "TitleEN", "Code", "ChapterNo")

icd11es <- readr::read_tsv(
  file = "data-raw/icd11_raw_data/SimpleTabulation-ICD-11-MMS-es/SimpleTabulation-ICD-11-MMS-es.txt",
  col_types = c("__cccccilc_llccccc_")
) |>
  dplyr::rename(TitleES = Title) |>
  dplyr::select("TitleES", "TitleEN", "Code", "ChapterNo")

icd11 <- dplyr::inner_join(icd11en, icd11pt, by = c("TitleEN", "Code", "ChapterNo")) |>
  dplyr::inner_join(icd11es, by = c("TitleEN", "Code", "ChapterNo")) |>
  dplyr::relocate(TitlePT, TitleES, .after = TitleEN)

usethis::use_data(icd11, overwrite = TRUE, compress = "xz")
