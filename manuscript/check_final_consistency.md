# Konsistenzprüfung des Manuskriptentwurfs

Geprüft: `manuscript/paper.md` (Abstract bis Conclusion) und `manuscript/tables.md`, Stand 2026-09-12.
Gegengerechnet in Python gegen `output/summary_by_study.csv`, `output/reproduction.csv`,
`output/uncertainty_proportions.csv`, `output/uncertainty_medians.csv`, `output/variance_summary.csv`,
`output/sensitivity_baseline_fixed.csv`, `output/registry_v1_vs_v2.csv`, `output/registry_v1_vs_v2_fields.csv`,
`output/duplicates.csv`, `output/published_minus_median.csv`, `config/exclusions.csv`, `config/registry.csv`,
`config/published.csv` und `config/published_overrides.csv`. Zitatschlüssel geprüft gegen
`literature/references.bib`.

## Kurzfassung

Das Manuskript ist ungewöhnlich sauber: Alle in der Aufgabenstellung ausdrücklich zu prüfenden Zahlen
(16/152/48/423/32/17/11, 10 von 12, 55–95 %, 0,15, 0,08–0,23, 1,08, 15 von 16, 10 von 15, 0,003, 1,35,
9/4/1, 7 von 16 und 13 von 16, 395, 1 934, 11 % (7–16), 8 % (5–13), 33 % vs. 32 %) stimmen über alle
Abschnitte hinweg überein und lassen sich exakt aus den genannten Dateien nachrechnen. "33 % vs. 32 %"
ist keine Inkonsistenz, sondern zwei verschiedene, beide korrekt gerundete Anteile (16/48 und 48/152).

Gefunden wurden: 1 echte Zahlen-Inkonsistenz zwischen Abschnitten (0,07 vs. 0,063 SD), 1 weiterer
Präzisionshinweis zur selben Stelle, 1 fehlender Zitatschlüssel und 2 Schlüssel mit abweichendem
BibTeX-Typ, sowie mehrere Versprechen-Einlösung-Lücken (fehlende Figure 3, doppelt vergebenes
Supplement S1, ein in Methods angekündigtes aber nie berichtetes Mass). Aims gegen Results (Abschnitt
1.4 gegen 3.1–3.4 gegen 4.1) sind vollständig konsistent.

## 1. Zahlen über Abschnitte hinweg

| Zeile(n) im Text | Ist | Soll | Befund |
|---|---|---|---|
| Zeile 524 (4.1) und Zeile 554 (4.3) | "und nie um mehr als 0,07 Standardabweichungen" abweichend | Zeile 401 und 408 (3.2) sowie Tabelle 3: maximale absolute Differenz ist 0,063 SD (SPADI/Frozen-shoulder-Studie, exakt 0,0631656602112521 laut `output/reproduction.csv`, Spalte `abs_diff_sd`) | **Inkonsistenz.** Discussion 4.1 und 4.3 nennen beide "0,07", Results 3.2 und Tabelle 3 nennen "0,063" für denselben Sachverhalt (maximale absolute Abweichung der 12 reproduzierten Schätzer). 0,07 ist nicht falsch im Sinne einer oberen Schranke, aber es ist eine andere Zahl als die im Ergebnisteil berichtete, exakte Zahl. Möglicher Ursprung der Verwechslung: Zeile 431 nennt im selben Kapitel 3.3 einen Interquartilbereich "0,07 bis 0,23" für eine andere Grösse (Streubreite der Range über 16 Studien), nicht für die Reproduktionsabweichung. Empfehlung: in Zeile 524 und 554 "0,07" durch "0,063" ersetzen. |
| Zeile 449 (3.3) | "exceeds 0.05 in three trials (FREE 0.11, water exercise 0.08, TERECO 0.05)" | `output/sensitivity_baseline_fixed.csv`, Spalte `range_fixed`: neben FREE (0,1085), Mallorca/Wasser (0,0795) und TERECO (0,0543) überschreitet auch tDCS (1,0345) die Schwelle 0,05 | **Präzisionshinweis, keine harte Inkonsistenz.** Rechnerisch überschreiten vier, nicht drei Studien den Wert 0,05; die vierte (tDCS) wird im selben Satz separat genannt ("in the transcranial stimulation trial it remains 1.03"). Das ist inhaltlich nachvollziehbar, aber die Formulierung "in three trials" ist für sich genommen ungenau, wenn tDCS mitgezählt wird. Empfehlung: "in three further trials" oder "in three trials besides the tDCS trial already noted". |
| übrige geprüfte Zahlen | 16, 152, 48, 423, 32, 17, 11, 10 von 12, 55–95 %, 0,15, 0,08–0,23, 1,08, 15 von 16, 10 von 15, 0,003, 1,35, 9/4/1, 7 von 16, 13 von 16, 395, 1 934, 11 % (7–16), 8 % (5–13), 33 % vs. 32 % | siehe Abschnitt 2 | **Konsistent.** Jede dieser Zahlen kommt an allen Fundstellen (Abstract, Results, Discussion, Conclusion, wo zutreffend) mit demselben Wert vor; Einzelnachweise in Abschnitt 2. |

