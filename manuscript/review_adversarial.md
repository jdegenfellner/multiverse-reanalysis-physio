# Adversarial Review, `manuscript/paper.md` (Entwurf vom 2026-09-12)

Perspektive: Gutachter für BMC Medical Research Methodology, Biostatistik klinischer Studien und Metaforschung. Ziel des Durchgangs war die Ablehnung. Berichtet wird nur, was gegen Datei oder Code standhält. Zeilenangaben beziehen sich auf `manuscript/paper.md`, wenn nichts anderes steht. Alle Zahlen wurden mit R direkt aus `output/` und `config/` nachgerechnet.

Empfehlung: Reject in der vorliegenden Form, Resubmission nach grundlegender Überarbeitung von Abschnitt 2.6, 3.3, 4.4 und der Reproduktionsklassifikation möglich. Die Architektur ist tragfähig, die Hauptbefunde sind es in ihrer jetzigen Formulierung nicht.

---

## 1. Die Kernbehauptung zur Fragilität ist ein Gitterartefakt, kein Befund (schwerwiegend)

**Behauptung.** Abstract Z. 38 bis 39, Conclusion Z. 681 bis 684, Discussion Z. 570 bis 580: "Fragility over equivalent choices is small and almost entirely the choice of baseline handling."

**Beleg.** `output/variance_by_study.csv` (principled, Zielgrösse d): In 7 von 15 Studien mit variierendem Knoten (Mulligan, Lytras, SPADI, tSCS, Phosphatidsäure, Gaining More, Creatine) gibt es genau zwei Knoten, Baseline-Behandlung und Inferenz. Inferenz bewegt den Schätzer per Konstruktion nicht (Anteil 1e-30). Der Baseline-Anteil von 100 % ist in diesen 7 Studien tautologisch. In den übrigen 3 der "10 von 15", in denen Baseline dominiert (TERECO 79 %, ETIP 98 %, Facial 99 %), konkurriert nur noch die Ausreisserregel. Es bleiben 5 Studien (TERECO, FREE, ETIP, tDCS, Facial), in denen zwei Knoten den Schätzer überhaupt bewegen können.

`output/nodes_not_applicable.csv`: Kovariaten waren im principled-Gitter in 13 von 16 Studien nicht anwendbar, das Modell in 14 von 16, die Ausreisserregel in 11 von 16 (ganz oder teilweise). Das principled-Gitter reduziert sich in den meisten Studien auf die drei Baseline-Optionen.

**Konzentration.** Von 395 principled-Spezifikationen stammen 140 (35 %) aus FREE und 72 (18 %) aus TERECO, zusammen 54 % aus zwei Studien. Neun Studien tragen 9 oder weniger Spezifikationen bei, eTRE 3, Cluster Sets 6. Die Zahl 395 (Abstract Z. 27) suggeriert eine Breite, die nicht existiert.

**Die Sensitivitätsanalyse ist ein Rechenartefakt.** Z. 448 bis 450 und Abstract Z. 30 bis 31: "with it fixed, the median range was 0.003". `output/sensitivity_baseline_fixed.csv`: `range_fixed` ist in 8 von 16 Studien exakt 0, weil kein weiterer Knoten variiert. Sortiert: 0, 0, 0, 0, 0, 0, 0, 0, 0,006, 0,016, 0,035, 0,037, 0,054, 0,079, 0,109, 1,034. Der Median 0,003 ist (0 + 0,006)/2 und misst nichts als die Zahl der strukturellen Nullen. Werden zusätzlich die Ausreisserregeln fixiert, ist die Spannweite in 12 von 16 Studien null (eigene Rechnung aus `output/multiverse_all.csv`).

**Was das Gitter tatsächlich misst.** In 10 von 15 Studien ist die "Fragilität über äquivalente Entscheidungen" die Spannweite zwischen Endwert-, Change-Score- und ANCOVA-Schätzer. Diese Spannweite ist eine deterministische Funktion von Baseline-Ungleichgewicht und Baseline-Endwert-Korrelation, keine Eigenschaft analytischer Freiheit. Das Paper deutet das selbst an (Spearman 0,41 mit dem Ungleichgewicht, Z. 455 bis 456), zieht aber nicht die Konsequenz.

**Wie es ehrlich formuliert sein müsste.** "In diesem Korpus war in den meisten Studien kein äquivalenter Knoten ausser der Baseline-Behandlung anwendbar. Über die anwendbaren äquivalenten Entscheidungen jenseits der Baseline-Behandlung bewegte sich der Schätzer in 12 von 16 Studien nicht. Die berichtete Spannweite von 0,15 SD ist die Differenz zwischen Endwert-, Change-Score- und ANCOVA-Schätzer, die vom beobachteten Baseline-Ungleichgewicht abhängt." Die Formulierung "fragility is small and almost entirely baseline handling" ist zu streichen, ebenso die 0,003 im Abstract.

