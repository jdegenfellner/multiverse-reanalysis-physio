# Logikprüfung von OUTLINE.md (Version vom 2026-09-12)

Gutachter-Perspektive: Logik und Story. Quellen und statistische Methodik im Detail sind
nicht Gegenstand dieser Prüfung. Grundlage sind `manuscript/OUTLINE.md`, `STAND.md`,
`METHODENPRUEFUNG.md` (Behebungsstand und Auditor-Regeln) und `README.md`
(Neuheitsprüfung).

Gesamteindruck vorweg: Die Architektur trägt. Vier Aims, ein Funnel, ein Gitter mit
principled/defensible-Trennung, ein Ehrlichkeitsabschnitt zur eigenen Kodierung. Das ist
ein solides Gerüst. Die eigentlichen Probleme sitzen woanders, in der Schärfe einzelner
Formulierungen (vor allem in der Discussion) und in ein paar losen Enden, die vor dem
Schreiben entschieden werden sollten. Keiner der Befunde unten verlangt eine neue
Analyse. Alle sind mit dem vorhandenen Material behebbar.

Befunde sind nach Schwere geordnet. Jeder Befund nennt Abschnitt, Problem und Vorschlag.

---

## Schwerwiegend

### Befund 1. Rechenfehler in der Implications-Zeile

**Abschnitt:** 4.8.

**Problem:** Der Satz "recomputation without a mandate is possible for about one in ten
trials with a link" passt zu keiner der beiden in 3.3 definierten Nenner. 8 von 152 sind
5 %, nicht 10 % (das steht in 3.3 auch korrekt als "5%"). 8 von 48 sind 17 %. "Eine von
zehn" trifft keine der beiden Zahlen, die der Text selbst rechnet. Das ist genau die Art
Fehler, die ein Gutachter zuerst nachrechnet, weil es die einzige Zahl in der ganzen
Discussion ist, die als knappe Kernaussage im Implications-Teil steht.

**Vorschlag:** Auf einen der beiden bereits definierten Nenner umstellen und ihn benennen,
zum Beispiel "möglich für etwa 5 % aller Studien mit Repository-Link, für etwa jede
sechste der manuell geprüften RCTs". Keine dritte, in 4.8 neu eingeführte Zahl ohne
Herleitung in 3.3.

### Befund 2. Abschnitt 3.5 liefert die Anklage, aber nicht die Verteidigung

**Abschnitt:** 3.5, 4.6, Methoden 2.4.

**Problem:** 3.5 berichtet, dass Registry v1 in 8 von 16 Studien den Kontrollarm falsch
kodierte, in 4 das Outcome und in 11 die Kovariaten. Das ist die richtige Entscheidung,
das offenzulegen. Aber der Satz "Second-coder agreement [pending]" steht direkt daneben.
Ein Gutachter liest das so: Ihr habt gezeigt, dass eure erste Kodierung in der Hälfte der
Fälle falsch war, und die einzige Zahl, die belegen würde, dass die zweite Kodierung
zuverlässiger ist, fehlt noch. Damit steht in diesem Abschnitt aktuell nur Beweismaterial
gegen die eigene Zuverlässigkeit, kein Gegenbeweis. Das ist kein Framing-Problem, das sich
mit anderen Worten lösen lässt. Es ist eine fehlende Zahl an der Stelle, wo die Zahl am
meisten zählt.

**Vorschlag:** Die Zweitkodierung mit Kappa pro Feld muss vor der Einreichung fertig sein,
nicht nur vor dem Schreiben. Ohne sie sollte 3.5 nicht in der jetzigen Form stehen. Zweiter
Punkt unabhängig davon: der Satz "Effect of v1 errors on results is not reported as a
result (they were errors), but the fact is" wirkt ausweichend, weil er die naheliegende
Leserfrage nicht beantwortet, nämlich ob die Korrektur die Kernzahlen (Median d,
Vorzeichenstabilität, dominanter Knoten) in eine bestimmte Richtung verschoben hat. Ein
Satz zur Richtung der Verschiebung (auch qualitativ: grösser, kleiner, gleich) gehört
hinein, gestützt auf Tabelle S2, sonst bleibt ein Raum für den Verdacht des
Rosinenpickens.

