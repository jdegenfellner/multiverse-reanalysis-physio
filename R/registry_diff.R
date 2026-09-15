# Unterschiede Registry v1 gegen v2 je Feld, fuer die 16 gemeinsamen Studien.
v1 <- read.csv("config/registry_v1_2026-08-28.csv", stringsAsFactors = FALSE)
v2 <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
v1 <- v1[match(v2$study_id, v1$study_id), ]
norm <- function(x) { x[is.na(x)] <- ""; trimws(x) }
fields <- c("data_file","arm_include","arm_control","outcome_var","baseline_var","primary_time","covars_published","strat_vars","cluster_vars")
d <- data.frame(study_id = v2$study_id)
for (f in fields) d[[paste0(f, "_changed")]] <- norm(v1[[f]]) != norm(v2[[f]])
d$any_changed <- rowSums(d[, -1]) > 0
write.csv(d, "output/registry_v1_vs_v2_fields.csv", row.names = FALSE)
cat("Studien mit Aenderung:", sum(d$any_changed), "von", nrow(d), "\n")
print(colSums(d[, grepl("_changed$", names(d))]))