**Korrektur.** Je Studie die Zahl der anwendbaren und tatsächlich variierenden E-Knoten in Tabelle 2 oder 3 berichten. Die Zerlegung nur für Studien mit mindestens zwei variierenden Knoten berichten. Die Sensitivität "Baseline fixiert" als "in 8 Studien null per Konstruktion, in den übrigen 0,006 bis 1,03" berichten, ohne Median.

---

## 2. Die Baseline-Behandlung ist nach der eigenen Definition des Papers ein Typ-N-Knoten (schwerwiegend)

**Behauptung.** Z. 262 bis 266 definiert Typ N als "one option has justified precedence or the options examine different effects". Z. 291 bis 299 räumt ein, dass die drei Baseline-Optionen "not with the same precision" schätzen und dass Del Giudice und Gangestad das als Nichtäquivalenz werten. Begründung für den Verbleib im principled-Gitter: "all three analyses are used as primary analyses in this literature and none changes the question".

**Warum das nicht trägt.** Erstens ist "used in the literature and justifiable on its own" wörtlich die Definition des defensible-Gitters (Z. 266 bis 269). Das Paper begründet die Zuordnung zum principled-Gitter mit dem Kriterium des defensible-Gitters. Zweitens zitiert das Paper selbst Vickers 2001 und Senn 2006 (Z. 292 bis 294), die ANCOVA als überlegen ausweisen. Das ist "justified precedence", also Typ N. Drittens steht in Tabelle 1 (`tables.md` Z. 7) "Type E", während Methods 2.6 sagt, dass ein Kriterium verletzt ist. Ein Gutachter liest das als Sonderregel für den einen Knoten, der das Ergebnis liefert.

**Folge.** Wird Baseline nach den Regeln des Papers als N geführt, ist das principled-Gitter in 12 von 16 Studien leer oder hat Spannweite null (Punkt 1). Der Hauptbefund "0,15 SD über äquivalente Entscheidungen" wird zu "0 SD über äquivalente Entscheidungen, 0,15 SD über eine Entscheidung mit begründeter Präferenz". Das ist ein anderes Paper, und ein ehrlicheres.

**Die Unterscheidung principled/defensible als Beitrag** (Z. 101 bis 102, Z. 667 bis 670: "their ratio is the finding") wird dadurch untergraben, dass der Faktor 1,35 vom Nenner abhängt, und der Nenner von einer Klassifikation, die das Paper selbst als regelwidrig bezeichnet.

**Korrektur.** Baseline als N (oder als U mit eigener Achse) klassifizieren. Das principled-Gitter mit ANCOVA als Referenz führen. Den Befund umkehren: "Nach Ausschluss der Entscheidungen mit begründeter Präferenz war in diesem Korpus fast nichts mehr zu variieren; das ist eine Aussage über die Anwendbarkeit von Multiverse-Analysen auf einfache Zweiarm-Studien." Alternativ die Bezeichnung "principled" durch "estimand-preserving" ersetzen und den Anspruch auf Del Giudice und Gangestad fallen lassen.

---

## 3. In drei Studien wurde die Baseline fälschlich als "nicht im Deposit" behandelt (schwerwiegend, Implementierungsfehler)

**Behauptung.** Tabelle 1: Baseline-Behandlung anwendbar "baseline measurement in deposit". Z. 475 bis 476: "in the time-restricted eating trial the principled range is zero because no Type E node is applicable".

**Beleg.** `config/registry.csv`: eTRE, Cluster Sets und Physiofeedback haben leeres `baseline_var` und `time_var` gesetzt (Langformat). `harmonise()` in `R/engine.R` Z. 51 bis 53 filtert auf `primary_time` und verwirft alle anderen Zeitpunkte. Nachgeprüft in den Deposits: `Body data.csv` (eTRE) enthält `Time` mit den Werten pre und post; `data.xlsx` (Cluster Sets) enthält `Time` pre und post; `deidentified data.xlsx` (Physiofeedback) enthält `Time` 1 bis 4. Die Baseline liegt in allen drei Deposits vor. Die Pipeline kann Langformat nicht in Breitformat überführen, und dieser technische Mangel wird in Z. 475 als Eigenschaft der Studie berichtet.

**Folgen.**
- eTRE: principled-Spannweite 0 statt der Spannweite über drei Baseline-Optionen, `output/summary_grids_compared.csv` Verhältnis `Inf`, Ausschluss aus dem Median-Verhältnis (Z. 474 bis 477).
- Cluster Sets: nur Kovariaten variieren (Sex), `variance_by_study.csv` Kovariaten 100 %.
- Physiofeedback: Baseline nicht anwendbar, obwohl das publizierte MMRM alle vier Zeitpunkte nutzt.
- Stufe 2, eTRE: Z. 215 bis 218 begründet den Wechsel vom publizierten Interaktionsterm (2,13) auf den Post-Kontrast (−2,92) damit, dass der Post-Kontrast "corresponds to the estimand of our grid". Das Gitter hat für eTRE aber nur deshalb keinen Baseline-Knoten, weil die Pipeline die Baseline nicht liest. Die publizierte Zahl wurde an die Grenze der Software angepasst.
- Die Aussage "one of them without any equivalent choice that can move the estimate" (Z. 644) ist falsch.

