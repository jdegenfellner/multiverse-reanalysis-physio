# Laeuft die ganze Registry durch beide Gitter. Wiederaufsetzbar.
# Pflichtschritt am Ende: Duplikat-Bericht. Identische (est, se, p) innerhalb
# einer Studie sind eine Spezifikation, nicht mehrere (Simonsohn et al. 2020).
suppressMessages({library(dplyr)})
source("R/grid.R"); source("R/engine.R")

reg_all <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
out <- list(); log <- list(); na_nodes <- list()

for (i in seq_len(nrow(reg_all))) {
  reg <- reg_all[i, ]
  t0 <- Sys.time()
  r <- try({
    p <- run_study(reg, "principled"); q <- run_study(reg, "defensible")
    st <- run_study(reg, "strict"); oa <- run_study(reg, "outlier_arm")
    na_nodes[[i]] <- data.frame(study_id = reg$study_id,
      principled = paste(attr(p, "nodes_not_applicable"), collapse = "|"),
      defensible = paste(attr(q, "nodes_not_applicable"), collapse = "|"))
    dplyr::bind_rows(p, q, st, oa)
  }, silent = TRUE)
  sec <- round(as.numeric(difftime(Sys.time(), t0, units = "secs")), 1)
  if (inherits(r, "try-error") || is.null(r)) {
    log[[i]] <- data.frame(study_id = reg$study_id, status = "FEHLER", n_spec = 0, n_unique = 0, sec = sec,
                           msg = substr(as.character(r), 1, 120))
    cat(sprintf("  [%d/%d] %-28s FEHLER (%s s): %s\n", i, nrow(reg_all), reg$study_id, sec, substr(as.character(r), 1, 80))); next
  }
  out[[i]] <- r
  log[[i]] <- data.frame(study_id = reg$study_id, status = "ok", n_spec = nrow(r),
                         n_unique = sum(!r$is_dup), sec = sec, msg = "")
  cat(sprintf("  [%d/%d] %-28s %4d Spez. (%4d verschieden) in %6s s | n=%d | singulaer %d%%\n",
              i, nrow(reg_all), reg$study_id, nrow(r), sum(!r$is_dup), sec, max(r$n),
              round(100 * mean(r$singular == 1))))
}

res <- dplyr::bind_rows(out)
write.csv(res, "output/multiverse_all.csv", row.names = FALSE)
write.csv(dplyr::bind_rows(log), "output/run_log.csv", row.names = FALSE)
write.csv(dplyr::bind_rows(na_nodes), "output/nodes_not_applicable.csv", row.names = FALSE)

# ---- Duplikat-Bericht (Pflicht) ---------------------------------------------
dup <- res %>% group_by(study_id, grid_type) %>%
  summarise(n_spec = n(), n_unique = n_distinct(dup_group), share_dup = 1 - n_unique / n_spec, .groups = "drop")
write.csv(dup, "output/duplicates.csv", row.names = FALSE)
cat("\nGesamt:", nrow(res), "Spezifikationen aus", length(unique(res$study_id)), "Studien,",
    sum(!res$is_dup), "davon verschieden\n")
cat(sprintf("Duplikatanteil: principled %.0f%%, defensible %.0f%%\n",
            100 * mean(dup$share_dup[dup$grid_type == "principled"]),
            100 * mean(dup$share_dup[dup$grid_type == "defensible"])))
if (any(dup$share_dup > 0.10))
  cat("WARNUNG: Studien mit >10% Duplikaten:", paste(unique(dup$study_id[dup$share_dup > 0.10]), collapse = ", "), "\n")
