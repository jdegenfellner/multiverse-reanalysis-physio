# Das Spezifikationsgitter.
#
# Definiert die Knoten und Optionen aus NODES.md als Daten, nicht als Code.
# Zwei Gitter im Sinn von Short et al. (AMPPS 2026):
#   defensible  = alles, was das Kodierraster als im Feld verwendet ausweist
#   principled  = die Teilmenge nach Aequivalenzpruefung (Typ E)
#
# Die Engine liest das Gitter, sie kennt es nicht.
#
# Revision 2026-09-11 (siehe METHODENPRUEFUNG.md, Punkt 1):
#   - df_method entfernt: wurde von der Engine nie gelesen, reine Duplikate.
#   - covars = baseline_only entfernt: identisch mit none (Baseline haengt am Knoten
#     baseline). "baseline_plus_strat" heisst jetzt ehrlich "strat".
#   - population entfernt: ohne Imputation identisch mit complete_case. Die Frage
#     ITT gegen Completer steckt jetzt im Knoten missing (mi = ITT mit Imputation,
#     complete_case = Completer).
#   - Ausreisserregeln nur dann als Option, wenn sie in der Studie tatsaechlich
#     mindestens einen Wert veraendern. Sonst "nicht anwendbar", nicht vier Kopien.

NODES <- list(

  # ---- Typ E: gehen ins principled multiverse ------------------------------
  baseline = list(
    type = "E",
    options = c("endpoint", "change", "ancova"),
    label = "Baseline-Behandlung"
  ),
  covars = list(
    type = "E",
    options = c("none", "strat", "published"),
    label = "Kovariatenumfang"
  ),
  outlier = list(
    type = "U",                      # 2026-09-13: kein Paper im Korpus nutzt eine Regel; Winsorisieren
                                     # veraendert die Zielgroesse; MAD-Regel auf gedeckelten Skalen ist
                                     # ein Artefakt (tDCS). Nur als Sensitivitaetsarm gerechnet.
    options = c("none", "sd3_winsor", "iqr15_winsor", "mad_winsor"),
    label = "Ausreisser (gepoolt)"
  ),
  model = list(
    type = "E",
    options = c("lm", "mixed_ri"),   # mixed_ri nur bei schaetzbarer Clusterung
    label = "Modellfamilie"
  ),
  inference = list(
    type = "E",
    options = c("model", "hc3", "permutation"),
    label = "Inferenz"
  ),

  # ---- Typ N: eigene Achse, NICHT ins principled multiverse -----------------
  missing = list(
    type = "N",
    options = c("complete_case", "mi", "locf"),
    label = "Fehlende Werte / Analysepopulation"
  ),
  transform = list(
    type = "N",
    options = c("none", "log"),
    label = "Transformation"
  ),
  outlier_scope = list(
    type = "U",
    options = c("pooled", "armwise"),
    label = "Ausreisser gepoolt oder armweise"
  )
)

NODE_NAMES <- names(NODES)


