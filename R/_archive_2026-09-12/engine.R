# Die Multiverse-Engine.
#
# Eine Studie geht als Zeile der Registry hinein, eine Zeile je Spezifikation
# kommt heraus. Die Engine kennt keine Studie und kein Gitter, sie liest beides.
#
# Revision 2026-09-11 (METHODENPRUEFUNG.md):
#   - Fester Nenner je Studie: d = est / SD des Rohoutcomes (gepoolt, vor jeder
#     Vorverarbeitung). Die Residual-SD des Modells (sigma) haengt von der
#     Spezifikation ab und erzeugte Nenner-Artefakte. sigma wird weiter berichtet.
#   - Multiple Imputation tatsaechlich implementiert (mice, m = 10, Rubin-Pooling).
#   - Winsorizing wirkt auf Outcome UND Baseline, sonst mischt der Change Score.
#   - Intervallbreite als zweite Zielgroesse (fuer Inferenzknoten).
#   - Duplikat-Kennzeichnung: identische (est, se, p) innerhalb einer Studie.

suppressMessages({
  library(dplyr); library(readxl); library(haven)
  library(lme4);  library(lmerTest); library(sandwich); library(lmtest)
})

MI_M <- 20          # White, Royston & Wood 2011: m >= 100 x FMI; hoechste Missing-Rate im Korpus 35 %
N_PERM <- 4999      # s-Wert-Deckel -log2(1/5000) = 12.3 Bit

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

split_vars <- function(x) {
  if (is.null(x) || is.na(x) || x == "") return(character(0))
  trimws(strsplit(x, ",")[[1]])
}

#' Vereinheitlicht die Studie auf interne Spaltennamen .y .arm .id .base
#' und filtert bei Langformat auf den primaeren Zeitpunkt.
#' Haengt die festen Nenner als Attribute an: sd_raw, sd_log.
harmonise <- function(d, reg) {
  d <- d[!is.na(d[[reg$arm_var]]), , drop = FALSE]
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

  # Feste Nenner: gepoolte INNERHALB-Gruppen-SD des Rohoutcomes (Cohen/Hedges-Konvention),
  # vor jeder Vorverarbeitung. Die Gesamt-SD ueber beide Arme enthielte den Behandlungs-
  # effekt selbst im Nenner (Statistikgutachten 2026-09-12, Befund 2).
  pooled_sd <- function(y, g) {
    ok <- !is.na(y); y <- y[ok]; g <- g[ok]
    v <- tapply(y, g, stats::var); n <- tapply(y, g, length)
    sqrt(sum((n - 1) * v, na.rm = TRUE) / sum(n - 1, na.rm = TRUE))
  }
  attr(out, "sd_raw") <- pooled_sd(out$.y, out$.arm)
  attr(out, "sd_log") <- if (all(out$.y > 0, na.rm = TRUE)) pooled_sd(log(out$.y), out$.arm) else NA_real_
  out
}

#' Zufallseffekt-Ebenen, die tatsaechlich schaetzbar sind.
usable_clusters <- function(reg, d) {
  cl <- intersect(split_vars(reg$cluster_vars), names(d))
  keep <- vapply(cl, function(v) {
    k <- length(unique(d[[v]]))
    k >= 3 && k < nrow(d) * 0.8
  }, TRUE)
  cl[keep]
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
  vars <- intersect(c(".y", ".base"), names(d))
  for (v in vars) {
    if (scope == "armwise") {
      for (a in levels(d$.arm)) { i <- d$.arm == a; d[[v]][i] <- win(d[[v]][i]) }
    } else {
      d[[v]] <- win(d[[v]])
    }
  }
  d
}

apply_missing <- function(d, how) {
  if (how == "locf" && ".base" %in% names(d)) {
    d$.y[is.na(d$.y)] <- d$.base[is.na(d$.y)]        # LOCF = Baseline fortgeschrieben
    return(d[!is.na(d$.y), , drop = FALSE])
  }
  if (how == "mi") { attr(d, "use_mi") <- TRUE; return(d) }   # Imputation im Fit
  d[!is.na(d$.y), , drop = FALSE]                     # complete_case
}

