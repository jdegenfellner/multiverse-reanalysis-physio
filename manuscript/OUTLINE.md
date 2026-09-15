# Outline, version 2 (2026-09-12), after three reviews

Revision of version 1 after `review_logic.md` (19 findings), `review_sources.md` (10
corrections) and `review_statistics.md` (15 findings). All numbers from the pipeline run of
2026-09-12 after the statistical fixes (pooled within-group SD as denominator, non-
representable models counted as non-matches, absolute reproduction criterion, m = 20,
4 999 permutations). Every number traces to a file in `output/` or `config/`; every
attribution to a PDF in `literature/`. `[check]` marks numbers to re-read at writing time.
Version 1 is archived as `OUTLINE_v1.md`.

**Working title.** Reproducibility without a mandate: how far can a reader recompute
exercise, rehabilitation and physiotherapy trials from their public data, and how far do
their conclusions move?

**Target journals.** BMC Medical Research Methodology; Journal of Clinical Epidemiology;
PLOS Medicine.

**Reporting conventions.** No "statistically significant" as a verdict (Wasserstein & Lazar
2016; Wasserstein, Schirm & Lazar 2019). Every proportion with a Wilson interval, every
cross-study median with a study-bootstrap interval (`output/uncertainty_*.csv`). The
published estimate is located within the specification distribution; differences are
reported as a distribution of differences (`output/published_minus_median.csv`), never as
CI overlap. Thresholds in the integrity screen are triage rules, not verdicts.

---

## The story in one paragraph

Mass computational reproduction of research has been demonstrated where journals mandate
data and code: Brodeur et al. reproduced 110 economics and political science articles
and found more than 85% computationally reproducible. Physiotherapy and rehabilitation
have no such mandate; about one article in eight shares data (Jabouille 2025), and
requests to authors mostly fail (Elghzali 2025; Murphy 2025). We asked what a reader can
do unaided. From the literature we assembled every trial with a repository link in its
availability statement (152), retrieved the deposits, and for the 48 randomised trials
with a readable data file tried to identify and recompute the published primary estimate.
Two losses occur. The first, from 152 to 48, is the familiar availability gap: deposits
unreachable, no data file, not a trial. The second, from 48 to 16, is new: data are public
and readable, yet the published primary analysis cannot be identified in them or the
design does not admit an arm contrast. Where recomputation was possible it worked: 10 of
12 published estimates were recovered within 2% or 0.02 SD, and all 12 lie inside the
range of a wider "defensible" multiverse. We then ran a prespecified multiverse whose
decision nodes were classified in advance as equivalent (Type E), nonequivalent (Type N)
or uncertain (Type U) after Del Giudice and Gangestad. Across the 16 trials the range of
the standardised effect over equivalent choices has a median of 0.15 SD, but reaches
1.08 SD in the smallest trial; the sign is stable in 15 of 16; the handling of the
baseline value moves the estimate more than any other choice. The wider grid adds about a
third more range, mostly through log-transformation, which changes the estimand rather
than the analysis. Two further observations concern the field and ourselves: 9 of 16
papers name no primary outcome and 4 report no point estimate; and our own first mapping
of published analyses onto deposited data reversed the control arm in 10 of 16 trials
until rule-based recoding, which we report as a source of auditor degrees of freedom.

---

## 1. Introduction (900 to 1100 words)

### 1.1 Reproduction where sharing is mandatory
- Brodeur 2026 `[09]`: 110 articles from journals with mandatory data and code policies,
  >85% computationally reproducible, 72% of significant estimates robust to
  reproducer-chosen checks. Stodden 2018 `[16]` on policy and artefact availability.
- Biomedical audits before author contact was the bottleneck: Naudet 2018
  `[style_models]`: 37 RCTs eligible, 17 datasets obtained, 14 of 17 fully reproduced and
  16 of 17 reached the same conclusion `[corrected per review_sources #5]`. Siebert 2022
  `[17]`: 10 of 62 EMA-assessed studies reanalysed (16%); Naudet's own availability rate
  was 46% in a different cohort. State the two figures as a cross-study contrast, not as
  one paper's numbers `[review_sources #3]`. Hardwicke 2018 (Cognition, mandatory policy)
  and Hardwicke 2021 (Psychological Science, open data badges) `[review_sources #6]`.

