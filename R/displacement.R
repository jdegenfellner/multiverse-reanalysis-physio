# Verschiebung des publizierten Hauptergebnisses unter dem Multiverse.
# Anker je Studie: der in Stufe 2 nachgerechnete publizierte Schaetzer (stage2_final.csv),
# standardisiert mit demselben Nenner wie das Gitter (Skala beachten: Log gegen Log).
# Fuer jede Spezifikation: Delta = d_spec - d_published. Berichtet je Studie und Gitter:
# Median, Spannweite und maximale |Delta|; Anteil |Delta| <= 0.1 SD; Anteil mit Vorzeichen
# des publizierten Werts; ob eine Alternative das publizierte Vorzeichen umkehrt.
suppressMessages({library(dplyr); library(ggplot2)})
r  <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE) %>% filter(!is_dup)
s2 <- read.csv("output/stage2_final.csv", stringsAsFactors = FALSE)
out <- list(); rows <- list()
for (i in seq_len(nrow(s2))) {
  sid <- s2$study_id[i]; on_log <- isTRUE(s2$published_scale[i] == "log")
  for (g in c("principled", "defensible")) {
    x <- r[r$study_id == sid & r$grid_type == g, ]
    if (on_log) x <- x[!is.na(x$transform) & x$transform == "log", ] else if ("transform" %in% names(x)) x <- x[is.na(x$transform) | x$transform != "log", ]
    if (!nrow(x)) next
    d_pub <- s2$est[i] / x$sd_denom[1]            # reproduzierter publizierter Schaetzer auf Gitterskala
    delta <- x$d - d_pub
    rows[[length(rows)+1]] <- data.frame(study_id = sid, grid_type = g, spec_id = x$spec_id, d = x$d, d_pub = d_pub, delta = delta)
    out[[length(out)+1]] <- data.frame(study_id = sid, grid_type = g, n_spec = nrow(x), d_published = d_pub,
      delta_median = median(delta), delta_min = min(delta), delta_max = max(delta), abs_delta_max = max(abs(delta)),
      share_within_0.1 = mean(abs(delta) <= 0.1), share_within_0.2 = mean(abs(delta) <= 0.2),
      share_same_sign_as_published = mean(sign(x$d) == sign(d_pub)), any_sign_reversal = any(sign(x$d) != sign(d_pub)))
  }
}
res <- bind_rows(out); long <- bind_rows(rows)
write.csv(res, "output/displacement_by_study.csv", row.names = FALSE); write.csv(long, "output/displacement_long.csv", row.names = FALSE)
for (g in c("principled","defensible")) {
  z <- res[res$grid_type == g, ]
  cat(sprintf("\n=== %s: Verschiebung gegenueber dem publizierten Ergebnis, %d Studien ===\n", g, nrow(z)))
  for (j in order(-z$abs_delta_max)) with(z[j,], cat(sprintf("  %-28s d_publ %6.2f | Delta median %6.3f, Spanne %6.3f bis %6.3f, max|Delta| %.3f | <=0.1 SD: %3.0f%% | gleiches Vorzeichen: %3.0f%%%s\n",
    study_id, d_published, delta_median, delta_min, delta_max, abs_delta_max, 100*share_within_0.1, 100*share_same_sign_as_published, ifelse(any_sign_reversal, " | UMKEHR", ""))))
  cat(sprintf("  Ueber Studien: max|Delta| Median %.3f (IQR %.3f-%.3f, max %.3f) | alle Spez. innerhalb 0.1 SD in %d von %d | Vorzeichenumkehr in %d\n",
    median(z$abs_delta_max), quantile(z$abs_delta_max,.25), quantile(z$abs_delta_max,.75), max(z$abs_delta_max), sum(z$share_within_0.1 == 1), nrow(z), sum(z$any_sign_reversal)))
}
# Abbildung: Verschiebung je Spezifikation, Anker bei 0
lab <- c(physiofeedback_PMC12821712="Balance feedback", lytras_fms_PMC12942207="Lytras", tereco_PMC8318721="TERECO", spadi_PMC4880881="Frozen shoulder", tscs_PMC13085461="tSCS", tdcs_PMC13257960="tDCS", etip_PMC6886967="ETIP", gainingmore_PMC10809978="Deload", etre_PMC11945196="eTRE", creatine_PMC11944689="Creatine", free_PMC6733445="FREE", mallorca_PMC8198819="Water exercise")
ordd <- res %>% group_by(study_id) %>% summarise(m = max(abs_delta_max), .groups = "drop") %>% arrange(m)
long$trial <- factor(lab[long$study_id], levels = lab[ordd$study_id])
long$grid <- factor(long$grid_type, levels = c("defensible","principled"), labels = c("defensible grid (Type E and N)", "estimand-preserving grid (Type E)"))
p <- ggplot(long, aes(delta, trial, colour = grid)) + geom_vline(xintercept = 0, linewidth = .4) +
  geom_vline(xintercept = c(-0.1, 0.1), linewidth = .3, linetype = "dotted", colour = "grey50") +
  geom_point(position = position_dodge(width = .6), size = 1.2, alpha = .7) +
  scale_colour_manual(values = c("#8C6D31", "#1B4B73")) +
  labs(x = "Displacement of the standardised effect from the reproduced published estimate (SD units)", y = NULL, colour = NULL,
       title = "How far does the published result move under alternative specifications?", subtitle = "Zero = reproduced published estimate; dotted lines at 0.1 SD") +
  theme_minimal(base_size = 9) + theme(legend.position = "bottom", panel.grid.minor = element_blank())
ggsave("output/figures/displacement.png", p, width = 9, height = 5.5, dpi = 150)
cat("\nAbbildung: output/figures/displacement.png\n")
