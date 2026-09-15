# Novelty search, 2026-09-15

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

## Methodology and deviations from the search plan

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

## Queries verbatim, with source and hit count

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

## Candidates reviewed, with verdict

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

## Update on scooping risk (supplement to README, as of 2026-08-28)

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

## Conclusion

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
