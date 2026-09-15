# Varianzzerlegung JE STUDIE, danach ueber Studien zusammengefasst.
#
# WARUM NICHT GEMEINSAM: Ein Modell ueber alle Studien misst zu ~87 % die
# Heterogenitaet zwischen Studien und nicht die analytische Fragilitaet.
# Die Zielgroesse ist, welcher Knoten INNERHALB einer Studie die Streuung treibt.
# Typ II, weil das Gitter nach dem Streichen inkohaerenter Kombinationen
# unbalanciert ist und Typ I dann von der Termreihenfolge abhaengt.
suppressMessages({library(dplyr); library(car)})

r <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE)
NODES_V <- c("baseline","covars","outlier","model","inference",
             "population","transform","outlier_scope","df_method")

decompose <- function(x) {
  nod <- NODES_V[vapply(x[NODES_V], function(z) length(unique(z)) > 1, TRUE)]
  if (!length(nod) || nrow(x) < 10) return(NULL)
  m <- lm(as.formula(paste("d ~", paste(nod, collapse = "+"))), data = x)
  # Wenn die Knoten die Streuung vollstaendig erklaeren, ist die Residualquadratsumme
  # numerisch null und car::Anova bricht ab. Das passiert bei kleinen, sauber
  # faktoriellen Gittern. Dann Typ-I-Quadratsummen, die hier zulaessig sind, weil
  # ohne Residuum keine Ueberlappung zu verteilen ist.
  a <- tryCatch(car::Anova(m, type = 2), error = function(e) stats::anova(m))
  ss <- a[["Sum Sq"]]; names(ss) <- rownames(a)
  ss <- ss[names(ss) != "Residuals"]
  if (!length(ss) || sum(ss) == 0) return(NULL)
  data.frame(node = names(ss), share = 100 * ss / sum(ss), row.names = NULL)
}

out <- list()
for (g in c("principled","defensible")) {
  for (s in unique(r$study_id)) {
    x <- r[r$study_id == s & r$grid_type == g, ]
    dd <- decompose(x)
    if (!is.null(dd)) { dd$study_id <- s; dd$grid_type <- g; out[[length(out)+1]] <- dd }
  }
}
res <- bind_rows(out)
write.csv(res, "output/variance_by_study.csv", row.names = FALSE)

for (g in c("principled","defensible")) {
  cat("\n===", g, "===\n")
  z <- res[res$grid_type == g & res$node != "Residuals", ]
  n_st <- length(unique(z$study_id))
  tab <- z %>% group_by(node) %>%
    summarise(median_share = median(share),
              dominant_in = sum(share > 50),
              top_in = NA, .groups = "drop")
  # in wie vielen Studien ist der Knoten der groesste?
  # ungroup() ist zwingend: count() erbt sonst die Gruppierung nach study_id
  # und zaehlt innerhalb jeder Studie statt ueber Studien hinweg.
  top <- z %>% group_by(study_id) %>% slice_max(share, n = 1, with_ties = FALSE) %>%
         ungroup() %>% count(node)
  tab$top_in <- top$n[match(tab$node, top$node)]; tab$top_in[is.na(tab$top_in)] <- 0
  tab <- tab %>% arrange(desc(top_in), desc(median_share))
  cat(sprintf("  %d Studien\n", n_st))
  cat(sprintf("  %-14s %12s %14s %14s\n", "Knoten", "Median-%", "groesster in", ">50% in"))
  for (i in seq_len(nrow(tab))) with(tab[i,], cat(sprintf(
    "  %-14s %11.1f %13d %14d\n", node, median_share, top_in, dominant_in)))
}