### 1.2 The field without a mandate
- Jabouille 2025 `[10]`: four physiotherapy association journals, 465 articles, 12% with
  data directly available. Elghzali 2025 `[11]`: 22.7% author compliance. Murphy 2025
  `[12]`: 14% of authors provided raw data, 28% of replications succeeded. Dhanani 2022
  `[13]`: recomputation from published numbers only.
- "We are not aware of" any study retrieving individual data from repositories in these
  fields and recomputing the primary analysis; give search terms and date (README).
  Terminology: computational or analytic reproducibility.
- Corpus search limitation (single database) goes to 4.7 `[review_logic #17]`.

### 1.3 Multiverse analysis in trials
- Steegen 2016 `[08]`, Simonsohn 2020 `[23]`. Nepomuceno 2026 `[15]`: of 613
  multiverse-style studies, in the 152 coded in depth 8.6% preregistered, 3.9% justify
  their specifications, median 144 specifications, 82.2% purely descriptive
  `[corrected per review_sources #1; state denominator 152]`.
- Del Giudice & Gangestad 2021 `[06]`: Type E (principled equivalence), Type N
  (principled nonequivalence), Type U (uncertainty); padded multiverses can hide real
  effects `[review_sources #2]`. Short 2026 `[07]`: defensibility (justified per pipeline,
  one route being use in the literature) versus equivalence; "illusion of consistency"
  when empirically similar datasets are compared `[review_sources #8, #9]`.
- Veltri 2026 `[01]`: simulated behavioural RCT, 180 paths from 36 preprocessing pipelines
  and 5 model specifications; preprocessing explains 76.9% of estimate variance, model
  choice 7.5%. The simulation does not separate estimand change from analytic choice.
- Crenshaw 2026 `[02]`: multiverse on one PTSD trial. Vibration of effects: Patel 2015
  `[27]`, Klau 2021 `[28]`. Many-analysts: Silberzahn 2018 `[30]`, Botvinik-Nezer 2020
  `[31]`, Breznau 2022 `[32]`, Gould 2025 `[33]`.

### 1.4 Aims (verbatim as Results headings 3.1 to 3.4; secondary aim as 3.5)
1. Feasibility: of trials with a public deposit, in how many can the published primary
   analysis be identified in the data and recomputed without contacting anyone, and
   where does the loss occur?
2. Reproduction: does the published primary estimate reproduce?
3. Fragility: over a prespecified grid of equivalent choices, how far does the
   standardised effect move, and which node moves it?
4. Estimand versus analysis: how much range does the defensible grid add, and through
   which nodes?
Secondary: reporting features that block reproduction, and our own coding error rate.
`[review_logic #6, #7, #12]`

---

## 2. Methods (1900 to 2300 words)

### 2.1 Design, registration, transparency
- Meta-research audit, three stages, two-source corpus.
- Not preregistered. Timeline stated explicitly: node grid written 2026-08-28 before any
  computation; published analyses extracted from all 21 candidate papers; auditor rules
  fixed after that extraction and before registry v2 and the final computation; all
  results inspected before writing. Say why the rule timing cannot have steered the
  results toward a wanted direction: the rules are generic (registration hierarchy,
  report type, design classes), applied uniformly, and their effect is reported (3.5)
  `[review_logic #10]`. Brodeur's statement on non-preregistration quoted verbatim
  `[09, check wording]`. Transparency items after van den Akker 2021 `[35]`.
- Code, registry, grid, outputs public `[DOI to create]`.

### 2.2 Corpus, source A (Europe PMC)
- Search string, date, filters; 423 records. Availability-statement extraction; URL
  counted only inside the statement (whole-text counting inflated 107 to 4 true
  positives). 152 with a link, 91 RCTs. Deposit probe via OSF, Zenodo, Dryad, figshare
  APIs; 84 reachable, 74 with a tabular file, 48 RCTs. API pitfalls in a footnote.
