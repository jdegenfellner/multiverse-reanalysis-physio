# Zahlenabgleich `paper.md` / `tables.md` gegen die Datenquellen (Version vom 2026-09-13, 08:33 Uhr)

Geprüft mit Python/pandas gegen die in der Aufgabe genannten Dateien (Stand aller Quellen
2026-09-13). Hinweis zur Aktualität: Die Analyse-Pipeline lief während der Prüfung noch;
`output/stage2_final.csv`, `output/stage2_comparison.csv`, `output/stage2_published_models.csv`,
`output/published_minus_median.csv`, `output/uncertainty_medians.csv` und
`output/uncertainty_proportions.csv` wurden um 08:32 Uhr neu geschrieben, `manuscript/paper.md`
und `manuscript/tables.md` um 08:33 Uhr. Alle übrigen `output/*.csv`-Dateien (u. a.
`multiverse_all.csv`, `summary_by_study.csv`, `duplicates.csv`, `variance_summary.csv`,
`variance_interactions.csv`, `range_drivers.csv`, `pipeline_similarity.csv`,
`integrity_screen.csv`, `registry_v1_vs_v2*.csv`, `reproduction.csv`) stammen aus einem
früheren, seit 08:07 Uhr unveränderten Lauf und sind von der letzten Stufe-2-Überarbeitung
nicht betroffen. Alle Zahlen unten sind gegen den ab 08:33 Uhr stabilen Manuskriptstand
geprüft (letzte Kontrolle 08:59 Uhr, keine weitere Änderung).

Legende Befund: ✓ bestätigt · ~ bestätigt mit Rundungshinweis · ✗ Abweichung · (extern) Literaturzitat, nicht aus den gelisteten Datenquellen prüfbar.

## Abstract

| Zahl | Quelle | Nachgerechnet | Befund |
|---|---|---|---|
| 423 Records | `candidates/clinical_studies_with_repos.csv` | 424 Zeilen − 1 Header = 423 | ✓ |
| 152 Studien mit Repo-Link | `candidates/deposit_contents.csv` | 153 Zeilen − 1 = 152 | ✓ |
| 48 RCT mit lesbarer Datei | `candidates/deposit_contents.csv` | reachable (n_files>0) & tabellarisch (n_tabular≥1) & is_rct=True → 48 | ✓ |
| 16 Studien, 11 % der 152, 104/136 Verluste, 32 danach, 11 Daten | `candidates/deposit_contents.csv`, `config/exclusions.csv` | 152→48: 104 Verluste (68 unreachable+10 ohne Tabelle+26 nicht randomisiert); 48→16: 32 Verluste (`exclusions.csv`: 32 Zeilen, category design=17, data=11, duplicate=2, no_estimate=2); 16/152=10,5 %→11 % | ✓ |
| Fitting … 11 von 12 Punktschätzern, alle 12 auf 0,014 SD | `output/stage2_final.csv` | class-Verteilung: full=11, major=1; max(abs_sd)=0,01403→0,014; median(abs_sd)=0,00089→0,001 (Ergebnisteil) | ✓ |
| 196 Spezifikationen (estimand-preserving) | `output/summary_by_study.csv` (principled), `output/duplicates.csv` | Σn_spec(unique)=196; share_dup=1,01 % | ✓ |
| Median 0,12 SD (0,09–0,21) | `output/uncertainty_medians.csv` | 0,1192 (0,0917–0,2125) | ✓ |
| Vorzeichen nie geändert | `output/summary_by_study.csv` | share_same_sign=1,0 in allen 16 Zeilen (principled) | ✓ |
| 11 von 16 nur baseline handling variabel | `output/multiverse_all.csv` (principled, is_dup=FALSE) | genau 11 Studien mit ausschließlich baseline+inference variabel (covars/model konstant) | ✓ |
| Spearman 0,82 (baseline imbalance) | `output/range_drivers.csv` + aktuelles `output/summary_by_study.csv` (d_range) | 0,818 über 15 Studien mit Baseline | ✓ |
| Bei fixiertem baseline handling: 0 in 12, max 0,04 | `output/summary_by_study.csv` (strict) | 12 Studien d_range=0; restliche vier: 0,0426/0,0295/0,0174/0,0108 | ✓ |
| Faktor 1,35 (defensible/estimand-preserving) | `output/uncertainty_medians.csv` | 1,351 (1,121–1,520) | ✓ |
| Drei von 12 primären Berichten ohne Primär-Outcome via Registrierung/Paper | `config/registrations.csv`, `manuscript/tables.md` Tab. 2 | „Primary outcome declared in“ bei den 12 primären Berichten: registration=8, paper only=1 (eTRE, zählt als „durch Paper identifiziert“), sample-size-calc only=1 (Cluster sets), not declared=2 (Phosphatidic acid, Deload) → 3 nicht über Registrierung/Paper identifiziert | ✓ (in dieser Version bereits korrekt; siehe frühere Fassung unten) |
| 7 von 16 Vorzeichen umgekehrt (erste Zuordnung) | `output/registry_v1_vs_v2.csv` | sign_flip=TRUE in 7 von 16 Zeilen, alle 7 mit arm_control_changed=TRUE | ✓ |

