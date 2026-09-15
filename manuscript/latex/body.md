## Introduction

Computational reproduction of published research at scale has been demonstrated where
journals require authors to deposit data and code. Brodeur and colleagues reproduced 110
articles from economics and political science journals with mandatory data and code
policies and found more than 85% of them computationally reproducible. Of the
estimates the original authors called "statistically significant", 72% remained
"significant" with the same sign under robustness checks chosen by the reproducers \cite{Brodeur_2026}. A policy that is not verified
at submission does less: under the data and code policy of Science, artefacts could be
obtained for 44% of a sample of articles and results reproduced for 26% \cite{Stodden_2018}.
Biomedical audits have stalled one step earlier.
Naudet and colleagues identified 37 randomised trials published under the data-sharing
policies of the BMJ and PLOS Medicine, obtained data for 17, reproduced the primary
result fully in 14 and reached the same conclusion in 16 \cite{Naudet_2018}. For trials
assessed by the European Medicines Agency, Siebert and colleagues could reanalyse 10 of 62
(16%) \cite{Siebert_2022}. In psychology, about a third of the datasets shared under the
mandatory policy of Cognition were not reusable \cite{Hardwicke_2018}. Among articles with
reusable data and an open data badge at Psychological Science, the obstacle to
reproduction was unclear reporting of the analysis \cite{Hardwicke_2021}.

Physiotherapy and rehabilitation have no data-sharing mandate. Elghzali and colleagues counted data availability statements in 1 278 articles from
the five rehabilitation journals with the highest impact factors: 25.5% of articles
carried one. The figure depends on journal policy, because one journal that requires
a statement had one in 99% of its articles and the other four together in 5%. A
statement is not a deposit. None of these journals requires deposition of data or code
\cite{Elghzali_2025}. In the journals of four national physiotherapy
associations, 12% of 465 articles made data directly available. The authors recommend
a default open data policy that the field does not yet have \cite{Jabouille_2025}. When authors of rehabilitation studies whose availability statements
promised data on request were asked, 22.7% complied \cite{Elghzali_2025}. In sports and
exercise science, 14% of authors provided raw data on request. Of attempted
replications, 28% succeeded \cite{Murphy_2025}. Dhanani and colleagues recomputed the statistics of
572 trials from the numbers printed in the articles, without individual data
\cite{Dhanani_2022}. To the best of my knowledge, no published or registered study in physiotherapy,
rehabilitation or exercise science has retrieved individual participant data from public
repositories and recomputed the published primary analysis. I searched Europe PMC,
OpenAlex and the OSF registry index on 15 September 2026 for combinations of
reproducibility, reanalysis, multiverse, specification curve and many-analysts terms
with terms for these fields and for individual, raw or shared data; the queries and
their results are documented in the Supplement. The nearest neighbour is a registered
report from the German Sport University Cologne that plans to recompute the primary
analyses of 50 articles in the Journal of Sports Sciences from raw data shared privately
by the authors \cite{Nolte_2026_reg}, alongside a preprint by the same group on data and code
availability in sports science \cite{Nolte_2026_preprint}. Reproducibility in this literature usually
means whether a clinician can reproduce an exercise programme from its description. I
mean computational reproducibility, the recovery of the published number from the
published data and methods.

A recomputed estimate answers one question: was the reported number obtained by the
reported method. A second question is how far the number depends on choices that the
method leaves open. Multiverse analysis and specification curve analysis address this
question by computing every defensible combination of analytical choices \cite{Steegen_2016,Simonsohn_2020}. The method is popular and loosely applied. Of 613 multiverse-style
studies, the median study computed 144 specifications. Among the 152 coded in depth,
8.6% were preregistered, 3.9% discussed whether their specifications were equivalent or
defensible, and 82.2% reported the results descriptively without any inferential summary
\cite{Nepomuceno_2026}.
Del Giudice and Gangestad showed that a multiverse padded with options that are not
equivalent can obscure a real effect. They proposed classifying each decision into three
types. A Type E decision has options of comparable validity that examine the same effect
and estimate it with comparable precision. A Type N decision has one option with
justified precedence, or options that answer different questions. A Type U decision is
one where equivalence is uncertain \cite{Del_Giudice_2021}. Short and colleagues separate the
defensibility of a single pipeline from the equivalence of pipelines with one another,
and warn that a multiverse whose pipelines produce nearly identical datasets creates an
illusion of consistency \cite{Short_2026}. In a simulated behavioural trial, Veltri found that
preprocessing choices explained 76.9% of the variance of the effect estimate and model
choices 7.5%, but the simulation did not separate choices that change the estimand from
choices that do not \cite{Veltri_2025}. Crenshaw and colleagues applied the multiverse
approach to one clinical trial \cite{Crenshaw_2026}. The epidemiological version of the same
question, vibration of effects, has been studied for observational associations
\cite{Patel_2015,Klau_2020}. Studies in which many analysts receive the same data have
shown how far conclusions vary between competent analysts \cite{Silberzahn_2018,Botvinik_Nezer_2020,Breznau_2022,Gould_2025}. None of these applied one prespecified,
equivalence-classified grid to a corpus of trials.

I asked four questions. First, of trials in exercise, rehabilitation and physiotherapy
with publicly deposited data, in how many can the published primary analysis be
identified in the data and recomputed by a reader who contacts no one? Where is the
loss? Second, does the published primary estimate reproduce? Third, over a prespecified
grid of choices classified as equivalent, how far does the standardised effect move, and
which choice moves it? Fourth, how much range does a wider grid of defensible but
non-equivalent choices add? Through which choices? I also record which reporting
features of the papers obstructed reproduction and report how often my own first
mapping of published analyses onto deposited data was wrong before I fixed rules for it.