- Source B (Zenodo, Dryad direct search, 127 study-like deposits) moved to 4.7 as a
  begun but unmerged extension `[review_logic #8]`.

### 2.3 Eligibility, design exclusions, auditor rules
- Criteria (a) to (d). Design exclusions applied uniformly: crossover, within-person,
  feasibility as primary aim, non-clinical, non-randomised, binary primary outcome;
  secondary analyses without an arm contrast. Categories in `config/exclusions.csv`
  (`category`): design 17, data insufficient 11, no arm-contrast estimate 2, duplicate
  dataset 2 `[review_statistics #5]`.
- The eight auditor rules (METHODENPRUEFUNG.md), listed.
- Two-stage coding and its consequence (3.5). Second coder blind `[pending; kappa]`.
- Field and population coded per study; stratum labels: "clinical rehabilitation
  context" (physiotherapy or rehabilitation in patients or survivors, neuromodulation,
  steroid injection; 8) versus "exercise physiology and sports nutrition, non-clinical
  context" (training and nutrition in healthy adults 6, exercise in pregnancy 2; 8).
  State that the two pregnancy trials sit in the second stratum by intervention context,
  not by health status `[review_statistics #6]`.

### 2.4 Stage 1 outcome: the funnel, with the two losses named
### 2.5 Stage 2: computational reproduction
- Extraction with verbatim quotes; matching rule (most nodes agreeing; ties by closest
  estimate, which can only favour agreement, stated as such `[review_statistics #13]`);
  published model families absent from the grid (random slopes, Bayesian, non-parametric)
  count as non-matches `[review_statistics #1]`.
- Classification uses both a relative and an absolute criterion because a relative rule is
  unstable near zero `[review_statistics #3]`: full if the same sign and (relative
  difference ≤ 2% or absolute difference ≤ 0.02 SD); minor if ≤ 10% or ≤ 0.05 SD; major
  otherwise. Hardwicke 2021 uses minor < 10% and major ≥ 10% plus a decision-error
  category; the 2% level was proposed and discarded in Naudet 2018 `[review_sources #4]`.
  Both criteria reported per study (Table 3); the relative-only classification given as a
  sensitivity line.
- "No point estimate" when the paper reports only p or F. Two documented overrides
  (eTRE post contrast; phosphatidic acid F statistic).

### 2.6 Data integrity screen
- Carlisle-type baseline test (Stouffer combination, chosen over Fisher because the
  question is two-sided: too similar or too different; flag below 0.005 or above 0.995 as
  a triage rule) `[review_statistics #12]`; Bolland 2019 caveats; duplicate rows; terminal
  digits reported only. Low power at 16 trials stated `[review_logic #16]`.

### 2.7 Stage 3: grids (Table 1)
- E nodes: baseline handling (Vickers & Altman 2001 `[39]`; Senn 2006 `[40]`;
  Van Breukelen 2006 `[56]`; Twisk 2018 `[41]`), covariates (Kahan 2014 `[42]`; Kahan &
  Morris 2012 `[43]`), pooled winsorising, model family, inference. N nodes: missing data
  (MI m = 20 by PMM, Rubin pooling, Barnard-Rubin df; White 2011 `[45]`; ICH E9(R1)
  `[54]`; Kahan 2024 primer `[44]`), log-transformation, arm-wise outliers.
- Applicability rules; incoherent combinations removed (HC3 and permutation only with
  linear models; MI not with permutation); exact duplicates collapsed and reported
  (pooled duplicate share 4.4% principled, 6.1% defensible) `[review_statistics
  Zahlenabgleich #28]`. Grid size: 8 nodes, 22 options; per-study unique specifications 3
  to 140 (principled) and 6 to 672 (defensible) `[review_statistics #14, #39]`.
