# Summenmasse nach PREREGISTRATION.md Abschnitt 5.5, je Studie und Gitter.
# Nur eindeutige Spezifikationen. Keine Dichotomie "signifikant" als Hauptmass.
#
#   - Verteilung von d: Median, IQR, Spannweite
#   - Anteil Spezifikationen mit gleichem Vorzeichen wie der Median
#   - Anteil |d| > MCID_d (MCID in SD-Einheiten aus registry, wenn vorhanden; sonst 0.2 als
#     konservative Schwelle nach Cohen, gekennzeichnet)
#   - s-Werte: Median und Spannweite
#   - Vergleich principled gegen defensible: Verhaeltnis der Spannweiten
#   - Verortung des publizierten Schaetzers: Perzentil in der Verteilung (wenn vorhanden)
suppressMessages({library(dplyr)})

r   <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE)
r   <- r[!r$is_dup, ]
reg <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
pub <- if (file.exists("config/published.csv")) read.csv("config/published.csv", stringsAsFactors = FALSE) else NULL
if (!is.null(pub) && file.exists("config/published_overrides.csv")) {   # dokumentierte Korrekturen anwenden
  ov <- read.csv("config/published_overrides.csv", stringsAsFactors = FALSE)
  for (i in seq_len(nrow(ov))) pub$published_est[pub$study_id == ov$study_id[i]] <- ov$published_est[i]
}

one <- function(x) {
  sid <- x$study_id[1]
  mcid_d <- NA_real_
  if (!is.null(pub) && sid %in% pub$study_id && !is.na(pub$mcid_raw[pub$study_id == sid]))
    mcid_d <- pub$mcid_raw[pub$study_id == sid] / x$sd_denom[1]
  thr <- if (is.na(mcid_d)) 0.2 else mcid_d
  med <- median(x$d)
  out <- data.frame(
    study_id = sid, grid_type = x$grid_type[1], n_spec = nrow(x), n = max(x$n),
    d_median = med, d_q25 = quantile(x$d, .25), d_q75 = quantile(x$d, .75),
    d_min = min(x$d), d_max = max(x$d), d_range = diff(range(x$d)),
    share_same_sign = mean(sign(x$d) == sign(med)),
    share_ci_excl_0 = mean(x$ci_lo > 0 | x$ci_hi < 0),          # deskriptiv, sekundaer
    mcid_d = thr, mcid_source = if (is.na(mcid_d)) "cohen_small_0.2" else "instrument_mcid",
    share_abs_d_gt_mcid = mean(abs(x$d) > thr),
    share_ci_excl_mcid = mean((x$ci_lo / x$sd_denom[1]) > thr | (x$ci_hi / x$sd_denom[1]) < -thr),
    s_median = median(x$s_value), s_min = min(x$s_value), s_max = max(x$s_value),
    ci_width_d_median = median(x$ci_width_d),
    stringsAsFactors = FALSE)
  if (!is.null(pub) && sid %in% pub$study_id && !is.na(pub$published_est[pub$study_id == sid])) {
    pe <- pub$published_est[pub$study_id == sid]
    pd <- pe / x$sd_denom[1]
    if (isTRUE(pub$published_scale[pub$study_id == sid] == "log")) pd <- NA_real_
    out$published_d <- pd
    out$published_percentile <- if (is.na(pd)) NA_real_ else mean(x$d <= pd)
    out$published_inside_range <- if (is.na(pd)) NA else (pd >= min(x$d) & pd <= max(x$d))
  } else { out$published_d <- NA_real_; out$published_percentile <- NA_real_; out$published_inside_range <- NA }
  rownames(out) <- NULL
  out
}

res <- bind_rows(lapply(split(r, list(r$study_id, r$grid_type), drop = TRUE), one))
write.csv(res, "output/summary_by_study.csv", row.names = FALSE)

wide <- res %>% filter(grid_type %in% c("principled","defensible")) %>% select(study_id, grid_type, d_median, d_range, share_same_sign, n_spec) %>%
  tidyr::pivot_wider(names_from = grid_type, values_from = c(d_median, d_range, share_same_sign, n_spec)) %>%
  mutate(range_ratio_def_vs_princ = d_range_defensible / d_range_principled)
write.csv(wide, "output/summary_grids_compared.csv", row.names = FALSE)

cat("\n=== Je Studie: Median d [Spannweite], Vorzeichenanteil ===\n")
for (g in c("principled","strict","defensible","outlier_arm")) {
  cat("--", g, "--\n")
  z <- res[res$grid_type == g, ]
  for (i in order(z$d_median)) with(z[i,], cat(sprintf(
    "  %-28s n=%3d  spec=%4d  d=%6.2f [%6.2f, %6.2f]  sign %3.0f%%  |d|>MCID %3.0f%%  s med %4.1f\n",
    study_id, n, n_spec, d_median, d_min, d_max, 100*share_same_sign, 100*share_abs_d_gt_mcid, s_median)))
}
cat("\n=== Ueber Studien ===\n")
for (g in c("principled","strict","defensible","outlier_arm")) {
  z <- res[res$grid_type == g, ]
  cat(sprintf("%-11s Spannweite d: Median %.2f (IQR %.2f-%.2f, max %.2f) | Vorzeichenanteil: Median %.2f, min %.2f | Studien mit Spannweite ueber 0: %d/%d\n",
    g, median(z$d_range), quantile(z$d_range,.25), quantile(z$d_range,.75), max(z$d_range),
    median(z$share_same_sign), min(z$share_same_sign), sum(z$d_min < 0 & z$d_max > 0), nrow(z)))
}
cat(sprintf("Verhaeltnis Spannweite defensible/principled: Median %.2f, Spannweite %.2f-%.2f\n",
  median(wide$range_ratio_def_vs_princ, na.rm=TRUE), min(wide$range_ratio_def_vs_princ, na.rm=TRUE), max(wide$range_ratio_def_vs_princ, na.rm=TRUE)))