## Methods

### Design and transparency

I conducted a meta-research audit of randomised trials in exercise, rehabilitation and
physiotherapy that had deposited individual participant data in a public repository.
The audit has three stages. Stage 1 asks in how many trials the published primary
analysis can be identified in the deposited data and recomputed without contacting
anyone. Stage 2 asks whether the published primary estimate reproduces. Stage 3 applies
the same prespecified grid of analytical choices to every trial and measures how far the
estimate moves.

The audit was not preregistered. The grid of decision nodes was written on 28 August
2026, before any specification was computed. The rules that map a published analysis
onto the deposited data (section 2.3) were fixed after I had extracted the published
analyses from all candidate papers and before the final computation. Three changes to
the grid were made after the first complete run had been inspected. The strict grid of
section 2.6 was added. Outlier rules, which had been a core node, were moved to a
sensitivity arm after a winsorising rule on a bounded outcome had produced a range of
1.08 standard deviations in one trial. The core grid was renamed from principled to
estimand-preserving once the precision criterion of Del Giudice and Gangestad had been
applied to baseline handling. All three are stated where they matter. All results
were inspected before this manuscript was written. Brodeur et al. state that their own
reanalyses "should thus all be considered as not pre-registered" because the
implementable checks cannot be known before a replication package is opened
\cite{Brodeur_2026}. The same applies here. Section 3.5 reports what the
rule-based mapping changed relative to my first, ad hoc mapping. The transparency
items proposed by van den Akker et al. for secondary data analysis are addressed in
Supplement Text S1 \cite{Van_den_Akker_2021}. Code, the trial registry, the grid definition and
all outputs will be deposited in a public repository on acceptance.

### Corpus

I searched Europe PMC on 27 August 2026 for open-access articles with
physiotherapy, rehabilitation or exercise-therapy terms in the title or abstract, a
clinical design (publication type randomised controlled trial, clinical trial or
observational study, or corresponding title terms), and a repository term anywhere in
the full text. The search returned 423 records. For each record I retrieved the JATS
full text and extracted the data- and code-availability statement. A record was
retained when a repository URL appeared inside that statement. Counting URLs anywhere in
the full text had inflated an earlier pass with citations of software repositories.
Restricting the count to the availability statement removed most apparent matches, which had been citations of software repositories rather than deposits. The restricted count gave 152 studies, 91 of them
randomised trials. Data supplied only as a journal supplementary file, without a
repository link, were not captured by this route.

For every retained study I queried the application programming interfaces of OSF,
Zenodo, Dryad and figshare, listed the deposit and classified files by extension. A
deposit counted as reachable when a file list was returned and as containing data when
at least one tabular file (csv, xlsx, sav, rds or similar) was present.
The deposit probe left 84 reachable deposits, 74 with a tabular file, 48 of them
randomised trials. These 48 were downloaded and assessed by hand.

A second search route, querying Zenodo and Dryad directly for clinically relevant
deposits, returned 127 study-like deposits. These were not matched to articles for this
report and are discussed as an extension in section 4.7.

### Eligibility and mapping rules

A trial entered stages 2 and 3 when four conditions held. It was a randomised trial of an
exercise, rehabilitation or physiotherapy intervention. Individual participant data were
downloadable without application or data-use agreement. The primary outcome and the
allocation were identifiable in the data. The published methods described the
primary analysis in enough detail to reconstruct it. Group-level summary tables did not
count as individual data. I did not contact authors.

Design exclusions were applied to all 48 trials in the same way. Crossover and
within-person designs were excluded because the grid assumes parallel groups. A binary
primary outcome was excluded because the grid is built for continuous outcomes. The other
exclusions were feasibility studies whose primary aim was recruitment or retention,
studies without a clinical or training intervention, non-randomised studies and
secondary analyses of an included trial that report no arm contrast. Every exclusion is recorded with its category and reason in Supplement Table
S1.

Mapping a published analysis onto deposited data requires decisions about which variable
is the primary outcome, which timepoint is primary, which value of the group variable is
the control arm, and which covariates entered the published model. My first mapping
made these decisions study by study. After the published analyses had been extracted
from all 21 candidate papers with verbatim quotations, I fixed eight rules and rebuilt
the mapping under them. The primary outcome is the one named in the trial registration,
retrieved from the registry for every trial with a registration identifier. Failing that,
it is the one the paper calls primary, then the outcome of the sample-size
calculation, then the first outcome reported in the abstract. The source is
recorded for each trial. A paper whose headline outcome is not the registered primary
outcome of its trial is a secondary report. The primary timepoint is the one the paper designates, otherwise
the first follow-up after the end of the intervention. When the primary outcome or its
timepoint is absent from the deposit, the trial is excluded. No substitute outcome is
used. The control arm is the arm the paper describes as control, placebo, sham,
wait-list or usual care. Its code in the data is verified through value labels or, when
labels are absent, by matching group sizes and baseline means against the paper's first
table. Covariates are those that appear as adjustment terms in the published primary
model. Variables tested only for baseline balance do not count. Each paper is classified
as a primary report, which reports the trial's prespecified primary analysis, or a
secondary report, which presents an exploratory or secondary analysis with its own
headline estimate. Field and population are coded for each trial. The mapping was done by one coder.

### Stage 2: computational reproduction