- Permutation p from 4 999 permutations, s-value ceiling 12.3 bits stated
  `[review_statistics #10]`.

### 2.8 Summary measures
- d = estimate / pooled within-group SD of the raw outcome at the primary timepoint,
  computed once per study before preprocessing (Cohen/Hedges convention)
  `[review_statistics #2]`; log specifications with the pooled SD of the log outcome,
  never mixed with raw ones (our rule, not attributed) `[review_sources #7]`.
- Per study: median, IQR, range of d; share with the sign of the median; share with
  |d| > 0.2 SD labelled as Cohen's small-effect convention, not MCID `[review_statistics
  #11]`; s-values; percentile of the published estimate.
- Node contribution: per-study Type II sums of squares, additive model, for d and for
  standardised interval width; sensitivity with all two-way interactions in the 10
  study-grid combinations with ≥ 30 specifications `[review_statistics #7]`. Report the
  dominant node's median share and how many studies have only one d-moving node.
- Dataset similarity between preprocessing pipelines (our operationalisation, after
  Short 2026's concept) `[review_sources #8]`.
- Uncertainty: Wilson intervals; study bootstrap (5 000) for cross-study medians;
  distribution of published minus multiverse median.
- Range drivers: Spearman of the principled range with n, baseline imbalance,
  baseline-outcome correlation, missingness (descriptive, 16 points)
  `[review_logic #13]`.
- Not done: pooled meta-analysis over specifications (Bartos 2025 `[24]`), minP (Mandl
  2024 `[04]`); listed as future work.
- Software: R `[version]`; dplyr, readxl, haven, lme4, lmerTest, sandwich, lmtest, mice,
  car `[review_statistics #40]`.

---

## 3. Results (1500 to 1800 words; Tables 2 and 3; Figures 1 to 4)

### 3.1 Feasibility (Aim 1; Figure 1; Table S1)
- 423 → 152 (91 RCTs) → 84 → 74 (48 RCTs) → 16 included (13 primary reports, 3 secondary
  reports). Included, denominator 48: 33% (Wilson 22 to 47%); denominator 152: 11% (7 to
  16%).
- Loss one (152 → 48): unreachable deposit 68, no tabular file 10, non-randomised 26.
- Loss two (48 → 32 excluded → 16): design 17, data insufficient for the primary
  analysis 11 (allocation not in data 3, outcome not identifiable 2, raw signals 2,
  timepoint not in deposit 1, summary table only 1, README only 1, unreadable 1), no
  arm-contrast estimate 2, duplicate 2. Sentence: in 11 trials the data were public and
  readable and still could not answer the published question.
- Hosts; fields and populations; n 16 to 294; code deposited alongside data in
  `[check: 2]` of 16.

### 3.2 Reproduction (Aim 2; Table 3)
- 12 with a point estimate: full 10, minor 2 (SPADI 6.9% and 0.06 SD; FREE 29% and
  0.04 SD), major 0. Full: 83% (Wilson 55 to 95%). Relative-only rule: 6 full, 3 minor,
  3 major. Absolute differences 0.000 to 0.063 SD.
- Published specification fully representable in the grid 7 of 12 (Wilson 32 to 81%);
  non-representable elements: random-slopes model (FREE), Bayesian multilevel (Gaining
  More), 14-timepoint AR(1) and log-scale change (Physiofeedback), cLDA with centre
  (TERECO), three-arm LMM (eTRE).
- Published estimate inside the principled range 9 of 12 (47 to 91%), inside the
  defensible range 12 of 12 (76 to 100%). Published minus multiverse median: median
  0.006 SD, range −0.055 to 0.163 SD (Figure S).
- Naudet convention: full or minor, denominator 48: 25% (15 to 39%); denominator 152: 8%
  (5 to 13%).

### 3.3 Fragility (Aim 3; Figure 2; Figure 3; Figure 4)
- Principled: 395 unique specifications; range of d per study median 0.15 SD (bootstrap
  0.08 to 0.23), IQR 0.07 to 0.23, maximum 1.08 (tDCS, n = 20). Sign stable 15 of 16 (72
  to 99%); range includes zero in 1 (FREE).
- Node shares (d): baseline handling largest in 10 of 15 studies with a varying node,
  median share 100% because in 9 of 15 only baseline handling and inference vary and
  inference cannot move d; outlier rule largest in 3, covariates in 2. Interval width:
  baseline 10 of 15, inference median 3.7%. Interaction sensitivity: dominant node
  unchanged in 10 of 10; interaction terms median 9% of explained variance.
- Range drivers (16 points): Spearman with n −0.04, baseline imbalance 0.37 (12
  studies with a baseline), baseline-outcome correlation −0.10, missingness 0.01.
  Descriptive only.
- Strata (descriptive, no test): clinical rehabilitation context (8) median range 0.18,
  max 1.08; exercise and nutrition context (8) median 0.06, max 0.41.
- Dataset similarity: in 9 of 16 trials all preprocessing pipelines correlate above 0.99;
  sign stability there is not evidence of robustness.
- Integrity screen: no flag (low power stated).

### 3.4 Estimand versus analysis (Aim 4)
- Defensible: 1 934 unique specifications; range median 0.28 (bootstrap 0.10 to 0.38),
  maximum 1.11; sign stable 14 of 16; includes zero in 2 (FREE, ETIP).
- Ratio defensible to principled, median 1.35 (bootstrap 1.18 to 1.52) over 15 studies
  with a finite ratio; eTRE has zero principled range.
- Largest node in the defensible grid: baseline 7 of 16, log-transformation 5, outlier
  3, covariates 1. Missing-data strategy largest in none.

### 3.5 Reporting, and auditor degrees of freedom (secondary aim; Table 2; Box 1)
- Reporting: primary outcome declared in registration or methods 7 of 16 (Wilson 23 to
  67%), inferred from the abstract 9; point estimate 12 of 16; estimand stated 1;
  baseline significance tests reported 13, decisive for adjustment in 3; outlier rule 0;
  protocol 7, registration only 6, neither 3; journal with data requirement 10.
- Auditor degrees of freedom (`output/registry_v1_vs_v2_fields.csv`,
  `output/registry_v1_vs_v2.csv`): registry v1 differed from v2 in 13 of 16 trials:
  control arm 10, outcome variable 5, covariate set 11, baseline variable 3, data file 1.
  Effect on results, computed by running v1 through the final engine: median |d| 0.24
  versus 0.25, median range 0.16 versus 0.14, but the sign of the median reversed in 7 of
  16. Coding errors changed direction, not fragility. Second-coder agreement `[pending]`.

---

## 4. Discussion (1300 to 1600 words)

### 4.1 Principal findings: four sentences for four aims, one for the secondary aim.

### 4.2 Two losses, one new
- The first loss is the known availability gap. The second is identifiability: public,
  readable data that cannot answer the published question. Implication: a deposit needs a
  named primary variable, an allocation variable with labels, and a dictionary.

### 4.3 Reproduction: majority reproduced, wide interval, and where it fails
- 10 of 12 (55 to 95%) with n = 12 is the number; the contrast to Brodeur is the setting
  (mandate, 110 articles), not the rate. Failures of exact representation come from model
  families outside the grid, not from data problems. Naudet: 16 of 17 same conclusion.
  The larger point stands in the first sentence: only 12 of 423 screened records reach
  this step `[review_logic #3]`.

### 4.4 Fragility: typical case small, smallest trial not
- Median 0.15 SD; the smallest trial moves six to seven times that. Baseline handling
  dominates, the Vickers and Altman lesson, and in most trials it is the only equivalent
  choice that can move the estimate at all; say so `[review_statistics #8]`. Baseline
  imbalance correlates weakly with range in 12 points; not a test. Contrast with Veltri:
  in real trials with Type N nodes separated, preprocessing contributes little; the
  largest preprocessing effect, log-transformation, is an estimand change. Crenshaw 2026:
  single-trial curve versus an a priori node typology applied over 16 trials, which is
  what makes estimand ambiguity visible as a field pattern `[review_logic #9]`.

### 4.5 Reporting
- 9 of 16 without a named primary outcome, 4 without a point estimate, 1 with an
  estimand. ICH E9(R1), Kahan 2024, CONSORT 2010 `[58]` and 2025 `[59]`. Baseline tests
  (Senn 1994 `[55]`).

### 4.6 Auditor degrees of freedom
- Our registry v1 reversed the control arm in 10 of 16. The reanalysis has its own
  garden of forking paths (Gelman & Loken 2014 `[34]`, 2013 `[34a]`). Rule-based recoding
  and blind second coding are the remedy; the effect was on direction, not on fragility.
  Relate to reproducer-chosen checks in Brodeur and to many-analysts variation.

### 4.7 Limitations
- Self-selected corpus (Tsujimoto 2020 `[18]`: ratio of odds ratios 1.01, 0.86 to 1.19;
  Wicherts 2011 `[19]`; Nuijten 2017 `[20]` as a conceptual repetition without
  confirmation; Claesen 2023 `[21]` as a failed replication) `[review_sources #10]`.
- 16 trials, 3 to 140 principled specifications each; one trial with a single
  specification; continuous outcomes only; 3 secondary reports included; single
  database search; Source B begun, not merged; not preregistered, rule timing stated;
  one coder to date; integrity screen underpowered; Type II decomposition with
  confounded node pairs (model × inference, missing × inference) and interactions not
  modelled in the main analysis; dataset similarity high in 9 of 16; MCID not per
  instrument.

### 4.8 Implications
- For journals and depositors: named primary variable, labelled allocation, dictionary.
- For multiverse practice: classify nodes first, collapse duplicates, fix the
  denominator, report both grids.
- For meta-research: without a mandate, one trial in nine with a repository link (11%,
  7 to 16%) reaches recomputation, and one in twelve (8%, 5 to 13%) reproduces
  `[review_logic #1: both denominators named]`.

## 5. Conclusion (120 to 160 words)
Feasibility with the two losses; reproduction; fragility with median and maximum;
estimand versus analysis; reporting; our own error rate in one clause `[review_logic #11]`.

---

## Tables and figures

| | Content | Source |
|---|---|---|
| Table 1 | Nodes, options, type, justification, applicability | `R/grid.R`, NODES.md |
| Table 2 | Reporting features of 16 trials | `config/published.csv` |
| Table 3 | Reproduction per trial: published, ours, relative and absolute difference, class, representable, percentile | `output/reproduction.csv` |
| Figure 1 | Flowchart with both losses | `output/figures/flowchart_funnel.pdf` |
| Figure 2 | Range of d per trial, both grids, published estimate marked | `overview_all_studies.png` |
| Figure 3 | Specification curves TERECO, tDCS, FREE | `speccurve_*.png` |
| Figure 4 | Node shares per trial | `variance_d.png` |
| Box 1 | Registry v1 versus v2 and its effect | `output/registry_v1_vs_v2*.csv` |
| Table S1 | 32 exclusions with category and reason | `config/exclusions.csv` |
| Table S2 | Registry v2 | `config/registry.csv` |
| Table S3 | Summary measures per trial and grid, with intervals | `output/summary_by_study.csv`, `output/uncertainty_*.csv` |
| Table S4 | Interaction sensitivity | `output/variance_interactions.csv` |
| Table S5 | Range drivers | `output/range_drivers.csv` |
| Figure S1 to S16 | All specification curves (16 included trials only) | |
| Figure S17 | Interval-width shares | `variance_ci_width_d.png` |
| Figure S18 | Published minus multiverse median, 12 trials | `output/published_minus_median.csv` |
| Supplement | Integrity screen, dataset similarity, duplicates, non-applicable nodes | `output/*.csv` |

## Open before writing
- Second coder (form in `coding/`).
- Verify code-deposit count for the 16 `[check]`.
- Decide whether to add Bartos-style pooled estimate and minP now or list as future.
