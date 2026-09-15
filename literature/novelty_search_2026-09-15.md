# Neuheitsprüfung, 2026-09-15

Geprüfte Aussage (Manuskript, `body.tex` Zeile 5 bzw. `paper.md`):

> "I am not aware of a study in physiotherapy, rehabilitation or exercise science that
> retrieved individual participant data from public repositories and recomputed the
> published primary analysis."

Kriterium für ein Gegenbeispiel: Individualdaten aus einem öffentlichen Repositorium
oder Supplement geholt **UND** die publizierte Primäranalyse nachgerechnet, im Feld
Physiotherapie, Rehabilitation oder Sport- und Bewegungswissenschaft.

Diese Prüfung ergänzt die frühere Neuheitsprüfung vom 2026-08-28 (dokumentiert in
`README.md`, Abschnitt "Neuheitsprüfung"). Die dort ausgeschlossenen Nachbarn (Jabouille
2025, Elghzali 2025, Murphy 2025, Dhanani 2022) werden hier nicht erneut im Volltext
geprüft, sondern als bekannt vorausgesetzt.

**Urteil vorab: Kein Gegenbeispiel gefunden. Die Aussage bleibt haltbar.** Der nächste
Nachbar ist eine seit Januar 2026 laufende, noch nicht abgeschlossene Registered-Report-
Studie aus der Sportwissenschaft, die die publizierte Primäranalyse zwar nachrechnen
will, aber ausdrücklich mit **privaten**, von Autoren vertraulich geteilten Rohdaten
arbeitet statt mit Daten aus einem öffentlichen Repositorium. Details unten.

## Methodik und Abweichungen vom Suchplan

Alle Anfragen liefen über curl mit `-A "Mozilla/5.0"` und 1,5 Sekunden Pause zwischen
Aufrufen. Zwei Abweichungen von der Suchvorgabe, beide dokumentiert:

1. **medRxiv/bioRxiv**: Die direkte HTML-Suche auf `www.medrxiv.org/search/...` liefert
   nur eine Cloudflare-Challenge-Seite ("Just a moment...") zurück, kein Suchergebnis.
   Wie im Suchplan selbst vorgesehen, wurde stattdessen OpenAlex mit `filter=type:preprint`
   verwendet.
2. **OSF Registrations**: `https://api.osf.io/v2/registrations/` lieferte während der
   gesamten Sitzung durchgehend HTTP 502 oder Verbindungs-Timeouts (`https://api.osf.io/v2/`
   selbst antwortete mit 200, nur der Registrations-Endpunkt war betroffen; mehrere
   Wiederholungen über rund zwei Minuten, kein Erfolg). Als Ersatz wurde die SHARE-Such-API
   (`https://share.osf.io/api/v2/search/creativeworks/_search`) verwendet, die auch
   OSF-Registrierungen indiziert und zum Suchzeitpunkt erreichbar war (HTTP 200). Das ist
   ein dokumentierter Kompromiss, kein vollständiger Ersatz für `filter[title]`, weil SHARE
   eine andere Relevanzgewichtung nutzt und weitere Quellen (CrossRef, DataCite, PubMed
   Central) mit indiziert.

## Abfragen wörtlich, mit Quelle und Trefferzahl

### Europe PMC (`https://www.ebi.ac.uk/europepmc/webservices/rest/search`, `resultType=lite`, `pageSize=100`)

