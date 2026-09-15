# Outline, version 1 (2026-09-12), ARCHIVED. Superseded by OUTLINE.md (version 2).

This is the version the three reviews (`review_logic.md`, `review_sources.md`,
`review_statistics.md`) refer to by line number. Reconstructed verbatim from the working
copy; line numbers in the reviews are approximate against this file.

**Working title.** Reproducibility without a mandate: computational reproduction and a
principled multiverse audit of exercise, rehabilitation and physiotherapy trials with
publicly deposited data

**Target journals.** BMC Medical Research Methodology; Journal of Clinical Epidemiology;
PLOS Medicine (Research Article, meta-research).

**Reporting conventions.** No "statistically significant" as a verdict (Wasserstein 2016,
2019). Uncertainty as intervals and s-values. No CI-overlap comparisons. Every number in
the text traces to a file in `output/` or `config/`; every attribution to a PDF in
`literature/`. Numbers marked `[check]` must be re-read from the file at writing time.

---

## The story in one paragraph

Mass computational reproduction of trials has been demonstrated only where journals
mandate data and code (Brodeur 2026, economics and political science, >85% reproduced).
Physiotherapy and rehabilitation have no such mandate; roughly one article in eight shares
data at all (Jabouille 2025) and requests to authors mostly fail (Elghzali 2025, Murphy
2025). We asked what a reader can do unaided: from the literature and from repositories we
assembled every trial with a public deposit, tried to recompute the published primary
estimate, and then ran a prespecified multiverse whose decision nodes were classified in
advance as equivalent (type E), estimand-changing (type N) or unclear (Del Giudice &
Gangestad 2021). Three results carry the paper. First, feasibility collapses one step later
than in previous audits: not at author contact, but at the transition from "data are
public" to "the published primary analysis can be identified and recomputed" (152 studies
with a repository link, 16 analysable). Second, where recomputation is possible it mostly
works: 8 of 12 published estimates fall within 10% of ours, and the published estimate lies
inside the principled multiverse range in 9 of 12. Third, analytic fragility is small and
concentrated: across 16 trials the principled range of the standardised effect has a median
of 0.14 SD, the sign is stable in 15 of 16, and the handling of the baseline value drives
most of the spread; the wider "defensible" grid adds about a third more range, mostly
through log-transformation, which is an estimand change rather than an analytic choice.
The audit also produced two findings about auditing itself: reporting in this field
frequently leaves the primary outcome, the estimand and even a point estimate unstated, and
our own first mapping of published analyses onto deposited data was wrong in half the
studies until rule-based recoding, which we report as a source of auditor degrees of freedom.

---

## 1. Introduction (target 900 to 1100 words)

### 1.1 Reproduction where sharing is mandatory
- Claim: Computational reproduction at scale has been shown feasible under mandatory data
  and code policies. Source: Brodeur 2026 (110 articles, >85% computationally reproducible,
  72% of significant estimates robust) `[literature/09]`. Stodden 2018 for the policy
  effect on artefact availability `[16]`.
- Claim: Earlier biomedical reanalysis audits collapsed at author contact. Sources: Naudet
  2018 (BMJ and PLOS Medicine, 37 RCTs eligible, 17 datasets obtained, 14 reanalysed)
  `[style_models/Naudet]`; Siebert 2022 (EMA data sharing, reanalysis rate 46% vs 16% under
  the Naudet convention) `[17]`; Hardwicke 2018 and 2021 (Cognition, Psychological Science
  open data badges) `[style_models]`.

### 1.2 The field without a mandate
- Claim: In physiotherapy and rehabilitation, no journal mandate; data availability
  around 12% (Jabouille 2025, four association journals, 465 articles) `[10]`; author
  compliance after data-availability statements 22.7% (Elghzali 2025) `[11]`; in sports
  science, 14% of authors provided raw data and 28% of replications succeeded (Murphy
  2025) `[12]`. Dhanani 2022 recomputed statistics from published numbers only `[13]`.
- Claim: No published or registered study has retrieved individual participant data from
  repositories in these fields and recomputed the primary analysis (Europe PMC search,
  README section "Neuheitsprüfung"). State as "we are not aware of", with search terms.
- Terminology: "computational" or "analytic" reproducibility, distinct from
  reproducibility of exercise programmes.

