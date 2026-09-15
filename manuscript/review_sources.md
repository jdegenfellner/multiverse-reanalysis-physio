# Quellenprüfung OUTLINE.md (Version vom 2026-09-12)

Methode: `pdftotext -layout` je PDF, Seiten mit `awk`-Zähler markiert, dann `grep -n -i` auf
Stichworte; Umgebung mit `sed -n` gelesen. Alle Zitate sind wörtlich aus den Originalen
(Englisch belassen). Seitenangaben beziehen sich, wo nicht anders vermerkt, auf die
PDF-Seitenzählung von `pdftotext`, bei Veltri 2026 auf die gedruckten Zeitschriftenseiten.

Befund-Kategorien: **korrekt** / **korrekt (Präzisierung nötig)** / **Zahl falsch** /
**Aussage nicht im Paper** / **Begriff falsch zugeordnet** / **nicht prüfbar**.

---

## Reporting conventions (Zeile 10–11)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| Reporting conventions | "No 'statistically significant' as a verdict (Wasserstein 2016, 2019)" — Wasserstein-Lazar 2016 `[38]` | korrekt | Titel: "The ASA Statement on p-Values: Context, Process, and Purpose", Am. Stat. 70:2, 129–133 | keine |
| Reporting conventions | dito, Wasserstein/Schirm/Lazar 2019 `[00]` | korrekt, fast wörtlich | Abschnittsüberschrift "2. Don't Say 'Statistically Significant'" (S. 3); "We conclude ... that it is time to stop using the term 'statistically significant' entirely." (S. 3); "In sum, 'statistically significant'—don't say it and don't use it." (S. 3) | keine |

