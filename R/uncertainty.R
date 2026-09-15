# Unsicherheit der Kernzahlen (Statistikgutachten 2026-09-12, Befund 4).
#   - Wilson-Intervalle fuer Anteile
#   - Bootstrap ueber STUDIEN (nicht Spezifikationen) fuer Median-Spannweite und Median-Verhaeltnis
#   - Verteilung der Differenz publizierter d minus Multiverse-Median (keine CI-Ueberlappung!)
suppressMessages({library(dplyr)}); set.seed(20260912)
s <- read.csv("output/summary_by_study.csv"); rep <- read.csv("output/reproduction.csv"); w <- read.csv("output/summary_grids_compared.csv")
st2 <- read.csv("output/stage2_final.csv")   # Stufe 2: publizierte Modelle nachgefittet
wilson <- function(k, n) { p <- k/n; z <- 1.96; den <- 1 + z^2/n; c <- (p + z^2/(2*n))/den; h <- z*sqrt(p*(1-p)/n + z^2/(4*n^2))/den; c(lo = c - h, hi = c + h) }
p <- s[s$grid_type == "principled", ]; d <- s[s$grid_type == "defensible", ]
n_est <- nrow(st2)
props <- list(
  c("reproduced full", sum(st2$class == "full"), n_est),
  c("reproduced full or minor", sum(st2$class %in% c("full","minor")), n_est),
  c("published inside principled range", sum(rep$inside_principled, na.rm = TRUE), sum(!is.na(rep$inside_principled))),
  c("published inside defensible range", sum(rep$inside_defensible, na.rm = TRUE), sum(!is.na(rep$inside_defensible))),
  c("sign stable principled", sum(p$share_same_sign == 1), nrow(p)),
  c("sign stable defensible", sum(d$share_same_sign == 1), nrow(d)),
  c("range includes 0 principled", sum(p$d_min < 0 & p$d_max > 0), nrow(p)),
  c("spec fully representable", sum(rep$spec_fully_matched, na.rm = TRUE), sum(!is.na(rep$spec_fully_matched))),
  c("reproduced full or minor, denominator 48 assessed RCTs", sum(st2$class %in% c("full","minor")), 48),
  c("reproduced full or minor, denominator 152 with link", sum(st2$class %in% c("full","minor")), 152),
  c("included, denominator 48", 16, 48), c("included, denominator 152", 16, 152))
pt <- bind_rows(lapply(props, function(v) { k <- as.numeric(v[2]); n <- as.numeric(v[3]); ci <- wilson(k, n)
  data.frame(quantity = v[1], k = k, n = n, prop = k/n, wilson_lo = ci[1], wilson_hi = ci[2]) }))
B <- 5000
boot_med <- function(v) { v <- v[is.finite(v)]; m <- replicate(B, median(sample(v, replace = TRUE))); c(est = median(v), lo = quantile(m, .025), hi = quantile(m, .975)) }
bm <- rbind(
  data.frame(quantity = "median range d, principled", t(boot_med(p$d_range))),
  data.frame(quantity = "median range d, defensible", t(boot_med(d$d_range))),
  data.frame(quantity = "median ratio defensible/principled (finite only)", t(boot_med(w$range_ratio_def_vs_princ))),
  data.frame(quantity = "median |published d - multiverse median d| (principled)", t(boot_med(abs(rep$published_d - p$d_median[match(rep$study_id, p$study_id)])))))
names(bm) <- c("quantity","est","boot_lo","boot_hi")
diffs <- rep %>% filter(!is.na(published_d)) %>% mutate(med_p = p$d_median[match(study_id, p$study_id)], diff_d = published_d - med_p) %>% select(study_id, published_d, med_p, diff_d)
write.csv(pt, "output/uncertainty_proportions.csv", row.names = FALSE)
write.csv(bm, "output/uncertainty_medians.csv", row.names = FALSE)
write.csv(diffs, "output/published_minus_median.csv", row.names = FALSE)
print(pt, digits = 3); print(bm, digits = 3); print(diffs, digits = 3)
cat(sprintf("\nDifferenz publiziert - Median: Median %.3f, Spannweite %.3f bis %.3f SD\n", median(diffs$diff_d), min(diffs$diff_d), max(diffs$diff_d)))
