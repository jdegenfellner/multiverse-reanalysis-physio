# Sensitivitaet der Varianzzerlegung: additives Modell gegen Modell mit allen
# Zwei-Wege-Interaktionen, nur Studien mit >= 30 eindeutigen Spezifikationen.
# Frage: aendert sich der dominante Knoten? (Statistikgutachten 2026-09-12, Befund 7)
suppressMessages({library(dplyr); library(car)})
r <- read.csv("output/multiverse_all.csv", stringsAsFactors = FALSE); r <- r[!r$is_dup, ]
NODES_V <- intersect(c("baseline","covars","outlier","model","inference","missing","transform","outlier_scope"), names(r))
out <- list()
for (g in c("principled","defensible")) for (s in unique(r$study_id)) {
  x <- r[r$study_id == s & r$grid_type == g, ]
  nod <- NODES_V[vapply(x[NODES_V], function(z) length(unique(z[!is.na(z)])) > 1, TRUE)]
  if (nrow(x) < 30 || length(nod) < 2) next
  m1 <- lm(as.formula(paste("d ~", paste(nod, collapse = "+"))), data = x)
  m2 <- lm(as.formula(paste("d ~ (", paste(nod, collapse = "+"), ")^2")), data = x)
  a1 <- tryCatch(car::Anova(m1, type = 2), error = function(e) NULL)
  a2 <- tryCatch(car::Anova(m2, type = 2, singular.ok = TRUE), error = function(e) NULL)
  if (is.null(a1) || is.null(a2)) next
  sh <- function(a) { ss <- a[["Sum Sq"]]; names(ss) <- rownames(a); ss <- ss[names(ss) != "Residuals"]; ss <- ss[!is.na(ss)]; 100 * ss / sum(ss) }
  s1 <- sh(a1); s2 <- sh(a2); main2 <- s2[!grepl(":", names(s2))]
  out[[length(out)+1]] <- data.frame(study_id = s, grid_type = g, n_spec = nrow(x), n_nodes = length(nod),
    top_additive = names(s1)[which.max(s1)], share_additive = max(s1),
    top_interaction_model = names(main2)[which.max(main2)], share_main_in_interaction_model = max(main2),
    share_all_interactions = sum(s2[grepl(":", names(s2))]))
}
res <- bind_rows(out); write.csv(res, "output/variance_interactions.csv", row.names = FALSE)
print(res, digits = 3)
cat("\nDominanter Knoten wechselt in", sum(res$top_additive != res$top_interaction_model), "von", nrow(res), "Faellen\n")
