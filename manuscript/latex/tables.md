
## Decision nodes of the two grids

| Node | Type | Options | Applicable when | Justification |
|---|---|---|---|---|
| Baseline handling | E on estimand, N on precision (see Methods 2.6) | endpoint, change, ancova | baseline measurement in deposit, including long-format deposits | Under randomisation all three are unbiased for the same mean difference; analysis of covariance is the most precise \cite{Vickers_2001,Senn_2006,Van_Breukelen_2006} |
| Covariate set | E | none, strat, published | stratification factors or published covariates in deposit | Adjustment is an efficiency choice, not a confounding correction, for a continuous outcome in a linear model \cite{Kahan_2014,Kahan_2012} |
| Outlier winsorising, pooled over arms | U (sensitivity arm only) | none, sd3_winsor, iqr15_winsor, mad_winsor | rule changes at least one value | No paper in the corpus reports an outlier rule; winsorising changes the quantity estimated; reported as a separate arm |
| Model family | E | lm, mixed_ri | estimable cluster variable | Same estimand; random intercept only where a cluster variable with three or more levels exists |
| Inference | E | model, hc3, permutation | always (HC3 and permutation only with the linear model) | Same estimand, different calibration of the interval |
| Missing data and analysis population | N | complete_case, mi, locf | missing primary outcomes present; LOCF only with a baseline | Multiple imputation has justified precedence under a missing-at-random assumption; last observation carried forward assumes no change after dropout \cite{White_2011} |
| Transformation | N | none, log | all outcome and baseline values positive | Log scale estimates a ratio of geometric means, not a difference |
| Outlier winsorising, arm-wise | U (sensitivity arm only) | pooled, armwise | an outlier rule is applicable and arm-wise limits differ from pooled | Arm-wise limits use post-randomisation information |

Estimand-preserving grid: baseline handling, covariate set, model family, inference. Strict grid: the same with baseline handling fixed to analysis of covariance. Defensible grid: estimand-preserving grid plus missing-data strategy and transformation. Outlier arm: estimand-preserving grid plus the two outlier nodes, sensitivity only. Incoherent combinations removed; exact duplicates collapsed.

## Reporting of the primary analysis in the 16 included trials

| Trial | Year | Report type | n randomised | Registration | Primary outcome declared in | Point estimate | Estimand stated | Baseline test | Baseline handling | Covariates | Missing data | Model | Journal requires sharing |
|---|---|---|---:|---|---|---|---|---|---|---|---|---|---|
| Balance feedback | 2026 | secondary | 404 | yes | secondary report | yes | no | yes | other | published_set | mmrm_ml | mixed_ri | unclear |
| Mulligan, neck pain | 2026 | primary | 43 | yes | registration | no | no | yes | change | none | none_missing | anova | unclear |
| Lytras, low back pain | 2026 | primary | 40 | yes, after start | registration | yes | no | yes | other | none | none_missing | anova | yes |
| Cluster sets, squat 1RM | 2026 | primary | 36 | none found | sample-size calculation only | no | no | yes, decisive | other | published_set | none_missing | mixed_ri | unclear |
| TERECO, COVID-19, 6MWD | 2022 | primary | 120 | yes | registration | yes | no | no | ancova | baseline_plus_strat | mmrm_ml | mixed_ri | yes |
| Frozen shoulder, SPADI | 2016 | primary | 106 | yes, after start | registration | yes | no | yes | ancova | baseline_only | not_reported | anova | unclear |
| tSCS, balance, BBS | 2026 | primary | 20 | yes | registration | yes | no | yes, decisive | ancova | baseline_only | none_missing | lm_ancova | yes |
| tDCS after ACLR, CAR | 2026 | secondary | 20 | yes | secondary report | yes | no | yes | endpoint | none | none_missing | ttest | yes |
| ETIP, pregnancy, PGWBI | 2019 | secondary | 91 | yes | secondary report | yes | no | yes | ancova | baseline_only | complete_case | lm_ancova | yes |
| Phosphatidic acid, LBM | 2016 | primary | 18 | none found | not declared | no | no | yes | change | none | none_missing | anova | yes |
| Facial palsy, SFGS | 2024 | primary | 24 | yes | registration | no | no | yes | change | none | complete_case | nonparam | yes |
| Deload, muscle thickness | 2024 | primary | 50 | yes | not declared | yes | yes | no | change | none | complete_case | mixed_ri | yes |
| eTRE, body weight | 2025 | primary | 24 | none found | paper only | yes | no | yes | other | none | none_missing | mixed_ri | yes |
| Creatine, lean mass | 2025 | primary | 63 | yes | registration | yes | no | yes | ancova | baseline_only | complete_case | lm_ancova | unclear |
| FREE, low back pain, RMDQ | 2019 | primary | 226 | yes | registration | yes | no | no | ancova | published_set | mmrm_ml | mixed_slopes | yes |
| Water exercise, EPDS | 2021 | secondary | 294 | yes, after start | secondary report | yes | no | yes, decisive | endpoint | none | mi | anova | unclear |

