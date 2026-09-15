# Supplementary material

Reproducibility without a mandate: computational reproduction and multiverse analysis of exercise, rehabilitation and physiotherapy trials with publicly deposited individual participant data. Jürgen Degenfellner, ZHAW. Generated from the project files on 2026-09-15.

## Text S1. Transparency statement for secondary data analysis (after van den Akker et al. 2021)

**Prior knowledge of the data.** All 48 deposits were downloaded on 28 August 2026 and inspected for file structure before the grid of decision nodes was written on the same day. No specification had been computed at that point. The published analyses were extracted from the papers on 12 September 2026, and the mapping rules of Methods 2.3 were fixed after that extraction.

**Order of analyses.** First complete multiverse run: 28 August 2026, with the ad hoc mapping (registry v1). Rule-based mapping (registry v2) and rerun: 12 September 2026. Statistical review and corrections (pooled within-group denominator, reproduction rule, multiple imputation): 12 September 2026. Adversarial review, reclassification of outlier rules, addition of the strict grid, long-format baseline correction, refit of the published models: 13 September 2026. Displacement analysis: 13 September 2026.

**Decisions made after seeing results.** Outlier rules were moved from the core grid to a sensitivity arm after a winsorising rule on a bounded outcome had produced a range of 1.08 standard deviations. The strict grid was added after the first run showed that in most trials only baseline handling could vary. The core grid was renamed from principled to estimand-preserving after the precision criterion had been applied to baseline handling. The reproduction rule (2% and 10% relative difference) was fixed before any computation. An absolute criterion introduced on 12 September was withdrawn on 13 September and the prespecified rule reinstated, with the absolute difference reported without threshold.

**Registry v1 versus v2.** Table S2 lists both mappings, Table S7 the effect of v1 on the results. The sign of the median effect reversed in 7 of 16 trials.

**Coders.** One coder mapped all trials.

## Table S1. Exclusions at manual assessment (n = 32)

| study_id | category | reason_code | reason |
|---|---|---|---|
| 2016_early-sitting-in-ischemic-stroke-patients-sevel | design | binary_outcome | Primary outcome is the proportion with modified Rankin score 0-2, i.e. binary; the grid is built for continuous outcomes. |
| 2017_predicting-outcome-in-frozen-shoulder-shoulder-c | duplicate | duplicate_data | Uses the same dataset as the adhesive capsulitis study (106 rows, Group 1/2/3, identical SPADI columns); double counting. |
| 2020_an-age-adapted-plyometric-exercise-program-impro | design | feasibility_primary | Feasibility study; primary endpoint is the feasibility of the programme. |
| 2021_home-based-exercise-for-people-living-with-frail | design | feasibility_primary | Primary endpoints are eligibility, recruitment, adherence and attrition; no effect estimate. |
| 2022_dependence-of-learning-outcomes-in-flipped-and-l | design | not_clinical | Educational research on teaching formats; not a clinical study in patients. |
| 2022_a-comparison-of-psychological-characteristics-in | design | not_rct | Cross-sectional/cohort comparison of psychological characteristics; no randomised intervention. |
| 2025_subphenotypic-classification-of-covid-19-survivo | duplicate | duplicate_data | Latent-class secondary analysis of the same TERECO dataset (119 rows, group_randomized, SF12 columns). |
| 2025_isoenergetic-pre-exercise-meals-varying-in-carbo | design | crossover_design | Crossover design; the grid assumes parallel groups and would ignore the within-person structure. |
| 2021_impact-of-assessment-and-intervention-by-a-healt | data | outcome_not_identifiable | Primary outcome per abstract is ED length of stay; no column in the deposit is clearly identifiable as such. |
| 2024_effects-of-anodal-tdcs-on-resting-state-eeg-powe | data | outcome_data_not_tabular | The table file contains only baseline characteristics; the EEG outcomes are in 7z archives. |
| 2022_influence-of-the-statistical-significance-of-res | design | not_clinical | Reader study on how readers interpret abstracts with/without spin; no intervention in patients. |
| 2021_the-impact-of-a-physician-s-recommendation-and-g | design | not_clinical | Qualtrics vignette survey on physician recommendation and gender; no clinical intervention. |
| 2021_effect-of-an-inverted-seated-position-with-upper | design | crossover_design | Four conditions per person with rest/pre/post; crossover, no parallel groups. |
| 2023_a-clinical-model-to-predict-the-progression-of-k | design | not_rct | Prognostic model for the course of knee osteoarthritis; no randomisation. |
| 2025_comparative-effects-of-combined-aerobic-and-resi | data | no_ipd | Deposit contains only a results table with group differences and CIs, no individual participant data. |
| 2025_comparing-structured-note-taking-and-multiple-ch | design | not_clinical | Educational research on note-taking techniques; not a clinical study. |
| 2026_effects-of-modest-carbohydrate-energy-supplement | design | crossover_design | Each person receives both supplements (Supplement_1 and Supplement_2 in all 20 rows, 10 C/10 P each); crossover, not parallel groups. |
| 2026_preliminary-efficacy-of-cognitive-multisensory-r | data | arm_not_in_data | Paper randomises to immediate CMR (Group A) vs observation (Group B), but the deposit has no group column. |
| 2025_time-restricted-eating-without-exercise-enhances | design | crossover_design | Three phases per person (Phase 1, 2, 3) with no group variable; within-person design. |
| 2024_eight-weeks-of-high-intensity-interval-training | data | file_not_readable | Both CSV files in the deposit cannot be read as a table (inconsistent number of columns). |
| 2022_the-effect-of-mindfulness-on-the-inflammatory-ps | data | no_data_in_deposit | The archive linked in the availability statement contains only a README.md and no data. |
| 2025_a-sensor-augmented-telerehabilitation-system-for | data | outcome_data_not_tabular | Deposit contains only raw EMG and IMU signals as NumPy arrays per participant/trial, no outcome table. |
| 2026_effects-of-low-load-blood-flow-restriction-train | data | arm_not_in_data | Data held as extdata of an R package in Parquet/Excel files; the contractility table lacks a group variable. |
| 2023_the-effects-of-creatine-supplementation-on-cogni | design | crossover_design | Supplement order per person (order_supplement, guess_first_supplement); crossover, plus four separate test files. |
| 2025_the-effect-of-proximity-to-failure-on-perceptual | design | within_person_design | Both limbs per person receive different protocols (FAIL vs RIR); within-person design. |
| 2026_anatomy-of-a-failure-a-retrospective-evaluation | data | arm_not_in_data | Retrospective analysis; CONDITION codes measurement timepoints (1w, 1m, 3m, 6m, 12m); no group variable found. |
| 2025_lengthened-partial-repetitions-elicit-similar-mu | design | within_person_design | Both arms per person receive different protocols (pROM/fROM contralateral); no parallel-group control arm. |
| 2024_pilot-randomized-controlled-trial-of-i-lymfit-i | design | feasibility_primary | Pilot feasibility RCT (n=26); primary aim is feasibility benchmarks, no efficacy primary outcome. |
| 2022_understanding-how-individualised-physiotherapy-o | no_estimate | no_group_estimate | Exploratory network analysis (mixed graphical model) over 10 ODI items; no group-difference estimate. |
| 2025_effects-of-an-aquatic-protocol-on-electromyograp | data | outcome_not_identifiable | No primary outcome declared; deposit has only single-muscle columns with unlabelled .A/.P suffixes. |
| 2015_a-12-week-exercise-program-for-pregnant-women-wi | data | outcome_timepoint_not_in_deposit | Primary outcome (after documented outcome switching) needs 36-week data; deposit has only v1/v2. |
| 2026_changes-in-repetitive-negative-thinking-and-stre | no_estimate | secondary_analysis_no_estimate | Mediation analysis (SEM) of the ImPuls RCT; no own group-comparison estimate; primary report is elsewhere. |

## Table S2. Trial registry, version 2 (rule-based) against version 1 (ad hoc)

