# Die Multiverse-Engine.
#
# Eine Studie geht als Zeile der Registry hinein, eine Zeile je Spezifikation
# kommt heraus. Die Engine kennt keine Studie und kein Gitter, sie liest beides.
#
# Neue Studie hinzufuegen = eine Zeile in config/registry.csv. Sonst nichts.

suppressMessages({
  library(dplyr); library(readxl); library(haven)
  library(lme4);  library(lmerTest); library(sandwich); library(lmtest)
})

# ---- Daten laden ------------------------------------------------------------

load_study <- function(reg) {
  f <- file.path(reg$data_file)
  d <- switch(tolower(tools::file_ext(f)),
    xlsx = suppressMessages(readxl::read_excel(f, sheet = if (is.na(reg$sheet) || reg$sheet == "") 1 else reg$sheet)),
    xls  = suppressMessages(readxl::read_excel(f, sheet = if (is.na(reg$sheet) || reg$sheet == "") 1 else reg$sheet)),
    csv  = utils::read.csv(f, stringsAsFactors = FALSE),
    sav  = haven::read_sav(f),
    rds  = readRDS(f),
    stop("Unbekanntes Format: ", f))
  as.data.frame(d)
}

#' Vereinheitlicht die Studie auf interne Spaltennamen .y .arm .id .base
#' und filtert bei Langformat auf den primaeren Zeitpunkt.
harmonise <- function(d, reg) {
  # Leere Fuellzeilen entfernen. SPSS-Exporte enthalten regelmaessig hunderte
  # Zeilen ohne Werte, die als Faelle durchgehen wuerden.
  d <- d[!is.na(d[[reg$arm_var]]), , drop = FALSE]

  # Nur die vergleichsrelevanten Arme behalten. Bei mehr als zwei Armen
  # legt arm_include fest, welcher Kontrast gemeint ist.
  if ("arm_include" %in% names(reg) && !is.na(reg$arm_include) && reg$arm_include != "") {
    keep <- split_vars(reg$arm_include)
    d <- d[as.character(d[[reg$arm_var]]) %in% keep, , drop = FALSE]
  }

  if (!is.na(reg$time_var) && reg$time_var != "") {
    d <- d[as.character(d[[reg$time_var]]) == as.character(reg$primary_time), , drop = FALSE]
  }
  out <- data.frame(
    .id  = if (!is.na(reg$id_var) && reg$id_var != "") d[[reg$id_var]] else seq_len(nrow(d)),
    .arm = factor(as.character(d[[reg$arm_var]])),
    .y   = suppressWarnings(as.numeric(d[[reg$outcome_var]])),
    stringsAsFactors = FALSE)
  out$.arm <- stats::relevel(out$.arm, ref = as.character(reg$arm_control))
  if (!is.na(reg$baseline_var) && reg$baseline_var != "")
    out$.base <- suppressWarnings(as.numeric(d[[reg$baseline_var]]))
  for (v in split_vars(reg$covars_published)) if (v %in% names(d)) out[[v]] <- d[[v]]
  for (v in split_vars(reg$strat_vars))       if (v %in% names(d)) out[[v]] <- d[[v]]
  for (v in split_vars(reg$cluster_vars))     if (v %in% names(d)) out[[v]] <- d[[v]]
  out
}

#' Zufallseffekt-Ebenen, die tatsaechlich schaetzbar sind.
#' Eine Ebene mit so vielen Stufen wie Zeilen ist entartet (ein Fall je Level),
#' das passiert regelmaessig, sobald auf einen Zeitpunkt gefiltert wird.
usable_clusters <- function(reg, d) {
  cl <- intersect(split_vars(reg$cluster_vars), names(d))
  keep <- vapply(cl, function(v) {
    k <- length(unique(d[[v]]))
    k >= 3 && k < nrow(d) * 0.8
  }, TRUE)
  cl[keep]
}