apply_transform <- function(d, how) {
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
    none      = character(0),
    strat     = split_vars(reg$strat_vars),
    published = split_vars(reg$covars_published))
  cov <- intersect(cov, names(d))
  if (length(cov)) rhs <- paste(rhs, "+", paste(sprintf("`%s`", cov), collapse = " + "))
  if (spec$model == "mixed_ri") {
    cl <- usable_clusters(reg, d)
    if (length(cl)) rhs <- paste(rhs, "+", paste(sprintf("(1|`%s`)", cl), collapse = " + "))
  }
  stats::as.formula(paste(lhs, "~", rhs))
}

# ---- Ein Fit ----------------------------------------------------------------

fit_one <- function(d, f, spec, arm_term) {
  if (spec$model == "mixed_ri" && grepl("\\|", deparse1(f))) {
    m  <- lmerTest::lmer(f, data = d, REML = TRUE,
                         control = lme4::lmerControl(optimizer = "bobyqa"))
    co <- summary(m)$coefficients
    return(c(est = co[arm_term, "Estimate"], se = co[arm_term, "Std. Error"],
             p = co[arm_term, "Pr(>|t|)"], df = co[arm_term, "df"],
             sigma = sigma(m), singular = as.numeric(lme4::isSingular(m))))
  }
  m <- stats::lm(f, data = d)
  inf <- if (is.null(spec$inference)) "model" else spec$inference
  if (inf == "hc3") {
    ct <- lmtest::coeftest(m, vcov. = sandwich::vcovHC(m, type = "HC3"))
    return(c(est = ct[arm_term, 1], se = ct[arm_term, 2], p = ct[arm_term, 4],
             df = m$df.residual, sigma = sigma(m), singular = 0))
  }
  if (inf == "permutation") {
    obs <- unname(coef(m)[arm_term])
    perm <- replicate(N_PERM, {
      dd <- d; dd$.arm <- sample(dd$.arm)
      unname(coef(stats::lm(f, data = dd))[arm_term])
    })
    return(c(est = obs, se = stats::sd(perm),
             p = (1 + sum(abs(perm) >= abs(obs))) / (N_PERM + 1),
             df = m$df.residual, sigma = sigma(m), singular = 0))
  }
  co <- summary(m)$coefficients
  c(est = co[arm_term, 1], se = co[arm_term, 2], p = co[arm_term, 4],
    df = m$df.residual, sigma = sigma(m), singular = 0)
}

#' Multiple Imputation mit mice, Fit je imputiertem Datensatz, Rubin-Pooling.
fit_mi <- function(d, f, spec, reg, arm_term, seed) {
  imp_vars <- intersect(c(".y", ".base", ".arm", split_vars(reg$covars_published),
                          split_vars(reg$strat_vars)), names(d))
  di <- d[, imp_vars, drop = FALSE]
  for (v in names(di)) if (is.character(di[[v]])) di[[v]] <- factor(di[[v]])
  imp <- mice::mice(di, m = MI_M, method = "pmm", seed = seed, printFlag = FALSE)
  fits <- lapply(seq_len(MI_M), function(k) {
    dk <- d; ck <- mice::complete(imp, k)
    for (v in names(ck)) dk[[v]] <- ck[[v]]
    if (spec$baseline == "change" && ".base" %in% names(dk)) dk$.y_minus_base <- dk$.y - dk$.base
    fit_one(dk, f, spec, arm_term)
  })
  M <- do.call(rbind, fits)
  qbar <- mean(M[, "est"]); W <- mean(M[, "se"]^2); B <- stats::var(M[, "est"])
  Tv <- W + (1 + 1 / MI_M) * B
  lambda <- (1 + 1 / MI_M) * B / Tv
  df_old <- (MI_M - 1) / max(lambda, 1e-12)^2
  df_com <- mean(M[, "df"])
  df_obs <- (df_com + 1) / (df_com + 3) * df_com * (1 - lambda)
  df_bar <- 1 / (1 / df_old + 1 / df_obs)                  # Barnard & Rubin 1999
  c(est = qbar, se = sqrt(Tv), p = 2 * stats::pt(-abs(qbar / sqrt(Tv)), df_bar),
    df = df_bar, sigma = mean(M[, "sigma"]), singular = max(M[, "singular"]))
}