### Befund 3. "Reproduction is good when it is possible" trägt die eigene Zahl nicht

**Abschnitt:** 4.3.

**Problem:** 8 von 12 sind 67 %. Der Text vergleicht das mit Brodeur (>85 %), Hardwicke und
Naudet (14 von 17) und nennt es "comparable". 67 % ist nicht vergleichbar mit über 85 %,
das ist eine Differenz von fast 20 Prozentpunkten bei n = 12. Bei so kleinem n ist zudem
jede Prozentangabe ohne Intervall irreführend, ein Wilson-Intervall für 8 von 12 reicht
etwa von 35 % bis 89 %. Die Überschrift selbst ("good") ist eine Bewertung, die Results
nicht hergibt, Results liefert nur eine Klassenverteilung.

**Vorschlag:** Überschrift und erste Sätze umformulieren, weg von einer Verdikt-Aussage
("good") hin zu einer beschreibenden ("reproduziert in der Mehrheit der Fälle, mit breitem
Unsicherheitsbereich bei n = 12"). Den Vergleich mit Brodeur nicht als Ähnlichkeit,
sondern als Kontrast setzen: Brodeur testet unter Mandat mit 110 Artikeln, hier bei n = 12
ohne Mandat. Die eigentliche Pointe dieses Papers ist ohnehin nicht, dass 67 % gut sind,
sondern dass man überhaupt nur 12 von 423 gescreenten Studien so weit bringt. Das gehört
in den ersten Satz von 4.3, nicht als Fussnote.

### Befund 4. "Fragility is small and has a name" verdeckt die Heterogenität, die die eigene Tabelle zeigt

**Abschnitt:** 4.4, gestützt auf 3.4.

**Problem:** Median 0,14 SD klingt klein. Aber die 16 Studien reichen von n = 16 bis
n = 294, und das Maximum liegt bei 0,89 SD (tDCS, n = 20), mehr als das Sechsfache des
Medians. "Small" beschreibt die Mitte der Verteilung, nicht die Studie, die am ehesten in
einer klinischen Entscheidung landen würde. Für eine Aussage über ein ganzes Feld aus nur
16 sehr unterschiedlich grossen Studien fehlt jede Angabe zur Unsicherheit über diese 16
Punkte hinweg (kein Intervall, keine Bandbreite über Studien). Das ist dieselbe Falle wie
im CLAUDE.md-Grundsatz zum Overlapping-CI-Fehlschluss, nur ohne CIs: eine Aussage über
"das Feld" aus einer Punktangabe (Median) ohne die Streuung der Streuung selbst zu zeigen.

**Vorschlag:** "Small" nur für den typischen Fall behaupten, nicht für das Feld, und das
Maximum im selben Satz nennen, nicht nur in Tabelle 3. Etwa: "Bei den meisten Studien
bewegt sich der Effekt um 0,1 bis 0,2 SD, bei der kleinsten Studie (tDCS, n = 20) um das
Sechsfache davon." Ein Satz zur Studiengrösse als möglichem Treiber der Fragilität (kleine
n, grosse Spannweite) würde die Aussage ehrlicher machen, ohne sie zu schwächen.

### Befund 5. Die eigentliche Neuheit steckt im Schritt 48 → 16, nicht im Schritt 152 → 16, und der Text vermischt beide

**Abschnitt:** 3.1, 4.2, Story-Absatz.

