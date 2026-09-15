# Entscheidungsknoten für Physio-RCTs mit stetigem primärem Outcome

Grundlage für das Multiverse-Gitter. Typisierung nach Del Giudice & Gangestad
(AMPPS 2021, doi 10.1177/2515245920954925): **E** = begründet gleichwertig,
**N** = eine Option hat Vorrang oder es ist ein anderes Estimand, **U** = unklar.

Nur E-Knoten werden im Kerngitter multipliziert. N-Knoten laufen als getrennte
Achse, U-Knoten als markierter Zusatzarm.

---

## Der wichtigste Befund vorweg

**Preprocessing schlägt Modellwahl um Größenordnungen.** Veltri, *The Effects of Data
Preprocessing Choices on Behavioral RCT Outcomes: A Multiverse Analysis*, Multivariate
Behavioral Research 2026, doi 10.1080/00273171.2025.2575399: 180 Analysepfade aus 36
Preprocessing-Pipelines × 5 Modellspezifikationen. **Preprocessing erklärt 76,9 % der
Varianz der Effektschätzer, die Modellwahl 7,5 %.** Bei nichtlinearen Modellen 99,8 % gegen
0,1 %. Pipelines, die standardisieren oder logarithmieren, schrumpfen Effekte um über 90 %.

Zwei Konsequenzen:

1. **Ein Gitter nur aus Modellknoten misst den kleineren Teil.** Unser erster Entwurf
   (Baseline-Behandlung, Kovariaten, Inferenz) wäre genau dieser Fehler gewesen.
2. **Aber ein Teil dieser 77 % ist gar keine Fragilität.** Log-Transformation und
   Standardisierung ändern das Estimand, das ist Typ N. Veltri rechnet auf simulierten
   Daten und trennt das nicht. Genau hier liegt unser Beitrag: dieselbe Zerlegung auf
   echten Trials, mit sauberer Trennung von analytischer Fragilität und
   Estimand-Wechsel.

---

## Defensible gegen principled: zwei Gitter, nicht eines

Multi-curious (Short et al., AMPPS 2026) trennt zwei Begriffe, die leicht zusammenfallen.

**Defensibility** fragt, ob eine einzelne Pipeline für sich begruendbar ist, ob ein
Gutachter sie durchgehen liesse. Das operative Kriterium im Tutorial lautet woertlich
*"used in the literature"*.

**Equivalence** fragt, ob die vertretbaren Pipelines untereinander austauschbar sind. Das
ist Del Giudice & Gangestads E/N/U-Schema, ein relativer Vergleich, und es setzt die
Defensibility-Pruefung voraus.

Entscheidend ist, welches von beidem das Ziel verlangt. Das Tutorial ist explizit: Wenn
die Robustheit eines Effekts ueber die **analytische Vielfalt einer Literatur** geprueft
werden soll, etwa um Quellen niedriger Replizierbarkeit zu untersuchen, ist Defensibility
**ohne** Aequivalenz-Beschneidung angemessen. Erst wenn die Robustheit eines einzelnen
theoretisch postulierten Effekts berichtet wird, verhindert die Aequivalenzpruefung, dass
begruendete, aber nicht beliebige Entscheidungen als beliebig behandelt werden.

**Unser Ziel ist das erste.** Deshalb rechnen wir beide Gitter:

| Gitter | Inhalt | Kriterium |
|---|---|---|
| **Defensible multiverse** | alles, was das Kodierraster als im Feld verwendet ausweist | used in the literature |
| **Principled multiverse** | die Teilmenge nach Aequivalenzpruefung, also die E-Knoten unten | Typ E nach Del Giudice & Gangestad |

**Die Differenz zwischen beiden ist das Ergebnis.** Sie quantifiziert, wieviel der
scheinbaren Fragilitaet aus Estimand-Wechseln stammt statt aus Willkuer. Genau diese
Trennung macht Veltri auf simulierten Daten nicht.

**Konsequenz fuer das Kodierraster.** Es ist keine Vorarbeit, sondern die *Begruendung*
des Gitters. Welche Optionen an einem Knoten vertretbar sind, entscheidet nicht unsere
Meinung, sondern was die 48 Studien tatsaechlich getan haben. Multi-curious nennt das
systematische Literaturreview ausdruecklich als Methode zur Identifikation vertretbarer
Pipelines.

**Werkzeuge** (Tabelle 3 des Tutorials): fuer R `specr` (Masur & Scharkow 2020) und
`multitool` (Young & Vermeent 2024), beide Berechnung und Visualisierung. Dazu das
Multiverse Sampling Tool (Short, Hildebrandt et al. 2025), wenn das Gitter zu gross fuer
vollstaendige Berechnung wird.

---

## Kerngitter (Typ E) — wird multipliziert

