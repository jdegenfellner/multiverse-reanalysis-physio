# Zahlenabgleich `manuscript/paper.md`, Abschnitte 2 (Methods) und 3 (Results)

Stand: 2026-09-12. Nachgerechnet mit Python (pandas) direkt gegen die Quelldateien und,
wo eine R-Datei den Wert erzeugt (Spearman-Korrelationen, Bootstrap-Konfidenzintervalle),
zusätzlich mit `Rscript` gegen `R/range_drivers.R` bzw. `R/uncertainty.R` verifiziert.
Wilson-Intervalle sind mit einer eigenen Implementierung der Standardformel nachgerechnet,
nicht nur aus `output/uncertainty_proportions.csv` übernommen.

Das Manuskript wurde während der Prüfung um die Abschnitte 1, 4 und 5 erweitert; das
betrifft die Abschnitte 2 und 3 nicht (Zeilen- und Textinhalt identisch geprüft).

Befund-Legende: **stimmt** = exakt (auf Rundung) reproduzierbar; **weicht ab** = eigene
Berechnung ergibt einen anderen Wert; **nicht prüfbar** = keine Datei im Projekt enthält
die Rohgrösse.

## 2. Methods

| Abschnitt | Zahl im Text | Quelle | nachgerechnet | Befund |
|---|---|---|---|---|
| 2.2 | Suche ergab 423 Datensätze | `candidates/clinical_studies_with_repos.csv` | 423 Zeilen | stimmt |
| 2.2 | "von 107 auf 4" (Treffer mit Code und Daten, Volltext vs. Availability-Statement) | — (kein Output im Projekt; nur README.md/OUTLINE.md-Prosa) | 4 bestätigt (`clinical_studies_with_repos.csv`: `n_code>0 & n_data>0` → 4 Zeilen); 107 in keiner Datei | 4: stimmt; 107: **nicht prüfbar** |
| 2.2 | 152 Studien, davon 91 RCT | `candidates/deposit_contents.csv` | 152 Zeilen; `is_rct==True` → 91 | stimmt |
| 2.2 | Zenodo: 25 Datensätze/Seite, 30 Anfragen/Minute | Kommentar in README.md, nicht in Code als Zahl abgelegt | Rate-Limits von Zenodo, nicht aus Studiendaten prüfbar | nicht prüfbar (externe API-Doku, nicht Teil der Projektdaten) |
| 2.2 | 84 erreichbare Deposits, 74 mit Tabellendatei, 48 davon RCT | `candidates/deposit_contents.csv` | `n_files>0` → 84; davon `n_tabular>0` → 74; davon `is_rct==True` → 48 | stimmt |
| 2.2 | zweite Route: 127 studienartige Deposits | `candidates/repo_deposits_trials.csv` | 127 Zeilen | stimmt |
| 2.3 | 21 Kandidatenpapiere mit Verbatim-Zitaten | `config/published.csv` | 21 Zeilen | stimmt |
| 2.6 | Gitter: 22 Optionen über acht Knoten | `R/grid.R` (`NODES`) | 8 Knoten (baseline 3, covars 3, outlier 4, model 2, inference 3, missing 3, transform 2, outlier_scope 2) → Summe 22 | stimmt |
| 2.6 | eindeutige Spezifikationen je Studie: 3–140 (principled), 6–672 (defensible) | `output/duplicates.csv` | principled `n_unique`: min 3, max 140; defensible: min 6, max 672 | stimmt |
| 2.6 | Multiple Imputation mit 20 Imputationen | `R/engine.R`, `MI_M` | `MI_M <- 20` | stimmt |
| 2.6 | Permutationstest mit 4 999 Permutationen | `R/engine.R`, `N_PERM` | `N_PERM <- 4999` | stimmt |
| 2.7 | s-Wert-Deckel bei Permutation: 12,3 Bit | Berechnung aus `N_PERM` | −log2(1/(N_PERM+1)) = −log2(1/5000) = 12,2877 → 12,3 | stimmt |

## 3. Results

### 3.1 Feasibility

