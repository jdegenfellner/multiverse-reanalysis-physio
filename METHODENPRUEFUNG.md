# Methodenprüfung, Stand 2026-09-11, Behebungsstand 2026-09-12

## Behebungsstand

| Punkt | Status | Was gemacht wurde |
|---|---|---|
| 1 Phantom-Spezifikationen | **behoben** | `df_method`, `population` und `covars = baseline_only` aus dem Gitter entfernt. MI mit `mice` (m = 10, PMM, Rubin-Pooling mit Barnard-Rubin-Freiheitsgraden) implementiert. Ausreisserregeln nur als Option, wenn sie in der Studie einen Wert verändern. LOCF nur, wenn eine Baseline für einen fehlenden Endwert vorliegt. HC3 und Permutation nur bei `lm`. Duplikat-Check als Pflichtschritt in `run_all.R`, Ausgabe in `output/duplicates.csv`. Verbleibende Duplikate sind echte Äquivalenzen (singuläre Mixed Models = lm) und werden über `is_dup` ausgeschlossen. |
| 2 Nenner | **behoben** | d = est / SD des Rohoutcomes über beide Arme vor jeder Vorverarbeitung, je Studie konstant. Log-Spezifikationen mit SD des Log-Outcomes. Alte Definition als `d_resid` zum Vergleich behalten. Effekt: tSCS-Spannweite 1,94 auf 0,40, Phosphatidsäure 1,00 auf 0,04, tDCS 1,45 auf 0,90. |
| 3 Inferenz-Tautologie | **behoben** | Zweite Zielgrösse `ci_width_d`, Zerlegung getrennt für Schätzer und Intervallbreite in `decompose.R`. |
| 4 Stufe 2 | **gerechnet** | Publizierte Analysen aus allen 21 Papers extrahiert (`coding/extracted/*.json`, mit wörtlichen Belegen), in `config/published.csv` zusammengeführt, Reproduktion klassifiziert in `output/reproduction.csv`. |
| 5 Auditor-Entscheidungen | **Regeln fixiert, Registry revidiert, Zweitkodierung offen** | Acht Regeln, siehe Abschnitt unten. Registry v2 in `config/registry.csv`, v1 archiviert. |
| 6 Korpusdefinition | **Entscheidung des Autors offen** | Die Extraktion kodiert `field` und `population` je Studie, damit ein Stratum Physiotherapie/Rehabilitation gegen Sport/Ernährung an Gesunden gebildet werden kann. |
| 7 Winsorizing Baseline | **behoben** | `apply_outlier` stutzt Outcome und Baseline. |
| 7 Grafiken | **behoben** | `plot_curves.R`: beide Gitter nebeneinander, 95%-Band je Spezifikation, publizierter Schätzer als Linie, Varianzzerlegung als Balken. |
| 7 ImPuls-Studie | **ausgeschlossen** | Mediationsanalyse des ImPuls-RCT ohne eigenen Gruppenschätzer. |
| 7 Integritätsscreen | **gerechnet** | `integrity_screen.R`: Carlisle auf benannten Baseline-Variablen (Stouffer, zweiseitig extrem), Duplikatzeilen, Endziffern nur berichtet (abgeleitete Mittelwerte machen den Test unbrauchbar). Kein Flag nach Korrektur. |
| 7 Summenmasse | **gerechnet** | `summary_measures.R`: Verteilung von d, Vorzeichenanteil, MCID-Anteil (Default 0,2 SD, solange keine MCID je Studie erfasst), s-Werte, Verhältnis der Spannweiten defensible/principled. Meta-Analyse über Spezifikationen (Bartos) und minP noch offen. |
| 7 Selbstselektion | **vorbereitet** | `journal_requires_data_sharing` wird in der Extraktion kodiert. |

## Dritte Korrekturrunde nach dem adversarialen Gutachten (2026-09-13)