| # | Abfrage | Trefferzahl |
|---|---|---:|
| Q1 | `("computational reproducibility" OR "analytic reproducibility" OR "analytical reproducibility" OR "reanalysis" OR "re-analysis" OR "reproduction") AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise science" OR "sports science" OR "sport science") AND ("individual participant data" OR "individual patient data" OR "raw data" OR "open data" OR "shared data" OR "repository")` | 5002 |
| Q2 | `("multiverse") AND (Feldbegriffe wie Q1) AND (Datenbegriffe wie Q1)` | 28 |
| Q3 | `("specification curve") AND (Feldbegriffe) AND (Datenbegriffe)` | 5 |
| Q4 | `("vibration of effects") AND (Feldbegriffe) AND (Datenbegriffe)` | 5 |
| Q5 | `("many analysts") AND (Feldbegriffe) AND (Datenbegriffe)` | 5 |
| Q6 | `("robustness reanalysis") AND (Feldbegriffe) AND (Datenbegriffe)` | 0 |
| Q7 | `"reproducibility" AND "physical therapy" AND "data" AND (PUB_TYPE:"Meta-Analysis" OR "meta-research" OR "metaresearch")` | 256 |
| Q8 | `"many analysts" AND ("sport" OR "sports science" OR "exercise science")` | 10 |
| Q9 | `("reanalysis" OR "re-analysis") AND ("open data") AND ("sports science" OR "exercise science" OR "sport science" OR "Journal of Sports Sciences" OR "Medicine and Science in Sports and Exercise")` | 24 |
| Q10 | `"prevalence" AND "reproducible" AND ("sport science" OR "sports science" OR "exercise science")` | 928 |
| Q11 | `("individual patient data" OR "individual participant data") AND ("reanalysis" OR "re-analysis" OR "recomputed" OR "recompute") AND ("physiotherapy" OR "physical therapy" OR "rehabilitation") AND ("repository" OR "Zenodo" OR "Dryad" OR "OSF" OR "figshare")` | 49 |
| Q12 | `("reproduced the published" OR "recomputed the published" OR "recompute the published" OR "reanalyzed the original data" OR "reanalysed the original data") AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise" OR "sports")` | 120 |
| Q13 | `"computational reproducibility" AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise science" OR "sports science" OR "sport science")` | 29 |
| Q14 | `"analytic reproducibility" AND ("physiotherapy" OR "physical therapy" OR "rehabilitation" OR "exercise" OR "sports" OR "sport")` | 14 |
| Q15 | `("downloaded" OR "retrieved") AND ("individual participant data" OR "individual patient data" OR "raw data") AND ("recomputed" OR "recompute" OR "reran the analysis" OR "re-ran the analysis") AND ("physiotherapy" OR "rehabilitation" OR "exercise" OR "sports" OR "physical therapy")` | 51 |
| Q16 | `("Zenodo" OR "Dryad" OR "figshare" OR "Open Science Framework") AND ("reanalysis" OR "re-analysis" OR "recomputed") AND ("physiotherapy" OR "rehabilitation" OR "physical therapy" OR "exercise science" OR "sports science")` | 250 |
| Q17 | `"prevalence" AND "computational reproducibility" AND ("sport" OR "exercise" OR "physiotherapy" OR "physical therapy" OR "rehabilitation")` | 40 |
| Q18 | `"Cochrane" AND ("individual patient data" OR "individual participant data") AND ("repository" OR "Zenodo" OR "Dryad" OR "Open Science Framework" OR "figshare") AND ("physiotherapy" OR "rehabilitation" OR "physical therapy")` | 256 |
| Q19 | `TITLE:("Reanalysis of" OR "Re-analysis of" OR "A reanalysis of" OR "Reanalyzing") AND ("physiotherapy" OR "rehabilitation" OR "physical therapy" OR "exercise" OR "sports" OR "sport")` | 175 |

Bei Trefferzahlen über 100 wurden nur die ersten 100 (relevanzsortiert) geladen und
geprüft; das ist eine Untergrenze der Vollständigkeit, aber Europe PMC sortiert nach
Relevanz zur Abfrage, sodass Treffer aus dem Zielfeld bei den ersten 100 erscheinen
sollten, wenn sie existieren.

### OpenAlex (`https://api.openalex.org/works?search=<text>&per-page=50`, teils `&filter=from_publication_date:2015-01-01`)