| Abschnitt | Zahl im Text | Quelle | nachgerechnet | Befund |
|---|---|---|---|---|
| 3.1 | 423 Datensätze, 152 mit Repository-Link, davon 91 RCT | `candidates/clinical_studies_with_repos.csv`, `candidates/deposit_contents.csv` | wie 2.2 | stimmt |
| 3.1 | 68 Deposits nicht abrufbar | `deposit_contents.csv` | 152 − 84 (`n_files>0`) = 68 | stimmt |
| 3.1 | 10 erreichbare Deposits ohne Tabellendatei | `deposit_contents.csv` | 84 − 74 (`n_tabular>0`) = 10 | stimmt |
| 3.1 | 26 der verbleibenden 74 nicht randomisiert | `deposit_contents.csv` | 74 − 48 (`is_rct`) = 26 | stimmt |
| 3.1 | **"48 randomisierte Studien ... 33 % derer mit Link"** | `deposit_contents.csv` (48 von 152) | 48/152 = 31,6 % | **weicht ab**: korrekt ≈ 32 % (31,6 %), nicht 33 % |
| 3.1 | 17 Ausschlüsse Design: Crossover 5, nicht klinisch 4, Feasibility 3, nicht randomisiert 2, within-person 2, binäres Outcome 1 | `config/exclusions.csv`, `category=="design"` | `reason_code`-Zählung: crossover_design 5, not_clinical 4, feasibility_primary 3, not_rct 2, within_person_design 2, binary_outcome 1; Summe 17 | stimmt |
| 3.1 | 11 Ausschlüsse Daten: Allokation 3, Outcome 2, nur Rohsignale 2, Zeitpunkt 1, Summary-Tabelle 1, README ohne Daten 1, nicht maschinenlesbar 1 | `config/exclusions.csv`, `category=="data"` | arm_not_in_data 3, outcome_not_identifiable 2, outcome_data_not_tabular 2, outcome_timepoint_not_in_deposit 1, no_ipd 1, no_data_in_deposit 1, file_not_readable 1; Summe 11 | stimmt |
| 3.1 | 2 ohne Armkontrast (Netzwerk-/Mediationsanalyse) | `config/exclusions.csv`, `category=="no_estimate"` | 2 Zeilen (ODI-Netzwerkanalyse PMC8830646, ImPuls-Mediationsanalyse PMC12885332) | stimmt |
| 3.1 | 2 Sekundäranalysen bereits eingeschlossener Datensätze | `config/exclusions.csv`, `category=="duplicate"` | 2 Zeilen (Frozen-Shoulder-Duplikat von SPADI, TERECO-Duplikat) | stimmt |
| 3.1 | Gesamtausschlüsse 17+11+2+2 = 32 | `config/exclusions.csv` | 32 Zeilen insgesamt | stimmt |
| 3.1 | 16 Studien in Stufe 2/3, 33 % der 48 (Wilson 22–47 %) | `config/registry.csv` (16 Zeilen) | 16/48 = 33,3 %; eigenes Wilson: 21,7–47,5 % → 22–47 % | stimmt |
| 3.1 | 11 % der 152 mit Link (7–16 %) | `config/registry.csv`, `deposit_contents.csv` | 16/152 = 10,5 %; Wilson 6,6–16,4 % → 7–16 % | stimmt |
| 3.1 | 13 primäre, 3 sekundäre Berichte | `config/registry.csv`, `report_type` | primary 13, secondary 3 | stimmt |
| 3.1 | Deposits: OSF 7, Zenodo 6, Dryad 3; 2 mit Analysecode | `config/registry.csv` × `candidates/deposit_contents.csv` (per PMCID verknüpft) | hosts: osf 7, zenodo 6, dryad 3; `n_code_files>0` → 2 (physiofeedback, clusterset) | stimmt |
| 3.1 | Strata: 6 Physio/Reha, 1 Neuromodulation, 1 Frozen Shoulder, 6 Training/Ernährung gesund, 2 Schwangerschaft (6/1/1/6/2) | `config/registry.csv`, Felder `field` × `population` | physiotherapy_rehabilitation 6; neuromodulation 1; other(Frozen Shoulder) 1; (exercise_physiology+sports_nutrition) & healthy 6; pregnant 2; Summe 16 | stimmt |
| 3.1 | "Eight interventions were delivered by physiotherapists" | `config/published.csv`, `delivered_by`, 16 Registry-Studien | `delivered_by=="physiotherapist"` → 8 | stimmt |
| 3.1 | randomisiert 18 bis 404 | `config/published.csv`, `n_randomised`, 16 Registry-Studien | min 18 (phosphatidic), max 404 (physiofeedback) | stimmt |
| 3.1 | analysierbar 16 bis 294 | `output/range_drivers.csv`, Spalte `n` | min 16 (etre), max 294 (mallorca) | stimmt |