`manuscript/review_adversarial.md` (starkes Modell, Auftrag: ablehnen) hat 15 Punkte
gefunden. Entscheidungen des Autors vom 2026-09-13: Kerngitter heisst
"estimand-preserving" (gleiches Estimand, Präzision darf differieren), der Anspruch auf
strenge Del-Giudice-Äquivalenz fällt; das strikte Gitter ohne Baseline-Behandlung wird
zusätzlich berichtet. Stufe 2 trägt die vorab festgelegte relative Regel, die absolute
Abweichung in SD wird ohne Schwelle daneben berichtet; die Oder-Regel ist gestrichen.

| Befund | Korrektur |
|---|---|
| Baseline in drei Langformat-Studien (eTRE, Cluster Sets, Physiofeedback) im Deposit vorhanden, von `harmonise()` verworfen | Spalte `baseline_time` in der Registry; `harmonise()` holt die Baseline über die ID aus der Baseline-Zeile |
| Ausreisserregeln: kein Paper nutzt eine; MAD auf gedeckelter Prozentskala erzeugt das Maximum 1,08 (tDCS) | `outlier`, `outlier_scope` auf Typ U; nicht in den gerechneten Gittern; eigener Sensitivitätsarm `outlier_arm` |
| "Baseline dominiert" tautologisch, wo nur Baseline und Inferenz variieren | Gitter `strict` (Typ E ohne Baseline, ANCOVA als Referenz) wird gerechnet und berichtet; Zahl der variierenden Knoten je Studie wird berichtet |
| Reproduktionsregel nachträglich gelockert | Vorabregel relativ als Hauptergebnis; `abs_diff_sd` und `abs_diff_se` ohne Schwelle; publizierte und nachgerechnete p und KI in Tabelle 3 |
| Gleichstände beim Matching verschwiegen (Lytras: drei Kandidaten, Spannweite 0,23 SD) | Spalten `n_tied`, `tie_range_d` in `reproduction.csv`, werden berichtet |
| Skalenfehler Physiofeedback (Log-Schätzer gegen Roh-d) | Nenner und Verortung auf der Skala der gematchten Spezifikation; Log-Schätzer nur gegen Log-Spezifikationen |
| Stufe 2 fittet Gitterzellen, nicht die publizierten Modelle | `R/stage2_published_models.R`: je Studie das publizierte Modell (LMM, MMRM, cLDA, brms). Nach dem zweiten Gutachten korrigiert: FREE Zeit als Faktor, SPADI GLM-Äquivalent mit listenweisem Ausschluss, eTRE drei Arme, TERECO ML, Lytras ohne unbegründeten Bonferroni-Faktor. Klassifikation in `R/stage2_classify.R` (relative Vorabregel plus Rundungspräzision). Ergebnis 11 full, 1 major |
| eTRE: publizierter Wert an Softwaregrenze angepasst | Override jetzt auf den publizierten Interaktionsterm (−2,13 in unserer Konvention), Change-Score-Kontrast |
| MI-Seed je Spezifikation zählt Monte-Carlo-Rauschen als Variation | ein Imputationssatz je Studie und Transformation, Cache in `run_study()` |
| `ci_width_d` mit 1,96 statt t-Quantil | t-Quantil mit Modell-df |
| Registrierungen trotz Regel 1 nicht abgerufen; "abstract" vermischt deklariert und erschlossen | `config/registrations.csv` wird abgerufen; Kodierung in vier Stufen; Primär- und Sekundärberichte getrennt |
| Integritätsscreen in 15 von 16 nicht berechenbar (< 2 benannte Variablen) | wird so berichtet; namensbasierte Breitsuche im Supplement |
| Abstract: "loss occurs after data are public" gegen 104 von 136 vor dem Öffnen; "11 public and readable" enthält 3 ohne lesbare IPD | Text wird korrigiert |
| "Forking paths" für Kodierfehler | Begriff wird gestrichen |

## Zweite Korrekturrunde nach den Gutachten zur Gliederung (2026-09-12, abends)

