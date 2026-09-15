# Quellenprüfung Abschnitt 1 (Introduction), `manuscript/paper.md` Zeilen 8–75

Geprüft am 2026-09-12 gegen die PDFs in `literature/` (Zuordnung über `literature/manifest.csv`
bzw. `literature/style_models/`), Text extrahiert mit `pdftotext -layout`, durchsucht mit
`grep`/`sed`. Jede Zahl und jede Sachaussage mit Zitatschlüssel wurde einzeln gegen den
Volltext geprüft.

| Zeile | Zuschreibung | Befund | Beleg (wörtliches Zitat, Fundstelle) | Korrekturvorschlag |
|---|---|---|---|---|
| 10–12 | Brodeur: "reproduced 110 articles from economics and political science journals with mandatory data and code policies" | korrekt | Abstract: "We reproduced original analyses and conducted robustness checks of 110 articles recently published in leading economics and political science journals" | keine |
| 12–13 | Brodeur: "found more than 85% of them computationally reproducible" | korrekt | Abstract: "We found that over 85% of published claims were computationally reproducible" | keine |
| 13–15 | Brodeur: "72% of statistically significant estimates remained significant with the same sign under robustness checks chosen by the reproducers" | korrekt | Abstract: "In robustness checks, our re-analyses lead to 72% of statistically significant estimates to remain significant and in the same direction"; Abschnitt 13.5: "We group the robustness checks and coding exercises conducted by the reproducers into eight groups" – die Robustness Checks wurden von den Reanalysten gewählt, nicht von den Originalautoren | keine |
| 15–17 | Stodden: "Journal policy is what made this possible: where a policy is enforced, the artefacts are there to be run" | **falsch** | Abstract: "we were able to obtain artifacts from 44% of our sample and were able to reproduce the findings for 26%." Diskussion: "although it is a step in the right direction, this policy is insufficient to fully achieve the goal of computational reproducibility. Instead, we recommend that the journal verify deposit of relevant artifacts as a condition of publication" | Stodden findet das Gegenteil: Bei bestehender, aber bei Einreichung nicht verifizierter Science-Policy waren nur 44% der Artefakte erhältlich und nur 26% reproduzierbar; Verifikation bei Einreichung wird als noch fehlende Verbesserung empfohlen, nicht als Erklärung für einen bereits erreichten Zustand. Satz revidieren, z. B.: "Even a nominal policy leaves most artefacts unreachable unless deposit is verified at submission [Stodden_2018]", oder durch eine Quelle mit tatsächlich verifizierter Policy und hoher Verfügbarkeit ersetzen. |
| 17–20 | Naudet: "37 randomised trials … obtained data for 17, reproduced the primary result fully in 14 and reached the same conclusion in 16" | korrekt | Abstract: "37 RCTs … 17/37 (46%) satisfied the definition of data availability and 14 of the 17 (82%) were fully reproduced … errors were identified in two but reached similar conclusions" (14 voll reproduziert + 2 mit Fehlern, aber gleicher Schlussfolgerung = 16) | keine |
| 20–22 | Siebert: "10 of 62 (16%)", EMA-bewertete Studien | korrekt | Abstract: "Among the 62 studies randomly sampled, we received IPD for 10 trials … 10/62 trials (16% [95% CI 8% to 28%]) were reproduced"; Diskussion: "Ten out of 62 main trials (16%) used by the EMA in its approval processes were reproduced" | keine |
| 22–25 | Hardwicke 2018/2021: "analytic reproducibility … was limited by missing or unusable materials as much as by discrepant results" | **ungenau** | Hardwicke 2018 (Cognition): Materialverfügbarkeit war der dominante Flaschenhals ("approximately one-third of the shared data did not appear to be reusable in principle"). Hardwicke 2021 (Psychological Science) hat dieses Problem dagegen per Design ausgeschlossen: "we selected only articles that had reusable data … in order to … largely circumvent upstream issues related to data availability and data management and instead focus on downstream issues related to analytic reproducibility"; dort primäre Ursache: "Non-reproducibility was primarily caused by unclear reporting of analytic procedures." | Die beiden Studien haben nicht dieselbe Fehlerstruktur; das sollte differenziert werden, z. B.: "…was limited primarily by missing or unusable materials at Cognition, and, even where materials were already vetted as reusable, by unclear reporting of analytic procedures at Psychological Science [Hardwicke_2018; Hardwicke_2021]." |
| 27–29 | Jabouille: "In the journals of four national physiotherapy associations, 12% of 465 articles made data directly available" | korrekt | "the four journals published a total of 1,173 articles: 590 in PTJ (American Physical Therapy Association), 168 in Physiotherapy Canada …, 150 in Physiotherapy (UK …), and 265 in the Journal of Physiotherapy (Australian …). Of these articles, 465 (40%) were original research studies"; "Only 12% of articles made their data directly available in a public repository or as supplementary material" | keine |
| 29–30 | Elghzali: "authors of rehabilitation trials whose availability statements promised data on request were asked, 22.7% complied" | korrekt (Zahl aus Abstract wörtlich übernommen) | Abstract: "After emailing authors to verify their commitment to the reported DSS, only 22.7% adhered to them." | Kleine Unschärfe, kein Fehler im Manuskript: Table 4 der Quelle ergibt rechnerisch 59/251 ≈ 23,5% (interne Inkonsistenz der Quelle zwischen Abstract und Tabelle). Zusätzlich ist die Stichprobe nicht rein aus Trials (71% Clinical Trial, Rest Kohorten-/Querschnittsstudien); "rehabilitation trials" ist daher leicht zu eng, besser "rehabilitation studies". Optional anpassen. |
| 30–32 | Murphy: "14% of authors provided raw data on request, and 28% of attempted replications succeeded" | korrekt | "Of those, 14% (n = 21) shared data" (156 kontaktierte Autoren); Abstract: "7 (28%) studies demonstrated robust replicability, meeting all three validation criteria" – zwei unabhängige Zahlen, korrekt zugeordnet | keine |
| 32–34 | Dhanani: "recomputed the statistics of 572 trials from the numbers printed in the articles, without individual data" | korrekt | "Overall, 572 RCTs were selected involving six specialties." Methoden: "Studies were included if the primary outcome could be reproduced using the data and statistical test reported in the published manuscript" – Reanalyse ausschließlich anhand publizierter Kennzahlen, keine IPD | keine |
| 43–45 | "Multiverse analysis and specification curve analysis address this question by computing every defensible combination of analytical choices [Steegen_2016; Simonsohn_2020]" | korrekt | Steegen: "researchers could perform a multiverse analysis, which involves performing all analyses across the whole set of alternatively processed data sets … if several processing choices are defensible, researchers should perform a multiverse analysis"; Simonsohn: "specification curve analysis, which consists of three steps: (1) identifying the set of theoretically justified, statistically valid and non-redundant specifications" – beides Originalarbeiten, "defensible"-Sprache passend | keine |
| 45–48 | Nepomuceno: "613" Studien gesamt | korrekt | Abstract: "Of the 1545 classifiable articles, 613 (39.7%) implemented a multiverse-style analysis" | keine |
| 45–48 | Nepomuceno: "152 coded in depth" | korrekt | Methods: "A randomly selected subsample of 152 studies (one quarter of the studies classified as deploying a multiverse) was coded in greater depth" | keine |
| 45–48 | Nepomuceno: "8.6% were preregistered" | korrekt | "The multiverse itself was preregistered in only 13/152 studies (8.6%)" | keine |
| 45–48 | Nepomuceno: "3.9% justified their choice of specifications" | **ungenau** | "only 6/152 (3.9%) discussed this distinction" – bezogen konkret darauf, ob Autoren Äquivalenz/Verteidigbarkeit ihrer Spezifikationen im Sinne von Del Giudice & Gangestad (2021) diskutierten, nicht eine allgemeine Rechtfertigung der Spezifikationswahl | Präziser: "3.9% discussed whether their specifications were defensible/principled" statt "justified their choice of specifications" |
| 45–48 | Nepomuceno: "the median study computed 144 specifications" | **ungenau** (falsch zugeordnet) | Abstract: "The number of specifications ranged from fewer than ten to more than ten thousand (median = 144, IQR 24–1248)", berechnet über n=529 Studien mit extrahierbarer Anzahl – das ist eine Teilmenge der vollen 613-Stichprobe, NICHT der 152 tief kodierten Studien. Für die 152er-Subgruppe wird kein eigener Median berichtet. | Satz umstrukturieren, damit "144" klar der 613er-Ebene (n=529) zugeordnet ist statt der 152er-Subgruppe, z. B.: "Of 613 multiverse-style studies, the median study computed 144 specifications (n=529 with an extractable count); among the 152 coded in depth, 8.6% were preregistered, 3.9% discussed whether their specifications were defensible, and 82.2% reported the results descriptively without any inferential summary." |
| 45–48 | Nepomuceno: "82.2% reported the results descriptively without any inferential summary" | korrekt | "125/152 studies (82.2%) relied solely on a descriptive reading of the results" | keine |
| 49–53 | Del Giudice & Gangestad: Type E "equivalent in validity, estimand and precision" | korrekt, aber paraphrasiert | Original: "Alternative measures have comparable validity, alternative analyses examine the same effect, and the parameter of interest is estimated with comparable precision or power." Die drei Nichtäquivalenzkategorien heißen im Original "measurement nonequivalence", "effect nonequivalence" und "power/precision nonequivalence". Das Wort "estimand" kommt im Original nicht vor (per grep bestätigt); dort steht "the same effect" / "effect nonequivalence". | Inhaltlich korrekt, aber "estimand" ist keine Originalformulierung. Da im Manuskript nicht als wörtliches Zitat markiert, vertretbar; optional "estimand" durch "effect" ersetzen oder Paraphrasencharakter kenntlich machen. |
| 49–53 | Del Giudice & Gangestad: Type N "one option has justified precedence or the options answer different questions" | korrekt (Paraphrase) | Original: "the available evidence and other considerations support the conclusion that alternative specifications are not equivalent, and some are objectively more justified than others as a means of estimating the effect of interest"; zusätzlich zitiert das Paper Simonsohn et al.: "with and without a certain set of covariates are not different answers to the same question, they are different answers to different questions" | keine |
| 49–53 | Del Giudice & Gangestad: Type U "equivalence is uncertain" | korrekt | "Type U decisions: uncertainty. In some instances, there are no compelling reasons to expect equivalence or nonequivalence, or there is reason to expect nonequivalence, but insufficient information to specify which alternatives are better justified." | keine |
| 49–51 | Del Giudice & Gangestad: "a multiverse padded with options that are not equivalent can obscure a real effect" | korrekt (Paraphrase, kein Direktzitat) | Abstract: "if specifications are not truly arbitrary, multiverse-style analyses can produce misleading results, potentially hiding meaningful effects within a mass of poorly justified alternatives." Die Wörter "padded" und "obscure" kommen im Original nicht vor (grep ohne Treffer). | Inhaltlich deckungsgleiche Umschreibung, kein Zitat behauptet; keine Korrektur nötig. |
| 53–56 | Short et al.: Trennung defensibility (einzelne Pipeline) vs. equivalence (Pipelines untereinander) | korrekt | "Defensibility concerns whether a given analytical pipeline can be justified independently…"; Tabelle 2: "Equivalence (pipelines relative to each other) — … conceptual assessment of whether defensible pipelines can be expected a priori to yield practically equivalent answers … (Del Giudice & Gangestad, 2021)" | keine |
| 54–56 | Short et al.: "illusion of consistency" bei nahezu identischen Datensätzen | korrekt, wörtliches Zitat bestätigt | "Empirical similarity across data sets can produce the illusion of consistency rather than genuine robustness" | keine |
| 56–59 | Veltri: "preprocessing choices explained 76.9% of the variance of the effect estimate and model choices 7.5%" | korrekt, exakt | Abstract: "preprocessing decisions explain 76.9% of the total variance in estimated treatment effects, whereas model choice explains only 7.5%." | keine |
| 56–59 | Veltri: "simulated behavioural trial" | korrekt | Titel: "The Effects of Data Preprocessing Choices on Behavioral RCT Outcomes: A Multiverse Analysis"; Abstract: "two fully specified multiverse analyses on simulated RCT data" | keine |
| 58–59 | Veltri: "the simulation did not separate choices that change the estimand from choices that do not" | korrekt (Fehlen bestätigt) | Keine Treffer für "estimand", "different construct/question" oder "equivalen*" im Volltext; das Paper zerlegt Varianz rein ANOVA-basiert ohne Äquivalenz-/Estimand-Rahmen | keine |
| 59–60 | Crenshaw: "applied the multiverse approach to one clinical trial" | korrekt | Abstract: "…demonstrate the approach using data from a small randomized psychotherapy trial for posttraumatic stress disorder" – eine einzelne RCT (STRONG-STAR-Konsortium) | keine |
| 61–63 | Patel & Klau: "vibration of effects, has been studied for observational associations" | korrekt | Patel, Titel/Abstract: "a standardized approach to quantify the variability of results obtained with choices of adjustments called the 'vibration of effects' (VoE)"; Klau, Titel: "Examining the robustness of observational associations to model, measurement and sampling uncertainty with the vibration of effects framework" | keine |
| 63–64 | Silberzahn, Botvinik-Nezer, Breznau, Gould: "studies in which many analysts receive the same data have shown how far conclusions vary between competent analysts" | korrekt | Silberzahn, Titel: "Many analysts, one data set…"; Botvinik-Nezer (NARPS): "Variability in the analysis of a single neuroimaging dataset by many teams", 70 Analyseteams; Breznau: "we coordinated 161 researchers in 73 research teams … using the same data"; Gould: "Same data, different analysts…", 174 Analyseteams/246 Analysten | keine |