**Korrektur.** `harmonise()` um eine Pivot-Funktion erweitern (`baseline_time` in der Registry), die drei Studien neu rechnen, alle Kennzahlen aktualisieren.

---

## 4. Das Maximum von 1,08 SD ist ein Artefakt der MAD-Winsorisierung auf einem deckeneffektbehafteten Outcome (schwerwiegend)

**Behauptung.** Abstract Z. 29, Z. 431 bis 433, Z. 572 bis 574: "For one trial of 20 participants in which an outlier rule changes the data, the same choices move it by 1.08. The maximum describes what a single small trial can do."

**Beleg.** tDCS, Outcome CAR (Central Activation Ratio, Prozent, Obergrenze 100). Rohdaten (nachgerechnet aus `tDCS.sav` über `harmonise()`): 10 von 20 Endwerten liegen zwischen 98,9 und 100,0, davon 9 im aktiven Arm. Median etwa 99,1, MAD entsprechend klein. Die Regel "3 MAD" stutzt 6 Endwerte und 2 Baselinewerte, die Regel "1,5 IQR" 2 und 2, die Regel "3 SD" keinen. `output/multiverse_all.csv`, tDCS principled, Inferenz model:

| Ausreisserregel | Endwert d | Change d | ANCOVA d |
|---|---:|---:|---:|
| keine | 1,405 | 1,462 | 1,424 |
| 1,5 IQR | 1,222 | 1,277 | 1,243 |
| 3 MAD | 0,384 | 0,439 | 0,389 |

Die MAD-Regel schneidet den gesamten Kontrollarm (Werte 80 bis 97) auf die Nähe des Medians und vernichtet den Effekt. Die Spannweite 1,08 ist die Differenz zwischen "keine Regel" und "MAD-Regel". Über die drei Baseline-Optionen beträgt die Spannweite ohne Ausreisserregel 0,057.

**Warum das schwer wiegt.**
- Z. 492: "No paper reports a rule for outliers." Die Option ist im Korpus nicht "used in the literature" (Kriterium für defensible, Z. 267 bis 269) und erst recht nicht Typ E.
- Winsorisieren verändert die Zielgrösse (Mittel der gestutzten Verteilung), Del Giudice und Gangestad würden das als U oder N führen. `METHODENPRUEFUNG.md` Z. 240 bis 244 hat das bereits angemerkt; es wurde nicht umgesetzt.
- Eine MAD-Regel auf ein Prozentmass mit Deckeneffekt anzuwenden, ist keine "conventional rule", sondern ein Fehler, den kein Analyst dieser Studie machen würde.
- Das Abstract trägt die Zahl 1,08 als Befund über Fragilität. Sie ist ein Befund über das Gitter.

**Korrektur.** Ausreisserregeln in Typ N oder U verschieben oder streichen. Falls beibehalten: nur Regeln, die für den Skalentyp definiert sind, und Ausreisserregeln bei beschränkten Skalen ausschliessen. tDCS-Maximum als Artefakt benennen oder entfernen. Das principled-Maximum wird dann 0,41 (tSCS), das ebenfalls die reine Baseline-Spannweite bei 0,41 SD Baseline-Ungleichgewicht und n = 20 ist.

---

## 5. Die Reproduktionsregel wurde nach Kenntnis der Ergebnisse gelockert und liefert "full" für 22 % und 27 % Abweichung (schwerwiegend)

**Behauptung.** Abstract Z. 26, Z. 398 bis 400: "Ten of 12 published point estimates were recovered to 2% or 0.02 standard deviations."

**Chronologie.** `PREREGISTRATION.md` Z. 92 bis 98: relative Regel, 10 % als Grenze für major. `R/reproduce.R` Kopfkommentar Z. 6 bis 8: "full: |Abweichung| <= 2 % UND gleiches Vorzeichen". `METHODENPRUEFUNG.md` Z. 29: die absolute Regel wurde am 12.09.2026 nach einem Gutachten ergänzt, "Ergebnis 10 full, 2 minor, 0 major (nur relativ: 6/3/3)". Methods 2.4 (Z. 229 bis 239) stellt die Oder-Verknüpfung als Designentscheidung dar und nennt die relative Regel "sensitivity analysis". Die Reihenfolge ist umgekehrt: die relative Regel war die Vorabregel, die Oder-Regel ist die Nachbesserung.

**Was die Oder-Regel rettet** (`output/reproduction.csv`, Spalten `rel_diff`, `abs_diff_sd`):