# ---- Eine Spezifikation rechnen ---------------------------------------------

run_spec <- function(spec, reg, d0, seed = 1) {
  d <- d0
  d <- apply_outlier(d, spec$outlier, if (!is.null(spec$outlier_scope)) spec$outlier_scope else "pooled")
  d <- apply_missing(d, if (!is.null(spec$missing)) spec$missing else "complete_case")
  d <- apply_transform(d, if (!is.null(spec$transform)) spec$transform else "none")
  use_mi <- isTRUE(attr(d, "use_mi"))
  if (spec$baseline == "change" && ".base" %in% names(d)) d$.y_minus_base <- d$.y - d$.base
  if (nrow(d) < 10 || length(unique(d$.arm)) < 2) return(NULL)

  f <- build_formula(spec, reg, d)
  arm_term <- paste0(".arm", setdiff(levels(d$.arm), levels(d$.arm)[1])[1])

  res <- try(
    if (use_mi) fit_mi(d, f, spec, reg, arm_term, seed) else fit_one(d, f, spec, arm_term),
    silent = TRUE)
  if (inherits(res, "try-error")) return(NULL)
  out <- as.list(res)
  out$n <- if (use_mi) nrow(d) else sum(!is.na(d$.y))
  out
}

# ---- Eine Studie durch das ganze Gitter --------------------------------------

run_study <- function(reg, which = "defensible", seed = 20260828) {
  set.seed(seed)
  d0 <- harmonise(load_study(reg), reg)
  g  <- build_grid(reg, d0, which)
  out <- vector("list", nrow(g))
  for (i in seq_len(nrow(g))) {
    r <- run_spec(as.list(g[i, , drop = FALSE]), reg, d0, seed = seed + i)
    if (!is.null(r)) out[[i]] <- cbind(g[i, , drop = FALSE], as.data.frame(r))
  }
  res <- dplyr::bind_rows(out)
  if (!nrow(res)) return(NULL)

  # Fester Nenner je Studie (METHODENPRUEFUNG.md, Punkt 2). Log-Spezifikationen
  # bekommen die SD des logarithmierten Rohoutcomes; sie bleiben ein eigener Arm.
  sd_raw <- attr(d0, "sd_raw"); sd_log <- attr(d0, "sd_log")
  is_log <- if ("transform" %in% names(res)) res$transform == "log" else rep(FALSE, nrow(res))
  denom <- ifelse(is_log, sd_log, sd_raw)
  res$sd_denom  <- denom
  res$d         <- res$est / denom
  res$d_resid   <- res$est / res$sigma                     # alte Definition, nur zum Vergleich
  res$ci_lo     <- res$est - 1.96 * res$se
  res$ci_hi     <- res$est + 1.96 * res$se
  res$ci_width_d <- 2 * 1.96 * res$se / denom              # Intervallbreite, standardisiert
  res$s_value   <- -log2(pmax(res$p, 1e-300))

  # Duplikate: identisches (est, se, p) innerhalb der Studie ist EINE Spezifikation
  key <- paste(signif(res$est, 10), signif(res$se, 10), signif(res$p, 10))
  res$dup_group <- as.integer(factor(key, levels = unique(key)))
  res$is_dup    <- duplicated(key)

  res$study_id  <- reg$study_id
  res$grid_type <- which
  res$spec_id   <- seq_len(nrow(res))
  attr(res, "nodes_not_applicable") <- attr(g, "nodes_not_applicable")
  res
}