## Methods

| Zahl | Quelle | Nachgerechnet | Befund |
|---|---|---|---|
| 423 Records, Reduktion 107→4 (Code+Daten) | `candidates/clinical_studies_with_repos.csv`, `README.md` Zeile 142 | (n_code≥1 & n_data≥1)=4; „107“ steht nur im README (nicht in einer der Pflichtquellen), dort bestätigt | ✓ (4 aus CSV; 107 nur aus README, keine der genannten Pflichtquellen) |
| 152 Studien, 91 RCT | `candidates/deposit_contents.csv` | 152 Zeilen, is_rct=True: 91 | ✓ |
| 84 erreichbar, 74 mit Tabelle, 48 RCT | `candidates/deposit_contents.csv` | n_files>0: 84; davon n_tabular≥1: 74; davon is_rct: 48 | ✓ |
| 127 studienartige Deposits (zweite Route) | `candidates/repo_deposits_trials.csv` (nicht in der Pflichtliste, aber im Projekt vorhanden) | 128 Zeilen − 1 = 127 | ✓ |
| 21 Kandidatenpapiere | `config/published.csv` | 22 Zeilen − 1 = 21 | ✓ |
| 4 999 Permutationen; Cap 12,3 Bit | `R/engine.R` (N_PERM), Berechnung | N_PERM=4999; −log2(1/5000)=12,29→12,3 | ✓ |

## Ergebnisse 3.1 Feasibility

| Zahl | Quelle | Nachgerechnet | Befund |
|---|---|---|---|
| 68 unreachable, 10 ohne Tabelle, 26 nicht randomisiert | `candidates/deposit_contents.csv` | 152−84=68; 84−74=10; 74−48=26 | ✓ |
| 48→32 %, 11/16, 33 % (22–47 %), 11 % (7–16 %) | `output/uncertainty_proportions.csv` | 16/48=33,3 % Wilson [21,7;47,5]; 16/152=10,5 % Wilson [6,6;16,4] | ✓ |
| 17 Design-Exklusionen (5/4/3/2/2/1) | `config/exclusions.csv` | category=design: crossover 5, not_clinical 4, feasibility 3, not_rct 2, within_person 2, binary 1 = 17 | ✓ |
| 11 Daten-Exklusionen (3/2/2/1/1/1/1), davon 8 lesbar/individuell, 3 README/Tabelle/unlesbar | `config/exclusions.csv` | arm_not_in_data 3, outcome_not_identifiable 2, outcome_data_not_tabular 2, outcome_timepoint 1, no_ipd 1, no_data_in_deposit 1, file_not_readable 1 = 11; „acht“ = 3+2+1+2=8, „drei“ = 1+1+1=3 | ✓ |
| 2+2 (no_estimate, duplicate) | `config/exclusions.csv` | category no_estimate=2, duplicate=2 | ✓ |
| OSF (7), Zenodo (6), Dryad (3), 2 mit Code | `config/registry.csv` × `candidates/deposit_contents.csv` (per PMCID verknüpft) | hosts: osf=7, zenodo=6, dryad=3; n_code_files>0: 2 (physiofeedback, clusterset) | ✓ |
| Feld/Population (6 phys./reha, 1 Neuromod., 1 Frozen shoulder, 6 Training/Nutrition, 2 Pregnancy) | `config/registry.csv` | field: physiotherapy_rehabilitation=6, neuromodulation=1, other=1, exercise_physiology=5+sports_nutrition=3=6, population pregnant=2 | ✓ |
| 8 Interventionen von Physiotherapeuten | `config/published.csv` | delivered_by=="physiotherapist": 8 | ✓ |
| Randomisiert 18–404 | `config/published.csv` | n_randomised: min 18 (Phosphatidic acid), max 404 (Balance feedback) | ✓ |
| **„analysierbar für den Primärkontrast 16 bis 294“** | `manuscript/tables.md` Tabelle 3 (Spalte „n“, = `output/stage2_final.csv`) | Aktuelle Tabelle-3-Werte: 18,20,20,23,24,29,36,39,40,54,63,70,119,221,294,**373**. Maximum ist Balance feedback mit **373**, nicht 294. Minimum ist strenggenommen 18 (Phosphatidic acid), **aber** der in Tabelle 3 gezeigte eTRE-Wert (24) ist selbst fehlerhaft (siehe Abweichungsliste) – korrekt wäre eTRE = 16, was dann das tatsächliche Minimum wäre | ✗ Abweichung, siehe unten |

