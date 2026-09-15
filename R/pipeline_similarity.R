# Empirische Aehnlichkeit der Datensaetze zwischen den Pipelines.
#
# WARUM DAS NOETIG IST: Short et al. (AMPPS 2026) warnen ausdruecklich, dass
# "empirical similarity across data sets can produce the illusion of consistency
# rather than genuine robustness". Wenn die Preprocessing-Optionen den Datensatz
# kaum veraendern, ist Vorzeichenstabilitaet trivial und sagt nichts ueber die
# Robustheit des Effekts. Ohne diese Pruefung ist unser Hauptbefund wertlos.
#
# Gemessen wird je Studie ueber alle Preprocessing-Pipelines:
#   - Pearson-Korrelation der Outcome-Vektoren zwischen Pipeline-Paaren
#   - relative euklidische Distanz, normiert auf die SD des Rohoutcomes
#   - Anteil der Faelle, deren Wert sich ueberhaupt aendert

suppressMessages({library(dplyr)})
source("R/grid.R"); source("R/engine.R")

PRE_NODES <- c("outlier", "outlier_scope", "transform", "missing")

pipeline_data <- function(spec, reg, d0) {
  d <- d0
  d <- apply_outlier(d, if (is.null(spec$outlier)) "none" else spec$outlier, if (!is.null(spec$outlier_scope)) spec$outlier_scope else "pooled")
  d <- apply_missing(d, if (!is.null(spec$missing)) spec$missing else "complete_case")
  d <- apply_transform(d, if (!is.null(spec$transform)) spec$transform else "none")
  # MI: fuer den Aehnlichkeitsvergleich zaehlt der beobachtete Vektor
  d[, c(".id", ".y"), drop = FALSE]
}

similarity_one <- function(reg) {
  d0 <- harmonise(load_study(reg), reg)
  g  <- build_grid(reg, d0, "defensible")
  pn <- intersect(PRE_NODES, names(g))
  if (!length(pn)) return(data.frame(study_id = reg$study_id, n_pipelines = 1L, n_ids = nrow(d0), cor_median = NA, cor_min = NA, dist_median = NA, dist_max = NA, changed_median = NA, changed_max = NA))
  pipes <- unique(g[, pn, drop = FALSE])
  if (nrow(pipes) < 2) return(data.frame(study_id = reg$study_id, n_pipelines = nrow(pipes), n_ids = nrow(d0),
    cor_median = NA, cor_min = NA, dist_median = NA, dist_max = NA, changed_median = NA, changed_max = NA))

  # Alle Pipelines auf die gemeinsame ID-Menge bringen, sonst sind Vektoren
  # unterschiedlich lang und die Korrelation waere nicht definiert.
  dats <- lapply(seq_len(nrow(pipes)), function(i) pipeline_data(as.list(pipes[i, , drop = FALSE]), reg, d0))
  ids  <- Reduce(intersect, lapply(dats, function(x) x$.id[!is.na(x$.y)]))
  if (length(ids) < 5) return(NULL)
  M <- vapply(dats, function(x) x$.y[match(ids, x$.id)], numeric(length(ids)))

  cr <- suppressWarnings(cor(M, use = "pairwise.complete.obs"))
  cr <- cr[upper.tri(cr)]
  # ACHTUNG: Die Distanz muss auf standardisierten Vektoren gerechnet werden.
  # Roh- und Log-Skala direkt zu vergleichen misst den Skalensprung, nicht die
  # Formaenderung, und liefert Distanzen von 15+ SD bei einer Korrelation von 0.9997.
  Z <- scale(M)
  ed <- c()
  for (i in 1:(ncol(Z) - 1)) for (j in (i + 1):ncol(Z))
    ed <- c(ed, sqrt(mean((Z[, i] - Z[, j])^2, na.rm = TRUE)))
  chg <- vapply(2:ncol(M), function(i) mean(abs(M[, i] - M[, 1]) > 1e-9, na.rm = TRUE), 0)

  data.frame(study_id = reg$study_id, n_pipelines = ncol(M), n_ids = length(ids),
             cor_median = median(cr, na.rm = TRUE), cor_min = min(cr, na.rm = TRUE),
             dist_median = median(ed), dist_max = max(ed),
             changed_median = median(chg), changed_max = max(chg))
}

if (!interactive()) {
  reg <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
  out <- list()
  for (i in seq_len(nrow(reg))) {
    r <- try(similarity_one(reg[i, ]), silent = TRUE)
    if (!inherits(r, "try-error") && !is.null(r)) out[[length(out) + 1]] <- r
  }
  res <- bind_rows(out)
  write.csv(res, "output/pipeline_similarity.csv", row.names = FALSE)

  cat("Aehnlichkeit der Pipeline-Datensaetze je Studie\n")
  cat("  cor = Pearson-Korrelation der Outcome-Vektoren zwischen Pipeline-Paaren\n")
  cat("  dist = euklidische Distanz auf standardisierten Vektoren (Formaenderung, nicht Skala)\n")
  cat("  changed = Anteil der Faelle, deren Wert sich gegenueber Pipeline 1 aendert\n\n")
  cat(sprintf("  %-26s %6s %8s %8s %9s %9s\n", "Studie", "Pipes", "cor med", "cor min", "dist med", "chg max"))
  for (i in seq_len(nrow(res))) with(res[i, ], cat(sprintf(
    "  %-26s %6d %8.4f %8.4f %9.4f %8.0f%%\n",
    substr(study_id, 1, 26), n_pipelines, cor_median, cor_min, dist_median, 100 * changed_max)))

  cat(sprintf("\n  Median ueber Studien: cor %.4f | dist %.4f\n",
              median(res$cor_median), median(res$dist_median)))
  triv <- sum(res$cor_min > 0.99, na.rm = TRUE)
  cat(sprintf("  Studien, in denen ALLE Pipeline-Paare r > 0.99 haben: %d von %d\n", triv, nrow(res)))
  if (triv > nrow(res) / 2)
    cat("  WARNUNG: In der Mehrheit der Studien sind die Pipeline-Datensaetze praktisch identisch.\n",
        "  Vorzeichenstabilitaet ist dann keine Robustheitsaussage.\n")
}
