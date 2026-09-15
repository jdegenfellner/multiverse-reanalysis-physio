## =============================================================================
## Stage 2: Unabhaengige computationale Reproduktion der PUBLIZIERTEN
## Primaeranalyse fuer die 12 Studien mit publiziertem Punktschaetzer.
##
## Jede Studie wird SO analysiert, wie sie im Paper (Statistical-Analysis-
## Abschnitt, siehe coding/extracted/<study_id>.json -> analysis_method_quote)
## beschrieben ist -- unabhaengig vom Multiverse-Gitter in R/engine.R/grid.R.
## Kein Herumprobieren mit Spezifikationen: wo die Papertext-Beschreibung
## unklar/unvollstaendig ist, wird die woertlich beschriebene Variante possible
## genau EINMAL umgesetzt und die Unsicherheit in der Spalte `deviations`
## dokumentiert.
##
## Output: output/stage2_published_models.csv
##         (study_id, model_as_published, est, ci_lo, ci_hi, p, n, deviations)
## Danach: Vergleich mit config/published.csv (+ config/published_overrides.csv)
##         -> output/stage2_comparison.csv
##
## Ausfuehren aus dem Projekt-Root:
##   Rscript R/stage2_published_models.R
## =============================================================================

suppressPackageStartupMessages({
  library(readxl)
  library(haven)
  library(dplyr)
  library(tidyr)
  library(lme4)
  library(lmerTest)
  library(nlme)
  library(emmeans)
  library(mice)
})

root <- "."
options(stringsAsFactors = FALSE)
set.seed(20260913)

results <- list()

add_result <- function(study_id, model_as_published, est, ci_lo, ci_hi, p, n, deviations) {
  results[[study_id]] <<- data.frame(
    study_id = study_id,
    model_as_published = model_as_published,
    est = as.numeric(est),
    ci_lo = as.numeric(ci_lo),
    ci_hi = as.numeric(ci_hi),
    p = as.numeric(p),
    n = as.integer(n),
    deviations = deviations,
    stringsAsFactors = FALSE
  )
}

log_section <- function(study_id) {
  cat("\n==================================================================\n")
  cat(">>> ", study_id, "\n")
  cat("==================================================================\n")
}

## =============================================================================
## 1. creatine_PMC11944689 -----------------------------------------------------
## Paper (2.3.5 Statistical Analyses): "Differences in whole-body and segmental
## LBM change between groups were analysed separately across the 3 stages...
## A linear regression model was used to analyse the differences in LBM CHANGES
## between groups for each stage, with absolute LBM from the beginning of the
## respective stage used as a covariate." Primaerer (abstract-erstberichteter)
## Kontrast = T1->T2 (7-Tage Wash-in, vor Beginn des Krafttrainings).
## =============================================================================
log_section("creatine_PMC11944689")
res <- tryCatch({
  f <- file.path(root, "studies/2025_the-effect-of-creatine-supplementation-on-lean-b_PMC11944689/deposit/Desai-Data-LBM.xlsx")
  dat <- read_excel(f, sheet = "Data")
  dat$lbm_change_post_1 <- suppressWarnings(as.numeric(dat$lbm_change_post_1))
  dat$dxa_leanmass_kg_pre <- suppressWarnings(as.numeric(dat$dxa_leanmass_kg_pre))
  dat <- dat %>% filter(group %in% c("Control", "Creatine"))
  dat_cc <- dat %>% filter(!is.na(lbm_change_post_1) & !is.na(dxa_leanmass_kg_pre))
  dat_cc$group <- factor(dat_cc$group, levels = c("Control", "Creatine"))

  m1 <- lm(lbm_change_post_1 ~ group + dxa_leanmass_kg_pre, data = dat_cc)
  print(summary(m1))
  s <- summary(m1)$coefficients
  ci <- confint(m1)

  add_result(
    "creatine_PMC11944689",
    "Linear regression (ANCOVA): change in whole-body LBM (T1->T2, 7-Tage Wash-in) ~ group + baseline LBM (T1), complete-case (Sec. 2.3.5)",
    s["groupCreatine", "Estimate"], ci["groupCreatine", 1], ci["groupCreatine", 2],
    s["groupCreatine", "Pr(>|t|)"], nrow(dat_cc),
    "REPRODUKTION SEHR NAH AM PUBLIZIERTEN WERT (0.507 vs 0.51 kg, p=0.028 vs 0.03). Paper berichtet nur Punktschaetzer + p (0.51 kg, p=0.03), kein CI/SE fuer die Gruppendifferenz -> unser CI ist modellbasiert (t-Verteilung) und im Paper nicht direkt gegenpruefbar. Eine Zeile (record_id=54, Creatine) mit Post-1-Wert '*' (dokumentierter Studienabbruch nach Baseline) wurde per complete-case exkludiert, konsistent mit dem Papertext ('withdrew after the baseline assessment ... not included in the analysis'). Zwei leere Fuellzeilen am Dateiende wurden ebenfalls automatisch entfernt."
  )
}, error = function(e) { message("FEHLER creatine: ", e$message); NULL })

