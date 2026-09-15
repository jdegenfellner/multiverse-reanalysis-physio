# Registry v1 (ad hoc, 2026-08-28) durch die finale Engine, nur die 16 Studien der v2.
# Wirkung der Registry-Fehler: Registry v1 mit der reparierten Engine rechnen,
# nur die 16 Studien, die auch in v2 sind. Vergleich Median d, Spannweite, Vorzeichen.
suppressMessages({library(dplyr)}); source("R/grid.R"); source("R/engine.R")
v1 <- read.csv("config/registry_v1_2026-08-28.csv", stringsAsFactors = FALSE)
v2 <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
v1 <- v1[v1$study_id %in% v2$study_id, ]
out <- list()
for (i in seq_len(nrow(v1))) {
  r <- try(run_study(v1[i, ], "principled"), silent = TRUE)
  if (inherits(r, "try-error") || is.null(r)) { cat("FEHLER", v1$study_id[i], "\n"); next }
  r <- r[!r$is_dup, ]
  out[[i]] <- data.frame(study_id = v1$study_id[i], v1_med = median(r$d), v1_range = diff(range(r$d)), v1_sign = mean(sign(r$d) == sign(median(r$d))))
}
a <- bind_rows(out)
s <- read.csv("output/summary_by_study.csv") %>% filter(grid_type == "principled") %>% select(study_id, v2_med = d_median, v2_range = d_range, v2_sign = share_same_sign)
x <- a %>% inner_join(s, by = "study_id") %>% mutate(sign_flip = sign(v1_med) != sign(v2_med))
write.csv(x, "output/registry_v1_vs_v2.csv", row.names = FALSE)
print(x, digits = 2)
cat(sprintf("\nMedian |d| v1 %.2f vs v2 %.2f | Median Spannweite v1 %.2f vs v2 %.2f | Vorzeichenwechsel des Medians: %d von %d\n",
  median(abs(x$v1_med)), median(abs(x$v2_med)), median(x$v1_range), median(x$v2_range), sum(x$sign_flip), nrow(x)))
