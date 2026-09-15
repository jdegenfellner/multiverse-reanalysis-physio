# UNABHAENGIGE Nachrechnung, ohne engine.R und grid.R.
# Liest Registry und Rohdaten selbst, fittet je Studie die drei Baseline-Varianten
# mit Basis-R und vergleicht: (a) mit dem publizierten Schaetzer, (b) mit den
# Spannweiten aus output/summary_by_study.csv. Wenn beides passt, ist die Pipeline
# fuer den dominanten Knoten unabhaengig bestaetigt.
suppressMessages({library(readxl); library(haven)})
g <- function(v, k) if (k %in% names(v)) unname(v[k]) else NA_real_
reg <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
pub <- read.csv("config/published.csv", stringsAsFactors = FALSE)
ov  <- read.csv("config/published_overrides.csv", stringsAsFactors = FALSE)
for (i in seq_len(nrow(ov))) pub$published_est[pub$study_id == ov$study_id[i]] <- ov$published_est[i]
s   <- read.csv("output/summary_by_study.csv"); sp <- s[s$grid_type == "principled", ]
rep <- read.csv("output/reproduction.csv")
sv <- function(x) if (is.na(x) || x == "") character(0) else trimws(strsplit(x, ",")[[1]])
out <- list()
for (i in seq_len(nrow(reg))) {
  r <- reg[i, ]; f <- r$data_file; ext <- tolower(tools::file_ext(f))
  d <- switch(ext, xlsx = as.data.frame(read_excel(f, sheet = if (r$sheet == "") 1 else r$sheet)), csv = read.csv(f), sav = as.data.frame(read_sav(f)), rds = readRDS(f))
  d <- d[!is.na(d[[r$arm_var]]), ]
  if (r$arm_include != "") d <- d[as.character(d[[r$arm_var]]) %in% sv(r$arm_include), ]
  if (r$time_var != "") d <- d[as.character(d[[r$time_var]]) == as.character(r$primary_time), ]
  y <- suppressWarnings(as.numeric(d[[r$outcome_var]])); arm <- relevel(factor(as.character(d[[r$arm_var]])), ref = as.character(r$arm_control))
  base <- if (r$baseline_var != "") suppressWarnings(as.numeric(d[[r$baseline_var]])) else NULL
  ok <- !is.na(y) & !is.na(arm); y <- y[ok]; arm <- arm[ok]; if (!is.null(base)) base <- base[ok]
  # gepoolte Innerhalb-Gruppen-SD, unabhaengig berechnet
  n1 <- sum(arm == levels(arm)[1]); n2 <- sum(arm != levels(arm)[1])
  sdp <- sqrt(((n1 - 1) * var(y[arm == levels(arm)[1]]) + (n2 - 1) * var(y[arm != levels(arm)[1]])) / (n1 + n2 - 2))
  est <- c(endpoint = unname(coef(lm(y ~ arm))[2]))
  if (!is.null(base)) { ok2 <- !is.na(base)
    est["change"] <- unname(coef(lm(I(y - base) ~ arm, subset = ok2))[2])
    est["ancova"] <- unname(coef(lm(y ~ arm + base, subset = ok2))[2]) }
  dd <- est / sdp
  out[[i]] <- data.frame(study_id = r$study_id, n = length(y), sd_pooled_indep = sdp,
    d_endpoint = g(dd,"endpoint"), d_change = g(dd,"change"), d_ancova = g(dd,"ancova"),
    range_baseline_only_indep = diff(range(dd)), range_principled_pipeline = sp$d_range[match(r$study_id, sp$study_id)],
    est_endpoint = g(est,"endpoint"), est_ancova = g(est,"ancova"),
    published = pub$published_est[match(r$study_id, pub$study_id)], pipeline_recomputed = rep$our_est[match(r$study_id, rep$study_id)])
}
x <- do.call(rbind, out); rownames(x) <- NULL
write.csv(x, "output/independent_check.csv", row.names = FALSE)
cat(sprintf("%-28s %4s %8s %8s %8s | Spanne(3 Baseline) unabh. %6s vs Pipeline-principled %6s\n", "Studie", "n", "d_end", "d_chg", "d_anc", "", ""))
for (i in seq_len(nrow(x))) with(x[i,], cat(sprintf("%-28s %4d %8.3f %8.3f %8.3f | %6.3f vs %6.3f\n", study_id, n, d_endpoint, d_change, d_ancova, range_baseline_only_indep, range_principled_pipeline)))
cat("\nPublizierter Schaetzer vs unabhaengiges ANCOVA/Endpoint vs Pipeline:\n")
for (i in seq_len(nrow(x))) with(x[i,], if (!is.na(published)) cat(sprintf("%-28s publ %9.3f | unabh. ancova %9.3f endpoint %9.3f | pipeline %9.3f\n", study_id, published, est_ancova, est_endpoint, pipeline_recomputed)))
