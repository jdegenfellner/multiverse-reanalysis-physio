# Baut config/published.csv aus coding/extracted/*.json.
suppressMessages({library(jsonlite); library(dplyr)})
fs <- list.files("coding/extracted", "\\.json$", full.names = TRUE)
fs <- fs[!grepl("impuls", fs)]
rows <- lapply(fs, function(f) {
  j <- fromJSON(f, simplifyVector = TRUE)
  pe <- j$published_estimate
  g <- function(v) if (is.null(v) || length(v) == 0) NA else v
  data.frame(study_id = j$study_id,
    primary_outcome = g(j$primary_outcome_name), primary_outcome_declared = g(j$primary_outcome_declared),
    primary_timepoint = g(j$primary_timepoint), n_randomised = g(j$n_randomised), n_analysed = g(j$n_analysed_primary),
    population = g(j$population), field = g(j$field), delivered_by = g(j$intervention_delivered_by),
    published_type = g(pe$type), published_est = as.numeric(g(pe$value)), published_ci_lo = as.numeric(g(pe$ci_low)),
    published_ci_hi = as.numeric(g(pe$ci_high)), published_se = as.numeric(g(pe$se)), published_p = as.numeric(g(pe$p)),
    published_scale = g(pe$scale), direction = g(pe$direction_favours),
    B_baseline_handling = g(j$B_baseline_handling), B_covariates = g(j$B_covariates), B_analysis_population = g(j$B_analysis_population),
    B_missing_strategy = g(j$B_missing_strategy), B_outlier_rule = g(j$B_outlier_rule), B_transformation = g(j$B_transformation),
    B_model_family = g(j$B_model_family), B_time_handling = g(j$B_time_handling), B_clustering_modelled = g(j$B_clustering_modelled),
    B_se_method = g(j$B_se_method), B_multiplicity = g(j$B_multiplicity),
    C_baseline_test_reported = g(j$C_baseline_test_reported), C_adjust_after_baseline_test = g(j$C_adjust_after_baseline_test),
    C_estimand_stated = g(j$C_estimand_stated), C_protocol_available = g(j$C_protocol_available), registration_id = g(j$registration_id),
    journal = g(j$journal), journal_requires_data_sharing = g(j$journal_requires_data_sharing),
    registry_outcome_ok = g(j$registry_check$outcome_var_matches_primary), registry_control_ok = g(j$registry_check$control_arm_matches),
    registry_issues = g(j$registry_check$issues), mcid_raw = NA_real_,
    stringsAsFactors = FALSE)
})
res <- bind_rows(rows)
write.csv(res, "config/published.csv", row.names = FALSE)
cat("published.csv:", nrow(res), "Studien,", sum(!is.na(res$published_est)), "mit publiziertem Schaetzer\n")
print(res[, c("study_id","field","population","published_est","published_p","B_baseline_handling","B_model_family","registry_outcome_ok")])
