# Visualisierung.
#
#   1. Specification Curve je Studie: principled und defensible nebeneinander,
#      95%-Intervall je Spezifikation als Band, publizierter Schaetzer als Linie
#      (wenn config/published.csv vorhanden). Darunter die Knotenbelegung.
#   2. Uebersicht ueber alle Studien: Median und Spannweite von d in beiden
#      Gittern, eingefaerbt nach Pipeline-Aehnlichkeit (Short et al. 2026).
#   3. Varianzzerlegung als gestapelte Balken je Studie.
#
# Keine Einfaerbung nach "signifikant" (Wasserstein, Schirm & Lazar 2019).
# Nur eindeutige Spezifikationen.

suppressMessages({library(dplyr); library(ggplot2); library(tidyr); library(patchwork)})

r   <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE) %>% filter(!is_dup)
sim <- if (file.exists("output/pipeline_similarity.csv")) read.csv("output/pipeline_similarity.csv", stringsAsFactors = FALSE) else NULL
pub <- if (file.exists("config/published.csv")) read.csv("config/published.csv", stringsAsFactors = FALSE) else NULL
if (!is.null(pub) && file.exists("config/published_overrides.csv")) {   # dokumentierte Korrekturen anwenden
  ov <- read.csv("config/published_overrides.csv", stringsAsFactors = FALSE)
  for (i in seq_len(nrow(ov))) pub$published_est[pub$study_id == ov$study_id[i]] <- ov$published_est[i]
}
dir.create("output/figures", showWarnings = FALSE)
unlink(list.files("output/figures", "^speccurve_.*\\.png$", full.names = TRUE))   # keine Kurven ausgeschlossener Studien

NODES_V <- intersect(c("baseline","covars","outlier","model","inference","missing","transform","outlier_scope"), names(r))
COL_P <- "#1B4B73"; COL_D <- "#8C6D31"

# ---- 1. Specification Curve je Studie ---------------------------------------

spec_panel <- function(x, col, title, pub_d = NA) {
  x <- x[order(x$d), ]; x$rank <- seq_len(nrow(x))
  x$lo <- x$ci_lo / x$sd_denom; x$hi <- x$ci_hi / x$sd_denom
  nod <- NODES_V[vapply(x[NODES_V], function(z) length(unique(z[!is.na(z)])) > 1, TRUE)]
  top <- ggplot(x, aes(rank, d)) +
    geom_ribbon(aes(ymin = lo, ymax = hi), fill = col, alpha = .15) +
    geom_hline(yintercept = 0, linewidth = .3, colour = "grey40") +
    geom_point(size = .6, colour = col) +
    labs(x = NULL, y = "d (estimate / pooled SD of raw outcome)", title = title,
         subtitle = sprintf("%d specifications", nrow(x))) +
    theme_minimal(base_size = 9) +
    theme(panel.grid.minor = element_blank(), axis.text.x = element_blank())
  if (!is.na(pub_d)) top <- top + geom_hline(yintercept = pub_d, linetype = "dashed", colour = "#A03030", linewidth = .5)
  if (!length(nod)) return(top)
  long <- x %>% select(rank, all_of(nod)) %>% pivot_longer(-rank, names_to = "node", values_to = "opt") %>% filter(!is.na(opt))
  bot <- ggplot(long, aes(rank, opt)) +
    geom_tile(fill = col, width = 1, height = 0.55) +
    facet_grid(node ~ ., scales = "free_y", space = "free_y", switch = "y") +
    labs(x = "Specification, sorted by effect", y = NULL) +
    theme_minimal(base_size = 8) +
    theme(strip.placement = "outside", strip.text.y.left = element_text(angle = 0, hjust = 1),
          panel.grid.minor = element_blank(), axis.text.x = element_blank())
  top / bot + plot_layout(heights = c(1, max(1, length(nod) * .4)))
}