Drei Gutachten (`manuscript/review_logic.md`, `review_sources.md`, `review_statistics.md`)
haben zur Gliederung v1 geführt zu:

| Befund | Korrektur |
|---|---|
| Nenner war die Gesamt-SD über beide Arme, enthält den Effekt selbst | gepoolte Innerhalb-Gruppen-SD (Cohen/Hedges), `engine.R` |
| Matching zählte nicht abbildbare Modelle (random slopes) still als "nicht bewertbar" | fehlender Schlüssel in `map_*` zählt als Nicht-Match; `outlier_scope` bewertet; Gitter-Abbildbarkeit 7 von 12 statt 8 |
| Relative 2/10-Prozent-Regel instabil bei Schätzern nahe 0 | zusätzlich absolute Differenz in SD (0,02 / 0,05); beide berichtet; Ergebnis 10 full, 2 minor, 0 major (nur relativ: 6/3/3) |
| Keine Unsicherheit für Anteile und Mediane | `uncertainty.R`: Wilson, Studien-Bootstrap, Verteilung publiziert minus Median |
| m = 10 knapp bei 35 % Missing; 499 Permutationen deckeln s-Werte bei 9 Bit | m = 20; 4 999 Permutationen (12,3 Bit) |
| Interaktionen in der Zerlegung nicht geprüft | `decompose_interactions.R`: dominanter Knoten unverändert in 10 von 10 |
| Ausschlusskategorien nur in Prosa | Spalte `category` in `config/exclusions.csv` (design 17, data 11, no_estimate 2, duplicate 2) |
| Registry-Differenzen 8/4/11 nur in Prosa | `registry_diff.R`: Kontrollarm 10, Outcome 5, Kovariaten 11, Baseline 3, Datei 1; 13 von 16 Studien |
| Wirkung der v1-Fehler unklar | v1 durch die finale Engine: Median-Betrag und Spannweite gleich, Vorzeichen des Medians in 7 von 16 gedreht |
| Alte Kurven ausgeschlossener Studien in `figures/` | `plot_curves.R` löscht vor dem Rendern |
| "MCID" für Cohen 0,2 | Label `cohen_small_0.2` |

Zehn falsche Quellenzuschreibungen (Nepomuceno 82,2 % statt 89,5 %; E/N/U-Benennung;
Siebert/Naudet-Zahlen; Hardwicke-Schwellen u. a.) sind in `manuscript/OUTLINE.md` v2
korrigiert, Liste in `review_sources.md`.

## Auditor-Regeln (fixiert 2026-09-12, vor der Registry-Revision)

Diese Regeln wurden nach der Extraktion der publizierten Analysen aus allen 21 Papers,
aber vor der Revision der Registry festgelegt. Sie ersetzen die ad-hoc-Entscheidungen der
ersten Registry-Version (archiviert als `config/registry_v1_2026-08-28.csv`).

1. **Primäres Outcome.** In dieser Reihenfolge: (a) als primär deklariert in der
   Registrierung, (b) als primär deklariert im Paper, (c) erstgenanntes Outcome im
   Abstract-Ergebnisteil, (d) Outcome der Fallzahlplanung. Die Quelle wird je Studie
   als `primary_declared` protokolliert. Bei koprimären Outcomes das erstgenannte.
2. **Zeitpunkt.** Der im Paper als primär benannte, sonst der erste Follow-up nach
   Interventionsende. Fehlt der primäre Zeitpunkt im Deposit, wird die Studie
   ausgeschlossen, nicht auf einen anderen Zeitpunkt umgestellt.
3. **Outcome nicht im Deposit.** Ausschluss, kein Ersatz durch ein verwandtes Outcome.
4. **Kontrollarm.** Der Arm, den das Paper als Kontrolle, Placebo, Sham, Wartelisten-,
   Usual-Care- oder Nur-Basisbehandlungs-Arm bezeichnet. Die Kodierung im Deposit wird
   über Wertelabels, sonst über Abgleich der Gruppengrössen und Baseline-Mittel mit
   Tabelle 1 verifiziert. Bei mehr als zwei Armen: erstgenannter aktiver Arm gegen
   Kontrolle.
