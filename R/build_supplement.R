# Erzeugt manuscript/latex/supplement.md aus den Output- und Config-Dateien.
suppressMessages(library(dplyr))
md <- function(df, digits = 3) {
  df[] <- lapply(df, function(c) if (is.numeric(c)) formatC(c, digits = digits, format = "fg") else as.character(c)); df[is.na(df)] <- ""
  df[] <- lapply(df, function(c) gsub("\\|", "/", c))
  paste(c(paste0("| ", paste(names(df), collapse = " | "), " |"), paste0("|", paste(rep("---", ncol(df)), collapse = "|"), "|"),
          apply(df, 1, function(r) paste0("| ", paste(r, collapse = " | "), " |"))), collapse = "\n")
}
out <- c("# Supplementary material", "",
  "Reproducibility without a mandate: computational reproduction and multiverse analysis of exercise, rehabilitation and physiotherapy trials with publicly deposited individual participant data. Jürgen Degenfellner, ZHAW. Generated from the project files on 2026-09-15.", "",
  "## Text S1. Transparency statement for secondary data analysis (after van den Akker et al. 2021)", "",
  "**Prior knowledge of the data.** All 48 deposits were downloaded on 28 August 2026 and inspected for file structure before the grid of decision nodes was written on the same day. No specification had been computed at that point. The published analyses were extracted from the papers on 12 September 2026, and the mapping rules of Methods 2.3 were fixed after that extraction.", "",
  "**Order of analyses.** First complete multiverse run: 28 August 2026, with the ad hoc mapping (registry v1). Rule-based mapping (registry v2) and rerun: 12 September 2026. Statistical review and corrections (pooled within-group denominator, reproduction rule, multiple imputation): 12 September 2026. Adversarial review, reclassification of outlier rules, addition of the strict grid, long-format baseline correction, refit of the published models: 13 September 2026. Displacement analysis: 13 September 2026.", "",
  "**Decisions made after seeing results.** Outlier rules were moved from the core grid to a sensitivity arm after a winsorising rule on a bounded outcome had produced a range of 1.08 standard deviations. The strict grid was added after the first run showed that in most trials only baseline handling could vary. The core grid was renamed from principled to estimand-preserving after the precision criterion had been applied to baseline handling. The reproduction rule (2% and 10% relative difference) was fixed before any computation. An absolute criterion introduced on 12 September was withdrawn on 13 September and the prespecified rule reinstated, with the absolute difference reported without threshold.", "",
  "**Registry v1 versus v2.** Table S2 lists both mappings, Table S7 the effect of v1 on the results. The sign of the median effect reversed in 7 of 16 trials.", "",
  "**Coders.** One coder to date. A second, blind coding is planned and its agreement will be reported.", "")