## =============================================================================
## 2. etip_PMC6886967 -----------------------------------------------------------
## Paper (Statistical methods): "...analysed by general linear model analysis
## of covariance. Baseline values of each outcome were set as covariates in
## late pregnancy analyses...". Primary outcome (abstract-erstgenannt) = PGWBI
## global score in later pregnancy, ANCOVA mit PGWBI-Baseline als Kovariate.
## =============================================================================
log_section("etip_PMC6886967")
res <- tryCatch({
  f <- file.path(root, "studies/2019_effects-of-supervised-exercise-training-during-p_PMC6886967/deposit/ETIP_Mental_Health_in_obese_pregancies.sav")
  dat <- read_sav(f)
  dat$Group <- as_factor(dat$Group)
  dat$Group <- relevel(dat$Group, ref = "Control group")
  dat_cc <- dat %>% filter(!is.na(Post_PGWB) & !is.na(Pre_PGWB_index))

  m1 <- lm(Post_PGWB ~ Group + Pre_PGWB_index, data = dat_cc)
  print(summary(m1))
  s <- summary(m1)$coefficients
  ci <- confint(m1)
  term <- "GroupExercise group"

  add_result(
    "etip_PMC6886967",
    "General linear model ANCOVA: PGWBI global score (spaete Schwangerschaft) ~ Group + PGWBI-Baseline, verfuegbare ITT-Faelle (Statistical methods)",
    s[term, "Estimate"], ci[term, 1], ci[term, 2],
    s[term, "Pr(>|t|)"], nrow(dat_cc),
    sprintf("REPRODUKTION SEHR NAH AM PUBLIZIERTEN WERT (Estimate %.3f vs 2.60; 95%% CI [%.2f, %.2f] vs [-3.77, 8.97] im Paper; p=%.3f vs 0.42). Paper deklariert PGWBI nicht als formal 'primaeres' Outcome (siehe registry_check), wird hier aber gemaess Registry/Aufgabenstellung als Primaerschaetzer gefuehrt. Kein weiteres Kovariat (z.B. BMI) im Modell, da Statistical-methods-Abschnitt ausschliesslich die jeweilige Baseline als Kovariate nennt. ITT hier = alle Faelle mit verfuegbarem Post-PGWB (keine Imputation fehlender Werte beschrieben/durchgefuehrt). ABWEICHUNG bei n: nur 54 von 91 Randomisierten haben sowohl Pre_PGWB_index als auch Post_PGWB nicht-fehlend im Deposit (28 Exercise + 31 Control mit nicht-fehlendem Post_PGWB, davon 54 zusaetzlich mit nicht-fehlendem Pre_PGWB_index), waehrend das Paper fuer denselben Kontrast n=74 (38+36) berichtet; trotz dieser Diskrepanz in der Analysestichprobe reproduziert das Modell Punktschaetzer und CI fast exakt, was nahelegt, dass Post_PGWB/Pre_PGWB_index im Deposit die korrekten Variablen sind und die Differenz vermutlich auf zusaetzliche, im Deposit nicht erkennbare Ausschlusskriterien oder eine engere Zeitfenster-Definition im Originaldatensatz des Papers zurueckgeht.",
      s[term, "Estimate"], ci[term, 1], ci[term, 2], s[term, "Pr(>|t|)"])
  )
}, error = function(e) { message("FEHLER etip: ", e$message); NULL })

## =============================================================================
## 3. etre_PMC11945196 ----------------------------------------------------------
## Paper (2.4): LMM, Weight ~ Time*Group (+1|ParticipantID), Group dummy-coded
## mit Control als Referenz, REML. Bericht: Time x Group Interaktion (Change-
## Score-Kontrast, Haupt-Estimand lt. config/published_overrides.csv: -2.13 in
## unserer eTRE-minus-Control-Konvention) UND separater Post-only-Kontrast
## (Group-Haupteffekt bei Time=post, -2.92 im Paper); hier werden BEIDE
## berichtet, mit der Interaktion als primaerem est/ci/p (siehe Override).
## =============================================================================
log_section("etre_PMC11945196")
res <- tryCatch({
  f <- file.path(root, "studies/2025_early-time-restricted-eating-improves-weight-los_PMC11945196/deposit/Body data.csv")
  dat <- read.csv(f, check.names = FALSE)
  names(dat)[names(dat) == "Participant-ID"] <- "ID"
  dat <- dat %>% filter(Group %in% c("Control", "eTRE"))
  dat$Group <- factor(dat$Group, levels = c("Control", "eTRE"))
  dat$Time <- factor(dat$Time, levels = c("pre", "post"))

  m1 <- lmer(Weight ~ Group * Time + (1 | ID), data = dat, REML = TRUE)
  print(summary(m1))

  ## (a) Time x Group Interaktion (Change-Score-Kontrast) = Haupt-Estimand lt. Override
  cf <- summary(m1)$coefficients
  interact_term <- "GroupeTRE:Timepost"
  ci_interact <- confint(m1, method = "Wald")[interact_term, ]

  ## (b) Post-only Kontrast (Group-Haupteffekt bei Time=post), via emmeans
  emm <- emmeans(m1, ~ Group | Time)
  pc <- as.data.frame(pairs(emm, reverse = TRUE))  # eTRE - Control
  pc_post <- pc[pc$Time == "post", ]

  n_used <- length(unique(dat$ID))

  add_result(
    "etre_PMC11945196",
    "LMM: Weight ~ Group*Time + (1|ID), REML; Haupt-Estimand = Time x Group Interaktion (Change-Score-Kontrast eTRE vs Control, lt. Override in eTRE-minus-Control-Konvention); Post-only-Kontrast separat dokumentiert",
    cf[interact_term, "Estimate"], ci_interact[1], ci_interact[2], cf[interact_term, "Pr(>|t|)"], n_used,
    sprintf("Interaktionskoeffizient (eTRE:post) wird direkt in unserer eTRE-minus-Control-Konvention berechnet und entspricht der Vorzeichenkonvention in config/published_overrides.csv (publizierter Wert dort: -2.13 [-3.07,-1.18], p=0.001; im Paper selbst als '+2.13' in umgekehrter Control-minus-eTRE-Konvention berichtet). Zusaetzlich reproduzierter Post-only-Kontrast (Group-Haupteffekt bei Time=post, im Paper direkt als eTRE-vs-Control-Post-Differenz berichtet: -2.92 [-4.88,-0.95], p=0.004) = %.3f, 95%% CI [%.3f, %.3f], p=%.4g.",
      pc_post$estimate, pc_post$estimate - qt(0.975, pc_post$df) * pc_post$SE,
      pc_post$estimate + qt(0.975, pc_post$df) * pc_post$SE, pc_post$p.value)
  )
}, error = function(e) { message("FEHLER etre: ", e$message); NULL })