Zusätzlich geprüft und konsistent befunden (nicht in der Vorgabenliste, aber mehrfach im Text):
Ausschlussgründe-Aufschlüsselung (5+4+3+2+2+1=17 Design, 3+2+2+1+1+1+1=11 Daten), n randomisiert
18–404, n analysiert 16–294, Hosting OSF 7/Zenodo 6/Dryad 3, 13/3 primäre/sekundäre Berichte, 6/1/1/6/2
Feld-Populations-Aufschlüsselung, "9 % Interaktionsanteil" (Zeile 447, `output/variance_interactions.csv`),
"ten of 32 trial-by-grid combinations" (Zeilen 447 und 656, aus `output/duplicates.csv` ableitbar),
Mapping-Detailzahlen 10/5/11/3/1 (`output/registry_v1_vs_v2_fields.csv`), Median-|d|-Vergleich 0,24
gegen 0,25 und Range-Vergleich 0,16 gegen 0,15 (`output/registry_v1_vs_v2.csv`).

## 2. Zahlen gegen Dateien (Abstract und Conclusion)

Alle Zahlen aus Abstract und Conclusion wurden einzeln nachgerechnet. Ergebnis: **keine Abweichung.**

| Zahl (Abstract/Conclusion) | Quelle | Nachrechnung |
|---|---|---|
| 423 Datensätze | — | Ausgangszahl der Europe-PMC-Suche; in keiner der geprüften Output-/Config-Dateien enthalten und daher nicht aus diesen Dateien nachrechenbar (sie ist der Ausgangspunkt, nicht das Ergebnis einer Verarbeitung). Kein Fehler, nur ausserhalb des Prüfbereichs der vorgegebenen Dateien. |
| 152 Studien mit Repository-Link | `output/uncertainty_proportions.csv` | Zeile "included, denominator 152": n=152. Stimmt. |
| 48 randomisierte Studien mit lesbarer Datei | `output/uncertainty_proportions.csv`, `config/exclusions.csv` | n=48 als Nenner; 16 (registry.csv) + 32 (exclusions.csv) = 48. Stimmt. |
| 32 Ausschlüsse, davon 17 Design, 11 Daten | `config/exclusions.csv`, Spalte `category` | `Counter`: design=17, data=11, duplicate=2, no_estimate=2, Summe 32. Stimmt exakt. |
| 16 eingeschlossene Studien | `config/registry.csv` | 16 Zeilen. Stimmt. |
| 11 % (der 152 mit Link) | `output/uncertainty_proportions.csv` | k=16, n=152, prop=0,1053→11 %, Wilson 6,58–16,4 %→"7 bis 16 %". Stimmt. |
| 33 % (der 48 geprüften) | `output/uncertainty_proportions.csv` | k=16, n=48, prop=0,3333→33 %, Wilson 21,7–47,5 %→"22 bis 47 %" (Results 3.1). Stimmt. |
| 10 von 12 reproduziert (2 minor, 0 major) | `output/reproduction.csv`, Spalte `class` | full=10, minor_discrepancy=2, major_discrepancy=0, no_point_estimate=4 (=16−12). Stimmt exakt. |
| 395 einzigartige Spezifikationen (principled) | `output/summary_by_study.csv` | Summe `n_spec` über die 16 principled-Zeilen = 395. Stimmt exakt. |
| Median Range 0,15 SD, Bootstrap 0,08–0,23 | `output/uncertainty_medians.csv` | "median range d, principled": est=0,1498→0,15; boot_lo=0,0795→0,08; boot_hi=0,2291→0,23. Stimmt. |
| Maximum 1,08 SD | `output/summary_by_study.csv` | Maximaler principled `d_range` = 1,0785 (tdcs_PMC13257960). Stimmt. |
| Vorzeichen stabil in 15 von 16 | `output/uncertainty_proportions.csv` | "sign stable principled": k=15, n=16. Stimmt. |
| Baseline-Handling dominant in 10 von 15 | `output/variance_summary.csv` | Zeile "baseline", principled, target d: dominant_in=10, n_studies_total=15. Stimmt. |
| Median-Range mit fixierter Baseline: 0,003 | `output/sensitivity_baseline_fixed.csv` | Median über 16 `range_fixed`-Werte = 0,00299→0,003. Stimmt. |
| Faktor 1,35 (defensible/principled) | `output/uncertainty_medians.csv` | "median ratio defensible/principled": est=1,352→1,35, boot 1,181–1,525→"1,18 bis 1,52". Stimmt. |
| 9 kein Primäroutcome / 4 kein Punktschätzer / 1 Estimand | `config/registry.csv` (primary_declared), `output/reproduction.csv` (class) | primary_declared="abstract" (nur aus Abstract erschliessbar) = 9; class="no_point_estimate" = 4; `config/published.csv` C_estimand_stated="yes" für die 16 Registry-Studien = 1. Stimmt. |
| 7 von 16 Vorzeichen umgekehrt (eigenes Erst-Mapping) | `output/registry_v1_vs_v2.csv`, Spalte `sign_flip` | TRUE-Zahl = 7. Stimmt. |
| 20 Teilnehmer (Studie mit Range 1,08) | `config/published.csv` | tdcs_PMC13257960: n_randomised=20. Stimmt. |

