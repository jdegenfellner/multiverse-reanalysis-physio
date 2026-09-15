# Stufe 2: Computationale Reproduktion.
#
# Liest config/published.csv (aus coding/extracted/*.json gebaut, R/build_published.R),
# identifiziert je Studie die Spezifikation im defensible-Gitter, die der publizierten
# Analyse am naechsten kommt, und klassifiziert nach PREREGISTRATION.md Abschnitt 4:
#   full                 |Abweichung| <= 2 % des publizierten Schaetzers UND gleiches Vorzeichen
#   minor_discrepancy    <= 10 % (Hardwicke et al. 2021)
#   major_discrepancy    > 10 % oder Vorzeichenwechsel
#   not_reproducible     publizierte Spezifikation nicht im Gitter abbildbar / kein Schaetzer
# Zusaetzlich: Perzentil des publizierten Schaetzers in beiden Gittern.
suppressMessages({library(dplyr)})

r   <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE) %>% filter(!is_dup)
pub <- read.csv("config/published.csv", stringsAsFactors = FALSE)
reg <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
pub <- pub[pub$study_id %in% reg$study_id, ]                       # nur eingeschlossene Studien
if (file.exists("config/published_overrides.csv")) {                # dokumentierte Korrekturen
  ov <- read.csv("config/published_overrides.csv", stringsAsFactors = FALSE)
  for (i in seq_len(nrow(ov))) {
    k <- pub$study_id == ov$study_id[i]
    pub$published_est[k] <- ov$published_est[i]; pub$published_ci_lo[k] <- ov$published_ci_lo[i]
    pub$published_ci_hi[k] <- ov$published_ci_hi[i]; pub$published_p[k] <- ov$published_p[i]
    if ("B_baseline_handling" %in% names(ov) && !is.na(ov$B_baseline_handling[i]) && ov$B_baseline_handling[i] != "")
      pub$B_baseline_handling[k] <- ov$B_baseline_handling[i]
  }
}

map_baseline <- c(endpoint = "endpoint", change = "change", ancova = "ancova", other = NA, unclear = NA)
map_missing  <- c(none_missing = "complete_case", complete_case = "complete_case", locf = "locf", mi = "mi",
                  mmrm_ml = "mi", not_reported = "complete_case", unclear = "complete_case")
# "NOT_REPRESENTABLE": das publizierte Modell existiert im Gitter nicht -> zaehlt als Nicht-Match.
# NA: bewusst nicht bewertbar (unclear/other).
map_model    <- c(ttest = "lm", anova = "lm", lm_ancova = "lm", mixed_ri = "mixed_ri", mmrm = "mixed_ri",
                  robust = "lm", mixed_slopes = "NOT_REPRESENTABLE", gee = "NOT_REPRESENTABLE",
                  quantile = "NOT_REPRESENTABLE", nonparam = "NOT_REPRESENTABLE", other = NA, unclear = "lm")
map_covars   <- c(none = "none", baseline_only = "none", baseline_plus_strat = "strat", published_set = "published",
                  data_driven = "published", unclear = "none")
map_se       <- c(model_based = "model", robust_hc = "hc3", permutation = "permutation", bootstrap = "hc3",
                  cluster_robust = "model", not_reported = "model")