| study_id | report_type | outcome_v2 | outcome_v1 | control_v2 | control_v1 | covariates_v2 | covariates_v1 | primary_declared |
|---|---|---|---|---|---|---|---|---|
| physiofeedback | secondary | AP_RMS | AP_RMS | Control | Control | Age,BMI,Gender,Race | Age,BMI,Gender,Race | secondary_report |
| mulligan | primary | NPRS2 | NPRS2 | 3 | 1 |  | Age,Gender | registration |
| lytras_fms | primary | NRPSLBPpost | NRPSLBPpost | 2 | 1 |  | Age,Gender,BMI | registration |
| clusterset | primary | 1RM | CMJ_mean | TS | TS | Sex | Age,Sex | sample_size |
| tereco | primary | X_6MWD2 | X_6MWD2 | 2 | 1 |  |  | registration |
| spadi | primary | SPADI8wks | SPADItot4wks | 3 | 1 |  |  | registration |
| tscs | primary | BBS_Post | BBS_Post | 2 | 1 |  | Age,BMI | registration |
| tdcs | secondary | CAR_post_all | CAR_post_all | 2 | 1 |  | age,BMI | secondary_report |
| etip | secondary | Post_PGWB | EPDS_total | 2 | 1 |  | Pre_preg_BMI | secondary_report |
| phosphatidic | primary | LBM2 | LBM2 | 2 | 1 |  | Age,Sex | none |
| facial | primary | T3 | VM2 | 2 | 1 |  | Age | registration |
| gainingmore | primary | RF50Post | RF50Post | 2 | 1 |  | SEX | none |
| etre | primary | Weight | Weight | Control | Control |  |  | paper |
| creatine | primary | dxa_leanmass_kg_post_1 | legs_post1 | Control | Control |  | sex | registration |
| free | primary | rmdq_tot | rmdq_tot | Control | Control | agegp_w0 |  | registration |
| mallorca | secondary | edimburgtotal | edimburgtotal | C | C |  |  | secondary_report |

## Table S3. Summary measures per trial and grid

grid_type: principled = estimand-preserving; strict = baseline handling fixed to analysis of covariance; defensible = Type E and N nodes; outlier_arm = sensitivity arm.

| study_id | grid_type | n_spec | n | d_median | d_q25 | d_q75 | d_min | d_max | share_same_sign | s_median |
|---|---|---|---|---|---|---|---|---|---|---|
| clusterset | defensible |   36 |   36 | 0.0644 | 0.0559 | 0.157 | 0.0528 | 0.179 |    1 | 1.49 |
| clusterset | outlier_arm |   18 |   36 | 0.0593 | 0.0542 | 0.155 | 0.0528 | 0.171 |    1 | 1.52 |
| clusterset | principled |   18 |   36 | 0.0593 | 0.0542 | 0.155 | 0.0528 | 0.171 |    1 | 1.52 |
| clusterset | strict |    6 |   36 | 0.0583 | 0.0528 | 0.0637 | 0.0528 | 0.0637 |    1 | 1.55 |
| creatine | defensible |   48 |   64 | 0.0431 | 0.0414 | 0.196 | 0.0163 | 0.28 |    1 | 3.18 |
| creatine | outlier_arm |    9 |   63 | 0.0446 | 0.0439 | 0.256 | 0.0439 | 0.256 |    1 | 5.16 |
| creatine | principled |    9 |   63 | 0.0446 | 0.0439 | 0.256 | 0.0439 | 0.256 |    1 | 5.16 |
| creatine | strict |    3 |   63 | 0.0439 | 0.0439 | 0.0439 | 0.0439 | 0.0439 |    1 | 5.14 |
| etip | defensible |   48 |   91 | 0.132 | 0.0802 | 0.185 | -0.0161 | 0.254 | 0.938 | 0.98 |
| etip | outlier_arm |   30 |   59 | 0.227 | 0.192 | 0.275 | 0.0447 | 0.289 |    1 |  1.6 |
| etip | principled |    9 |   59 | 0.192 | 0.0447 | 0.254 | 0.0447 | 0.254 |    1 | 1.23 |
| etip | strict |    3 |   59 | 0.192 | 0.192 | 0.192 | 0.192 | 0.192 |    1 | 1.22 |
| etre | defensible |   18 |   16 | -0.916 | -1.24 | -0.887 | -1.26 | -0.874 |    1 | 9.41 |
| etre | outlier_arm |    9 |   16 | -0.903 | -1.24 | -0.874 | -1.24 | -0.874 |    1 |  9.7 |
| etre | principled |    9 |   16 | -0.903 | -1.24 | -0.874 | -1.24 | -0.874 |    1 |  9.7 |
| etre | strict |    3 |   16 | -0.874 | -0.874 | -0.874 | -0.874 | -0.874 |    1 | 8.97 |
| facial | defensible |   30 |   24 | 1.51 | 1.45 | 1.55 | 1.35 |  1.6 |    1 | 9.53 |
| facial | outlier_arm |   16 |   23 | 1.49 | 1.45 | 1.51 | 1.44 | 1.55 |    1 | 9.57 |
| facial | principled |    9 |   23 | 1.49 | 1.45 | 1.55 | 1.45 | 1.55 |    1 | 9.64 |
| facial | strict |    3 |   23 | 1.49 | 1.49 | 1.49 | 1.49 | 1.49 |    1 | 10.6 |
| free | defensible |   96 |  226 | 0.092 | 0.0752 | 0.0977 | -0.0605 | 0.137 | 0.948 | 0.79 |
| free | outlier_arm |  219 |  214 | 0.0549 | 0.0203 | 0.085 | -0.0309 | 0.117 | 0.913 | 0.424 |
| free | principled |   35 |  214 | 0.0911 | 0.0753 | 0.0952 | 0.0562 | 0.117 |    1 | 0.797 |
| free | strict |   12 |  214 | 0.0911 | 0.0847 | 0.0936 | 0.0753 | 0.105 |    1 | 0.886 |
| gainingmore | defensible |   18 |   39 | -0.102 | -0.468 | -0.06 | -0.499 | -0.0423 |    1 | 1.07 |
| gainingmore | outlier_arm |    9 |   39 | -0.0901 | -0.468 | -0.06 | -0.468 | -0.06 |    1 | 0.956 |
| gainingmore | principled |    9 |   39 | -0.0901 | -0.468 | -0.06 | -0.468 | -0.06 |    1 | 0.956 |
| gainingmore | strict |    3 |   39 | -0.0901 | -0.0901 | -0.0901 | -0.0901 | -0.0901 |    1 | 0.956 |
| lytras_fms | defensible |    9 |   40 | -0.884 | -1.01 | -0.785 | -1.01 | -0.785 |    1 | 7.35 |
| lytras_fms | outlier_arm |    9 |   40 | -0.884 | -1.01 | -0.785 | -1.01 | -0.785 |    1 | 7.35 |
| lytras_fms | principled |    9 |   40 | -0.884 | -1.01 | -0.785 | -1.01 | -0.785 |    1 | 7.35 |
| lytras_fms | strict |    3 |   40 | -0.884 | -0.884 | -0.884 | -0.884 | -0.884 |    1 |  7.7 |
| mallorca | defensible |   10 |  294 | -0.301 | -0.313 | -0.295 | -0.315 | -0.281 |    1 | 5.82 |
| mallorca | outlier_arm |   19 |  263 | -0.287 | -0.304 | -0.244 | -0.315 | -0.236 |    1 | 6.36 |
| mallorca | principled |    3 |  263 | -0.315 | -0.315 | -0.315 | -0.315 | -0.315 |    1 | 6.48 |
| mallorca | strict |    3 |  263 | -0.315 | -0.315 | -0.315 | -0.315 | -0.315 |    1 | 6.48 |
| mulligan | defensible |   18 |   29 | -0.325 | -0.329 | -0.22 | -0.411 | -0.117 |    1 | 1.52 |
| mulligan | outlier_arm |    9 |   29 | -0.22 | -0.32 | -0.117 | -0.32 | -0.117 |    1 | 1.03 |
| mulligan | principled |    9 |   29 | -0.22 | -0.32 | -0.117 | -0.32 | -0.117 |    1 | 1.03 |
| mulligan | strict |    3 |   29 | -0.22 | -0.22 | -0.22 | -0.22 | -0.22 |    1 | 1.03 |
| phosphatidic | defensible |   18 |   18 | 0.101 | 0.0637 | 0.105 | 0.0562 | 0.106 |    1 | 4.01 |
| phosphatidic | outlier_arm |    9 |   18 | 0.105 | 0.0637 | 0.106 | 0.0637 | 0.106 |    1 | 3.83 |
| phosphatidic | principled |    9 |   18 | 0.105 | 0.0637 | 0.106 | 0.0637 | 0.106 |    1 | 3.83 |
| phosphatidic | strict |    3 |   18 | 0.106 | 0.106 | 0.106 | 0.106 | 0.106 |    1 | 4.41 |
| physiofeedback | defensible |   45 |  276 | 0.0744 | 0.0493 | 0.108 | -0.0194 | 0.141 | 0.956 | 0.762 |
| physiofeedback | outlier_arm |  157 |  276 | 0.0913 | 0.0704 | 0.108 | 0.0222 | 0.141 |    1 | 1.13 |
| physiofeedback | principled |   23 |  276 | 0.108 | 0.0666 | 0.133 | 0.0493 | 0.141 |    1 | 1.38 |
| physiofeedback | strict |    8 |  276 | 0.114 | 0.108 | 0.133 | 0.0899 | 0.133 |    1 | 1.51 |
| spadi | defensible |   24 |   72 | -0.952 | -0.975 | -0.91 |   -1 | -0.869 |    1 |   14 |
| spadi | outlier_arm |    9 |   71 | -0.975 |   -1 | -0.904 |   -1 | -0.904 |    1 | 12.3 |
| spadi | principled |    9 |   71 | -0.975 |   -1 | -0.904 |   -1 | -0.904 |    1 | 12.3 |
| spadi | strict |    3 |   71 | -0.975 | -0.975 | -0.975 | -0.975 | -0.975 |    1 | 17.3 |
| tdcs | defensible |   18 |   20 | 1.41 | 1.39 | 1.43 | 1.38 | 1.46 |    1 |  7.3 |
| tdcs | outlier_arm |   41 |   20 | 1.38 | 1.22 | 1.41 | 0.384 | 1.46 |    1 | 7.94 |
| tdcs | principled |    9 |   20 | 1.42 | 1.41 | 1.46 | 1.41 | 1.46 |    1 | 7.47 |
| tdcs | strict |    3 |   20 | 1.42 | 1.42 | 1.42 | 1.42 | 1.42 |    1 | 7.59 |
| tereco | defensible |   96 |  119 | 0.758 | 0.655 | 0.808 | 0.537 | 0.917 |    1 | 16.4 |
| tereco | outlier_arm |  126 |  112 | 0.826 | 0.801 | 0.858 | 0.762 | 0.913 |    1 | 19.1 |
| tereco | principled |   18 |  112 | 0.843 | 0.808 | 0.901 | 0.793 | 0.913 |    1 | 17.9 |
| tereco | strict |    6 |  112 | 0.843 | 0.834 | 0.851 | 0.834 | 0.851 |    1 | 24.3 |
| tscs | defensible |   18 |   20 | 1.09 | 0.976 | 1.36 | 0.975 |  1.5 |    1 | 10.8 |
| tscs | outlier_arm |    9 |   20 | 1.03 | 0.975 | 1.36 | 0.975 | 1.36 |    1 | 12.3 |
| tscs | principled |    9 |   20 | 1.03 | 0.975 | 1.36 | 0.975 | 1.36 |    1 | 12.3 |
| tscs | strict |    3 |   20 | 0.975 | 0.975 | 0.975 | 0.975 | 0.975 |    1 | 17.3 |