## Diskrepanzen im Zitierschlüssel (nicht inhaltlich, nur Jahr/Datei)

- **Veltri_2025** vs. Dateiname `01_Veltri_2026_…`: derselbe Artikel (Multivariate Behavioral Research, Vol. 61(2), 2026), online first 3. November 2025 – Zitierschlüssel folgt dem Online-Datum, kein Fehler.
- **Klau_2020** vs. Dateiname `28_Klau_2021_…`: derselbe Artikel (International Journal of Epidemiology), Advance-Access-Datum 5. November 2020, Druckausgabe 2021 – Zitierschlüssel folgt dem Online-Datum, kein Fehler.

## Zusätzlich geprüft, außerhalb des Zeilenbereichs 8–75 (zur Einordnung)

Diese Stellen liegen in Abschnitt 2 (Methods), betreffen aber dieselben Quellen und wurden im
Zuge der Prüfung mitverifiziert:

- Zeile 95–98: Brodeur-Zitat "should thus all be considered as not pre-registered" ist wörtlich
  exakt belegt (Original, Abschnitt 13.1: "Our re-analyses should thus all be considered as not
  pre-registered."). Der "[check wording]"-Hinweis im Manuskript kann entfernt werden.
- Zeile 197–199: Hardwicke-Kriterium "minor discrepancies below 10%, major discrepancies at or
  above 10%" ist korrekt (Original: "classified as 'minor' (0% > PE < 10%) or 'major' (PE ≥
  10%)"). Naudets Ablehnung eines 2%-Schwellenwerts ist ebenfalls korrekt belegt (Original:
  "we initially planned to consider non-reproducibility as a disagreement … by more than 2% …
  we believed that such a definition was sometimes meaningless … Accordingly, we changed our
  definition").
- Zeile 295: Der Schwellenwert 0.99 (Korrelation zwischen Pipeline-Outputs) stammt erkennbar aus
  der eigenen Analyse der Autoren, nicht aus Short et al. 2026; die Zuschreibung an Short betrifft
  nur das allgemeine Prinzip (Pipeline-Ähnlichkeit kann Robustheit vortäuschen), was durch das
  Paper gedeckt ist ("consistent results across the multiverse may be misinterpreted as
  robustness to analytical variation when they instead reflect underlying empirical
  similarity"). Empfehlung: im Manuskript klarstellen, dass 0.99 der eigene Schwellenwert ist.

## Zusammenfassung der nötigen Änderungen

1. **Stodden_2018 (Zeile 15–17)** — substanzieller Fehler, vor Einreichung zwingend zu
   korrigieren. Der Satz behauptet das Gegenteil des Stodden-Befunds.
2. **Hardwicke_2018/2021 (Zeile 22–25)** — ungenau, sollte präzisiert werden: die beiden Studien
   haben unterschiedliche Fehlerstrukturen (2018: primär Materialverfügbarkeit; 2021: primär
   unklare Berichterstattung der Analyse, da Materialverfügbarkeit dort per Design kontrolliert
   war).
3. **Nepomuceno_2026, "144" (Zeile 45–48)** — falsch zugeordnet: Zahl stammt aus n=529 (Teilmenge
   der 613 Studien), nicht aus den 152 tief kodierten Studien. Satzstruktur anpassen.
4. **Nepomuceno_2026, "3.9% justified their choice of specifications" (Zeile 45–48)** — leicht zu
   weit gefasste Paraphrase; präziser als "discussed whether specifications were
   defensible/principled" formulieren.
5. **Elghzali_2025, "rehabilitation trials" (Zeile 29–30)** — optional präzisieren zu
   "rehabilitation studies", da die Stichprobe auch Nicht-Trial-Designs enthält (71% Clinical
   Trial).

Alle übrigen 24 geprüften Zuschreibungen (Brodeur 110/>85%/72%/robustness-checks-Formulierung,
Naudet 37/17/14/16, Siebert 10/62/16%, Jabouille 12%/465/vier Verbände, Murphy 14%/28%, Dhanani
572, Steegen/Simonsohn, Nepomuceno 613/152/8.6%/82.2%, Del Giudice Type E/N/U und
"padded…obscure", Short defensibility/equivalence und "illusion of consistency", Veltri
76.9%/7.5%/"simulated behavioural trial", Crenshaw eine klinische Studie, Patel/Klau vibration of
effects, Silberzahn/Botvinik-Nezer/Breznau/Gould many-analysts) sind korrekt und wörtlich durch
die Originaltexte gedeckt.