## 3. Zitatschlüssel

60 Einträge in `literature/references.bib` (58×`@article`, 1×`@misc`, 1×`@techreport`, 1×`@unpublished`).
44 eindeutige Schlüssel werden in `paper.md`/`tables.md` in eckigen Klammern zitiert.

| Schlüssel | Fundstelle (Zeile in paper.md) | Befund |
|---|---|---|
| `Hardwicke_2018` | Zeile 58 ("... mandatory policy of Cognition were not reusable [Hardwicke_2018]") | **Fehlt.** Kommt in `references.bib` nicht vor, auch nicht unter einem anderen Eintragstyp. Nur `Hardwicke_2021` ist vorhanden. Vermutlich fehlt der Eintrag für Hardwicke et al. 2018 (Cognition-Datenreanalyse) im .bib-File. |
| `Gelman_Loken_2013` | Zeile 627 ("[Gelman_2014; Gelman_Loken_2013]") | Vorhanden in `references.bib` (Zeile 120), aber als `@unpublished{Gelman_Loken_2013,...}`, nicht als `@article` oder `@misc`. Nach der strikten Definition der Aufgabe ("Schlüssel = Text zwischen `@article{` bzw. `@misc{` und dem ersten Komma") zählt er als fehlend; der Schlüssel selbst existiert im File und referenziert den richtigen Eintrag (Gelman & Loken, "The garden of forking paths"). Kein inhaltlicher Fehler, nur ein Hinweis, falls die Prüfung strikt auf `@article`/`@misc` beschränkt bleiben soll. |
| `ICH_2019_E9R1` | Zeile 613 | Vorhanden in `references.bib`, aber als `@techreport`, nicht `@article`/`@misc`. Gleicher Hinweis wie oben. |

