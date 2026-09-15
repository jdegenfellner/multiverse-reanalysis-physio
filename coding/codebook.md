# Codebook zum Kodierraster

Eine Zeile je Studie. Erfasst wird, **was das Paper tatsaechlich getan hat**,
nicht was wir spaeter variieren. `unclear` heisst: im Paper nicht entscheidbar.
`not_reported` heisst: die Entscheidung wurde getroffen, aber nicht berichtet.
Der Unterschied ist selbst ein Ergebnis.

| Spalte | Erlaubte Werte | Knotentyp |
|---|---|---|
| `A_n_randomised` | Zahl |  |
| `A_n_analysed_primary` | Zahl |  |
| `A_n_arms` | Zahl |  |
| `A_primary_outcome` | Freitext, Instrumentname |  |
| `A_outcome_scale_min` | Zahl oder leer |  |
| `A_outcome_scale_max` | Zahl oder leer |  |
| `A_n_timepoints` | Zahl |  |
| `A_primary_timepoint` | Freitext, z.B. '12 Wochen' |  |
| `A_cluster_present` | none|therapist|site|treatment_group|partial_nesting|unclear |  |
| `A_blinded_assessor` | yes|no|unclear |  |
| `B_baseline_handling` | endpoint|change|percent_change|ancova|other|unclear | E (percent_change: N) |
| `B_covariates` | none|baseline_only|baseline_plus_strat|published_set|data_driven|unclear | E |
| `B_analysis_population` | itt|mitt|per_protocol|as_treated|complete_case|unclear | N |
| `B_mitt_definition` | Freitext, wenn mitt | U in N |
| `B_missing_strategy` | none_missing|complete_case|locf|bocf|mean_imp|mi|mmrm_ml|ipw|not_reported|unclear | N ausser mi/mmrm_ml = E |
| `B_mi_n_imputations` | Zahl oder leer | U |
| `B_mi_armwise` | pooled|armwise|unclear|na | N |
| `B_mi_outcome_included` | yes|no|unclear|na | N |
| `B_outlier_rule` | not_reported|none|sd2|sd3|iqr15|iqr3|mad|percentile|cooks|other|unclear | U |
| `B_outlier_pooled` | pooled|armwise|na|unclear | N |
| `B_outlier_action` | na|keep|delete|winsorize|trim|robust_model|unclear | U |
| `B_transformation` | none|log|sqrt|boxcox|rank|standardised|other|unclear | N |
| `B_floor_ceiling_handled` | not_addressed|tobit|ordinal|beta|dichotomised|unclear | U/N |
| `B_repeat_within_tp` | na|mean|best|last|median|unclear | E/U |
| `B_model_family` | ttest|anova|lm_ancova|mixed_ri|mixed_slopes|mmrm|gee|robust|quantile|nonparam|other|unclear | E in Mittelwertfamilie |
| `B_time_handling` | single_timepoint|factor|continuous|longitudinal_pooled|unclear | U innerhalb, N zwischen |
| `B_clustering_modelled` | none|therapist|site|treatment_group|partial_nesting|unclear | N wenn Clusterung vorliegt |
| `B_covariance_structure` | na|unstructured|cs|ar1|toeplitz|selected_by_ic|not_reported | U |
| `B_strat_factors_adjusted` | yes|no|not_stratified|unclear | N |
| `B_se_method` | model_based|robust_hc|cluster_robust|bootstrap|permutation|not_reported | E im Estimand, U in Kalibrierung |
| `B_df_method` | not_reported|residual|satterthwaite|kenward_roger|between_within|other | N schwach |
| `B_multiplicity` | none|bonferroni|holm|hochberg|fdr|hierarchical|other|not_reported | U/N |
| `B_responder_analysis` | no|yes_mcid|yes_percent|yes_other | N |
| `B_mcid_source` | Freitext oder leer | U |
| `C_baseline_test_reported` | yes|no |  |
| `C_adjust_after_baseline_test` | yes|no|unclear | keine legitime Option |
| `C_estimand_stated` | yes|no |  |
| `C_protocol_available` | yes|no|registration_only |  |
| `D_code_deposited` | yes|no |  |
| `D_code_runs_as_is` | yes|no|na |  |
| `D_code_reproduces_paper` | yes|no|partial|na |  |
| `D_reproduced_class` | full|minor_discrepancy|major_discrepancy|not_reproducible |  |
| `D_max_discrepancy_pct` | Zahl oder leer |  |
| `D_integrity_screen` | pass|flag|na |  |
| `E_core_grid_applicable` | yes|partial|no |  |
| `E_nodes_not_applicable` | Freitext, kommagetrennt |  |
| `Z_coder` | Initialen |  |
| `Z_date` | YYYY-MM-DD |  |
| `Z_notes` | Freitext |  |

## Abschnitte

**A** Studienmerkmale. **B** Entscheidungen an den Knoten aus `NODES.md`.
**C** Reporting-Audit, verbindet mit dem Table-1-Fallacy-Projekt.
**D** Reproduktion, Stufe 2 des Protokolls. **E** Anwendbarkeit des Kerngitters.
