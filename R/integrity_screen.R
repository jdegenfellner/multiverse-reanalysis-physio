# Datenintegritaets-Screen VOR dem Multiverse (PREREGISTRATION.md 4b).
#
# 1. Carlisle-Test auf stetigen Baseline-Variablen (Carlisle 2017, Anaesthesia):
#    Fuer jede stetige Baseline-Variable ein p-Wert fuer die Gleichheit der Arm-
#    mittelwerte (ANOVA). Unter korrekter Randomisierung sind diese p-Werte
#    uniform. Kombination je Studie ueber Stouffer; Extremwerte in BEIDE Richtungen
#    (zu aehnlich UND zu unaehnlich) sind auffaellig. Bolland 2019: nur stetige
#    Variablen, Rundung beachten.
# 2. GRIM (Brown & Heathers 2017) auf publizierten Mittelwerten ganzzahliger Skalen:
#    braucht published.csv mit mean, n, Dezimalstellen. Wird hier auf die
#    Individualdaten angewendet: Sind die Werte einer Skala mit ganzzahligem
#    Wertebereich tatsaechlich ganzzahlig?
# 3. Duplikate: identische Zeilen ueber alle numerischen Spalten.
# 4. Endziffern: Chi-Quadrat auf Gleichverteilung der letzten Ziffer (nur bei
#    Messwerten mit >= 2 Dezimalstellen sinnvoll).
#
# Ergebnis: ein Flag je Studie, KEINE Anschuldigung. Nur "flag" oder "pass".
suppressMessages({library(dplyr); library(readxl); library(haven)})
source("R/grid.R"); source("R/engine.R")

reg <- read.csv("config/registry.csv", stringsAsFactors = FALSE)

carlisle <- function(d_full, arm, vars) {
  ps <- c()
  for (v in vars) {
    x <- suppressWarnings(as.numeric(d_full[[v]]))
    if (length(unique(na.omit(x))) < 5) next                  # nicht stetig
    ok <- !is.na(x) & !is.na(arm)
    if (sum(ok) < 10 || length(unique(arm[ok])) < 2) next
    p <- tryCatch(summary(aov(x[ok] ~ factor(arm[ok])))[[1]][["Pr(>F)"]][1], error = function(e) NA)
    if (!is.na(p)) ps[v] <- p
  }
  ps
}