| Knoten | Optionen | Warum gleichwertig |
|---|---|---|
| **Baseline-Behandlung** | Endwert · Change Score · ANCOVA mit Baseline-Kovariate | Unter Randomisierung alle erwartungstreu für dieselbe mittlere Differenz, Unterschied nur in Präzision. Vickers & Altman, BMJ 2001, doi 10.1136/bmj.323.7321.1123 |
| **Kovariatenumfang** | keine · nur Baseline-Outcome · Baseline plus Stratifizierungsfaktoren · publizierter Satz | Bei stetigem Outcome und linearem Modell fallen marginaler und konditionaler Effekt zusammen. FDA-Guidance 2023; Kahan 2014, doi 10.1186/1745-6215-15-139 |
| **Ausreißerregel** (gepoolt) | keine · ±3 SD · IQR 1,5 · MAD-basiert | Konventionell, keine hat Vorrang. **Nur gepoolt über beide Arme**, siehe N-Achse |
| **Ausreißerbehandlung** | belassen · Winsorizing · Trimmen | dito |
| **Modellfamilie Mittelwert** | lineares Modell / ANCOVA · Random-Intercept-Mixed · MMRM | Alle zielen auf die mittlere Differenz. Twisk 2018, doi 10.1016/j.conctc.2018.03.008 |
| **Inferenz** | modellbasierter SE · robuster HC3 · Permutation | Gleiches Estimand, andere Kalibrierung |
| **Fehlende Werte (nur MAR-konforme)** | MI · Direct Likelihood / MMRM | Unter MAR asymptotisch äquivalent. White 2011, doi 10.1136/bmj.d40 |

