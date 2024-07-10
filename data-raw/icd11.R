## code to prepare `icd11en` dataset goes here

icd11en <- readr::read_tsv(
  file = "data-raw/icd11_raw_data/SimpleTabulation-ICD-11-MMS-en/SimpleTabulation-ICD-11-MMS-en.txt",
  col_types = c("c_ccccilc_llccccc_")
) |>
  dplyr::rename(TitleEN = Title) |>
  dplyr::mutate(uri_code = gsub("http://id.who.int/icd/entity/", "", `Foundation URI`)) |>
  dplyr::select(-`Foundation URI`) |>
  dplyr::mutate(TitleEN = gsub("- ", "", TitleEN))

icd11pt <- readr::read_tsv(
  file = "data-raw/icd11_raw_data/SimpleTabulation-ICD-11-MMS-pt/SimpleTabulation-ICD-11-MMS-pt.txt",
  col_types = c("__cccccilc_llccccc_")
) |>
  dplyr::rename(TitlePT = Title) |>
  dplyr::select("TitlePT", "TitleEN", "Code", "ChapterNo") |>
  dplyr::mutate(TitleEN = gsub("- ", "", TitleEN)) |>
  dplyr::mutate(TitlePT = gsub("- ", "", TitlePT))

icd11es <- readr::read_tsv(
  file = "data-raw/icd11_raw_data/SimpleTabulation-ICD-11-MMS-es/SimpleTabulation-ICD-11-MMS-es.txt",
  col_types = c("__cccccilc_llccccc_")
) |>
  dplyr::rename(TitleES = Title) |>
  dplyr::select("TitleES", "TitleEN", "Code", "ChapterNo") |>
  dplyr::mutate(TitleEN = gsub("- ", "", TitleEN)) |>
  dplyr::mutate(TitleES = gsub("- ", "", TitleES))

icd11 <- dplyr::inner_join(icd11en, icd11pt, by = c("TitleEN", "Code", "ChapterNo")) |>
  dplyr::inner_join(icd11es, by = c("TitleEN", "Code", "ChapterNo")) |>
  dplyr::relocate(TitlePT, TitleES, .after = TitleEN) |>
  dplyr::rename(
    code = Code,
    block_id = BlockId,
    title_en = TitleEN,
    title_pt = TitlePT,
    title_es = TitleES,
    class = ClassKind,
    depth = DepthInKind,
    is_residual = IsResidual,
    chapter = ChapterNo,
    is_leaf = isLeaf,
    primary_tabulation = `Primary tabulation`,
    gr_1 = Grouping1,
    gr_2 = Grouping2,
    gr_3 = Grouping3,
    gr_4 = Grouping4,
    gr_5 = Grouping5
  )

usethis::use_data(icd11, overwrite = TRUE, compress = "xz")