### Table S3b. Wilson intervals for proportions and study-bootstrap intervals for medians

| quantity | k | n | prop | wilson_lo | wilson_hi |
|---|---|---|---|---|---|
| reproduced full |   11 |   12 | 0.917 | 0.646 | 0.985 |
| reproduced full or minor |   11 |   12 | 0.917 | 0.646 | 0.985 |
| published inside principled range |    9 |   11 | 0.818 | 0.523 | 0.949 |
| published inside defensible range |   11 |   12 | 0.917 | 0.646 | 0.985 |
| sign stable principled |   16 |   16 |    1 | 0.806 |    1 |
| sign stable defensible |   13 |   16 | 0.812 | 0.57 | 0.934 |
| range includes 0 principled | 0 |   16 | 0 | 0 | 0.194 |
| spec fully representable |    7 |   12 | 0.583 | 0.32 | 0.807 |
| reproduced full or minor, denominator 48 assessed RCTs |   11 |   48 | 0.229 | 0.133 | 0.365 |
| reproduced full or minor, denominator 152 with link |   11 |  152 | 0.0724 | 0.0409 | 0.125 |
| included, denominator 48 |   16 |   48 | 0.333 | 0.217 | 0.475 |
| included, denominator 152 |   16 |  152 | 0.105 | 0.0658 | 0.164 |

| quantity | est | boot_lo | boot_hi |
|---|---|---|---|
| median range d, principled | 0.119 | 0.0917 | 0.212 |
| median range d, defensible | 0.239 | 0.132 | 0.322 |
| median ratio defensible/principled (finite only) | 1.35 | 1.12 | 1.52 |
| median /published d - multiverse median d/ (principled) | 0.0156 | 0.00272 | 0.0564 |

## Table S4. Variance partition with two-way interactions, trial-by-grid combinations with at least 30 specifications

| study_id | grid_type | n_spec | n_nodes | top_additive | share_additive | top_interaction_model | share_main_in_interaction_model | share_all_interactions |
|---|---|---|---|---|---|---|---|---|
| free | principled |   35 |    4 | covars | 55.3 | covars | 42.7 | 17.7 |
| physiofeedback | defensible |   45 |    5 | transform | 43.7 | transform | 38.2 | 9.31 |
| clusterset | defensible |   36 |    4 | baseline | 98.2 | baseline | 97.4 | 0.848 |
| tereco | defensible |   96 |    5 | transform | 46.6 | transform | 45.5 | 2.42 |
| etip | defensible |   48 |    4 | transform | 75.7 | transform | 44.9 | 40.7 |
| facial | defensible |   30 |    4 | baseline | 98.8 | baseline | 79.8 | 19.2 |
| creatine | defensible |   48 |    4 | baseline | 97.9 | baseline | 95.4 | 2.48 |
| free | defensible |   96 |    5 | baseline | 49.9 | baseline | 12.5 | 74.6 |

## Table S5. Range drivers per trial and range with baseline handling fixed

| study_id | n | baseline_imbalance_sd | cor_base_outcome | frac_missing | range_p | range_d |
|---|---|---|---|---|---|---|
| physiofeedback |  276 | 0.0411 | 0.466 | 0 | 0.0917 | 0.16 |
| mulligan |   29 | 0.162 | 0.632 | 0 | 0.203 | 0.294 |
| lytras_fms |   40 | 0.217 | 0.379 | 0 | 0.229 | 0.229 |
| clusterset |   36 | 0.105 | 0.985 | 0 | 0.118 | 0.126 |
| tereco |  119 | 0.165 | 0.613 | 0.0588 | 0.121 | 0.38 |
| spadi |   72 | 0.108 | 0.486 | 0.0139 | 0.0975 | 0.132 |
| tscs |   20 | 0.409 | 0.882 | 0 | 0.386 | 0.522 |
| tdcs |   20 | 0.0711 | 0.19 | 0 | 0.0569 | 0.0866 |
| etip |   91 | 0.038 | 0.549 | 0.352 | 0.209 | 0.27 |
| phosphatidic |   18 | 0.0434 | 0.994 | 0 | 0.0419 | 0.0495 |
| facial |   24 | 0.101 | 0.502 | 0.0417 | 0.101 | 0.249 |
| gainingmore |   39 | 0.411 | 0.915 | 0 | 0.407 | 0.457 |
| etre |   16 | 0.398 | 0.873 | 0 | 0.366 | 0.386 |
| creatine |   64 | 0.239 | 0.997 | 0.0156 | 0.212 | 0.263 |
| free |  226 | 0.0237 | 0.227 | 0.0531 | 0.0607 | 0.198 |
| mallorca |  294 |   NA |   NA | 0.105 | 0 | 0.034 |

| study_id | range_full | n_spec | range_fixed |
|---|---|---|---|
| clusterset | 0.0159 |    6 | 0.0159 |
| creatine | 0.212 |    3 | 0 |
| etip | 0.244 |   12 | 0.0372 |
| etre | 0 |    3 | 0 |
| facial | 0.11 |    6 | 0.00598 |
| free | 0.148 |   48 | 0.109 |
| gainingmore | 0.407 |    3 | 0 |
| lytras_fms | 0.229 |    3 | 0 |
| mallorca | 0.0795 |   12 | 0.0795 |
| mulligan | 0.203 |    3 | 0 |
| phosphatidic | 0.0419 |    3 | 0 |
| physiofeedback | 0.0347 |   26 | 0.0347 |
| spadi | 0.0975 |    3 | 0 |
| tdcs | 1.08 |    9 | 1.03 |
| tereco | 0.152 |   24 | 0.0543 |
| tscs | 0.386 |    3 | 0 |