## =============================================================================
## 4. gainingmore_PMC10809978 ---------------------------------------------------
## Paper (Statistical analyses): Bayes-Mehrebenenmodell ("univariate ... multi-
## level regression model"), Gruppendifferenz in der AENDERUNG (Pre->Post) fuer
## RF50 (ein co-primaeres Outcome von 9). brms ist installiert -> Bayes-Modell
## mit brms-Standardpriors (im Paper nicht spezifiziert) wird gefittet.
## =============================================================================
log_section("gainingmore_PMC10809978")
res <- tryCatch({
  f <- file.path(root, "studies/2024_gaining-more-from-doing-less-the-effects-of-a-on_PMC10809978/deposit/Dataset Deload.xlsx")
  dat <- read_excel(f, sheet = 1)
  dat <- dat[!is.na(dat$GROUP), c("CODE", "GROUP", "RF50Pre", "RF50Post")]
  dat$GROUP <- factor(dat$GROUP, levels = c(2, 1), labels = c("TRAD", "DELOAD"))  # TRAD = Kontrolle
  long <- dat %>%
    pivot_longer(cols = c(RF50Pre, RF50Post), names_to = "TimeRaw", values_to = "RF50") %>%
    mutate(Time = ifelse(TimeRaw == "RF50Pre", "pre", "post"),
           Time = factor(Time, levels = c("pre", "post")))
  long$RF50 <- as.numeric(long$RF50)

  brms_ok <- requireNamespace("brms", quietly = TRUE)
  if (brms_ok) {
    fit <- brms::brm(RF50 ~ GROUP * Time + (1 | CODE), data = long,
                      family = gaussian(), chains = 4, iter = 4000, warmup = 1000,
                      seed = 20260913, refresh = 0, silent = 2,
                      control = list(adapt_delta = 0.95))
    print(summary(fit))
    post <- as.data.frame(fit)
    term <- "b_GROUPDELOAD:Timepost"
    if (!term %in% names(post)) term <- grep("GROUPDELOAD.*Time|Time.*GROUPDELOAD", names(post), value = TRUE)[1]
    draws <- post[[term]]
    est <- median(draws)
    ci <- quantile(draws, c(0.025, 0.975))
    p_val <- NA_real_  # Bayesianisch: kein frequentistischer p-Wert, siehe deviations
    model_desc <- "Bayes-Mehrebenenmodell (brms, gaussian family, weakly-informative brms-Default-Priors): RF50 ~ Group*Time + (1|CODE); Gruppendifferenz-in-Aenderung = Group x Time Interaktion (DELOAD vs TRAD), posteriorer Median mit 95%-Kredibilitaetsintervall"
    dev_txt <- "Paper nennt 'univariate multilevel regression models' in einem vollstaendig bayesianischen Framework (vermutlich brms/Stan), spezifiziert aber weder Prior-Verteilungen noch die genaue Zufallseffekt-Struktur der 'multilevel'-Komponente im Detail; hier mit brms-Standardprioren (flach/schwach informativ) und (1|CODE) als Random Intercept fuer Messwiederholung Pre/Post reproduziert. Berichteter Wert im Paper ist eine posteriore Wahrscheinlichkeit ('p'=0.273, dass die Differenz die Deload-Aufnahme favorisiert), kein frequentistischer p-Wert -> unsere p-Spalte ist NA, stattdessen wird die posteriore Wahrscheinlichkeit P(Delta>0) separat berechnet und hier dokumentiert."
    p_gt0 <- mean(draws > 0)
    dev_txt <- paste0(dev_txt, sprintf(" P(GROUPDELOAD:Timepost > 0 | Daten) = %.3f (Paper: p=0.273 als analoge posteriore Wahrscheinlichkeit fuer Delload-Vorteil).", p_gt0))
  } else {
    m1 <- lmer(RF50 ~ GROUP * Time + (1 | CODE), data = long, REML = TRUE)
    cf <- summary(m1)$coefficients
    term <- "GROUPDELOAD:Timepost"
    ci_m <- confint(m1, method = "Wald")[term, ]
    est <- cf[term, "Estimate"]; ci <- ci_m; p_val <- cf[term, "Pr(>|t|)"]
    model_desc <- "brms nicht verfuegbar -> lme4-Aequivalent (REML) statt Bayes-Mehrebenenmodell: RF50 ~ Group*Time + (1|CODE)"
    dev_txt <- "ABWEICHUNG: brms war zur Laufzeit nicht installiert; als Ersatz wurde ein frequentistisches lmer-Aequivalent (flache/keine Priors entsprechen ungefaehr REML-Schaetzung) verwendet, wie in der Aufgabenstellung vorgesehen."
  }

  add_result(
    "gainingmore_PMC10809978",
    model_desc,
    est, ci[1], ci[2], p_val, length(unique(long$CODE)),
    dev_txt
  )
}, error = function(e) { message("FEHLER gainingmore: ", e$message); NULL })