5. **Kovariaten.** Nur die, die im publizierten Primärmodell tatsächlich als
   Adjustierungsterme stehen. Variablen, die nur in Tabelle 1 auf Baseline-Balance
   geprüft wurden, zählen nicht.
6. **Berichtstyp.** Primärberichte (das Paper berichtet die vorab definierte
   Primäranalyse des Trials) und Sekundärberichte (das Paper ist eine Sekundär- oder
   Explorativanalyse mit eigenem Hauptergebnis) werden getrennt gekennzeichnet
   (`report_type`). Sekundärberichte ohne Gruppendifferenz-Schätzer (Netzwerk-,
   Mediationsanalysen) werden ausgeschlossen.
7. **Design.** Within-Person-Designs (kontralaterale Gliedmassen) und
   Machbarkeitsstudien mit Feasibility als primärem Ziel werden ausgeschlossen, in
   allen Fällen gleich.
8. **Feld und Population** werden je Studie kodiert (`field`, `population`), damit das
   Stratum "Physiotherapie/Rehabilitation an Patienten" gegen "Sport, Ernährung,
   Training an Gesunden" berichtet werden kann. Die Entscheidung, welches Stratum den
   Haupttext trägt, liegt beim Autor.

**Ergebnis der Revision.** Von 21 Studien der ersten Registry wurden 5 nachträglich
ausgeschlossen (Within-Person, Feasibility, Netzwerkanalyse, Outcome nicht
identifizierbar, Zeitpunkt nicht im Deposit) und die ImPuls-Studie als Mediationsanalyse
ohne Gruppenschätzer. In 8 der 16 verbleibenden Studien war der Kontrollarm in der ersten
Registry falsch kodiert, in 4 das Outcome falsch gewählt, in 11 die Kovariatenliste
falsch. Die erste Registry war unbrauchbar; dass sie einen ganzen Lauf lang unentdeckt
blieb, gehört als Befund über den eigenen Prozess in den Diskussionsteil.

Zusätzlich korrigiert: Die DOI 10.1136/bmj-2023-076316 ist der Estimands-Primer von Kahan et al. (BMJ 2024), nicht eine Studie zu Estimands in Protokollen. Zitat in PREREGISTRATION.md und NODES.md angepasst.

---

## Ursprüngliche Befunde vom 2026-09-11


Kritische Durchsicht von Gitter, Engine und Auswertung nach dem ersten Volllauf
(21 Studien, 18 238 Spezifikationen). Reihenfolge nach Schwere. Jeder Punkt nennt
den Befund, den Beleg aus den Daten und die Korrektur.

---

## 1. Das Gitter enthält massenhaft Phantom-Spezifikationen

**Befund.** Nur 874 von 1 704 principled-Spezifikationen (51 %) und 6 300 von 16 534
defensible-Spezifikationen (38 %) liefern ein verschiedenes Tripel (est, se, p). Der
Rest sind exakte Duplikate, weil Optionen im Code nicht oder nur scheinbar implementiert
sind:

| Knoten | Identische Gruppen | Grund |
|---|---:|---|
| `df_method` | 532 von 532 (100 %) | Wird in `run_spec()` nie gelesen. Satterthwaite und Kenward-Roger sind derselbe Fit. |
| `population` | 5 012 von 7 238 | `itt_observed` behält NA-Zeilen, `lm()` wirft sie ohnehin weg. Identisch mit `completers`, ausser bei LOCF. |
| `missing` | 2 002 von 4 116 | `mi` setzt nur ein Attribut, es wird nie imputiert oder gepoolt. Identisch mit `complete_case`. |
| `covars` | 1 911 von 6 419 | `baseline_only` erzeugt `character(0)`, ist also identisch mit `none`. Bei `endpoint` und `change` fehlt die Baseline dann ganz. |
| `outlier` | 1 580 von 4 724 | In vielen Studien greift keine der drei Regeln, dann sind alle vier Optionen derselbe Datensatz. Das ist echt, muss aber als "nicht anwendbar" gezählt werden, nicht als vier Spezifikationen. |
| `outlier_scope` | 2 638 von 7 086 | Folge des vorigen. |