## 1.1 Reproduction where sharing is mandatory (Zeile 47–55)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 1.1 | Brodeur 2026: "110 articles" `[09]` | korrekt | "checks of 110 articles recently published in leading economics and political science journals" (Abstract, S. 3); "110 published studies in economics (79) and political science (31)" (S. 6) | keine |
| 1.1 | Brodeur 2026: ">85% computationally reproducible" | korrekt | "over 85% of published claims were computationally reproducible" (S. 3); "a computational reproducibility rate of 85%" (S. 9) | keine |
| 1.1 | Brodeur 2026: "72% of significant estimates robust" | korrekt | "our re-analyses lead to 72% of statistically significant estimates to remain significant and in the same direction" (S. 3); Fig. 1: 72% (S. 9) | keine |
| 1.1 | Brodeur 2026: Feld "economics and political science" | korrekt | Titel: "Reproducibility and Robustness of Economics and Political Science Research"; Sample 79 Ökonomie + 31 Politikwissenschaft (S. 6) | keine |
| 1.1 | Stodden 2018: "policy effect on artefact availability" `[16]` | korrekt (Einschränkung im Original) | "we were able to obtain artifacts from 44% of our sample and were able to reproduce the findings for 26%" (S. 1); Fazit selbst: "an improvement over no policy, but currently insufficient for reproducibility" (S. 1) | Bei Verwendung die Einschränkung "insufficient" mitnennen, sonst wirkt der Effekt stärker als im Paper dargestellt |
| 1.1 | Naudet 2018: "BMJ and PLOS Medicine" `[style_models/Naudet]` | korrekt | Titel: "...studies published in The BMJ and PLOS Medicine" (S. 1) | keine |
| 1.1 | Naudet 2018: "37 RCTs eligible" | korrekt | "37 RCTs (21 from The BMJ and 16 from PLOS Medicine) ... met the eligibility criteria" (S. 1) | keine |
| 1.1 | Naudet 2018: "17 datasets obtained" | korrekt | "17/37 (46%, 95% CI 30% to 62%) satisfied the definition of data availability" (S. 1) | keine |
| 1.1 | Naudet 2018: "14 reanalysed" | **Zahl falsch / unpräzise** | "14 of the 17 (82%, 59% to 94%) were fully reproduced" (S. 1); "errors were identified in two but reached similar conclusions and one paper did not provide enough information ... to reproduce the analyses" (S. 1) | 14/17 wurden *vollständig* reproduziert, nicht "reanalysiert". Tatsächlich reanalysiert wurden 16/17 (1 nicht auswertbar wegen fehlender Methodenangaben). Formulierung: "17 datasets obtained; 16 reanalysed, 14 fully reproduced" |
| 1.1 | Siebert 2022: "EMA data sharing" `[17]` | korrekt | Titel: "Data-sharing and re-analysis for main studies assessed by the European Medicines Agency" (S. 1) | keine |
| 1.1 | Siebert 2022: "reanalysis rate 46% vs 16% under the Naudet convention" | **Aussage nicht im Paper** | Siebert 2022 berichtet nur EINEN Wert: "the conclusions of 10/62 trials (16% [CI95 8 to 28%]) were reproduced" (S. 1/7). 46% ist die Data-*Availability*-Rate aus Naudet 2018 (andere Studie/Kohorte, BMJ/PLOS Medicine statt EMA); Siebert erwähnt Naudet nur als Vergleich: "These results are in line with an earlier survey ... [46]" (S. 10–11). Der Ausdruck "Naudet convention" kommt wörtlich in keinem der beiden Paper vor | Umformulieren als Cross-Study-Vergleich: "Siebert 2022 reproduced 10/62 (16%) EMA trials, using the Naudet convention of counting studies without data as not reproducible; this is lower than the 46% data-availability rate Naudet 2018 found in a different cohort (BMJ/PLOS Medicine)." Nicht als eine Zahl aus einer Quelle darstellen |
| 1.1 | Hardwicke 2018: Journal "Cognition" `[style_models]` | korrekt | Titel: "...mandatory open data policy at the journal Cognition" (S. 1) | keine |
| 1.1 | Hardwicke 2018/2021: "open data badges" | **teilweise falsch** | Hardwicke 2018 (Cognition) betraf eine **verpflichtende** Policy, keine Badges: "A mandatory open data policy was introduced at the journal Cognition on 1 March 2015" (S. 3); Badges werden dort nur am Rande für *Psychological Science* erwähnt. Hardwicke 2021: "25 Psychological Science articles awarded open data badges between 2014 and 2015" (S. 1) | "Open data badges" trifft nur auf Hardwicke 2021 (Psychological Science) zu, nicht auf Hardwicke 2018 (Cognition, dort Pflicht-Policy). Im Fliesstext beide Journale unterscheiden: "Cognition (mandatory data policy) and Psychological Science (open data badges)" |

## 1.2 The field without a mandate (Zeile 59–62)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 1.2 | Jabouille 2025: "~12%" Datenverfügbarkeit `[10]` | korrekt | "Data were openly available in only 12% of articles" (S. 10) | keine |
| 1.2 | Jabouille 2025: "four association journals" | korrekt | Journale der nationalen Physiotherapie-Verbände USA/Kanada/UK/Australien (S. 1, 3) | keine |
| 1.2 | Jabouille 2025: "465 articles" | korrekt | "A total of 465 original research articles were identified" (S. 1) | keine |
| 1.2 | Elghzali 2025: "22.7%" `[11]` | korrekt | "After emailing authors ... only 22.7% adhered to them [DSS]" (S. 1) | keine |
| 1.2 | Murphy 2025: "14% of authors provided raw data" `[12]` | korrekt | "Of those, 14% (n = 21) shared data" (S. 6) | keine |
| 1.2 | Murphy 2025: "28% of replications succeeded" | korrekt | "28% (n = 7) of the replications were successful" (S. 7) | keine |
| 1.2 | Dhanani 2022: "recomputed statistics from published numbers only" `[13]` | korrekt | "re-analyzed the primary outcome using the statistical method reported in the manuscript" (S. 1); keine IPD verwendet | keine |