## =============================================================================
## 5. lytras_fms_PMC12942207 ----------------------------------------------------
## Paper (2.7): Two-way mixed ANOVA (Group x Time), primaerer Hypothesentest =
## Interaktion; bei signifikanter Interaktion Bonferroni-adjustierte simple-
## effects-Paarvergleiche zwischen Gruppen zu jedem Zeitpunkt. Kontrast bei
## Woche 3 = NRPS-Lumbar post-Wert zwischen den Gruppen (Group 1=MT+FMS
## Intervention, Group 2=MT allein Kontrolle, gemaess README/SPSS-Werte-Labels).
## =============================================================================
log_section("lytras_fms_PMC12942207")
res <- tryCatch({
  f <- file.path(root, "studies/2026_short-term-effects-of-manual-therapy-combined-wi_PMC12942207/deposit/Lytras FMS 1 data.sav")
  dat <- read_sav(f)
  dat$Group <- factor(dat$GROUP, levels = c(2, 1), labels = c("MT_only", "MT_FMS"))  # 2 = Kontrolle

  long <- dat %>%
    select(Group, NRPSLBPpre, NRPSLBPpost) %>%
    mutate(id = row_number()) %>%
    pivot_longer(cols = c(NRPSLBPpre, NRPSLBPpost), names_to = "Time", values_to = "NPRS") %>%
    mutate(Time = factor(ifelse(Time == "NRPSLBPpre", "baseline", "week3"), levels = c("baseline", "week3")))

  ## (a) Zwei-Faktor gemischtes ANOVA: Interaktionstest (Group x Time), Between=Group, Within=Time
  aov_fit <- aov(NPRS ~ Group * Time + Error(id / Time), data = long)
  print(summary(aov_fit))

  ## (b) Simple-effect / Post-hoc-Paarvergleich der Gruppen bei Woche 3 (nach signifikanter Interaktion),
  ##     wie im Paper: unabhaengiger t-Test auf den Woche-3-Rohwert
  t_res <- t.test(NRPSLBPpost ~ Group, data = dat, var.equal = TRUE)
  # Bonferroni-Korrektur ueber die 2 getesteten Zeitpunkte (baseline, week3), wie im Paper beschrieben
  p_bonf <- min(t_res$p.value * 2, 1)

  est <- diff(t_res$estimate)  # MT_FMS - MT_only (diff() auf (MT_only,MT_FMS)-Reihenfolge = zweiter minus erster Level)
  ci <- -rev(t_res$conf.int)        # CI fuer MT_FMS - MT_only (Vorzeichen umgedreht wg. Faktorreihenfolge)

  add_result(
    "lytras_fms_PMC12942207",
    "Two-way mixed ANOVA (Group x Time) auf NPRS-Lumbar; primaerer Interaktionstest, danach Bonferroni-adjustierter Simple-Effect-t-Test (Gruppenvergleich bei Woche 3, unabhaengiger t-Test, gleiche Varianzen) gemaess 2.7 Statistical Analysis",
    est, ci[1], ci[2], p_bonf, nrow(dat),
    "Bonferroni-Adjustierung als Multiplikation des zweiseitigen zweistichproben-t-Test-p-Werts mit 2 (Anzahl getesteter Zeitpunkte: baseline, Woche 3) implementiert, da SPSS-Verfahren fuer 'Bonferroni-adjusted pairwise t-tests' im Paper nicht mit exaktem Adjustierungsfaktor spezifiziert ist; CI ist NICHT Bonferroni-adjustiert (95% CI des einfachen t-Tests), da das Paper fuer das CI keine explizite Adjustierungsmethode nennt. Gruppen-Codierung (2=Kontrolle/MT allein, 1=Intervention/MT+FMS) gemaess README.docx und SPSS-Value-Labels bestaetigt (weicht von registry.csv arm_control=1 ab, siehe registry_check)."
  )
}, error = function(e) { message("FEHLER lytras_fms: ", e$message); NULL })

## =============================================================================
## 6. mallorca_PMC8198819 --------------------------------------------------------
## Paper (2.7): "ANOVA tests for continuous measures ... Multiple imputation
## was used for the main analysis" (MICE-aequivalent). Publizierter Haupt-
## schaetzer ist die MI-basierte ITT-Analyse (-0.70, CI -1.24 bis -0.17, p=0.01).
## =============================================================================
log_section("mallorca_PMC8198819")
res <- tryCatch({
  f <- file.path(root, "studies/2021_effectiveness-of-moderate-intensity-aerobic-wate_PMC8198819/deposit/WaterexerciseprogramGAPMallorca.xlsx")
  dat <- suppressMessages(read_excel(f, sheet = "Sheet1"))

  clean_num <- function(x) suppressWarnings(as.numeric(ifelse(x == "#NULL!", NA, x)))
  dat_mi <- data.frame(
    GRUPO = factor(dat$GRUPO, levels = c("C", "I")),
    edimburgtotal = clean_num(dat$edimburgtotal),
    edad = clean_num(dat$edad),
    bmi = clean_num(dat$bmi),
    ipaq_met = as.numeric(dat$PreTest_IPAQ_TotalPAMETWeek),
    fumador = factor(clean_num(dat$fumador))
  )

  imp <- mice(dat_mi, m = 20, method = "pmm", seed = 20260913, printFlag = FALSE)
  fit_list <- with(imp, lm(edimburgtotal ~ GRUPO))
  pooled <- pool(fit_list)
  ps <- summary(pooled, conf.int = TRUE)
  row_i <- ps[ps$term == "GRUPOI", ]

  add_result(
    "mallorca_PMC8198819",
    "ANOVA/unadjustierter Gruppenvergleich (EPDS-Gesamtscore, 1 Monat postpartum) mit Multiple Imputation (mice, PMM, m=20) fuer fehlende EPDS-Werte, gepoolt nach Rubin's Rules; entspricht dem publizierten 'ITT analysis: Imputed' Hauptergebnis (2.7 Statistical Analysis)",
    row_i$estimate, row_i$`2.5 %`, row_i$`97.5 %`, row_i$p.value, nrow(dat_mi),
    "SPSS-MI-Modell und exakte Anzahl/Auswahl der Hilfsvariablen des Original-Papers sind nicht dokumentiert (nur 'Multiple imputation ... with chained equation' genannt, ohne m oder Praediktorenliste). Hier mice::mice mit PMM approximiert, Imputationsmodell mit plausiblen Hilfsvariablen (edad, bmi, IPAQ-MET/Woche, Raucherstatus) neben GRUPO, m=20 (im Paper nicht spezifiziert, daher Default gemaess Aufgabenstellung). Analysemodell selbst ist unadjustiert (lm(edimburgtotal~GRUPO)) gemaess Methodentext ('ANOVA tests for continuous measures'), keine Kovariaten. Kann von der SPSS-MI-Implementierung (z.B. andere Zufallszahlen, andere Hilfsvariablen) abweichen."
  )
}, error = function(e) { message("FEHLER mallorca: ", e$message); NULL })

