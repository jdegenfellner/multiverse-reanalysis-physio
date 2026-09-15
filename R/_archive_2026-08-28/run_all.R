# Laeuft die ganze Registry durch beide Gitter. Wiederaufsetzbar.
suppressMessages({library(dplyr)})
source("R/grid.R"); source("R/engine.R")

reg_all <- read.csv("config/registry.csv", stringsAsFactors = FALSE)
out <- list(); log <- list()

for (i in seq_len(nrow(reg_all))) {
  reg <- reg_all[i, ]
  t0 <- Sys.time()
  r <- try({
    dplyr::bind_rows(run_study(reg, "principled"), run_study(reg, "defensible"))
  }, silent = TRUE)
  sec <- round(as.numeric(difftime(Sys.time(), t0, units = "secs")), 1)
  if (inherits(r, "try-error") || is.null(r)) {
    log[[i]] <- data.frame(study_id = reg$study_id, status = "FEHLER", n_spec = 0, sec = sec,
                           msg = substr(as.character(r), 1, 90))
    cat(sprintf("  [%d/%d] %-28s FEHLER (%s s)\n", i, nrow(reg_all), reg$study_id, sec)); next
  }
  out[[i]] <- r
  log[[i]] <- data.frame(study_id = reg$study_id, status = "ok", n_spec = nrow(r), sec = sec, msg = "")
  cat(sprintf("  [%d/%d] %-28s %4d Spez. in %5s s | n=%d | singulaer %d%%\n",
              i, nrow(reg_all), reg$study_id, nrow(r), sec, max(r$n),
              round(100 * mean(r$singular == 1))))
}

res <- dplyr::bind_rows(out)
write.csv(res, "output/multiverse_all.csv", row.names = FALSE)
write.csv(dplyr::bind_rows(log), "output/run_log.csv", row.names = FALSE)
cat("\nGesamt:", nrow(res), "Spezifikationen aus", length(unique(res$study_id)), "Studien\n")
