# Statistisches Gutachten zu `manuscript/OUTLINE.md` (Version vom 2026-09-12)

Gutachter-Perspektive: Biostatistik, klinische Studien, Multiverse-Methodik. Grundlage:
`OUTLINE.md`, `STAND.md`, `METHODENPRUEFUNG.md`, `NODES.md`, `R/grid.R`, `R/engine.R`,
`R/decompose.R`, `R/summary_measures.R`, `R/reproduce.R`, `R/integrity_screen.R`, sowie
`output/summary_by_study.csv`, `output/reproduction.csv`, `output/duplicates.csv`,
`output/variance_summary.csv`, `output/integrity_screen.csv`, `output/pipeline_similarity.csv`,
`config/registry.csv`, `config/published.csv`, `config/published_overrides.csv`,
`config/exclusions.csv`, `config/registry_v1_2026-08-28.csv`, `candidates/deposit_contents.csv`.
Alle Zahlen wurden mit Python (pandas) und R (Rscript) direkt aus den Dateien nachgerechnet,
nicht geschätzt.

## Zusammenfassung

Die Architektur (principled/defensible-Trennung, Registry als einzige Schnittstelle,
Typ-II-Zerlegung je Studie, fester Standardisierungsnenner, dokumentierte Duplikat- und
Integritätsprüfung) ist methodisch tragfähig und deutlich über dem Standard vieler
publizierter Multiverse-Analysen. Der überwiegende Teil der Zahlen in Abschnitt 3 von
`OUTLINE.md` (rund 35 von 42 geprüften Angaben) stimmt exakt mit den Output-Dateien überein,
einschliesslich einiger nicht-trivialer Kombinationszahlen (z. B. die Strata-Aufteilung
5/1/1/1/6/2 = 16, oder die Reporting-Tabelle aus `config/published.csv`). Es gibt jedoch
mehrere echte Zahlenabweichungen (Abschnitt 1) und einen konkreten Implementierungsfehler in
der Reproduktions-Matching-Logik, der eine Kernaussage von Abschnitt 3.3 widerlegt
(Abschnitt 2, Befund 1). Die grössere methodische Schwäche liegt nicht in Rechenfehlern,
sondern darin, dass mehrere Kernaussagen (kleine Fragilität, gute Reproduktion, dominanter
Knoten) als Punktangaben ohne jede Unsicherheit über 12 bis 16 Studien berichtet werden,
obwohl die zugrunde liegenden Anteile bei diesem n sehr breite Kompatibilitätsintervalle
haben.

---

## Teil 1: Zahlenabgleich (Prüfpunkt 1)

Format: Behauptung in OUTLINE.md → Datei/Berechnung → Befund.