## 1.3 Multiverse analysis in trials, and its two known problems (Zeile 70–84)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 1.3 | Steegen 2016: Ursprungspaper Multiverse `[08]` | korrekt | "researchers could perform a multiverse analysis" (S. 1); Titel "Increasing Transparency Through a Multiverse Analysis" | keine |
| 1.3 | Simonsohn 2020: Specification-curve `[23, bib only]` | korrekt | "we introduce specification curve analysis" (S. 1), Autoren Simonsohn/Simmons/Nelson | keine |
| 1.3 | Nepomuceno 2026: "8.6%" präregistriert `[15]` | korrekt (Nenner ergänzen) | "The multiverse itself was preregistered in only 13/152 studies (8.6%)" (S. 10) | Nenner n=152 (vertieft codierte Teilstichprobe, nicht alle 613) im Text nennen |
| 1.3 | Nepomuceno 2026: "3.9%" begründet ("justified") | korrekt (Nenner ergänzen) | "only 6/152 (3.9%) discussed this distinction" [Defensibility/Equivalence] (S. 10) | gleicher Nenner n=152 |
| 1.3 | Nepomuceno 2026: "median 144" Spezifikationen | korrekt | "median = 144, IQR 24–1248" (S. 1), n=529 Studien mit extrahierbarer Zahl | keine |
| 1.3 | Nepomuceno 2026: "89.5% purely descriptive" | **Zahl falsch** | "125/152 studies (82.2%) relied solely on a descriptive reading of the results" (S. 10); zusätzlich 10.5% Permutationstests, 7.2% andere quantitative Methoden | Korrekte Zahl: **82.2% (125/152)**, nicht 89.5%. Vermutlich fehlerhaft aus "100% − 10.5%" abgeleitet, ignoriert die 7.2% "other quantitative methods" |
| 1.3 | Nepomuceno 2026: "613 studies" (Spezialcheck, nicht im aktuellen Outline-Text) | korrekt | Titel: "...Across 613 Studies"; "613/1545 (39.7%) implemented a multiverse-style analysis" (S. 6) | keine |
| 1.3 | Del Giudice & Gangestad 2021: "equivalent (type E), estimand-changing (type N) or unclear" (Story-Absatz, Zeile 26–27) `[06]` | **Begriff falsch zugeordnet** | Original: "Type E decisions (principled equivalence), Type N decisions (principled nonequivalence), and Type U decisions (uncertainty)" (Abstract, S. 1; S. 3). Die Wörter "estimand" und "unclear" kommen im Paper nicht vor | Umformulieren: "equivalent (Type E), nonequivalent (Type N) or uncertain (Type U)". Falls "estimand-changing" als eigene Interpretation von Type N gemeint ist, explizit als solche kennzeichnen, nicht als Original-Terminologie |
| 1.3 | Del Giudice & Gangestad 2021: "equivalent, non-equivalent or uncertain" (Zeile 74) | korrekt (Schreibweise angleichen) | s.o.; Original schreibt "nonequivalent" ohne Bindestrich | Mit Zeile 26–27 vereinheitlichen; siehe Korrektur oben |
| 1.3 | Del Giudice & Gangestad 2021: gepolsterte Multiverses verbergen Effekte | korrekt | "multiverse-style analyses can produce misleading results, potentially hiding meaningful effects within a mass of poorly justified alternatives" (Abstract, S. 1); "drowning reasonable effect estimates in a sea of unjustified alternatives" (S. 2) | keine |
| 1.3 | Short 2026: Defensibility "used in the literature" vs. Equivalence `[07]` | korrekt (Präzisierung nötig) | Glossar: "Defensible: ... can be guided by domain knowledge, accepted methodological approaches, theory, application in recent peer-reviewed literature, or empirical assessment" (S. 17); "Equivalent: ... reasonably treated as interchangeable" (S. 17) | "used in the literature" ist nur EINER von mehreren Begründungswegen für Defensibility, nicht die Definition. Anführungszeichen entfernen oder Definition erweitern |
| 1.3 | Short 2026: "illusion of consistency" | korrekt, wörtlich | "Empirical similarity across data sets can produce the illusion of consistency rather than genuine robustness" (S. 12) | keine |
| 1.3 | Veltri 2026: "76.9% vs 7.5% of estimate variance" `[01]` | korrekt | "preprocessing decisions explain 76.9% of the total variance in estimated treatment effects, whereas model choice explains only 7.5%" (Abstract, S. 383); Table 3 (S. 388) | keine, gilt für Simulation A (lineare Modelle) |
| 1.3 | Veltri 2026: "180 Pfade", "36 x 5" (Spezialcheck, nicht im aktuellen Outline-Text) | korrekt | "Each analysis spans 180 analytical pathways, produced by crossing 36 preprocessing pipelines ... with five common model specifications" (S. 383); "180 specifications (36 preprocessing × 5 models)" (S. 396) | Falls später zitiert: 36 Preprocessing-Pipelines × 5 Modelle = 180 Pfade je Simulation. Nicht mit der eigenen "36 core options" der Studie verwechseln (das ist eine andere Zahl, siehe 4.7) |
| 1.3 | Veltri 2026: Simulation, keine Trennung Estimand vs. analytische Wahl | korrekt | "We demonstrate this influence with two fully specified multiverse analyses on simulated RCT data" (S. 383); keine Treffer für "estimand"/"type E"/"type N" im Volltext | keine |
| 1.3 | Crenshaw 2026: ein PTSD-Trial `[02]` | korrekt | "a small randomized psychotherapy trial for posttraumatic stress disorder" (S. 1); n=32 Paare, NCT02336971 (S. 4) | keine |
| 1.3 | Patel 2015: Vibration of effects `[27]` | korrekt | Titel: "...vibration of effects due to model specification..." (S. 1) | keine |
| 1.3 | Klau 2021: Vibration of effects, observational `[28]` | korrekt | Titel: "...vibration of effects framework" (S. 1) | keine |
| 1.3 | Silberzahn 2018 `[30]`, Botvinik-Nezer 2020 `[31]`, Breznau 2022 `[32]`, Gould 2025 `[33]`: Many-analysts-Studien | korrekt (alle vier) | "Twenty-nine teams involving 61 analysts" (Silberzahn, S. 5); "70 teams" (Botvinik-Nezer, S. 5); "161 researchers in 73 research teams" (Breznau, S. 1); "174 analyst teams, comprising 246 analysts" (Gould, S. 3) | keine |

