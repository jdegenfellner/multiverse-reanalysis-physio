# Schlaegt Registry-Zeilen fuer die restlichen Studien vor.
#
# Das ist ein Vorschlag, keine Entscheidung. Jede Zeile muss gegen das Paper
# geprueft werden, bevor sie in config/registry.csv wandert. Die Spalte
# `confidence` sagt, wie sicher der Vorschlag ist, `needs_check` was zu pruefen ist.

suppressMessages({library(readxl); library(haven); library(dplyr)})

ARM_PAT     <- "^(group|arm|treatment|trt|allocation|randomi|condition|gruppe)"
ID_PAT      <- "^(id|subject|participant|pat|case|studyid|record)"
TIME_PAT    <- "^(time|timepoint|visit|wave|occasion|phase|period)$"
OUTCOME_PAT <- paste0("nprs|nrps|^vas|pain|odi|oswestry|rmdq|roland|ndi|neck|dash|womac|",
                      "koos|sf36|sf_36|quickdash|tampa|tsk|pcs|fabq|6mwt|walk|gait|",
                      "rom|strength|force|grip|balance|berg|tug|godin|cmj|score|index")
BASE_SUF    <- c("pre","_pre","pre_","baseline","_base","t0","_0","1")
POST_SUF    <- c("post","_post","post_","followup","_fu","t1","_1","2")

read_any <- function(p) {
  e <- tolower(tools::file_ext(p))
  d <- try(switch(e,
    xlsx = suppressMessages(readxl::read_excel(p)),
    xls  = suppressMessages(readxl::read_excel(p)),
    csv  = utils::read.csv(p, stringsAsFactors = FALSE),
    sav  = haven::read_sav(p),
    rds  = readRDS(p), NULL), silent = TRUE)
  if (inherits(d, "try-error") || is.null(d)) return(NULL)
  # .rds kann alles enthalten, etwa ein mids-Objekt aus mice. Nur echte Tabellen.
  if (!is.data.frame(d) && !inherits(d, "tbl_df")) return(NULL)
  d <- try(as.data.frame(d), silent = TRUE)
  if (inherits(d, "try-error")) return(NULL)
  d
}

#' Findet die Armvariable: Name passt, 2 bis 4 Auspraegungen, halbwegs balanciert
find_arm <- function(d) {
  cand <- names(d)[grepl(ARM_PAT, tolower(names(d)))]
  score <- vapply(cand, function(v) {
    t <- table(d[[v]])
    if (length(t) < 2 || length(t) > 4) return(-1)
    min(t) / max(t)                                   # Balance als Guete
  }, 0)
  if (!length(score) || max(score) < 0) return(NA_character_)
  cand[which.max(score)]
}

#' Findet Paare von Outcome-Spalten, die sich nur im pre/post-Suffix unterscheiden
find_pre_post <- function(d) {
  num <- names(d)[vapply(d, function(x) is.numeric(x) || haven::is.labelled(x), TRUE)]
  low <- tolower(num)
  out <- list()
  for (i in seq_along(num)) {
    for (s in seq_along(BASE_SUF)) {
      b <- BASE_SUF[s]
      if (!grepl(paste0(b, "$"), low[i])) next
      stem <- sub(paste0(b, "$"), "", low[i])
      hit <- which(low %in% paste0(stem, POST_SUF))
      if (length(hit)) {
        out[[length(out) + 1]] <- list(base = num[i], post = num[hit[1]], stem = stem)
        break
      }
    }
  }
  out
}

propose_one <- function(folder) {
  files <- list.files(file.path(folder, "deposit"), full.names = TRUE,
                      pattern = "[.](xlsx|xls|csv|sav|rds)$")
  files <- files[!grepl("codebook|readme|dictionary|legend", tolower(basename(files)))]
  if (!length(files)) return(NULL)
  # groesste Datei zuerst, das ist meist der Analysedatensatz
  files <- files[order(-file.size(files))]

  for (f in files) {
    d <- read_any(f); if (is.null(d) || nrow(d) < 8) next
    arm <- find_arm(d); if (is.na(arm)) next
    d <- d[!is.na(d[[arm]]), , drop = FALSE]
    id  <- names(d)[grepl(ID_PAT, tolower(names(d)))][1]
    tv  <- names(d)[grepl(TIME_PAT, tolower(names(d)))][1]
    pp  <- find_pre_post(d)
    oc  <- names(d)[grepl(OUTCOME_PAT, tolower(names(d)))]

    outcome <- baseline <- NA_character_
    conf <- "niedrig"; check <- character(0)
    if (length(pp)) {
      pri <- pp[[which.max(grepl(OUTCOME_PAT, vapply(pp, `[[`, "", "stem")))]]
      outcome <- pri$post; baseline <- pri$base
      conf <- if (grepl(OUTCOME_PAT, pri$stem)) "mittel" else "niedrig"
      check <- c(check, sprintf("%d pre/post-Paare gefunden, primaeres Outcome pruefen", length(pp)))
    } else if (!is.na(tv) && length(oc)) {
      outcome <- oc[1]
      check <- c(check, "Langformat: primaeren Zeitpunkt und Outcome pruefen")
    } else if (length(oc)) {
      outcome <- oc[1]
      check <- c(check, "kein pre/post-Paar erkannt, Baseline fehlt")
    } else {
      check <- c(check, "kein Outcome-Kandidat erkannt")
    }
    arms <- names(table(d[[arm]]))
    if (length(arms) > 2) check <- c(check, sprintf("%d Arme: arm_include setzen", length(arms)))

    return(data.frame(
      study_id = basename(folder), data_file = f, sheet = "",
      id_var = ifelse(is.na(id), "", id), arm_var = arm,
      arm_include = "", arm_control = arms[1],
      outcome_var = ifelse(is.na(outcome), "", outcome),
      baseline_var = ifelse(is.na(baseline), "", baseline),
      time_var = ifelse(is.na(tv), "", tv), primary_time = "",
      covars_published = "", strat_vars = "", cluster_vars = "",
      published_est = "", published_p = "",
      n_rows = nrow(d), arm_levels = paste(arms, collapse = "|"),
      outcome_candidates = paste(head(oc, 8), collapse = ","),
      confidence = conf, needs_check = paste(check, collapse = "; "),
      stringsAsFactors = FALSE))
  }
  data.frame(study_id = basename(folder), data_file = "", sheet = "", id_var = "",
             arm_var = "", arm_include = "", arm_control = "", outcome_var = "",
             baseline_var = "", time_var = "", primary_time = "", covars_published = "",
             strat_vars = "", cluster_vars = "", published_est = "", published_p = "",
             n_rows = 0, arm_levels = "", outcome_candidates = "",
             confidence = "keiner", needs_check = "keine Armvariable erkannt",
             stringsAsFactors = FALSE)
}

if (!interactive()) {
  done <- read.csv("config/registry.csv", stringsAsFactors = FALSE)$data_file
  fold <- list.dirs("studies", recursive = FALSE)
  fold <- fold[!vapply(fold, function(f) any(grepl(basename(f), done, fixed = TRUE)), TRUE)]
  cat(length(fold), "Studien ohne Registry-Zeile\n")
  res <- dplyr::bind_rows(lapply(fold, propose_one))
  write.csv(res, "config/registry_proposed.csv", row.names = FALSE)
  cat("\nVerlaesslichkeit der Vorschlaege:\n"); print(table(res$confidence))
  cat("\nMit Outcome-Vorschlag:", sum(res$outcome_var != ""),
      "| mit Baseline:", sum(res$baseline_var != ""),
      "| mit Armvariable:", sum(res$arm_var != ""), "\n")
}
