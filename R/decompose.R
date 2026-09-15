# Varianzzerlegung JE STUDIE, danach ueber Studien zusammengefasst.
#
# Zwei Zielgroessen (METHODENPRUEFUNG.md, Punkt 3):
#   d          = est / feste SD des Rohoutcomes  -> Knoten, die den Schaetzer bewegen
#   ci_width_d = Breite des 95%-Intervalls / SD  -> alle Knoten, auch Inferenz
#
# Nur eindeutige Spezifikationen (is_dup == FALSE), sonst werden Knoten mit
# wirkungslosen Optionen ueberrepraesentiert.
# Typ II, weil das Gitter nach dem Streichen inkohaerenter Kombinationen
# unbalanciert ist und Typ I dann von der Termreihenfolge abhaengt.
suppressMessages({library(dplyr); library(car)})

r <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE)
r <- r[!r$is_dup, ]
NODES_V <- c("baseline","covars","outlier","model","inference","missing","transform","outlier_scope")
NODES_V <- intersect(NODES_V, names(r))

decompose <- function(x, y) {
  nod <- NODES_V[vapply(x[NODES_V], function(z) length(unique(z[!is.na(z)])) > 1, TRUE)]
  if (!length(nod) || nrow(x) < 6) return(NULL)
  m <- lm(as.formula(paste(y, "~", paste(nod, collapse = "+"))), data = x)
  a <- tryCatch(car::Anova(m, type = 2), error = function(e) stats::anova(m))
  ss <- a[["Sum Sq"]]; names(ss) <- rownames(a)
  resid <- ss["Residuals"]; ss <- ss[names(ss) != "Residuals"]
  if (!length(ss) || sum(ss) == 0) return(NULL)
  data.frame(node = names(ss), share = 100 * ss / sum(ss),
             share_incl_resid = 100 * ss / (sum(ss) + resid), row.names = NULL)
}

out <- list()
for (y in c("d", "ci_width_d")) for (g in c("principled","defensible")) for (s in unique(r$study_id)) {
  x <- r[r$study_id == s & r$grid_type == g, ]
  dd <- decompose(x, y)
  if (!is.null(dd)) { dd$study_id <- s; dd$grid_type <- g; dd$target <- y; out[[length(out)+1]] <- dd }
}
res <- bind_rows(out)
write.csv(res, "output/variance_by_study.csv", row.names = FALSE)

summ <- list()
for (y in c("d", "ci_width_d")) for (g in c("principled","defensible")) {
  z <- res[res$grid_type == g & res$target == y, ]
  n_st <- length(unique(z$study_id))
  top <- z %>% group_by(study_id) %>% slice_max(share, n = 1, with_ties = FALSE) %>% ungroup() %>% count(node)
  tab <- z %>% group_by(node) %>%
    summarise(median_share = median(share), iqr_lo = quantile(share, .25), iqr_hi = quantile(share, .75),
              dominant_in = sum(share > 50), n_studies = n(), .groups = "drop")
  tab$top_in <- top$n[match(tab$node, top$node)]; tab$top_in[is.na(tab$top_in)] <- 0
  tab <- tab %>% arrange(desc(top_in), desc(median_share))
  tab$grid_type <- g; tab$target <- y; tab$n_studies_total <- n_st
  summ[[length(summ)+1]] <- tab
  cat(sprintf("\n=== %s | Zielgroesse %s | %d Studien ===\n", g, y, n_st))
  cat(sprintf("  %-14s %9s %14s %14s %9s\n", "Knoten", "Median-%", "groesster in", ">50% in", "Studien"))
  for (i in seq_len(nrow(tab))) with(tab[i,], cat(sprintf(
    "  %-14s %8.1f %13d %14d %9d\n", node, median_share, top_in, dominant_in, n_studies)))
}
write.csv(bind_rows(summ), "output/variance_summary.csv", row.names = FALSE)