**Warum das schwer wiegt.** Simonsohn et al. (2020) verlangen "non-redundant and valid
specifications". Duplikate verfälschen jede Zählung (Anteil Vorzeichen, Anteil über MCID),
gewichten die Varianzzerlegung falsch und blähen die berichtete Gittergrösse auf. Die
Zahl 18 238 darf so nicht ins Paper. Ein Gutachter, der die Duplikate findet, wird dem Rest
nicht mehr trauen.

**Korrektur.**
- `df_method` entweder implementieren (`lmerTest` mit `ddf = "Kenward-Roger"`, nur bei
  `mixed_ri`) oder aus dem Gitter streichen.
- `mi` implementieren (`mice` mit m = 20, Pooling nach Rubin, Imputationsmodell mit Arm,
  Baseline und Kovariaten) oder streichen. Halbimplementierte Optionen sind schlimmer als
  fehlende.
- `population`: `itt_observed` ist ohne Imputation kein eigener Estimand. Sinnvoll ist nur
  ITT mit MI gegen Completer mit Complete Case. Die Kombination als eine Achse führen.
- `covars = baseline_only` streichen. Die Baseline steckt im Knoten `baseline` (ANCOVA).
  Alternativ `baseline_only` als "Baseline als Kovariate, aber Outcome = Endwert"
  definieren, was ANCOVA ist, also redundant.
- Nach jedem Lauf einen Duplikat-Check erzwingen: gleiche (est, se, p) innerhalb einer
  Studie werden zu einer Spezifikation zusammengefasst, die Optionskombinationen werden
  als äquivalent protokolliert. Diese Zahl ist selbst berichtenswert.

---

## 2. Die Standardisierung d = est / sigma erzeugt künstliche Fragilität

**Befund.** `sigma` ist die Residual-SD des jeweils gefitteten Modells. Sie ist keine
Konstante der Studie, sondern hängt von der Spezifikation ab. ANCOVA und Change Score
haben eine viel kleinere Residual-SD als das Endwert-Modell, sobald Baseline und Endwert
korreliert sind. Damit ändert sich d auch dann, wenn sich der Schätzer auf der Rohskala
kaum bewegt.

Beispiel Phosphatidsäure (n = 18, principled):

| Baseline-Behandlung | est | sigma | d |
|---|---:|---:|---:|
| Endwert | -0,63 | 9,90 | -0,06 |
| Change Score | -1,04 | 0,98 | -1,06 |
| ANCOVA | -1,05 | 0,98 | -1,07 |

Der Rohschätzer bewegt sich um den Faktor 1,6, das d um den Faktor 17. Die Spannweite
in der Übersichtsgrafik ist zu grossen Teilen ein Nenner-Artefakt. Dasselbe bei tDCS
(sigma von 1,0 bis 5,8 je nach Ausreisserregel), Lengthened Partials (Faktor 3,9),
tSCS (Faktor 3,4). Bei `mixed_ri` kommt hinzu, dass `sigma()` von `lmer` nur die
Within-Cluster-SD ist, also systematisch kleiner als bei `lm`.

**Warum das schwer wiegt.** Die Varianzzerlegung (welcher Knoten treibt die Streuung)
und die Übersichtsgrafik beruhen auf d. Beides misst derzeit zu einem unbekannten Teil
Nenner-Variation statt Schätzer-Variation. Der Befund "Baseline-Behandlung dominiert"
ist damit nicht belastbar.