From each included paper I extracted the published primary estimate, its interval and
p-value, and the specification of the published analysis (baseline handling, covariate
set, analysis population, missing-data strategy, model family, standard-error method,
transformation), each with a verbatim quotation. Where a paper reported only a test
statistic or a p-value, the trial was classed as having no point estimate. Two documented
adjustments were made to the extracted values. For the time-restricted eating trial the
published primary estimate is the time-by-group interaction of a mixed model, reported as
control minus intervention. I use it with the sign of my convention. For the
phosphatidic acid trial the value first extracted was an F statistic. The trial was
reclassed as having no point estimate.

For each of the 12 trials with a point estimate I then fitted the published analysis as
the paper describes it, in a separate script outside the multiverse grid. Where the paper
reports an analysis of covariance, that was fitted. For the cluster-randomised FREE trial
this was a linear mixed model with random intercept and slope for practitioner and the
prespecified covariates present in the deposit. For the balance feedback trial it was a
mixed model over all four measurement occasions on the logarithmic scale, with the
authors' deposited code. TERECO was analysed with a constrained longitudinal analysis.
The deload trial was fitted with a Bayesian multilevel model with default priors, because
the paper states none. The water exercise trial was analysed with multiple imputation
with 20 imputations, because the paper does not state the number. For the frozen
shoulder trial it was a repeated-measures analysis of covariance over the two short-term
follow-ups, approximated as a mixed model. Where a detail was not
stated, the script records the assumption. Agreement was classified by the rule fixed
before any computation: full when the recomputed estimate had the same sign and differed
by at most 2% from the published one, or by less than half a unit of the last printed
digit, a minor discrepancy at most 10%, a major discrepancy otherwise \cite{Hardwicke_2021,Naudet_2018}. The absolute difference in pooled standard
deviations of the raw outcome, whether the recomputed 95% interval contains the published
estimate, and whether the p-value falls on the same side of 0.05 are reported for every
trial without thresholds. I did not judge whether the published analysis was
appropriate.

Separately, to locate the published estimate in the multiverse of section 2.6, each
published specification was matched to the grid specification agreeing with it on the
largest number of nodes. Published model families absent from the grid counted as
non-matches. Ties were broken by the estimate closest to the published one and are
reported. The percentile of the published estimate in the distribution of the
estimand-preserving grid is given where both are on the same scale.

### Data integrity screen

Before any multiverse was computed, each dataset was screened for patterns that would
make a fragility analysis meaningless. For every continuous baseline variable named in
the paper I computed a one-way analysis of variance p-value for the difference between
arms. Under correct randomisation these p-values are uniform \cite{Carlisle_2017}. They were
combined by Stouffer's method, which suits a two-sided question better than Fisher's
combination because arms that are too similar and arms that are too different are both
of interest. A combined value below 0.005 or above 0.995 was treated as a triage flag,
not as a verdict. The test was applied to continuous variables only. Bolland et al.
showed that rounding distorts the distribution of these p-values \cite{Bolland_2019}. The
deposited baseline variables are rounded to varying degrees, which I did not correct. Duplicate rows over all numeric columns were counted. A terminal-digit
test on the outcome was computed but not used for flagging, because several primary
outcomes are derived means whose terminal digits are structurally non-uniform. Flagged
trials would have been excluded from stage 3 and reported separately. The named-variable
component requires at least two continuous baseline variables named in the paper and
present in the deposit. A broader search over all deposited variables whose names
indicate a baseline measurement was computed for every trial with such variables and is
reported in the Supplement, but was not used for flagging because it includes variables the paper did
not treat as baseline characteristics.

### Stage 3: the grids

The multiverse varies six decision nodes (Table 1). Following Del Giudice and Gangestad,
each node was classified before computation as Type E, Type N or Type U. A Type E node
has options of comparable validity that examine the same effect and estimate it with
comparable precision. A Type N node has one option with justified precedence, or options
that examine different effects. A Type U node is one where equivalence is uncertain
\cite{Del_Giudice_2021}. I depart from this scheme in
one respect and say so. The three ways of handling the baseline value, follow-up value,
change score and analysis of covariance, estimate the same mean difference under
randomisation but not with the same precision: analysis of covariance is more efficient
than the change score, which is more efficient than the follow-up value when baseline and
outcome are correlated \cite{Vickers_2001,Senn_2006,Van_Breukelen_2006}. Under a strict
reading, precedence goes to analysis of covariance and the node is Type N. I kept the
node in the core grid because none of the three changes the quantity estimated, which is
the criterion the grid is named for. I call that grid estimand-preserving. The
strict grid without it shows what the precision criterion removes.

Three grids are reported. The estimand-preserving grid varies baseline handling, the
covariate set (none, the stratification factors, or the published set) \cite{Kahan_2014,Kahan_2012}, the model family (linear model, or a random intercept for a cluster variable
where one is estimable) and the inference method (model-based standard error,
heteroscedasticity-consistent HC3 standard error, or a permutation test with 4 999
permutations). The strict grid fixes baseline handling to analysis of covariance where a
baseline exists and varies the remaining three nodes. The defensible grid, in the sense
of Short et al. \cite{Short_2026}, adds two Type N nodes. The first is the missing-data
strategy. Its options are complete cases, last observation carried forward where a
baseline exists, or multiple imputation by predictive mean matching with 20 imputations,
Rubin's rules and Barnard and Rubin degrees of freedom. This node is Type N on both
criteria, because complete cases and imputed data target different populations once
dropout is informative and because imputation has justified precedence under a
missing-at-random assumption \cite{White_2011}. The second is logarithmic transformation of
outcome and baseline, which estimates a ratio of geometric means. The difference between the
defensible and the estimand-preserving grid is a result of the audit, not a robustness
check.

