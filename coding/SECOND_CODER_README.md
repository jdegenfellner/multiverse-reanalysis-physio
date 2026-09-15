# Zweitkodierung, Anleitung

Ziel: unabhängige zweite Kodierung der 16 eingeschlossenen Studien, blind zur ersten.

1. `second_coder_form.csv` öffnen. Je Zeile eine Studie, `paper_pdf` ist das Originalpaper,
   `deposit_file` die Datendatei.
2. Nur aus dem Paper (Q1 bis Q4, Q6 bis Q10) und aus der Datendatei (Q5) ausfüllen.
   Nicht in `config/registry.csv` oder `coding/extracted/` schauen.
3. Q5: Welcher Wert der Gruppenvariable im Deposit ist der Kontrollarm? Bei SPSS-Dateien
   die Wertelabels prüfen, sonst Gruppengrössen und Baseline-Mittel mit Tabelle 1 abgleichen.
4. Q6: Nur Variablen, die im Primärmodell als Adjustierungsterme stehen. Baseline-Balance-
   Tests in Tabelle 1 zählen nicht.
5. Wenn etwas nicht entscheidbar ist: `unclear` eintragen und in `notes` begründen.
6. Erst nach Abschluss `first_coder_key_DO_NOT_OPEN_BEFORE_CODING.csv` öffnen und
   Abweichungen besprechen. Ergebnis der Einigung wird in `config/registry.csv` und
   als Kappa je Feld im Paper berichtet.

Richtwert: 10 bis 15 Minuten je Studie.