### 1.3 Multiverse analysis in trials, and its two known problems
- Claim: Multiverse and specification-curve methods (Steegen 2016 `[08]`, Simonsohn 2020
  `[23, bib only]`) are widely used but rarely preregistered (8.6%) or justified (3.9%),
  median 144 specifications, 89.5% purely descriptive (Nepomuceno 2026) `[15]`.
- Claim: Uncritically padded multiverses can hide real effects; nodes must be classified
  as equivalent, non-equivalent or uncertain (Del Giudice & Gangestad 2021) `[06]`.
  Multi-curious distinguishes defensibility ("used in the literature") from equivalence
  (Short 2026) `[07]`.
- Claim: Preprocessing dominates model choice in a simulated RCT multiverse (76.9% vs
  7.5% of estimate variance, Veltri 2026) `[01]`, but the simulation does not separate
  estimand change from analytic choice.
- Claim: Clinical trial multiverse so far demonstrated on single trials (Crenshaw 2026,
  one PTSD trial) `[02]`.
- Vibration of effects as the epidemiological precursor (Patel 2015 `[27]`, Klau 2021
  `[28]`); many-analysts studies as the empirical counterpart (Silberzahn 2018 `[30]`,
  Botvinik-Nezer 2020 `[31]`, Breznau 2022 `[32]`, Gould 2025 `[33]`).

### 1.4 Aims
Four questions, verbatim for Results headings:
1. Feasibility: of trials with a public deposit, in how many can the published primary
   analysis be identified in the data and recomputed without contacting anyone?
2. Reproduction: does the published primary estimate reproduce?
3. Fragility: across a prespecified grid of equivalent choices, how far does the
   standardised effect move, and which decision node moves it?
4. Estimand versus analysis: how much range does the wider defensible grid add, and
   through which nodes?

Plus a stated secondary aim: to document reporting features that block reproduction
(primary outcome, estimand, point estimate).

---

## 2. Methods (target 1800 to 2200 words)

### 2.1 Design and registration
- Meta-research audit of published trials, two-source corpus, three stages.
- Not preregistered. State plainly: the decision grid was written before any specification
  was computed (NODES.md dated 2026-08-28), but all results were inspected before this
  manuscript. Follow Brodeur's statement that reanalyses "should all be considered as not
  pre-registered" `[09, check wording]`. Transparency statement per van den Akker 2021
  items `[35]`.
- Code, registry, grid and all outputs public (OSF/Zenodo DOI `[to create]`).

### 2.2 Corpus, source A (literature side)
- Europe PMC full-text search: physiotherapy/rehabilitation/exercise-therapy terms in
  title or abstract AND clinical design (PUB_TYPE or title terms) AND repository term in
  full text AND open access. Date `[check README]`. n = 423.
- Availability-statement extraction from JATS; repository URL counted only inside the
  data- or code-availability statement (rationale: the earlier whole-text count inflated
  hits with tool citations, from 107 to 4 true positives). n = 152, 91 RCTs.
- Automated deposit probe via OSF, Zenodo, Dryad, figshare APIs; file listing classified
  by extension. n = 84 reachable, 74 with tabular file, 48 RCTs.
- Two API pitfalls documented in a footnote (Zenodo page size 25 and 30 requests/min;
  OSF percent-encoding) because they silently produce zero results.

### 2.3 Corpus, source B (repository side)
- Direct Zenodo and Dryad search, 500 deposits, 127 study-like. Not yet matched to
  articles; reported as pending extension in Limitations, or dropped from this paper
  `[author decision]`.

### 2.4 Eligibility and auditor rules
- Four criteria (a) RCT in physiotherapy, rehabilitation, exercise or training,
  (b) individual data downloadable without application, (c) primary outcome and
  allocation identifiable, (d) methods sufficient to reconstruct the analysis.
- Design exclusions applied uniformly: crossover, within-person (limbs), feasibility as
  primary aim, non-clinical, non-randomised, binary primary outcome (grid built for
  continuous), secondary analysis without an arm contrast.
- The eight auditor rules (METHODENPRUEFUNG.md): primary outcome hierarchy
  (registration > paper > abstract-first > sample-size calculation); primary timepoint;
  no outcome substitution; control arm verification via value labels or Table 1 match;
  covariates only if in the published model; report type (primary vs secondary report);
  design exclusions; field and population coding.
- Two-stage coding: first coder built registry v1 ad hoc; after full extraction of the
  published analyses, rules were fixed and registry v2 built; a second coder codes
  blind `[pending; report kappa per field]`. Registry v1 errors are reported (Results 3.5).