#' Ist ein Knoten fuer diese Studie ueberhaupt anwendbar?
#'
#' Gibt die zulaessigen Optionen zurueck. Faellt ein Knoten auf eine Option
#' zurueck, gilt er als "nicht anwendbar" und wird je Studie gezaehlt.
applicable_options <- function(node, reg, d) {
  o <- NODES[[node]]$options
  has_base <- ".base" %in% names(d)

  if (node == "baseline" && !has_base) return("endpoint")

  if (node == "covars") {
    keep <- "none"
    if (!is.na(reg$strat_vars) && reg$strat_vars != "" &&
        length(intersect(split_vars(reg$strat_vars), names(d)))) keep <- c(keep, "strat")
    if (!is.na(reg$covars_published) && reg$covars_published != "" &&
        length(intersect(split_vars(reg$covars_published), names(d)))) keep <- c(keep, "published")
    return(keep)
  }

  if (node == "outlier") {
    # Nur Regeln behalten, die in dieser Studie mindestens einen Wert veraendern
    keep <- "none"
    for (rule in setdiff(o, "none")) {
      dd <- apply_outlier(d, rule, "pooled")
      if (any(abs(dd$.y - d$.y) > 1e-9, na.rm = TRUE) ||
          (has_base && any(abs(dd$.base - d$.base) > 1e-9, na.rm = TRUE))) keep <- c(keep, rule)
    }
    return(keep)
  }

  if (node == "outlier_scope") {
    # armweise nur, wenn es sich fuer mindestens eine wirksame Regel vom Pool unterscheidet
    rules <- setdiff(applicable_options("outlier", reg, d), "none")
    if (!length(rules)) return("pooled")
    for (rule in rules) {
      a <- apply_outlier(d, rule, "pooled"); b <- apply_outlier(d, rule, "armwise")
      if (any(abs(a$.y - b$.y) > 1e-9, na.rm = TRUE)) return(o)
    }
    return("pooled")
  }

  if (node == "model") {
    if (length(usable_clusters(reg, d)) == 0) return("lm")
    return(o)
  }

  if (node == "missing") {
    if (!any(is.na(d$.y))) return("complete_case")       # nichts fehlt, Knoten entfaellt
    keep <- c("complete_case", "mi")
    # LOCF nur, wenn fuer mindestens einen fehlenden Endwert eine Baseline vorliegt;
    # sonst ist LOCF identisch mit complete_case
    if (has_base && any(is.na(d$.y) & !is.na(d$.base))) keep <- c(keep, "locf")
    return(keep)
  }

  if (node == "transform") {
    bad <- any(d$.y <= 0, na.rm = TRUE) || (has_base && any(d$.base <= 0, na.rm = TRUE))
    if (bad) return("none")
    return(o)
  }

  o
}


#' Baut das Gitter fuer eine Studie.
#'
#' which = "principled" nimmt nur Typ-E-Knoten, "defensible" nimmt E und N.
#' Inkohaerente Kombinationen werden entfernt (Simonsohn et al. 2020 verlangen
#' "non-redundant and valid specifications").
build_grid <- function(reg, d, which = c("defensible", "principled", "strict", "outlier_arm")) {
  which <- match.arg(which)
  # principled  = Typ E ("estimand-preserving": gleiches Estimand, Praezision darf differieren)
  # strict      = Typ E ohne Baseline-Behandlung (Del Giudice streng: ANCOVA hat Vorrang)
  # defensible  = Typ E + N
  # outlier_arm = Typ E + Ausreisserknoten (Sensitivitaet, Typ U)
  types <- switch(which, principled = "E", strict = "E", defensible = c("E", "N"), outlier_arm = c("E", "U"))
  use <- names(NODES)[vapply(NODES, function(n) n$type %in% types, TRUE)]
  if (which == "strict") use <- setdiff(use, "baseline")

  opts <- lapply(use, function(n) applicable_options(n, reg, d))
  names(opts) <- use
  g <- expand.grid(opts, stringsAsFactors = FALSE, KEEP.OUT.ATTRS = FALSE)
  if (which == "strict") g$baseline <- if (".base" %in% names(d)) "ancova" else "endpoint"   # Referenz fixiert

  # inkohaerente Kombinationen streichen
  # HC3 und Permutation sind fuer lm definiert; bei mixed_ri gibt es nur den
  # modellbasierten SE (Satterthwaite). Sonst Duplikate.
  if (all(c("model", "inference") %in% names(g)))
    g <- g[!(g$model == "mixed_ri" & g$inference != "model"), , drop = FALSE]
  if (all(c("outlier", "outlier_scope") %in% names(g)))
    g <- g[!(g$outlier == "none" & g$outlier_scope == "armwise"), , drop = FALSE]
  if (all(c("missing", "inference") %in% names(g)))
    g <- g[!(g$missing == "mi" & g$inference == "permutation"), , drop = FALSE]  # kein Permutationstest ueber gepoolte MI

  full <- vapply(NODES[use], function(n) length(n$options), 1L)
  got  <- vapply(opts, length, 1L)
  attr(g, "grid_type") <- which
  attr(g, "nodes_not_applicable") <- names(got)[got < full]
  attr(g, "n_dropped_nodes") <- sum(got < full)
  g
}