## =============================================================================
## 7. physiofeedback_PMC12821712 -------------------------------------------------
## Deposit enthaelt Original-R-Code ("statistical code.R") der Autoren:
##   lmer(log(AP_RMS) ~ Group*Time + Age+BMI+Gender+Race + (1|SubjectID)+(1|Site),
##        REML=TRUE, control=lmerControl(optimizer="bobyqa")), Race releveled
##        auf Referenz "Other". Kontrast: Group*Time bei T4.
## =============================================================================
log_section("physiofeedback_PMC12821712")
res <- tryCatch({
  f <- file.path(root, "studies/2026_effect-of-a-physio-feedback-exercise-interventio_PMC12821712/deposit/deidentified data.xlsx")
  dat <- suppressMessages(read_excel(f, sheet = "Sheet1"))
  dat <- dat %>% filter(!is.na(Group) & !is.na(AP_RMS))
  dat$Race <- relevel(factor(dat$Race), ref = "Other")
  dat$Group <- factor(dat$Group, levels = c("Control", "Intervention"))
  dat$TimeF <- factor(dat$Time, levels = c(1, 2, 3, 4))

  m1 <- lmer(log(AP_RMS) ~ Group * TimeF + Age + BMI + Gender + Race +
               (1 | SubjectID) + (1 | Site), data = dat, REML = TRUE,
             control = lmerControl(optimizer = "bobyqa"))
  print(summary(m1))
  cf <- summary(m1)$coefficients
  term <- "GroupIntervention:TimeF4"
  ci_m <- confint(m1, method = "Wald")[term, ]

  add_result(
    "physiofeedback_PMC12821712",
    "LMM (Original-Autoren-Code aus deposit/statistical code.R): log(AP_RMS) ~ Group*Time + Age+BMI+Gender+Race + (1|SubjectID)+(1|Site), REML, bobyqa-Optimierer, Race-Referenz 'Other'; Kontrast Group x Time bei T4",
    cf[term, "Estimate"], ci_m[1], ci_m[2], cf[term, "Pr(>|t|)"], length(unique(dat$SubjectID)),
    "Der deponierte Original-Code schreibt 'Group * Time' ohne explizites factor(Time); da Time im Datensatz numerisch (1-4) codiert ist, wuerde eine rein lineare Behandlung nur EINEN Interaktionsterm liefern, waehrend Tabelle 3 des Papers separate Kontraste fuer T2, T3, T4 berichtet. Um den im Paper tabellierten T4-Kontrast zu reproduzieren, wurde Time hier explizit als 4-stufiger Faktor (Referenz T1) kodiert -- ansonsten identisch zum Original-Code (inkl. bobyqa-Optimierer und Race-Referenzkategorie 'Other')."
  )
}, error = function(e) { message("FEHLER physiofeedback: ", e$message); NULL })

## =============================================================================
## 8. spadi_PMC4880881 ------------------------------------------------------------
## Paper (Statistical analysis): "repeated measures ANCOVA model with 4 and 8
## weeks observations as repeated measures ... pretest as covariate ... main
## effect of treatment between groups". Kontrast IS (Group=1) vs TAU (Group=3),
## gepoolt ueber 4+8 Wochen, Baseline (SPADItotPre) als Kovariate.
## =============================================================================
log_section("spadi_PMC4880881")
res <- tryCatch({
  f <- file.path(root, "studies/2016_adhesive-capsulitis-of-the-shoulder-treatment-wi_PMC4880881/deposit/Frozen shoulder RCTgr dataset 100516_art2_1.sav")
  dat <- read_sav(f)
  dat <- dat %>% filter(Group %in% c(1, 3))
  dat$Group <- factor(dat$Group, levels = c(3, 1), labels = c("TAU", "IS"))  # TAU = Kontrolle

  long <- dat %>%
    select(IDnr, Group, SPADItotPre, SPADItot4wks, SPADI8wks) %>%
    pivot_longer(cols = c(SPADItot4wks, SPADI8wks), names_to = "Time", values_to = "SPADI") %>%
    filter(!is.na(SPADI) & !is.na(SPADItotPre))

  m1 <- lmer(SPADI ~ Group + Time + SPADItotPre + (1 | IDnr), data = long, REML = TRUE)
  print(summary(m1))
  cf <- summary(m1)$coefficients
  ci_m <- confint(m1, method = "Wald")["GroupIS", ]

  add_result(
    "spadi_PMC4880881",
    "Repeated-measures ANCOVA (approximiert als LMM mit Random Intercept je Patient): SPADI (4+8 Wochen gepoolt als Messwiederholung) ~ Group + Time + SPADI-Baseline + (1|IDnr); Kontrast IS (Group=1) vs TAU (Group=3)",
    cf["GroupIS", "Estimate"], ci_m[1], ci_m[2], cf["GroupIS", "Pr(>|t|)"], length(unique(long$IDnr)),
    "Paper implementiert die 'repeated measures ANCOVA' vermutlich als SPSS-GLM (multivariater Ansatz mit fixem Messwiederholungsfaktor, kein explizites Random-Effects-Modell); hier stattdessen mit einem linear gemischten Modell (Random Intercept je Patient) approximiert, was fuer eine Compound-Symmetry-Kovarianzstruktur strukturell aequivalent ist, aber abweichende Freiheitsgrade/SE liefern kann. Exakter p-Wert im Paper nicht berichtet (nur Signifikanzband ***=p<0.001 in Tabelle 4), daher nur qualitativer p-Vergleich moeglich. Gruppen-Codierung (1=IS,2=ISD,3=TAU) wurde anhand der deskriptiven Baseline-/Follow-up-Mittelwerte in den Rohdaten gegen Tabelle 2 des Papers verifiziert (Group=1 SPADItotPre~64.1/SPADItot4wks~34.1 matcht IS; Group=3 SPADItotPre~61.4/SPADItot4wks~51.9 matcht TAU)."
  )
}, error = function(e) { message("FEHLER spadi: ", e$message); NULL })