| # | Suchtext | Trefferzahl |
|---|---|---:|
| OA1 | `reanalysis individual participant data physiotherapy rehabilitation repository` | 18 |
| OA2 | `multiverse specification curve physiotherapy rehabilitation exercise trial` | 0 |
| OA3 | `computational reproducibility sport science exercise physiotherapy` | 577 |
| OA4 | `many analysts sports science` | 29 165 |
| OA5 | `reanalysis open data sports science journal` | 2073 |
| OA6 | `individual patient data repository recompute rehabilitation trial` | 51 |
| OA7 | `vibration of effects physiotherapy rehabilitation exercise` | 5915 |
| OA8 | `robustness reanalysis physiotherapy exercise rehabilitation` | 104 |
| OA9 | `Mesquida many analysts sport` | 17 |
| OA10 | `Caldwell many analysts sport science` | 320 (nicht einzeln geprüft, Autor bereits über OA9/Sports-Med-Neighbour abgedeckt) |
| OA11 | `Vigotsky reanalysis sport science open data` | 4 |
| OA12 | `Borg many analysts sport` | 439 (nicht einzeln geprüft) |
| OA13 | `Bosco many analysts sport science` | 97 (nicht einzeln geprüft) |
| OA14 | `Abt many analysts sport science` | 170 (nicht einzeln geprüft) |
| OA15 | `Warmenhoven many analysts biomechanics` | 16 |
| OA16 | `Cochrane individual patient data reanalysis physiotherapy repository` | 16 |
| PP1 | `reanalysis individual participant data physiotherapy rehabilitation exercise` (`filter=type:preprint`) | 24 |
| PP2 | `multiverse specification curve rehabilitation physical therapy trial` (`filter=type:preprint`) | 0 |