| Studie | rel. Abw. | abs. Abw. (SD) | publ. p | unser p |
|---|---:|---:|---:|---:|
| Gaining More | 21,8 % | 0,0168 | 0,273 | 0,658 |
| Physiofeedback | 27,4 % | 0,0161 | 0,678 | 0,785 |
| Water exercise | 6,1 % | 0,0196 | 0,010 | 0,021 |
| TERECO | 2,3 % | 0,0195 | n. b. | 4e-10 |

Zwei der vier Rettungen liegen bei 0,0195 und 0,0196 SD, also 0,0004 unter der Schwelle. Die Schwelle 0,02 SD ist nirgends begründet. Gaining More: publizierter Schätzer −0,63 (KI −2,8 bis 1,5), rekonstruiert −0,49, p 0,27 gegen 0,66. Das als "full reproduction" zu bezeichnen, wird kein Gutachter akzeptieren, der Hardwicke 2021 kennt.

**Wie ein Gutachter das liest.** Als Regel, die eingeführt wurde, um aus 6 zehn zu machen, und als Abstract, das "2% or 0.02 SD" nennt, ohne zu sagen, dass 4 der 10 nur über das zweite Kriterium passieren.

**Zusätzlich.** Z. 210 bis 211: extrahiert wurden "the published primary estimate, its interval and p-value". Der Vergleich von Intervall oder p wird nirgends berichtet. eTRE: Schätzer exakt reproduziert (0,04 %), p 0,004 gegen 0,026, weil das publizierte LMM alle Zeitpunkte nutzt und die Grid-Spezifikation ein Endwert-lm mit n = 16 ist. Eine Reproduktion des Schätzers ohne Reproduktion seiner Unsicherheit ist keine Reproduktion der publizierten Analyse.

**Korrektur.** Vorabregel als Hauptergebnis (6 full, 3 minor, 3 major). Kontinuierliche Abweichungen (bereits in Tabelle 3) als eigentliches Ergebnis. Absolute Schwelle, falls beibehalten, an der publizierten SE verankern (z. B. 0,1 SE), nicht an einer freien Zahl. p- und KI-Vergleich in Tabelle 3 ergänzen. Im Abstract: "6 of 12 under the preregistered relative rule".

---

## 6. Stufe 2 reproduziert nicht die publizierte Analyse, sondern die nächstgelegene Gitterzelle; Gleichstände werden verschwiegen (schwerwiegend)

**Behauptung.** Z. 221 bis 227: Matching auf die Spezifikation mit den meisten übereinstimmenden Knoten, Tie-Break "closest to the published one", "we report whether a tie occurred".

**Beleg.** Nachrechnung der Scoring-Logik aus `R/reproduce.R` Z. 63 bis 72 auf `output/multiverse_all.csv`:
- Lytras: `B_baseline_handling = other` → `map_baseline` liefert NA → Knoten nicht bewertet. Alle drei Baseline-Optionen erreichen 7 von 7 Punkten. Die drei Kandidaten haben d = −0,785, −0,88, −1,01 (Spannweite 0,229 SD, die gesamte principled-Spannweite dieser Studie). Der Tie-Break wählt den Endwert-Schätzer, der mit −1,2 exakt dem publizierten entspricht. Ergebnis "full, 0,0 %". Das ist Auswahl nach Zielwert.
- FREE: 2 Kandidaten mit 7 von 8, d-Differenz 0,015.
- Ein Gleichstand wird weder in `reproduction.csv` (keine Spalte) noch in Results 3.2 noch in Tabelle 3 berichtet. Z. 226 verspricht etwas, das nicht eingelöst wird.

**Nicht abbildbare Modelle.** Z. 410 bis 414: 5 von 12 publizierte Spezifikationen nicht im Gitter (Random Slopes, Bayes-Mehrebenenmodell, 14-Zeitpunkte-AR(1), cLDA, Drei-Arm-LMM). Vier dieser fünf werden als "full" gezählt (eTRE, Gaining More, Physiofeedback, TERECO). Random Slopes sind mit `lme4` eine Zeile, AR(1) mit `nlme`, ein Bayes-Mehrebenenmodell mit `brms`. Das Paper hat sich entschieden, Stufe 2 mit der Maschinerie von Stufe 3 zu erledigen. Damit ist "computational reproduction" (Z. 72 bis 74: "recovery of the published number from the published data and methods") nicht das, was gemacht wurde. Gemacht wurde: "die nächstgelegene von uns definierte Analyse liefert eine ähnliche Zahl".

**Zirkel.** Einschlusskriterium 4 (Z. 174 bis 175): "the published methods described the primary analysis in enough detail to reconstruct it". Damit können Studien in Stufe 2 nicht an mangelnder Beschreibung scheitern. Dann wird nicht die beschriebene Analyse gerechnet, sondern die nächste Gitterzelle, und die Toleranz nachträglich erweitert. Die Aussage "Where recomputation is possible it works" (Abstract Z. 38, Z. 673) ist damit weitgehend per Konstruktion wahr.