### 2.5 Stage 1 outcomes: feasibility funnel
- Counts at every step with reasons; figure 1 flowchart.

### 2.6 Stage 2: computational reproduction
- Published estimate, interval, p and the published specification extracted from each
  paper with verbatim quotes (`coding/extracted/`).
- Matching rule: the grid specification agreeing with the published specification on the
  most nodes; ties broken by closest estimate. Whether all scored nodes matched is
  reported separately.
- Classification (Hardwicke 2021 `[style_models]`): full ≤2% relative difference, minor
  ≤10%, major >10% or sign change; "no point estimate" when the paper reports only a
  test statistic or p.
- Two documented overrides (`config/published_overrides.csv`): eTRE (paper reports both
  the post contrast and the interaction; we use the post contrast that matches our
  estimand), phosphatidic acid (extracted value was an F statistic).
- No judgement of appropriateness; no author contact.

### 2.7 Data integrity screen
- Carlisle-type test on named continuous baseline variables (Stouffer combination,
  two-sided extremes flagged; Carlisle 2017 `[47]`, caveats Bolland 2019 `[49]`);
  duplicate-row check; terminal-digit test reported but not used for flagging because
  many outcomes are derived means. GRIM (Brown & Heathers 2017 `[50]`) not applicable to
  individual data. Studies flagged would have been excluded from stage 3; none was.
- Context: INSPECT-SR stage 2 found no relation between trustworthiness and risk of bias
  (Wilkinson 2025 `[51]`); INSPECT-IPD protocol `[53]`.

