# Reproducibility without a mandate

Code, configuration, outputs and manuscript for: *Reproducibility without a mandate:
computational reproduction and multiverse analysis of exercise, rehabilitation and
physiotherapy trials with publicly deposited individual participant data* (Jürgen
Degenfellner, ZHAW, 2026). Manuscript: `manuscript/paper.md`, PDF: `manuscript/paper.pdf`.

**What is not in this repository.** The deposited individual participant data of the
48 assessed trials (about 4 GB) and the full texts of the papers are third-party
material and stay local. Every deposit is identified by URL and DOI in
`candidates/deposit_contents.csv`; SHA-256 checksums of the 16 analysed data files are in
`config/data_checksums.csv`, so a reader who downloads the same deposits can verify they
hold the analysed versions. Literature PDFs are likewise excluded; `literature/manifest.csv`
and `literature/references.bib` list them with DOIs.

**How to rerun.** `Rscript R/run_all.R` (multiverse over four grids), then the scripts
named in `STAND.md`; stage 2 is `R/stage2_published_models.R`, `R/stage2_classify.R` and
`R/stage2_no_estimate.R`. The mapping of each trial onto its data is `config/registry.csv`,
the grid is `R/grid.R`. Method decisions and their history are in `METHODENPRUEFUNG.md`,
current numbers in `STAND.md`. Code is under the MIT licence; the manuscript text is
CC BY 4.0.

---

# Multiverse-Reanalyse von Physiotherapie-Studien mit offenen Daten

Kandidatensuche für ein Paper, das Physio-Studien mit hinterlegten Daten (und
möglichst Code) nachrechnet und dann einen Multiverse über die Analyse­entscheidungen
legt. Angelegt 2026-08-27.

**Arbeitstitel:** *Reproducibility without a mandate: a reanalysis and multiverse audit of
physiotherapy trials with publicly available data*

## Neuheitsprüfung, Stand 2026-08-28 (erneut 2026-09-15, siehe `literature/novelty_search_2026-09-15.md`: keine Gegenbeispiele; neuer Nachbar Nolte, DSHS Köln, OSF-Registrierung 10.17605/OSF.IO/VCWP8)

**Urteil: Lücke in der Physiotherapie bestätigt, Verkettung anderswo besetzt.**

In Physiotherapie, Rehabilitation, Sportwissenschaft, Ergotherapie und Schmerzforschung
gibt es keine publizierte oder registrierte Arbeit, die Individualdaten aus Repositorien
holt und die publizierte Primäranalyse nachrechnet. `"computational reproducibility"` und
`"analytic reproducibility"` gekreuzt mit diesen Feldern ergeben in Europe PMC jeweils
**0 Treffer**. Die 203 Arbeiten, die Naudet 2018 zitieren, enthalten keinen Nachahmer aus
dem Bewegungsbereich.

**Der Nachbar, der abgegrenzt werden muss.** Brodeur A, Mikola D, Cook N, et al.
(347 Autoren). *Reproducibility and robustness of economics and political science research.*
Nature 2026;652(8108):151-156, doi 10.1038/s41586-026-10251-x. 110 Artikel, über 85 %
computational reproduzierbar, 72 % der signifikanten Schätzer bleiben in Robustheitschecks
signifikant und gleichgerichtet. Das ist dieselbe Kette. Drei Unterschiede tragen:

1. **Kein Mandat.** Brodeur wählte Journals mit Daten- und Codepflicht, dort war Stufe 1
   fast trivial. Die Physiotherapie hat kein Mandat, damit wird die Machbarkeitsstufe zum
   eigenen Ergebnis. Die Frage, ob Massenreproduktion ohne Verpflichtung überhaupt geht,
   kann Brodeur konstruktionsbedingt nicht beantworten.
2. **Einheitliches Spezifikationsgitter.** Brodeurs Robustheitschecks sind
   replikatorgewählt und pro Studie verschieden, "multiverse" kommt im Working Paper
   einmal vor. Ein präspezifiziertes Gitter über alle Studien macht eine studienübergreifende
   Specification Curve erst interpretierbar.
