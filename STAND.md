# Stand der Ergebnisse, 2026-09-13 (nach dritter Korrekturrunde, adversariales Gutachten)

Kernzahlen dieser Runde: 16 Studien (12 Primär-, 4 Sekundärberichte). Stufe 2 mit echt
gefitteten publizierten Modellen (`R/stage2_published_models.R`, `R/stage2_classify.R`,
`output/stage2_final.csv`): 11 full, 0 minor, 1 major (Deload, Bayes ohne Priors), max.
absolute Differenz 0,014 SD, unser KI enthält den publizierten Wert in 12 von 12, p-Verdikt
gleich in 8 von 8. Die vier Papers ohne Punktschätzer (`R/stage2_no_estimate.R`,
`output/stage2_no_estimate.csv`): alle publizierten p-Werte reproduzieren exakt; bei
Phosphatidsäure ist die gedruckte F-Statistik 33,30 falsch (Interaktion F = 4,95). Zweites adversariales Gutachten (`manuscript/review_adversarial_round2.md`):
Major revision; fünf Modellabschnitte danach korrigiert (FREE Zeit als Faktor, SPADI GLM-
Äquivalent, eTRE drei Arme, TERECO ML, Lytras ohne Faktor 2).
Hauptmass seit 2026-09-13: Verschiebung des reproduzierten publizierten Ergebnisses
(`R/displacement.R`, `output/displacement_by_study.csv`): max|Delta| Median 0,15 SD (IQR
0,08 bis 0,28, max 0,41), keine Vorzeichenumkehr im E-Gitter; im defensible-Gitter in 2
Studien einzelne Umkehrungen. Estimand-preserving-Gitter: 196 Spezifikationen, Spannweite Median 0,12 SD (Bootstrap
0,09 bis 0,21), max 0,41, Vorzeichen stabil 16 von 16, Spearman mit Baseline-Ungleichgewicht
0,82. Striktes Gitter (ohne Baseline): Spannweite 0 in 12 von 16, max 0,04. Defensible:
0,24, Faktor 1,35. Ausreisserarm: max 1,08 (tDCS, MAD-Artefakt). Reporting: 8 von 12
Primärberichten mit registriertem primärem Outcome, 4 ohne. Die Abschnitte unten sind
teilweise noch vom 12.09. und werden beim nächsten Durchgang abgeglichen.

Alle Zahlen aus dem Lauf vom 2026-09-12 mit Registry v2 und reparierter Engine. Zahlen
aus früheren Läufen sind ungültig (siehe `METHODENPRUEFUNG.md`).

## Korpus

| Stufe | n |
|---|---:|
| Europe PMC gescreent | 423 |
| Repository-Link im Availability-Statement | 152 (91 RCTs) |
| Deposit erreichbar | 84 |
| Tabellendatei vorhanden | 74 (48 RCTs) |
| RCTs manuell geprüft | 48 |
| **Eingeschlossen** | **16** (13 Primärberichte, 3 Sekundärberichte) |
| Ausgeschlossen mit Grund | 32 (`config/exclusions.csv`) |

Flowchart: `output/figures/flowchart_funnel.png`. Zweiter Suchweg (Zenodo, Dryad): 127
studienartige Deposits, noch nicht Artikeln zugeordnet.

Strata nach Feld und Population (`config/registry.csv`): Physiotherapie/Reha an
Patienten 5, an Überlebenden 1, Steroidinjektion 1, Neuromodulation 1, Trainings- und
Ernährungsstudien an Gesunden 6, Bewegung in der Schwangerschaft 2.

## Stufe 1: Reporting der eingeschlossenen Papers

| Merkmal | n von 16 |
|---|---:|
| Primäres Outcome in Registrierung oder Methoden deklariert | 7 |
| Primäres Outcome nur aus dem Abstract ableitbar | 9 |
| Estimand benannt | 1 |
| Baseline-Signifikanztest berichtet | 13 |
| Journal mit Datenpflicht | 10 (6 unklar) |
| Punktschätzer der Gruppendifferenz berichtet | 12 |
| Nur p-Wert oder F-Statistik, kein Schätzer | 4 |