### 2.8 Stage 3: the two grids
- Nodes and options table (Table 1), each with type and justification:
  - E: baseline handling (endpoint, change, ANCOVA; Vickers & Altman 2001 `[39]`,
    Senn 2006 `[40, bib only]`, Twisk 2018 `[41]`); covariate set (none, stratification
    factors, published set; Kahan 2014 `[42]`, Kahan & Morris 2012 `[43]`); pooled outlier
    winsorising (none, 3 SD, 1.5 IQR, 3 MAD); model family (linear, random intercept where
    clustering is estimable); inference (model SE, HC3, permutation).
  - N: missing-data strategy (complete case, MI with 10 imputations by PMM and Rubin
    pooling, LOCF where a baseline exists; ICH E9(R1) `[54]`, Kahan 2024 `[44]`);
    log-transformation; arm-wise outlier rule.
  - Applicability rules: an option is dropped when it cannot change the data (no
    missingness, rule winsorises nothing, no estimable cluster). Non-applicable nodes
    counted per study (`output/nodes_not_applicable.csv`).
  - Incoherent combinations removed; exact duplicate results collapsed to one
    specification (Simonsohn's non-redundancy requirement) and the duplicate share
    reported (`output/duplicates.csv`).
- Principled grid = E nodes; defensible grid = E + N nodes. The difference is a result,
  not a robustness check.

### 2.9 Summary measures
- Standardisation: d = estimate / SD of the raw outcome across arms before any
  preprocessing, fixed per study; log specifications use the SD of the log outcome and
  are never pooled with raw ones (Del Giudice & Gangestad on scale mixing). State why the
  residual SD was not used (it varies with the specification and manufactured range).
- Per study: median, IQR and range of d; share of specifications with the sign of the
  median; share with |d| above 0.2 SD (MCID not available per instrument `[or fill]`);
  s-values (Rafi & Greenland 2020 `[36]`); location of the published estimate as a
  percentile of the distribution.
- Node contribution: per-study type II sums of squares of d and, separately, of the
  standardised interval width; summarised as the node with the largest share per study.
- Pipeline similarity (Short 2026): correlation between preprocessed outcome vectors; where
  all pairs exceed r = 0.99, sign stability is not evidence of robustness.
- Not done and said so: pooled meta-analysis over specifications (Bartos 2025 `[24]`) and
  minP multiplicity control (Mandl 2024 `[04]`) `[author decision: add or list as future]`.
- Software: R `[version]`, packages lme4, lmerTest, sandwich, mice, car.

---

## 3. Results (target 1400 to 1700 words, 2 tables, 4 figures)

### 3.1 Feasibility (Figure 1; Table S1 exclusions)
- 423 screened; 152 with a repository link in the availability statement (91 RCTs);
  84 deposits reachable; 74 with a tabular file (48 RCTs); 48 assessed; 16 included
  (13 primary reports, 3 secondary reports). `output/figures/flowchart_funnel.png`,
  `config/exclusions.csv`.
- Exclusion structure: 16 design, 11 data insufficient for the primary analysis, 2 no
  arm-contrast estimate, 3 other. Sentence on where the funnel actually breaks.
- Reachable hosts: OSF 48, Zenodo 23, Dryad 11, figshare 2 (`candidates/deposit_contents.csv`).
- Included corpus by field and population (`config/registry.csv`): 5 physiotherapy or
  rehabilitation in patients, 1 in survivors, 1 neuromodulation, 1 steroid injection, 6
  training or nutrition in healthy adults, 2 exercise in pregnancy. Sample sizes 16 to 294.
- Code deposited with data: 10 of 74 at deposit level `[check for the 16]`.

### 3.2 Reporting of the primary analysis (Table 2, from `config/published.csv`)
- Primary outcome declared in registration or methods 7 of 16; inferred from abstract 9.
- Point estimate of the arm difference reported 12 of 16; only p or F in 4.
- Estimand stated 1 of 16. Baseline significance tests reported 13 of 16, and used to
  decide adjustment in 3.
- Published baseline handling: ANCOVA 6, change score 4, endpoint 2, other 4. Model
  families: ANOVA 5, mixed 6, ANCOVA 3, t-test 1, non-parametric 1. Missing data: none
  missing 7, complete case 4, likelihood 3, MI 1, not reported 1. Outlier rule reported
  0 of 16. Log transformation 1.
- Protocol or registration available: 7 protocol, 6 registration only, 3 neither.
  Journal with a data-sharing requirement: 10, unclear 6.
- One documented outcome switch disclosed by the authors (pregnancy exercise trial,
  excluded because the switched primary timepoint is not in the deposit).

### 3.3 Computational reproduction (Table 3, `output/reproduction.csv`)
- Of 12 with a point estimate: 6 full, 2 minor (3.0%, 6.9%), 4 major (19% to 29%).
- Published specification fully representable in the grid 8 of 12; three of the four
  major discrepancies have non-representable specifications (Bayesian multilevel model,
  14-timepoint AR(1) model, covariates absent from the deposit); the fourth (postpartum
  depression trial) differs through multiple imputation.
- Published estimate inside the principled range 9 of 12, inside the defensible range 12
  of 12; percentile positions listed.
- Naudet convention: counting the 152 with a link as denominator, fully or minor
  reproduced 8 of 152 (5%); counting the 48 assessed RCTs, 8 of 48 (17%).

### 3.4 Multiverse (Figure 2 overview; Figure 3 exemplary curves; Figure 4 node shares)
- Unique specifications: 395 principled, 1 934 defensible; duplicates collapsed 3 to 4%.
- Principled range of d: median 0.14 SD (IQR 0.07 to 0.22), maximum 0.89 (tDCS, n = 20).
  Sign stable in 15 of 16; range includes zero in 1 (FREE).
- Defensible range: median 0.25 (IQR 0.11 to 0.36), maximum 0.91. Sign stable 14 of 16;
  includes zero in 2 (FREE, ETIP). Ratio defensible to principled, median 1.37.
- Node with largest share of the estimate variance: baseline handling in 10 of 15
  (principled), outlier rule 3, covariates 2; inference 0 by construction. In the
  defensible grid, log-transformation is the largest node in 5 of 16. Interval width:
  inference contributes a median 2 to 3%.
- Strata: physiotherapy and rehabilitation (8) median range 0.18, max 0.89; training and
  nutrition in healthy adults (8) median 0.06, max 0.40. Report as descriptive.
- Pipeline similarity: in 10 of 19 assessed studies all preprocessed outcome vectors
  correlate above 0.99 `[recompute for the 16]`.
- Integrity screen: no flag.

### 3.5 Auditor degrees of freedom (short subsection or Box 1)
- Registry v1 versus v2: control arm miscoded in 8 of 16, outcome mismatched in 4,
  covariate list wrong in 11; 5 studies excluded after rule fixing. Effect of v1 errors on
  results is not reported as a result (they were errors), but the fact is.
- Second-coder agreement `[pending]`.

---

## 4. Discussion (target 1300 to 1600 words)

### 4.1 Principal findings (four sentences mirroring the four aims)

### 4.2 Where feasibility breaks, and why it is not where previous audits broke
- Previous audits: author contact (Naudet, Elghzali, Murphy). Here: identifiability of
  the primary analysis in the deposit. Implication for data-sharing policy: a deposit
  without a variable dictionary and a named primary variable is not reusable.

### 4.3 Reproduction is good when it is possible
- Compare with Brodeur (>85%), Hardwicke 2021 (Psychological Science), Naudet 2018
  (14 of 17 reanalyses with same conclusion). Our 8 of 12 within 10% is comparable;
  discrepancies come from models we could not represent, not from data problems.

### 4.4 Fragility is small and has a name
- Baseline handling dominates; this is the Vickers and Altman lesson; connect to the
  observed spread as a function of baseline imbalance and correlation (Lord's paradox
  literature already in NODES.md). Contrast with Veltri's 77% preprocessing share: in real
  trials with type-N nodes separated, preprocessing (outliers, missing) contributes little
  and the largest "preprocessing" effect, log-transformation, is an estimand change.
- The defensible minus principled difference quantifies estimand ambiguity; a third more
  range. This is the methodological contribution.

### 4.5 Reporting
- Nine of sixteen papers do not name a primary outcome; four give no point estimate; one
  states an estimand. Link to ICH E9(R1) and Kahan 2024; to CONSORT.
- Baseline tests reported in 13, decisive in 3 (Senn 1994 already cited in NODES.md
  `[add PDF or cite via Senn 2006]`).

### 4.6 Auditor degrees of freedom
- Our own first registry was wrong in half the studies. Reanalysis has its own garden of
  forking paths (Gelman & Loken 2014 `[34]`); rule-based recoding and blind second coding
  are the remedy. Relate to Brodeur's reproducer-chosen robustness checks and to the
  many-analysts literature.

### 4.7 Limitations
- Self-selected corpus (Tsujimoto 2020 `[18, bib only]`; Wicherts 2011 `[19]` and its
  failed replications Nuijten 2017 `[20]`, Claesen 2023 `[21]`): reproducibility likely an
  upper bound, fragility a lower bound. Within-corpus comparison mandated vs unclear
  journals `[if reported]`.
- Small n per trial; 16 trials; continuous outcomes only; no crossover; secondary
  reports included (3).
- Not preregistered; results seen before writing; one coder to date.
- Grid choices: 36 core options is deliberately small; things not varied (time windows,
  item-level missing, therapist clustering) listed.
- Pipeline similarity: in roughly half the trials preprocessing options barely change
  the data, so sign stability is partly trivial.
- Source B not used.

### 4.8 Implications
- For journals: named primary variable and dictionary as a deposit condition.
- For multiverse practice: classify nodes before computing; report duplicates; fix the
  standardisation denominator.
- For meta-research: recomputation without a mandate is possible for about one in ten
  trials with a link, and works when it is possible.

## 5. Conclusion (120 to 160 words)
One paragraph: feasibility, reproduction, fragility, estimand versus analysis, reporting.

---

## Tables and figures

| | Content | Source |
|---|---|---|
| Table 1 | Decision nodes, options, type, justification, applicability rule | `R/grid.R`, NODES.md |
| Table 2 | Reporting features of the 16 included trials | `config/published.csv` |
| Table 3 | Reproduction per study: published, ours, relative difference, class, spec matched, percentile | `output/reproduction.csv` |
| Figure 1 | Corpus flowchart | `output/figures/flowchart_funnel.pdf` |
| Figure 2 | Range of d per study, both grids, published estimate marked | `overview_all_studies.png` |
| Figure 3 | Two or three specification curves (TERECO, tDCS, FREE) | `speccurve_*.png` |
| Figure 4 | Node share of estimate variance per study | `variance_d.png` |
| Table S1 | 32 exclusions with reasons | `config/exclusions.csv` |
| Table S2 | Registry v2 and v1 differences | `config/registry*.csv` |
| Table S3 | Summary measures per study, both grids | `output/summary_by_study.csv` |
| Figure S1 to S16 | All specification curves | |
| Figure S17 | Interval-width variance shares | `variance_ci_width_d.png` |
| Supplement | Integrity screen, pipeline similarity, duplicates, non-applicable nodes | `output/*.csv` |

## Claims that need a source not yet in `literature/`
- Senn 1994 (baseline tests) `[fetch or cite through Senn 2006]`
- Lord's paradox / change vs ANCOVA under imbalance: Van Breukelen 2006, Barnett 2004
  (cited in NODES.md, PDFs not in literature/)
- CONSORT 2010 or 2025 statement
- Therapist effects and partial nesting (Johns 2019, Candlish 2018) only if 4.7 mentions them