split_vars <- function(x) {
  if (is.na(x) || x == "") return(character(0))
  trimws(strsplit(x, ",")[[1]])
}

# ---- Preprocessing-Knoten ---------------------------------------------------

apply_outlier <- function(d, rule, scope) {
  if (rule == "none") return(d)
  cut_fun <- function(y) {
    switch(sub("_winsor$", "", rule),
      sd3    = c(mean(y, na.rm = TRUE) - 3 * sd(y, na.rm = TRUE),
                 mean(y, na.rm = TRUE) + 3 * sd(y, na.rm = TRUE)),
      iqr15  = { q <- stats::quantile(y, c(.25, .75), na.rm = TRUE)
                 c(q[1] - 1.5 * diff(q), q[2] + 1.5 * diff(q)) },
      mad    = { m <- stats::median(y, na.rm = TRUE); s <- stats::mad(y, na.rm = TRUE)
                 c(m - 3 * s, m + 3 * s) })
  }
  win <- function(y) { b <- cut_fun(y); pmin(pmax(y, b[1]), b[2]) }
  if (scope == "armwise") {
    for (a in levels(d$.arm)) { i <- d$.arm == a; d$.y[i] <- win(d$.y[i]) }
  } else {
    d$.y <- win(d$.y)
  }
  d
}

apply_missing <- function(d, how) {
  if (how == "complete_case") return(d[!is.na(d$.y), , drop = FALSE])
  if (how == "locf" && ".base" %in% names(d)) {
    d$.y[is.na(d$.y)] <- d$.base[is.na(d$.y)]        # LOCF = Baseline fortgeschrieben
    return(d[!is.na(d$.y), , drop = FALSE])
  }
  if (how == "mi") {
    if (!requireNamespace("mice", quietly = TRUE)) return(d[!is.na(d$.y), , drop = FALSE])
    attr(d, "use_mi") <- TRUE                         # Kennzeichen, Pooling im Fit
    return(d)
  }
  d[!is.na(d$.y), , drop = FALSE]
}

apply_transform <- function(d, how) {
  # ACHTUNG: Die Transformation muss auf Outcome UND Baseline wirken. Sonst
  # rechnet der Change-Score log(post) - base und mischt zwei Skalen. Genau das
  # hat im 5-Studien-Pilot ein Vorzeichen kippen lassen.
  if (how == "log") {
    d$.y <- log(d$.y)
    if (".base" %in% names(d)) d$.base <- log(d$.base)
  }
  d
}

# ---- Modellformel -----------------------------------------------------------

build_formula <- function(spec, reg, d) {
  lhs <- if (spec$baseline == "change" && ".base" %in% names(d)) ".y_minus_base" else ".y"
  rhs <- ".arm"
  if (spec$baseline == "ancova" && ".base" %in% names(d)) rhs <- paste(rhs, "+ .base")
  cov <- switch(spec$covars,
    none = character(0),
    baseline_only = character(0),                     # steckt schon in ancova
    baseline_plus_strat = split_vars(reg$strat_vars),
    published = split_vars(reg$covars_published))
  cov <- intersect(cov, names(d))
  # Spaltennamen mit Leerzeichen, Bindestrich oder Punkt brauchen Backticks,
  # sonst ist die Formel syntaktisch ungueltig. Kommt im Korpus oft vor
  # (z.B. "maternal _age", "BB55-Post", "Pre.Strenth.R.Ext").
  if (length(cov)) rhs <- paste(rhs, "+", paste(sprintf("`%s`", cov), collapse = " + "))
  if (spec$model == "mixed_ri") {
    cl <- usable_clusters(reg, d)
    if (length(cl)) rhs <- paste(rhs, "+", paste(sprintf("(1|`%s`)", cl), collapse = " + "))
  }
  stats::as.formula(paste(lhs, "~", rhs))
}

# ---- Eine Spezifikation rechnen ---------------------------------------------