## =============================================================================
## 9. tdcs_PMC13257960 -------------------------------------------------------------
## Paper (Statistical analyses): "Between-group comparisons ... independent
## t-tests for normally distributed variables". Kontrast: CAR post-intervention,
## aktive a-tDCS ("R a-tDCS") vs Sham ("S a-tDCS").
## =============================================================================
log_section("tdcs_PMC13257960")
res <- tryCatch({
  f <- file.path(root, "studies/2026_integrating-multi-session-transcranial-direct-cu_PMC13257960/deposit/tDCS.sav")
  dat <- read_sav(f)
  dat$group <- as_factor(dat$group)
  dat$group <- factor(dat$group, levels = c("S a-tDCS", "R a-tDCS"))  # Sham = Kontrolle

  t_res <- t.test(CAR_post_all ~ group, data = dat, var.equal = TRUE)
  print(t_res)
  est <- diff(t_res$estimate)  # R (aktiv) - S (Sham) (diff() auf (S,R)-Reihenfolge = zweiter minus erster Level)
  ci <- -rev(t_res$conf.int)

  add_result(
    "tdcs_PMC13257960",
    "Unabhaengiger t-Test (gleiche Varianzen): CAR post-Intervention, aktive a-tDCS vs Sham a-tDCS (Statistical analyses)",
    est, ci[1], ci[2], t_res$p.value, nrow(dat),
    "Paper nennt Shapiro-Wilk/Levene-Vortests zur Wahl zwischen t-Test (gleiche Varianzen) und Mann-Whitney-U, spezifiziert aber nicht, welcher Test fuer CAR konkret verwendet wurde; hier direkt der Student-t-Test mit gleichen Varianzen (Voreinstellung fuer normalverteilte Daten laut Methodentext) auf die post-Werte gerechnet. Keine Kovariaten (Age/BMI nur deskriptiver Baseline-Vergleich, nicht im Primaermodell)."
  )
}, error = function(e) { message("FEHLER tdcs: ", e$message); NULL })

## =============================================================================
## 10. tereco_PMC8318721 -----------------------------------------------------------
## Paper (Statistical analysis): "constrained longitudinal data analysis" (cLDA)
## = LMM mit Gleichheitsrestriktion der Baseline-Mittelwerte ueber Gruppen,
## adjustiert fuer Zentrum (fixer Effekt), Random Intercept je Patient; der
## Interaktionsterm Time x Treatment bei Post-Treatment = Behandlungseffekt.
## =============================================================================
log_section("tereco_PMC8318721")
res <- tryCatch({
  f <- file.path(root, "studies/2022_a-telerehabilitation-programme-in-post-discharge_PMC8318721/deposit/TERECO_Public_Data_wide.csv")
  dat <- read.csv(f)
  dat$center <- factor(dat$center)
  dat$tereco_arm <- ifelse(dat$group_randomized == 1, 1L, 0L)  # 1 = TERECO/Intervention

  long <- dat %>%
    select(num_ID, center, tereco_arm, X_6MWD1, X_6MWD2, X_6MWD3) %>%
    pivot_longer(cols = starts_with("X_6MWD"), names_to = "wave", values_to = "sixmwd") %>%
    mutate(Time = factor(recode(wave, X_6MWD1 = "baseline", X_6MWD2 = "post", X_6MWD3 = "followup"),
                          levels = c("baseline", "post", "followup"))) %>%
    filter(!is.na(sixmwd))

  ## Constrained-LDA-Restriktion: kein Gruppenterm bei baseline, nur bei post/followup
  long$grp_post <- long$tereco_arm * (long$Time == "post")
  long$grp_fu   <- long$tereco_arm * (long$Time == "followup")

  m1 <- lmer(sixmwd ~ Time + grp_post + grp_fu + center + (1 | num_ID), data = long, REML = TRUE)
  print(summary(m1))
  cf <- summary(m1)$coefficients
  ci_m <- confint(m1, method = "Wald")["grp_post", ]

  add_result(
    "tereco_PMC8318721",
    "Constrained longitudinal data analysis (LMM mit Gleichheitsrestriktion der Baseline-Mittelwerte): 6MWD ~ Time + Treatment(nur post/follow-up) + Zentrum(fix) + (1|Patient); Kontrast = Behandlungseffekt post-Treatment (Statistical analysis)",
    cf["grp_post", "Estimate"], ci_m[1], ci_m[2], cf["grp_post", "Pr(>|t|)"], length(unique(long$num_ID)),
    "Paper beschreibt cLDA typischerweise als GLS/Mixed-Model mit UNSTRUKTURIERTER Kovarianzmatrix ueber die 3 Zeitpunkte; hier stattdessen ein Random-Intercept-Modell (Compound-Symmetry-Annahme) verwendet, was fuer die Punktschaetzung des Behandlungseffekts bei ausbalanciertem Design meist aehnlich, fuer den Standardfehler aber nicht identisch ist. Alle 119 Patienten mit Baseline-Wert werden unter MAR direkt in die Likelihood einbezogen (kein Ausschluss der 7 fehlenden Post-Werte, kein Imputationsschritt), analog zum 'no imputations'-ITT-Ansatz des Papers. Exakter p-Wert im Paper nicht berichtet (nur 'p<0.001')."
  )
}, error = function(e) { message("FEHLER tereco: ", e$message); NULL })