**Zusammenfassung:** 1 tatsächlich fehlender Schlüssel (`Hardwicke_2018`); 2 Schlüssel technisch vorhanden,
aber ausserhalb der engen `@article`/`@misc`-Definition der Aufgabe (`Gelman_Loken_2013`, `ICH_2019_E9R1`).

## 4. Versprechen und Einlösung

| Zeile(n) im Text | Ist | Soll | Befund |
|---|---|---|---|
| Zeilen 369, 429, 438, 690–691 | Text zitiert "Figure 1" (Zeile 369), "Figure 2" (Zeile 429), "Figure 4" (Zeile 438) und die Schlussnotiz (Zeile 690–691) verspricht "Figures 1 to 4" | Eine Fundstelle für "Figure 3" im Fliesstext | **Fehlt.** "Figure 3" wird im gesamten Manuskript nie zitiert, obwohl die Schlussnotiz vier Abbildungen ankündigt und Figure 1, 2 und 4 alle im Text vorkommen. `output/figures/` enthält u. a. `variance_ci_width_d.png`, das inhaltlich zur CI-Breiten-Variansaufteilung passen würde (analog zu `variance_d.png` für Figure 4) und derzeit von keiner Abbildungsnummer referenziert wird. Vermutlich fehlt ein Absatz/Verweis im Text (z. B. in 3.3 zur Intervallbreite), oder die Nummerierung ist verrutscht. |
| Zeilen 138 und 183–184 | Zeile 138: "... addressed in Supplement S1 [Van_den_Akker_2021]" (Transparenz-Checkliste). Zeile 183–184: "Every exclusion is recorded with its category and reason in Supplement Table S1." (Ausschlusstabelle) | Zwei unterschiedliche Inhalte brauchen zwei unterschiedliche Supplement-Nummern | **Inkonsistenz.** "S1" wird zweimal für zwei verschiedene Supplement-Inhalte vergeben (Transparenz-Checkliste nach van den Akker et al. vs. Ausschlusstabelle). Die übrigen Supplement-Verweise sind eindeutig (S2, S4, S5, S18); S1 kollidiert. Eine der beiden Stellen braucht eine neue Nummer (z. B. S1 für die Checkliste, S3 für die Ausschlusstabelle, da S3 sonst nirgends vergeben ist). |
| Zeilen 323–330 (Methods 2.7) | "... the share with \|d\| above 0.2, Cohen's convention for a small effect ..." wird als zu berichtendes Summary-Mass angekündigt | Eine Zahl/ein Prozentsatz dieser Grösse in Results 3.3 oder 3.4 | **Nicht eingelöst.** Diese Kennzahl liegt in `output/summary_by_study.csv` vor (Spalte `share_abs_d_gt_mcid`), wird aber in Results 3.3/3.4 an keiner Stelle als Zahl berichtet oder in Tabelle 2/3 aufgeführt. Entweder ergänzen oder aus Methods 2.7 streichen. |
| Zeilen 204–207 | "A second coder is to repeat the mapping blind to the first, and agreement per field will be reported [check: pending]." | Ein Inter-Rater-Ergebnis in Results 3.5 | **Nicht eingelöst, aber selbst markiert.** Der Platzhalter "[check: pending]" zeigt, dass dies den Autoren bereits bekannt ist. Discussion 4.7 bestätigt konsistent: "one coder has mapped the trials to date." Kein verdeckter Fehler, aber vor Einreichung offen. |
| generell | S1, S2, S4, S5, S18 werden im Fliesstext zitiert | Eine Supplement-Datei im Projekt | Im Projektordner existiert aktuell keine Supplement-Datei (kein Treffer für "*supplement*" ausserhalb `studies/`). Bei einem Entwurfsstand ist das erwartbar, aber vor Einreichung fehlt das gesamte Supplement-Dokument. |