Outlier rules were part of the original grid as a Type E node with pooled winsorising at
3 standard deviations, 1.5 interquartile ranges or 3 median absolute deviations. No paper
in the corpus reports an outlier rule, so the node fails the criterion of use in the
literature. Winsorising also changes the quantity estimated. The node was reclassified as
Type U, removed from the three grids, and computed as a separate sensitivity arm, which
is reported because it illustrates what an unclassified option can do to a bounded
outcome.

An option was dropped for a trial when it could not change the data: missing-data
options without missing outcomes, cluster models without an estimable cluster variable,
logarithms of non-positive values, last observation carried forward without a baseline.
For trials deposited in long format the baseline was taken from the row at the baseline
timepoint. HC3 and permutation inference are defined only for the linear model, and
permutation is not combined with multiple imputation. Multiple imputation used one set of
imputed datasets per trial and transformation, shared by all specifications, so that
Monte Carlo variation between imputation runs does not count as specification variation.
Specifications that returned identical estimate, standard error and p-value were
collapsed to one. The share of collapsed duplicates is reported. Non-applicable nodes
and the number of nodes that vary are counted per trial, because a share of 100% for one
node in a trial where no other node can vary is not a finding.

### Summary measures

Estimates from different specifications are comparable only on a common scale. Every
estimate was divided by the pooled within-group standard deviation of the raw outcome at
the primary timepoint, computed once per trial before any preprocessing, which gives a
standardised difference d in the convention of Cohen's d and Hedges' g. The residual
standard deviation of the fitted model was not used, because it changes with the
specification and would manufacture range. Specifications on the logarithmic scale were
standardised with the pooled standard deviation of the logarithmic outcome and were never
pooled with raw-scale specifications.

The primary summary is the displacement of the published result. For each trial with a
point estimate, the estimate recomputed in stage 2 is standardised on the same scale as
the grid and taken as the anchor. Every specification is expressed as the difference
between its d and the anchor. Per trial and grid I report the median, the range and the
largest absolute displacement, the share of specifications within 0.1 standard
deviations of the anchor, and whether any specification reverses the sign of the
published estimate. Trials whose paper reports no point estimate have no anchor and are
described by the distribution of d alone. As secondary description, for each trial and
grid I report the median, interquartile range and range of d over unique
specifications, together with the share of specifications whose sign agrees with the
median. I also report the share with |d| above 0.2, Cohen's convention for a small
effect, since instrument-specific minimal important differences were not available for
every outcome. The s-value, the negative base-2 logarithm of the p-value, is given as a
continuous measure of evidence against the test hypothesis \cite{Rafi_2020}, as is the
percentile of the published estimate in the distribution of d. The permutation p-value cannot fall below 1 in 5 000, which caps the
s-value of permutation specifications at 12.3 bits. I do not report the share of
"statistically significant" specifications as a primary measure \cite{Wasserstein_2019}.

To identify which node moves the estimate, I fitted for each trial and grid an additive
linear model of d on all varying nodes and partitioned the explained variance by Type II
sums of squares, which do not depend on the order of terms in an unbalanced grid. The
same partition was computed for the standardised width of the 95% interval, because
inference options change the interval but not the estimate. Removing incoherent
combinations confounds some node pairs, in particular model family with inference method.
As a sensitivity analysis I refitted the model with all two-way interactions in the ten
trial-by-grid combinations with at least 30 specifications and checked whether the node
with the largest share changed. The number of trials in which only one node can move the
estimate is reported, because a share of 100% in such a trial is not a finding.

Empirical similarity of the preprocessed datasets was measured by the Pearson correlation
between the outcome vectors of every pair of preprocessing pipelines of a trial. Where
all pairs exceed 0.99, the pipelines barely change the data. Stability of the sign
is then not evidence of robustness \cite{Short_2026}. Descriptive correlates of the principled
range (sample size, standardised baseline imbalance, baseline-outcome correlation,
share of missing outcomes) are given as Spearman coefficients over 16 trials without
tests.

Proportions are reported with Wilson 95% intervals. Medians over trials are reported with
95% intervals from 5 000 bootstrap resamples of trials, not of specifications. Confidence intervals of the published estimate
and of any multiverse summary were not compared for overlap. Pooled estimation over
specifications \cite{Bartos_2025_arXiv} and multiplicity control over specifications
\cite{Mandl_2024} were not performed.

Analyses used R 4.6.0 with the packages dplyr, readxl, haven, lme4, lmerTest, sandwich,
lmtest, mice and car.


## Results

### Feasibility

Figure 1 shows the corpus. Of 423 records, 152 had a repository link inside the
availability statement (91 randomised trials). Two losses followed. The first is the
availability loss. In this step 68 deposits could not be retrieved through the repository
interfaces, mostly because of truncated or dead links. A further 10 reachable deposits
contained no tabular file. Of the remaining 74 studies, 26 were not randomised. This left 48 randomised
trials with a readable data file, 32% of those with a link. The second loss occurred
after the data had been opened. Of the 48 trials, 17 were excluded for design (crossover
5, not a clinical or training intervention 4, feasibility as the primary aim 3, not
randomised on inspection 2, within-person allocation of limbs 2, binary primary outcome
1), 11 because the deposited data could not support the published primary analysis
(allocation not identifiable 3, primary outcome not identifiable 2, outcome present only
as raw electrophysiological or inertial signals 2, primary timepoint absent 1, summary
table instead of individual data 1, README without data 1, file not machine-readable 1),
2 because the paper reported no arm contrast (a network analysis and a mediation
analysis), and 2 as secondary analyses of a dataset already included. In 11 trials the
deposit could not support the published analysis. In eight of them the data were
individual and readable.

