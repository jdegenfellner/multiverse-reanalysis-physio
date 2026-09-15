# Preregistration — Reproducibility without a mandate

**A reanalysis and multiverse audit of physiotherapy trials with publicly available data**

Registry: OSF Registries · Template: Open-Ended Registration (attach this document)
Status: DRAFT — placeholders in `[brackets]` must be filled before submission.

---

## 1. Background and aim

Mass computational reproduction has been done where data sharing is mandatory. Brodeur et
al. (Nature 2026, doi 10.1038/s41586-026-10251-x) reproduced 110 articles from economics
and political science journals with mandatory data and code policies, finding >85% of
claims computationally reproducible and 72% of significant estimates robust. Physiotherapy
has no such mandate: only 12% of articles in the four national association journals make
data directly available (Jabouille et al., medRxiv 2025, doi 10.1101/2025.09.23.25336497).

We ask whether independent reanalysis is feasible at all in a field without a data-sharing
mandate, and, where it is, how far trial conclusions survive the range of defensible
analytical choices.

Three stages:

1. **Feasibility.** Of physiotherapy and rehabilitation trials with publicly deposited
   data, in how many can the published primary analysis be independently recomputed?
2. **Computational reproduction.** Does the published primary effect estimate reproduce?
3. **Multiverse.** Across reproducible studies, how far does the conclusion move over a
   prespecified space of defensible specifications?

## 2. Sample

**Source A (literature side).** Europe PMC search combining physiotherapy/rehabilitation
terms in title/abstract with a clinical design (`PUB_TYPE` or title/abstract terms) and a
repository term in full text, restricted to open access. 423 candidates screened; a
repository link inside the data- or code-availability statement was found for 152 studies,
91 of them RCTs.

**Source B (repository side).** Zenodo and Dryad searched directly for clinically relevant
deposits; 127 study-like deposits. This arm exists because the Europe PMC route requires a
PMCID and systematically misses recent articles.

**Automated pre-screen.** Deposit file listings retrieved via the OSF, Zenodo, Dryad and
figshare APIs. 74 studies had at least one tabular file, 48 of them RCTs; 10 additionally
had analysis code.

**Randomised trials only.** Non-randomised and exploratory studies are excluded. This is a
design decision, not a convenience: the cross-study specification grid in section 5.1 is only
interpretable if the studies share a structure (two arms, a designated primary outcome,
baseline and follow-up), and randomisation is what makes covariate adjustment an efficiency
choice rather than a causal assumption. In observational designs, varying the covariate set
produces branches that estimate different quantities, so a multiverse would conflate
disagreement about causal structure with analytic fragility. The 26 non-randomised studies in
the corpus are reported as an excluded set with reasons, and are the obvious subject of a
separate paper.

**Eligibility for stages 2 and 3.** A study enters if all of the following hold:
(a) a randomised controlled trial in physiotherapy, rehabilitation or
exercise therapy; (b) individual-participant data publicly downloadable without an
application or data-use agreement; (c) the primary outcome and group allocation are
identifiable in the data; (d) the published methods describe the primary analysis in
enough detail to reconstruct it. Each criterion is coded by two assessors independently;
disagreements are resolved by discussion, and by `[third assessor]` if unresolved.

## 3. Stage 1 — feasibility

**Outcome.** The proportion of studies passing each eligibility criterion, reported as a
funnel with counts at every step, plus reasons for exclusion.

**Prespecified definitions** (these determine the headline number and are therefore fixed
here):
- *Primary analysis*: the analysis of the outcome the article designates as primary. If
  several co-primary outcomes are named, all are attempted and the study counts as
  reproduced only if all reproduce.
- *Publicly deposited*: retrievable without contacting anyone and without an application.
  Data behind a request form count as not deposited.
- *Individual-participant data*: one row per participant, containing outcome and arm.
  Group-level summary tables do not qualify.
- *Sufficient method detail*: two assessors independently judge that the analysis could be
  written from the methods section without guessing the model family, the covariate set or
  the handling of repeated measures.

**No author contact.** We do not email authors. This is a deliberate design choice: prior
audits collapsed at that step (2/65 in surgery, JAMA Netw Open 2022; 22.7% compliance in
rehabilitation, Elghzali et al. 2025). Our denominator is what a reader can obtain unaided.

## 4. Stage 2 — computational reproduction

**Outcome.** For each eligible study, whether the published primary effect estimate is
recovered.

**Tolerance.** A discrepancy exceeding 10% of the reported point estimate counts as a major
numerical discrepancy, following Hardwicke et al. (R Soc Open Sci 2021, doi
10.1098/rsos.201494). Discrepancies in the second decimal place that do not change the
reported conclusion are recorded as minor.