### 3.2 Reproduction

| Abschnitt | Zahl im Text | Quelle | nachgerechnet | Befund |
|---|---|---|---|---|
| 3.2 | 12 von 16 mit Punktschätzer | `output/reproduction.csv`, `class` | `class!="no_point_estimate"` → 12 | stimmt |
| 3.2 | 10 volle Reproduktion (83 %, Wilson 55–95 %) | `output/reproduction.csv` | `class=="full"` → 10/12 = 83,3 %; Wilson 55,2–95,3 % → 55–95 % | stimmt |
| 3.2 | 2 geringe, 0 grosse Diskrepanz | `output/reproduction.csv` | `minor_discrepancy` 2 (free, spadi); `major` 0 | stimmt |
| 3.2 | Frozen-Shoulder-Studie: 6,9 %, 0,063 SD | `output/reproduction.csv`, spadi_PMC4880881 | `rel_diff` 6,93 %; `abs_diff_sd` 0,0632 | stimmt |
| 3.2 | FREE-Studie: 29 %, 0,040 SD | `output/reproduction.csv`, free_PMC6733445 | `rel_diff` 29,30 %; `abs_diff_sd` 0,0400 | stimmt |
| 3.2 | relatives Kriterium allein: 6 voll, 3 gering, 3 gross | `output/reproduction.csv`, `rel_diff` neu klassifiziert (≤2 %/≤10 %/>10 %) | voll: creatine, etip, etre, lytras_fms, tdcs, tscs = 6; gering: mallorca, spadi, tereco = 3; gross: free, gainingmore, physiofeedback = 3 | stimmt |
| 3.2 | die 3 relativ "grossen" Diskrepanzen: 0,016–0,040 SD | `output/reproduction.csv` | free 0,0400; gainingmore 0,0168; physiofeedback 0,0161 → Bereich 0,016–0,040 | stimmt |
| 3.2 | absolute Differenzen 0,000–0,063 SD über 12 Studien | `output/reproduction.csv`, `abs_diff_sd` | min 0,000 (lytras_fms), max 0,0632 (spadi) | stimmt |
| 3.2 | Spezifikation vollständig abbildbar: 7 von 12 (58 %, 32–81 %) | `output/reproduction.csv`, `spec_fully_matched` | 7 `True` von 12; Wilson 32,0–80,7 % → 32–81 % | stimmt |
| 3.2 | publizierter Schätzer im principled-Bereich: 9 von 12 (75 %, 47–91 %) | `output/reproduction.csv`, `inside_principled` | 9/12 = 75 %; Wilson 46,8–91,1 % → 47–91 % | stimmt |
| 3.2 | im defensible-Bereich: 12 von 12 (76–100 %) | `output/reproduction.csv`, `inside_defensible` | 12/12; Wilson 75,8–100 % → 76–100 % | stimmt |
| 3.2 | Differenz publiziert − Median principled: Median 0,006, Bereich −0,055 bis 0,163 | `output/published_minus_median.csv` (12 Zeilen) | Median 0,00640; Min −0,0546; Max 0,1630 | stimmt |
| 3.2 | 12 von 152 (8 %, 5–13 %) | wie oben, Nenner 152 | 12/152 = 7,89 %; Wilson 4,6–13,3 % → 5–13 % | stimmt |
| 3.2 | 12 von 48 (25 %, 15–39 %) | wie oben, Nenner 48 | 12/48 = 25 %; Wilson 14,9–38,8 % → 15–39 % | stimmt |

### 3.3 Fragility over equivalent choices