out <- list()
for (i in seq_len(nrow(pub))) {
  p <- pub[i, ]; sid <- p$study_id
  x <- r[r$study_id == sid & r$grid_type == "defensible", ]
  if (!nrow(x)) next
  if (is.na(p$published_est)) {
    out[[i]] <- data.frame(study_id = sid, class = "no_point_estimate", spec_fully_matched = NA,
      reason = sprintf("Paper berichtet keinen Punktschaetzer der Gruppendifferenz (nur p = %s)", p$published_p)); next
  }
  target <- list(baseline = map_baseline[p$B_baseline_handling], covars = map_covars[p$B_covariates],
                 missing = map_missing[p$B_missing_strategy], model = map_model[p$B_model_family],
                 inference = map_se[p$B_se_method],
                 transform = if (isTRUE(p$B_transformation == "log")) "log" else "none",
                 outlier = if (isTRUE(p$B_outlier_rule %in% c("none", "not_reported", "unclear"))) "none" else NA,
                 outlier_scope = "pooled")
  # Fehlender Schluessel in einer map_*-Tabelle = nicht abbildbar, nicht "unbewertbar"
  for (nd in names(target)) if (length(target[[nd]]) == 0 || (is.null(names(target[[nd]])) && FALSE)) target[[nd]] <- "NOT_REPRESENTABLE"
  for (nd in c("baseline","covars","missing","model","inference")) {
    key <- switch(nd, baseline = p$B_baseline_handling, covars = p$B_covariates, missing = p$B_missing_strategy,
                  model = p$B_model_family, inference = p$B_se_method)
    tab <- switch(nd, baseline = map_baseline, covars = map_covars, missing = map_missing, model = map_model, inference = map_se)
    if (!is.na(key) && !(key %in% names(tab))) target[[nd]] <- "NOT_REPRESENTABLE"
  }
  # Score: Zahl uebereinstimmender Knoten (NA im Ziel = nicht bewertbar)
  sc <- rep(0, nrow(x)); k <- 0; not_repr <- character(0)
  for (nd in names(target)) {
    if (is.na(target[[nd]]) || !(nd %in% names(x)) || all(is.na(x[[nd]]))) next   # Knoten nicht im Gitter dieser Studie
    k <- k + 1
    if (identical(target[[nd]], "NOT_REPRESENTABLE")) { not_repr <- c(not_repr, nd); next }   # zaehlt im Nenner, nie im Zaehler
    sc <- sc + as.numeric(x[[nd]] == target[[nd]] & !is.na(x[[nd]]))
  }
  cand <- x[sc == max(sc), ]
  n_tied <- nrow(cand); tie_range_d <- if (n_tied > 1) diff(range(cand$d)) else 0
  best <- if (n_tied > 1) cand[order(abs(cand$est - p$published_est)), ][1, ] else cand  # Gleichstand: naechster Wert, wird berichtet
  matched_all <- max(sc) == k
  rel <- abs(best$est - p$published_est) / abs(p$published_est)
  abs_d <- abs(best$est - p$published_est) / best$sd_denom             # absolute Differenz in SD der gematchten Skala
  same_sign <- sign(best$est) == sign(p$published_est)
  # Klassifikation nach der VORAB festgelegten relativen Regel (PREREGISTRATION.md; Hardwicke 2021):
  # full <= 2 %, minor <= 10 %, major > 10 % oder Vorzeichenwechsel. Die absolute Differenz in
  # SD wird daneben berichtet, ohne Schwelle.
  cls <- if (same_sign && rel <= 0.02) "full" else if (same_sign && rel <= 0.10) "minor_discrepancy" else "major_discrepancy"
  abs_se <- if (!is.na(p$published_se) && p$published_se > 0) abs(best$est - p$published_est) / p$published_se else NA_real_
  # Verortung nur auf derselben Skala: publizierter Log-Schaetzer wird nicht mit Roh-d verglichen
  on_log <- isTRUE(p$published_scale == "log")
  xp <- r[r$study_id == sid & r$grid_type == "principled", ]
  if (on_log) { x <- x[!is.na(x$transform) & x$transform == "log", ]; xp <- xp[0, ] }
  pd <- if (on_log) (if (nrow(x)) p$published_est / x$sd_denom[1] else NA_real_) else p$published_est / xp$sd_denom[1]
  out[[i]] <- data.frame(study_id = sid, class = cls, spec_fully_matched = matched_all,
    reason = if (!matched_all) sprintf("publizierte Spezifikation nur zu %d/%d Knoten abbildbar%s", max(sc), k,
      if (length(not_repr)) paste0(" (nicht im Gitter: ", paste(not_repr, collapse = ","), ")") else "") else "",
    published_est = p$published_est, our_est = best$est, rel_diff = rel, abs_diff_sd = abs_d, abs_diff_se = abs_se,
    n_tied = n_tied, tie_range_d = tie_range_d,
    published_ci_lo = p$published_ci_lo, published_ci_hi = p$published_ci_hi, our_ci_lo = best$ci_lo, our_ci_hi = best$ci_hi,
    published_p = p$published_p, our_p = best$p,
    nodes_matched = max(sc), nodes_scored = k,
    spec_baseline = best$baseline, spec_covars = best$covars, spec_missing = best$missing,
    spec_model = best$model, spec_inference = best$inference, spec_transform = best$transform,
    published_d = pd,
    pct_principled = if (nrow(xp)) mean(xp$d <= pd) else NA_real_, pct_defensible = if (nrow(x)) mean(x$d <= pd) else NA_real_,
    inside_principled = if (nrow(xp)) pd >= min(xp$d) & pd <= max(xp$d) else NA,
    inside_defensible = if (nrow(x)) pd >= min(x$d) & pd <= max(x$d) else NA)
}
res <- bind_rows(out)
write.csv(res, "output/reproduction.csv", row.names = FALSE)
cat("\n=== Stufe 2: Reproduktion ===\n")
print(table(res$class))
cat("publizierte Spezifikation vollstaendig im Gitter:", sum(res$spec_fully_matched, na.rm = TRUE), "von", sum(!is.na(res$spec_fully_matched)), "| Gleichstaende:", sum(res$n_tied > 1, na.rm = TRUE), "\n")
for (i in seq_len(nrow(res))) with(res[i,], cat(sprintf("  %-28s %-18s publ %9.3f  unsere %9.3f  rel %5.1f%%  abs %5.3f SD  Gitter %-5s Perz(princ) %4.2f  %s\n",
  study_id, class, published_est, our_est, 100*rel_diff, abs_diff_sd, spec_fully_matched, pct_principled, reason)))