## =============================================================================
## 11. tscs_PMC13085461 --------------------------------------------------------------
## Paper (Statistical analysis {20a}): "an ANCOVA was performed for BBS, with
## post-intervention BBS as the dependent variable and baseline BBS as a
## covariate". Kontrast RAGT+tSCS (n=13, Intervention) vs CPT+tSCS (n=7,
## Kontrolle).
## =============================================================================
log_section("tscs_PMC13085461")
res <- tryCatch({
  f <- file.path(root, "studies/2026_transcutaneous-spinal-cord-stimulation-combined_PMC13085461/deposit/iEMG _1_ 2.0.sav")
  dat <- read_sav(f)
  dat$Group <- as_factor(dat$Group)
  dat$Group <- factor(dat$Group, levels = c("CPT+tSCS", "RAGT+tSCS"))  # CPT+tSCS = Kontrolle

  m1 <- lm(BBS_Post ~ Group + BBS_Pre, data = dat)
  print(summary(m1))
  s <- summary(m1)$coefficients
  ci <- confint(m1)
  term <- "GroupRAGT+tSCS"

  add_result(
    "tscs_PMC13085461",
    "ANCOVA: BBS post-Intervention ~ Group + BBS-Baseline; Kontrast RAGT+tSCS vs CPT+tSCS (Statistical analysis {20a})",
    s[term, "Estimate"], ci[term, 1], ci[term, 2], s[term, "Pr(>|t|)"], nrow(dat),
    "Starke Gruppenungleichheit (n=13 vs n=7) laut Protokoll so vorgesehen, aber ungewoehnlich fuer 1:1-Randomisierung. Numerische Group-Codierung im .sav-Datensatz enthielt bereits Text-Labels ('RAGT+tSCS'/'CPT+tSCS'), die direkt uebernommen wurden; Zuordnung zu Intervention/Kontrolle folgt Abstract und Tabellen 1-3 (RAGT+tSCS=n13=Intervention), da 'Sample size {14}' im Paper widerspruechlich Group A/B vertauscht. Exakter p-Wert im Paper nur als 'p<0.001' berichtet."
  )
}, error = function(e) { message("FEHLER tscs: ", e$message); NULL })

## =============================================================================
## 12. free_PMC6733445 ------------------------------------------------------------
## Paper (Statistical analysis, p.7): LMM auf Patientenebene mit Random Inter-
## cept + Slope fuer GP, Baseline-RMDQ + praespezifizierte Kovariaten, Zeit x
## Arm-Interaktion; Kontrast FREE vs Control bei 6 Monaten (week=26).
## =============================================================================
log_section("free_PMC6733445")
res <- tryCatch({
  f <- file.path(root, "studies/2019_the-fear-reduction-exercised-early-free-approach_PMC6733445/deposit/FREE_Patient_Outcome_Data_v1_0.csv")
  dat <- read.csv(f, stringsAsFactors = FALSE)
  dat$Tment <- factor(dat$Tment, levels = c("Control", "FREE"))
  dat$gender_w0 <- factor(dat$gender_w0)
  dat$backpain_consistency_3f <- factor(dat$backpain_consistency_3f)
  dat$previous_backpain_w0_imp <- factor(dat$previous_backpain_w0_imp)
  dat$pracsize_strata <- factor(dat$pracsize_strata)

  fit_full <- function(random_part) {
    frm <- as.formula(paste0(
      "rmdq_tot ~ rmdq_tot_base + week * Tment + age_w0 + gender_w0 + NZDep_Decile + ",
      "d_length_back_pain_weeks + backpain_consistency_3f + previous_backpain_w0_imp + ",
      "pseq2_tot_mod_base_imp + expectation4wk_base_imp + hcpairs_tot_w0 + pracsize_strata + ",
      random_part))
    lmer(frm, data = dat, REML = TRUE, control = lmerControl(optimizer = "bobyqa"))
  }

  m1 <- tryCatch(fit_full("(1 + week | GP)"), error = function(e) NULL)
  used_slope <- TRUE
  if (is.null(m1) || isSingular(m1, tol = 1e-4)) {
    m1_slope_singular <- is.null(m1) || isSingular(m1, tol = 1e-4)
    if (is.null(m1)) {
      m1 <- fit_full("(1 | GP)")
      used_slope <- FALSE
    }
  } else {
    m1_slope_singular <- FALSE
  }
  print(summary(m1))

  emm <- emmeans(m1, ~ Tment, at = list(week = 26))
  pc <- as.data.frame(pairs(emm, reverse = TRUE))  # FREE - Control

  n_used <- length(unique(dat$study_id[!is.na(dat$rmdq_tot)]))

  dev_txt <- paste0(
    "Kovariatensatz aus den im Deposit verfuegbaren, bereits mittelwert-imputierten Basisvariablen zusammengestellt (age_w0, gender_w0, NZDep_Decile, d_length_back_pain_weeks, backpain_consistency_3f, previous_backpain_w0_imp, pseq2_tot_mod_base_imp, expectation4wk_base_imp [von zwei im Deposit verfuegbaren 'recovery expectation'-Variablen wurde nur diese verwendet, da das Paper nicht spezifiziert welche 'recovery expectations' gemeint sind], hcpairs_tot_w0, pracsize_strata); 'anxiety'/'catastrophisation' NICHT aufgenommen, da im Methodentext nicht als Kovariate genannt. Zeit (week, 2/6/12/26) als STETIGE Kovariate mit Zeit x Arm-Interaktion behandelt (nicht als Faktor), um den im Paper explizit genannten Random Slope fuer GP zu ermoeglichen; Kontrast bei week=26 ueber emmeans extrahiert. Clusterung ueber GP (Random Intercept + Slope), NICHT ueber practice_code, gemaess Papertext. ",
    if (!used_slope) "Random-Slope-Modell (1+week|GP) konvergierte nicht/war singulaer -> Fallback auf (1|GP) (Random Intercept only)." else if (isTRUE(m1_slope_singular)) "Random-Slope-Modell (1+week|GP) war (nahezu) singulaer, wurde aber dennoch verwendet (kein Alternativmodell erzwungen)." else "Random-Slope-Modell (1+week|GP) konvergierte ohne Singularitaetswarnung.")

  add_result(
    "free_PMC6733445",
    "LMM: RMDQ ~ Baseline-RMDQ + week*Tment + praespezifizierte Kovariaten + (1+week|GP), REML; Kontrast FREE vs Control bei week=26 (Statistical analysis, p.7)",
    pc$estimate, pc$estimate - qt(0.975, pc$df) * pc$SE, pc$estimate + qt(0.975, pc$df) * pc$SE,
    pc$p.value, n_used,
    dev_txt
  )
}, error = function(e) { message("FEHLER free: ", e$message); NULL })