Sixteen trials entered stages 2 and 3, 33% of the 48 assessed (Wilson 95% interval 22 to
47%) and 11% of the 152 with a link (7 to 16%). Twelve are primary reports. Four analyse
an outcome that the trial registration lists as secondary (an exploratory balance
analysis, a psychological outcome of a pregnancy exercise trial, postpartum depression
in a water exercise trial, and voluntary muscle activation in a neuromodulation trial
whose registered primary outcome, muscle strength, is not in the deposit). Deposits were hosted on OSF (7),
Zenodo (6) and Dryad (3). Two contained analysis code alongside the data. Six trials are
physiotherapy or rehabilitation trials in patients or survivors, one a neuromodulation
trial in patients, one a corticosteroid injection trial for frozen shoulder, six
training or nutrition trials in healthy adults, and two exercise trials in pregnancy.
Eight interventions were delivered by physiotherapists. The trials randomised 18 to 404
participants. The number analysable for the primary contrast in the estimand-preserving
multiverse ranged from 16 to 276. The fitted published models used 20 to 373
observations.

### Reproduction

Twelve of the 16 papers report a point estimate for the primary arm contrast. Fitting the
published analysis as described recovered it fully in 11 (92%, Wilson interval 65 to
99%) and with a major discrepancy in 1 (Table 3). The absolute difference between
published and recomputed estimate had a median of 0.001 standard deviations and a
maximum of 0.014. Ten estimates agree with the published value to the precision at which it was
printed. The one major discrepancy is the deload trial (18%, 0.014 standard
deviations), whose published Bayesian multilevel model states neither priors nor seed.
My fit with default priors gives −0.51 against −0.63, with credible intervals that
overlap almost entirely. In all 12 trials the recomputed 95% interval contains the
published estimate. In the 8 trials that report a p-value and for which a
frequentist p-value exists, the recomputed value falls on the same side of 0.05. One paper did not report an interval for the primary estimate and three did not report a
p-value. The test statistics of the four papers without a point estimate are treated
below. Four of the 12 reconstructions rest on an assumption the paper leaves open: the
number of imputations in the water exercise trial, the priors of the deload model, the
estimation method in TERECO, where maximum likelihood, the software default, reproduces
the published interval to the decimal, and the implementation of the repeated-measures
analysis of covariance in the frozen shoulder trial, where the between-subject effect on
the mean of the two follow-ups reproduces the published estimate to 0.1%. The FREE trial
reproduces to 1.8% once time is entered as a factor, as the paper describes.

For the four papers that report no point estimate, the reported test statistic was
recomputed as described. The three-arm repeated-measures analysis of variance of the
Mulligan trial gives F(2,40) = 0.983, p = 0.383, as published. The mixed model of the
cluster-set trial gives the published interaction p of 0.352 and the published main-
effect F statistics of 80.67 and 95.13. The exact Mann-Whitney test of the facial palsy
trial gives p = 0.0020 and the published medians and interquartile ranges of the change
scores, once quartiles are computed as SPSS does. In the phosphatidic acid trial the
published interaction p of 0.041 reproduces, but the F statistic printed with it,
F(1,16) = 33.30, does not: the interaction F is 4.95. No term in the analysis gives
33.30. The abstract reports the same statistic as a main effect with p < 0.001. The
published p-values therefore reproduce in all four. One F statistic is misreported.

Counting every study with a repository link as the denominator, as Siebert et al. did for all sampled trials \cite{Siebert_2022}, the published primary estimate was recovered in 11 of
152 (7%, Wilson interval 4 to 12%). Counting the 48 assessed trials, it was recovered in
11 of 48 (23%,
13 to 37%).

Located in the estimand-preserving multiverse, the published estimate lies inside the
range in 9 of the 11 trials on a common scale (Wilson interval 52 to 95%). The
absolute difference from the multiverse median has a median of 0.016 standard deviations
(bootstrap interval 0.003 to 0.056). The published specification could be represented
completely in the grid in 7 of 12 trials. In 3 trials several grid specifications matched
it equally well, with a range of 0.23 standard deviations between the candidates in the
Lytras trial, whose paper does not state how the baseline entered the analysis.

### Displacement of the published result over estimand-preserving choices

The estimand-preserving grid yielded 196 unique specifications over 16 trials, between 3
and 35 per trial, after collapsing 1% exact duplicates. In 11 of the 16 trials only
baseline handling and the inference method could vary, because no covariate from the
published model or stratification factor was in the deposit and no cluster variable was
estimable. The covariate set varied in 4 trials and the model family in 2. In one
trial without a baseline measurement only the inference method varied.

Figure 2 shows, for the 11 trials with a published estimate on the scale of the grid,
how far each specification moves the standardised effect away from the reproduced
published estimate. The largest displacement per trial has a median of 0.15 standard
deviations (interquartile range 0.08 to 0.28) and a maximum of 0.41. In 5 of the 11
trials every specification stays within 0.1 standard deviations of the published
result. In none does any specification reverse its sign. The three largest
displacements, 0.41 in the deload trial, 0.39 in the spinal cord stimulation trial and
0.34 in the time-restricted eating trial, are each the distance between the published
baseline handling and one alternative, in the three trials with the largest baseline
imbalance between arms, 0.40 to 0.41 standard deviations. In the Lytras trial the
published follow-up analysis sits at the edge of its multiverse: the change-score and
covariance-adjusted alternatives move the effect by 0.10 and 0.23 standard deviations in
the same direction. Elsewhere the published estimate is central, with a median
displacement of at most 0.06 in absolute value.