Bei OA3, OA4, OA5, OA7 wurden nur die relevanzsortierten Top-15 bis Top-20 geprüft, weil
die Freitextsuche ohne Phrasenbindung sehr breit streut (z. B. zieht "vibration of
effects" jede Studie zu Vibrationstraining in der Physiotherapie an). Für OA10, OA12,
OA13, OA14 wurde aus Zeitgründen auf Einzelprüfung verzichtet, weil die zugehörigen
Autoren (Caldwell, Borg, Bosco, Abt) bereits über die Ko-Autorenschaft von Murphy et al.
2025 und Mesquidas Werkliste (OA9) erfasst sind und dort keine IPD-Reanalyse auftaucht.

Zusätzlich wurden gezielte OpenAlex-Autorenabfragen gefahren: Matthieu Boisgontier
(`author.id:A5076503553`, publiziert seit 2026-08-01: 4 Werke, alles Kinarm-Validierung
und eine Meta-Analyse-Datenablage, keine Reanalyse), François Jabouille
(`author.id:A5084775748`, 20 Werke, jüngste zwei sind Kinarm-Validierungsstudien und ein
französischsprachiger Transparenz-Checklisten-Artikel vom 2026-08-01, keine Reanalyse),
Cristian Mesquida (`author.id:A5082605089`, 36 Werke, jüngste sind Softwarepaket
`metacheck`, Typ-S/M-Fehler-Kommentar, Power-Analyse-Scoping-Review, keine IPD-Reanalyse)
und Colby J. Vorland (`author.id:A5074473858`, 115 Werke, Filter `search=reanalysis`:
16 Treffer, siehe Kandidatentabelle).

### medRxiv/bioRxiv

Direkter Zugriff über `www.medrxiv.org/search/...` blockiert durch Cloudflare
(Challenge-Seite, kein Ergebnis extrahierbar). Ersatz: OpenAlex `filter=type:preprint`
(siehe PP1, PP2 oben).

### OSF Registrations

`https://api.osf.io/v2/registrations/?filter[title]=<term>` lieferte für alle sieben
geplanten Suchbegriffe ("reproducibility physiotherapy", "reanalysis rehabilitation",
"multiverse exercise", "reanalysis physiotherapy", "multiverse physiotherapy",
"individual participant data physiotherapy", "computational reproducibility sport")
durchgehend HTTP 502 oder Timeout, auch nach mehreren Wiederholungen über zwei Minuten
verteilt. Ersatz: SHARE-Such-API.

| # | SHARE-Abfrage (`q=`) | Treffer gesamt |
|---|---|---:|
| S1 | `reproducibility physiotherapy` (Freitext, ungebunden) | 50 851 (zu breit, nicht auswertbar; siehe S2/S3) |
| S2 | `title:("reanalysis" OR "re-analysis" OR "multiverse" OR "individual participant data" OR "individual patient data") AND title:(physiotherapy OR rehabilitation OR "exercise science" OR "sports science" OR "sport science" OR "physical therapy")` | 21 |
| S3 | `title:("multiverse" OR "specification curve" OR "computational reproducibility" OR "vibration of effects") AND title:(physiotherapy OR rehabilitation OR "exercise" OR "sports" OR "sport" OR "physical therapy")` | 2 |

S2 und S3 sind auf den Titel beschränkte Abfragen (Elasticsearch `query_string`-Syntax),
weil die reine Freitextsuche (S1) durch das riesige, mit vielen Fremdquellen (Clinical­
Trials.gov, DataCite, CrossRef) angereicherte SHARE-Register nicht mehr sinnvoll von
Hand sichtbar war.

## Geprüfte Kandidaten mit Verdikt

| Titel | Autoren | Jahr | Journal/Quelle | DOI | Verdikt |
|---|---|---|---|---|---|
| Finding Predictive Factors of Stabilization Exercise Adherence in RCTs on Low Back Pain: An Individual Data Reanalysis Using Machine Learning Techniques | Pfeifer AC, Schröder-Pfeifer P, Schiltenwolf M, et al. | 2025 | Arch Phys Med Rehabil | 10.1016/j.apmr.2024.12.015 | Kein Gegenbeispiel. "Preplanned reanalysis" desselben MiSpEx-Netzwerks, das die Originaldaten erhoben hat, keine Datenbeschaffung aus einem öffentlichen Repositorium; Fragestellung sind ML-Prädiktoren der Adhärenz, nicht die publizierte Primäranalyse. |
| Dose-response relationship and effect modifier of stabilisation exercises in nonspecific low back pain: a project-wide individual patient data re-analysis on 1483 intervention participants | Niederer D, Pfeifer AC, Engel T, et al. | 2023 | Pain | 10.1097/j.pain.0000000000002801 | Kein Gegenbeispiel. Gleiches MiSpEx-Netzwerk, projektinterne IPD, nicht aus einem öffentlichen Repositorium bezogen; Dosis-Wirkungs-Frage statt Nachrechnung einer publizierten Primäranalyse. |
| Re-analysis of data from a cluster RCT entitled "health literacy and exercise-focused interventions on clinical measurements in Chinese diabetes patients" | Jamshidi-Naeini Y, Golzarri-Arroyo L, Vorland CJ, Brown AW, Allison DB | 2022 | eClinicalMedicine | 10.1016/j.eclinm.2022.101686 | Kein Gegenbeispiel, aber methodisch am nächsten an unserem Vorgehen: Die Autoren reproduzieren zuerst explizit die publizierten Zahlen, dann rechnen sie mit korrigiertem Modell (LMM statt GEE) neu. Datenquelle ist jedoch direkte, vertrauliche Weitergabe durch die Originalautoren ("collegially shared"), kein öffentliches Repositorium, und das Feld ist Diabetes-Versorgung/Health Literacy, keine Physiotherapie/Reha/Sportwissenschaft im engeren Sinn. |
| Contrary to the Conclusions Stated in the Paper, Only Dry Fat-Free Mass Was Different between Groups upon Reanalysis. Comment on "Intermittent Energy Restriction..." | Peos J, Brown AW, Vorland CJ, Allison DB, Sainsbury A | 2020 | J Funct Morphol Kinesiol | 10.3390/jfmk5040085 | Kein Gegenbeispiel. Individualdaten stammen aus dem Online-Supplement der Originalpublikation (damit öffentlich zugänglich), Feld ist Sportwissenschaft/Krafttraining. Aber: kein Nachrechnen der publizierten Primäranalyse, sondern ein alternatives, korrigiertes Modell (ANCOVA/ITT statt Completers-only-DINS-Vergleich) zur Widerlegung der Schlussfolgerung; als Leserbrief/Comment kein eigenständiger Studienbeitrag, kein Multiverse. |
| Individually randomized trial mislabeled as a cluster-randomized trial. Comment on "Effectiveness of wearable technology to optimize youth soccer players' off-training behaviour..." | Vorland CJ, et al. | 2023 | Sci Med Football | 10.1080/24733938.2023.2190998 | Kein Gegenbeispiel. Kurzer Kommentar zu einem Randomisierungs-/Analysefehler, keine erkennbare Beschaffung von Individualdaten aus einem Repositorium, keine vollständige Nachrechnung der Primäranalyse. |
| Replication concerns in sports and exercise science: a narrative review of selected methodological issues in the field | Mesquida C, Murphy J, Lakens D, Warne J | 2022 | R Soc Open Sci | 10.1098/rsos.220946 | Kein Gegenbeispiel. Narrativer Review, keine eigene Reanalyse. |
| Estimating the Replicability of Sports and Exercise Science Research (inkl. Korrektur 2025-09-11) | Murphy J, Caldwell A, Mesquida C, et al. | 2025 | Sports Med | 10.1007/s40279-025-02201-w | Bereits als Nachbar dokumentiert (README, Stand 2026-08-28). Replikation mit neuen Daten, keine IPD-Reanalyse aus Repositorium. Die Korrektur vom September 2025 ändert daran nichts. |
| Reproducible candidate kinematic-electromyographic waveform markers of post-stroke gait from public multimodal waveform exports | Calabrò RS, Calderone A, Sottile F, et al. | 2026 | Front Med Technol | 10.3389/fmedt.2026.1863908 | Kein Gegenbeispiel. "Secondary analysis" eines öffentlichen Gangdatensatzes, erzeugt aber neue Marker/Metriken statt die publizierte Primäranalyse des Originaldatensatzes nachzurechnen. |
| Computational Reproducibility in Sports Science: A Registered Report Reanalyzing Private Raw Data | Nolte S | Registriert 2026-01-14 | OSF Registries | 10.17605/OSF.IO/VCWP8 | Kein Gegenbeispiel, aber wichtigster neuer Nachbar. Ziel ist exakt die Nachrechnung der publizierten Primäranalysen von 50 Artikeln im Journal of Sports Sciences, mit Bewertung von Korrektheit und Methodenvagheit. Datenquelle ist jedoch ausdrücklich **privat**: Autoren werden gebeten, ihre Rohdaten vertraulich zu teilen, gerade weil "relying only on published data may yield a distorted sample". Noch keine publizierten Ergebnisse (Europe-PMC-Suche nach dem Titel: 0 Treffer, Stand 2026-09-15). |
| Data and Code Availability in Sports Science: A Registered Report | Nolte S, Memmert D, Rein R | Preprint 2026-09-08 | OSF Preprints | 10.31222/osf.io/et5fw_v1 | Kein Gegenbeispiel. Reine Verfügbarkeitsaudit aller Original­artikel in Q1-Sportwissenschaftsjournalen der letzten zehn Jahre (wie Jabouille/Elghzali), keine Reanalyse. Von Bedeutung als Scooping-Signal: dieselbe Gruppe (Köln) baut damit "a resource with all articles that have shared data and/or code for reuse" auf, dessen naheliegende Folgeanwendung eine öffentliche-Repositorium-Reanalyse wäre. |
| Prevalence and predictors of data and code sharing in the medical and health sciences: systematic review with meta-analysis of individual participant data | (OpenAlex-Treffer, nicht Feld-spezifisch) | 2023 | – | – | Kein Gegenbeispiel. "Individual participant data" bezieht sich hier auf die einzelnen ausgewerteten Studien der Meta-Analyse selbst (Anteil mit Data/Code Sharing je Studie als "Beobachtung"), nicht auf klinische Individualdaten; Thema ist die Prävalenz von Data/Code-Sharing allgemein in Medizin, kein physiotherapeutisches Feld. |
| CaReMATCH / ExTraMATCH II / Precision rehabilitation for aphasia (mehrere IPD-Metaanalyse-Protokolle) | diverse | 2018-2023 | OSF/Kardio-Reha/Stroke J | diverse | Kein Gegenbeispiel. Klassische prospektive IPD-Metaanalysen über mehrere Studien hinweg, Individualdaten direkt von den beteiligten Studienteams eingesammelt (nicht aus einem öffentlichen Repositorium gezogen), Zielgröße ist ein gepoolter Metaanalyse-Effekt über Studien, nicht die Nachrechnung einer einzelnen publizierten Primäranalyse. |

## Update zum Scooping-Risiko (Ergänzung zu README, Stand 2026-08-28)

Die Boisgontier/Jabouille-Linie zeigt seit dem 28.08. keine neue Richtung: die jüngsten
Werke sind eine Kinarm-Validierungsstudie (Registered Report, 2026-08-26/09-11) und ein
französischsprachiger Transparenz-Checklisten-Artikel in *Kinésithérapie, la Revue*
(2026-08-01, "Les indicateurs de la science ouverte comme estimation du risque de
pratiques de recherche douteuses en kinésithérapie"). Beides bestätigt die frühere
Einschätzung: Metaforschung auf Artikelebene, kein Methodensprung zu Individualdaten.

Neu und relevanter ist **Simon Nolte** (Deutsche Sporthochschule Köln, mit Daniel
Memmert und Robert Rein). Er verfolgt seit Januar 2026 zwei parallele, sich ergänzende
Projekte: eine feldweite Verfügbarkeitsaudit von Daten und Code in Sportwissenschafts-
Journalen (Preprint 2026-09-08, eine Woche vor diesem Suchdatum) und eine Registered-
Report-Reanalyse der publizierten Primäranalysen von 50 Artikeln im *Journal of Sports
Sciences* (registriert 2026-01-14). Der zweite Punkt ist inhaltlich am nächsten an
diesem Manuskript, verwendet aber bewusst privat und vertraulich von den Autoren
geteilte Rohdaten statt Daten aus einem öffentlichen Repositorium, und deckt
Sportwissenschaft journalweit ab statt Physiotherapie/Reha-Studien mit hinterlegten
Repository-Daten. Kein Multiverse, keine Spezifikationskurve. Sollte Nolte künftig seine
Verfügbarkeitsaudit-Ressource ("Resource mit allen Artikeln, die Daten und/oder Code
geteilt haben") mit einer Reanalyse verknüpfen, wäre das ein direkter Konkurrent. Zum
Suchzeitpunkt existiert dieser Schritt nicht.

## Fazit

Über 19 Europe-PMC-Abfragen, 17 OpenAlex-Abfragen (davon 2 mit `type:preprint`) und 3
SHARE/OSF-Abfragen (nach Ausfall der offiziellen OSF-API) wurde kein publizierter oder
registrierter Beitrag gefunden, der (a) Individualdaten aus einem öffentlichen
Repositorium oder Supplement bezieht, (b) damit die publizierte Primäranalyse einer
physiotherapeutischen, rehabilitativen oder sport-/bewegungswissenschaftlichen Studie
nachrechnet, und (c) das als eigenständiger Studienbeitrag tut. Die Aussage im Manuskript
bleibt nach dieser zweiten, erweiterten Suche haltbar.

Die nächsten Nachbarn sind, in absteigender Nähe: Nolte (2026, registrierte
Reanalyse-Absicht, aber private statt öffentliche Daten), die Jamshidi-Naeini/Allison-
Gruppe (2022, reproduziert zuerst die Originalzahlen, dann korrigierte Reanalyse, aber
außerhalb des Feldes und mit direkt geteilten statt öffentlich abgelegten Daten), die
Vorland/Allison/Peos-"Comment"-Serie (nutzt gelegentlich Supplement-Individualdaten in
sportwissenschaftlichen Journalen, aber als kurze Fehlerkorrektur ohne Nachrechnung der
publizierten Zahl und ohne Multiverse) und die MiSpEx-Netzwerk-Eigenreanalysen (Pfeifer
2025, Niederer 2023: projektinterne IPD, andere Fragestellung). Keiner davon erfüllt
beide Kriterien gleichzeitig im Zielfeld.

**Einschränkung:** Die OSF-Registrierungs-API war am Suchtag nicht erreichbar; der
SHARE-Ersatz deckt zwar denselben Registrierungsbestand ab, aber mit anderer
Relevanzgewichtung. Ein erneuter direkter Abgleich über `filter[title]`, sobald die
API wieder läuft, wird empfohlen, ändert aber angesichts der Deckungsgleichheit der
SHARE-Treffer mit den Europe-PMC/OpenAlex-Ergebnissen das Gesamturteil voraussichtlich
nicht.