ex <- read.csv("config/exclusions.csv", stringsAsFactors = FALSE); ex$study_id <- sub("_PMC.*$", "", ex$study_id); ex$reason <- substr(ex$reason, 1, 160)
out <- c(out, "## Table S1. Exclusions at manual assessment (n = 32)", "", md(ex[, c("study_id","category","reason_code","reason")]), "")
reg <- read.csv("config/registry.csv", stringsAsFactors = FALSE); v1 <- read.csv("config/registry_v1_2026-08-28.csv", stringsAsFactors = FALSE); v1 <- v1[match(reg$study_id, v1$study_id), ]
t2 <- data.frame(study_id = reg$study_id, report_type = reg$report_type, outcome_v2 = reg$outcome_var, outcome_v1 = v1$outcome_var, control_v2 = reg$arm_control, control_v1 = v1$arm_control, covariates_v2 = reg$covars_published, covariates_v1 = v1$covars_published, primary_declared = reg$primary_declared_v3)
out <- c(out, "## Table S2. Trial registry, version 2 (rule-based) against version 1 (ad hoc)", "", md(t2), "")
s <- read.csv("output/summary_by_study.csv"); s3 <- s %>% select(study_id, grid_type, n_spec, n, d_median, d_q25, d_q75, d_min, d_max, share_same_sign, s_median) %>% arrange(study_id, grid_type)
out <- c(out, "## Table S3. Summary measures per trial and grid", "", "grid_type: principled = estimand-preserving; strict = baseline handling fixed to analysis of covariance; defensible = Type E and N nodes; outlier_arm = sensitivity arm.", "", md(s3), "")
u1 <- read.csv("output/uncertainty_proportions.csv"); u2 <- read.csv("output/uncertainty_medians.csv")
out <- c(out, "### Table S3b. Wilson intervals for proportions and study-bootstrap intervals for medians", "", md(u1), "", md(u2), "")
ia <- read.csv("output/variance_interactions.csv"); out <- c(out, "## Table S4. Variance partition with two-way interactions, trial-by-grid combinations with at least 30 specifications", "", md(ia), "")
sb <- read.csv("output/sensitivity_baseline_fixed.csv"); rd <- read.csv("output/range_drivers.csv")
out <- c(out, "## Table S5. Range drivers per trial and range with baseline handling fixed", "", md(rd %>% select(study_id, n, baseline_imbalance_sd, cor_base_outcome, frac_missing, range_p, range_d)), "", md(sb), "")
ig <- read.csv("output/integrity_screen.csv"); out <- c(out, "## Table S6. Data integrity screen", "", "p_carlisle_named: Stouffer-combined p over baseline variables named in the paper (NA where fewer than two). p_carlisle_all: name-based broad search, reported only.", "", md(ig), "")
v <- read.csv("output/registry_v1_vs_v2.csv"); out <- c(out, "## Table S7. Effect of the first mapping (registry v1) on the results, computed with the final engine", "", md(v), "")
dp <- read.csv("output/displacement_by_study.csv"); out <- c(out, "## Table S8. Displacement of the published result per trial and grid", "", md(dp), "")
st2 <- read.csv("output/stage2_published_models.csv", stringsAsFactors = FALSE); st2$deviations <- substr(gsub("\n", " ", st2$deviations), 1, 220); st2$model_as_published <- substr(st2$model_as_published, 1, 160)
out <- c(out, "## Table S9. Published models as fitted, with assumptions recorded", "", md(st2 %>% select(study_id, model_as_published, est, ci_lo, ci_hi, p, n, deviations)), "")
ne <- read.csv("output/stage2_no_estimate.csv", stringsAsFactors = FALSE); out <- c(out, "## Table S10. Test statistics recomputed for the four papers without a point estimate", "", md(ne), "")
rg <- read.csv("config/registrations.csv", stringsAsFactors = FALSE); rg$registered_primary_outcome <- substr(rg$registered_primary_outcome, 1, 140)
out <- c(out, "## Table S11. Trial registrations retrieved", "", md(rg %>% select(study_id, registration_id, retrieved, registered_after_start, registered_primary_outcome, matches_our_outcome_var)), "")
out <- c(out, "## Figure S1. Median and range of d per trial, both grids", "", "![](figures/supp/overview_all_studies.png)", "", "## Figure S2. Share of interval-width variance per node", "", "![](figures/supp/variance_ci_width_d.png)", "")
fs <- sort(list.files("manuscript/latex/figures/supp", "^speccurve_"))
for (i in seq_along(fs)) out <- c(out, sprintf("## Figure S%d. Specification curves, %s", i + 2, sub("^speccurve_", "", sub("[.]png$", "", fs[i]))), "", sprintf("![](figures/supp/%s)", fs[i]), "")
nov <- readLines("literature/novelty_search_2026-09-15.md"); nov <- sub("^# ", "### ", nov); nov <- sub("^## ", "### ", nov)
out <- c(out, "## Text S2. Novelty search protocol, 15 September 2026", "", nov)
writeLines(out, "manuscript/latex/supplement.md"); cat("supplement.md:", length(out), "Zeilen\n")