## 2.1 Design and registration (Zeile 106–109)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 2.1 | Brodeur 2026: "should all be considered as not pre-registered" `[09, check wording]` | korrekt, fast wörtlich | "Our re-analyses should thus all be considered as not pre-registered." (S. 29) | Für ein direktes Zitat exakt "should thus all be considered as not pre-registered" übernehmen |
| 2.1 | van den Akker 2021: Transparency-Statement-Items `[35]` | korrekt | "we present a template specifically designed for the preregistration of secondary data analyses" (S. 1); "our template ... involves 25 questions" (S. 3) | Präzisierung: 25 Fragen/Items |

## 2.6 Stage 2: computational reproduction (Zeile 154–160)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 2.6 | Hardwicke 2021: "full ≤2% relative difference, minor ≤10%, major >10% or sign change" `[style_models]` | **Zahl falsch** | Tatsächlich nur zwei Stufen: "Numerical discrepancies were classified as 'minor' (0% > PE < 10%) or 'major' (PE ≥ 10%). If an original p-value fell on the opposite side of the alpha boundary ... we additionally recorded a 'decision error'." (S. 3) | Es gibt **keine** "full ≤2%"-Kategorie bei Hardwicke 2021. Die 2%-Schwelle stammt aus Naudet 2018, wo sie explizit verworfen wurde: "we initially planned to consider non-reproducibility as a disagreement ... by more than 2% ... After reanalysis ... we changed our definition" (Naudet 2018, S. 3). Klassifikation im Manuskript entweder auf Hardwickes 2-Stufen-Schema umstellen (minor <10%, major ≥10%, "decision error" separat bei α-Grenzüberschreitung) oder die 3-Stufen-Klassifikation als eigene methodische Festlegung kennzeichnen, nicht als Hardwicke-Zitat |