3. **Zielgröße ist die Verteilung der Fragilität über Studien** und welche
   Entscheidungsknoten sie feldweit treiben, nicht die Fragilität einer Einzelstudie.

**Die nächsten Nachbarn im Feld bleiben alle eine Stufe davor stehen:**

| Arbeit | Was sie macht | Was fehlt |
|---|---|---|
| Elghzali et al., BMC Med Res Methodol 2025, doi 10.1186/s12874-025-02587-1 | 1278 Studien aus 5 Top-Reha-Journals, Data-Sharing-Statements; nach E-Mail hielten nur 22,7 % der Autoren ihre Zusage ein | rechnet nie etwas nach |
| Jabouille, …, Boisgontier, medRxiv 2025, doi 10.1101/2025.09.23.25336497 | 465 Artikel aus 4 Verbandszeitschriften, Praxisindikatoren, 12 % offene Daten | keine Reproduktion |
| Murphy, Caldwell, Mesquida et al., Sports Med 2025, doi 10.1007/s40279-025-02201-w | Replikation mit **neuen** Daten, 28 % Erfolg; nur 14 % der Autoren gaben Rohdaten heraus | anderes Design |
| Dhanani et al., J Gen Intern Med 2022, doi 10.1007/s11606-022-07799-5 | 572 RCTs, Statistik aus publizierten Zahlen nachgerechnet, 2 % p-Wert-Diskordanz | keine Individualdaten, keine Robustheit |

**Weitere Pflichtzitate:** Naudet et al., BMJ 2018, doi 10.1136/bmj.k400. Hardwicke et al.,
R Soc Open Sci 2018 (Cognition) und 2021 (Psychological Science, Open-Data-Badges).
Ankel-Peters et al., Q Open 2025, doi 10.1093/qopen/qoaf004. Nepomuceno, Ghosal,
Sandoval-Lentisco & Ioannidis, Preprint 2026, doi 10.64898/2026.07.15.738584 (613
Multiverse-Anwendungen: nur 8,6 % präregistriert, nur 3,9 % begründen die Vertretbarkeit
ihrer Spezifikationen, Median 144 Spezifikationen).

**Terminologie-Falle.** In der Physiotherapie meint "reproducibility of exercise programs"
schon etwas anderes, nämlich ob ein Kliniker die Intervention aus der Beschreibung
nachbauen kann (zwei OSF-Registrierungen vom August 2026). Durchgehend von
*computational* oder *analytic* reproducibility sprechen.

### Scooping-Risiko: geprüft, gering

Die Gruppe um Matthieu Boisgontier (Ottawa) wurde gezielt geprüft: Europe PMC (104 Werke),
OpenAlex (Autor A5076503553, 55 Werke seit 2023), ORCID 0000-0001-9376-3071, OSF-API,
Laborseite, Förderangaben.

**Kein konkurrierendes Vorhaben.** Boisgontiers fünf OSF-Registrierungen (User `cnkds`,
selbst nachgeprüft) betreffen Kinarm-Validierung, ein Scoping-Review zu Sturzscreening und
drei ältere Arbeiten zu Belohnungsaktivität, Alterung und Ego-Depletion. Nichts zu
Reanalyse, Reproduktion oder Multiverse. Jabouille, der Erstautor des Replicability-Preprints,
hat null eigene OSF-Nodes.

**Ihre eigene Roadmap zeigt woanders hin.** Der Abschnitt *Limitation and Future
Considerations* des medRxiv-Preprints nennt drei Richtungen: mehr Journale, globalere
Stichprobe, Befragung von Forschern. Keine davon ist dieses Paper. Das SportRxiv-Stück 993
(doi 10.51224/SportRxiv.993) ist ein eingeladenes Editorial für *Movement & Sport Sciences*
über Forschungsbewertung und Diamond Open Access, ohne angekündigte Folgestudie.