**Korrektur.** Für die 12 Studien mit Schätzer die publizierte Analyse tatsächlich implementieren (eigene Skripte je Studie, ausserhalb des Gitters). Gleichstände in Tabelle 3 ausweisen. Lytras als "Baseline-Behandlung im Paper nicht bestimmbar, drei Kandidaten, Spannweite 0,23 SD" berichten, nicht als "full, 0,0 %".

---

## 7. Der Reporting-Befund "9 von 16 nennen kein primäres Outcome" ist durch Kodierung und Sekundärberichte aufgebläht (schwerwiegend)

**Behauptung.** Abstract Z. 32 bis 33, Z. 486 bis 488, Z. 608 bis 609, Conclusion Z. 685.

**Beleg 1, explizite Deklarationen als "abstract only" kodiert.** `config/published.csv` und `coding/extracted/*.json`:
- tSCS: Notes: "BBS und TUG sind laut Abstract UND Methods ('Primary outcomes') explizit als KO-PRIMAERE Outcomes deklariert." Tabelle 2: "abstract only".
- eTRE: Issues: "co-primary outcomes declared in the Abstract ('The primary outcomes included body weight, ...')". Tabelle 2: "abstract only".
Beide Papers nennen ihr primäres Outcome. Die Kategorie "abstract" in `primary_outcome_declared` vermischt "im Abstract deklariert" mit "aus dem Abstract erschlossen". Z. 487 bis 488 ("can only be inferred as the first outcome reported in the abstract") ist für diese beiden falsch.

**Beleg 2, Sekundärberichte.** Physiofeedback, ETIP und Water exercise sind Sekundär- oder Explorativanalysen (Z. 387 bis 388). Physiofeedback schreibt laut Extraktion: "The primary outcomes of the trial itself were fall risk, dynamic balance, and physical activity levels ... In this exploratory analysis ...". Water exercise: EPDS ist explizit "secondary hypothesis" des Trials. Diese Papers nennen sehr wohl, was primär ist, es ist nur nicht das, was hier reanalysiert wurde. Sie als "name no primary outcome" zu zählen, ist eine Fehlklassifikation.

**Bereinigt.** Höchstens 7 von 16, darunter 3 Sekundärberichte. Unter den 13 Primärberichten: Mulligan, Phosphatidsäure, Gaining More, Creatine, also 4 von 13. Aus "nine of 16" wird "four of 13 primary reports".

**Beleg 3, Registrierungen nicht konsultiert.** Regel 1 (Z. 191): "The primary outcome is the one named in the trial registration". `config/published.csv`, Creatine: "would require checking the ANZCTR entry itself, out of scope here". Pregnancy12w: "outside the scope of this paper-text-only extraction". Tabelle 2: "registration" nur bei Lytras, obwohl Mulligan (NCT06858124), tSCS (ChiCTR2300074090), tDCS (IRCT), ETIP (NCT01243554), Water exercise (ISRCTN14097513), Creatine (ACTRN) registriert sind. Die in Methods beschriebene Regel wurde nicht angewendet.

**Korrektur.** Registrierungen abrufen und Regel 1 anwenden. Kategorien trennen: deklariert in Registrierung / Methoden / Abstract; nicht deklariert. Primär- und Sekundärberichte getrennt berichten. Abstract und Conclusion anpassen.

---

## 8. Abstract und Conclusion widersprechen den Ergebnissen (mittel bis schwer)

**a) "the loss occurs after the data are public"** (Abstract Z. 37, sinngemäss Conclusion Z. 678 bis 680). Z. 369 bis 384: Von 152 auf 48 gehen 104 Studien verloren, davon 68 an unerreichbaren Deposits. Nach dem Öffnen der Daten gehen 11 verloren (plus 17 Design, 2 ohne Kontrast, 2 Duplikate). Der grössere Verlust liegt vor dem Öffnen. Discussion 4.2 sagt das korrekt ("Two losses"), das Abstract nicht.

**b) Die "11 of 48" sind nicht alle "public and readable"** (Z. 384, Z. 543 bis 547). `config/exclusions.csv`: PMC9645607 enthält nur eine README, PMC11467018 ist nicht einlesbar, PMC12694805 enthält nur eine Ergebnistabelle. Drei der elf hatten keine lesbaren Individualdaten. PMC13141020 ist laut eigener Begründung "Retrospektive Auswertung", also kein RCT, und gehört unter Design, nicht unter "allocation not identifiable". Der "neue" Verlust (Z. 542: "different in kind") betrifft 7 bis 8 Studien, nicht 11.

**c) "Fragility ... almost entirely baseline handling"** und **"with it fixed, the median range was 0.003"** im Abstract ohne den strukturellen Vorbehalt, der in Results Z. 440 bis 442 steht. Was in Results als "partly structural" qualifiziert wird, steht im Abstract als Befund.