## Computational reproduction of the published primary estimate, published analysis fitted as described

| Trial | n in fitted model | Published estimate (95% CI; p) | Recomputed estimate (95% CI; p) | Relative difference | Absolute difference (SD) | Class | Recomputed CI contains published | Published estimate: percentile in estimand-preserving multiverse | Grid matches tied |
|---|---:|---|---|---:|---:|---|---|---:|---:|
| Creatine, lean mass | 63 | 0.51 (CI not reported; p = 0.03) | 0.507 (0.0569 to 0.958; p = 0.028) | 0.5% | 0.000 | full | yes | 0.33 | 1 |
| ETIP, pregnancy, PGWBI | 54 |  2.6 (-3.77 to 8.97; p = 0.42) |  2.6 (-3.77 to 8.97; p = 0.42) | 0.1% | 0.000 | full | yes | 0.67 | 1 |
| eTRE, body weight | 24 | -2.13 (-3.07 to -1.18; p = 0.001) | -2.13 (-3.07 to -1.18; p = 0.00024) | 0.2% | 0.002 | full | yes | 0.33 | 1 |
| FREE, low back pain, RMDQ | 221 | 0.57 (-0.64 to 1.78; p = 0.35) | 0.58 (-0.7 to 1.86; p = 0.37) | 1.8% | 0.002 | full | yes | 1.00 | 2 (range 0.01 SD) |
| Lytras, low back pain | 40 | -1.2 (-2.18 to -0.22; p = 0.018) | -1.2 (-2.18 to -0.222; p = 0.018) | 0.0% | 0.000 | full | yes | 0.67 | 3 (range 0.23 SD) |
| Water exercise, EPDS | 294 | -0.7 (-1.24 to -0.17; p = 0.01) | -0.694 (-1.23 to -0.161; p = 0.011) | 0.8% | 0.003 | full | yes | 0.00 | 1 |
| Balance feedback | 373 | 0.02 (-0.08 to 0.12; p = 0.68) | 0.021 (-0.0782 to 0.12; p = 0.68) | 4.9% | 0.002 | full | yes | not on common scale | 2 (range 0.05 SD) |
| Frozen shoulder, SPADI | 70 | -20.8 (-28.9 to -12.7; p not reported) | -20.8 (-28.9 to -12.7; p = 0.0000026) | 0.1% | 0.001 | full | yes | 0.67 | 1 |
| tDCS after ACLR, CAR | 20 | 6.85 (1.92 to 11.8; p = 0.01) | 6.85 (2.27 to 11.4; p = 0.0056) | 0.0% | 0.000 | full | yes | 0.33 | 1 |
| TERECO, COVID-19, 6MWD | 119 | 65.5 (43.8 to 87.1; p not reported) | 65.4 (43.8 to 87.1; p = 0.0000000091) | 0.0% | 0.000 | full | yes | 0.50 | 1 |
| tSCS, balance, BBS | 20 | 7.67 (5.14 to 10.2; p not reported) | 7.67 (5.14 to 10.2; p = 0.0000064) | 0.1% | 0.000 | full | yes | 0.33 | 1 |
| Deload, muscle thickness | 39 | -0.63 (-2.8 to  1.5; p = 0.27) | -0.515 (-2.73 to 1.76; posterior model) | 18.3% | 0.014 | major | yes | 0.67 | 1 |
| Cluster sets, squat 1RM | 36 | none (interaction p = 0.352; F time 80.67, F sex 95.13) | interaction p = 0.352; F 80.67, 95.13 | | | no point estimate; statistics reproduce | | | |
| Facial palsy, SFGS | 23 | none (Mann-Whitney p = 0.002; medians 59.0 vs 24.0) | exact p = 0.0020; medians 59.0 vs 24.0 | | | no point estimate; statistics reproduce | | | |
| Mulligan, neck pain | 43 | none (group x time F = 0.983, p = 0.383) | F(2,40) = 0.983, p = 0.383 | | | no point estimate; statistics reproduce | | | |
| Phosphatidic acid, LBM | 18 | none (interaction F(1,16) = 33.30, p = 0.041) | F(1,16) = 4.95, p = 0.041 | | | no point estimate; p reproduces, F misreported | | | |

Full: same sign and relative difference at most 2%, or within half a unit of the last printed digit; minor: at most 10%; major: otherwise (rule fixed before computation). Assumptions made where the paper is silent are recorded in `R/stage2_published_models.R`; classification in `R/stage2_classify.R`.