**Wichtige Einschränkung zu E.** „Gleichwertig" heißt *keine begründete Vorrangoption*,
nicht *praktisch folgenlos*. In einem einzelnen festen Datensatz mit zufälligem
Baseline-Ungleichgewicht divergieren Change Score und ANCOVA systematisch in
entgegengesetzte Richtungen (Lord's Paradox, Regression zur Mitte). Van Breukelen 2006,
doi 10.1016/j.jclinepi.2006.02.007; Barnett 2004, doi 10.1093/ije/dyh299. Bei 48 festen
Datensätzen ist das der Knoten, an dem Ergebnisse springen.

---

## Estimand-Achse (Typ N) — getrennt gerechnet, nicht multipliziert

| Knoten | Optionen | Warum verschieden |
|---|---|---|
| **Analysepopulation** | ITT · mITT · Per-Protocol · As-Treated | Verschiedene Estimands, ICH E9(R1). PP ist keine gültige Umsetzung eines Efficacy-Estimands, sondern eine verzerrte Näherung. **Als getrenntes Multiversum rechnen, nicht als Achse im Kerngitter** |
| **Intercurrent Events** | Treatment Policy · Composite · While-on-Treatment · Hypothetical · Principal Stratum | Fünf Strategien, fünf Fragen. ICH E9(R1) |
| **Transformation** | keine · log · sqrt · Rang | log schätzt ein Verhältnis geometrischer Mittel, nicht eine Differenz. Keene 1995, doi 10.1002/sim.4780140810 |
| **Prozentuale Änderung** | zusätzlich zu Endwert/Change/ANCOVA | Nichtlineare Funktion des Baselinewerts, niedrigste Power, stark varianzabhängig. Gehört **nicht** in die E-Klasse. Vickers 2001, doi 10.1186/1471-2288-1-6 |
| **Responder-Dichotomisierung** | keine · 30 % · 50 % · MCID-Schwelle | Anderes Estimand (Risikodifferenz), erheblicher Effizienzverlust. Snapinn & Jiang 2007, doi 10.1186/1745-6215-8-31 |
| **Missing-Strategie nicht-MAR** | LOCF · BOCF · Worst/Best Case · Mittelwertimputation | Verzerren Punktschätzer und Kovarianzstruktur. Keine gleichwertigen Optionen. Mallinckrodt 2004, doi 10.1186/1471-244x-4-26 |
| **Ausreißerregel armweise** | gepoolt vs. getrennt je Arm | Armweise Grenzen nutzen Post-Randomisierungs-Information. Wicker 2026 berichtet rund 53 % mittlere Änderung der Effektschätzer |
| **Stratifizierungsfaktoren weglassen** | ja · nein | Ignorieren liefert zu große SE und konservativen Test. Kahan & Morris 2011, doi 10.1002/sim.4431 |
| **Clusterung ignorieren** | keine · Therapeut · Zentrum · partielle Nestung | Ignorierte Clusterung inflationiert Typ-I-Fehler. Candlish 2018, doi 10.1186/s12874-018-0559-x |
| **Zeitbehandlung** | primärer Zeitpunkt · longitudinal gepoolt | Effekt zu einem Zeitpunkt gegen Mittelung über Zeit. Innerhalb desselben Zeitpunkts ist Faktor gegen stetig dagegen U |

---

## Markierter Zusatzarm (Typ U)

Boden- und Deckeneffekte (Tobit gegen ignorieren), Kovarianzstruktur (UN, CS, AR1),
Freiheitsgradmethode (Satterthwaite, Kenward-Roger, Between-Within), REML gegen ML,
Vorgehen bei singulärem Fit, Visit-Windows, Item-Level-Missing und Prorating-Regeln,
Baseline-Definition bei mehreren Prä-Messungen, Wahl der MCID-Quelle,
Standardisierungs-SD für Effektgrößen, Multiplizitätskorrektur und Familiendefinition.

---

## Keine legitime Option

**Adjustierung, die durch einen Baseline-Signifikanztest ausgelöst wird.** Senn 1994,
doi 10.1002/sim.4780131703. Kommt real vor und gehört ins Reporting-Audit, nicht ins
Gitter. Verbindet sich direkt mit dem Table-1-Fallacy-Projekt.

---

## Knoten, die typischerweise vergessen werden

Ausreißerregel gepoolt gegen armweise · Messwiederholungen innerhalb eines Zeitpunkts
(Mittel aus drei Griffkraftversuchen gegen bester Versuch, „Schmerz jetzt" gegen
„Durchschnitt der letzten Woche") · Item-Level-Missing und Prorating bei ODI und RMDQ ·
Visit-Windows · Baseline-Definition bei mehreren Prä-Messungen · Therapeuten- und
Gruppenclusterung, besonders partielle Nestung · Kovarianzstruktur und
Freiheitsgradmethode · MI-Innenleben (armweise oder gepoolt, Outcome im Imputationsmodell,
Anzahl Imputationen, Seed) · Wahl der MCID-Quelle · Standardisierungs-SD ·
REML gegen ML und Software-Defaults · Familiendefinition bei Multiplizität ·
der Meta-Knoten, also die Konstruktion des Gitters selbst.

---

## Physio-spezifische Relevanz

**Therapeuteneffekte** erklären gepoolt rund 5 % der Ergebnisvarianz, in RCTs 8,2 bis
17,4 % (Johns 2019, doi 10.1016/j.cpr.2018.08.004). In Physio-RCTs praktisch nie
modelliert. Stärkster N-Knoten des Feldes.

**Partielle Nestung.** Gruppentraining im Interventionsarm gegen individuelle oder
Wartelistenkontrolle ist Standarddesign und erzeugt genau die Struktur, bei der
Standardanalysen fehlschlagen (Candlish 2018; Roberts 2020, doi 10.1002/sim.8778).

**Boden- und Deckeneffekte.** In 190 RCTs mit PROs überschritten 74 % die Skalenränder in
relevantem Umfang (Saarinen 2024, doi 10.1016/j.jclinepi.2024.111308). Für ODI und RMDQ
sind Bodeneffekte von 23 bis 27 % dokumentiert.

**Unverblindete Outcome-Erhebung.** Nichtverblindete Assessoren überschätzen Effekte
deutlich (Hróbjartsson 2013, doi 10.1503/cmaj.120744). Kein Analyseknoten, macht die
Streuung aber inhaltlich brisanter.

---

## Zweistufiger Gitterbau

Bei 48 Studien mit heterogenem Reporting sind viele Knoten nicht überall realisierbar
(Therapeuten-ID fehlt meist, Item-Level-Daten fast immer).

**Kerngitter**: Knoten, die bei allen anwendbar sind, also Baseline-Behandlung,
Kovariaten, Ausreißer, Modellfamilie, Inferenz.
**Studienspezifische Zusatzachsen**: dort, wo die Daten es hergeben.

Die Zahl der Optionen je Knoten wird vorab festgelegt und registriert, sonst wird das
Multiversum selbst zum Freiheitsgrad.

---

## Abgrenzung

**Crenshaw A, Pukay-Martin N, Wagner A, et al. Navigating Analytical Challenges in
Clinical Trials Using the Multiverse Approach. Collabra: Psychology 2026,
doi 10.1525/collabra.155619.** Plädiert dafür, den Multiverse-Ansatz auf klinische Studien
anzuwenden, und demonstriert ihn an **einer** kleinen Psychotherapie-Studie zu PTBS. Kein
Korpus-Audit. Das ist die Vorlage, deren Korpus-Version dieses Projekt ist, und der
wichtigste Zitierpunkt in der Einleitung.

**O'Brien et al., PLOS One 2026, doi 10.1371/journal.pone.0349949.** Multiversum über
Implementierungsvariabilität in einem RCT. Ebenfalls Einzelstudie.

Eine trialspezifische erschöpfende Knotentaxonomie existiert nach dieser Recherche nicht.
Andockpunkte: Wicherts 2016 (doi 10.3389/fpsyg.2016.01832, 34 Freiheitsgrade,
psychologiezentriert), Steegen 2016 (doi 10.1177/1745691616658637), Simonsohn 2020
(doi 10.1038/s41562-020-0912-z), Patel 2015 (doi 10.1016/j.jclinepi.2015.05.029) und
Klau 2021 (doi 10.1093/ije/dyaa164) für Vibration of Effects.