**d) "applying one classified grid to 16 trials is what makes the pattern visible as a property of the literature and not of a dataset"** (Z. 596 bis 598). Selbstselektierter Korpus, 6 von 16 Studien mit n < 30 (`summary_by_study.csv`: 16, 18, 20, 20, 23, 29), 54 % der Spezifikationen aus 2 Studien, das Maximum ein Regelartefakt. Das ist eine Eigenschaft dieses Datensatzes. Abschnitt 4.7 sagt das (Z. 644 bis 646), Abschnitt 4.4 behauptet das Gegenteil.

**e) "reversed the effect direction in 7 of 16 trials"** (Abstract Z. 33 bis 34) und "garden of forking paths on the reproducer's side" (Z. 627). Z. 505 bis 508: In 10 von 16 war der Kontrollarm anders kodiert, meist weil "the first value of the group variable had been taken as the control arm". Ein vertauschter Kontrollarm dreht das Vorzeichen per Definition. Das sind Kodierfehler, keine Gabelungen zwischen vertretbaren Alternativen. Gelman und Loken beschreiben Letzteres. Die Passage misbraucht den Begriff, und das Abstract verkauft die eigene Fehlerquote als Befund über Reanalysen.

---

## 9. Skalenfehler in `reproduction.csv` für Physiofeedback (mittel, konkreter Bug)

`R/reproduce.R` Z. 75: `abs_d <- abs(best$est - p$published_est) / x$sd_denom[1]`. `x$sd_denom[1]` ist die erste defensible-Zeile, für Physiofeedback `transform = none`, SD 0,339. Die gematchte Spezifikation ist `transform = log`, SD 0,399. Z. 82 bis 94: `published_d = published_est / sd_denom[1]` und Perzentil sowie `inside_principled` vergleichen den publizierten Log-Schätzer (0,02, `published_scale = log`) mit principled-Schätzern auf der Rohskala. `R/summary_measures.R` Z. 44 setzt in genau diesem Fall NA. Die beiden Output-Dateien widersprechen sich.

Betroffen: Tabelle 3, Physiofeedback, Perzentil 0,15; Z. 416 bis 417 "inside the range of the principled multiverse in 9 of 12" (ohne Physiofeedback 8 von 11); `uncertainty_proportions.csv` Zeile "published inside principled range". Die Klassifikation "full" bleibt (0,0137 statt 0,0161 SD), das Perzentil und die Inside-Zählung nicht.

---

## 10. Der Integritätsscreen wurde in 15 von 16 Studien nicht gerechnet (mittel)

Z. 244 bis 249 und Z. 464 bis 465: "The integrity screen flagged no trial." Z. 256 bis 258: "low power". `R/integrity_screen.R` Z. 69: `stouffer` gibt NA zurück, wenn weniger als zwei p-Werte vorliegen. `output/integrity_screen.csv`, Spalte `n_baseline_named`: 2 bei Physiofeedback, 0 oder 1 bei allen anderen. `p_carlisle_named` ist in 15 von 16 Studien NA. Die Flag-Regel (Z. 100 bis 101) kann bei NA nicht auslösen. "Flagged no trial" ist wahr, weil der Test nicht stattgefunden hat. Die Breitsuche (`p_carlisle_all`, 2 bis 43 Variablen) wurde berechnet, aber laut Code Z. 91 bis 92 nicht für das Flag verwendet und im Paper nicht berichtet.

**Korrektur.** Berichten: "The Carlisle component could be computed in 1 of 16 trials; the name-based broad search over 2 to 43 baseline variables gave combined p-values between 0.15 and 0.95 and is reported in Supplement X."

---

## 11. FREE: Cluster-RCT, in 77 % der principled-Spezifikationen ohne Clusterung, und alle Mixed-Fits singulär (mittel)

`output/multiverse_all.csv`, FREE principled: 108 von 140 Spezifikationen `model = lm` (nach Streichung der inkohärenten Kombinationen 3 Inferenzoptionen für lm, 1 für mixed_ri). Die 32 `mixed_ri`-Fits haben `singular = 1` in 32 von 32. Die Random Intercepts für GP (57 Ebenen) und Praxis (8 Ebenen) kollabieren; der Modellknoten ist inert (Anteil an d 0,9 %).

Der Permutationstest (`R/engine.R` Z. 168 bis 176) permutiert individuelle Armlabels. In einer Cluster-randomisierten Studie ist das keine gültige Randomisierungsinferenz. HC3 korrigiert Heteroskedastizität, nicht Clusterung. In 108 von 140 Spezifikationen der einzigen Studie mit instabilem Vorzeichen ist die Inferenz designwidrig. Tabelle 1 führt "Model family" als Typ E ("Same estimand"). Für ein Cluster-Design hat das Cluster-Modell begründete Präferenz, also Typ N.

Z. 498 bis 499 "Two papers modelled clustering" und Z. 402 bis 404 erwähnen nichts davon. Für TERECO (stratifiziert nach Zentrum) ist die unstratifizierte Permutation ebenfalls nur approximativ.

---

## 12. MI-Zufallsrauschen wird als Spezifikationsvariation gezählt (mittel)