## Stufe 2: Computationale Reproduktion (`output/reproduction.csv`)

Von 12 Studien mit publiziertem Punktschätzer, Regel: gleiches Vorzeichen und (relative
Differenz ≤ 2 % oder absolute Differenz ≤ 0,02 SD) = vollständig; ≤ 10 % oder ≤ 0,05 SD =
klein; sonst gross.

| Klasse | n | Wilson 95 % | Studien |
|---|---:|---|---|
| Vollständig | 10 | 55 bis 95 % | Creatine, ETIP, eTRE, Lytras, tDCS, tSCS, TERECO 2,3 %, Mallorca 6,1 % / 0,020 SD, Gaining More 22 % / 0,017 SD, Physiofeedback 27 % / 0,016 SD |
| Kleine Abweichung | 2 | | SPADI 6,9 % / 0,063 SD, FREE 29 % / 0,040 SD |
| Grosse Abweichung | 0 | | |

Nur relative Regel (Hardwicke): 6 vollständig, 3 klein, 3 gross. Beide Kriterien stehen
in `output/reproduction.csv`.

Publizierte Spezifikation vollständig im Gitter abbildbar: 7 von 12 (nicht abbildbar:
Random Slopes, Bayes-Mehrebenenmodell, 14-Zeitpunkte-AR(1), cLDA mit Zentrum, Drei-Arm-LMM).

Der publizierte Schätzer liegt bei 9 von 12 Studien innerhalb der principled-Spannweite
und bei 12 von 12 innerhalb der defensible-Spannweite. Differenz publiziert minus
Multiverse-Median: Median 0,006 SD, Spannweite −0,055 bis 0,163 SD.

## Stufe 3: Multiverse (`output/summary_by_study.csv`, `output/multiverse_all.csv`)

Eindeutige Spezifikationen: 395 principled (3 bis 140 je Studie), 1 934 defensible (6 bis
672); gepoolter Duplikatanteil 4,4 % und 6,1 %. Nenner: gepoolte Innerhalb-Gruppen-SD des
Rohoutcomes je Studie.

| | principled (Typ E) | defensible (Typ E + N) |
|---|---|---|
| Spannweite von d, Median (Bootstrap 95 %) | 0,15 (0,08 bis 0,23) | 0,28 (0,10 bis 0,38) |
| Spannweite, IQR | 0,07 bis 0,23 | 0,09 bis 0,37 |
| Spannweite, Maximum | 1,08 (tDCS, n = 20) | 1,11 (tDCS) |
| Vorzeichen in allen Spezifikationen gleich | 15 von 16 (Wilson 72 bis 99 %) | 14 von 16 (64 bis 97 %) |
| Spannweite schliesst 0 ein | 1 (FREE) | 2 (FREE, ETIP) |

Verhältnis der Spannweiten defensible zu principled: Median 1,35 (Bootstrap 1,18 bis 1,52)
über 15 Studien mit endlichem Verhältnis.

Stratum klinischer Reha-Kontext (8 Studien): Spannweite Median 0,18, max 1,08. Stratum
Training und Ernährung, nicht-klinisch (8): Median 0,06, max 0,41. Deskriptiv.

Treiber der Spannweite (Spearman, 16 Punkte): n −0,04, Baseline-Ungleichgewicht 0,37
(12 Studien), Baseline-Endwert-Korrelation −0,10, Missing 0,01.

**Welcher Knoten bewegt den Schätzer** (Typ-II-Anteil je Studie, `output/variance_summary.csv`):

| Knoten | principled: grösster Anteil in | defensible: grösster Anteil in |
|---|---:|---:|
| Baseline-Behandlung | 10 von 15 | 7 von 16 |
| Ausreisserregel | 3 | 3 |
| Kovariaten | 2 | 1 |
| Log-Transformation (Typ N) | nicht im Gitter | 5 |
| Inferenzmethode | 0 (bewegt per Konstruktion nur das Intervall) | 0 |

