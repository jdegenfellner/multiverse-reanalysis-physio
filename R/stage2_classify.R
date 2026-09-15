# Klassifikation der Stufe-2-Nachfits nach der VORAB festgelegten relativen Regel
# (full <= 2 %, minor <= 10 %, major sonst oder Vorzeichenwechsel). Absolute Differenz
# in gepoolten SD der Skala des publizierten Schaetzers, ohne Schwelle. Erzeugt
# output/stage2_final.csv aus output/stage2_published_models.csv.
suppressMessages(library(dplyr))
m <- read.csv("output/stage2_published_models.csv", stringsAsFactors = FALSE)
pub <- read.csv("config/published.csv", stringsAsFactors = FALSE)
ov <- read.csv("config/published_overrides.csv", stringsAsFactors = FALSE)
for (i in seq_len(nrow(ov))) { k <- pub$study_id == ov$study_id[i]
  pub$published_est[k] <- ov$published_est[i]; pub$published_ci_lo[k] <- ov$published_ci_lo[i]
  pub$published_ci_hi[k] <- ov$published_ci_hi[i]; pub$published_p[k] <- ov$published_p[i] }
r <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE)
sd_raw <- r %>% filter(grid_type == "principled") %>% group_by(study_id) %>% summarise(sd_raw = first(sd_denom), .groups = "drop")
sd_log <- r %>% filter(grid_type == "defensible", !is.na(transform), transform == "log") %>% group_by(study_id) %>% summarise(sd_log = first(sd_denom), .groups = "drop")
x <- m %>% select(study_id, model_as_published, est, ci_lo, ci_hi, p, n, deviations) %>%
  left_join(pub %>% select(study_id, published_est, published_ci_lo, published_ci_hi, published_p, published_scale), by = "study_id") %>%
  left_join(sd_raw, by = "study_id") %>% left_join(sd_log, by = "study_id") %>%
  mutate(sd = ifelse(!is.na(published_scale) & published_scale == "log", sd_log, sd_raw),
         rel = abs(est - published_est) / abs(published_est), abs_sd = abs(est - published_est) / sd,
         same_sign = sign(est) == sign(published_est),
         # Rundungspraezision des publizierten Werts: Differenz kleiner als eine halbe letzte Stelle gilt als exakt
         dec = vapply(published_est, function(v) nchar(sub("^-?\\d*\\.?", "", sub("0+$", "", sprintf("%.10g", v)))), 1L),
         within_rounding = abs(est - published_est) <= 0.5 * 10^(-dec),
         class = ifelse(same_sign & (rel <= 0.02 | within_rounding), "full", ifelse(same_sign & rel <= 0.10, "minor", "major")),
         our_ci_contains_pub = published_est >= ci_lo & published_est <= ci_hi,
         p_verdict_same = ifelse(is.na(published_p) | is.na(p), NA, (published_p < 0.05) == (p < 0.05)))
write.csv(x, "output/stage2_final.csv", row.names = FALSE)
print(as.data.frame(x %>% select(study_id, published_est, est, rel, abs_sd, within_rounding, class, published_p, p, p_verdict_same, our_ci_contains_pub, n) %>% mutate(across(where(is.numeric), ~signif(.x, 3)))))
cat("\nKlassen:"); print(table(x$class))
cat("max abs_sd:", round(max(x$abs_sd), 3), "| median abs_sd:", round(median(x$abs_sd), 3), "| p-Verdikt gleich:", sum(x$p_verdict_same, na.rm = TRUE), "von", sum(!is.na(x$p_verdict_same)), "| KI enthaelt publ:", sum(x$our_ci_contains_pub), "von", nrow(x), "\n")
cat("publiziertes KI berichtet:", sum(!is.na(x$published_ci_lo)), "| publ. p berichtet:", sum(!is.na(x$published_p)), "\n")
