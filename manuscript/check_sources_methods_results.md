# Quellenprüfung: Abschnitte 2 (Methods) und 3 (Results)

Geprüft: alle Zitatschlüssel in `manuscript/paper.md`, Abschnitte 2 und 3 (Stand 12.09.2026,
625-Zeilen-Fassung mit Abschnitten 1–5), sowie die davon referenzierte Table 1 in
`manuscript/tables.md`, gegen die Original-PDFs in `literature/` (Zuordnung über
`literature/manifest.csv` und Dateinamen). Textextraktion mit `pdftotext -layout`,
Volltextsuche mit `grep`. Seitenangaben sind, wo möglich, die gedruckten Journal-Seiten.

Legende Befund: **korrekt** = Zuschreibung durch die Quelle wörtlich/inhaltlich gedeckt ·
**ungenau** = Kernaussage teilweise gedeckt, aber verkürzt, einseitig oder als eigene
Interpretation ohne Kennzeichnung dargestellt · **falsch** = Quelle sagt das Gegenteil oder
enthält die Behauptung nicht · **nicht prüfbar** = Aussage betrifft das Manuskript selbst
(z. B. Supplement), nicht die Quelle.

---

## 0. Zusammenfassender Befund vorab

Zwei Probleme ziehen sich durch mehrere Einzelbefunde und sollten vor jeder Einzelkorrektur
behoben werden:

1. **Die Type-E-Definition widerspricht sich selbst.** Abschnitt 2.6 definiert Type E als
   Knoten, "where the options are equivalent with respect to validity, estimand **and
   precision** under randomisation". Damit wäre Präzisionsgleichheit eine
   *Voraussetzung* für Type E. Table 1 (`tables.md`) und die eigentliche Absicht des
   Abschnitts sagen aber das Gegenteil: Die Baseline-Handling-Optionen sind unverzerrt für
   denselben Effekt und **unterscheiden sich in der Präzision** – genau das ist der
   Kernbefund von Van Breukelen (2006) und Vickers & Altman (2001), auf die sich das
   Manuskript beruft. Mit der wörtlichen Fließtext-Definition widerlegen die eigenen
   Zitate die eigene Typ-Klassifikation. Vermutlich ein Formulierungsfehler
   ("validity and estimand, **but not necessarily** precision").
2. **Mehrere Zitatschlüssel in `paper.md` haben keine oder eine falsche Entsprechung in
   `literature/references.bib`** (unabhängig vom Inhalt der PDFs geprüft, siehe Abschnitt 5).
   Das betrifft `Short_2026`, `Twisk_2018`, `White_2011`, `Wasserstein_2019` und `Mandl_2024`.

---

## 1. Abschnitt 2.1 (Design und Transparenz)

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.1: `"should thus all be considered as not pre-registered" [Brodeur_2026, check wording]` | Wörtliches Zitat aus Brodeur et al. 2026 | **korrekt** | "Our re-analyses should thus all be considered as not pre-registered." — Brodeur et al. 2026, Appendix Abschn. 13.1 "Reports", S. 27. Wortgleich. | Markierung `[check wording]` kann entfernt werden; Wortlaut ist exakt bestätigt. |
| §2.1: Begründung "because the implementable checks cannot be known before a replication package is opened" | Als Brodeurs eigene Begründung dargestellt | **ungenau** | Original (S. 27): "…it is very unclear from only reading the original paper what is the range of re-analyses that is feasible. Reproducers had to carefully look at the replication package … to gauge whether specific robustness checks were implementable given data availability." Brodeur nennt aber einen **zweiten** Grund im selben Absatz: "…some teams in both streams did not write a pre-re-analysis plan and virtually all teams that did write one ended up deviating from it." | Der im Manuskript genannte Grund ist einer von zweien bei Brodeur, nicht der einzige. Entweder ergänzen oder als eigene Zusammenfassung kennzeichnen ("Brodeur et al. explain this partly by noting that…" statt "state … because"). |
| §2.1: "The transparency items proposed by van den Akker et al. for secondary data analysis" [Van_den_Akker_2021] | van den Akker et al. böten ein Set an Transparenz-Items für Sekundärdatenanalysen | **korrekt** | Van den Akker et al. 2021 stellen ein 25-Fragen-Präregistrierungstemplate vor; sekundärdatenspezifische Zusatzfragen werden ausdrücklich mit erhöhtem Transparenzbedarf begründet: "…others aim to solve the challenges unique to the preregistration of secondary data analysis, such as the increased need for transparency about the process leading up to the preregistration" (S. 3). | Keine zwingend nötig. Ob Supplement S1 sie tatsächlich abdeckt, ist am Manuskript selbst, nicht an der Quelle, zu prüfen (nicht prüfbar). |