`R/engine.R` Z. 239: `seed = seed + i`, jede Spezifikation erhält eigene Imputationen. Z. 259 bis 261: Duplikate werden über exakte Gleichheit von (est, se, p) erkannt. MI-Spezifikationen, die sich nur im Inferenzknoten unterscheiden, sind damit nie Duplikate. Nachgerechnet: innerhalb von Gruppen, die sich nur in der Inferenz unterscheiden, schwankt d bei MI-Spezifikationen im Mittel um 0,035 SD (ETIP) und 0,038 SD (Facial). Das ist ein Viertel der berichteten Median-Spannweite. `variance_by_study.csv`, defensible, d: Inferenz-Anteil 0,97 % (ETIP), 0,58 % (FREE), 0,68 % (Water exercise). Z. 578 bis 579 behauptet "the inference method changes the interval and not the estimate". Im defensible-Gitter stimmt das wegen des Seeds nicht. 475 von 1 934 defensible-Spezifikationen sind MI-Spezifikationen. Der Faktor 1,35 und die Zählung 1 934 enthalten Monte-Carlo-Rauschen.

**Korrektur.** Ein Imputationssatz je Studie und Missing-Option, für alle Spezifikationen gemeinsam. Dann kollabieren die Inferenz-Varianten von MI-Spezifikationen im Schätzer.

---

## 13. Weitere Prüfungen zur statistischen Korrektheit (Punkt 5 des Auftrags)

Was stimmt:
- **Nenner.** `R/engine.R` Z. 66 bis 75: gepoolte Innerhalb-Gruppen-SD des Rohoutcomes am primären Zeitpunkt, über die eingeschlossenen Arme, vor jeder Vorverarbeitung, Complete Cases. Change-Score-Schätzer werden durch die Endwert-SD geteilt (Z. 249 bis 251), wie in Z. 314 bis 317 beschrieben. Log-Spezifikationen durch die Log-SD. Korrekt implementiert.
- **Typ II.** `R/decompose.R` Z. 21 bis 22: `car::Anova(type = 2)` auf additivem lm. Wie beschrieben. Anteile beziehen sich auf die erklärte Quadratsumme ohne Residuum (`share`); `share_incl_resid` liegt vor und sollte berichtet werden, weil das Residuum im additiven Modell die Interaktionen enthält (FREE defensible: Ausreisser 77 % ohne, 41 % mit Residuum).
- **Bootstrap.** `R/uncertainty.R` Z. 25: 5 000 Resamples über Studien, Perzentilintervall. Korrekt. Bei n = 16 sind die Intervallgrenzen zwangsläufig beobachtete Werte (0,079 = Water exercise, 0,229 = Lytras). Sollte gesagt werden.
- **Wilson.** Z. 7: Formel korrekt.
- **Stouffer.** Z. 69: korrekt, aber siehe Punkt 10.
- **MI.** `R/engine.R` Z. 184 bis 206: m = 20, PMM, Rubin-Pooling, Barnard-Rubin-Freiheitsgrade korrekt (ν_obs = (ν_com + 1)/(ν_com + 3) · ν_com · (1 − λ)). Imputationsmodell ohne Clustervariable. `METHODENPRUEFUNG.md` Z. 7 und `engine.R` Z. 10 nennen noch m = 10; nur der Konstante `MI_M` ist zu trauen.
- **Permutation.** 4 999 Permutationen, p = (1 + k)/(N + 1), Deckel 12,3 Bit. Korrekt, mit dem Vorbehalt aus Punkt 11.
- **Spearman.** Paper-Werte (−0,06, 0,41, −0,06, 0,02) stimmen mit `range_drivers.csv`. `STAND.md` Z. 79 bis 80 nennt andere Werte (−0,04, 0,37, −0,10, 0,01) und Z. 92 "9 von 15" statt 7. Interne Dokumente sind veraltet.

Was nicht stimmt oder fehlt:
- `ci_width_d` (`engine.R` Z. 255) verwendet 1,96 statt des t-Quantils bei df = 14 bis 18 (2,10 bis 2,14). Bei Permutationsspezifikationen ist `se` die SD der Permutationsverteilung, keine SE des Schätzers. Betrifft nur die Zerlegung der Intervallbreite, sollte aber offengelegt werden.
- Das Median der signierten Differenz publiziert minus Multiverse-Median (0,006, Z. 418 bis 420) verschleiert, dass der Median der absoluten Differenz 0,045 SD beträgt (`uncertainty_medians.csv`, Bootstrap 0,010 bis 0,071). Der signierte Median ist nahe null, weil die Abweichungen in beide Richtungen gehen. Den absoluten Wert berichten.

---

## 14. Was fehlt (Punkt 6 des Auftrags, soweit oben nicht behandelt)