**Korrektur.** Ein fester Nenner je Studie, der nicht von der Spezifikation abhängt:
die gepoolte SD des Rohoutcomes zum primären Zeitpunkt (oder der Baseline) über beide
Arme, einmal berechnet, vor jeder Vorverarbeitung. Für Log-Spezifikationen die
entsprechende SD auf der Log-Skala, und diese Spezifikationen als eigener Arm, wie im
Protokoll vorgesehen. Zusätzlich die Rohskala berichten, wo alle Spezifikationen dieselbe
Skala haben. Nach der Umstellung Varianzzerlegung und alle Grafiken neu rechnen.

---

## 3. Inferenzknoten auf d gemessen ist eine Tautologie

**Befund.** Modellbasierter SE, HC3 und Permutation verändern per Konstruktion nur
SE und p, nie den Punktschätzer. Die Varianzzerlegung von d ergibt für `inference`
in jeder Studie exakt null. Das Paper würde berichten "Inferenz spielt nie eine Rolle",
was nichts über die Daten aussagt.

**Korrektur.** Für Inferenzknoten eine eigene Zielgrösse: Breite des Konfidenzintervalls,
s-Wert oder p. Die Zerlegung zweimal berichten, einmal für den Punktschätzer (Knoten,
die ihn verändern), einmal für die Intervallbreite (alle Knoten).

---

## 4. Stufe 2 fehlt fast vollständig

**Befund.** `published_est` ist in der Registry bei einer von 21 Studien gefüllt. Ohne
den publizierten Schätzer gibt es keine Reproduktion, keine Klassifikation (voll, minor,
major, nicht reproduzierbar) und keine Verortung des publizierten Ergebnisses in der
Spezifikationskurve. Das Kodierraster (`coding/coding_sheet.csv`) ist bis auf eine
Spalte leer. Damit ist auch das defensible-Gitter nicht das, was NODES.md verspricht,
nämlich "was die Studien tatsächlich getan haben". Es ist derzeit ein aus der Literatur
gesetztes Gitter, kein aus dem Korpus abgeleitetes.

**Korrektur.** Für alle 21 Studien: publizierter Schätzer, SE oder CI, p, und die
publizierte Spezifikation als Zeile im Kodierraster. Dann je Studie die Spezifikation
identifizieren, die der publizierten am nächsten kommt, und Reproduktion mit der
10-Prozent-Toleranz klassifizieren. Erst danach ist der Vergleich publiziert gegen
Multiverse möglich.

---

## 5. Eigene Analystenentscheidungen sind nicht geregelt

**Befund.** In der Registry stehen Entscheidungen, die wir getroffen haben und die
den Effekt bestimmen: "kein primäres Outcome deklariert; NPRS lumbal als
erstgenanntes" (Lytras), "3 Arme; Kontrast 1 gegen 2" (Mulligan), "Ganzkörper-Magermasse
nicht im Deposit; Beine als grösstes Segment" (Creatine). Das sind Freiheitsgrade des
Auditors. Sie sind protokolliert, aber nicht regelbasiert und nicht unabhängig
doppelt kodiert.

**Korrektur.** Vorab fixierte Regeln: (a) primäres Outcome laut Registrierung, sonst
laut Abstract, sonst erstgenannt im Methodenteil; (b) bei mehr als zwei Armen der im
Abstract erstgenannte Kontrast; (c) fehlt das publizierte primäre Outcome im Deposit,
wird die Studie als "Outcome nicht im Deposit" ausgeschlossen, nicht ersetzt. Creatine
fällt damit voraussichtlich heraus. Zweitkodierung der Registry durch eine zweite Person.

---

## 6. Korpusdefinition: "Physiotherapie" ist gedehnt

**Befund.** Unter den 21 Studien sind Creatine-Supplementierung, Phosphatidsäure,
zeitbeschränktes Essen, Cluster-Sets, Lengthened Partials und Pre-Exercise-Meals. Das
ist Sporternährung und Trainingsphysiologie an Gesunden, keine Physiotherapie an
Patienten. Ein Gutachter aus dem Feld wird das sofort sehen. Die Suche hat
"exercise" als Physio-Term gezählt.