## 2.7 Data integrity screen (Zeile 163–169)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 2.7 | Carlisle 2017: Stouffer-Kombination, zweiseitig `[47]` | korrekt | "I used the sum of the z values (Stouffer's method) as the primary method to combine p values" (S. 3); Table 2: Konversion einseitig→zweiseitig (S. 5) | keine |
| 2.7 | Bolland 2019: Caveats, Rundung `[49]` | korrekt | Titel: "Rounding ... affected baseline p-value distributions in randomised trials"; "baseline p-values calculated from rounded summary statistics are non-uniformly distributed" (S. 4) | keine |
| 2.7 | Brown & Heathers 2017 (GRIM): nicht anwendbar auf Individualdaten `[50]` | korrekt (sinngemäss) | GRIM prüft publizierte Mittelwerte gegen Stichprobengrösse/Granularität (Abstract, S. 2); bei Individualdaten direkt nachrechenbar, GRIM somit gegenstandslos | keine |
| 2.7 | Wilkinson 2025 JCE: "no relation between trustworthiness and risk of bias" `[51]` | korrekt (kleine Nuance) | Abstract: "No relationship was identified between trustworthiness assessment and Risk of Bias or GRADE" (S. 4); Conclusions: "problematic studies do not appear to be flagged by Risk of Bias assessment" (S. 4/15) | Eine RoB-Domäne (allocation concealment) zeigte eine Assoziation, aber kontraintuitiv gerichtet (p=0.01, S. 11) — stützt die "no relation"-Aussage eher, als ihr zu widersprechen; ggf. als Fussnote erwähnen |
| 2.7 | Heal 2026 INSPECT-IPD: Protokoll `[53]` | korrekt | Titel: "Protocol for the development of a tool (INSPECT-IPD) to identify problematic randomised controlled trials when individual participant data are available" (S. 1) | keine |

## 2.8 Stage 3: the two grids (Zeile 172–187)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 2.8 | Vickers & Altman 2001: Baseline-Handling, ANCOVA bevorzugt `[39]` | korrekt | "Analysis of covariance is the preferred general approach, however." (S. 2) | keine |
| 2.8 | Senn 2006: Change score vs. ANCOVA `[40, bib only]` | korrekt | "The case for preferring analysis of covariance (ANCOVA) to the simple analysis of change scores (SACS) has often been made" (S. 1) | keine |
| 2.8 | Twisk 2018: Treatment-effect-Schätzung RCT `[41]` | korrekt | "to explain different methods used to estimate treatment effects in RCTs" (S. 1); Empfehlung longitudinale ANCOVA/Repeated Measures (S. 1/6) | keine |
| 2.8 | Kahan 2014: Kovariaten-Adjustierung, Risiken/Nutzen `[42]` | korrekt | Titel: "The risks and rewards of covariate adjustment in randomized trials"; "should be routinely incorporated" (S. 1) | keine |
| 2.8 | Kahan & Morris 2012: Stratifizierte Randomisierung `[43]` | korrekt | Titel: "Reporting and analysis of trials using stratified randomisation..." (S. 1) | keine |
| 2.8 | ICH E9(R1) 2019: Missing-data/Estimands `[54]` | korrekt | Titel: "Addendum on Estimands and Sensitivity Analysis in Clinical Trials" (S. 1) | keine |
| 2.8 | Kahan 2024: Estimands-Primer BMJ `[44]` | korrekt | Titel: "The estimands framework: a primer on the ICH E9(R1) addendum", BMJ 2024;384:e076316 (S. 1) | keine |