## Ergebnisse 3.2 Reproduktion

| Zahl | Quelle | Nachgerechnet | Befund |
|---|---|---|---|
| 11 von 12 „full“, 1 „major“ | `output/stage2_final.csv` | class: full=11, major=1 | ✓ |
| 92 % (Wilson 65–99 %) | Wilson(11,12) | 91,7 % [64,6; 98,5] → 65–99 % | ✓ |
| Median 0,001 SD, Max 0,014 SD | `output/stage2_final.csv` | median(abs_sd)=0,00089→0,001; max=0,01403→0,014 (deload) | ✓ |
| **„Sieben Schätzer stimmen auf die gedruckte Stelle überein“** | `output/stage2_final.csv`, Rundung auf die in Tabelle 3 gezeigte Nachkommastelle | Eigene Nachrechnung (\|our_est−published_est\| < ½ Einheit der letzten Stelle): **9** Treffer (Creatine, ETIP, eTRE, Lytras, Water exercise, Balance feedback, Frozen shoulder, tDCS, tSCS); FREE (Differenz 0,010 vs. Grenze 0,005) und TERECO (0,053 vs. 0,05) verfehlen die Toleranz knapp | ✗ Abweichung, siehe unten |
| Deload: unser Fit „−0,52 gegen −0,63“ | `output/stage2_final.csv` (est-Spalte) | est = −0,514929 → rundet auf 2 Nachkommastellen zu **−0,51**, nicht −0,52 | ✗ Abweichung (Rundung) |
| TERECO: ML reproduziert das Intervall exakt | `output/stage2_final.csv` | published_ci (43,8; 87,1) = our_ci (43,8; 87,1) | ✓ |
| Frozen shoulder: 0,1 % | `output/stage2_final.csv` | rel=0,001423→0,14 %→0,1 % | ✓ |
| FREE: 1,8 % | `output/stage2_final.csv` | rel=0,018096→1,8 % | ✓ |
| Ein Paper ohne Intervall, drei ohne p-Wert | `output/stage2_final.csv`, `config/published.csv` | published_ci_lo & _hi beide NA: 1 (Creatine); published_p NA: 3 (Frozen shoulder, TERECO, tSCS) | ✓ |
| 8 Trials mit vergleichbarem p-Wert, gleiche Seite von 0,05 | `output/stage2_final.csv` | p_verdict_same: True=8, NaN=4 (Deload, Frozen shoulder, TERECO, tSCS) | ✓ |
| 12/12 KI schließt publizierten Wert ein | `output/stage2_final.csv` | our_ci_contains_pub: 12× TRUE | ✓ |
| 4 Rekonstruktionen mit offener Annahme (Water exercise, Deload, TERECO, Frozen shoulder) | `output/stage2_final.csv` (deviations-Text) | Freitext bestätigt für alle vier eine explizit offengelassene Annahme (Imputationszahl, Priors, Schätzmethode, Reko der wiederholten-Messungen-ANCOVA) | ✓ |
| 11 von 152 (7 %, 4–12 %); 11 von 48 (23 %, 13–37 %) | `output/stage2_final.csv`, Wilson | Wilson(11,152)=[4,09;12,49]→4–12 %; Wilson(11,48)=[13,31;36,54]→13–37 % | ✓ |
| 9 von 11 „inside“ (Wilson 52–95 %) | `output/reproduction.csv`, `output/uncertainty_proportions.csv` | inside_principled: True=9, False=2 (FREE, Water exercise), physiofeedback nicht auf gemeinsamer Skala (ausgeschlossen) → 9/11; Wilson [52,3;94,9] | ✓ |
| 0,016 (0,003–0,056) | `output/uncertainty_medians.csv` | 0,01562 (0,00272–0,05642) | ✓ |
| 7 von 12 vollständig abbildbar | `output/reproduction.csv` | spec_fully_matched=True: 7 | ✓ |
| 3 Gleichstände, Lytras 0,23 | `output/reproduction.csv` | n_tied>1: 3 (Lytras n=3, FREE n=2, Balance feedback n=2); tie_range_d Lytras=0,229→0,23 | ✓ |