## Table S6. Data integrity screen

p_carlisle_named: Stouffer-combined p over baseline variables named in the paper (NA where fewer than two). p_carlisle_all: name-based broad search, reported only.

| study_id | n | n_baseline_named | p_carlisle_named | n_baseline_all | p_carlisle_all | frac_outcome_nonint | n_dup_rows | p_lastdigit | flag |
|---|---|---|---|---|---|---|---|---|---|
| physiofeedback |  358 |    2 | 0.308 |    2 | 0.308 |    1 | 0 | 0.918 | pass |
| mulligan |   29 |    1 |   NA |    2 | 0.51 | 0 | 0 |   NA | pass |
| lytras_fms |   40 |    1 |   NA |    5 | 0.873 | 0 | 0 |   NA | pass |
| clusterset |   36 | 0 |   NA |    8 | 0.333 | 0.194 | 0 |   NA | pass |
| tereco |  119 |    1 |   NA |    7 | 0.672 | 0 | 0 |   NA | pass |
| spadi |   72 |    1 |   NA |    5 | 0.859 | 0 | 0 |   NA | pass |
| tscs |   20 |    1 |   NA |   10 | 0.145 | 0 | 0 |   NA | pass |
| tdcs |   20 |    1 |   NA |   13 | 0.953 |  0.9 | 0 |   NA | pass |
| etip |   91 |    1 |   NA |   43 | 0.324 | 0 | 0 |   NA | pass |
| phosphatidic |   18 |    1 |   NA |    5 | 0.449 |    1 | 0 |   NA | pass |
| facial |   24 |    1 |   NA |    2 | 0.911 | 0 | 0 |   NA | pass |
| gainingmore |   39 |    1 |   NA |    9 | 0.573 | 0.974 | 0 | 0.491 | pass |
| etre |   16 | 0 |   NA | 0 |   NA |    1 | 0 |   NA | pass |
| creatine |   64 |    1 |   NA |   25 | 0.269 |    1 | 0 | 0.312 | pass |
| free |  226 |    1 |   NA |   21 | 0.892 | 0 | 0 |   NA | pass |
| mallorca |  294 | 0 |   NA |   16 | 0.263 | 0 | 0 |   NA | pass |

## Table S7. Effect of the first mapping (registry v1) on the results, computed with the final engine

| study_id | v1_med | v1_range | v1_sign | v2_med | v2_range | v2_sign | sign_flip |
|---|---|---|---|---|---|---|---|
| physiofeedback | 0.0498 | 0.0173 |    1 | 0.108 | 0.0917 |    1 | FALSE |
| mulligan | -0.218 | 0.193 |    1 | -0.22 | 0.203 |    1 | FALSE |
| lytras_fms | 0.886 | 0.229 |    1 | -0.884 | 0.229 |    1 | TRUE |
| clusterset | 0.376 | 0.0114 |    1 | 0.0593 | 0.118 |    1 | FALSE |
| tereco | -0.851 | 0.105 |    1 | 0.843 | 0.121 |    1 | TRUE |
| spadi | -0.0437 | 0.169 | 0.667 | -0.975 | 0.0975 |    1 | FALSE |
| tscs |   -1 | 0.476 |    1 | 1.03 | 0.386 |    1 | TRUE |
| tdcs | -1.46 | 0.0693 |    1 | 1.42 | 0.0569 |    1 | TRUE |
| etip | 0.191 | 0.0668 |    1 | 0.192 | 0.209 |    1 | FALSE |
| phosphatidic | -0.105 | 0.0419 |    1 | 0.105 | 0.0419 |    1 | TRUE |
| facial | -0.567 | 0.252 |    1 | 1.49 | 0.101 |    1 | TRUE |
| gainingmore | 0.075 | 0.448 |    1 | -0.0901 | 0.407 |    1 | TRUE |
| etre | -1.24 | 0 |    1 | -0.903 | 0.366 |    1 | FALSE |
| creatine | 0.00914 | 0.207 |    1 | 0.0446 | 0.212 |    1 | FALSE |
| free | 0.0911 | 0.047 |    1 | 0.0911 | 0.0607 |    1 | FALSE |
| mallorca | -0.315 | 0 |    1 | -0.315 | 0 |    1 | FALSE |

## Table S8. Displacement of the published result per trial and grid

| study_id | grid_type | n_spec | d_published | delta_median | delta_min | delta_max | abs_delta_max | share_within_0.1 | share_within_0.2 | share_same_sign_as_published | any_sign_reversal |
|---|---|---|---|---|---|---|---|---|---|---|---|
| creatine | principled |    9 | 0.0439 | 0.000689 | -0.000000000000000368 | 0.212 | 0.212 | 0.667 | 0.667 |    1 | FALSE |
| creatine | defensible |   24 | 0.0439 | -0.000000000000000368 | -0.0227 | 0.236 | 0.236 | 0.667 | 0.667 |    1 | FALSE |
| etip | principled |    9 | 0.192 | 0.000000000000000666 | -0.147 | 0.062 | 0.147 | 0.667 |    1 |    1 | FALSE |
| etip | defensible |   24 | 0.192 | -0.00408 | -0.147 | 0.062 | 0.147 | 0.875 |    1 |    1 | FALSE |
| etre | principled |    9 | -0.903 | 0.0000000000000333 | -0.337 | 0.0295 | 0.337 | 0.667 | 0.667 |    1 | FALSE |
| etre | defensible |    9 | -0.903 | 0.0000000000000333 | -0.337 | 0.0295 | 0.337 | 0.667 | 0.667 |    1 | FALSE |
| gainingmore | principled |    9 | -0.0628 | -0.0273 | -0.405 | 0.00274 | 0.405 | 0.667 | 0.667 |    1 | FALSE |
| gainingmore | defensible |    9 | -0.0628 | -0.0273 | -0.405 | 0.00274 | 0.405 | 0.667 | 0.667 |    1 | FALSE |
| lytras_fms | principled |    9 | -0.785 | -0.0982 | -0.229 | 0.00000000000000178 | 0.229 | 0.667 | 0.667 |    1 | FALSE |
| lytras_fms | defensible |    9 | -0.785 | -0.0982 | -0.229 | 0.00000000000000178 | 0.229 | 0.667 | 0.667 |    1 | FALSE |
| mallorca | principled |    3 | -0.316 | 0.00116 | 0.00116 | 0.00116 | 0.00116 |    1 |    1 |    1 | FALSE |
| mallorca | defensible |    5 | -0.316 | 0.00116 | 0.00116 | 0.00966 | 0.00966 |    1 |    1 |    1 | FALSE |
| physiofeedback | defensible |   22 | 0.0526 | 0.0107 | -0.072 | 0.0291 | 0.072 |    1 |    1 | 0.909 | TRUE |
| spadi | principled |    9 | -0.913 | -0.0619 | -0.0882 | 0.00933 | 0.0882 |    1 |    1 |    1 | FALSE |
| spadi | defensible |   24 | -0.913 | -0.0391 | -0.0882 | 0.0437 | 0.0882 |    1 |    1 |    1 | FALSE |
| tdcs | principled |    9 | 1.41 | 0.0183 | 0.00000000000000466 | 0.0569 | 0.0569 |    1 |    1 |    1 | FALSE |
| tdcs | defensible |    9 | 1.41 | 0.0183 | 0.00000000000000466 | 0.0569 | 0.0569 |    1 |    1 |    1 | FALSE |
| tereco | principled |   18 | 0.838 | 0.00481 | -0.0451 | 0.0754 | 0.0754 |    1 |    1 |    1 | FALSE |
| tereco | defensible |   48 | 0.838 | -0.0299 | -0.152 | 0.0792 | 0.152 | 0.792 |    1 |    1 | FALSE |
| tscs | principled |    9 | 0.975 | 0.055 | 0.000000000000000666 | 0.386 | 0.386 | 0.667 | 0.667 |    1 | FALSE |
| tscs | defensible |    9 | 0.975 | 0.055 | 0.000000000000000666 | 0.386 | 0.386 | 0.667 | 0.667 |    1 | FALSE |
| free | principled |   35 | 0.139 | -0.048 | -0.0829 | -0.0222 | 0.0829 |    1 |    1 |    1 | FALSE |
| free | defensible |   96 | 0.139 | -0.0471 | -0.2 | -0.0017 |  0.2 | 0.938 |    1 | 0.948 | TRUE |