for (sid in unique(r$study_id)) {
  xp <- r[r$study_id == sid & r$grid_type == "principled", ]
  xd <- r[r$study_id == sid & r$grid_type == "defensible", ]
  if (!nrow(xp) || !nrow(xd)) next
  pub_d <- NA
  if (!is.null(pub) && sid %in% pub$study_id) {
    pe <- pub$published_est[pub$study_id == sid]
    if (!is.na(pe) && !isTRUE(pub$published_scale[pub$study_id == sid] == "log")) pub_d <- pe / xp$sd_denom[1]
  }
  p <- (spec_panel(xp, COL_P, paste0(sid, " | estimand-preserving grid (Type E)"), pub_d) |
        spec_panel(xd, COL_D, "defensible grid (Type E and N)", pub_d)) +
       plot_annotation(caption = "Band: 95% interval per specification. Dashed line: published estimate where reported.")
  nn <- max(3, length(NODES_V))
  ggsave(file.path("output/figures", paste0("speccurve_", sid, ".png")), p, width = 12, height = 3.2 + nn * .5, dpi = 150)
}
cat("Specification Curves geschrieben:", length(list.files("output/figures", "^speccurve")), "\n")

# ---- 2. Uebersicht ueber alle Studien ---------------------------------------

s <- r %>% filter(grid_type %in% c("principled","defensible")) %>% group_by(study_id, grid_type) %>%
  summarise(med = median(d), lo = min(d), hi = max(d), n = max(n), .groups = "drop")
ord <- s %>% filter(grid_type == "principled") %>% arrange(med) %>% pull(study_id)
if (!is.null(sim)) s <- s %>% left_join(sim %>% select(study_id, cor_min), by = c("study_id"))
s$study_id <- factor(s$study_id, levels = ord)
s$grid_type <- factor(s$grid_type, levels = c("defensible", "principled"))
pubd <- NULL
if (!is.null(pub)) {
  pubd <- r %>% filter(grid_type == "principled") %>% group_by(study_id) %>% summarise(sd_denom = first(sd_denom), .groups = "drop") %>%
    inner_join(pub, by = "study_id") %>% filter(!is.na(published_est), is.na(published_scale) | published_scale != "log") %>%
    mutate(pd = published_est / sd_denom, study_id = factor(study_id, levels = ord))
}

p <- ggplot(s, aes(y = study_id, colour = grid_type)) +
  geom_vline(xintercept = 0, linewidth = .3, colour = "grey40") +
  geom_errorbarh(aes(xmin = lo, xmax = hi), height = .3, linewidth = .6, position = position_dodge(width = .6)) +
  geom_point(aes(x = med), size = 1.7, position = position_dodge(width = .6)) +
  scale_colour_manual(values = c(principled = COL_P, defensible = COL_D),
                      labels = c(principled = "estimand-preserving grid (Type E)", defensible = "defensible grid (Type E and N)")) +
  labs(x = "Standardised effect d = estimate / pooled within-group SD of the raw outcome; median and range", y = NULL, colour = NULL,
       title = "Multiverse range per trial, both grids",
       subtitle = "Red cross: published estimate where reported") +
  theme_minimal(base_size = 9) + theme(legend.position = "bottom", panel.grid.minor = element_blank())
if (!is.null(pubd) && nrow(pubd)) p <- p + geom_point(data = pubd, aes(x = pd, y = study_id), inherit.aes = FALSE, shape = 4, size = 2.4, colour = "#A03030", stroke = 1)
ggsave("output/figures/overview_all_studies.png", p, width = 9, height = 6, dpi = 150)

# ---- 3. Varianzzerlegung je Studie ------------------------------------------

v <- read.csv("output/variance_by_study.csv", stringsAsFactors = FALSE)
for (tg in c("d", "ci_width_d")) {
  z <- v %>% filter(target == tg) %>% mutate(study_id = factor(study_id, levels = ord),
    node = factor(node, levels = c("baseline","covars","outlier","model","inference","missing","transform","outlier_scope")))
  p <- ggplot(z, aes(share, study_id, fill = node)) + geom_col(width = .7) +
    facet_wrap(~ grid_type) + scale_fill_brewer(palette = "Set2") +
    labs(x = "Share of Type II sum of squares (%)", y = NULL, fill = "Node",
         title = if (tg == "d") "Which node moves the estimate?" else "Which node moves the interval width?") +
    theme_minimal(base_size = 9) + theme(legend.position = "bottom", panel.grid.minor = element_blank())
  ggsave(sprintf("output/figures/variance_%s.png", tg), p, width = 10, height = 6, dpi = 150)
}
cat("Uebersicht und Varianzgrafiken geschrieben\n")