## Ergebnisse 3.3 Fragility (estimand-preserving)

| Zahl | Quelle | Nachgerechnet | Befund |
|---|---|---|---|
| 196 Spez., 3–35 pro Studie, 1 % Duplikate | `output/summary_by_study.csv`, `output/duplicates.csv` | Σn_spec=196, min 3 (Water exercise), max 35 (FREE); share_dup=198→196=1,01 % | ✓ |
| 11 von 16 nur baseline+inference; covars in 4, model in 2; 1 Studie ohne Baseline nur inference | `output/multiverse_all.csv` | exakt bestätigt (siehe Abstract-Tabelle); covars variiert in 4, model in 2, Water exercise (kein Baseline) nur inference | ✓ |
| Median 0,12 (0,09–0,21), IQR 0,08–0,22 | `output/uncertainty_medians.csv`, `output/summary_by_study.csv` | Median 0,1192; Q25/Q75 (linear) 0,0840/0,2166 → 0,08/0,22 | ✓ |
| 0,41 (Deload, n=39), 0,39 (tSCS, n=20), 0,37 (eTRE, n=16) | `output/summary_by_study.csv` | d_range: gainingmore 0,4075/n39; tscs 0,3863/n20; etre 0,3662/n16 | ✓ |
| Vorzeichen 16/16 (Wilson 81–100 %) | `output/uncertainty_proportions.csv` | share_same_sign=1 in 16/16; Wilson [80,6;100] → 81–100 % | ✓ |
| Baseline top in 14 von 15 | `output/variance_summary.csv` | node=baseline, grid=principled, target=d: top_in=14, n_studies=15 | ✓ |
| Spearman 0,82 (Imbalance)/0,39 (Baseline-Outcome-Korrelation, 15 Studien)/−0,29 (Stichprobengröße, alle 16) | `output/range_drivers.csv` + aktuelles `d_range`; `output/summary_by_study.csv` | 0,818/0,393 über 15 Studien mit Baseline; −0,286 über **alle 16** Studien (inkl. Water exercise ohne Baseline) mit der Multiverse-n-Spalte | ✓ (Hinweis: die −0,29 nutzt n=16, nicht n=15 wie die ersten beiden Koeffizienten – im Text durch „with sample size, over all 16 trials, it is −0.29“ bereits klargestellt) |
| Top-3-Imbalance 0,40–0,41 SD | `output/range_drivers.csv` | gainingmore 0,4107, tscs 0,4089, etre 0,3983 = dieselben drei Top-Range-Studien | ✓ |
| Strict: 68 Spez., 0 in 12, max 0,04 (Balance feedback 0,04/FREE 0,03/TERECO 0,02/Cluster sets 0,01) | `output/summary_by_study.csv` (strict) | 12× d_range=0; vier >0: 0,0426/0,0295/0,0174/0,0108 in exakt dieser Reihenfolge | ✓ |
| Intervallbreite: baseline 11, model 2, inference 2, inference Median 8 % | `output/variance_summary.csv` (target=ci_width_d, principled) | top_in: baseline=11, model=2, inference=2; median_share(inference)=7,74→8 % | ✓ |
| Interaktionen: 8 Kombinationen, 8 unverändert, **Median 14 %** | `output/variance_interactions.csv` | 8 Zeilen; top_additive==top_interaction_model in allen 8 (unverändert); median(share_all_interactions)=**13,49 %→13 %**, nicht 14 % | ✗ Abweichung, siehe unten |
| Strata: 0,11/0,39 (klinisch) und 0,16/0,41 (Sport/Ernährung) | `output/summary_by_study.csv` × `config/registry.csv` (field) | klinisch (phys._reha+other+neuromod., n=8): Median 0,1106→0,11, Max 0,3863→0,39; exercise_phys.+sports_nutrition (n=8): Median 0,1634→0,16, Max 0,4075→0,41 | ✓ |
| s-Werte 0,8 bis 18 Bit | `output/summary_by_study.csv` (s_median, principled) | min(s_median)=0,7966 (FREE)→0,8; max=17,938 (TERECO)→18 | ✓ |
| Ähnlichkeit: 11 von 16 >0,99, 1 Studie nur eine Pipeline | `output/pipeline_similarity.csv` | cor_min>0,99: 11; n_pipelines==1: 1 (Lytras) | ✓ |
| Integrität: 1 berechenbar, breit 0,15–0,95, 2–43 Variablen | `output/integrity_screen.csv` | n_baseline_named≥2 nur bei physiofeedback (1 Studie); p_carlisle_all-Bereich (ohne eTRE mit 0 Variablen) 0,1455–0,9530→0,15–0,95; n_baseline_all ohne 0-Werte: 2–43 | ✓ |