## Table S9. Published models as fitted, with assumptions recorded

| study_id | model_as_published | est | ci_lo | ci_hi | p | n | deviations |
|---|---|---|---|---|---|---|---|
| creatine | Linear regression (ANCOVA): change in whole-body LBM (T1->T2, 7-day wash-in) ~ group + baseline LBM (T1), complete-case (Sec. 2.3.5) | 0.507 | 0.0569 | 0.958 | 0.0279 |   63 | REPRODUCTION VERY CLOSE TO THE PUBLISHED VALUE (0.507 vs 0.51 kg, p=0.028 vs 0.03). The paper reports only a point estimate + p (0.51 kg, p=0.03), no CI/SE for the group difference -> our CI is model-based (t-distributio |
| etip | General linear model ANCOVA: PGWBI global score (late pregnancy) ~ Group + PGWBI baseline, available ITT cases (Statistical methods) |  2.6 | -3.77 | 8.97 | 0.417 |   54 | REPRODUCTION VERY CLOSE TO THE PUBLISHED VALUE (estimate 2.597 vs 2.60; 95% CI [-3.77, 8.97] vs [-3.77, 8.97] in the paper; p=0.417 vs 0.42). The paper does not formally declare PGWBI as the 'primary' outcome (see regist |
| etre | LMM: Weight ~ Group*Time + (1/ID), REML; main estimand = Time x Group interaction (change-score contrast eTRE vs Control, per override in eTRE-minus-Control con | -2.13 | -3.07 | -1.18 | 0.000241 |   24 | The interaction coefficient (eTRE:post) is computed directly in our eTRE-minus-Control convention and matches the sign convention in config/published_overrides.csv (published value there: -2.13 [-3.07,-1.18], p=0.001; re |
| gainingmore | Bayesian multilevel model (brms, gaussian family, weakly informative brms default priors): RF50 ~ Group*Time + (1/CODE); group difference-in-change = Group x Ti | -0.515 | -2.73 | 1.76 |   NA |   39 | The paper names 'univariate multilevel regression models' within a fully Bayesian framework (presumably brms/Stan), but specifies neither the prior distributions nor the exact random-effects structure of the 'multilevel' |
| lytras_fms | Two-way mixed ANOVA (Group x Time) on NPRS-Lumbar; primary interaction test, followed by a Bonferroni-adjusted simple-effect t-test (group comparison at week 3, | -1.2 | -2.18 | -0.222 | 0.0175 |   40 | Unadjusted simple-effect t-test at week 3 (Bonferroni family not defined in the paper); Group x Time interaction from the mixed ANOVA reported in the console output, not adjusted, because the SPSS procedure for 'Bonferro |
| mallorca | ANOVA/unadjusted group comparison (EPDS total score, 1 month postpartum) with multiple imputation (mice, PMM, m=20) for missing EPDS values, pooled by Rubin's r | -0.694 | -1.23 | -0.161 | 0.0109 |  294 | The SPSS MI model and the exact number/selection of auxiliary variables of the original paper are not documented (only 'Multiple imputation ... with chained equations' is stated, without m or a list of predictors). Appro |
| physiofeedback | LMM (original authors' code from deposit/statistical code.R): log(AP_RMS) ~ Group*Time + Age+BMI+Gender+Race + (1/SubjectID)+(1/Site), REML, bobyqa optimiser, R | 0.021 | -0.0782 | 0.12 | 0.678 |  373 | The deposited original code writes 'Group * Time' without an explicit factor(Time); since Time is coded numerically (1-4) in the dataset, a purely linear treatment would yield only ONE interaction term, whereas Table 3 o |
| spadi | Repeated-measures ANCOVA as a GLM equivalent: ANCOVA on the mean of weeks 4 and 8 ~ Group + SPADI baseline, listwise exclusion; corresponds to the between-subje | -20.8 | -28.9 | -12.7 | 0.00000255 |   70 | The paper presumably implements the 'repeated measures ANCOVA' as an SPSS GLM (multivariate approach with a fixed repeated-measures factor, no explicit random-effects model); approximated here instead with a linear mixed |
| tdcs | Independent t-test (equal variances): CAR post-intervention, active a-tDCS vs sham a-tDCS (Statistical analyses) | 6.85 | 2.27 | 11.4 | 0.00563 |   20 | The paper names Shapiro-Wilk/Levene pre-tests to choose between a t-test (equal variances) and Mann-Whitney U, but does not specify which test was actually used for CAR; computed here directly as Student's t-test with eq |
| tereco | Constrained longitudinal data analysis (LMM with equality constraint on baseline means): 6MWD ~ Time + Treatment (post/follow-up only) + Centre (fixed) + (1/Pat | 65.4 | 43.8 | 87.1 | 0.00000000913 |  119 | The paper typically describes cLDA as a GLS/mixed model with an UNSTRUCTURED covariance matrix across the 3 timepoints; a random-intercept model (compound-symmetry assumption) is used here instead, which is usually simil |
| tscs | ANCOVA: BBS post-intervention ~ Group + BBS baseline; contrast RAGT+tSCS vs CPT+tSCS (Statistical analysis {20a}) | 7.67 | 5.14 | 10.2 | 0.00000641 |   20 | Marked group imbalance (n=13 vs n=7) as intended per the protocol, but unusual for 1:1 randomisation. The numeric group coding in the .sav dataset already contained text labels ('RAGT+tSCS'/'CPT+tSCS'), which were taken  |
| free | LMM: RMDQ ~ baseline RMDQ + week*Tment + pre-specified covariates + (1+week/GP), REML; contrast FREE vs Control at week=26 (Statistical analysis, p.7) | 0.58 | -0.7 | 1.86 | 0.367 |  221 | Covariate set assembled from the baseline variables available in the deposit that are already mean-imputed (age_w0, gender_w0, NZDep_Decile, d_length_back_pain_weeks, backpain_consistency_3f, previous_backpain_w0_imp, ps |

## Table S10. Test statistics recomputed for the four papers without a point estimate

| study_id | statistic | published | recomputed | note |
|---|---|---|---|---|
| mulligan | Group x Time F, p (repeated-measures ANOVA, 3 arms, n = 43) | F = 0.983, p = 0.383 | F(2,40) = 0.983, p = 0.383 | SPSS repeated-measures ANOVA; with two occasions the univariate and multivariate solutions coincide |
| mulligan | Group main effect F, p | not reported as a number | F(2,40) = 0.290, p = 0.750 |  |
| mulligan | within-group means pre -> post | Mulligan 4.79 -> 2.36; Maitland 5.07 -> 2.14; Control ? | Mulligan 4.79 -> 2.36 (n=14); Maitland 5.07 -> 2.14 (n=14); Control 5.07 -> 2.80 (n=15) |  |
| facial | Mann-Whitney U p (SFGS composite change, day 20 - baseline) | p = 0.002 | p = 0.0020 (W = 114) | exact test, as SPSS reports for small samples; the asymptotic test with continuity correction gives p = 0.0033 |
| facial | median (IQR) change per group | Exp 59.0 (42.5-63.0); Conv 24.0 (9.0-32.0) | Experimental 59.0 (42.5-63.0), n=12; Conventional 24.0 (9.0-32.0), n=11 |  |
| clusterset | Group x Time interaction p (LMM, Type III, Satterthwaite) | p = 0.352 | F(1,34.0) = 0.890, p = 0.352 | as described in the paper, Methods 2.4.2 |
| clusterset | Time main effect F, p | F(1,34) = 80.67, p < 0.001 | F(1,34.0) = 80.67, p = 1.7e-10 |  |
| clusterset | Sex main effect F, p | F(1,33) = 95.13, p < 0.001 | F(1,33.0) = 95.13, p = 3e-11 |  |
| phosphatidic | Group x Time interaction F, p (2x2 mixed ANOVA, n = 18) | F(1,16) = 33.30, p = 0.041 (Results); 'main effect F(1,16) = 33.30, p < 0.001' (Abstract) | F(1,16) = 4.95, p = 0.0408 | internally inconsistent in the paper: F = 33.30 with df (1,16) implies p < 0.001, whereas p = 0.041 implies F = 4.9 |
| phosphatidic | Time main effect F, p | not separately reported | F(1,16) = 30.89, p = 4.3e-05 |  |
| phosphatidic | means pre/post per group | MT 60.8+/-9.5 -> 62.7+/-10.2; PLA 61.2+/-9.7 -> 62.0+/-9.7 | MT 60.8+/-9.6 -> 62.7+/-10.2 (n=8); PLA 61.2+/-9.6 -> 62.0+/-9.7 (n=10) |  |

## Table S11. Trial registrations retrieved

| study_id | registration_id | retrieved | registered_after_start | registered_primary_outcome | matches_our_outcome_var |
|---|---|---|---|---|---|
| physiofeedback | NCT05778604 | yes | no | Change from Baseline in Fall Risk Reduction; Change from Baseline in Dynamic Balance as Measured By Timed-Up and Go (TUG) test; Change from  | no |
| mulligan | NCT06858124 | yes | unclear | Changes in neck pain intensity with NPRS (listed first); Changes in Pressure Pain Threshold (PPT); Changes in cervical ROM; Changes in Neck  | yes |
| lytras_fms | NCT07234071 | yes | yes | Changes in pain intensity with NPRS (listed first); Straight Leg Raise (SLR) Angle - Goniometry/SROM; Change in Functional Disability (RMDQ) | yes |
| clusterset |  | no |  |  |  |
| tereco | ChiCTR2000031834 | yes | no | Total distances of 6 minutes walk test (Primary indicator; sole primary outcome) | yes |
| spadi | NCT01570985 | yes | yes | Shoulder pain and disability index (SPADI) (sole primary outcome) | yes |
| tscs | ChiCTR2300074090 | yes | no | Balance (Berg Balance Scale / Timed Up and Go) - listed first; Mobility (Walking Index for Spinal Cord Injury WISCI II / 10-Meter Walk Test) | yes |
| tdcs | IRCT20231113060048N1 | yes | no | Quadriceps muscle strength (Biodex Isokinetic Dynamometer) - the ONLY registered primary outcome. 'Central activation ratio' (CAR) is part o | no |
| etip | NCT01243554 | yes | unclear | Weight gain during pregnancy (kg), measured from 14 weeks' gestation to birth (sole primary outcome, unchanged since version 1) | no |
| phosphatidic |  | no |  |  |  |
| facial | CTRI/2020/02/023240 | yes | no | Sunny Brook Facial Grading System (SFGS) - listed first; House Brackmann Scale; Facial Disability Index (3 jointly registered primary outcom | yes |
| gainingmore | OSF preregistration https://osf.io/bztka | yes | no | No separate 'primary outcome' field in this OSF pre-registration template (open Van't Veer/Giner-Sorolla template with no primary/secondary  | partial |
| etre |  | no |  |  |  |
| creatine | ACTRN12622000040763 | yes | no | [1] Whole-body lean mass measured by dual x-ray absorptiometry (DXA) - listed first; [2] Faith's phylogenetic diversity of the gut microbiot | yes |
| free | ACTRN12616000888460 | yes | no | Patient back pain related impairment measured with the Roland Morris Disability Questionnaire (sole primary outcome) | yes |
| mallorca | ISRCTN14097513 | yes | yes | The incidence of epidural analgesia use during labour is determined through review of the clinical history at one month after birth (sole pr | no |

## Figure S1. Median and range of d per trial, both grids

![](figures/supp/overview_all_studies.png)

## Figure S2. Share of interval-width variance per node

![](figures/supp/variance_ci_width_d.png)

## Figure S3. Specification curves, clusterset_PMC13140343

![](figures/supp/speccurve_clusterset_PMC13140343.png)

## Figure S4. Specification curves, creatine_PMC11944689

![](figures/supp/speccurve_creatine_PMC11944689.png)

## Figure S5. Specification curves, etip_PMC6886967

![](figures/supp/speccurve_etip_PMC6886967.png)

## Figure S6. Specification curves, etre_PMC11945196

![](figures/supp/speccurve_etre_PMC11945196.png)

## Figure S7. Specification curves, facial_PMC11164989

![](figures/supp/speccurve_facial_PMC11164989.png)

## Figure S8. Specification curves, free_PMC6733445

![](figures/supp/speccurve_free_PMC6733445.png)

## Figure S9. Specification curves, gainingmore_PMC10809978

![](figures/supp/speccurve_gainingmore_PMC10809978.png)

## Figure S10. Specification curves, lytras_fms_PMC12942207

![](figures/supp/speccurve_lytras_fms_PMC12942207.png)

## Figure S11. Specification curves, mallorca_PMC8198819

![](figures/supp/speccurve_mallorca_PMC8198819.png)

## Figure S12. Specification curves, mulligan_PMC13092435

![](figures/supp/speccurve_mulligan_PMC13092435.png)

## Figure S13. Specification curves, phosphatidic_PMC4891923

![](figures/supp/speccurve_phosphatidic_PMC4891923.png)

## Figure S14. Specification curves, physiofeedback_PMC12821712

![](figures/supp/speccurve_physiofeedback_PMC12821712.png)

## Figure S15. Specification curves, spadi_PMC4880881

![](figures/supp/speccurve_spadi_PMC4880881.png)

## Figure S16. Specification curves, tdcs_PMC13257960

![](figures/supp/speccurve_tdcs_PMC13257960.png)

## Figure S17. Specification curves, tereco_PMC8318721

![](figures/supp/speccurve_tereco_PMC8318721.png)

## Figure S18. Specification curves, tscs_PMC13085461

![](figures/supp/speccurve_tscs_PMC13085461.png)

## Text S2. Novelty search protocol, 15 September 2026

### Novelty search, 2026-09-15

Statement under review (manuscript, `body.tex` line 5, or `paper.md`):

> "I am not aware of a study in physiotherapy, rehabilitation or exercise science that
> retrieved individual participant data from public repositories and recomputed the
> published primary analysis."

Criterion for a counterexample: individual participant data obtained from a public
repository or supplement **AND** the published primary analysis recomputed, in the
field of physiotherapy, rehabilitation or exercise and sports science.

This check supplements the earlier novelty search of 2026-08-28 (documented in
`README.md`, section "Neuheitsprüfung"). The neighbours excluded there (Jabouille
2025, Elghzali 2025, Murphy 2025, Dhanani 2022) are not reviewed again in full text
here but taken as already known.

**Verdict in advance: no counterexample found. The statement remains tenable.** The
closest neighbour is a registered report study in exercise science, running since
January 2026 and not yet completed, that does aim to recompute the published primary
analysis but explicitly works with **private** raw data shared confidentially by the
authors rather than data from a public repository. Details below.

### Methodology and deviations from the search plan

All requests were run via curl with `-A "Mozilla/5.0"` and a 1.5 second pause between
calls. Two deviations from the search specification, both documented:

1. **medRxiv/bioRxiv**: the direct HTML search on `www.medrxiv.org/search/...` returns
   only a Cloudflare challenge page ("Just a moment...") and no search result. As
   foreseen in the search plan itself, OpenAlex with `filter=type:preprint` was used
   instead.
2. **OSF Registrations**: `https://api.osf.io/v2/registrations/` returned HTTP 502 or
   connection timeouts throughout the entire session (`https://api.osf.io/v2/` itself
   responded with 200, only the registrations endpoint was affected, with several
   retries over roughly two minutes and no success). As a substitute, the SHARE search
   API (`https://share.osf.io/api/v2/search/creativeworks/_search`) was used, which
   also indexes OSF registrations and was reachable at the time of the search (HTTP
   200). This is a documented compromise, not a full substitute for `filter[title]`,
   because SHARE uses a different relevance weighting and also indexes further sources
   (CrossRef, DataCite, PubMed Central).

### Queries verbatim, with source and hit count

### Europe PMC (`https://www.ebi.ac.uk/europepmc/webservices/rest/search`, `resultType=lite`, `pageSize=100`)

| # | Query | Hits |
|---|---|---:|
| Q1 | `("computational reproducibility" OR "analytic reproducibility" OR "analytical reproducibility" OR "reanalysis" OR "re-analysis" OR "reproduction") AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise science" OR "sports science" OR "sport science") AND ("individual participant data" OR "individual patient data" OR "raw data" OR "open data" OR "shared data" OR "repository")` | 5002 |
| Q2 | `("multiverse") AND (Feldbegriffe wie Q1) AND (Datenbegriffe wie Q1)` | 28 |
| Q3 | `("specification curve") AND (Feldbegriffe) AND (Datenbegriffe)` | 5 |
| Q4 | `("vibration of effects") AND (Feldbegriffe) AND (Datenbegriffe)` | 5 |
| Q5 | `("many analysts") AND (Feldbegriffe) AND (Datenbegriffe)` | 5 |
| Q6 | `("robustness reanalysis") AND (Feldbegriffe) AND (Datenbegriffe)` | 0 |
| Q7 | `"reproducibility" AND "physical therapy" AND "data" AND (PUB_TYPE:"Meta-Analysis" OR "meta-research" OR "metaresearch")` | 256 |
| Q8 | `"many analysts" AND ("sport" OR "sports science" OR "exercise science")` | 10 |
| Q9 | `("reanalysis" OR "re-analysis") AND ("open data") AND ("sports science" OR "exercise science" OR "sport science" OR "Journal of Sports Sciences" OR "Medicine and Science in Sports and Exercise")` | 24 |
| Q10 | `"prevalence" AND "reproducible" AND ("sport science" OR "sports science" OR "exercise science")` | 928 |
| Q11 | `("individual patient data" OR "individual participant data") AND ("reanalysis" OR "re-analysis" OR "recomputed" OR "recompute") AND ("physiotherapy" OR "physical therapy" OR "rehabilitation") AND ("repository" OR "Zenodo" OR "Dryad" OR "OSF" OR "figshare")` | 49 |
| Q12 | `("reproduced the published" OR "recomputed the published" OR "recompute the published" OR "reanalyzed the original data" OR "reanalysed the original data") AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise" OR "sports")` | 120 |
| Q13 | `"computational reproducibility" AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise science" OR "sports science" OR "sport science")` | 29 |
| Q14 | `"analytic reproducibility" AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise" OR "sports" OR "sport")` | 14 |
| Q15 | `("downloaded" OR "retrieved") AND ("individual participant data" OR "individual patient data" OR "raw data") AND ("recomputed" OR "recompute" OR "reran the analysis" OR "re-ran the analysis") AND ("physiotherapy" OR "rehabilitation" OR "exercise" OR "sports" OR "physical therapy")` | 51 |
| Q16 | `("Zenodo" OR "Dryad" OR "figshare" OR "Open Science Framework") AND ("reanalysis" OR "re-analysis" OR "recomputed") AND ("physiotherapy" OR "rehabilitation" OR "physical therapy" OR "exercise science" OR "sports science")` | 250 |
| Q17 | `"prevalence" AND "computational reproducibility" AND ("sport" OR "exercise" OR "physiotherapy" OR "physical therapy" OR "rehabilitation")` | 40 |
| Q18 | `"Cochrane" AND ("individual patient data" OR "individual participant data") AND ("repository" OR "Zenodo" OR "Dryad" OR "Open Science Framework" OR "figshare") AND ("physiotherapy" OR "rehabilitation" OR "physical therapy")` | 256 |
| Q19 | `TITLE:("Reanalysis of" OR "Re-analysis of" OR "A reanalysis of" OR "Reanalyzing") AND ("physiotherapy" OR "rehabilitation" OR "physical therapy" OR "exercise" OR "sports" OR "sport")` | 175 |

For hit counts above 100, only the first 100 (sorted by relevance) were loaded and
reviewed. This is a lower bound on completeness, but Europe PMC sorts by relevance to
the query, so hits from the target field should appear within the first 100 if they
exist.

### OpenAlex (`https://api.openalex.org/works?search=<text>&per-page=50`, teils `&filter=from_publication_date:2015-01-01`)

| # | Search text | Hits |
|---|---|---:|
| OA1 | `reanalysis individual participant data physiotherapy rehabilitation repository` | 18 |
| OA2 | `multiverse specification curve physiotherapy rehabilitation exercise trial` | 0 |
| OA3 | `computational reproducibility sport science exercise physiotherapy` | 577 |
| OA4 | `many analysts sports science` | 29 165 |
| OA5 | `reanalysis open data sports science journal` | 2073 |
| OA6 | `individual patient data repository recompute rehabilitation trial` | 51 |
| OA7 | `vibration of effects physiotherapy rehabilitation exercise` | 5915 |
| OA8 | `robustness reanalysis physiotherapy exercise rehabilitation` | 104 |
| OA9 | `Mesquida many analysts sport` | 17 |
| OA10 | `Caldwell many analysts sport science` | 320 (not individually reviewed, author already covered via OA9/Sports Med neighbour) |
| OA11 | `Vigotsky reanalysis sport science open data` | 4 |
| OA12 | `Borg many analysts sport` | 439 (not individually reviewed) |
| OA13 | `Bosco many analysts sport science` | 97 (not individually reviewed) |
| OA14 | `Abt many analysts sport science` | 170 (not individually reviewed) |
| OA15 | `Warmenhoven many analysts biomechanics` | 16 |
| OA16 | `Cochrane individual patient data reanalysis physiotherapy repository` | 16 |
| PP1 | `reanalysis individual participant data physiotherapy rehabilitation exercise` (`filter=type:preprint`) | 24 |
| PP2 | `multiverse specification curve rehabilitation physical therapy trial` (`filter=type:preprint`) | 0 |

For OA3, OA4, OA5 and OA7, only the relevance-sorted top 15 to top 20 were reviewed,
because free-text search without phrase binding spreads very broadly (for example,
"vibration of effects" pulls in every study on vibration training in physiotherapy).
For OA10, OA12, OA13 and OA14, individual review was omitted for reasons of time,
because the associated authors (Caldwell, Borg, Bosco, Abt) are already covered
through co-authorship with Murphy et al. 2025 and through Mesquida's work list (OA9),
where no IPD reanalysis appears.

In addition, targeted OpenAlex author queries were run: Matthieu Boisgontier
(`author.id:A5076503553`, published since 2026-08-01: 4 works, all Kinarm validation
plus one meta-analysis data deposit, no reanalysis), François Jabouille
(`author.id:A5084775748`, 20 works, the two most recent are Kinarm validation studies
and a French-language transparency checklist article from 2026-08-01, no reanalysis),
Cristian Mesquida (`author.id:A5082605089`, 36 works, most recent are the software
package `metacheck`, a type S/M error comment, and a power analysis scoping review, no
IPD reanalysis), and Colby J. Vorland (`author.id:A5074473858`, 115 works, filter
`search=reanalysis`: 16 hits, see candidate table).

### medRxiv/bioRxiv

Direct access via `www.medrxiv.org/search/...` is blocked by Cloudflare (challenge
page, no result extractable). Substitute: OpenAlex `filter=type:preprint` (see PP1,
PP2 above).

### OSF Registrations

`https://api.osf.io/v2/registrations/?filter[title]=<term>` returned HTTP 502 or a
timeout throughout, for all seven planned search terms ("reproducibility
physiotherapy", "reanalysis rehabilitation", "multiverse exercise", "reanalysis
physiotherapy", "multiverse physiotherapy", "individual participant data
physiotherapy", "computational reproducibility sport"), even after several retries
spread over two minutes. Substitute: SHARE search API.

| # | SHARE query (`q=`) | Total hits |
|---|---|---:|
| S1 | `reproducibility physiotherapy` (Freitext, ungebunden) | 50 851 (too broad to evaluate, see S2/S3) |
| S2 | `title:("reanalysis" OR "re-analysis" OR "multiverse" OR "individual participant data" OR "individual patient data") AND title:(physiotherapy OR rehabilitation OR "exercise science" OR "sports science" OR "sport science" OR "physical therapy")` | 21 |
| S3 | `title:("multiverse" OR "specification curve" OR "computational reproducibility" OR "vibration of effects") AND title:(physiotherapy OR rehabilitation OR "exercise" OR "sports" OR "sport" OR "physical therapy")` | 2 |

S2 and S3 are queries restricted to the title (Elasticsearch `query_string` syntax),
because pure free-text search (S1) was no longer meaningfully reviewable by hand,
given the enormous SHARE register enriched with many external sources
(ClinicalTrials.gov, DataCite, CrossRef).

### Candidates reviewed, with verdict

| Title | Authors | Year | Journal/Source | DOI | Verdict |
|---|---|---|---|---|---|
| Finding Predictive Factors of Stabilization Exercise Adherence in RCTs on Low Back Pain: An Individual Data Reanalysis Using Machine Learning Techniques | Pfeifer AC, Schröder-Pfeifer P, Schiltenwolf M, et al. | 2025 | Arch Phys Med Rehabil | 10.1016/j.apmr.2024.12.015 | Not a counterexample. A "preplanned reanalysis" by the same MiSpEx network that collected the original data, with no data obtained from a public repository. The research question concerns ML predictors of adherence, not the published primary analysis. |
| Dose-response relationship and effect modifier of stabilisation exercises in nonspecific low back pain: a project-wide individual patient data re-analysis on 1483 intervention participants | Niederer D, Pfeifer AC, Engel T, et al. | 2023 | Pain | 10.1097/j.pain.0000000000002801 | Not a counterexample. Same MiSpEx network, project-internal IPD not obtained from a public repository. A dose-response question rather than recomputation of a published primary analysis. |
| Re-analysis of data from a cluster RCT entitled "health literacy and exercise-focused interventions on clinical measurements in Chinese diabetes patients" | Jamshidi-Naeini Y, Golzarri-Arroyo L, Vorland CJ, Brown AW, Allison DB | 2022 | eClinicalMedicine | 10.1016/j.eclinm.2022.101686 | Not a counterexample, but methodologically the closest to our approach. The authors first explicitly reproduce the published figures, then recompute with a corrected model (LMM instead of GEE). The data source, however, is direct, confidential sharing by the original authors ("collegially shared"), not a public repository, and the field is diabetes care and health literacy, not physiotherapy, rehabilitation or exercise science in the narrower sense. |
| Contrary to the Conclusions Stated in the Paper, Only Dry Fat-Free Mass Was Different between Groups upon Reanalysis. Comment on "Intermittent Energy Restriction..." | Peos J, Brown AW, Vorland CJ, Allison DB, Sainsbury A | 2020 | J Funct Morphol Kinesiol | 10.3390/jfmk5040085 | Not a counterexample. Individual data come from the online supplement of the original publication (hence publicly accessible), field is exercise science and strength training. However, no recomputation of the published primary analysis, but an alternative, corrected model (ANCOVA/ITT instead of a completers-only DINS comparison) to refute the conclusion. As a letter/comment, not an independent study contribution and no multiverse. |
| Individually randomized trial mislabeled as a cluster-randomized trial. Comment on "Effectiveness of wearable technology to optimize youth soccer players' off-training behaviour..." | Vorland CJ, et al. | 2023 | Sci Med Football | 10.1080/24733938.2023.2190998 | Not a counterexample. A short comment on a randomisation/analysis error, with no discernible retrieval of individual data from a repository and no complete recomputation of the primary analysis. |
| Replication concerns in sports and exercise science: a narrative review of selected methodological issues in the field | Mesquida C, Murphy J, Lakens D, Warne J | 2022 | R Soc Open Sci | 10.1098/rsos.220946 | Not a counterexample. A narrative review, no original reanalysis. |
| Estimating the Replicability of Sports and Exercise Science Research (inkl. Korrektur 2025-09-11) | Murphy J, Caldwell A, Mesquida C, et al. | 2025 | Sports Med | 10.1007/s40279-025-02201-w | Already documented as a neighbour (README, as of 2026-08-28). A replication with new data, not an IPD reanalysis from a repository. The September 2025 correction does not change this. |
| Reproducible candidate kinematic-electromyographic waveform markers of post-stroke gait from public multimodal waveform exports | Calabrò RS, Calderone A, Sottile F, et al. | 2026 | Front Med Technol | 10.3389/fmedt.2026.1863908 | Not a counterexample. A "secondary analysis" of a public gait dataset, but one that produces new markers/metrics rather than recomputing the published primary analysis of the original dataset. |
| Computational Reproducibility in Sports Science: A Registered Report Reanalyzing Private Raw Data | Nolte S | Registered 2026-01-14 | OSF Registries | 10.17605/OSF.IO/VCWP8 | Not a counterexample, but the most important new neighbour. The aim is precisely to recompute the published primary analyses of 50 articles in the Journal of Sports Sciences, assessing correctness and methodological vagueness. The data source, however, is explicitly **private**: authors are asked to share their raw data confidentially, precisely because "relying only on published data may yield a distorted sample". No published results yet (Europe PMC search for the title: 0 hits, as of 2026-09-15). |
| Data and Code Availability in Sports Science: A Registered Report | Nolte S, Memmert D, Rein R | Preprint 2026-09-08 | OSF Preprints | 10.31222/osf.io/et5fw_v1 | Not a counterexample. A pure availability audit of all original articles in Q1 exercise science journals over the past ten years (like Jabouille/Elghzali), no reanalysis. Notable as a scooping signal: the same group (Cologne) is thereby building "a resource with all articles that have shared data and/or code for reuse", whose obvious follow-on application would be a public-repository reanalysis. |
| Prevalence and predictors of data and code sharing in the medical and health sciences: systematic review with meta-analysis of individual participant data | (OpenAlex hit, not field specific) | 2023 | – | – | Not a counterexample. "Individual participant data" here refers to the individual studies evaluated in the meta-analysis itself (the proportion with data/code sharing per study as the "observation"), not to clinical individual-level data. The topic is the prevalence of data/code sharing generally in medicine, not a physiotherapy-related field. |
| CaReMATCH / ExTraMATCH II / Precision rehabilitation for aphasia (several IPD meta-analysis protocols) | various | 2018-2023 | OSF/cardiac rehab/stroke J | various | Not a counterexample. Classic prospective IPD meta-analyses across several studies, with individual data collected directly from the participating study teams (not drawn from a public repository). The target quantity is a pooled meta-analytic effect across studies, not the recomputation of a single published primary analysis. |

### Update on scooping risk (supplement to README, as of 2026-08-28)

The Boisgontier/Jabouille line has shown no new direction since 28 August. The most
recent works are a Kinarm validation study (registered report, 2026-08-26/09-11) and a
French-language transparency checklist article in *Kinésithérapie, la Revue*
(2026-08-01, "Les indicateurs de la science ouverte comme estimation du risque de
pratiques de recherche douteuses en kinésithérapie"). Both confirm the earlier
assessment: meta-research at the article level, no methodological shift to individual
data.

New and more relevant is **Simon Nolte** (German Sport University Cologne, with Daniel
Memmert and Robert Rein). Since January 2026 he has been pursuing two parallel,
complementary projects: a field-wide availability audit of data and code in exercise
science journals (preprint 2026-09-08, one week before this search date) and a
registered-report reanalysis of the published primary analyses of 50 articles in the
*Journal of Sports Sciences* (registered 2026-01-14). The second project is
content-wise the closest to this manuscript, but it deliberately uses raw data shared
privately and confidentially by the authors rather than data from a public repository,
and it covers exercise science journal-wide rather than physiotherapy/rehabilitation
studies with deposited repository data. No multiverse, no specification curve. Should
Nolte in future link his availability-audit resource ("resource with all articles that
have shared data and/or code") to a reanalysis, that would be a direct competitor. At
the time of this search, that step does not exist.

### Conclusion

Across 19 Europe PMC queries, 17 OpenAlex queries (2 of them with `type:preprint`) and
3 SHARE/OSF queries (after the official OSF API failed), no published or registered
contribution was found that (a) obtains individual data from a public repository or
supplement, (b) thereby recomputes the published primary analysis of a physiotherapy,
rehabilitation or exercise/sports science study, and (c) does so as an independent
study contribution. The statement in the manuscript remains tenable after this second,
extended search.

The closest neighbours, in descending order of proximity, are: Nolte (2026, registered
intent to reanalyse, but private rather than public data), the Jamshidi-Naeini/Allison
group (2022, first reproduces the original figures, then a corrected reanalysis, but
outside the field and with data shared directly rather than deposited publicly), the
Vorland/Allison/Peos "comment" series (occasionally uses supplement individual data in
exercise science journals, but as a short error correction without recomputing the
published figure and without a multiverse), and the MiSpEx network's own reanalyses
(Pfeifer 2025, Niederer 2023: project-internal IPD, a different research question).
None of these satisfies both criteria simultaneously within the target field.

**Limitation:** the OSF registrations API was unreachable on the day of the search.
The SHARE substitute covers the same registration pool, but with a different
relevance weighting. A further direct check via `filter[title]` is recommended once
the API is working again, but given the overlap of the SHARE hits with the Europe
PMC/OpenAlex results, this is unlikely to change the overall verdict.