| Abschnitt | Zahl im Text | Quelle | nachgerechnet | Befund |
|---|---|---|---|---|
| 3.3 | 395 eindeutige Spezifikationen, 3–140 je Studie, 4,4 % Duplikate | `output/duplicates.csv` (principled) | Summe `n_unique` = 395; Bereich 3–140; `1 − 395/413` = 4,36 % → 4,4 % | stimmt |
| 3.3 | Median-Spannweite 0,15 SD (Bootstrap 0,08–0,23; IQR 0,07–0,23) | `output/summary_by_study.csv` (principled, `d_range`); `R/uncertainty.R` neu ausgeführt | Median 0,1498; Bootstrap-CI (`set.seed(20260912)`, B=5000) 0,0795–0,2291 → 0,08–0,23; IQR 0,070–0,233 → 0,07–0,23 | stimmt |
| 3.3 | grösste Spannweite 1,08 SD, tDCS-Studie, n=20 | `output/summary_by_study.csv`; `output/range_drivers.csv` | tdcs_PMC13257960: `d_range` 1,0785 → 1,08; `n` 20 | stimmt |
| 3.3 | **"the next largest are 0.40 and 0.33"** | `output/summary_by_study.csv` (principled), unabhängig auch aus `output/multiverse_all.csv` neu berechnet | zweitgrösste: gainingmore_PMC10809978 = 0,4075 → 0,41; drittgrösste: tscs_PMC13085461 = 0,3863 → 0,39 | **weicht ab**: korrekt 0,41 und 0,39, nicht 0,40 und 0,33 (siehe Anmerkung unten) |
| 3.3 | Vorzeichen in 15 von 16 Studien stabil (72–99 %), FREE mit Nulldurchgang | `output/summary_by_study.csv` (principled), `share_same_sign`, `d_min`/`d_max` | `share_same_sign==1` → 15; Wilson 71,7–98,9 % → 72–99 %; free_PMC6733445 ist die einzige mit `d_min<0<d_max` | stimmt |
| 3.3 | s-Werte je Studie 0,5–19,1 Bit (Median 5,2) | `output/summary_by_study.csv` (principled), `s_median` | min 0,482 → 0,5; max 19,122 → 19,1; Median 5,201 → 5,2 | stimmt |
| 3.3 | Baseline dominiert Schätzervarianz in 10 von 15 Studien, Ausreisserregel 3, Kovariaten 2 | `output/variance_summary.csv` (principled, target=d, `top_in`) | baseline 10, outlier 3, covars 2, model 0, inference 0; Summe 15 | stimmt |
| 3.3 | **"in 9 of the 15 trials only baseline handling and the inference method vary"** | `output/multiverse_all.csv` (principled), je Studie Knoten mit `nunique>1` gezählt; gegengeprüft mit `output/variance_by_study.csv` | exakt {baseline, inference} varriert in 7 von 15 Studien (creatine, gainingmore, lytras_fms, mulligan, phosphatidic, spadi, tscs), nicht 9 | **weicht ab**: korrekt 7 von 15, nicht 9 |
| 3.3 | Intervallbreite: Baseline 10, Ausreisser 3, Kovariaten 1, Inferenz 1; Inferenz Median 3,7 % | `output/variance_summary.csv` (principled, target=ci_width_d) | `top_in`: baseline 10, outlier 3, covars 1, inference 1; `median_share` Inferenz 3,72 % → 3,7 % | stimmt |
| 3.3 | Interaktions-Sensitivität: 10 Studien-Gitter-Kombinationen ≥30 Spezifikationen, Knoten unverändert, Median 9 % | `output/variance_interactions.csv` | 10 Zeilen, alle `n_spec≥30`; `top_additive==top_interaction_model` in allen 10; Median `share_all_interactions` 9,11 % → 9 % | stimmt |
| 3.3 | **Spearman Spannweite × Stichprobengrösse: −0,04 (16 Studien)** | `output/range_drivers.csv`; mit `Rscript` gegen `R/range_drivers.R`-Formel exakt nachgerechnet | ρ = −0,056 (n=16) | **weicht ab**: korrekt ≈ −0,06, nicht −0,04 |
| 3.3 | **Spearman Spannweite × Anteil fehlender Werte: 0,01** | `output/range_drivers.csv`, R nachgerechnet | ρ = 0,023 (n=16) | **weicht ab**: korrekt ≈ 0,02, nicht 0,01 |
| 3.3 | **Spearman Spannweite × Baseline-Ungleichgewicht: 0,37 (12 Studien mit Baseline)** | `output/range_drivers.csv`, R nachgerechnet | ρ = 0,413 (n=12) | **weicht ab**: korrekt ≈ 0,41, nicht 0,37 |
| 3.3 | **Spearman Spannweite × Baseline-Endwert-Korrelation: −0,10 (12 Studien)** | `output/range_drivers.csv`, R nachgerechnet | ρ = −0,056 (n=12) | **weicht ab**: korrekt ≈ −0,06, nicht −0,10 |
| 3.3 | 8 klinische Reha-Studien: Median 0,18 SD, Max 1,08 | `config/registry.csv` (`field`) × `output/summary_by_study.csv` (principled) | Gruppe physiotherapy_rehabilitation+neuromodulation+other (n=8): Median 0,1775 → 0,18; Max 1,0785 → 1,08 | stimmt |
| 3.3 | 8 Trainings-/Ernährungsstudien: Median 0,06, Max 0,41 | wie oben, Gruppe exercise_physiology+sports_nutrition (n=8) | Median 0,0607 → 0,06; Max 0,4075 → 0,41 | stimmt |
| 3.3 | 9 von 16 Studien: alle Pipeline-Paare r>0,99 | `output/pipeline_similarity.csv`, `cor_min` | `cor_min>0.99` → 9 Studien | stimmt |
| 3.3 | Integritäts-Screen kein Flag | `output/integrity_screen.csv`, `flag` | alle 16 Zeilen `flag=="pass"` | stimmt |