Alle in Methods 2.1–2.6 angekündigten Masse, die tatsächlich geprüft wurden (Median/IQR/Range von d,
Anteil gleiches Vorzeichen, s-Value, Perzentil des publizierten Schätzers, Varianzzerlegung für d und für
die CI-Breite, Interaktions-Sensitivität, Pipeline-Ähnlichkeit, Spearman-Korrelate, Wilson-Intervalle,
Bootstrap-Mediane, Differenz publizierter Schätzer minus Multiverse-Median), werden in Results 3.1–3.5
berichtet. Einzige Ausnahme ist der Anteil mit \|d\| > 0,2 (siehe oben).

Weitere offene Platzhalter im Text, vom Autor selbst als "[check]" markiert (kein Fund dieser Prüfung,
nur zur Vollständigkeit aufgeführt): Zeile 4 (allgemeiner Hinweis), Zeile 135 ("[Brodeur_2026, check
wording]"), Zeile 139 ("[repository DOI to be created]"), Zeile 143 ("[date, check README]"), Zeile 152
("[check: number from the first screening pass, README]").

## 5. Aims gegen Results

**Befund: vollständig konsistent.** Die vier Fragen aus 1.4 (Zeilen 107–113) erscheinen in derselben
Reihenfolge als Überschriften/Abschnittsinhalte 3.1 Feasibility, 3.2 Reproduction, 3.3 Fragility over
equivalent choices, 3.4 Estimand versus analysis. Die zwei zusätzlichen Ankündigungen aus 1.4
("we also record which reporting features ... and we report how often our own first mapping ... was
wrong") werden in 3.5 gemeinsam beantwortet, ebenfalls an der richtigen Stelle nach den vier
Hauptfragen.

In 4.1 (Principal findings, Zeilen 521–536) entsprechen die ersten vier Sätze exakt den vier Fragen in
derselben Reihenfolge (Feasibility/Verlust → Reproduktion → Fragilität über äquivalente Wahlmöglichkeiten
→ Erweiterung durch das defensible Grid), gefolgt von einem fünften Satz zu Reporting und Mapping, der
die zwei Zusatzpunkte aus 1.4 aufgreift. Keine Abweichung in Reihenfolge oder Inhalt gefunden.

## Zahlenübersicht

- Geprüfte, in der Aufgabenstellung explizit genannte Zahlen: alle konsistent.
- Zusätzlich gefundene Inkonsistenz zwischen Abschnitten: 1 (0,07 vs. 0,063 SD, Discussion 4.1/4.3 gegen
  Results 3.2/Tabelle 3), plus 1 Präzisionshinweis ("three trials" vs. rechnerisch vier).
- Abweichungen Abstract/Conclusion gegen Dateien: 0.
- Fehlende Zitatschlüssel: 1 (`Hardwicke_2018`); 2 weitere mit abweichendem BibTeX-Typ (`Gelman_Loken_2013`,
  `ICH_2019_E9R1`), technisch vorhanden.
- Fehlende Abbildung: 1 (Figure 3, im Text nie referenziert).
- Weitere Versprechen-Einlösung-Lücken: doppeltes Supplement S1, ein in Methods angekündigtes, in
  Results nicht berichtetes Mass (Anteil \|d\| > 0,2), unvollendeter Second-Coder-Check (selbst
  markiert), kein Supplement-Dokument im Projekt vorhanden.
- Aims gegen Results (1.4 vs. 3.1–3.4 vs. 4.1): keine Abweichung.