## Ergebnisse 3.4 Estimand vs. Analyse (defensible + outlier)

| Zahl | Quelle | Nachgerechnet | Befund |
|---|---|---|---|
| 550 Spez., 9–96 pro Studie, 1 % Duplikate | `output/summary_by_study.csv`, `output/duplicates.csv` | Σn_spec=550, min 9, max 96; share_dup=556→550=1,08 % | ✓ |
| Median 0,24 (0,13–0,32), IQR 0,13–0,32 | `output/uncertainty_medians.csv`, `output/summary_by_study.csv` | Median 0,2389; Q25/Q75 0,1304/0,3157→0,13/0,32 (identisch mit Bootstrap-CI, kein Fehler, echte Koinzidenz) | ✓ |
| Max 0,52, tSCS | `output/summary_by_study.csv` | max(d_range)=0,5219 bei tscs_PMC13085461 | ✓ |
| Vorzeichen stabil 13/16 (57–93 %), Null in 3 (ETIP, FREE, Balance feedback) | `output/summary_by_study.csv`, `output/uncertainty_proportions.csv` | share_same_sign==1: 13; d_min<0<d_max: genau ETIP, FREE, physiofeedback; Wilson [57,0;93,4] | ✓ |
| Faktor 1,35 (1,12–1,52) | `output/uncertainty_medians.csv` | 1,351 (1,121–1,520) | ✓ |
| Baseline top in 11/16, Transformation in 5, Missing in 0 von 7 anwendbar | `output/variance_summary.csv` (defensible, target=d) | top_in: baseline=11, transform=5 (n_studies=13), missing=0 (n_studies=7) | ✓ |
| Outlier-Arm: Median 0,18, Max 1,08 | `output/summary_by_study.csv` (outlier_arm) | median(d_range)=0,1775→0,18; max=1,0785→1,08 (tDCS) | ✓ |
| d von 1,4 auf 0,4 (mad_winsor) | `output/multiverse_all.csv` (outlier_arm, tdcs) | outlier=none: d≈1,41–1,46; outlier=mad_winsor/pooled: d≈0,38–0,44 | ✓ |

## Ergebnisse 3.5 Reporting & eigene Kartierung