## 2.9 Summary measures (Zeile 190–205)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 2.9 | Del Giudice & Gangestad 2021: "on scale mixing" (log/raw SD nie gepoolt) `[06]` | **Aussage nicht im Paper** | Volltextsuche nach "scale mixing", "mixing", "standardiz", "log-transform" ohne einschlägigen Treffer. Einzige Erwähnung: "other relevant domains include criteria for outliers, variable transformations, choice of statistical models" (S. 3), ohne Ausführung | Zuschreibung entfernen oder als eigene methodische Festlegung des Manuskriptteams kennzeichnen (lässt sich indirekt aus dem Type-N-Konzept ableiten, aber "scale mixing" steht nicht im Paper) |
| 2.9 | Rafi & Greenland 2020: s-values `[36]` | korrekt | "the Shannon transform of the P-value p ... to provide a measure of the information supplied by the testing procedure" (Abstract) | keine |
| 2.9 | Short 2026: "Pipeline similarity ... correlation ... r = 0.99 ... sign stability" | **Begriff falsch zugeordnet** | Im Paper ist "Pipeline similarity/analytical similarity" definiert als strukturelle Überlappung von Decision Nodes (S. 17), NICHT als Korrelation der Ergebnisvektoren. Das im Outline gemeinte Konzept heisst im Paper "Dataset similarity/empirical similarity: ... overlap or correlation between data sets produced by different analytical pipelines" (S. 17); als Masse werden genannt: "cosine similarity ... Euclidean distance ... graph neural networks" (S. 12–13). Kein Treffer für "0.99", "r =", "sign stability" | Umbenennen in "Dataset (empirical) similarity (Short 2026)". Schwellenwert r=0.99 und Begriff "sign stability" sind eigene operationale Festlegungen der Autoren, nicht aus dem Paper — als solche kennzeichnen |
| 2.9 | Bartos 2025: gepoolte Meta-Analyse über Spezifikationen `[24]` (nicht durchgeführt) | korrekt | "single-dataset meta-analysis, a weighted-likelihood approach ... yields meta-analytic point and interval estimates of the average effect across analytic approaches" (Abstract) | keine |
| 2.9 | Mandl 2024: minP-Multiplizitätskontrolle `[04]` (nicht durchgeführt) | korrekt | "we propose using the 'minP' adjustment method, which takes potential test dependencies into account ... through a permutation-based procedure" (Abstract) | keine |

## 4.3 Reproduction is good when it is possible (Zeile 282–285)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 4.3 | Brodeur (>85%) | korrekt | s.o. 1.1 | keine |
| 4.3 | Hardwicke 2021 (Psychological Science) | korrekt | "16 (64%, 95% CI [43,81]) articles contained at least one 'major numerical discrepancy'" (S. 1) | keine |
| 4.3 | Naudet 2018: "14 of 17 reanalyses with same conclusion" | **Zahl falsch** | "14 of the 17 ... were fully reproduced ... errors were identified in two but reached similar conclusions ... one paper did not provide enough information" (S. 1); "we found no results contradicting the initial publication" (S. 5) | Präziser: 14/17 vollständig reproduziert; **16/17 kamen zur gleichen Schlussfolgerung** (14 vollständig + 2 mit Fehlern, aber gleicher Schlussfolgerung); 1/17 nicht beurteilbar (fehlende Methodenangaben, nicht abweichend). Formulierung "14 of 17 fully reproduced; 16 of 17 reached the same conclusion, none contradicted" |

## 4.4 Fragility is small and has a name (Zeile 287–294)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 4.4 | "Vickers and Altman lesson" (Baseline-Handling dominiert) | korrekt | s.o. 2.8 | keine |
| 4.4 | Veltri's "77% preprocessing share" | korrekt | Paper rundet selbst an einer Stelle: "77% ... and only 8% to model choice" (S. 388, vor Table 2) | keine |

## 4.5 Reporting (Zeile 296–300)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 4.5 | "Link to ICH E9(R1) and Kahan 2024" | korrekt | s.o. 2.8 | keine |
| 4.5 | CONSORT (2010/2025) | nicht prüfbar | kein PDF in `literature/` | PDF beschaffen, falls zitiert werden soll |
| 4.5 | Senn 1994 (Zeile 300, 353) | nicht prüfbar | kein PDF in `literature/`; Outline vermerkt dies bereits selbst ("add PDF or cite via Senn 2006") | Entweder PDF beschaffen oder ausschliesslich über Senn 2006 zitieren (dort ist die Argumentation belegt) |