The distribution of d gives the same picture. Its range per trial has a median of
0.12 standard deviations (bootstrap 95% interval 0.09 to 0.21, interquartile range 0.08
to 0.22) and a maximum of 0.41. The sign of d is the same in every specification in
all 16 trials (Wilson interval 81 to 100%). Supplement Figure S1 shows the median and
range for every trial and Figure 3 the specification curves of two trials. Baseline
handling had the largest share of the estimate variance in 14 of the 15 trials in which
any node varied (Figure 4), which in 11 of them means only that nothing else could vary.
The range is a function of baseline imbalance: the Spearman correlation between the
range and the standardised difference in baseline means between arms is 0.82 over the 15
trials with a baseline and with the baseline-outcome correlation 0.39. With sample size,
over all 16 trials, it is −0.29.

The strict grid, with baseline handling fixed to analysis of covariance, leaves 68
specifications. Its range is zero in 12 of 16 trials and at most 0.04 in the other four
(balance feedback 0.04, FREE 0.03, TERECO 0.02, cluster sets 0.01), the trials in which a
covariate set or a cluster model could vary. Over choices that satisfy the strict
equivalence criterion, there was almost nothing to vary in this corpus.

For the width of the 95% interval, baseline handling had the largest share in 11 trials,
the model family in 2 and the inference method in 2. The inference method accounted for a
median of 8% of the interval-width variance. Refitting with all two-way interactions in
the eight trial-by-grid combinations with at least 30 specifications did not change the
node with the largest share in any of them. Interaction terms accounted for a median of
13% of the explained variance (Supplement Table S4). In the eight trials in a clinical
rehabilitation context the range had a median of 0.11 standard deviations and a maximum
of 0.39. In the eight trials of exercise physiology or sports nutrition the median was
0.16 and the maximum 0.41. Per-trial median s-values range from 0.8 to 18 bits.

In 11 of the 16 trials every pair of preprocessing pipelines produced outcome vectors
correlated above 0.99. In one trial only one pipeline existed. Sign stability in
these trials says little about robustness, because the options barely change the data.
The named-variable component of the integrity screen could be computed in one trial,
which was not flagged. The broad search over 2 to 43 deposited baseline variables gave
combined p-values between 0.15 and 0.95 (Supplement Table S6).

### Estimand versus analysis

The defensible grid yielded 550 unique specifications, between 9 and 96 per trial, after
collapsing 1% duplicates. Measured from the published result, the largest displacement
per trial has a median of 0.18 standard deviations (interquartile range 0.08 to 0.26) and
the same maximum of 0.41. Every specification stays within 0.1 standard deviations in 4
of 12 trials. In two trials single specifications reverse the sign of the published
estimate, FREE and the balance feedback trial, whose published effects are 0.14 and 0.05
standard deviations. Of their specifications, 95% and 91% keep the published sign. The
range of d has a median of 0.24 standard deviations (bootstrap interval 0.13 to 0.32,
interquartile range 0.13 to 0.32) and a maximum of 0.52, in the spinal cord stimulation
trial. The sign was stable in 13 of 16 trials (57 to 93%). The range includes zero in
three, the ETIP pregnancy trial, FREE and the balance feedback trial. Over the 15 trials
with a non-zero estimand-preserving range, the defensible range exceeded it by a median
factor of 1.35 (bootstrap interval 1.12 to 1.52). Baseline handling remained the node
with the largest share of the estimate variance in 11 of 16 trials and the logarithmic
transformation in 5. The missing-data strategy, which could vary in 7 trials, had the
largest share in none.

The outlier arm, which adds the three pooled winsorising rules to the estimand-preserving
grid, has a median range of 0.18 and a maximum of 1.08 standard deviations. The maximum
is the transcranial stimulation trial, whose outcome is a percentage with a ceiling at
100 and half of whose participants score between 99 and 100: the rule of three median
absolute deviations winsorises the whole control arm towards the median and reduces d
from 1.4 to 0.4. No trial in the corpus applied such a rule. The arm is reported as
an illustration of what an option outside the literature does to a bounded outcome, not
as fragility.

### Reporting and the effect of my own mapping

Of the 12 primary reports, 8 analyse the outcome that the trial registration names as
primary, or as the first of several co-primary outcomes (Table 2). Three trials had no
registration. Of these, one declares its primary outcome in the paper, one identifies it
only through the sample-size calculation, and one names none. One registered trial names
no primary outcome in registration or paper. Three registrations were made after
recruitment had begun. The four secondary reports state that their outcome is not the
trial's primary outcome, in three cases in the paper and in one case only in the
registration. Twelve of the 16 papers report a point estimate for the arm contrast.
Four report only a p-value or an F statistic. One paper states an estimand. Thirteen
report tests of baseline balance and their "significance". In three the result of
that test
determined whether the analysis was adjusted. No paper reports a rule for outliers. The
published baseline handling was analysis of covariance in six, a change score in four, the
follow-up value in two and another approach in four. Model families were analysis of
variance (five), mixed models (six), analysis of covariance (three), a t-test and a
non-parametric test. Seven papers had no missing primary outcomes. Of the remaining nine,
four analysed complete cases, three used likelihood-based longitudinal models, one
multiple imputation and one did not say. Two papers modelled clustering. A protocol was
available for seven trials, a registration only for six, neither for three. Ten trials
appeared in journals that require data sharing. For six the requirement was unclear.