**Classification.** Each study is assigned to exactly one class: fully reproduced; reproduced
with minor discrepancies; major discrepancy; not reproducible (data or code insufficient).

**Rules.**
- Where analysis code is deposited, it is run as provided before any reimplementation. Both
  outcomes are recorded separately.
- We do **not** judge whether the original analysis was appropriate. A study reproduces if
  we obtain the reported number by the reported method, even where we consider that method
  suboptimal.
- Every reproduction is performed independently by two analysts and reconciled.
- All deviations from this protocol are logged with date and reason and reported.

## 4b. Data integrity screen — before any multiverse

Holding individual-participant data is what makes forensic checks possible at all. Carlisle
(*Anaesthesia* 2021, doi 10.1111/anae.15263) analysed 526 submitted trials: with access to
individual data, 67 of 153 (44%) contained false data, against 6 of 373 (2%) without it,
odds ratio 47 (95% CrI 17–144). A multiverse uses none of this. Worse, without a prior
integrity check a fabricated dataset would enter stage 3 and its instability would be
reported as analytic fragility.

We therefore screen before, not after:

- Baseline distribution check on continuous baseline variables (Carlisle 2017, doi
  10.1111/anae.13938), applying the caveats of Bolland et al. (*J Clin Epidemiol* 2019):
  the uniformity assumption holds for continuous variables but not for categorical ones,
  and rounding distorts.
- GRIM where means of integer-bounded scales are reported (Brown & Heathers, doi
  10.1177/1948550616673876), via the `scrutiny` package.
- Terminal digit and duplication checks on the individual records.

Studies failing the integrity screen are reported separately and excluded from stage 3,
with the reason stated. We report the count. We make no allegation about any individual
study; the screen flags patterns warranting caution, nothing more.

`[Note: INSPECT-IPD, the individual-data variant of the INSPECT-SR trustworthiness tool,
exists as a protocol preprint (doi 10.64898/2026.02.06.26345217). Check before submission
whether a usable instrument has been released; if so, prefer it over an ad hoc screen.]`

Relevant context for the discussion: INSPECT-SR stage 2 found **no relationship** between
trustworthiness assessment and risk of bias or GRADE (*J Clin Epidemiol* 2025, doi
10.1016/j.jclinepi.2025.111824). Established quality instruments do not detect these
problems, and a multiverse sits on the same axis as GRADE.

## 5. Stage 3 — multiverse

Following Brodeur et al., who state that their own reanalyses "should thus all be considered
as not pre-registered" because implementable robustness checks cannot be known before
opening the replication package, we register the **grammar** of the multiverse now and the
**enumerated pipelines** later.

### 5.1 Fixed now: decision nodes and options

The same node set is applied to every study. This is the substantive difference from prior
reanalysis audits, where robustness checks were chosen ad hoc per study and therefore cannot
be aggregated.

Every node is classified E, N or U in the sense of Del Giudice & Gangestad (2021). Only
type E nodes form the core multiverse. Type N nodes vary the estimand rather than the
method and are reported as a separate arm. Type U nodes are reported separately.

**Core multiverse — type E, equivalent under randomisation**

| Node | Options | Why equivalent |
|---|---|---|
| Baseline handling | follow-up only · change score · ANCOVA with baseline covariate | Under randomisation all three are unbiased for the same average treatment effect and differ only in precision (Vickers & Altman, *BMJ* 2001, doi 10.1136/bmj.323.7321.1123) |
| Covariate adjustment | none · baseline outcome only · published set · published set plus prespecified prognostic variables present in the data | Randomisation makes adjustment an efficiency choice, not a confounding correction. **Continuous outcomes only**: for odds ratios and hazard ratios adjusted and unadjusted estimands differ by non-collapsibility, so for such outcomes this node moves to the N arm |
| Inference | model-based SE · heteroscedasticity-robust SE · permutation | Same estimand, different route to the interval |

Core size: 3 x 4 x 3 = **36 specifications** per study.

**Estimand-varying arm — type N, one option has justified precedence**

| Node | Options | Why not equivalent |
|---|---|---|
| Analysis population | ITT · per-protocol · as-treated | Treatment-policy versus hypothetical strategy, ICH E9(R1). Different questions (Kahan et al., The estimands framework: a primer on the ICH E9(R1) addendum, *BMJ* 2024, doi 10.1136/bmj-2023-076316) |
| Missing data | complete cases · LOCF · multiple imputation | MI has precedence under MAR; LOCF is deprecated |
| Time point | published primary endpoint · longitudinal model over all reported time points | Effect at one time versus averaged over time |
| Stratification factors | omitted · included | Guidance says include randomisation strata |