| Zahl | Quelle | Nachgerechnet | Befund |
|---|---|---|---|
| 8 von 12 primären Berichten via Registrierung | `manuscript/tables.md` Tab. 2 | „Primary outcome declared in“=registration bei 8 der 12 primary reports | ✓ |
| 3 ohne Registrierung; davon 1 Paper, 1 Fallzahl, 1 keins | `config/registrations.csv` | retrieved=no: 3 (Cluster sets, Phosphatidic acid, eTRE); Deklaration: eTRE=paper only, Cluster sets=sample-size only, Phosphatidic acid=not declared | ✓ |
| 1 registrierte Studie ohne Primär-Outcome | Tab. 2 | Deload: Registrierung=yes, „not declared“ | ✓ |
| 3 Registrierungen nach Studienbeginn | `config/registrations.csv` | registered_after_start=yes: 3 (Lytras, Frozen shoulder, Water exercise) | ✓ |
| 4 Sekundärberichte | Tab. 2 / `config/registry.csv` | report_type=secondary: 4 | ✓ |
| 12/16 mit Punktschätzer, 4 nur p/F | Tab. 3 | 12 mit Estimate, 4 „no point estimate“ | ✓ |
| 1 Paper nennt Estimand | Tab. 2 | „Estimand stated“=yes: 1 (Deload) | ✓ |
| 13 mit Baseline-Test, 3 davon entscheidend | Tab. 2 | Baseline test yes/„yes, decisive“: 13; „yes, decisive“: 3 (Cluster sets, tSCS, Water exercise) | ✓ |
| Baseline handling: 6/4/2/4 | Tab. 2 | ancova=6, change=4, endpoint=2, other=4 | ✓ |
| Modellfamilien: 5/6/3/1/1 | Tab. 2 | anova=5, mixed(_ri+_slopes)=6, lm_ancova=3, ttest=1, nonparam=1 | ✓ |
| Missing: 7 ohne, davon 4/3/1/1 | Tab. 2 | none_missing=7; complete_case=4, mmrm_ml=3, mi=1, not_reported=1 | ✓ |
| 2 Clustering-Modelle | `config/published.csv` | B_clustering_modelled≠none: 2 (FREE, Balance feedback) | ✓ |
| Protokoll 7/6/3 | `config/published.csv` | C_protocol_available: yes=7, registration_only=6, no=3 | ✓ |
| 10 Journals mit Sharing-Pflicht, 6 unklar | Tab. 2 | Journal requires sharing: yes=10, unclear=6 | ✓ |
| Kein Outlier-Regel-Reporting | `config/published.csv` | B_outlier_rule=not_reported: 16/16 | ✓ |
| Mapping 13/10/5/11/3/1 | `output/registry_v1_vs_v2_fields.csv` | any_changed=13; arm_control=10; outcome_var=5; covars=11; baseline_var=3; data_file=1 | ✓ |
| v1 0,27 vs. 0,27; 0,09 vs. 0,12; 7 von 16 | `output/registry_v1_vs_v2.csv` | median\|v1_med\|=0,2666→0,27; median\|v2_med\|=0,2674→0,27; median(v1_range)=0,0873→0,09; median(v2_range)=0,1192→0,12; sign_flip=7 | ✓ |
| Alle 7 Vorzeichenwechsel wegen Kontrollarm-Fehlkodierung | `output/registry_v1_vs_v2_fields.csv` | Für alle 7 sign_flip-Studien ist arm_control_changed=TRUE | ✓ |

## Diskussion 4.1–4.8 und Conclusion

Alle in Diskussion/Conclusion wiederholten Zahlen (104/136, 32/11, 8→11/12, 0,014, 0,12 SD,
11/16 baseline, 0,82, 12 zero/max 0,04, Faktor 1,35, „3 von 12 ohne Primär-Outcome“, 7/16
Vorzeichenumkehr, 68/48/152, 11 von 48 Daten-Verlust mit 8 lesbar, Wilson-Intervalle 65–99 %,
7–16 %/4–12 %, „drei Studien mit weniger als 30 Teilnehmern randomisiert“, drei Arme aus
Dreiarm-Design, 1,08 SD Ausreißer-Sensitivität) sind Wiederholungen bereits oben geprüfter
Zahlen und stimmen in dieser Version durchgehend mit den Quellen überein, mit folgenden
Ausnahmen:

| Zahl | Fundstelle | Quelle | Nachgerechnet | Befund |
|---|---|---|---|---|
| „fünf der Studien randomisierten weniger als 30 Teilnehmer“ | 4.4, 4.7 | Tab. 3 (n-Spalte) bzw. `config/published.csv` (n_randomised) | Beide Definitionen ergeben exakt 5 (Tab.-3-n: tDCS, tSCS, Facial palsy, Mulligan, Phosphatidic acid; n_randomised: Phosphatidic acid, tSCS, tDCS, Facial palsy, eTRE) | ✓ |
| Drei Studien vergleichen zwei Arme aus einem Dreiarm-Design | 4.7 | `config/registry.csv` (arm_include/notes) | genau 3: Mulligan (1,3 von 3), Frozen shoulder/spadi (1,3 von 3), eTRE (Control,eTRE von 3 Armen: Control/eTRE/mTRE) | ✓ |
| „127 studienartige Deposits“ | 4.7 | `candidates/repo_deposits_trials.csv` | 128 Zeilen−1=127 | ✓ |

Externe Literaturzitate der Einleitung und Diskussion (Brodeur 110/85 %/72 %; Stodden 44 %/26 %;
Naudet 37/17/14/16; Siebert 10/62=16 %; Jabouille 12 %/465; Elghzali 22,7 %; Murphy 14 %/28 %;
Dhanani 572; Nepomuceno 613/144/152/8,6 %/3,9 %/82,2 %; Veltri 76,9 %/7,5 %) sind Angaben aus
fremden Publikationen und mit den hier gelisteten Projektdaten nicht nachrechenbar; sie wurden
nicht geprüft.

## Tabelle 1

Rein qualitative Beschreibung der Gitterknoten (Typ E/N/U, Optionen, Anwendbarkeit); keine
nachrechenbaren Zahlen außer den bereits oben geprüften Grid-Definitionen (estimand-preserving/
strict/defensible/outlier). Konsistent mit Methods 2.6.

## Tabelle 2

Alle 14 Spalten für alle 16 Studien wurden gegen `config/registry.csv`, `config/registrations.csv`
und `config/published.csv` abgeglichen (siehe Zeilen oben zu Abschnitt 3.5); keine Abweichung
gefunden.

## Tabelle 3

Gegen `output/stage2_final.csv` (Spalten n, Published/Recomputed estimate, CI, p, Relative
difference, Absolute difference, Class, CI-contains) und `output/reproduction.csv` (Percentile,
Grid matches tied) geprüft.

| Trial | Geprüfte Werte | Befund |
|---|---|---|
| Creatine, ETIP, Lytras, Water exercise, tDCS, TERECO, tSCS, FREE, Frozen shoulder, Balance feedback | est/CI/p/rel/abs_sd/class exakt gegen `stage2_final.csv` | ✓ (alle exakt) |
| Deload | est=−0,515 (−2,73 bis 1,76; posterior), rel 18,3 %→18 %, abs 0,014 | ✓ |
| **eTRE** | n=**24** in Tabelle 3 | ✗ Abweichung: korrekt ist n=**16**, siehe unten |
| Cluster sets/Facial palsy/Mulligan/Phosphatidic acid | „no point estimate“, n=36/23/29/18, p wie im Paper | ✓ (n gegen `stage2_final.csv`/Rohdaten unverändert korrekt) |
| „Grid matches tied“-Spalte | `output/reproduction.csv` (n_tied, tie_range_d) | inhaltlich unabhängig von der Stufe-2-Neuberechnung (bezieht sich nur auf publizierte Spezifikation und Gitterverteilung, nicht auf den neu gefitteten Schätzer); Werte weiterhin korrekt | ✓ |

---

## Abweichungen mit korrektem Wert

1. **eTRE-Stichprobengröße in Tabelle 3 und `output/stage2_final.csv`.** Ausgewiesen: n = 24.
   Die Rohdaten (`studies/2025_early-time-restricted-eating-improves-weight-los_PMC11945196/deposit/Body data.csv`)
   zeigen ein Dreiarm-Design mit je 8 Teilnehmern (Control, eTRE, mTRE = 24 randomisiert
   insgesamt); der publizierte und hier analysierte Kontrast Control-gegen-eTRE verwendet nur
   die beiden genannten Arme, also **n = 16** (8 + 8), nicht 24. Der Wert n = 16 ist konsistent
   mit `output/summary_by_study.csv` (Multiverse-Gitter, unveränderter Lauf), das für diese
   Studie durchgehend n = 16 ausweist. **Korrektur: n = 16** in Tabelle 3, Zeile eTRE.