My first mapping of published analyses onto deposited data, made study by study before
the rules of section 2.3 were fixed, differed from the rule-based mapping in 13 of the 16
trials: the control arm was coded differently in 10, the outcome variable in 5, the
covariate set in 11, the baseline variable in 3 and the data file in 1 (Supplement Table
S2). Most control-arm differences arose where the first value of the group variable had
been taken as the control arm without checking value labels or group sizes against the
paper. Running the first mapping through the final pipeline gave a median |d| of 0.27 in both
and a median estimand-preserving range of 0.09 against 0.12, but the sign of the median
d was reversed in 7 of 16 trials, in each case because the control arm had been miscoded.
The mapping errors changed the direction of effects, not their fragility.


## Discussion

### Principal findings

Of 152 trials in exercise, rehabilitation and physiotherapy whose availability
statements pointed to a repository, 16 allowed a reader to identify and recompute the
published primary analysis without contacting anyone. The loss occurred in two steps,
first because deposits could not be reached or read, then because public data did not
contain what the published analysis needed. Where the published analysis could be fitted
as described, its estimate was recovered in 11 of 12 trials and to 0.014 standard
deviations in all 12. Over choices that leave the estimand unchanged, the published result moved by at most
0.15 standard deviations in the typical trial and by 0.41 at most. It never changed
sign. In 11 of 16 trials the only such choice that could move it was the handling of the
baseline value. With that choice fixed the range was zero in 12 trials. Adding choices that change
the estimand widened the range by about a third, mostly through logarithmic
transformation. Three of the 12 primary reports do not identify a primary outcome through
registration or paper, four papers give no point estimate, and one states an estimand.
My own first mapping of published analyses onto deposited data reversed the
direction of the effect in 7 of 16 trials before rules were fixed.

### Two losses, one of them new

The first loss is the one earlier audits describe. Deposits behind truncated links,
archives without a data file and studies that were not trials account for the drop from
152 to 48. Its size is in line with the availability rates of Jabouille and
colleagues and the compliance rates of Elghzali and colleagues \cite{Jabouille_2025,Elghzali_2025}. The second loss is different in kind. In 11 of 48 trials the deposit could not
support the published primary analysis: in eight the data were individual and readable
but the allocation was not in the file, the primary outcome was not identifiable among
the columns, the primary timepoint was missing, or the outcome existed only as raw
signals. In three the deposit held a README, a summary table or an unreadable file. All
eleven satisfy every availability policy I know of and are useless for the one purpose
that justifies the policy. A deposit that can answer its own
paper's question needs three things that none of these policies require: a variable that
holds the allocation with labelled values, a variable that the paper names as the primary
outcome, and a dictionary that connects the two to the text.

### Reproduction

Eleven of 12 published estimates were recovered (Wilson interval 65 to 99%), ten of
them to the printed decimal. None differed by more than 0.014 standard deviations.
Every recomputed interval contains the published estimate. The interval on the
proportion is wide because the denominator is 12. The denominator is 12 because only
12 of 423 screened records reach this step. The comparison with Brodeur and colleagues
is one of setting, not of rate: they worked under a mandate with 110 articles, I without
one. Naudet and colleagues reached the same conclusion as the original authors in 16 of
17 reanalyses \cite{Naudet_2018}. The one discrepancy comes from a Bayesian model whose paper
states no priors, not from the data. Reproduction required reading each paper closely and
resolving four details the papers leave open. In one trial the authors' deposited code
resolved them. Where a description was complete, a reader could recover the number.

### Fragility and what the grid could vary

Over choices that leave the estimand unchanged, the published result moved by at most
0.15 standard deviations in the typical trial and never changed sign. The number
describes one choice. In
11 of 16 trials the only such choice that could move the estimate was the handling of the
baseline value, because the covariates of the published model were not in the deposit, no
cluster variable was estimable and the inference method changes the interval and not the
estimate. The range over the three baseline analyses is not a property of analytic
freedom. It is a function of the baseline imbalance that randomisation happened to
produce, with a rank correlation of 0.82 over 15 trials, as the difference between
change-score and covariance-adjusted estimates under imbalance predicts \cite{Senn_2006,Van_Breukelen_2006}. With baseline handling fixed to analysis of covariance, which has
justified precedence, the range was zero in 12 trials and at most 0.04 standard
deviations in the other four. For simple two-arm trials with one primary outcome and one
follow-up, a multiverse over strictly equivalent choices has almost nothing to vary.

What a wider multiverse adds is a change of question. The defensible grid exceeded the
estimand-preserving grid by a median factor of 1.35. The node that most often drove
the additional range was logarithmic transformation, which estimates a ratio of geometric
means. Veltri's simulation attributed three quarters of the estimate variance to
preprocessing \cite{Veltri_2025}. In these trials, once options that change the estimand are
set apart, preprocessing choices that keep it contributed little. The outlier arm shows
the other way in which an unclassified multiverse manufactures fragility: a rule of three
median absolute deviations, applied to a percentage with a ceiling, moved one estimate by
1.08 standard deviations. No trial in the corpus used such a rule. Crenshaw and colleagues
showed what a multiverse looks like for one trial \cite{Crenshaw_2026}. Applying one classified
grid to 16 trials shows how little of it survives classification.

Two cautions apply. In 11 of 16 trials the preprocessing pipelines left the data almost
unchanged. Sign stability in those trials is not evidence of anything. And 196
estimand-preserving specifications over 16 trials, between 3 and 35 per trial, is a
description of one small, self-selected corpus, not of a field. Five of the trials
randomised fewer than 30 participants.