## 4.6 Auditor degrees of freedom (Zeile 302–306)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 4.6 | Gelman & Loken 2014: "garden of forking paths" `[34]` | korrekt, titelgebend | "Data-dependent analysis— a 'garden of forking paths' — explains why many statistically significant comparisons don't hold up." (S. 1); ausgeführt S. 5 | keine |

## 4.7 Limitations (Zeile 308–320)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg (Zitat, Seite) | Korrektur |
|---|---|---|---|---|
| 4.7 | Tsujimoto 2020: "self-selected corpus" `[18, bib only]` | korrekt (Nuance) | Titel: "No consistent evidence of data availability bias existed in recent individual participant data meta-analyses" (S. 1) | Nuance: Tsujimoto fand **keinen** Effektschätzungs-Bias (s.u.), aber sehr wohl eine Qualitäts-Selektion (Studien mit verfügbaren IPD hatten grössere Stichproben, bessere Allocation Concealment, höheren Impact Factor). Bei Ausformulierung diese Differenzierung mitnehmen |
| 4.7 (Spezialcheck, nicht im aktuellen Outline-Text) | Tsujimoto 2020: "ratio of odds ratios 1.01 (0.86–1.19)" | korrekt, exakt bestätigt | "pooled ROR, 1.01; 95% CI, 0.86 to 1.19; I² = 27%; τ² = 0.044" (S. 5); Abstract: "ROR 1.01, 95% CI, 0.86–1.19" (S. 1) | keine — Zahl exakt korrekt, verglichen werden gepoolte Odds Ratios aus 31 systematischen Übersichtsarbeiten (728 RCTs) zwischen Studien mit vs. ohne IPD-Beitrag |
| 4.7 | Wicherts 2011: Datenteilungsbereitschaft ↔ Fehlerrate `[19]` | korrekt | "reluctance to share data to be associated with weaker evidence ... and a higher prevalence of apparent errors" (Abstract) | keine |
| 4.7 | Nuijten 2017: "failed replication" von Wicherts 2011 `[20]` | korrekt (Präzisierung nötig) | "Our findings are not directly in line with Wicherts et al. (2011) ... A meaningful difference ... is that we looked at whether data sets were published alongside the articles, whereas Wicherts et al. looked at (reluctance in) data sharing when explicitly requested." (S. 17); "we found no relationship between data sharing and reporting inconsistencies" (S. 1) | Nuijten bezeichnet die eigene Studie nirgends als "Replikation" von Wicherts — methodisch abweichend (tatsächliche Verfügbarkeit statt Bereitschaft auf Anfrage). Präziser: "konzeptuelle Wiederholung, die den Effekt nicht bestätigte", statt "failed replication" |
| 4.7 | Claesen 2023: "failed replication" von Wicherts 2011 `[21]` | korrekt, direkt | Titel: "...A replication of Wicherts, Bakker and Molenaar (2011)"; "we found no robust empirical evidence for the claim that not sharing research data ... is associated with consistency errors" (S. 1) | keine — explizite, gescheiterte Replikation |
| 4.7 | "Grid choices: 36 core options" (eigene Angabe, kein Literaturzitat) | n/a | — | Nur zur Klarstellung: nicht mit Veltris "36 preprocessing pipelines × 5 models = 180" verwechseln (andere Studie, andere Struktur, s. 1.3) |

## Claims that need a source not yet in `literature/` (Zeile 352–357)