Der Median-Anteil der Baseline-Behandlung ist 100 %, weil in 9 von 15 Studien im
principled-Gitter nur Baseline und Inferenz variieren und Inferenz den Schätzer nicht
bewegt. Die Inferenzmethode erklärt im Median 3,7 % der Streuung der Intervallbreite.
Sensitivität mit Baseline-Behandlung auf ANCOVA fixiert: Median-Spannweite 0,003 SD (`output/sensitivity_baseline_fixed.csv`). Sensitivität mit Zwei-Wege-Interaktionen (10 Studien-Gitter-Kombinationen mit ≥ 30
Spezifikationen): dominanter Knoten unverändert in 10 von 10, Interaktionsanteil Median 9 %.

## Unabhängige Nachrechnung (`R/independent_check.R`, `output/independent_check.csv`)

Ohne Engine und Gitter, nur Basis-R: je Studie Endwert, Change Score und ANCOVA aus den
Rohdaten, Nenner selbst berechnet. In 8 von 16 Studien ist die Spannweite über die drei
Baseline-Varianten identisch mit der principled-Spannweite der Pipeline (bis auf die
dritte Nachkommastelle); in den übrigen 8 ist die Pipeline-Spannweite grösser, weil dort
Ausreisserregel, Kovariaten oder Clusterung zusätzlich variieren. Die 12 Reproduktions-
Schätzer stimmen mit der jeweils passenden unabhängigen Variante überein (tSCS 7,666,
ETIP 2,597, Creatine 0,507, Lytras −1,200, tDCS 6,848, eTRE −2,919, SPADI −22,241).

## Integritätsscreen (`output/integrity_screen.csv`)

Carlisle-Test auf benannten Baseline-Variablen, Duplikatzeilen: kein Flag in 16 Studien.
Endziffern nur berichtet, weil viele primäre Outcomes abgeleitete Mittelwerte sind.

## Pipeline-Ähnlichkeit (`output/pipeline_similarity.csv`)

In 9 von 16 Studien korrelieren alle Preprocessing-Pipelines mit r > 0,99.
Vorzeichenstabilität ist dort keine Robustheitsaussage (Short et al. 2026). In der
Übersichtsgrafik wird das nicht mehr eingefärbt, muss aber im Text stehen.

## Grafiken (`output/figures/`)

- `flowchart_funnel.png/.pdf/.svg`
- `overview_all_studies.png`: beide Gitter, publizierter Schätzer als rotes Kreuz
- `speccurve_<study>.png`: 16 Kurven, principled und defensible nebeneinander, 95%-Band
- `variance_d.png`, `variance_ci_width_d.png`

## Was noch fehlt

0. **Registry v1 gegen v2** (`output/registry_v1_vs_v2*.csv`): 13 von 16 Studien geändert,
   Kontrollarm 10, Outcome 5, Kovariaten 11. Mit der finalen Engine gerechnet: Median-Betrag
   und Spannweite gleich, Vorzeichen des Medians in 7 von 16 gedreht.
1. **Zweitkodierung** der Registry v2 durch eine zweite Person (Formular in `coding/`).
2. Korpusentscheidung getroffen (2026-09-12): alle 16 im Hauptkorpus, Strata berichtet. Manuskript auf Englisch.
3. Meta-Analyse über Spezifikationen (Bartos et al.) und minP (Mandl et al.).
4. MCID je Studie erfassen (derzeit Default 0,2 SD).
5. Zweiter Suchweg: 127 Zenodo/Dryad-Deposits Artikeln zuordnen.
6. Quellen vollständig: 59 Einträge in `literature/manifest.csv`, alle als PDF.
7. Manuskript: vollständiger Entwurf in `manuscript/paper.md` (Abstract bis Conclusion, rund 7 000 Wörter), Tabellen in `manuscript/tables.md`. Jeder Abschnitt gegen Quellen und Output-Dateien geprüft (`manuscript/check_*.md`), Korrekturen eingearbeitet. Offen: Abbildungslegenden, Supplement-Zusammenstellung, Referenzliste rendern, Danksagung, Datenverfügbarkeits-DOI.
