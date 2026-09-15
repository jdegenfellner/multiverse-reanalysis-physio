# Schritt 4 des Tutorials: Visualisierung.
#
# Zwei Abbildungen:
#   1. Specification Curve je Studie (Simonsohn et al. 2020): Effekte sortiert,
#      darunter die Belegung der Entscheidungsknoten.
#   2. Uebersicht ueber alle Studien: Spannweite von d, eingefaerbt nach der
#      empirischen Aehnlichkeit der Pipeline-Datensaetze. Ohne diese Einfaerbung
#      waere die Abbildung irrefuehrend (Short et al. 2026 zur Illusion von Konsistenz).
#
# KEINE Einfaerbung nach "signifikant", das waere die Dichotomie, die Wasserstein,
# Schirm & Lazar 2019 ausdruecklich ablehnen.

suppressMessages({library(dplyr); library(ggplot2); library(tidyr)})

r   <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE)
sim <- read.csv("output/pipeline_similarity.csv", stringsAsFactors = FALSE)
dir.create("output/figures", showWarnings = FALSE)

NODES_V <- c("baseline","covars","outlier","model","inference",
             "population","transform","outlier_scope","df_method")

# ---- 1. Specification Curve je Studie ---------------------------------------

spec_curve <- function(sid, grid = "defensible") {
  x <- r[r$study_id == sid & r$grid_type == grid, ]
  if (!nrow(x)) return(NULL)
  x <- x[order(x$d), ]; x$rank <- seq_len(nrow(x))
  nod <- NODES_V[vapply(x[NODES_V], function(z) length(unique(z)) > 1, TRUE)]

  top <- ggplot(x, aes(rank, d)) +
    geom_ribbon(aes(ymin = d - 1.96 * se / sd(x$d, na.rm = TRUE) * 0,
                    ymax = d + 1.96 * se / sd(x$d, na.rm = TRUE) * 0), alpha = 0) +
    geom_hline(yintercept = 0, linewidth = .3, colour = "grey40") +
    geom_point(size = .5, colour = "#1B4B73") +
    labs(x = NULL, y = "standardisierter Effekt d",
         title = sid,
         subtitle = sprintf("%d Spezifikationen (%s)", nrow(x), grid)) +
    theme_minimal(base_size = 9) +
    theme(panel.grid.minor = element_blank(), axis.text.x = element_blank())

  long <- x %>% select(rank, all_of(nod)) %>%
    pivot_longer(-rank, names_to = "node", values_to = "opt")
  # geom_point(shape = 124) zeichnet in ggplot2 4.x nichts, die untere Haelfte
  # der Abbildung blieb leer. geom_tile ist ohnehin der Standard fuer
  # Spec-Curve-Knotenpanels und rendert zuverlaessig.
  bot <- ggplot(long, aes(rank, opt)) +
    geom_tile(fill = "#2F5D50", width = 1, height = 0.55) +
    facet_grid(node ~ ., scales = "free_y", space = "free_y", switch = "y") +
    labs(x = "Spezifikation, sortiert nach Effekt", y = NULL) +
    theme_minimal(base_size = 8) +
    theme(strip.placement = "outside", strip.text.y.left = element_text(angle = 0, hjust = 1),
          panel.grid.minor = element_blank(), axis.text.x = element_blank())

  list(top = top, bot = bot, n_nodes = length(nod))
}

for (sid in unique(r$study_id)) {
  p <- spec_curve(sid)
  if (is.null(p)) next
  f <- file.path("output/figures", paste0("speccurve_", sid, ".png"))
  g <- suppressWarnings(
    gridExtra::arrangeGrob(p$top, p$bot, ncol = 1, heights = c(1, max(1, p$n_nodes * .45))))
  ggsave(f, g, width = 7, height = 3 + p$n_nodes * .55, dpi = 150)
}
cat("Specification Curves geschrieben:", length(list.files("output/figures", "^speccurve")), "\n")

# ---- 2. Uebersicht ueber alle Studien ---------------------------------------

s <- r %>% filter(grid_type == "defensible") %>% group_by(study_id) %>%
  summarise(med = median(d), lo = min(d), hi = max(d),
            stab = mean(sign(d) == sign(median(d))), .groups = "drop") %>%
  left_join(sim %>% select(study_id, cor_min), by = "study_id") %>%
  mutate(wirksam = ifelse(cor_min > 0.99, "Pipelines aendern die Daten kaum (r > .99)",
                          "Pipelines aendern die Daten substanziell"),
         study_id = factor(study_id, levels = study_id[order(med)]))

p <- ggplot(s, aes(med, study_id, colour = wirksam)) +
  geom_vline(xintercept = 0, linewidth = .3, colour = "grey40") +
  geom_errorbarh(aes(xmin = lo, xmax = hi), height = .25, linewidth = .5) +
  geom_point(size = 1.6) +
  scale_colour_manual(values = c("Pipelines aendern die Daten kaum (r > .99)" = "#B0A48A",
                                 "Pipelines aendern die Daten substanziell" = "#1B4B73")) +
  labs(x = "standardisierter Effekt d, Median und Spannweite ueber alle Spezifikationen",
       y = NULL, colour = NULL,
       title = "Multiverse-Spannweiten je Studie",
       subtitle = "Graue Studien: die Preprocessing-Optionen veraendern den Datensatz praktisch nicht") +
  theme_minimal(base_size = 9) +
  theme(legend.position = "bottom", panel.grid.minor = element_blank())
ggsave("output/figures/overview_all_studies.png", p, width = 8, height = 5.5, dpi = 150)
cat("Uebersicht geschrieben\n")