run_spec <- function(spec, reg, d0) {
  d <- d0
  d <- apply_outlier(d, spec$outlier, if (!is.null(spec$outlier_scope)) spec$outlier_scope else "pooled")
  d <- apply_missing(d, if (!is.null(spec$missing)) spec$missing else "complete_case")
  d <- apply_transform(d, if (!is.null(spec$transform)) spec$transform else "none")
  if (!is.null(spec$population) && spec$population == "completers")
    d <- d[!is.na(d$.y), , drop = FALSE]
  if (spec$baseline == "change" && ".base" %in% names(d)) d$.y_minus_base <- d$.y - d$.base
  if (nrow(d) < 10 || length(unique(d$.arm)) < 2) return(NULL)

  f <- build_formula(spec, reg, d)
  arm_term <- paste0(".arm", setdiff(levels(d$.arm), levels(d$.arm)[1])[1])

  res <- try({
    if (spec$model == "mixed_ri" && grepl("\\|", deparse1(f))) {
      m  <- lmerTest::lmer(f, data = d, REML = TRUE,
                           control = lme4::lmerControl(optimizer = "bobyqa"))
      co <- summary(m)$coefficients
      c(est = co[arm_term, "Estimate"], se = co[arm_term, "Std. Error"],
        p = co[arm_term, "Pr(>|t|)"], n = nrow(d),
        sigma = sigma(m), singular = as.numeric(lme4::isSingular(m)))
    } else {
      m  <- stats::lm(f, data = d)
      if (!is.null(spec$inference) && spec$inference == "hc3") {
        ct <- lmtest::coeftest(m, vcov. = sandwich::vcovHC(m, type = "HC3"))
        c(est = ct[arm_term, 1], se = ct[arm_term, 2], p = ct[arm_term, 4], n = nrow(d),
          sigma = sigma(m), singular = 0)
      } else if (!is.null(spec$inference) && spec$inference == "permutation") {
        obs <- unname(coef(m)[arm_term])
        perm <- replicate(499, {
          dd <- d; dd$.arm <- sample(dd$.arm)
          unname(coef(stats::lm(f, data = dd))[arm_term])
        })
        c(est = obs, se = stats::sd(perm),
          p = (1 + sum(abs(perm) >= abs(obs))) / 500, n = nrow(d),
          sigma = sigma(m), singular = 0)
      } else {
        co <- summary(m)$coefficients
        c(est = co[arm_term, 1], se = co[arm_term, 2], p = co[arm_term, 4], n = nrow(d),
          sigma = sigma(m), singular = 0)
      }
    }
  }, silent = TRUE)

  if (inherits(res, "try-error")) return(NULL)
  as.list(res)
}

# ---- Eine Studie durch das ganze Gitter --------------------------------------

run_study <- function(reg, which = "defensible", seed = 20260828) {
  set.seed(seed)
  d0 <- harmonise(load_study(reg), reg)
  g  <- build_grid(reg, d0, which)
  out <- vector("list", nrow(g))
  for (i in seq_len(nrow(g))) {
    r <- run_spec(as.list(g[i, , drop = FALSE]), reg, d0)
    if (!is.null(r)) out[[i]] <- cbind(g[i, , drop = FALSE], as.data.frame(r))
  }
  res <- dplyr::bind_rows(out)
  if (!nrow(res)) return(NULL)
  # WICHTIG: Schaetzer aus Spezifikationen mit verschiedenen Outcome-Skalen
  # (roh gegen log) sind NICHT vergleichbar. Del Giudice & Gangestad 2021 warnen
  # ausdruecklich, dass die zentrale Tendenz dann bedeutungslos wird. Jede
  # studienuebergreifende Zusammenfassung laeuft deshalb ueber d = est / sigma,
  # also die eigene Residual-SD der jeweiligen Skala.
  res$d <- res$est / res$sigma
  res$study_id  <- reg$study_id
  res$grid_type <- which
  res$spec_id   <- seq_len(nrow(res))
  res
}