| Abschnitt in OUTLINE | Zuschreibung | Befund | Beleg | Korrektur |
|---|---|---|---|---|
| Ende OUTLINE | Senn 1994 (Baseline-Tests) | nicht prüfbar | kein PDF vorhanden | s.o. 4.5 |
| Ende OUTLINE | Van Breukelen 2006, Barnett 2004 (Lord's Paradox) | nicht prüfbar | kein PDF vorhanden | PDFs beschaffen, falls zitiert werden soll |
| Ende OUTLINE | CONSORT 2010/2025 | nicht prüfbar | kein PDF vorhanden | s.o. 4.5 |
| Ende OUTLINE | Johns 2019, Candlish 2018 (Therapist-Effekte) | nicht prüfbar | kein PDF vorhanden | nur beschaffen, falls 4.7 sie erwähnt |

---

## Liste aller Zuschreibungen, die geändert werden müssen

Sortiert nach Wichtigkeit für die zentrale Story:

1. **Nepomuceno 2026, Zeile 72**: "89.5% purely descriptive" → **"82.2% purely descriptive" (125/152)**. Zusätzlich für 8.6%, 3.9% und 82.2% den Nenner n=152 (Teilstichprobe, nicht 613) nennen.
2. **Del Giudice & Gangestad 2021, Zeile 26–27 (Story-Absatz)**: "equivalent (type E), estimand-changing (type N) or unclear" → **"equivalent (Type E), nonequivalent (Type N) or uncertain (Type U)"**. Die Begriffe "estimand" und "unclear" kommen im Original nicht vor; mit Zeile 74 vereinheitlichen.
3. **Siebert 2022, Zeile 53–54**: "reanalysis rate 46% vs 16% under the Naudet convention" ist keine Zahl aus Siebert 2022 allein. Siebert selbst berichtet nur 16% (10/62); 46% ist Naudets Datenverfügbarkeitsrate aus einer anderen Kohorte. Als expliziten Cross-Study-Vergleich umformulieren.
4. **Hardwicke 2021, Zeile 154–156 (Methods 2.6)**: Die Dreierklassifikation "full ≤2% / minor ≤10% / major >10%" ist falsch zugeschrieben. Hardwicke 2021 kennt nur zwei Stufen (minor <10%, major ≥10%) plus separaten "decision error"; die 2%-Schwelle stammt aus Naudet 2018, wo sie verworfen wurde.
5. **Naudet 2018, Zeile 52 und Zeile 283–284**: "14 reanalysed" / "14 of 17 reanalyses with same conclusion" → präziser: 14/17 vollständig reproduziert, **16/17 kamen zur gleichen Schlussfolgerung**, 1/17 nicht beurteilbar (nicht abweichend).
6. **Hardwicke 2018, Zeile 54–55**: "open data badges" trifft nicht auf Cognition/2018 zu (dort: Pflicht-Policy); nur auf Psychological Science/2021. Im Fliesstext differenzieren.
7. **Del Giudice & Gangestad 2021, Zeile 193–194 (Methods 2.9)**: Zuschreibung "on scale mixing" — dieser Begriff/diese Aussage steht nicht im Paper. Entfernen oder als eigene Festlegung kennzeichnen.
8. **Short 2026, Zeile 201–202 (Methods 2.9)**: "Pipeline similarity" ist im Paper ein anderer, bereits definierter Begriff (strukturelle Knoten-Überlappung). Das gemeinte Konzept heisst dort "Dataset (empirical) similarity". Der Schwellenwert r=0.99 und "sign stability" kommen im Paper nicht vor — als eigene Festlegung kennzeichnen.
9. **Short 2026, Zeile 75–76**: "used in the literature" ist nur einer von mehreren Wegen, "defensibility" zu begründen, nicht die Definition selbst — Anführungszeichen entfernen oder Definition erweitern.
10. **Nuijten 2017, Zeile 309–311**: "failed replication" ist zu stark — Nuijten nennt die eigene Studie selbst keine Replikation von Wicherts (andere Operationalisierung). Präziser als "konzeptuelle Wiederholung ohne Bestätigung des Effekts" formulieren (Claesen 2023 ist dagegen korrekt als "failed replication" belegt).

Alle übrigen geprüften Zuschreibungen (siehe Tabellen oben) sind korrekt.