**Der Methodensprung fehlt ihnen.** Ihr gesamtes Werk auditiert auf Artikelebene, also
Metadaten und aus dem Fließtext extrahierte Kennzahlen. Rohdaten werden nie angefasst,
fremder Code nie ausgeführt. Multiverse-Methodik kommt in Publikationen und OSF-Projekten
kein einziges Mal vor. Hinter der Metaforschung steht auch kein finanziertes Programm, sie
läuft als Nebenlinie mit Studentenkohorten (NSERC und CFI finanzieren die Kinarm-Linie).

**Sie liefern die Steilvorlage, die sie selbst nicht aufnehmen.** Wörtlich aus der
Diskussion: *"Only 12% of articles made their data directly available in a public repository
or as supplementary material, meaning that reproducibility could be directly assessed in
just over one-tenth of the physical therapy literature."* Genau dieser Satz gehört in die
Einleitung dieses Papers.

**Cristian Mesquida** (OSF-User `9y4qh`, 21 Nodes) ist methodisch näher, aber sein
Reproduzierbarkeitsbegriff ist statcheck-artig, also Nachrechnen von p-Werten aus
berichteten Teststatistiken. Individualdaten berührt er nicht.

**Das größere Risiko kommt aus der Computational-Reproducibility-Community**, die gerade
Feld für Feld durchgeht: Soziologie (10.31222/osf.io/5cakq, Juli 2026), Experience Sampling
(10.31234/osf.io/b6n52, Juli 2026), Archäologie (OSF `dqnhg`, Juli 2026), Intensivmedizin
(OSF `z8js9`, Juni 2026). Plausibler als ein Methodenwechsel bei Boisgontier ist, dass
jemand von dort Physio als nächstes Feld nimmt.

**Empfehlung:** Präregistrierung in vier bis sechs Wochen. Wirksamer als jede Registrierung
wäre ein früher Preprint mit Stufe 1 allein, also Korpusdefinition plus die Zahl, wie viele
Studien sich überhaupt nachrechnen lassen. Kooperationsanfragen erst nach dem Zeitstempel,
vorher setzt man das Thema nur auf fremde Radars.

## Warum das ein Paper ist

Europe PMC kennt in Titel und Abstract weltweit **7** Arbeiten, die Multiverse oder
Specification Curve mit einem RCT verbinden, und die kommen aus Bildungsforschung,
Psychiatrie und Neuroimaging. Aus der Physiotherapie kommt keine. Am nächsten dran
ist *The Effects of Data Preprocessing Choices on Behavioral RCT Outcomes*
(Multivariate Behav Res 2026).

Das Paper liefert zwei Befunde statt einem: wie viele Analysen überhaupt durchlaufen,
und wie weit die Schlussfolgerung wandert, wenn man die vertretbaren Alternativen
durchspielt.

## Was in `candidates/` liegt

| Datei | Inhalt |
|---|---|
| `shortlist_with_deposited_data.csv` | **Die Arbeitsliste.** 152 klinische Physio-/Reha-Studien mit echtem Repository-Link im Availability-Statement, davon **91 RCTs**. Sortiert: RCTs zuerst, dann nach Jahr. |
| `clinical_studies_with_repos.csv` | Alle 423 gescreenten Kandidaten mit klinischem Studiendesign, inklusive der Negativfälle ("auf Anfrage": 42). |
| `repo_deposits_trials.csv` | **Die zweite Arbeitsliste.** 127 studienartige Deposits aus Zenodo (81) und Dryad (46), von der Datenseite her gesucht. Findet Arbeiten, die Europe PMC nicht kennt. |
| `repo_deposits_zenodo_dryad.csv` | Alle 500 klinisch relevanten Deposits, auch die nicht studienartigen. |
| `broad_sweep_data_and_code.csv` | Breiter erster Durchlauf ohne Design-Filter, 254 Arbeiten. Überwiegend Biomechanik, Bildgebung und Simulation. Als Kandidatenliste unbrauchbar, als Kontrast lehrreich. |

