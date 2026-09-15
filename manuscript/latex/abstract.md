**Background.** Large reproduction projects have recomputed published results from the
original data and code, but only in fields where journals require authors to deposit
both. Journals in physiotherapy and rehabilitation ask at most for a data availability
statement. None requires deposition of data and code as a condition of publication. I asked how many trials in these fields a reader can recompute from public
data deposits without contacting the authors, whether the published estimates reproduce,
and how far they move when the analysis is varied over choices classified in advance as
preserving or as changing the estimand.

**Methods.** From 423 open-access records in Europe PMC I identified 152 studies with a
repository link in their availability statement, retrieved the deposits, and assessed
the 48 randomised trials with a readable data file under fixed rules for identifying the
primary outcome, control arm and published model, with trial registrations retrieved.
I fitted each published primary analysis as described and ran a multiverse over a
grid of decision nodes written before computation: an estimand-preserving grid
(baseline handling, covariates, model family, inference) and a defensible grid adding
missing-data strategy and transformation. After inspecting the first results I added a
strict grid with baseline handling fixed to analysis of covariance and moved outlier
rules, which no included paper uses, to a sensitivity arm. Effects are in pooled
within-group standard deviations.

**Results.** Sixteen trials were included, 11% of those with a link. Of 136 losses, 104
occurred before the data were opened. Of the 32 after, 11 were deposits that could
not support the published analysis. Fitting the published analysis recovered 11 of 12 point estimates
and all 12 to 0.014 standard deviations. Over 196 estimand-preserving specifications the published result moved by at most 0.15
standard deviations in the median trial and by 0.41 at most. No specification
reversed its sign. In 11 of 16 trials only baseline handling could vary. The
displacement scaled with baseline imbalance (Spearman 0.82).
With baseline handling fixed, the range was zero in 12 trials and at most 0.04 in the
rest. The defensible grid widened the range by a median factor of 1.35, mostly through
logarithmic transformation. It reversed the published sign in single specifications of
two trials with effects near zero. Three of 12 primary reports do not identify a primary outcome
through registration or paper. Four papers report no point estimate. My first mapping of
analyses onto data reversed the effect direction in 7 of 16 trials before rules were
fixed.

**Conclusions.** In a field whose journals do not require data deposition, 16 of the 152
trials that pointed to a repository, about one in nine, could be recomputed by a reader
without contacting the authors. Where the published analysis could be fitted as
described, it reproduced. Over choices that keep the estimand, a multiverse on simple two-arm trials
has little to vary beyond the handling of the baseline value, whose effect is set by
baseline imbalance. Most of what a wider multiverse adds is a change of question.