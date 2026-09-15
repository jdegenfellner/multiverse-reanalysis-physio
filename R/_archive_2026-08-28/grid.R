# Das Spezifikationsgitter.
#
# Definiert die Knoten und Optionen aus NODES.md als Daten, nicht als Code.
# Zwei Gitter im Sinn von Short et al. (AMPPS 2026):
#   defensible  = alles, was das Kodierraster als im Feld verwendet ausweist
#   principled  = die Teilmenge nach Aequivalenzpruefung (Typ E)
#
# Neue Optionen kommen hier dazu. Die Engine liest das Gitter, sie kennt es nicht.

NODES <- list(

  # ---- Typ E: gehen ins principled multiverse ------------------------------
  baseline = list(
    type = "E",
    options = c("endpoint", "change", "ancova"),
    label = "Baseline-Behandlung"
  ),
  covars = list(
    type = "E",
    options = c("none", "baseline_only", "baseline_plus_strat", "published"),
    label = "Kovariatenumfang"
  ),
  outlier = list(
    type = "E",                      # nur gepoolt, armweise ist N
    options = c("none", "sd3_winsor", "iqr15_winsor", "mad_winsor"),
    label = "Ausreisser (gepoolt)"
  ),
  model = list(
    type = "E",
    options = c("lm", "mixed_ri"),   # mmrm nur bei longitudinalen Daten, s. applicable()
    label = "Modellfamilie"
  ),
  inference = list(
    type = "E",
    options = c("model", "hc3", "permutation"),
    label = "Inferenz"
  ),

  # ---- Typ N: eigene Achse, NICHT ins principled multiverse -----------------
  population = list(
    type = "N",
    options = c("itt_observed", "completers"),
    label = "Analysepopulation"
  ),
  missing = list(
    type = "N",
    options = c("complete_case", "mi", "locf"),
    label = "Missing-Strategie"
  ),
  transform = list(
    type = "N",
    options = c("none", "log"),
    label = "Transformation"
  ),
  outlier_scope = list(
    type = "N",
    options = c("pooled", "armwise"),
    label = "Ausreisser gepoolt oder armweise"
  ),

  # ---- Typ U: markierter Zusatzarm ------------------------------------------
  df_method = list(
    type = "U",
    options = c("satterthwaite", "kenward_roger"),
    label = "Freiheitsgrade"
  )
)


#' Ist ein Knoten fuer diese Studie ueberhaupt anwendbar?
#'
#' Gibt die zulaessigen Optionen zurueck oder NA_character_, wenn der Knoten
#' nicht instanziierbar ist. Die Zahl der nicht anwendbaren Knoten je Studie
#' wird berichtet, das ist Teil des Ergebnisses.
applicable_options <- function(node, reg, d) {
  o <- NODES[[node]]$options

  if (node == "baseline" && (is.na(reg$baseline_var) || reg$baseline_var == ""))
    return("endpoint")                                   # ohne Baseline nur Endwert

  if (node == "covars") {
    keep <- "none"
    if (!is.na(reg$baseline_var) && reg$baseline_var != "") keep <- c(keep, "baseline_only")
    if (!is.na(reg$strat_vars) && reg$strat_vars != "")     keep <- c(keep, "baseline_plus_strat")
    if (!is.na(reg$covars_published) && reg$covars_published != "") keep <- c(keep, "published")
    return(keep)
  }

  if (node == "model") {
    if (length(usable_clusters(reg, d)) == 0) return("lm")
    return(o)
  }

  if (node == "missing") {
    if (!any(is.na(d$.y))) return("complete_case")        # nichts fehlt, Knoten entfaellt
    return(o)
  }

  if (node == "transform") {
    # log braucht positive Werte in Outcome UND Baseline, sonst entfaellt die Option
    bad <- any(d$.y <= 0, na.rm = TRUE) ||
           (".base" %in% names(d) && any(d$.base <= 0, na.rm = TRUE))
    if (bad) return("none")
    return(o)
  }

  if (node == "outlier_scope") {
    return(o)
  }

  o
}


#' Baut das Gitter fuer eine Studie.
#'
#' which = "principled" nimmt nur Typ-E-Knoten, "defensible" nimmt E und N und U.
#' Inkohaerente Kombinationen werden entfernt (Simonsohn et al. 2020 verlangen
#' "non-redundant and valid specifications").
build_grid <- function(reg, d, which = c("defensible", "principled")) {
  which <- match.arg(which)
  types <- if (which == "principled") "E" else c("E", "N", "U")
  use <- names(NODES)[vapply(NODES, function(n) n$type %in% types, TRUE)]

  opts <- lapply(use, function(n) applicable_options(n, reg, d))
  names(opts) <- use
  g <- expand.grid(opts, stringsAsFactors = FALSE, KEEP.OUT.ATTRS = FALSE)

  # inkohaerente Kombinationen streichen
  if (all(c("outlier", "outlier_scope") %in% names(g)))
    g <- g[!(g$outlier == "none" & g$outlier_scope == "armwise"), , drop = FALSE]
  if (all(c("missing", "population") %in% names(g)))
    g <- g[!(g$missing == "locf" & g$population == "completers"), , drop = FALSE]
  if (all(c("model", "df_method") %in% names(g)))
    g <- g[!(g$model == "lm" & g$df_method == "kenward_roger"), , drop = FALSE]
  if (all(c("inference", "df_method") %in% names(g)))
    g <- g[!(g$inference == "permutation" & g$df_method == "kenward_roger"), , drop = FALSE]

  attr(g, "grid_type") <- which
  attr(g, "n_dropped_nodes") <- sum(vapply(opts, length, 1L) <
                                    vapply(NODES[use], function(n) length(n$options), 1L))
  g
}