### 3.4 Estimand versus analysis

| Abschnitt | Zahl im Text | Quelle | nachgerechnet | Befund |
|---|---|---|---|---|
| 3.4 | 1 934 eindeutige Spezifikationen, 6–672 je Studie, 6,1 % Duplikate | `output/duplicates.csv` (defensible) | Summe `n_unique` = 1934; Bereich 6–672; `1 − 1934/2060` = 6,12 % → 6,1 % | stimmt |
| 3.4 | Median-Spannweite 0,28 SD (Bootstrap 0,10–0,38; IQR 0,09–0,37), Max 1,11 (tDCS) | `output/summary_by_study.csv` (defensible, `d_range`); `R/uncertainty.R` | Median 0,2828; Bootstrap 0,0992–0,3809 → 0,10–0,38; IQR 0,090–0,367 → 0,09–0,37; Max 1,1072 → 1,11 (tdcs) | stimmt |
| 3.4 | Vorzeichen stabil in 14 von 16 (64–97 %); Nulldurchgang bei FREE und ETIP | `output/summary_by_study.csv` (defensible), `share_same_sign` | 14/16 = 87,5 %; Wilson 64,0–96,5 % → 64–97 %; etip_PMC6886967 und free_PMC6733445 sind die einzigen mit `d_min<0<d_max` | stimmt |
| 3.4 | Verhältnis defensible/principled: Median 1,35 (Bootstrap 1,18–1,52), über 15 Studien mit Spannweite>0 | `output/summary_grids_compared.csv`, `range_ratio_def_vs_princ`; `R/uncertainty.R` neu ausgeführt | 15 endliche Verhältnisse (etre = Inf ausgeschlossen); Median 1,3521; Bootstrap 1,1810–1,5249 → 1,18–1,52 | stimmt |
| 3.4 | **eTRE-Studie: principled-Spannweite 0, defensible-Spannweite 0,01** | `output/multiverse_all.csv`, `output/summary_by_study.csv`, etre_PMC11945196 | principled `d_range` = 0 (bestätigt: alle Typ-E-Knoten "nicht anwendbar" laut `output/nodes_not_applicable.csv`); defensible `d_range` = 0,019407 → 0,02 | **weicht ab**: defensible-Spannweite ist 0,02, nicht 0,01 |
| 3.4 | Baseline dominiert weiterhin in 7 von 16, Log-Transformation 5, Ausreisser 3, Kovariaten 1, Missing-Strategie 0 | `output/variance_summary.csv` (defensible, target=d, `top_in`) | baseline 7, transform 5, outlier 3, covars 1, missing 0; Summe 16 | stimmt |

### 3.5 Reporting, and the effect of our own mapping