Spalten der Shortlist: `year, is_rct, journal, title, doi, pmcid, n_data, n_code,
data_urls, code_urls, das`. `das` ist der Wortlaut des Availability-Statements.

## Wie gesucht wurde

`R/screen_clinical.py` erzeugt die Shortlist in zwei Schritten.

1. Europe-PMC-Suche: Physio-Begriffe in Titel/Abstract, **UND** klinisches Design
   über `PUB_TYPE` (Randomized Controlled Trial, Clinical Trial, Observational Study)
   oder entsprechende Titelbegriffe, **UND** ein Repository-Term irgendwo im Volltext,
   **UND** `OPEN_ACCESS:Y`. Ergibt 423 Kandidaten.
2. Für jeden Kandidaten den JATS-Volltext holen, das Data- und Code-Availability-Statement
   herausschneiden und Repository-URLs **nur innerhalb dieses Abschnitts** zählen.

Schritt 2 ist der entscheidende. Der erste Durchlauf (`screen_repos.py`) hat URLs im
ganzen Volltext gesucht und dadurch jedes zitierte Werkzeug mitgezählt, etwa
`github.com/dmlc/xgboost`. Von 107 vermeintlichen Treffern blieben nach der Verschärfung
4 mit echtem Code **und** Daten übrig.

`R/harvest_repos.py` sucht ergänzend von der Datenseite her direkt in Zenodo und Dryad.

**Zenodo-API, zwei Fallen.** Ohne Token ist die Seitengröße auf **25** begrenzt; jede
Anfrage mit `size` darüber liefert HTTP 400 mit einer Validierungsmeldung, die leicht
als Netzwerkfehler durchgeht. Und das Limit liegt bei **30 Anfragen pro Minute**, danach
kommt eine Fehlerantwort statt Daten. Beides erzeugt stille Nullergebnisse. Zusätzlich
blockt Zenodo den urllib-User-Agent, curl kommt durch. Wegen der Ratenbegrenzung fehlen
ein paar Seiten, die Zahlen sind also auch hier Untergrenzen.

## Zwei Einschränkungen, die in die Limitationen gehören

**Die Zahlen sind Untergrenzen, und die beiden Wege ergänzen sich.** Der Weg über
Europe PMC setzt voraus, dass der Volltext dort deponiert ist. Gegenprobe an einem
bekannten Positivfall: Verwoerd et al., *Clinical indicators associated with pain
trajectories in non-specific neck pain*, BMJ Open 2026, doi 10.1136/bmjopen-2025-115274,
mit Code auf GitHub (RichardFel/Paincare) und Daten auf Zenodo (doi 10.5281/zenodo.21511654),
hat **keine PMCID** und fehlt in `shortlist_with_deposited_data.csv`. Der Repository-Weg
findet es dagegen (`zenodo.org/records/21511654`). Frisch erschienene Arbeiten fehlen im
PMC-Weg systematisch, deshalb braucht es beide Listen.

**Code ist viel seltener als Daten.** Von den 152 haben nur 4 Code und Daten zugleich
im Availability-Statement. Wer Code voraussetzt, hat fast keine Stichprobe. Wer sich mit
Daten begnügt und die Analyse selbst schreibt, hat 152.

## Der Trichter, Stand 2026-08-28

Automatischer Vor-Screen über `R/probe_deposits.py`: Für jede Studie der Shortlist wird
die Dateiliste des verlinkten Deposits über die APIs von OSF, Zenodo, Dryad und figshare
geholt und nach Dateiendung klassifiziert.

| Stufe | n | davon RCT |
|---|---:|---:|
| Klinische Studien mit Repo-Link im Availability-Statement | 152 | 91 |
| Deposit erreichbar, Dateiliste geholt | 84 | |
| mindestens eine Tabellendatei im Deposit | 74 | **48** |
| zusätzlich Analysecode im Deposit | 10 | 8 |