**Flagged arm — type U, precedence unclear**

| Node | Options |
|---|---|
| Outliers | none removed · `[prespecified rule]` |
| Transformation of a skewed outcome | none · `[rule]` |

**The split is itself a finding.** Reporting the core and the estimand-varying arm
separately distinguishes *analytic fragility*, the same question answered different ways,
from *estimand ambiguity*, different questions dressed as robustness checks. Existing
multiverse analyses conflate the two. A principled multiverse is smaller than an
unprincipled one: 36 core specifications sits well below the literature median of 144
(Nepomuceno et al. 2026), and that is the point.
`[Adjust this table before submission. Every option must be defensible in the sense of
Del Giudice & Gangestad (AMPPS 2021, doi 10.1177/2515245920954925): included options are
equivalent (type E) with respect to validity, target estimand and precision; non-equivalent
options (type N) are excluded; uncertain options (type U) are flagged and reported
separately.]`

> **Warning — this table as drafted is probably wrong.** For clinical trials most of the
> interesting branches are type N, not type E. Intention-to-treat versus per-protocol,
> complete cases versus multiple imputation, and follow-up value versus change score are in
> part *different estimands* in the sense of ICH E9(R1), not robustness variants of one
> estimand (Kahan et al., *BMJ* 2024, doi 10.1136/bmj-2023-076316). Del Giudice &
> Gangestad's central warning applies directly: a multiverse padded with poorly justified
> alternatives can *hide* a real effect. Before submission, each row must be classified E,
> N or U, type N rows either dropped or reported as a separate estimand-varying arm, and the
> classification recorded. This is the single decision on which the paper's credibility
> rests.

### 5.2 Non-applicable nodes

Where a node cannot be instantiated in a given study (no repeated measures, no covariates
recorded, no missingness), the node is marked *not applicable* for that study, the reason is
recorded, and the multiverse for that study is the product of the remaining nodes. The
number of studies per node with a non-applicable marking is reported.

### 5.3 Fixed later, before computation

After the data package for a study is opened and before any specification is computed, the
enumerated list of implementable pipelines for that study is deposited as a timestamped
addendum to this registration, generated with SMART (Short et al., R Soc Open Sci 2025,
doi 10.1098/rsos.250800; app at apps.meta-rep.lmu.de/SMART/).

### 5.4 Corpus selection test

Our corpus consists only of studies that shared data, which is itself a selection.
Trials contributing individual data are measurably better conducted: more recent, larger,
more often with adequate allocation concealment (Tsujimoto et al., *J Clin Epidemiol* 2020,
doi 10.1016/j.jclinepi.2019.10.004). The same study found no data-availability bias on the
effect axis, ratio of odds ratios 1.01 (95% CI 0.86–1.19), and the older claim that data
sharers report weaker evidence (Wicherts et al. 2011) failed to replicate twice (Nuijten et
al., *Collabra* 2017; Claesen et al., *PLOS ONE* 2023).

Our reproducibility rate is therefore plausibly an upper bound and our fragility estimate a
lower bound. Two things are prespecified to address this:

1. **Within-corpus comparison.** Studies that shared voluntarily are compared against those
   sharing under a journal policy. If multiverse fragility is comparable in both groups, the
   selection account is weakened. This costs no additional data collection.
2. **Naudet convention.** The headline reproducibility figure is additionally reported with
   non-available studies counted as not reproducible, which makes the effect of the
   selection visible (cf. Siebert et al., *BMC Medicine* 2022, where this convention moved
   the rate from 46% to 16%).

No method exists to extrapolate formally from a self-selected corpus to the field. We do not
claim one.

### 5.5 Summary measures

All estimates are standardised as d = estimate / residual SD before any cross-specification
summary. Estimates from specifications on different outcome scales (raw versus log) are not
comparable, and their central tendency would be, in Del Giudice & Gangestad's words,
"misleading or virtually meaningless".

Fixed in advance:
- the **distribution of d** per study: median, full range, interquartile range
- the proportion of specifications agreeing in sign with the published estimate
- the proportion of specifications whose estimate exceeds the published **MCID** for that
  instrument, and the proportion whose interval excludes it
- across studies, the distribution of these quantities, and which decision nodes account for
  the dispersion (Type II sums of squares; Type I is order-dependent and invalid here because
  dropping incoherent combinations leaves options unequally represented)