---

## 2. Abschnitt 2.4 (Stage 2: Reproduktionskriterien)

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.4: "Hardwicke et al. used a relative criterion with minor discrepancies below 10% and major discrepancies at or above 10%" [Hardwicke_2021] | Exakte Schwellenwerte | **korrekt** | "Numerical discrepancies were classified as 'minor' (…PE < 10%) or 'major' (PE ≥ 10%)." — Hardwicke et al. 2021, S. 3, Abschn. 2.1 "Design" (PE = percentage error). | Keine. |
| §2.4: "Naudet et al. considered and rejected a 2% threshold" [Naudet_2018] | 2-%-Schwellenwert erwogen und verworfen | **korrekt** | "For the reanalysis we initially planned to consider non-reproducibility as a disagreement … by more than 2% … After reanalysis of a couple of studies we believed that such a definition was sometimes meaningless. … Accordingly, we changed our definition…" — Naudet et al. 2018, S. 3. | Keine. (Naudet ersetzte den Schwellenwert durch eine qualitative Beschreibung, nicht durch eine andere Zahl — das behauptet das Manuskript auch nicht.) |

---

## 3. Abschnitt 2.5 (Data integrity screen)

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.5: "Under correct randomisation these p-values are uniform" [Carlisle_2017] | Uniformität der Baseline-p-Werte unter korrekter Randomisierung | **korrekt** (kleine Einschränkung) | "The distribution of 72,261 baseline means was largely consistent with random sampling, with 5087 trial p values being contained within the 99% confidence interval of the cumulative uniform distribution" (Results, S. 946). Carlisle verweist für die Theorie selbst auf frühere Arbeiten: "The general principles of these methods have been explained elsewhere [2, 3]" (S. 945). | Tragfähig; optional Carlisle et al. 2015 / Pandit 2012 als eigentliche Theoriequelle ergänzen. |
| §2.5: Kombinationsmethode (Stouffer vs. Fisher) — im Manuskript **kein Zitat** an dieser Stelle gesetzt | Zu prüfen: welche Methode nutzt Carlisle tatsächlich? | nicht prüfbar als Fehlzitat (da unzitiert), aber sachlich aufschlussreich | Carlisle nutzt Stouffer's Methode tatsächlich als **primäre** Methode: "I used the sum of the z values (Stouffer's method) as the primary method to combine p values … I also calculated the results of five other methods … sum of log (Fisher's method)…" (Methods, S. 946). | Da im Manuskript korrekt kein Zitat an die Stouffer-Aussage gehängt ist, keine Korrektur nötig. Die Übereinstimmung mit Carlisles eigener Methodenwahl ist bemerkenswert und könnte als Fußnote ergänzt werden. |
| §2.5: "Categorical … variables were excluded from the test" [Bolland_2019] | Bolland begründe Ausschluss kategorialer Variablen | **falsch** | Bolland et al. 2019 behandeln ausschliesslich kontinuierliche Baseline-Variablen (Mittelwert/SD). Volltextsuche nach "categorical/binary/ordinal/discrete" ergab keinen inhaltlichen Treffer. | Zitat für "categorical" entfernen oder anders begründen; auch Carlisle 2017 äussert sich dazu nicht. |
| §2.5: "…heavily rounded variables were excluded from the test" [Bolland_2019] | Bolland begründe Ausschluss stark gerundeter Variablen | **ungenau** | Kernbefund korrekt: "The p-value distributions calculated from rounded summary statistics were not uniform, but expected distributions could be empirically generated" (Abstract, S. 2). Bolland empfiehlt aber nirgends einen **Ausschluss** ("exclude" kommt im Manuskript nicht vor), sondern den Vergleich mit einer empirisch generierten Referenzverteilung: "Distribution of baseline p-values calculated from rounded summary statistics should be compared to empirically generated distributions not the uniform distribution" (S. 3). | Präzisieren: "…excluded from the test as a conservative simplification, since rounded summary statistics are known to distort the reference distribution away from uniform [Bolland_2019], who instead propose comparison against an empirically simulated null." |

---

## 4. Abschnitt 2.6 (Stage 3: zwei Grids) — Typologie Type E/N/U

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.6: "Type E, where the options are equivalent with respect to validity, estimand and precision under randomisation" [Del_Giudice_2021] | Drei genannte Kriterien für Type E | **ungenau** | Original, S. 7: "Type E decisions: principled equivalence. … Alternative measures have comparable validity, alternative analyses examine the same effect, and the parameter of interest is estimated with comparable precision or power." Der Begriff "estimand" kommt im gesamten Paper **0-mal** vor, ebenso "randomi[s/z]ation" **0-mal**. | Die drei Kriterien selbst sind sinngemäss richtig (Validität / derselbe Effekt / Präzision), "estimand" ist eine zulässige Übersetzung, aber kein Del-Giudice/Gangestad-Originalbegriff; "under randomisation" ist eine Ergänzung des Manuskripts. Zusätzlich: **die Aufnahme von "precision" als Gleichheits-Kriterium widerspricht der übrigen Nutzung des Begriffs im Manuskript** (siehe Abschnitt 0 oben) — hier liegt der eigentliche Fehler, nicht bei Del Giudice/Gangestad selbst. |
| §2.6: "Type N, where the options answer different questions" [Del_Giudice_2021] | Definition Type N | **ungenau** | Original, S. 7: "Type N decisions: principled nonequivalence. … alternative specifications are not equivalent, and some are objectively more justified than others as a means of estimating the effect of interest." | "answer different questions" deckt nur eine von drei Nonequivalence-Arten ab (Effekt); Del Giudice/Gangestad zählen auch Mess- und Präzisions-Nonequivalence zu Type N. Präziser: "Type N, where the options are not equivalent and some are better justified than others." |
| §2.6: "Type U, where equivalence is uncertain" [Del_Giudice_2021] | Definition Type U | **korrekt** | S. 7: "Type U decisions: uncertainty. … there are no compelling reasons to expect equivalence or nonequivalence, or there is reason to expect nonequivalence, but insufficient information to specify which alternatives are better justified." | Keine. |
| §2.6: "Type E nodes form the principled grid" (implizit Del_Giudice_2021) | Gleichsetzung Type E = "principled" | korrekt, mit Einschränkung | Del Giudice/Gangestad verwenden "principled multiverse-style analyses" selbst (S. 11), wenden dort aber auch Type-N/-U-Logik an (N reduziert auf beste Option, U in separate explorative Multiversen aufgeteilt) — im Resultat variiert dort tatsächlich nur Type E. | Vertretbare Interpretation, aber keine wörtliche DG&G-Aussage; ggf. als eigene Konvention kennzeichnen. |
| §2.6: "the defensible grid, in the sense of Short et al.: every option is used in the literature and can be justified on its own, without the requirement of equivalence" [Short_2026] | Definition "defensible" | **ungenau** | Short et al., S. 6–7: "Defensibility concerns whether a given analytical pipeline can be justified independently…"; Glossar S. 17: "Defensible: An option or pipeline can be considered defensible if it is rationally justifiable … guided by domain knowledge, accepted methodological approaches, theory, application in recent peer-reviewed literature, or empirical assessment." | "used in the literature" ist nur eine von mehreren Rechtfertigungsgrundlagen bei Short (neben Theorie, Fachwissen, Methodenstandard, empirischer Prüfung) – nicht die Definition selbst. Zudem ist "defensible grid = Type E ∪ Type N" eine Konstruktion des Manuskripts: bei Short geht Defensibilität der E/N/U-Prüfung voraus (auch Type-U-Pipelines sind bereits "defensible"); dass im Manuskript nur E+N übrigbleiben, liegt am eigenen Ausschluss aller Type-U-Knoten, nicht an Shorts Definition. Präzisieren, z. B.: "…can be justified independently (e.g. by precedent in the literature, theory, or expert consensus), without the requirement of equivalence", plus Hinweis, dass Type-U-Knoten separat ausgeschlossen wurden. |
| §2.6/§2.7 (implizit): Ursprung des Gegensatzes "principled vs. defensible" | An Short_2026 zugeschrieben | **korrekt** | Short et al. formulieren den Gegensatz tatsächlich selbst (S. 6–7) und schreiben "principled" ausdrücklich Del Giudice & Gangestad zu (S. 9: "…refine the defensible multiverse into a principled multiverse (Del Giudice & Gangestad, 2021)"). "Defensible" kommt bei Del Giudice/Gangestad **0-mal** vor. | Keine. Die Zitatverteilung (Typologie → Del_Giudice_2021, "defensible" → Short_2026) ist korrekt. |

---

## 5. Abschnitt 2.6 — Baseline-Handling (Type-E-Knoten)

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.6, Fliesstext: Baseline-Handling-Knoten [Vickers_2001; Senn_2006; Van_Breukelen_2006; Twisk_2018] | Alle vier stützen: Follow-up/Change-Score/ANCOVA unverzerrt für denselben Effekt unter Randomisierung, unterscheiden sich nur in Präzision | **ungenau bis falsch, je nach Quelle** (Details unten) | siehe Einzelzeilen | siehe Einzelzeilen |
| … Vickers & Altman 2001 | s. o. | **ungenau** | "If, by chance, baseline scores are worse in the treatment group, the treatment effect will be underestimated by a follow up score analysis and over-estimated by looking at change scores (because of regression to the mean). By contrast, analysis of covariance gives the same answer whether or not there is baseline imbalance" (S. 1123). Präzisionsvorteil ANCOVA quantifiziert (85 vs. 68 vs. 54 Patienten bei r=0.6, S. 1123–1124). | Vickers & Altman behandeln Follow-up/Change-Score nur bei **exakter** Baseline-Balance als äquivalent zu ANCOVA; bei zufälliger Imbalance sehen sie eine **bedingte Verzerrung**, nicht nur einen Präzisionsverlust. Fußnote ergänzen. |
| … Senn 2006 | s. o. | **ungenau, tendenziell falsch** | Follow-up-Wert allein kommt im Paper **nicht vor**. Zu Change-Score/ANCOVA: "…where an RCT has been run ANCOVA is a superior choice of analysis to SACS and will at least deal with accidental bias, whereas SACS will not" (S. 4343). Eine Äquivalenz-Passage existiert ("over all randomizations", S. 4336), aber Senns eigene Schlussfolgerung bevorzugt ANCOVA aus Validitäts-, nicht nur Effizienzgründen. | Zitat auf den Change-Score/ANCOVA-Vergleich beschränken (Follow-up-Wert nicht durch Senn gedeckt); ergänzen, dass Senn ANCOVA auch aus Robustheitsgründen bevorzugt. |
| … Van Breukelen 2006 | s. o. | **korrekt** | Abstract/Diskussion: "In randomized studies both methods are unbiased, but ANCOVA has more power" (S. 920, 925). Im Regressionsrahmen mit b2=0 (Follow-up), b2=1 (Change), optimalem b2 (ANCOVA): "any value of b2 … gives the same b1 (=D) apart from sampling error … So ANCOVA gives the largest power and the smallest confidence interval" (S. 922). | Keine; einzige Quelle, die alle drei Varianten explizit und sauber abdeckt. |
| … Twisk et al. 2018 | s. o. | **falsch** | "A proper adjustment is not achieved by performing a regular repeated measures analysis (method 2) or by the regular analysis of changes (method 3). It is advised to use either a longitudinal analysis of covariance (method 1) or a repeated measures analysis without the treatment variable…" (S. 85, Conclusion). Baseline wird explizit als Confounder behandelt: "…even a small difference in baseline value … can have a (strong) confounding effect" (S. 83). | Twisk widerspricht der Äquivalenzaussage direkt und rät auch **innerhalb von RCTs** von Follow-up- und Change-Score-Analyse ab. Zitat an dieser Stelle entfernen oder umformulieren (z. B. als Beleg für "ANCOVA wird in der Praxis empfohlen", nicht für Äquivalenz). |
| **Tables.md Table 1**, Zeile "Baseline handling": "Under randomisation all three are unbiased for the same mean difference and differ in precision [Vickers_2001; Senn_2006; Van_Breukelen_2006]" | Dieselbe Kernaussage, aber ohne Twisk_2018 | **ungenau** (Van Breukelen korrekt; Vickers teilweise/bedingt; Senn deckt "all three" nicht) | s. Einzelzeilen oben. Van Breukelen deckt die Formel fast wörtlich; Senn erwähnt Follow-up-Wert gar nicht. | Auf Van_Breukelen_2006 (Hauptbeleg) und Vickers_2001 (Präzisionsteil, mit Einschränkung) stützen; Senn_2006 präzisieren oder streichen. |
| **Inkonsistenz paper.md vs. tables.md** | Fliesstext (§2.6, Z. 232–234) zitiert 4 Quellen inkl. Twisk_2018; Table 1 (Z. 7) zitiert nur 3, ohne Twisk_2018 | **Inkonsistenz bestätigt** | paper.md: "[Vickers_2001; Senn_2006; Van_Breukelen_2006; Twisk_2018]"; tables.md: "[Vickers_2001; Senn_2006; Van_Breukelen_2006]". Twisk_2018 wird sonst nirgends in paper.md zitiert. | Angleichen. Da Twisk 2018 der Äquivalenzaussage inhaltlich widerspricht, ist die Tabellenversion (ohne Twisk) die vorzugswürdige; Twisk_2018 im Fliesstext an dieser Stelle streichen. |

---

## 6. Abschnitt 2.6 — Covariate Set (Type-E-Knoten)

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.6, Fliesstext: "the covariate set (none, the stratification factors, or the published set)" [Kahan_2014; Kahan_2012] | Beleg für die drei Optionen, insb. Stratifizierungsfaktoren | **ungenau** | Kahan 2014, S. 3: "it is essential that stratification factors be accounted for in the trial analysis." Kahan & Morris 2012, Conclusion S. 1/5: "Trialists should adjust their primary analysis for balancing factors to obtain correct P values and confidence intervals and to avoid an unnecessary loss in power." | Starker Beleg für die Option "Stratifizierungsfaktoren"; beide Quellen argumentieren aber, dass **Weglassen zu falschen SE/CI/P-Werten führt**, nicht bloss zu einer gleichwertigen Alternative – das steht in Spannung zur Type-E-"equivalent"-Einordnung (vgl. Abschnitt 0). Type-E-Klassifikation dieses Knotens begründen oder einschränken. |
| **tables.md** Table 1, Zeile "Covariate set": "Adjustment is an efficiency choice, not a confounding correction, for a continuous outcome in a linear model" [Kahan_2014; Kahan_2012] | Adjustierung als reine Effizienzfrage, ausdrücklich keine Confounding-Korrektur | **ungenau** (nicht wörtlich gedeckt) | Volltextsuche: "efficiency"/"efficient" kommt in Kahan 2014 **0-mal** vor, "confound…" **0-mal**. In Kahan & Morris 2012 kommt "confounding" **1-mal** vor, aber in unabhängigem Kontext (andere, nicht-randomisierte Studie), nicht zur RCT-Kovariatenadjustierung. | Eigene Interpretation der Autoren, keine Quellenaussage. Entweder als eigene Einordnung kennzeichnen (nicht als Zitat) oder eine Quelle ergänzen, die diese Terminologie tatsächlich nutzt. Inhaltlicher Kern (Adjustierung wirkt über SE/Power, nicht über Bias) ist mit Kahan 2014 als Simulationsbefund konsistent, nur nicht so formuliert. |

---

## 7. Abschnitt 2.6 — Missing-Data-Strategie (Type-N-Knoten), inkl. LOCF

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.6, Fliesstext: "…20 imputations, Rubin's rules…" [White_2011] | Faustregel für Anzahl Imputationen | **korrekt** (Methodik gedeckt; Zahl 20 nicht als Regel im Fliesstext hergeleitet) | White, Royston & Wood, S. 388, Abschn. 7.3 "A rule of thumb": **"we require about m⩾100× FMI."** Bodner-Näherung ebenda: "m should be at least equal to the percentage of incomplete cases … For the UK700 analysis … 17 per cent … hence this rule would suggest m = 20." | Regel ist wörtlich **m ≥ 100 × FMI** (bzw. m ≈ % unvollständiger Fälle). Die im Grid fest gewählten 20 Imputationen könnten explizit mit dieser Regel begründet werden, falls die tatsächlichen FMI/Missing-Anteile der 21 Studien das hergeben. |
| §2.6, Fliesstext: "…last observation carried forward where a baseline exists" [White_2011; ICH_2019_E9R1; Kahan_2024] | ICH E9(R1) und Kahan 2024 als Mitbeleg für LOCF | **falsch** | ICH E9(R1): "last observation carried forward", "LOCF", "carried forward", "imputation" — je **0 Treffer** im gesamten 22-Seiten-Dokument. Kahan 2024: "LOCF"/"carried forward" — **0 Treffer**. | ICH_2019_E9R1 und Kahan_2024 nicht als LOCF-Beleg zitieren; White_2011 allein genügt für die MI-Methodik, LOCF selbst ist in keiner der drei Quellen belegt. Als allgemeiner Beleg für "Missing-Data-Handhabung muss zur Estimand-Strategie passen" eignet sich ICH E9(R1) S. 15f.: "Handling of missing data should be based on … the strategies employed in the description of the estimand." |
| **tables.md** Table 1, Zeile "Missing data and analysis population": "Different estimands under ICH E9(R1): treatment policy with imputation versus completers [ICH_2019_E9R1; Kahan_2024]; last observation carried forward is deprecated but used" | 1:1-Zuordnung "treatment policy = Imputation" vs. "completers = andere Strategie"; LOCF als "deprecated" | **falsch** | ICH E9(R1): "imputation", "complete case", "completer", "deprecat…" — je **0 Treffer**. Kahan 2024: "deprecat…", "complete case/completer" — je **0 Treffer**; "multiple imputation" wird genannt, aber Table 5 (S. 8) ordnet sie explizit der **hypothetical**-Strategie zu ("…use a method (eg, inverse probability weighting, multiple imputation, or likelihood based analyses)"), während treatment policy definiert ist als "Estimated by including participant outcomes in the analysis regardless of the occurrence of the intercurrent event" — also **ohne** Imputation. | Diese Tabellenzeile **kehrt die tatsächliche Zuordnung um** und erfindet einen nicht auffindbaren Beleg ("deprecated"). Zeile grundlegend umformulieren, z. B.: "Different estimands: complete-case analysis approximates a while-on-treatment/hypothetical estimand, multiple imputation under MAR approximates a hypothetical estimand [Kahan_2024, Table 5]; treatment policy is typically estimated without imputation, by including all observed outcomes regardless of intercurrent events [ICH_2019_E9R1, Kahan_2024]." |
| Zusatzbefund (Prüfpunkt 13, nicht an dieser Stelle zitiert, aber für Gesamtbild relevant): Gegenüberstellung treatment policy vs. andere Estimand-Strategien | — | **korrekt/gut belegt** (wo tatsächlich zitiert) | ICH E9(R1), S. 10–13, Abschn. A.3.2, mit eigenen Unterabschnitten "Treatment policy strategy", "Hypothetical strategies", "Composite variable strategies", "While on treatment strategies", "Principal stratum strategies". Kahan 2024, Table 4 (S. 7): "Strategies to handle intercurrent events in the estimand definition" mit denselben fünf Strategien. | Beide Quellen taugen sehr gut als Beleg für die Estimand-Strategien-Typologie allgemein — nur nicht für die spezifische (und falsche) LOCF/Imputations-Zuordnung in tables.md. |

---

## 8. Abschnitt 2.7 (Summary measures)

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §2.7: "the s-value, the base-2 logarithm of the p-value" [Rafi_2020] | s-Wert = log2(p) (ohne Vorzeichen) | **ungenau** | Rafi & Greenland 2020, Abstract S. 1: "…the binary surprisal or S-value s = −log2(p)". Haupttext S. 4: "…negative base-2 logarithm of the P-value, s = log2(1/p) = −log2(p)…". log2(p) ist für p<1 negativ, der S-Wert per Definition ≥ 0. | "…the s-value, the **negative** base-2 logarithm of the p-value…" (Wort "negative"/"minus" ergänzen). |
| §2.7: "caps the s-value of permutation specifications at 12.3 bits" | Rechnerische Plausibilität (keine Quellenfrage) | **korrekt** | Eigene Nachrechnung nach Rafi/Greenland-Formel: −log2(1/5000) = log2(5000) ≈ 12.29 → gerundet 12.3 bit. | Keine. |
| §2.7: "…continuous measure of evidence [Rafi_2020; Greenland_2016]" | Greenland 2016 als Mitbeleg für S-Wert-Definition | **ungenau** | Greenland et al. 2016 enthält an keiner Stelle "S-value", "surprisal", "Shannon" oder "log2" (vollständige Negativsuche). Stützt nur allgemein p-Werte als Kompatibilitätsmass: "One approach is to focus on P values as continuous measures of compatibility, as described earlier" (S. 346). | Zuschreibung trennen: z. B. "…the s-value…[Rafi_2020], in the spirit of treating p-values as a continuous rather than dichotomised measure [Greenland_2016]" — Greenland_2016 nicht als Beleg für die S-Wert-Definition selbst führen. |
| §2.7: "…not report … as a primary measure [Wasserstein_2016; Wasserstein_2019]" | Beide Quellen als gleichrangiger Beleg für "don't say statistically significant" | teils **korrekt**, teils **ungenau** | Wasserstein, Schirm & Lazar 2019, S. 2, Abschn. "Don't Say 'Statistically Significant'": "…it is time to stop using the term 'statistically significant' entirely. … 'statistically significant'—don't say it and don't use it." Wasserstein & Lazar 2016 (ASA-Statement) enthält diese explizite Forderung **nicht**; nächstliegend Principle 3, S. 131: "Practices that reduce data analysis … to mechanical 'bright-line' rules (such as 'p<0.05') … can lead to erroneous beliefs and poor decision making." 2019 stellt selbst klar: "The ASA Statement … stopped just short of recommending that declarations of 'statistical significance' be abandoned. We take that step here" (S. 2). | Die explizite "don't say significant"-Forderung primär [Wasserstein_2019] zuschreiben; [Wasserstein_2016] separat für die allgemeinere Kritik an Bright-Line-Schwellen (Principle 3) führen, nicht als gleichrangigen Beleg für denselben Satz. |
| §2.7: "Pooled estimation over specifications" [Bartos_2025_arXiv] | Gepoolte Schätzung über Spezifikationen | **korrekt** | Titel: "Single-Dataset Meta-Analysis for Many-Analysts and Multiverse Studies". Abstract S. 1: "…a weighted-likelihood approach … yields meta-analytic point and interval estimates of the average effect across analytic approaches…". | Keine. |
| §2.7: "multiplicity control over specifications" [Mandl_2024] | Multiplizitätskontrolle über Spezifikationen | **korrekt** | Titel: "Addressing researcher degrees of freedom through minP adjustment". Abstract S. 1: "…we address this issue by formalizing the multiplicity of analysis strategies as a multiple testing problem … we propose using the 'minP' adjustment method…". | Keine. |

---

## 9. Abschnitt 3.2 (Reproduction)

| Stelle im Text | Zuschreibung | Befund | Beleg (wörtliches Zitat, Seite) | Korrekturvorschlag |
|---|---|---|---|---|
| §3.2: "Counting every study with a repository link as the denominator, as Naudet et al. did, the published primary estimate was recovered in 12 of 152 (8%)…" [Naudet_2018] | Naudet habe seine Reproduktionsrate mit dem weiten Nenner ("jede Studie mit Repository-Link") berichtet | **falsch** | Naudets weiter Nenner (37 RCTs) war jede unter der Data-Sharing-Pflicht eingereichte RCT, nicht "jede Studie mit Repository-Link" — von 19 datenteilenden Studien nutzten nur 5 ein offenes Repository, 10 wurden per E-Mail verschickt (S. 4–5). Entscheidend: Naudets **Haupt-Reproduktionszahl** nutzt den **engen** Nenner: "Among the 17 studies … providing sufficient data for reanalysis of their primary outcomes, 14 (82%, 95% CI 59% to 94%) studies were fully reproduced" (S. 5). Eine Reproduktionsrate mit 37 im Nenner berichten Naudet et al. nirgends als "recovery"-Kennzahl (die 46%-Zahl mit Nenner 37 misst Data-Availability, nicht Reproduktion). | Die Analogie kehrt Naudets tatsächliche Wahl um. Vorschlag: entweder den Naudet-Verweis aus diesem Satz entfernen, oder präzisieren: "…as Naudet et al. did when reporting their overall data-availability rate (46% of 37 eligible trials), as opposed to their 82% reproduction rate among the 17 trials with usable data…". |

---

## 10. Zusatzbefund: Zitatschlüssel ohne (oder mit falscher) Entsprechung in `references.bib`

Unabhängig vom Inhalt der PDFs geprüft (Abgleich `paper.md`-Zitatschlüssel gegen
`literature/references.bib`-Einträge). Dies betrifft das Rendern der Zitate, nicht die
inhaltliche Richtigkeit der bisherigen Befunde.

| Im Manuskript zitierter Schlüssel | Zustand in `references.bib` | Befund | Korrekturvorschlag |
|---|---|---|---|
| `Short_2026` | Kein Eintrag; nur `Short_2025` vorhanden — **anderes Paper** ("The Systematic Multiverse Analysis Registration Tool", 2025, nicht "Multicurious" 2026, Datei `07_Short_2026_Multicurious-published.pdf`) | **falsch/fehlend** | Neuen bib-Eintrag `Short_2026` für das Multicurious-Paper (Short et al. 2026) anlegen. |
| `Twisk_2018` | Kein Eintrag unter diesem Schlüssel; der tatsächliche Eintrag für dasselbe Paper trägt den (durch Autoren-Parsing verunglückten) Schlüssel `J_2018` | **falsch/fehlend** | bib-Schlüssel auf `Twisk_2018` umbenennen (oder alle Vorkommen im Manuskript auf `J_2018` ändern). |
| `White_2011` | Kein Eintrag unter diesem Schlüssel; vorhanden ist `White_2010` (Jahr im bib-Eintrag: 2010) | **falsch/fehlend** | Journal-Zitierweise ist "Statist. Med. 2011, 30 377–399" (Epub 2010, Druckausgabe 2011); Schlüssel und Jahr im bib-Eintrag auf `White_2011`/2011 vereinheitlichen. |
| `Wasserstein_2019` | Kein Eintrag; nur `Wasserstein_2016` vorhanden | **fehlend** | Neuen bib-Eintrag für Wasserstein, Schirm & Lazar 2019 ("Moving to a World Beyond p<0.05", Datei `00_...pdf`) anlegen. |
| `Mandl_2024` | Kein Eintrag | **fehlend** | Neuen bib-Eintrag für Mandl et al. 2024 (Datei `04_Mandl_2024_minP-Multiverse-Inference.pdf`) anlegen. |

---

## 11. Kurzbericht

**Geprüft:** alle 22 Zitatschlüssel in Abschnitt 2 und 3 von `paper.md` (plus die davon
referenzierte Table 1 in `tables.md`), gegen die zugehörigen PDFs in `literature/`; insgesamt
rund 35 Einzelzuschreibungen.

**Korrekt (ohne oder mit nur kosmetischem Korrekturbedarf):** das Brodeur-Zitat selbst
(wortgleich, S. 27), Hardwicke 2021 (10-%-Schwelle, wortgleich), Naudet 2018 (2-%-Schwelle
erwogen/verworfen), van den Akker 2021 (Transparenz-Items), Carlisle 2017 (Uniformität der
Baseline-p-Werte), Del Giudice & Gangestad Type U, die Zuordnung "principled" zu Del Giudice/
Gangestad bzw. "defensible" zu Short, Van Breukelen 2006 (einzige Quelle, die die
Baseline-Handling-Äquivalenz sauber für alle drei Varianten trägt), Short 2026 zur "illusion
of consistency", White 2011 (m ≥ 100 × FMI, wortgleich), Wasserstein 2019 ("don't say it and
don't use it", wortgleich), Bartos 2025 und Mandl 2024 (Pooling bzw. Multiplizitätskontrolle).

**Zu ändern — inhaltlich, nach Dringlichkeit:**
1. **§3.2, Naudet-Nenner-Aussage ist falsch** und sollte umgeschrieben oder gestrichen
   werden: Naudets eigentliche Reproduktionsrate (82 %) nutzt den engen, nicht den weiten
   Nenner — das Gegenteil dessen, was der Satz suggeriert.
2. **Table 1, Missing-Data-Zeile (ICH E9(R1)/Kahan 2024, LOCF "deprecated")** ist falsch und
   kehrt die tatsächliche Estimand-Zuordnung um (Multiple Imputation gehört laut Kahan 2024
   zur hypothetical-, nicht zur treatment-policy-Strategie); "deprecated" ist in keiner der
   beiden Quellen belegt.
3. **§2.6-Baseline-Handling: Twisk 2018 widerspricht der Äquivalenzaussage** und sollte an
   dieser Stelle gestrichen werden (die Version ohne Twisk in Table 1 ist die richtige); Senn
   2006 nur mit Einschränkung führen (Follow-up-Wert dort nicht behandelt).
4. **Type-E-Definition in §2.6 widerspricht sich selbst** ("equivalent … precision" statt
   "differ in precision") — das betrifft indirekt jede Type-E-Zuschreibung im Grid.
5. **Bolland 2019 stützt keinen Ausschluss kategorialer Variablen** (falsch) und empfiehlt für
   gerundete Variablen einen empirischen Vergleich statt Ausschluss (ungenau).
6. **Table 1, Covariate-Zeile ("efficiency choice, not a confounding correction")** ist nicht
   wörtlich durch Kahan 2014/2012 gedeckt — beide Begriffe kommen dort nicht in diesem Sinn vor.
7. **s-Wert-Definition in §2.7 fehlt das Minuszeichen** ("negative base-2 logarithm"), und
   Greenland 2016 sollte nicht als Mitbeleg für die S-Wert-Definition selbst stehen.
8. Wasserstein 2016 als gleichrangiger Mitbeleg für "don't say statistically significant" ist
   ungenau — die explizite Forderung stammt erst von 2019.
9. Del Giudice & Gangestads Type-N-Definition ist im Manuskript zu eng gefasst.

**Formal, unabhängig vom Inhalt:** fünf Zitatschlüssel (`Short_2026`, `Twisk_2018`,
`White_2011`, `Wasserstein_2019`, `Mandl_2024`) fehlen in `references.bib` oder sind dort
unter einem anderen Schlüssel/Jahr abgelegt — das bricht das Zitieren beim Rendern und sollte
vor der nächsten Kompilierung behoben werden.

Vollständige Belege mit Seitenangaben in den Tabellen oben.