| Abschnitt | Zahl im Text | Quelle | nachgerechnet | Befund |
|---|---|---|---|---|
| 3.5 (Table 2) | primäres Outcome: 1 aus Registrierung, 6 aus Methods, 9 nur aus Abstract erschliessbar | `config/registry.csv`, `primary_declared` | registration 1, methods_first_named 6, abstract 9; Summe 16 | stimmt |
| 3.5 | 12 mit Punktschätzer, 4 nur p-Wert/F-Statistik | `output/reproduction.csv`, `class` | wie 3.2: 12 mit Schätzer, 4 `no_point_estimate` | stimmt |
| 3.5 | 1 Paper nennt ein Estimand | `config/published.csv`, `C_estimand_stated`, 16 Registry-Studien | `yes` → 1 | stimmt |
| 3.5 | 13 mit Baseline-Signifikanztest, 3 davon mit Adjustierungsentscheid danach | `config/published.csv`, `C_baseline_test_reported`, `C_adjust_after_baseline_test` | `C_baseline_test_reported=="yes"` → 13; `C_adjust_after_baseline_test=="yes"` → 3 | stimmt |
| 3.5 | keine Studie berichtet eine Ausreisserregel | `config/published.csv`, `B_outlier_rule` | alle 16 `not_reported` | stimmt |
| 3.5 | Baseline-Handhabung: ANCOVA 6, Change Score 4, Follow-up-Wert 2, sonstige 4 | `config/published.csv`, `B_baseline_handling` | ancova 6, change 4, endpoint 2, other 4 | stimmt |
| 3.5 | Modellfamilien: ANOVA 5, Mixed Models 6, ANCOVA 3, t-Test 1, nichtparametrisch 1 | `config/published.csv`, `B_model_family` | anova 5, (mixed_ri 5 + mixed_slopes 1) 6, lm_ancova 3, ttest 1, nonparam 1 | stimmt |
| 3.5 | 7 ohne fehlende Werte; von den restlichen 9: 4 Complete Case, 3 Likelihood-Longitudinalmodelle, 1 Multiple Imputation, 1 ohne Angabe | `config/published.csv`, `B_missing_strategy` | none_missing 7; complete_case 4, mmrm_ml 3, mi 1, not_reported 1 (Summe 9) | stimmt |
| 3.5 | 2 Papers modellieren Clustering (1 Zentrum, 1 Therapeut) | `config/published.csv`, `B_clustering_modelled` | site 1, therapist 1 | stimmt |
| 3.5 | Protokoll verfügbar für 7, nur Registrierung für 6, keins für 3 | `config/published.csv`, `C_protocol_available` | yes 7, registration_only 6, no 3 | stimmt |
| 3.5 | 10 Zeitschriften mit Datenteilungspflicht, bei 6 unklar | `config/published.csv`, `journal_requires_data_sharing` | yes 10, unclear 6 | stimmt |
| 3.5 | Erstkartierung vs. regelbasierte Kartierung: Unterschied in 13 von 16 | `output/registry_v1_vs_v2_fields.csv`, `any_changed` | `any_changed==True` → 13 | stimmt |
| 3.5 | Kontrollarm anders kodiert in 10, Outcome in 5, Kovariaten in 11, Baseline-Variable in 3, Datei in 1 | `output/registry_v1_vs_v2_fields.csv` | `arm_control_changed` 10; `outcome_var_changed` 5; `covars_published_changed` 11; `baseline_var_changed` 3; `data_file_changed` 1 | stimmt |
| 3.5 | Erstkartierung durch finale Pipeline: Median \|d\| 0,24 gegen 0,25; Median principled-Spannweite 0,16 gegen 0,14; Vorzeichenwechsel in 7 von 16 | `output/registry_v1_vs_v2.csv` (Spalten `v1_med`, `v2_med`, `v1_range`, `v2_range`, `sign_flip`) | Median\|v1_med\| 0,2420 → 0,24; Median\|v2_med\| 0,2458 → 0,25; Median v1_range 0,1567 → 0,16; Median v2_range 0,1433 → 0,14; `sign_flip` Summe = 7 | stimmt (Anmerkung: Quelldatei `output/registry_v1_vs_v2.csv`, Zeitstempel 12.9. 16:02, ist älter als der letzte Lauf der Gitter-/Engine-Revision um 17:27–17:41 desselben Tages; ein Skript, das genau diese Datei mit `v1_med`/`v2_med`/`sign_flip` erzeugt, liegt im aktuellen Repository nicht mehr vor. Die Zahlen im Text stimmen mit der vorhandenen Datei exakt überein, sind aber nur so lange nachvollziehbar, wie diese Datei nicht neu berechnet wird) |

## Abweichungen im Überblick (mit korrektem Wert)

1. **3.1**, "48 randomised trials with a readable data file, 33% of those with a link" –
   48/152 = 31,6 %, korrekt gerundet **32 %**, nicht 33 %. (Die 33 % gehören zu einer
   anderen Quote weiter unten im selben Absatz, 16/48.)