out <- list()
for (i in seq_len(nrow(reg))) {
  r <- reg[i, ]
  d_full <- tryCatch(load_study(r), error = function(e) NULL)
  if (is.null(d_full)) next
  d_full <- d_full[!is.na(d_full[[r$arm_var]]), ]
  if (!is.na(r$arm_include) && r$arm_include != "")
    d_full <- d_full[as.character(d_full[[r$arm_var]]) %in% split_vars(r$arm_include), ]
  if (!is.na(r$time_var) && r$time_var != "") {
    # Baseline-Zeile je Person: erster Zeitpunkt
    tpc <- as.character(d_full[[r$time_var]])
    tp  <- suppressWarnings(as.numeric(tpc))
    first <- if (all(is.na(tp))) sort(unique(tpc))[1] else as.character(min(tp, na.rm = TRUE))
    d_full <- d_full[!is.na(tpc) & (if (all(is.na(tp))) tpc == first else tp == as.numeric(first)), ]
  }
  arm <- as.character(d_full[[r$arm_var]])

  # Baseline-Kandidaten: baseline_var + publizierte Kovariaten + alles, was numerisch ist
  # und nicht das Outcome ist (konservativ: nur explizit benannte Variablen zaehlen fuer
  # das Hauptergebnis, die Breitsuche wird separat berichtet)
  named <- intersect(c(r$baseline_var, split_vars(r$covars_published)), names(d_full))
  named <- named[named != ""]
  # Breitsuche NUR ueber Spalten, die dem Namen nach Baseline sind. Post-Randomisierungs-
  # Variablen (Follow-up-Outcomes) muessen sich zwischen Armen unterscheiden duerfen.
  num_all <- names(d_full)[vapply(d_full, function(z) is.numeric(z) || is.numeric(suppressWarnings(as.numeric(z))), TRUE)]
  num_all <- setdiff(num_all, c(r$outcome_var, r$id_var, r$arm_var, r$time_var))
  base_pat <- "(?i)(^|[^a-z])(pre|base|baseline|t0|bl|_0|_1$|1$|age|bmi|height|weight|sex|gender)"
  num_all <- num_all[grepl(base_pat, num_all, perl = TRUE)]
  num_all <- union(named, num_all)

  p_named <- carlisle(d_full, arm, named)
  p_all   <- carlisle(d_full, arm, num_all)

  stouffer <- function(p) { if (length(p) < 2) return(NA_real_); z <- qnorm(p); pnorm(sum(z) / sqrt(length(z))) }
  # Zweiseitig: p_comb nahe 0 = Arme zu verschieden, nahe 1 = Arme zu aehnlich
  pc_named <- stouffer(p_named); pc_all <- stouffer(p_all)

  # GRIM-artige Pruefung: Outcome mit ganzzahligem Skalenbereich, Werte ganzzahlig?
  y <- suppressWarnings(as.numeric(d_full[[r$outcome_var]]))
  frac_nonint <- mean(abs(y - round(y)) > 1e-9, na.rm = TRUE)

  # Duplikate ganzer Zeilen ueber ALLE numerischen Spalten (ohne ID und Arm)
  allnum <- names(d_full)[vapply(d_full, is.numeric, TRUE)]
  allnum <- setdiff(allnum, c(r$id_var, r$arm_var))
  numcols <- d_full[, allnum, drop = FALSE]
  n_dup_rows <- if (ncol(numcols) >= 3) sum(duplicated(numcols)) else NA_integer_

  # Endziffern-Test auf Outcome, nur bei >= 2 Dezimalen
  dec <- suppressWarnings(nchar(sub("^[^.]*\\.?", "", format(y[!is.na(y)], drop0trailing = TRUE))))
  p_lastdigit <- NA_real_
  if (length(dec) && !is.na(median(dec, na.rm = TRUE)) && median(dec, na.rm = TRUE) >= 2) {
    ld <- as.integer(substr(sprintf("%.2f", y[!is.na(y)]), nchar(sprintf("%.2f", y[!is.na(y)])), nchar(sprintf("%.2f", y[!is.na(y)]))))
    if (length(ld) >= 30) p_lastdigit <- tryCatch(chisq.test(table(factor(ld, levels = 0:9)))$p.value, error = function(e) NA)
  }

  # Flag nur aus explizit benannten Baseline-Variablen, Duplikaten und Endziffern.
  # Die namensbasierte Breitsuche ist explorativ und wird nur berichtet.
  # Endziffern-Test NICHT in der Flag-Regel: Die primaeren Outcomes sind oft
  # abgeleitete Mittelwerte (Mittel aus 3 Spruengen, Wochenmittel /7), deren
  # Endziffern strukturell ungleich verteilt sind. Nur berichtet.
  flag <- (!is.na(pc_named) && (pc_named < 0.005 || pc_named > 0.995)) ||
          (!is.na(n_dup_rows) && n_dup_rows > 0)

  out[[i]] <- data.frame(study_id = r$study_id, n = nrow(d_full),
    n_baseline_named = length(p_named), p_carlisle_named = pc_named,
    n_baseline_all = length(p_all), p_carlisle_all = pc_all,
    frac_outcome_nonint = frac_nonint, n_dup_rows = n_dup_rows, p_lastdigit = p_lastdigit,
    flag = ifelse(flag, "flag", "pass"), stringsAsFactors = FALSE)
}
res <- bind_rows(out)
write.csv(res, "output/integrity_screen.csv", row.names = FALSE)
cat(sprintf("  %-28s %4s %6s %8s %6s %8s %6s %8s %5s\n", "Studie", "n", "k_nam", "p_nam", "k_all", "p_all", "dupRow", "p_digit", "Flag"))
for (i in seq_len(nrow(res))) with(res[i,], cat(sprintf("  %-28s %4d %6d %8.3f %6d %8.3f %6s %8s %5s\n",
  study_id, n, n_baseline_named, p_carlisle_named, n_baseline_all, p_carlisle_all,
  ifelse(is.na(n_dup_rows), "-", n_dup_rows), ifelse(is.na(p_lastdigit), "-", sprintf("%.3f", p_lastdigit)), flag)))
cat("\nFlags:", sum(res$flag == "flag"), "von", nrow(res), "\n")