### Reporting

The reproduction rate is bounded above by what the papers and their registrations state.
Among the 12 primary reports, the registered primary outcome could be identified for
eight. Three trials were never registered. For one registered trial neither the
registry nor the paper names a primary outcome. Three registrations were made after
recruitment had started. Four of the 16 papers report a p-value or an F statistic without
an estimate of the arm difference. One states what quantity it is estimating. CONSORT
has asked for a defined primary outcome and an effect size with its precision since 2010
\cite{Schulz_2010}. The 2025 revision asks for the metric and the timepoint of every
outcome \cite{Hopewell_2025}. The estimands framework asks for the quantity itself
\cite{ICH_2019_E9R1,Kahan_2024}. Thirteen papers test baseline balance, a practice Senn argued
against in 1994 \cite{Senn_1994}. Three let the test decide the adjustment, which makes the
analysis depend on a random event. None reports what it did with outliers. The four
secondary reports are a reminder that the outcome a paper analyses and the outcome its
trial registered are not the same thing. The registration is where the
difference shows.

### Auditor degrees of freedom

Mapping a published analysis onto a deposited dataset is itself an analysis with
choices: which column is the outcome, which value is the control arm, which timepoint,
which covariates. My first mapping, made study by study, differed from the rule-based
mapping in 13 of 16 trials and reversed the direction of the effect in seven. Rerunning
it through the final pipeline changed neither the median size of the effects nor their
range by much. It changed their sign. These were coding errors, not choices between
defensible alternatives. They belong to the reproducer, not to the trials. Brodeur and colleagues let reproducers choose their
robustness checks and counted the results. The many-analysts studies show what such
freedom does to conclusions \cite{Silberzahn_2018,Breznau_2022}. Fixed rules, written before the mapping and applied to every trial, are the remedy that was applied. The error rate of the first pass belongs in the report.

### Limitations

The corpus is self-selected. Trials that share data are larger, more recent and better
conducted than trials that do not \cite{Tsujimoto_2020}. Wicherts and colleagues found more
reporting errors and weaker evidence among authors who did not share their data
\cite{Wicherts_2011}. The association with errors was not confirmed in a conceptual repetition
\cite{Nuijten_2017} and failed a replication \cite{Claesen_2023}. The reproduction rate is therefore
plausibly an upper bound for the field. No method extrapolates from this corpus to trials
that did not share.

Sixteen trials, five of which randomised fewer than 30 participants and one without a
baseline measurement, support statements about a typical case and a maximum, not about a
distribution. Only continuous primary outcomes were analysed. Crossover and within-person
designs were excluded. Four of the 16 papers analyse an outcome that their trial
registered as secondary. Four trials name co-primary outcomes of which I analysed
the first. Three trials compare two arms drawn from a three-arm design, with the
standardising denominator computed from those two arms. In one trial the paper is
inconsistent about which arm is the control. I followed the design section. The corpus
came from one database with one search string and required a repository
link in the availability statement. Trials whose data are published as a journal
supplementary file, which Jabouille and colleagues count as directly available, were
not captured. A second route through Zenodo and Dryad found 127 study-like deposits
that were not matched to articles.

The audit was not preregistered, the mapping rules were fixed after the published analyses had been read, and one coder mapped the trials. The
estimand-preserving grid keeps a node whose options differ in precision. In most
trials it was the only node that could vary. The strict grid shows what remains without
it. The model family was inert: in the cluster-randomised FREE trial, random intercepts
for practitioner and practice were singular in every fit. The linear-model
specifications, including permutation inference over individual allocations, do not
respect the cluster design. The variance partition is additive and treats confounded node
pairs as separate. The named component of the integrity screen could be computed in one
trial. Instrument-specific minimal important differences were not collected. The 0.2
standard deviation threshold is a convention. Pooled estimation over specifications and
multiplicity control over specifications were not attempted \cite{Bartos_2025_arXiv,Mandl_2024}.

### Implications

For journals and repositories, a deposit should be accepted when it contains a labelled
allocation variable, a variable named as the primary outcome, and a dictionary. Without
them the deposit meets the policy and fails its purpose. For multiverse practice,
classify every decision before computing, drop options the literature does not use,
collapse specifications that give the same result, fix the standardisation denominator
before preprocessing, and report how many nodes could vary in each trial, because a
multiverse over simple two-arm trials may have little to vary. For meta-research in fields whose journals do not require data deposition, 16 of 152
trials with a repository link (11%, Wilson interval 7 to 16%) reached recomputation and
11 of 152 (7%, 4 to 12%) reproduced. When the published analysis could be fitted as
described, it reproduced.

## Conclusion

In a field whose journals do not require data deposition, 16 of 152 trials with a
repository link, about one in nine, allowed a reader to recompute the published primary
analysis without contacting the authors. The loss occurred
in two steps. The second, from public data to identifiable analysis, is the one that
availability policies do not address. Where the published analysis could be fitted as
described, 11 of 12 estimates were recovered and all 12 to 0.014 standard deviations.
Over choices that leave the estimand unchanged, the published result moved by at most
0.15 standard deviations in the typical trial and never changed sign. In most trials the
only such choice was the handling of the baseline value. Without it there was almost
nothing to vary. Choices
that change the estimand widened the range by a third. Three of 12 primary reports do not
identify a primary outcome through registration or paper. Four papers give no
estimate. My own first mapping of analyses onto data reversed seven effects before rules
were fixed.