- s-values (Rafi & Greenland, BMC Med Res Methodol 2020) as a continuous evidence scale

**We do not report the proportion of "statistically significant" specifications as a primary
measure.** Wasserstein, Schirm & Lazar (The American Statistician 2019, doi
10.1080/00031305.2019.1583913) put it plainly: don't say "statistically significant", and
don't use a threshold to declare a result. Reducing multiverse variability to a binary verdict
also "risks oversimplifying the uncertainty that multiverse analysis aims to make transparent"
(Short et al. 2026, citing Goetz et al. 2024). Where the count of threshold-crossing
specifications appears at all, it is descriptive, secondary, and the labels are written in
quotation marks as what they are: verdicts produced by a convention, not properties of an effect.

**Possibilistic, not probabilistic.** The spread across specifications is possibilistic
uncertainty. A result occurring more often in the multiverse is not thereby more likely to be
correct (Sarma et al. 2024, via Short et al. 2026). Summary statistics describe the space of
defensible results; they are not estimates of a parameter, and they are labelled as such.
In addition to these descriptive measures we prespecify two inferential steps, because
89.5% of published multiverse analyses stop at description (Nepomuceno et al. 2026):
a pooled estimate with an honest interval via single-dataset meta-analysis (Bartos,
Hoogeveen, Sarafoglou & Pawel, arXiv 2511.17064 — preprint status to be disclosed), and
multiplicity control across specifications via minP (Mandl et al., *BMC Med Res Methodol*
2024, doi 10.1186/s12874-024-02279-2). A plain meta-analysis over specifications of the
same dataset would be overconfident, since it reuses the same information repeatedly.

**No specification is nominated after the fact as the correct one.** The published estimate
is compared against the specification distribution by locating it within that distribution.
We do not compare confidence intervals of the published estimate and of any multiverse
summary for overlap; where a difference is quantified, it is estimated as a distribution of
the difference itself.

### 5.6 Stopping rule

If fewer than 10 studies reach stage 3, the multiverse is reported as an illustrative case
series and stages 1 and 2 carry the paper. This is decided by the count alone, before any
multiverse result is inspected.

## 6. Prior contact with the data

Parts of the corpus were inspected before this registration.

`[Initials]` inspected publications and deposit listings for n = `[X]` studies between
`[date]` and `[date]` to assess feasibility. What was inspected: whether a dataset is
findable and machine-readable, and whether the published primary analysis appears
reconstructible from the methods section. File listings were retrieved via repository APIs;
`[k]` datasets were downloaded; `[j]` reproduction attempts were begun and completed.

Appendix `[X]` lists these studies individually with study ID, download date, reproduction
date and result. They are flagged `prior_contact` in the dataset, and every main result is
additionally reported excluding them.

No other studies were downloaded or recomputed before this registration. The decision nodes
and option sets in section 5.1 were formulated without knowledge of any multiverse result.
For the `[j]` studies with prior contact we know the published result and our reproduction
result, but not the behaviour of alternative specifications. Prior knowledge is stated per
author below.

`[Per-author statement, following van den Akker et al., Meta-Psychology 2021,
doi 10.15626/mp.2020.2625, items Q8, Q17 and Q18.]`

## 7. Deviations

Any departure from this protocol will be logged with date and reason and reported in the
manuscript, distinguishing confirmatory from exploratory analyses.

---

### Key references

Brodeur A, et al. Reproducibility and robustness of economics and political science research.
Nature 2026;652:151-156. doi 10.1038/s41586-026-10251-x
Naudet F, et al. BMJ 2018;360:k400. doi 10.1136/bmj.k400
Hardwicke TE, et al. R Soc Open Sci 2018;5:180448 · 2021;8:201494
Jabouille F, et al. medRxiv 2025. doi 10.1101/2025.09.23.25336497
Elghzali A, et al. BMC Med Res Methodol 2025. doi 10.1186/s12874-025-02587-1
Del Giudice M, Gangestad SW. AMPPS 2021;4. doi 10.1177/2515245920954925
Short CA, et al. R Soc Open Sci 2025;12:250800. doi 10.1098/rsos.250800
Steegen S, et al. Perspect Psychol Sci 2016;11:702-712. doi 10.1177/1745691616658637
Simonsohn U, Simmons JP, Nelson LD. Nat Hum Behav 2020. doi 10.1038/s41562-020-0912-z
van den Akker OR, et al. Meta-Psychology 2021. doi 10.15626/mp.2020.2625
Nepomuceno A, Ghosal A, Sandoval-Lentisco A, Ioannidis JPA. Preprint 2026.
doi 10.64898/2026.07.15.738584