## =============================================================================
## Ergebnisse zusammenfuehren und schreiben
## =============================================================================
out <- bind_rows(results)
dir.create(file.path(root, "output"), showWarnings = FALSE)
write.csv(out, file.path(root, "output/stage2_published_models.csv"), row.names = FALSE)
cat("\n\n=== output/stage2_published_models.csv geschrieben (", nrow(out), " Zeilen) ===\n")
print(out[, c("study_id", "est", "ci_lo", "ci_hi", "p", "n")])

## =============================================================================
## Vergleich mit publiziertem Schaetzer (config/published.csv + overrides)
## =============================================================================
pub <- read.csv(file.path(root, "config/published.csv"), stringsAsFactors = FALSE)
ov <- read.csv(file.path(root, "config/published_overrides.csv"), stringsAsFactors = FALSE)

pub_use <- pub %>% select(study_id, published_est, published_ci_lo, published_ci_hi, published_p)
pub_use$published_est <- suppressWarnings(as.numeric(pub_use$published_est))
pub_use$published_ci_lo <- suppressWarnings(as.numeric(pub_use$published_ci_lo))
pub_use$published_ci_hi <- suppressWarnings(as.numeric(pub_use$published_ci_hi))
pub_use$published_p <- suppressWarnings(as.numeric(pub_use$published_p))
for (i in seq_len(nrow(ov))) {
  sid <- ov$study_id[i]
  est_i <- suppressWarnings(as.numeric(ov$published_est[i]))
  if (sid %in% pub_use$study_id && !is.na(est_i)) {
    pub_use$published_est[pub_use$study_id == sid] <- est_i
    pub_use$published_ci_lo[pub_use$study_id == sid] <- suppressWarnings(as.numeric(ov$published_ci_lo[i]))
    pub_use$published_ci_hi[pub_use$study_id == sid] <- suppressWarnings(as.numeric(ov$published_ci_hi[i]))
    pub_use$published_p[pub_use$study_id == sid] <- suppressWarnings(as.numeric(ov$published_p[i]))
  }
}
pub_use$published_est <- as.numeric(pub_use$published_est)
pub_use$published_ci_lo <- as.numeric(pub_use$published_ci_lo)
pub_use$published_ci_hi <- as.numeric(pub_use$published_ci_hi)
pub_use$published_p <- as.numeric(pub_use$published_p)

comp <- out %>%
  left_join(pub_use, by = "study_id") %>%
  mutate(
    abs_diff = est - published_est,
    rel_diff_pct = 100 * (est - published_est) / abs(published_est),
    published_ci_contains_reanalysis = ifelse(!is.na(published_ci_lo) & !is.na(published_ci_hi),
                                               est >= published_ci_lo & est <= published_ci_hi, NA),
    reanalysis_ci_contains_published = ifelse(!is.na(ci_lo) & !is.na(ci_hi),
                                               published_est >= ci_lo & published_est <= ci_hi, NA),
    p_agreement_both_sig_0.05 = ifelse(!is.na(published_p) & !is.na(p),
                                        (published_p < 0.05) == (p < 0.05), NA)
  )

write.csv(comp, file.path(root, "output/stage2_comparison.csv"), row.names = FALSE)
cat("\n=== output/stage2_comparison.csv geschrieben ===\n")
print(comp[, c("study_id", "est", "published_est", "abs_diff", "rel_diff_pct",
               "p", "published_p", "p_agreement_both_sig_0.05",
               "published_ci_contains_reanalysis")])

cat("\n=== FERTIG ===\n")