**48 RCTs mit mindestens einer Tabellendatei** ist die realistische Ausgangsmenge für die
manuelle Prüfung. Das ist deutlich mehr, als die Feldquoten befürchten liessen, und es
reicht für eine aussagekräftige studienübergreifende Specification Curve.

Ergebnis in `candidates/deposit_contents.csv`, sortiert nach RCT, Datei vorhanden, Code
vorhanden, Größe. Die Spalte `tabular_files` nennt die Dateinamen, sodass man vor dem
Herunterladen sieht, ob es sich lohnt.

**Zwei API-Fallen, die stille Nullergebnisse erzeugen** (beide im Skript entschärft):
`page[size]` muss in OSF-URLs prozentkodiert werden, sonst bricht curl mit
`bad range in URL` ab, was wie ein leeres Deposit aussieht. Ein erster Lauf verlor so alle
61 OSF-Deposits. Und OSF liefert auf oberster Ebene Ordner statt Dateien, man muss
absteigen.

**Offen:** 8 figshare-Links sind private Share-Links (`figshare.com/s/…`) und über die API
nicht auflösbar, die müssen von Hand geöffnet werden. Bei etwa 60 Studien blieb das Deposit
unerreichbar, meist wegen abgeschnittener URLs im Availability-Statement. Auch die sind
Handarbeit.

## Zum Nenner-Einwand

Gegen das Vorhaben lässt sich einwenden, der Trichter kollabiere, weil die Open-Data-Quote
im Feld bei 12 % liegt (Jabouille 2025) und nur 14 bis 23 % der Autoren auf Anfrage
tatsächlich Daten herausgeben (Murphy 2025, Elghzali 2025).

**Das ist der falsche Nenner für dieses Design.** Elghzali und Murphy sind am
Autorenkontakt gescheitert. Hier wird niemand angeschrieben. Die Stichprobe ist bereits
auf Studien vorselektiert, deren Daten öffentlich in einem Repositorium liegen: **82 RCTs
mit direkt abrufbarem Datenrepositorium** (OSF 38, Zenodo 18, Dryad 15, figshare 9), plus
114 noch zuzuordnende Deposits. Der Flaschenhals der Vorläuferarbeiten existiert hier nicht.

Die echte Attrition passiert eine Stufe später, nämlich beim Übergang von "Daten liegen
öffentlich" zu "Individualdaten mit rechenbarer Primäranalyse". Wie groß dieser Verlust
ist, weiss niemand, und genau deshalb steht der Pilot vor der Präregistrierung.

## Nächste Schritte

1. **Pilot über 10 Studien** aus der Shortlist, um die Attritionsrate zu schätzen und das
   Kodierformular zu kalibrieren. Erst diese Zahl entscheidet, wie ambitioniert Stufe 3
   angelegt werden kann. Das Paincare-Repo (`main.py` gegen `requirements.txt`, lokal unter
   `1_ZHAW/Markus_Ernst_Anfrage_BMJ open/Paincare/`) eignet sich zum Kalibrieren.
   *Vorher klären, ob die Anfrage von Markus Ernst eine Gutachtenanfrage war. Falls ja,
   nicht als namentliches Ziel verwenden.*
2. Die 114 Deposits aus `repo_deposits_trials.csv` ihren Artikeln zuordnen.
3. **Präregistrieren**, mit dem vollständigen Spezifikationsgitter und einer
   Ausstiegsregel: Erreichen weniger als etwa zehn Studien Stufe 3, wird der Multiverse
   zur illustrativen Fallauswahl und Stufe 1 plus 2 tragen das Paper.
4. Beim Auswerten: Der Vergleich zwischen Originalergebnis und Multiverse darf **nicht**
   über die Überlappung der jeweiligen Konfidenzintervalle laufen. Zielgröße ist die
   Verteilung der Differenz.