| # | Zeile(n) | Behauptung | Geprüft gegen | Befund |
|---|---|---|---|---|
| 1 | 115, 212 | 423 gescreent | `candidates/clinical_studies_with_repos.csv` (424 Zeilen inkl. Header) | stimmt |
| 2 | 118, 212 | 152 mit Repo-Link, 91 RCTs | `candidates/deposit_contents.csv` (152 Zeilen, `is_rct` Summe 91) | stimmt |
| 3 | 120, 212, 218 | 84 erreichbar; OSF 48, Zenodo 23, Dryad 11, figshare 2 | `deposit_contents.csv`, Filter `n_files>0` | stimmt exakt |
| 4 | 120, 212 | 74 mit Tabellendatei, 48 RCTs | `deposit_contents.csv`, `n_tabular>0` bzw. zusätzlich `is_rct` | stimmt exakt |
| 5 | 213, 219–221 | 16 eingeschlossen (13 Primär-, 3 Sekundärberichte) | `config/registry.csv` (16 Zeilen), `report_type` | stimmt exakt |
| 6 | 216 | 32 Ausschlüsse | `config/exclusions.csv` (32 Zeilen) | stimmt |
| 7 | 216–217 | Ausschlussstruktur 16 Design / 11 Daten / 2 kein Kontrast / 3 sonstige | `exclusions.csv`, `reason_code` | **rechnerisch nur EINE Zuordnung möglich, die stimmt, aber diese Zuordnung steht in keiner Datei** (siehe Teil 2, Befund 5); ausserdem widerspricht sie Methods 2.4, wo binäres Outcome explizit als Design-Ausschluss gelistet ist |
| 8 | 219–221 | 5 Physio/Reha Patienten, 1 Survivors, 1 Neuromodulation, 1 Steroid, 6 Training/Ernährung gesund, 2 Schwangerschaft | `registry.csv`, `field`×`population` | stimmt exakt (5+1+1+1+6+2=16) |
| 9 | 221 | Fallzahlen 16 bis 294 | `summary_by_study.csv`, Spalte `n` | stimmt exakt |
| 10 | 222 | Code mit Daten deponiert: 10 von 74 | `deposit_contents.csv`, `n_tabular>0 & n_code_files>0` | stimmt exakt; für die 16 Eingeschlossenen (noch als `[check]` markiert): aktuell **2 von 16** (clusterset, physiofeedback) |
| 11 | 225 | Primäres Outcome deklariert 7/16, aus Abstract 9 | `published.csv`, `primary_outcome_declared` | stimmt exakt |
| 12 | 226 | Punktschätzer 12/16, nur p/F 4 | `published.csv` `published_est` **nach** Anwendung von `published_overrides.csv` | stimmt exakt; **roh** (ohne Override) wäre es 13/3, weil Phosphatidsäure roh mit dem F-Wert 33.3 als `published_est` geführt wird |
| 13 | 227–228 | Estimand genannt 1/16 | `published.csv`, `C_estimand_stated` | stimmt |
| 14 | 227–228 | Baseline-Test 13/16, adjustiert danach 3 | `published.csv`, `C_baseline_test_reported`, `C_adjust_after_baseline_test` | stimmt exakt |
| 15 | 229–230 | Baseline-Handling ANCOVA 6, Change 4, Endpoint 2, sonstige 4 | `published.csv`, `B_baseline_handling` | stimmt exakt |
| 16 | 230 | Modellfamilien ANOVA 5, mixed 6, ANCOVA 3, t-Test 1, nichtparametrisch 1 | `published.csv`, `B_model_family` | stimmt, wenn `mixed_ri`(5)+`mixed_slopes`(1)=6 zusammengefasst werden |
| 17 | 231–232 | Missing: none 7, complete case 4, likelihood 3, MI 1, n.r. 1 | `published.csv`, `B_missing_strategy` | stimmt exakt (`mmrm_ml`=„likelihood") |
| 18 | 232 | Ausreisserregel berichtet 0/16 | `published.csv`, `B_outlier_rule` | stimmt (16× `not_reported`) |
| 19 | 232 | Log-Transformation 1 | `published.csv`, `B_transformation` | stimmt |
| 20 | 233 | Protokoll/Registrierung 7/6/3 | `published.csv`, `C_protocol_available` | stimmt exakt |
| 21 | 234 | Journal mit Datenpflicht 10, unklar 6 | `published.csv`, `journal_requires_data_sharing` | stimmt exakt |
| 22 | 239 | Reproduktion: 6 voll, 2 minor (3,0 %, 6,9 %), 4 major (19–29 %) | `output/reproduction.csv` | stimmt (major-Spanne exakt 18,7–28,9 %, gerundet 19–29 %) |
| 23 | 241 | Publizierte Spezifikation vollständig abbildbar 8/12 | `reproduction.csv`, `spec_fully_matched` | stimmt als Zahl, **aber Zähler ist fehlerhaft konstruiert**, siehe Teil 2, Befund 1 |
| 24 | 241–243 | „Drei der vier grossen Abweichungen sind nicht abbildbar" | `reproduction.csv` | **stimmt NICHT**: nur 2 von 4 (gainingmore, physiofeedback) haben `spec_fully_matched = FALSE`. `free_PMC6733445` (Bayes/Mixed-Slopes-Fall) zeigt `spec_fully_matched = TRUE`, weil der Knoten „model" für dieses Modell gar nicht bewertet wird (Befund 1) |
| 25 | 244–245 | Publiziert innerhalb principled 9/12, defensible 12/12 | `reproduction.csv`, `inside_principled`/`inside_defensible` | stimmt exakt |
| 26 | 246–247 | Naudet: 8/152 (5 %), 8/48 (17 %) | berechnet aus `reproduction.csv` | stimmt (5,26 % bzw. 16,67 %) |
| 27 | 250 | 395 principled, 1 934 defensible eindeutige Spezifikationen | `output/duplicates.csv`, Summe `n_unique` | stimmt exakt |
| 28 | 250 | „Duplikate kollabiert 3 bis 4 %" | `duplicates.csv`, gepoolt | **stimmt nicht für defensible**: gepoolter Duplikatanteil 4,36 % (principled) vs. **6,12 %** (defensible), nicht 3–4 % |
| 29 | 252–253 | Principled: Median 0,14 SD (IQR 0,07–0,22), Max 0,89 (tDCS, n=20); Vorzeichen stabil 15/16; schliesst 0 ein in 1 (FREE) | `summary_by_study.csv` | stimmt exakt |
| 30 | 253–254 | Defensible: Median 0,25 (IQR 0,11–0,36), Max 0,91; Vorzeichen 14/16; schliesst 0 ein in 2 (FREE, ETIP) | `summary_by_study.csv` | stimmt exakt |
| 31 | 254 | Verhältnis defensible/principled, Median 1,37 | `output/summary_grids_compared.csv`, mit `Rscript median()` nachgerechnet | **stimmt nicht**: tatsächlicher Median ist **1,40**. Zusätzlich: `etre_PMC11945196` hat principled-Spannweite = 0 → Verhältnis = `Inf`; dieser Sonderfall wird im Text nicht erwähnt |
| 32 | 255–257 | Baseline dominant 10/15 (principled), outlier 3, covars 2, inference 0 | `variance_summary.csv` | stimmt exakt |
| 33 | 257 | Defensible: Log-Transformation dominant in 5/16 | `variance_summary.csv` | stimmt exakt |
| 34 | 257–258 | „Inferenz erklärt Median 2 bis 3 % der Intervallbreite" | `variance_summary.csv`, Zielgrösse `ci_width_d`, Knoten `inference` | **stimmt nicht**: Median-Anteil ist **4,21 %** (principled, IQR 0,21–17,6 %) bzw. **5,34 %** (defensible, IQR 0,32–10,3 %) |
| 35 | 259–260 | Physio/Reha (8): Median 0,18, Max 0,89; Training/Ernährung gesund (8): Median 0,06, Max 0,40 | `registry.csv` × `summary_by_study.csv` | stimmt exakt (0,176 bzw. 0,061 gerundet); Stratum-**Bezeichnung** widerspricht aber Zeile 219–221 (siehe Teil 2, Befund 6) |
| 36 | 261–262 | Pipeline-Ähnlichkeit 10/19 | `output/pipeline_similarity.csv` | **veraltete Zahl, vom Autor selbst als `[recompute for the 16]` markiert**: Datei hat aktuell nur 15 Zeilen für 16 Studien (`lytras_fms_PMC12942207` fehlt vollständig), davon 9/15 mit `cor_min > 0,99` |
| 37 | 263 | Integritätsscreen: kein Flag | `output/integrity_screen.csv` | stimmt (16/16 „pass") |
| 38 | 267–268 | Registry v1→v2: Kontrollarm falsch in 8/16, Outcome in 4, Kovariaten in 11; 5 Studien ausgeschlossen | `registry_v1_2026-08-28.csv` vs. `registry.csv` | Zahl „5" stimmt exakt (21−16); **8/4/11 sind in keiner Datei nachvollziehbar**, nur Prosa in `METHODENPRUEFUNG.md` |
| 39 | 316–317 | „36 core options is deliberately small" | `R/grid.R` (8 Knoten, 22 Optionen: 15 principled + 7 zusätzliche Typ N) | **stimmt nicht** und ist wahrscheinlich eine Verwechslung mit dem Veltri-2026-Zitat in `NODES.md` Zeile 16 („180 Analysepfade aus 36 Preprocessing-Pipelines"), das eine **andere** Studie beschreibt |
| 40 | 205 | „packages lme4, lmerTest, sandwich, mice, car" | `R/engine.R`, `R/decompose.R` | unvollständig: `dplyr`, `readxl`, `haven`, `lmtest` fehlen in der Aufzählung |
| 41 | 326 (Discussion 4.8, direkt aus 3.3-Zahlen abgeleitet) | „recomputation … possible for about one in ten trials with a link" | 8/152 = 5 %, 8/48 = 17 % | **stimmt nicht**, keiner der beiden in 3.3 definierten Nenner ergibt „eine von zehn"; unabhängig davon bereits in einer parallel laufenden Logikprüfung (`manuscript/review_logic.md`, Befund 1) notiert |

**Zusammenfassung Zahlenabgleich:** 41 geprüfte Einzelbehauptungen, davon 33 exakt korrekt,
1 nur nach stiller Anwendung eines Override korrekt (Punkt 12, sollte im Methodenteil erwähnt
werden), 2 nicht aus einer Datei nachvollziehbar (Punkte 7, 38), 5 echte Abweichungen (Punkte
24, 28, 31, 34, 39) und 2 vom Autor selbst als veraltet markiert (Punkte 10-Teilzahl, 36).

---

## Teil 2: Methodische Prüfpunkte, nach Schwere geordnet

### SCHWERWIEGEND

#### Befund 1 (Prüfpunkt 5, verknüpft mit Prüfpunkt 1 Zeile 241–243). Die Matching-Logik zählt nicht abbildbare Modelltypen als „passt"

**Ort:** `R/reproduce.R` Zeile 29–34 (`map_model`), Zeile 52–59 (Scoring-Schleife).

**Befund:** `map_model` ist ein benannter R-Vektor ohne Eintrag für `"mixed_slopes"`.
`free_PMC6733445` hat `B_model_family = "mixed_slopes"` (`config/published.csv`). Der
Aufruf `map_model["mixed_slopes"]` liefert in R **NA**, ohne Fehler oder Warnung (mit
`Rscript` verifiziert). In der Scoring-Schleife gilt `if (is.na(target[[nd]]) || ...) next`
– der Knoten „model" wird dadurch **weder gezählt noch als Nicht-Match gewertet**, sondern
still aus Zähler (`sc`) und Nenner (`k`) entfernt. Für `free_PMC6733445` ergibt das
`nodes_scored = 6` (nicht 7) und `spec_fully_matched = TRUE`, obwohl das publizierte
Random-Slopes-Modell im Gitter gar nicht existiert (das Gitter kennt nur `lm` und
`mixed_ri`, ein Random-Intercept-Modell). Damit **widerspricht die Datei die eigene
Aussage im Text** (Zeile 241–243: „three of the four major discrepancies have
non-representable specifications … Bayesian multilevel model"): Laut `reproduction.csv`
haben nur `gainingmore_PMC10809978` und `physiofeedback_PMC12821712`
`spec_fully_matched = FALSE`; `free_PMC6733445` (der vermutlich gemeinte „Bayes"/Mixed-
Slopes-Fall) und `mallorca_PMC8198819` zeigen beide `TRUE`.

**Warum das schwer wiegt:** Das ist keine Rundungsdifferenz, sondern ein
Implementierungsfehler, der die Kernzahl aus Table 3 (8 von 12 „vollständig abbildbar")
optimistisch verzerrt: Jeder Knoten, dessen publizierte Kategorie keinen Eintrag in einer
`map_*`-Tabelle hat, wird automatisch als „nicht zu bewerten" statt als „nicht abbildbar"
behandelt. Ein Gutachter, der `reproduction.csv` nachrechnet (wie hier geschehen), findet
einen Widerspruch zur Prosa, der das Vertrauen in die gesamte Stufe-2-Auswertung
untergräbt.

**Vorschlag:** In `reproduce.R` NA-Zielwerte, die aus einem **fehlenden Schlüssel** in der
Mapping-Tabelle stammen (echte Nicht-Repräsentierbarkeit, z. B. `mixed_slopes`, Bayes,
GEE mit unstrukturierter Kovarianz), von NA-Zielwerten trennen, die **bewusst** auf „nicht
bewertbar" gesetzt sind (z. B. `baseline = "other"/"unclear"`, `model = "nonparam"/"other"`).
Erstere sollten `nodes_scored` erhöhen und automatisch als Nicht-Match zählen (oder
mindestens `spec_fully_matched` auf `FALSE` setzen und den Grund benennen), nicht
stillschweigend aus der Bewertung fallen. `map_model` um einen expliziten Eintrag
`mixed_slopes = NA_representable` (mit eigenem Flag) ergänzen. Nach der Korrektur Table 3
und die Zahl „8 von 12" neu ziehen.

#### Befund 2 (Prüfpunkt 2). Der Standardisierungsnenner ist die Gesamt-SD über beide Arme, nicht die gepoolte Innerhalb-Gruppen-SD

**Ort:** `R/engine.R` Zeile 66 (`attr(out, "sd_raw") <- stats::sd(out$.y, na.rm = TRUE)`);
`OUTLINE.md` Zeile 192–194.

**Befund:** `stats::sd(out$.y)` berechnet die Streuung über **alle** Beobachtungen beider
Arme zusammen, also inklusive der Varianzkomponente, die aus dem Mittelwertunterschied
zwischen den Armen selbst stammt. Das ist nicht dasselbe wie die klassische „gepoolte
Innerhalb-Gruppen-SD" von Cohen's d / Hedges' g (`sqrt(((n1-1)s1²+(n2-1)s2²)/(n1+n2-2))`),
die per Definition den Zwischen-Gruppen-Unterschied **ausschliesst**. Bei echtem
Behandlungseffekt ist die Gesamt-SD systematisch grösser als die Innerhalb-Gruppen-SD, und
zwar umso mehr, je grösser der Effekt ist (Beitrag zur Gesamtvarianz durch den
Mittelwertunterschied bei balancierten Gruppen ≈ (Mittelwertdifferenz)²/4). Für die Studie
mit dem grössten berichteten d (tDCS, principled Max 0,89, `n = 20`) bedeutet das: Genau
dort, wo der Effekt am grössten und die Stichprobe am kleinsten ist, wird der Nenner am
stärksten durch den Effekt selbst aufgebläht, was den berichteten d-Wert nach unten
verzerrt. Die Formulierung in `OUTLINE.md` Zeile 192 („SD of the raw outcome across arms")
ist mit dieser Implementierung konsistent, deckt sich aber nicht mit dem, was Leser unter
„gepoolter SD" (Cohen/Hedges-Konvention) verstehen, und ist auch nicht die in der Cochrane-
Methodik empfohlene Praxis für den Vergleich von Endwert- und Change-Score-Analysen
(dort wird explizit die SD der **Endwerte je Arm**, gepoolt über Freiheitsgrade, verwendet,
nicht die Gesamt-SD über beide Arme hinweg).

**Warum das schwer wiegt:** Der Nenner ist die Grundlage jeder d-Zahl im Paper (Median
0,14/0,25, Maximum 0,89/0,91, die gesamte Varianzzerlegung). Eine systematische, mit dem
wahren Effekt korrelierte Verzerrung im Nenner ist ein anderes, aber verwandtes Problem zu
dem in `METHODENPRUEFUNG.md` Punkt 2 bereits behobenen Fehler (spezifikationsabhängiges
`sigma`).

**Vorschlag:** Auf die klassische gepoolte Innerhalb-Gruppen-SD umstellen:
`sqrt(((n1-1)*var(y[arm1])+(n2-1)*var(y[arm2]))/(n1+n2-2))`, berechnet einmal je Studie vor
jeder Vorverarbeitung, exakt wie der jetzige Nenner nach Spezifikation konstant. Das ist
technisch trivial (Armzugehörigkeit ändert sich über Spezifikationen nicht) und macht d mit
der Standard-Cohen's-d/Hedges'-g-Konvention vergleichbar, was für den Vergleich mit anderen
Multiverse- und Meta-Analysen (Veltri 2026, Short 2026) wichtig ist, da diese vermutlich die
klassische Konvention verwenden.

#### Befund 3 (Prüfpunkt 4). Die 2-%-/10-%-Regel ist bei kleinen publizierten Schätzern nicht sinnvoll interpretierbar

**Ort:** `R/reproduce.R` Zeile 63; `OUTLINE.md` Zeile 154–156.

**Befund:** Mit den tatsächlichen Daten aus `reproduction.csv` bestätigt: Physiofeedback
hat `published_est = 0,02`, `our_est = 0,0145`, `rel_diff = 27,4 %` → Klasse „major
discrepancy". Die **absolute** Differenz ist 0,0055 auf der Rohskala, was einem
standardisierten Unterschied von etwa 0,014 SD entspricht (`published_d = 0,059`,
Studienstreuung principled 0,027–0,084 laut `summary_by_study.csv`) – deutlich innerhalb der
Spannweite ohnehin vorhandener analytischer Fragilität. Eine relative Regel ist bei
Schätzern nahe 0 per Definition instabil (jede beliebig kleine absolute Differenz erzeugt
eine beliebig grosse relative Differenz), unabhängig von der inhaltlichen Bedeutung des
Unterschieds.

**Warum das schwer wiegt:** Von den 4 „major discrepancies" ist mindestens 1
(Physiofeedback) vermutlich ein Artefakt der Nenner-Wahl und nicht ein Hinweis auf
tatsächliche Nicht-Reproduzierbarkeit. Das verzerrt die Kernzahl „6 voll, 2 minor, 4 major"
in Richtung schlechterer Reproduktion, als die Daten hergeben.

**Vorschlag:** Klassifikationsregel um ein zweites, absolutes Kriterium ergänzen, wahlweise
(a) absolute Differenz relativ zur Studien-SD (d. h. auf der d-Skala, die im Paper ohnehin
überall verwendet wird: „voll" wenn `|d_unser − d_publiziert| ≤ 0,05` UND relative Differenz
≤ 2 %, oder wenn eines der beiden Kriterien erfüllt ist), oder (b) relativ zum publizierten
SE (`|est_unser − est_publiziert| / SE_publiziert`), falls berichtet. Für Physiofeedback und
alle anderen Grenzfälle im Text explizit die Rohgrösse und die Studienspannweite angeben,
nicht nur den Prozentsatz.

#### Befund 4 (Prüfpunkt 10). Zentrale Anteile werden als Punktangaben ohne Unsicherheit berichtet

**Ort:** `OUTLINE.md` Abschnitt 3.1–3.5 durchgehend (z. B. Zeile 244–245, 252–254, 255–257).

**Befund:** Mit Wilson-Score-Intervallen (95 %) nachgerechnet, exemplarisch:

| Angabe | n | 95 %-KI (Wilson) |
|---|---|---|
| Voll+minor reproduziert, 8/12 | 12 | 39,1–86,2 % |
| Publiziert innerhalb principled, 9/12 | 12 | 46,8–91,1 % |
| Vorzeichen stabil principled, 15/16 | 16 | 71,7–98,9 % |
| Vorzeichen stabil defensible, 14/16 | 16 | 64,0–96,5 % |
| Baseline dominanter Knoten principled, 10/15 | 15 | 41,7–84,8 % |
| Reproduziert, Naudet-Nenner 152, 8/152 | 152 | 2,7–10,0 % |

Keine dieser Grössen hat im aktuellen Entwurf ein Intervall. Für „Vorzeichen stabil in 15
von 16" reicht das 95-%-KI von 72 % bis 99 % – „stabil" ist bei n = 16 mit weitem Intervall
verträglich, aber auch mit deutlich weniger Stabilität, als die Punktangabe suggeriert.
Zusätzlich fehlt jede Unsicherheitsangabe für die Studien-übergreifenden Mediane selbst
(Median-d-Spannweite 0,14 bzw. 0,25 über nur 16 Studien) und für das
Verhältnis-defensible/principled (Median 1,40, siehe Befund oben, mit einem `Inf`-Wert unter
den 16 Beobachtungen).

**Warum das schwer wiegt:** Genau der Fehler, den das Gutachten laut Auftrag nicht selbst
begehen soll (Overlapping-CI-Fehlschluss), lässt sich hier nicht einmal prüfen, weil keine
CIs berichtet werden; aber das eigentliche Problem ist allgemeiner: Bei n = 12 bis 16 ist
jede ungerundete Prozentangabe ohne Intervall geeignet, Präzision zu suggerieren, die nicht
vorhanden ist. Das widerspricht der selbstgesetzten Regel „Uncertainty as intervals and
s-values" (Zeile 10–11).

**Vorschlag:** Für alle Kernanteile in Table 3 und 3.3–3.5 ein Wilson- oder Bootstrap-KI
ergänzen (bei n ≤ 20 kein Normal-Approximations-Intervall verwenden). Für die
Studien-Mediane (d-Spannweite, Verhältnis defensible/principled) ein Bootstrap-KI über die
16 Studien (Resampling der Studien, nicht der Spezifikationen) angeben oder zumindest den
Min/Max explizit neben dem Median nennen (wird für d-Range bereits getan, für das
Verhältnis defensible/principled aktuell nicht). Die Differenz publizierter Schätzer minus
Multiverse-Median als eigene Verteilung über die 16 Studien darstellen (z. B. als
Boxplot/Dotplot der 12 verfügbaren Differenzen), nicht als CI-Vergleich.

---

### MITTEL

#### Befund 5 (Prüfpunkt 1, 7). Die Ausschlussstruktur „16/11/2/3" ist rechnerisch stimmig, aber die Zuordnung steht in keiner Datei

**Befund:** `exclusions.csv` hat eine Spalte `reason_code` mit 16 Kategorien, aber keine
Spalte, die diese 16 Kategorien den vier Summenzahlen aus Zeile 216–217 zuordnet. Die
einzige Zuordnung, die exakt 16/11/2/3 ergibt: „Design" = `crossover_design`(5) +
`within_person_design`(2) + `feasibility_primary`(3) + `not_clinical`(4) + `not_rct`(2) = 16;
„Daten unzureichend" = `arm_not_in_data`(3) + `outcome_not_identifiable`(2) +
`outcome_data_not_tabular`(2) + `no_ipd`(1) + `file_not_readable`(1) +
`no_data_in_deposit`(1) + `outcome_timepoint_not_in_deposit`(1) = 11; „kein
Armkontrast-Schätzer" = `no_group_estimate`(1) + `secondary_analysis_no_estimate`(1) = 2;
„sonstige" = `duplicate_data`(2) + `binary_outcome`(1) = 3. Diese Zuordnung erfordert, dass
`binary_outcome` NICHT als Design-Ausschluss zählt – widerspricht aber Methods 2.4 (Zeile
133–135), wo „binary primary outcome (grid built for continuous)" explizit als einer von
sieben Design-Ausschlussgründen gelistet ist.

**Vorschlag:** `exclusions.csv` um eine Spalte `category` (design/data/no_estimate/other)
ergänzen, die diese Aggregation herstellt, damit die Zahl 16/11/2/3 – wie im Rest des
Papers gefordert („every number in the text traces to a file") – tatsächlich aus einer
Datei ablesbar ist. Gleichzeitig die Methods-Beschreibung (2.4) und die
Kategorienzuordnung inhaltlich abgleichen (`binary_outcome` gehört inhaltlich klar zu
„Design", nicht zu „sonstige").

#### Befund 6 (Prüfpunkt 1, 3). Die Stratum-Bezeichnung „healthy adults" widerspricht der Aufteilung in 3.1

**Befund:** Zeile 219–221 zählt „6 training or nutrition in healthy adults" **getrennt**
von „2 exercise in pregnancy". Die Strata-Analyse in Zeile 259–260 fasst beide zu einem
Stratum „training and nutrition in healthy adults (8)" zusammen (`exercise_physiology` +
`sports_nutrition`, unabhängig von `population`). Rechnerisch korrekt (6+2=8), aber
begrifflich inkonsistent: Schwangere sind in Zeile 221 explizit nicht „healthy adults
[non-pregnant]" genannt, tauchen in der Stratum-Bezeichnung von Zeile 259 aber genau dort
auf. Eine der beiden Studien in diesem Substratum (`mallorca_PMC8198819`) hat als Outcome
zudem die Edinburgh Postnatal Depression Scale – ein psychiatrisches Outcome bei
Wöchnerinnen, kein „Training/Ernährung an Gesunden" im engeren Sinn.

**Vorschlag:** Stratum entweder umbenennen (z. B. „exercise physiology and sports
nutrition, non-clinical intervention context" statt „healthy adults") oder die 2
Schwangerschaftsstudien als eigenes drittes Stratum führen und explizit begründen, warum
sie stattdessen dem zweiten Stratum zugeschlagen werden.

#### Befund 7 (Prüfpunkt 3). Typ-II-Quadratsummen ignorieren Interaktionen und strukturelle (nicht nur numerische) Unbalanciertheit

**Ort:** `R/decompose.R` Zeile 21 (`lm(y ~ node1 + node2 + ...)`, rein additiv);
`R/grid.R` Zeile 152–157 (Streichung inkohärenter Kombinationen).

**Befund:** Das Modell enthält **keine** Interaktionsterme zwischen Knoten. `grid.R`
entfernt strukturell ganze Zellen: `model == "mixed_ri"` kommt nur mit `inference ==
"model"` vor (nie mit `hc3`/`permutation`), `missing == "mi"` nie mit
`inference == "permutation"`. Das ist keine gewöhnliche Unbalanciertheit (ungleiche
Zellhäufigkeiten), sondern **fehlende Zellen** (Häufigkeit exakt 0 für bestimmte
Kombinationen). Für den Knoten `model` (2 Stufen) bedeutet das: Sobald `model = mixed_ri`
gilt, ist `inference` konstant `"model"` – die beiden Knoten sind dann partiell konfundiert.
`car::Anova(type=2)` liefert unter solchen Bedingungen eine Zahl, aber ihre Interpretation
als „eindeutig diesem Knoten zurechenbarer Varianzanteil, unabhängig von anderen Knoten"
ist nicht mehr garantiert, weil die Typ-II-Logik (Test jedes Haupteffekts unter der
Annahme, dass höhere Interaktionen mit ihm null sind) hier durch Design, nicht durch
Zufall, verletzt sein kann.

**Vorschlag:** Im Methodenteil explizit benennen, dass Interaktionen nicht modelliert
werden und warum (Rechtfertigung: Anzahl Spezifikationen je Studie ist für ein volles
Interaktionsmodell oft zu klein, z. B. `etre_PMC11945196` mit nur 3 principled
Spezifikationen). Als Sensitivitätsprüfung mindestens für die grossen Studien (tereco,
free, mit 72 bzw. 140 principled Spezifikationen) ein Modell mit den wichtigsten
Zwei-Wege-Interaktionen (insbesondere `model:inference`, `missing:inference`) rechnen und
im Supplement berichten, ob sich die Knoten-Rangfolge ändert. Die konfundierten
Knotenpaare (`model`×`inference`, `missing`×`inference`) explizit als Limitation der
Zerlegung nennen.

#### Befund 8 (Prüfpunkt 3). „Knoten mit grösstem Anteil in k von n Studien" verdeckt, dass der Anteil bei vielen Studien trivial 100 % ist

**Ort:** `output/variance_summary.csv`, Zeile für `baseline`/`principled`/`d`.

**Befund:** `baseline` hat für `d`/principled einen **Median-Anteil von 100 %** (IQR
93,3–100 %) über die 12 Studien, in denen der Knoten variiert. Das ist keine knappe
Dominanz, sondern (in den meisten dieser Studien) der einzige Knoten, der überhaupt noch
variiert, nachdem `applicable_options()` alle anderen Knoten auf eine einzige Option
reduziert hat (kein Missing, keine wirksame Ausreisserregel, keine schätzbare Clusterung).
„top_in 10 von 15" beschreibt daher grösstenteils Studien, in denen Baseline-Handling der
**einzige** aktive Freiheitsgrad ist, nicht Studien, in denen Baseline-Handling einen
Mehrfach-Knoten-Wettbewerb „gewinnt". Im defensible-Gitter ist der Median-Anteil für
Baseline niedriger (86,2 %, IQR 27,6–98,4 %), was diese Interpretation stützt: Mit mehr
aktiven Knoten wird die Dominanz weniger absolut.

**Vorschlag:** Neben „top_in k von n" auch den Median-Anteil des dominanten Knotens
berichten (aus `variance_summary.csv` bereits vorhanden: `median_share`), und im Text
explizit unterscheiden zwischen Studien mit nur 1 aktivem Knoten (trivial 100 %) und
Studien mit echtem Mehrfach-Knoten-Wettbewerb. `n_studies_total` (12 bzw. 15/16) im Text
nennen, nicht nur den Zähler.

#### Befund 9 (Prüfpunkt 6). Multiple Imputation mit m = 10 ist bei der höchsten beobachteten Missing-Rate (35 %) knapp

**Ort:** `R/engine.R` Zeile 20 (`MI_M <- 10`).

**Befund:** Die Imputationsmodell-Spezifikation (Arm, Baseline, publizierte Kovariaten,
Stratifizierungsvariablen; PMM; Rubin-Pooling mit Barnard-Rubin-Freiheitsgraden nach der
korrekten Formel, Zeile 190–196) ist sauber implementiert und der Seed ist tatsächlich je
Spezifikation fix (`seed + i`, `R/engine.R` Zeile 225–231, mit `Rscript` nachvollzogen).
Für `etip_PMC6886967` beträgt der Missing-Anteil jedoch etwa 35 % (ermittelt aus den
frisch erzeugten Rohdaten in `output/range_drivers.csv`). Nach der Faustregel „m ≈ 100 ×
Fraction of Missing Information" (White, Royston & Wood 2011) ist m = 10 für eine Studie
mit so hoher Missing-Rate eher niedrig; moderne Empfehlungen (von Hippel 2020) liegen
meist bei m = 20 bis 50, besonders wenn – wie hier – aus der gepoolten Schätzung ein
p-Wert und daraus ein s-Wert berichtet wird, der von der MC-Fehlerkomponente der
Rubin-Regel abhängt.

**Vorschlag:** m auf mindestens 20 erhöhen (Rechenkosten sind bei diesen Fallzahlen
gering) oder die Wahl m = 10 explizit mit der beobachteten FMI je Studie begründen.

#### Befund 10 (Prüfpunkt 7). 499 Permutationen begrenzen den erreichbaren s-Wert auf ca. 9 Bit

**Ort:** `R/engine.R` Zeile 160–168 (`replicate(499, ...)`, `p = (1 + sum(...)) / 500`).

**Befund:** Die Formel selbst ist korrekt (Standard-„Add-one"-Schätzer, vermeidet
p = 0; Phipson & Smyth 2010; Davison & Hinkley 1997). Das Problem ist die **Auflösung**:
Der kleinstmögliche p-Wert ist `(1+0)/500 = 0,002`, was einen s-Wert-Deckel von
`-log2(0,002) ≈ 8,97` Bit erzeugt – unabhängig davon, wie stark der wahre Effekt ist. Zum
Vergleich: In `reproduction.csv` erreichen modellbasierte p-Werte für dieselben Studien
Werte bis `5,1 × 10⁻⁹` (tereco), was einem s-Wert von rund 27,5 Bit entspricht, und
`summary_by_study.csv` zeigt für mehrere Studien s-Wert-Maxima über 15–32 Bit. Für jede
Spezifikation mit `inference = "permutation"` in einer gut bestimmten Studie wird der
s-Wert also nicht durch die Datenstärke, sondern durch die Anzahl der Permutationen
gedeckelt. Das erzeugt einen artifiziellen Beitrag des Knotens „inference" zur
Intervallbreiten-/Evidenz-Zerlegung (Befund 34 im Zahlenabgleich, „2–3 %"/tatsächlich
4–5 % Anteil), der teils Auflösungsartefakt ist, nicht echter Methodenunterschied.

**Vorschlag:** Permutationsanzahl auf mindestens 9 999 erhöhen (ergibt s-Wert-Deckel
≈ 13,3 Bit) oder, wenn Rechenzeit ein echtes Problem ist, mindestens für Studien mit
kleinem `our_p` (tereco, spadi, tscs) gezielt mehr Permutationen fahren. Alternativ im Text
explizit den Auflösungsdeckel benennen und aus der s-Wert-Interpretation für
permutationsbasierte Spezifikationen ausklammern.

#### Befund 11 (Prüfpunkt 9). Der MCID-Ersatz 0,2 SD ist für alle 16 Studien der Default, nicht ein Instrumenten-MCID

**Ort:** `R/summary_measures.R` Zeile 23 (`thr <- if (is.na(mcid_d)) 0.2 else mcid_d`);
`output/summary_by_study.csv`, Spalte `mcid_source`.

**Befund:** Mit Python nachgerechnet: **Alle** 32 Zeilen (16 Studien × 2 Gitter) in
`summary_by_study.csv` haben `mcid_source = "default_0.2"`; `config/published.csv` hat für
**keine** der 21 Studien einen Wert in `mcid_raw`. Cohens 0,2 ist ein generischer
„kleiner Effekt" für Verhaltenswissenschaften, kein publiziertes Minimal Important
Difference für ein bestimmtes Instrument (SPADI, EPDS/PGWBI, RMDQ, BBS haben alle
publizierte, sehr unterschiedliche MID/MCID-Werte in der Originaleinheit). Der Begriff
„MCID" im Methodenteil (Zeile 196: „MCID not available per instrument") ist daher für
diesen Analyseschritt irreführend, solange er zu 100 % durch den Cohen-Default ersetzt
wird.

**Vorschlag:** Entweder vor Einreichung für die Instrumente mit publizierten MCID-Werten
(mindestens SPADI, ggf. RMDQ/FREE, BBS) die echten Werte in `mcid_raw` eintragen, oder das
Mass konsequent als „Anteil mit |d| > 0,2 (Cohens Konvention für einen kleinen Effekt)"
bezeichnen und den Begriff „MCID" im ganzen Manuskript dafür nicht verwenden.

---

### KLEIN

#### Befund 12 (Prüfpunkt 8). Integritätsscreen: fixer Schwellenwert steht im Spannungsverhältnis zur eigenen No-Threshold-Regel

Der Carlisle-Screen flaggt bei `p_carlisle_named < 0,005` oder `> 0,995`
(`R/integrity_screen.R` Zeile 96–97). Das ist als operative Triage-Entscheidung
(„genauer hinschauen ja/nein") vertretbar und liegt nahe an Carlisles eigener Konvention,
steht aber in einem gewissen Spannungsverhältnis zur Selbstverpflichtung „No
'statistically significant' as a verdict" (Zeile 10). Vorschlag: einen Satz ergänzen, der
den Schwellenwert explizit als pragmatische Triage-Regel benennt, nicht als
Signifikanzaussage. Die Stouffer-Kombination (statt Carlisles ursprünglicher
Fisher-Kombination) ist methodisch vertretbar und für die zweiseitige Fragestellung
(„zu ähnlich" vs. „zu unähnlich") sogar natürlicher, sollte aber im Methodenteil kurz
begründet werden, da ein mit Carlisle 2017 vertrauter Gutachter sonst nach der Abweichung
fragt. Der Bolland-2019-Hinweis auf Rundung ist nur teilweise umgesetzt: Der Filter
„< 5 eindeutige Werte gilt als nicht stetig" (Zeile 27) fängt grobe Rundung ab, aber nicht
moderat gerundete Variablen mit z. B. 6–10 Ausprägungen, die trotzdem Carlisle-artige
Scheinbefunde erzeugen können.

#### Befund 13 (Prüfpunkt 5). Ungezähltes Unentschieden bei `outlier_scope` begünstigt strukturell die Reproduktion

`R/reproduce.R` bewertet die Knoten `baseline, covars, missing, model, inference,
transform, outlier` (Zeile 45–49), aber **nicht** `outlier_scope` (gepoolt/armweise).
Sobald für eine Studie eine wirksame Ausreisserregel existiert und `outlier_scope`
mehrere Optionen hat, entstehen bei jeder Übereinstimmung der übrigen 7 Knoten automatisch
Unentschieden über die `outlier_scope`-Werte hinweg, die die Tie-Break-Regel „nächster
Wert" auflöst (Prüfpunkt 5 aus dem Auftrag: Ja, das begünstigt strukturell die
Reproduktion, weil unter den unentschiedenen Kandidaten immer der mit der kleinsten
Differenz zum publizierten Wert gewählt wird, nie der mit der grössten). Vorschlag:
`outlier_scope` in `target` aufnehmen (Default „pooled", da in Papers so gut wie nie
berichtet) oder im Text explizit offenlegen, dass die „nächster Wert"-Regel bei
Gleichstand die berichtete Abweichung nach unten verzerrt (nie nach oben), und diese
Verzerrung als Limitation nennen statt sie unkommentiert zu lassen.

#### Befund 14 (Prüfpunkt 12). 395 principled-Spezifikationen sind extrem ungleich über die 16 Studien verteilt

Aus `output/duplicates.csv`: Die principled-Spezifikationszahl je Studie reicht von 3
(`etre_PMC11945196`) bis 140 (`free_PMC6733445`)/72 (`tereco_PMC8318721`); mehrere Studien
haben nur 6–9 eindeutige Spezifikationen (clusterset 6, creatine 9, gainingmore 9,
lytras_fms 9, mulligan 9, phosphatidic 9, spadi 9, tscs 9). Für `etre_PMC11945196` ist die
principled-Spannweite exakt 0 (alle 3 Spezifikationen liefern denselben d-Wert), weil kaum
ein Knoten in dieser Studie überhaupt anwendbar ist (keine Baseline-Variable). Der
Studien-Median wird korrekt mit gleichem Gewicht je Studie gebildet (nicht
spezifikations-gewichtet, das ist richtig), aber das bedeutet auch, dass ein Drittel der
16 Studien nur 3–9 Spezifikationen zur „Fragilität" beisteuert – die dortige
„Spannweite" ist eine sehr grobkörnige Schätzung mit wenigen Stützstellen, nicht weniger
fragil im eigentlichen Sinn, sondern **kaum getestet**. „Small fragility" als Aussage über
den typischen Fall in diesem kleinen, selbstselektierten 16-Studien-Korpus ist mit den
Daten vertretbar; als generalisierbare Aussage über „das Feld" (Physiotherapie/Reha) ist
sie nicht gedeckt, was der Discussion-Teil (4.7, Selbstselektion) im Prinzip schon
anerkennt, aber nicht mit dem Story-Absatz und der Choice des Wortes „small" (Zeile 33)
konsistent verbindet. Vorschlag: „small" durchgängig auf den Median des vorliegenden
16-Studien-Korpus beziehen, das Maximum (tDCS, sechsfacher Median) im selben Satz nennen,
und im Methodenteil kurz die Streuung der Spezifikationsanzahl je Studie (3 bis 140)
nennen, um zu zeigen, dass der Median nicht durch ein oder zwei spezifikationsreiche
Studien getrieben wird.

#### Befund 15 (kleinere Punkte, gesammelt)

- **Prüfpunkt 11 (korrekt formuliert).** „Inference explains 0 % of estimate variance by
  construction" ist korrekt: Inferenzknoten verändern per Modellkonstruktion nur `se`/`p`,
  nie `est`, also ist der Typ-II-Anteil für `d` mathematisch exakt null (in
  `variance_summary.csv` numerisch `4,6 × 10⁻³¹`, reines Gleitkommarauschen). Die
  Formulierung ist ehrlich und vermeidet den Fehlschluss „Inferenz ist irrelevant" korrekt,
  indem sie im selben Abschnitt auf den `ci_width_d`-Befund verweist. Kleiner
  Stilvorschlag: „by mathematical construction" statt „by construction", um die
  Deduktionsrichtung unmissverständlich zu machen, und den Verweis auf `ci_width_d` im
  selben Satz statt im nächsten.
- **Figuren-Artefakte.** `output/figures/` enthält `speccurve_*.png` für mindestens 5
  Studien, die nicht im finalen 16er-Korpus sind (`aquatic_PMC12111718`,
  `lengthpartial_PMC11829627`, `lymfit_PMC11171874`, `odinet_PMC8830646`,
  `pregnancy12w_PMC4573757`). Vor Erstellung von „Figure S1 bis S16" (Tabellen/Figuren-
  Liste, Zeile 348) sicherstellen, dass nur die 16 eingeschlossenen Studien verwendet
  werden.
- **`decompose.log` ist veraltet gegenüber `variance_summary.csv`.** `R/decompose.R` wurde
  nach der Erzeugung von `output/decompose.log` editiert (Datei-Zeitstempel:
  `decompose.log` 15:44:23, `R/decompose.R` und `variance_summary.csv` 15:45:43). Das Log
  zeigt für principled/`d` nur 7 statt der jetzt korrekten 15 Studien – ein Hinweis darauf,
  dass mindestens eine der abweichenden Zahlen in `STAND.md`/`OUTLINE.md` (Befund 34 im
  Zahlenabgleich, „2 bis 3 %") möglicherweise aus dem alten Log statt aus der aktuellen CSV
  übernommen wurde. Vor der nächsten Zahlenübernahme `output/decompose.log` neu erzeugen
  oder ganz aus dem Workflow entfernen, um diese Fehlerquelle zu vermeiden.

---

## Teil 3: Was methodisch trägt (Positives)

- Die principled/defensible-Trennung nach Del Giudice & Gangestad (2021) ist konsequent im
  Code umgesetzt (`R/grid.R`), nicht nur in der Prosa.
- Der Duplikat-Check (`is_dup`, `R/engine.R` Zeile 250–253) und die Ausschlussregel für
  nicht-anwendbare Knotenoptionen (`applicable_options()`, `R/grid.R` Zeile 70–132) sind
  genau die Korrektur, die der in `METHODENPRUEFUNG.md` dokumentierte erste Lauf brauchte,
  und sind nachvollziehbar in `output/duplicates.csv` und `output/nodes_not_applicable.csv`
  protokolliert.
- Multiple Imputation ist tatsächlich implementiert (nicht nur als Attribut, siehe
  `METHODENPRUEFUNG.md` Punkt 1), mit korrekter Barnard-Rubin-Freiheitsgradformel und
  spezifikationsfestem Seed – beides mit `Rscript` nachvollzogen und korrekt.
- Die Trennung von Zielgrösse `d` (Punktschätzer-Bewegung) und `ci_width_d`
  (Intervallbreite) in der Varianzzerlegung löst die in `METHODENPRUEFUNG.md` Punkt 3
  beschriebene Inferenz-Tautologie sauber und ist selten so explizit in
  Multiverse-Papers zu finden.
- Der Integritätsscreen trennt explizit „Flag" von „Anschuldigung" (`R/integrity_screen.R`
  Zeile 17) und schliesst kategoriale Variablen korrekt aus der Carlisle-Prüfung aus.
- Die überwiegende Mehrheit der in Table 2 berichteten Reporting-Zahlen (Abschnitt 3.2)
  stimmt exakt mit `config/published.csv` überein, was für eine sorgfältige Extraktion
  spricht.

---

## Einschätzung

Kein Punkt oben stellt die Gesamtarchitektur infrage. Vor einer Einreichung sollten aus
Sicht dieses Gutachtens aber mindestens die vier „schwerwiegend" markierten Punkte
behoben werden, weil sie entweder eine Kernzahl in Table 3 direkt falsifizieren (Befund 1),
den Hauptnenner aller berichteten Effektgrössen betreffen (Befund 2), eine der vier
Hauptaussagen (Reproduktion) systematisch nach unten verzerren können (Befund 3), oder
grundsätzlich fehlende Unsicherheitsangaben bei sehr kleinem n betreffen (Befund 4). Die
„mittel" und „klein" markierten Punkte sind vor Einreichung wünschenswert, aber keiner
davon ändert allein eine der vier Hauptaussagen.