**Problem:** Der Story-Absatz komprimiert den ganzen Funnel auf "152 studies with a
repository link, 16 analysable". Das verwischt, dass der Schritt von 152 auf 48 (Deposit
nicht erreichbar, keine Tabellendatei, RCT-Filter) im Wesentlichen dieselbe Art Verlust
ist, die Jabouille, Elghzali und Murphy schon zeigen: Daten sind faktisch nicht da oder
nicht nutzbar. Der wirklich neue Befund, den 4.2 explizit behauptet ("not at author
contact, but at the transition from 'data are public' to 'the published primary analysis
can be identified and recomputed'"), sitzt im Schritt 48 → 16, wo die Daten öffentlich UND
lesbar sind und die Studie trotzdem ausscheidet, weil die Primäranalyse nicht
identifizierbar ist. Wenn diese Unterscheidung nicht scharf gezogen wird, kann ein
Gutachter sagen: das ist derselbe 12-Prozent-Befund wie bei Jabouille, nur mit anderen
Nachkommastellen.

**Vorschlag:** Im Story-Absatz und in 3.1 explizit zwei Zahlen nennen statt einer: wie viel
schon vor der manuellen Prüfung verloren geht (152 auf 48, klassische
Verfügbarkeitslücke) und wie viel danach verloren geht (48 auf 16, die neue
Identifizierbarkeitslücke). Nur die zweite Zahl trägt den Neuheitsanspruch aus 4.2.

---

## Mittel

### Befund 6. Die Aims-Reihenfolge aus 1.4 wird in Results nicht eingehalten

**Abschnitt:** 1.4 versus 3.1 bis 3.5.

**Problem:** 1.4 kündigt an, die vier Aims "verbatim for Results headings" zu verwenden,
in der Reihenfolge Feasibility, Reproduction, Fragility, Estimand versus Analysis, plus
ein sekundäres Ziel (Reporting). In den Results steht Reporting (3.2) aber zwischen
Feasibility (3.1) und Reproduction (3.3), nicht danach. Ein Gutachter, der die vier Aims
in der Einleitung liest und sie in den Results wiederfinden will, muss an dieser Stelle
prüfen, ob überhaupt etwas fehlt, bevor er merkt, dass es nur vorgezogen wurde.

**Vorschlag:** Entweder Reporting nach 3.4 verschieben, sodass die vier Hauptaims lückenlos
3.1 bis 3.4 durchlaufen und das sekundäre Ziel danach folgt, oder 1.4 so umschreiben, dass
die tatsächliche Reihenfolge (Feasibility, Reporting, Reproduction, Fragility, Estimand)
angekündigt wird. Die erste Lösung ist die sauberere, weil sie das eigene Versprechen aus
1.4 wörtlich einlöst.

### Befund 7. Aim 3 und Aim 4 teilen sich einen Abschnitt ohne eigene Überschrift

**Abschnitt:** 3.4.

**Problem:** 1.4 stellt Fragility und Estimand-versus-Analyse als zwei getrennte,
nummerierte Fragen vor. In 3.4 stehen beide Antworten hintereinander in derselben
Unterüberschrift, nur durch Absätze getrennt (principled range beantwortet Aim 3,
defensible range und das Verhältnis 1,37 beantworten Aim 4). Inhaltlich ist das in
Ordnung, weil beide auf demselben Gitter beruhen. Für einen Gutachter, der Punkt für
Punkt prüft, ob alle vier Aims beantwortet wurden, ist es aber leicht zu übersehen, wo
genau Aim 4 beantwortet wird.

**Vorschlag:** Innerhalb von 3.4 zwei benannte Absätze oder Zwischenzeilen setzen ("Aim 3:
Fragility" und "Aim 4: Estimand versus analysis") oder in 3.5 umnummerieren, sodass die
Struktur die Aims-Nummerierung sichtbar spiegelt.

### Befund 8. Abschnitt 2.3 (Source B) ist ein Methodenteil ohne Ergebnis

**Abschnitt:** 2.3, im Abgleich mit 4.7.

**Problem:** 2.3 beschreibt 500 durchsuchte Zenodo/Dryad-Deposits mit 127 studienartigen
Treffern. 4.7 sagt dann "Source B not used". Ein ganzer Methodenabschnitt beschreibt also
eine Anstrengung, die im fertigen Paper nirgends ein Ergebnis trägt. Das liest sich wie ein
Waffe, die im ersten Akt gezeigt und nie abgefeuert wird, ein Gutachter fragt sich, warum
127 Zahlen im Methodenteil stehen, wenn Results nichts davon verwendet.

**Vorschlag:** 2.3 auf zwei Sätze kürzen oder ganz in die Limitations (4.7) verschieben,
als "ein zweiter Suchweg wurde begonnen, aber aus Zeitgründen nicht mit dem Korpus
zusammengeführt, siehe Ausblick". Ein eigener Methodenabschnitt ist nur gerechtfertigt,
wenn Source B entweder ein Ergebnis liefert oder explizit als abgebrochener, aber
methodisch informativer Versuch (zum Beispiel zur Grössenordnung ungenutzter Repositorien)
gerahmt wird.

### Befund 9. Crenshaw 2026 wird einmal erwähnt und danach fallen gelassen

**Abschnitt:** 1.3, fehlt in Kapitel 4.

**Problem:** Crenshaw 2026 ist die einzige andere Arbeit, die Multiverse-Methodik direkt
auf einen klinischen Trial anwendet, also der nächste Nachbar in der Methodik. Die Outline
erwähnt sie in 1.3 in einem Halbsatz ("Clinical trial multiverse so far demonstrated on
single trials") und nie wieder. In der Discussion, wo die principled/defensible-Trennung
als "the methodological contribution" (4.4) benannt wird, fehlt der Rückbezug zu Crenshaw
komplett. Für ein Journal wie BMC Med Res Methodol oder J Clin Epidemiol ist genau dieser
Vergleich die erste Frage, die ein Gutachter mit Multiverse-Hintergrund stellt: was macht
ihr anders als Crenshaw, ausser mehr Studien?

**Vorschlag:** In 4.4 einen Satz einfügen, der Crenshaws Einzelstudien-Kurve explizit gegen
die eigene Leistung setzt: a-priori-Knotentypisierung über 16 Studien hinweg und die
Trennung von Schätzergenauigkeit und Estimand-Wechsel, was bei einer einzelnen Studie
nicht als Feld-Muster sichtbar werden kann.

### Befund 10. Die Nicht-Präregistrierung wird nur teilweise offengelegt

**Abschnitt:** 2.1, 2.4, 4.7.

**Problem:** 2.1 legt offen, dass das Gitter vor jeder Berechnung feststand (NODES.md,
28.08.), aber die Ergebnisse vor dem Schreiben bereits bekannt waren. Das ist ehrlich. Was
fehlt, ist eine eigene, benannte Offenlegung für einen zweiten, feineren Punkt aus 2.4: die
acht Auditor-Regeln, die bestimmen, welche Studien überhaupt eingeschlossen werden und wie
Kontrollarm, Outcome und Kovariaten kodiert werden, wurden "nach voller Extraktion der
publizierten Analysen" festgelegt, also nachdem bereits bekannt war, was in den Papers
steht. Das ist ein anderes Risiko als "Ergebnisse vor dem Schreiben gesehen", nämlich dass
Einschlussregeln nach Kenntnis der Daten fixiert wurden. 2.1 und 4.7 sprechen nur die
gröbere Frage an, nicht diese spezifischere.

**Vorschlag:** In 4.7 einen eigenen Satz ergänzen, der diesen zeitlichen Ablauf benennt und
begründet, warum er die Ergebnisse nicht in eine gewünschte Richtung gezogen haben kann
(zum Beispiel weil die Regeln aus generischen Prinzipien wie Registrierungshierarchie und
Berichtstyp folgen, nicht aus einer Studie einzeln optimiert wurden). Ein knapper,
konkreter Satz reicht, aber er muss diesen spezifischen Punkt treffen, nicht nur die
allgemeine Nicht-Präregistrierung.

### Befund 11. Die Konklusion lässt genau den Befund weg, der im Story-Absatz als eigenständiges Ergebnis zählt

**Abschnitt:** 5, im Abgleich mit dem Story-Absatz.

**Problem:** Der Story-Absatz nennt zwei "findings about auditing itself": Reporting-Mängel
im Feld und die eigenen Registry-Fehler. Für den Conclusion-Abschnitt sind nur "feasibility,
reproduction, fragility, estimand versus analysis, reporting" vorgesehen, die Auditor
Degrees of Freedom fehlen. Wenn 3.5/4.6 wirklich ein Ergebnis des Papers sind (nicht nur
eine Randnotiz), sollte die Konklusion das nicht auslassen, sonst wirkt der Abschnitt im
Nachhinein wie ein Anhang statt wie ein Kernbefund.

**Vorschlag:** Einen Halbsatz in der Konklusion ergänzen oder, falls kein Platz ist,
bewusst entscheiden, dass Auditor Degrees of Freedom ein Methoden-Befund zweiter Ordnung
ist und das dann auch im Story-Absatz so einordnen, statt es dort gleichrangig neben die
drei Hauptergebnisse zu stellen.

### Befund 12. "Reporting" und "Auditor degrees of freedom" werden im Story-Absatz unter einem Label geführt, obwohl sie verschiedene Dinge sind

**Abschnitt:** Story-Absatz ("The audit also produced two findings about auditing itself").

**Problem:** Reporting-Mängel (Primäroutcome fehlt in 9 von 16, Estimand in 15 von 16) sind
eine Eigenschaft der publizierten Literatur. Die Registry-Fehler sind eine Eigenschaft des
eigenen Prozesses. Beide unter "findings about auditing itself" zu bündeln, verwischt den
Unterschied zwischen einem Feldbefund und einer Selbstauskunft. Das beeinträchtigt die
Klarheit der Story an der Stelle, die für einen Leser am meisten zählt, dem letzten Absatz
der Einleitung.

**Vorschlag:** Zwei getrennte Formulierungen, zum Beispiel "the audit also produced a
finding about the field (reporting gaps) and a finding about itself (our own coding
error rate)". Kurz, aber trennt die beiden Ebenen sauber.

### Befund 13. Die Baseline-Imbalance-Erklärung in 4.4 klingt nach einer eigenen Analyse, die es laut Methoden nicht gibt

**Abschnitt:** 4.4, im Abgleich mit 2.9 und 3.4.

**Problem:** Der Satz "connect to the observed spread as a function of baseline imbalance
and correlation" liest sich wie eine empirische Aussage über einen Zusammenhang, den das
Paper selbst zeigt. In 2.9 (Summenmasse) und 3.4 (Results) steht keine Analyse, die
Spannweite gegen Baseline-Imbalance oder Baseline-Endwert-Korrelation aufträgt. Der
Beleg, der tatsächlich da ist, ist die dominante Rolle des Knotens Baseline-Behandlung in
der Varianzzerlegung, das ist etwas anderes als ein Zusammenhang mit dem Ausmass der
Imbalance selbst.

**Vorschlag:** Entweder die Analyse tatsächlich ergänzen (Spannweite von d gegen ein Mass
für Baseline-Imbalance je Studie, eine einfache Zusatzgrafik oder ein Satz mit Korrelation),
oder den Satz in 4.4 auf das zurücknehmen, was belegt ist: dass Baseline-Behandlung der
Knoten mit dem grössten Anteil ist, mit Vickers & Altman als mechanistische Erklärung,
ohne eine eigene quantifizierte Imbalance-Beziehung zu behaupten.

### Befund 14. Der Strata-Vergleich 8 gegen 8 wird in Results als fertig behandelt, obwohl die Korpusentscheidung laut STAND.md noch offen ist

**Abschnitt:** 3.4, im Abgleich mit STAND.md ("Korpusentscheidung (Autor): offen") und
Methoden-Regel 8.

**Problem:** Methoden-Regel 8 sagt ausdrücklich, die Entscheidung, welches Stratum den
Haupttext trägt, liege beim Autor und sei noch offen. 3.4 berichtet die Strata-Zahlen
trotzdem bereits als Teil der Ergebnisdarstellung ("Report as descriptive"), und 3.1 führt
den Gesamtkorpus von 16 bereits ungeteilt als das eingeschlossene Set. Solange die
Grundsatzfrage offen ist, ob Sport/Ernährung an Gesunden in den Hauptkorpus gehört oder
als separates Stratum, ist unklar, ob Abschnitt 3.4 im fertigen Manuskript so aussehen
wird wie in der Outline oder ob sich n und Zahlen noch verschieben.

**Vorschlag:** Diese Entscheidung vor dem Schreiben treffen, nicht während dessen, weil sie
Titel ("exercise, rehabilitation and physiotherapy trials"), Tabelle 2 und die
Strata-Zeile in 3.4 gleichzeitig betrifft. Unabhängig von der Entscheidung: die 8-gegen-8-
Zahlen dürfen im Text nirgends als Unterschied zwischen den beiden Gruppen gelesen werden,
solange keine Verteilung der Differenz selbst gezeigt wird, nur als deskriptive
Nebeneinanderstellung zweier Mediane. "Report as descriptive" in 3.4 ist der richtige
Instinkt, sollte aber in der ausformulierten Discussion (falls dort aufgegriffen) genauso
strikt eingehalten werden.

---

## Gering

### Befund 15. Methoden 2.9 kündigt Summenmasse an, die in Results 3.4 nicht auftauchen

**Abschnitt:** 2.9 versus 3.4, gestützt durch STAND.md Punkt 4 ("Was noch fehlt").

**Problem:** 2.9 nennt s-Werte (Rafi & Greenland) und den Anteil der Spezifikationen mit
|d| über 0,2 SD als geplante Summenmasse. In 3.4 kommt keines von beiden vor. STAND.md
bestätigt, dass die MCID-Erfassung je Studie noch aussteht. Das ist beim aktuellen Stand
kein Fehler, nur eine Lücke zwischen dem, was Methoden verspricht, und dem, was Results
zeigt.

**Vorschlag:** Vor dem Schreiben abgleichen, welche der in 2.9 angekündigten Masse
tatsächlich in die finale Fassung von 3.4 kommen, und die Methoden entsprechend kürzen
oder Results ergänzen. Keine Ankündigung stehen lassen, die nicht eingelöst wird.

### Befund 16. Der Integritätsscreen dürfte bei n = 16 kaum je etwas finden

**Abschnitt:** 2.7, 3.4 ("Integrity screen: no flag").

**Problem:** Der Carlisle-Test ist für grosse Korpora entwickelt, seine Power bei 16
Einzelstudien mit wenigen benannten Baseline-Variablen ist gering. "Kein Flag" ist bei so
wenig Teststärke fast garantiert und trägt daher wenig Information, auch wenn der
Screen methodisch richtig eingebaut ist.

**Vorschlag:** In 3.4 oder in den Limitations einen Satz zur begrenzten Power des Screens
bei diesem n ergänzen, damit der Abschnitt nicht wie eine Rigor-Behauptung wirkt, die mehr
verspricht, als sie bei dieser Stichprobengrösse leisten kann.

### Befund 17. Die Literatursuche für den Korpus ruht auf einer einzigen Datenbank, ohne das als Limitation zu nennen

**Abschnitt:** 2.2, fehlt in 4.7.

**Problem:** Der Korpus beruht auf einer Europe-PMC-Volltextsuche. 4.7 nennt
Selbstselektion (wer überhaupt Daten teilt) als Limitation, aber nicht die Abdeckung der
Suche selbst (eine Datenbank, ein Suchstring). Für ein methodisch strenges Journal ist das
ein naheliegender Zusatzpunkt.

**Vorschlag:** Einen Satz in 4.7 ergänzen, etwa dass die Suche auf Europe PMC beschränkt
war und relevante Studien in nicht indexierten oder anders verschlagworteten Quellen fehlen
können.

### Befund 18. Titel und Schwerpunkt der Ergebnisse zeigen leicht auseinander

**Abschnitt:** Titel, im Abgleich mit Story-Absatz und 4.4.

**Problem:** Der Haupttitel trägt "Reproducibility", das ist Aim 2. Der Story-Absatz nennt
Feasibility als ersten und am deutlichsten neuen Befund, und 4.4 nennt die
principled/defensible-Trennung "the methodological contribution" des Papers, das ist Aim
4. Der Titel hebt also das dritte der vier Ergebnisse hervor, nicht das erste oder das mit
dem stärksten Neuheitsanspruch. Das ist kein Fehler, ein Titel mit "Reproducibility ...
without a mandate" ist griffig und passt gut zur Abgrenzung von Brodeur. Aber wer nur den
Titel liest, erwartet in erster Linie eine Reproduktionsstudie und trifft dann zuerst auf
den Feasibility-Funnel.

**Vorschlag:** Keine zwingende Änderung des Haupttitels, dafür ist er zu gut in der
Brodeur-Abgrenzung verankert (siehe Befund 3 zu 4.3, wo "ohne Mandat" ohnehin die
tragende Idee ist). Aber den Untertitel könnte man von einer reinen Methodenbeschreibung
("computational reproduction and a principled multiverse audit of ...") zu etwas
verschieben, das andeutet, worum es inhaltlich geht, zum Beispiel dass Machbarkeit selbst
das erste Ergebnis ist. Optional, keine Pflichtkorrektur.

### Befund 19. Kein direkter Vergleichs-Überblick zu den fünf engsten Nachbararbeiten

**Abschnitt:** fehlt, würde zwischen 1.3 und 1.4 oder als Tabelle S0 passen.

**Problem:** README.md enthält bereits eine gute Textgegenüberstellung zu Naudet, Brodeur,
Elghzali, Jabouille, Murphy und Dhanani. In der Outline taucht das nur verteilt in
einzelnen Sätzen auf (1.1, 1.2, 4.2, 4.3). Für Gutachter an methodenorientierten Journals
ist eine kompakte Tabelle, die zeigt, wer was bereits gemacht hat und was hier zum ersten
Mal zusammenkommt, oft der schnellste Weg zur Neuheitsbewertung.

**Vorschlag:** Optionale Ergänzung, keine Pflicht. Falls Platz fehlt, als Supplement-Tabelle
denkbar, nicht im Haupttext.

---

## Antworten auf die sieben Leitfragen im Überblick

**1. Trägt die Story?** Im Kern ja. Die vier Aims folgen sauber aus 1.1 bis 1.3, und drei
der vier Aims (Feasibility, Reproduction, Fragility) werden in Results klar beantwortet.
Die Reihenfolge stimmt aber nicht ganz mit dem Versprechen aus 1.4 überein (Befund 6), und
Aim 4 teilt sich einen Abschnitt mit Aim 3 ohne eigene Kennzeichnung (Befund 7). Die
Grobstruktur ist also solide. Die grösste Lücke zwischen Behauptung und Beleg liegt in
einzelnen Formulierungen der Discussion (Befunde 3, 4, 13) und in einem Rechenfehler
(Befund 1).

**2. Overclaiming?** Ja, an drei Stellen konkret: 4.3 ("good"), 4.4 ("small"), und der
Zahlenfehler in 4.8. Der Strata-Vergleich selbst ist in 3.4 korrekt als deskriptiv
gekennzeichnet (Befund 14), das sollte so bleiben.

**3. Abgrenzung zu Brodeur und Crenshaw?** Zu Brodeur scharf und an der richtigen Stelle
(README und 1.1/4.2/4.3). Zu Crenshaw zu dünn, eine einzige Erwähnung ohne Rückbezug in
der Discussion (Befund 9).

**4. Abschnitt 3.5, Stärke oder Angriffspunkt?** Beides gleichzeitig, und aktuell mehr
Angriffspunkt als Stärke, weil die Zweitkodierung fehlt (Befund 2). Mit Kappa-Werten wird
daraus die stärkste Transparenz-Demonstration im Paper. Ohne sie ist es eine offene Flanke.

**5. Fehlt etwas, ist etwas überflüssig?** Source B (2.3) ist ein Methodenabschnitt ohne
Ergebnis (Befund 8). Eine Limitation zur Einzeldatenbank-Suche fehlt (Befund 17). Nichts
Zentrales ist überflüssig.

**6. Nicht-Präregistrierung ehrlich genug?** Grösstenteils ja, mit einer Lücke: der
zeitliche Ablauf der Auditor-Regeln (nach Extraktion, vor Berechnung) verdient einen
eigenen Satz (Befund 10).

**7. Trägt der Titel?** Der Haupttitel trägt, besonders durch die Kontrastwirkung zu
Brodeur. Der Untertitel beschreibt nur die Methode, nicht die Pointe (Befund 18), das ist
aber ein optionaler Feinschliff, kein Mangel.