2. **3.3**, "the next largest are 0.40 and 0.33" (zweit- und drittgrösste
   principled-Spannweite nach der tDCS-Studie) – korrekt **0,41** (gainingmore,
   `d_range` 0,4075) und **0,39** (tscs, `d_range` 0,3863), unabhängig aus
   `output/summary_by_study.csv` und `output/multiverse_all.csv` bestätigt. Die im Text
   stehenden Werte 0,40 und 0,33 entsprechen auffällig genau `v1_range` (0,4038) und
   `v2_range` (0,3275) der Studie tscs in der älteren, nicht mehr per Skript
   reproduzierbaren Datei `output/registry_v1_vs_v2.csv` — vermutlich eine Verwechslung
   der Quelle beim Schreiben dieses Satzes.

3. **3.3**, "in 9 of the 15 trials only baseline handling and the inference method vary
   in the principled grid" – korrekt **7 von 15** Studien (creatine, gainingmore,
   lytras_fms, mulligan, phosphatidic, spadi, tscs), direkt aus
   `output/multiverse_all.csv` (Knoten mit mehr als einem realisierten Wert je Studie,
   principled-Gitter) und gegengeprüft mit `output/variance_by_study.csv` ausgezählt.

4. **3.3**, Spearman-Korrelationen der principled-Spannweite (vier Werte im selben
   Absatz, alle mit `output/range_drivers.csv` per R und Python identisch nachgerechnet):
   - Stichprobengrösse: Text −0,04, korrekt **≈ −0,06** (ρ = −0,0559, n=16)
   - Anteil fehlender Werte: Text 0,01, korrekt **≈ 0,02** (ρ = 0,0227, n=16)
   - Baseline-Ungleichgewicht: Text 0,37, korrekt **≈ 0,41** (ρ = 0,4126, n=12)
   - Baseline-Endwert-Korrelation: Text −0,10, korrekt **≈ −0,06** (ρ = −0,0559, n=12)

5. **3.4**, "in the time-restricted eating trial the principled range is zero ... and
   the defensible range is 0.01" – korrekt **0,02** (`d_range` = 0,019407 für
   etre_PMC11945196, defensible-Gitter, aus `output/summary_by_study.csv` und
   `output/multiverse_all.csv`).

## Nicht prüfbar

- **2.2**, "reduced apparent matches with both code and data from 107 to 4": Die Zahl
  4 ist aus `candidates/clinical_studies_with_repos.csv` bestätigt
  (`n_code>0 & n_data>0` → 4 Zeilen). Für die 107 (Treffer bei ungefiltertem
  Volltext-Scan vor der Beschränkung auf das Availability-Statement) existiert keine
  Ausgabedatei im Projekt; sie wird nur in `README.md` und `manuscript/OUTLINE.md` als
  Prosa-Aussage wiederholt, nicht aber als reproduzierbares Zwischenergebnis
  (`R/screen_repos.py`, das den ungefilterten ersten Durchlauf erzeugt, schreibt keine
  Ausgabe mehr, die diese Zahl enthält).

## Anmerkung zur Nachvollziehbarkeit der Pipeline

Die für Abschnitt 3.3/3.4 zentralen Ausgabedateien (`output/multiverse_all.csv`,
`output/summary_by_study.csv`, `output/variance_summary.csv`, `output/duplicates.csv`,
`output/nodes_not_applicable.csv`, `output/range_drivers.csv`,
`output/uncertainty_medians.csv`) stammen alle aus demselben letzten Pipeline-Lauf am
12.9.2026, 17:27–17:42 Uhr, nach der in `R/grid.R` dokumentierten Revision vom
11./12.9.2026. `R/uncertainty.R` wurde probeweise erneut ausgeführt und erzeugte
bytegleiche Kopien von `output/uncertainty_medians.csv`,
`output/uncertainty_proportions.csv` und `output/published_minus_median.csv` — die
Bootstrap-Zahlen sind also mit dem hinterlegten Seed (`set.seed(20260912)`) exakt
reproduzierbar. Einzige Ausnahme ist `output/registry_v1_vs_v2.csv`
(Zeitstempel 12.9., 16:02 Uhr), die vor dieser letzten Revision entstand und deren
erzeugendes Skript nicht mehr im Repository vorliegt; die darin verwendeten Zahlen
stimmen zwar exakt mit dem Manuskripttext überein, sollten aber vor Einreichung mit
einem frischen, aktuell nachvollziehbaren Skript neu erzeugt werden.