**Korrektur.** Entweder den Titel ehrlich machen ("exercise, rehabilitation and
physiotherapy trials") oder ein Einschlusskriterium "Intervention durch
Physiotherapeuten oder in einem Rehabilitationskontext an einer klinischen Population"
nachziehen und die Sportstudien als Sensitivitätsstratum berichten. Die zweite Variante
ist sauberer, kostet aber etwa ein Drittel des Korpus.

---

## 7. Kleinere Punkte

- **Ausreisser als Typ E.** Winsorizing verändert die Zielgrösse (Mittel der
  gestutzten Verteilung). Del Giudice & Gangestad würden das eher als U einstufen. Da
  im Korpus vermutlich keine einzige Studie winsorisiert hat (Kodierraster leer, also
  unbelegt), ist die Option im defensible-Gitter nicht "used in the literature". Prüfen,
  sonst nach U verschieben.
- **Winsorizing vor Change Score.** `apply_outlier` stutzt nur `.y`, nicht `.base`.
  Der Change Score mischt dann gestutzten Endwert mit rohem Baselinewert. Entweder beide
  stutzen oder den Change Score stutzen.
- **Übersichtsgrafik.** Zeigt nur das defensible-Gitter. Für das Hauptargument braucht es
  beide Gitter nebeneinander, und die Spannweiten müssen nach Punkt 2 neu gerechnet werden.
- **Spezifikationskurven ohne Intervalle.** Ohne CI-Band je Spezifikation ist nicht
  sichtbar, ob die Bewegung der Punktschätzer gegen deren Unsicherheit ins Gewicht fällt.
- **Eine Studie unerledigt.** PMC12885332 (ImPuls, repetitives negatives Denken) ist
  weder in der Registry noch in den Ausschlüssen. Sie hat Daten und 12 Code-Dateien und
  wäre eine der wenigen Studien, bei denen fremder Code ausgeführt werden kann.
- **Integritätsscreen** (Carlisle, GRIM) ist nicht gerechnet, im Protokoll aber als
  Voraussetzung für Stufe 3 festgelegt.
- **Summenmasse aus dem Protokoll fehlen.** Vorzeichenanteil, MCID-Anteil, s-Werte,
  Meta-Analyse über Spezifikationen, minP: nichts davon ist berechnet.
- **Selbstselektion des Korpus.** Der Vergleich freiwillige gegen mandatierte Teiler
  (Abschnitt 5.4 des Protokolls) braucht eine Spalte "Journal mit Datenpflicht ja/nein".
  Fehlt.

---

## Was trotzdem trägt

Die Architektur ist richtig: Gitter als Daten, Engine kennt keine Studie, Registry als
einzige Schnittstelle, Ausschlüsse mit Begründung, Varianzzerlegung je Studie statt
gepoolt, Typ-II-Quadratsummen, Standardisierung wegen Skalenwechsel, Prüfung der
Pipeline-Ähnlichkeit nach Short et al. Die Trennung principled gegen defensible ist der
richtige Beitrag. Die Probleme oben sind Implementierungsfehler und fehlende Schritte,
keine Konstruktionsfehler. Sie sind in wenigen Tagen behebbar, aber vor der Behebung
sollte keine Zahl aus `output/` in einen Text.

## Reihenfolge der Behebung

1. Gitter bereinigen (Punkt 1), Duplikat-Check als Pflichtschritt in `run_all.R`.
2. Fester Nenner (Punkt 2), dann Neulauf und neue Zerlegung, getrennt für Schätzer
   und Intervallbreite (Punkt 3).
3. Regeln für Auditor-Entscheidungen fixieren, Registry zweitkodieren (Punkt 5),
   Korpusdefinition entscheiden (Punkt 6).
4. Publizierte Schätzer erfassen, Reproduktion klassifizieren (Punkt 4).
5. Integritätsscreen und Summenmasse.