- **Ko-primäre Outcomes.** Lytras (4 ko-primär), tSCS (BBS, TUG), tDCS (CAR, NPT), eTRE (3). Die Wahl des erstgenannten ist eine Auditor-Entscheidung mit Konsequenzen (tDCS: NPT nicht analysiert; tSCS: TUG nur unadjustiert publiziert). Nirgends diskutiert.
- **Drei-Arm-Studien** (Mulligan, SPADI, eTRE): Zwei-Arm-Kontraste aus Drei-Arm-Modellen, Nenner aus zwei Armen. Nicht berichtet.
- **tSCS Kontrollarm.** Extraktion: das Paper widerspricht sich, welche Gruppe Kontrolle ist ("Trial design" gegen "Sample size"). Registry wählt CPT+tSCS (n = 7). Nicht berichtet.
- **Zweitkodierung** (Z. 204 bis 206 "[check: pending]", Z. 651 bis 652). Abschnitt 4.6 nennt den blinden Zweitkodierer "the remedy". Ein Paper, das das Fehlen eines Zweitkodierers als Hauptursache von Fehlern identifiziert und ohne Zweitkodierer einreicht, widerlegt sich selbst.
- **Verteilung der Fallzahlen.** 6 von 16 mit n < 30; das Maximum stammt aus n = 20. Nur Spannweite 16 bis 294 genannt.
- **Residuum der Zerlegung** (Punkt 13).
- **p- und KI-Vergleich in Stufe 2** (Punkt 5).
- **Offene Platzhalter.** Z. 3 bis 5, Z. 135 "[check wording]", Z. 143 "[date, check README]", Z. 152 "[check: number ...]", Z. 139 "[repository DOI to be created]". Für ein "complete" gekennzeichnetes Manuskript nicht akzeptabel.

---

## 15. Die drei schwächsten Stellen und wie sie zu entschärfen sind (Punkt 7 des Auftrags)

**Erstens: Das principled-Gitter ist in den meisten Studien leer, und der eine Knoten, der es füllt, ist nach den eigenen Regeln kein E-Knoten (Punkte 1 bis 4).** Ein Gutachter rechnet `nodes_not_applicable.csv` gegen `variance_by_study.csv` und sieht in zehn Minuten, dass "Baseline dominiert" in 7 von 10 Fällen die einzige Möglichkeit war, und dass das Maximum eine MAD-Regel auf einem Prozentmass mit Deckel ist. Entschärfung: Baseline und Ausreisser als N führen, Langformat-Baseline nachrüsten, principled-Gitter mit ANCOVA als Referenz rechnen, den Befund umdrehen: "Nach Abzug der Entscheidungen mit begründeter Präferenz gab es in 12 von 16 Studien nichts Äquivalentes zu variieren; die verbleibende Spannweite in den anderen 4 lag zwischen 0,016 und 0,03 SD." Das ist ein publizierbarer, wenn auch bescheidenerer Befund über die Grenzen der Multiverse-Methode bei einfachen Zweiarm-Studien.

**Zweitens: Stufe 2 ist keine Reproduktion der publizierten Analyse (Punkte 5 und 6).** Ein Gutachter liest `METHODENPRUEFUNG.md` Z. 29 (oder fragt nach der Chronologie), findet den Kopfkommentar von `reproduce.R`, sieht 22 % und 27 % als "full" und die verschwiegenen Gleichstände. Entschärfung: die publizierten Modelle tatsächlich fitten (Random Slopes, AR(1), Bayes sind Standard in R), die vorregistrierte relative Regel als Hauptergebnis, Gleichstände und p-Vergleich in Tabelle 3, den Abstract auf "6 of 12 under the preregistered rule, all 12 within 0.07 SD" umstellen. Die kontinuierliche Abweichung ist die stärkere Aussage und braucht keine Schwelle.

**Drittens: Der Reporting-Befund ist durch Kodierung und Sekundärberichte überzeichnet und die Mapping-Regeln wurden nicht wie beschrieben angewendet (Punkt 7).** Ein Gutachter öffnet das tSCS-Paper, findet "Primary outcomes were the Berg Balance Scale and Timed Up and Go" und fragt, warum Tabelle 2 "abstract only" sagt; dann fragt er, warum Regel 1 (Registrierung) bei sechs registrierten Studien nicht angewendet wurde. Entschärfung: Registrierungen abrufen, Kodierung in vier Stufen trennen, Sekundärberichte getrennt führen oder ausschliessen, Zweitkodierung vor Einreichung abschliessen, "9 of 16" durch "4 of 13 primary reports" ersetzen.

Was standhält: die Korpuszahlen (423, 152, 84, 74, 48, 16), die Ausschlussdokumentation, der feste Nenner, die Typ-II-Zerlegung als Rechenschritt, die Studien-Bootstrap- und Wilson-Intervalle, der Verzicht auf Signifikanz-Anteile, die Pipeline-Ähnlichkeitsprüfung, die Offenlegung der eigenen Mapping-Fehler. Das Gerüst ist brauchbar. Die Schlüsse, die darauf gesetzt sind, sind es in der jetzigen Form nicht.
