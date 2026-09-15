# Was treibt die Spannweite je Studie? Deskriptiv: n, standardisiertes Baseline-
# Ungleichgewicht, Korrelation Baseline-Endwert, Anteil fehlend. Spearman mit der
# principled-Spannweite. Keine Inferenz, 16 Punkte.
suppressMessages({library(dplyr)}); source("R/grid.R"); source("R/engine.R")
reg <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
s <- read.csv("output/summary_by_study.csv", stringsAsFactors = FALSE)
out <- list()
for (i in seq_len(nrow(reg))) {
  r <- reg[i, ]; d <- harmonise(load_study(r), r)
  imb <- NA; rho <- NA
  if (".base" %in% names(d)) {
    m <- tapply(d$.base, d$.arm, mean, na.rm = TRUE); sdp <- sd(d$.base, na.rm = TRUE)
    imb <- abs(diff(m)) / sdp
    rho <- suppressWarnings(cor(d$.base, d$.y, use = "complete.obs"))
  }
  out[[i]] <- data.frame(study_id = r$study_id, n = nrow(d), has_baseline = ".base" %in% names(d),
    baseline_imbalance_sd = imb, cor_base_outcome = rho, frac_missing = mean(is.na(d$.y)))
}
x <- bind_rows(out) %>% left_join(s %>% filter(grid_type == "principled") %>% select(study_id, range_p = d_range, med_p = d_median), by = "study_id") %>%
  left_join(s %>% filter(grid_type == "defensible") %>% select(study_id, range_d = d_range), by = "study_id")
write.csv(x, "output/range_drivers.csv", row.names = FALSE)
print(x[order(-x$range_p), c("study_id","n","baseline_imbalance_sd","cor_base_outcome","frac_missing","range_p","range_d")], digits = 2)
cat("\nSpearman mit principled-Spannweite:\n")
for (v in c("n","baseline_imbalance_sd","cor_base_outcome","frac_missing")) {
  ok <- !is.na(x[[v]]) & !is.na(x$range_p)
  cat(sprintf("  %-22s rho = %5.2f (n = %d)\n", v, cor(x[[v]][ok], x$range_p[ok], method = "spearman"), sum(ok)))
}
cat("\nWilson-Intervalle:\n")
w <- function(k, n) { p <- k/n; z <- 1.96; c((p + z^2/(2*n) - z*sqrt(p*(1-p)/n + z^2/(4*n^2)))/(1+z^2/n), (p + z^2/(2*n) + z*sqrt(p*(1-p)/n + z^2/(4*n^2)))/(1+z^2/n)) }
for (kn in list(c(6,12), c(8,12), c(9,12), c(12,12), c(15,16), c(14,16), c(16,48), c(16,152), c(7,16), c(1,16), c(4,16), c(13,16))) cat(sprintf("  %2d/%-3d = %4.0f%%  Wilson %3.0f%% bis %3.0f%%\n", kn[1], kn[2], 100*kn[1]/kn[2], 100*w(kn[1],kn[2])[1], 100*w(kn[1],kn[2])[2]))