2. **„the number analysable for the primary contrast ranged from 16 to 294“ (Abschnitt 3.1).**
   Das in Tabelle 3 ausgewiesene Maximum ist die Balance-feedback-Studie mit n = 373, nicht
   Water exercise mit n = 294. Nach Korrektur von Punkt 1 bleibt das Minimum bei n = 16 (eTRE).
   **Korrektur: „ranged from 16 to 373“** (oder Klarstellung, warum Balance feedback aus dieser
   Aussage ausgenommen wird).

3. **„interaction terms accounted for a median of 14% of the explained variance“ (Abschnitt 3.3).**
   `output/variance_interactions.csv` enthält genau die im Text genannten 8
   Trial-mal-Gitter-Kombinationen; der Median von `share_all_interactions` über diese 8 Werte
   (0,85 %, 2,42 %, 2,48 %, 9,31 %, 17,67 %, 19,23 %, 40,66 %, 74,65 %) beträgt **13,49 %**, was
   auf **13 %** rundet, nicht 14 %. **Korrektur: „a median of 13%“.**

4. **„Seven estimates agree with the published value to the precision at which it was printed“
   (Abschnitt 3.2).** Eigene Nachrechnung mit dem in Methods 2.4 definierten Kriterium
   (Abweichung kleiner als eine halbe Einheit der zuletzt gedruckten Stelle, angewandt auf die
   in Tabelle 3 gezeigte Rundung) ergibt **9** Treffer: Creatine, ETIP, eTRE, Lytras, Water
   exercise, Balance feedback, Frozen shoulder, tDCS, tSCS. FREE (Differenz 0,010 gegen eine
   Toleranz von 0,005) und TERECO (0,053 gegen 0,05) verfehlen die Toleranz jeweils knapp.
   **Korrektur: „Nine estimates agree …“** (oder Präzisierung des Kriteriums, falls eine andere
   Rundungsregel gemeint war).

5. **„our fit with default priors gives −0.52 against −0.63“ (Abschnitt 4.3, Deload-Studie).**
   `output/stage2_final.csv` weist den rekonstruierten Schätzer mit −0,514929 aus; auf zwei
   Nachkommastellen (wie beim Vergleichswert −0,63) gerundet ergibt das **−0,51**, nicht −0,52.
   Der Wert stimmt mit Tabelle 3 (dort auf drei Stellen: −0,515) überein, nur die
   Zwei-Stellen-Rundung im Fließtext ist um eine Einheit der letzten Stelle daneben.
   **Korrektur: „gives −0.51 against −0.63“.**

Nicht als Abweichung gewertet, aber als Hinweis: `output/reproduction.csv` (Lauf von 08:04 Uhr)
enthält für die FREE-Studie noch den alten, vor der „time as factor“-Korrektur berechneten
Schätzer (class = major_discrepancy, rel_diff = 45 %); die in Tabelle 3 verwendeten Spalten
„Percentile“ und „Grid matches tied“ hängen jedoch nur vom publizierten Schätzer und vom
Gitter ab, nicht vom neu gefitteten Wert, und sind daher unverändert korrekt. Es wird dennoch
empfohlen, `R/reproduce.R` erneut laufen zu lassen, damit `reproduction.csv` insgesamt mit
`output/stage2_final.csv` synchron ist.

Frühere Fassung dieser Prüfung (vor 08:32/08:33 Uhr) hatte zusätzlich folgende Abweichungen in
der damaligen Version gefunden, die im Zuge der laufenden Überarbeitung zwischenzeitlich bereits
korrigiert wurden und daher **nicht mehr** in obiger Liste stehen: „Nine of 12 papers did not
report an interval … four did not report a p-value“ (jetzt korrekt „one … three“), „Four of 12
primary reports do not identify …“ (jetzt korrekt „Three of 12“), „Per-trial median s-values
range from 0.5 to 19 bits“ (jetzt korrekt „0.8 to 18“), „six of the trials randomised fewer than
30 participants“ (jetzt korrekt „five“), sowie die Stufe-2-Klassenzahlen 8/2/2 (jetzt 11/1 nach
Änderung der Übereinstimmungsregel in Methods 2.4).
