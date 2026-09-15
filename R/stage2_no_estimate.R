# Stufe 2 fuer die vier Studien OHNE publizierten Punktschaetzer: Nachrechnen der
# berichteten Teststatistik und des p-Werts, so wie im Paper beschrieben.
suppressMessages({library(dplyr); library(tidyr); library(haven); library(readxl); library(lme4); library(lmerTest); library(car)})
out <- list()
add <- function(id, what, published, recomputed, note) out[[length(out)+1]] <<- data.frame(study_id = id, statistic = what, published = published, recomputed = recomputed, note = note)

## 1. Mulligan: Two-way RM-ANOVA, 3 Gruppen x 2 Zeitpunkte, Group x Time Interaktion F(2,40) = 0.983, p = 0.383
d <- read_sav("studies/2026_comparison-of-the-short-term-effects-of-mulligan_PMC13092435/deposit/Kiouloukiotis data.sav")
d <- d[!is.na(d$TreatmentGroup), ]; d$Group <- factor(d$TreatmentGroup, levels = c(1,2,3), labels = c("Mulligan","Maitland","Control"))
long <- d %>% select(ParticipantNumber, Group, NPRS1, NPRS2) %>% pivot_longer(c(NPRS1, NPRS2), names_to = "Time", values_to = "NPRS") %>% mutate(ID = factor(ParticipantNumber), Time = factor(Time))
a <- summary(aov(NPRS ~ Group * Time + Error(ID/Time), data = long))
w <- a[["Error: ID:Time"]][[1]]; i <- grep("Group:Time", rownames(w))
add("mulligan_PMC13092435", "Group x Time F, p (RM-ANOVA, 3 arms, n = 43)", "F = 0.983, p = 0.383", sprintf("F(%d,%d) = %.3f, p = %.3f", w$Df[i], w$Df[nrow(w)], w$`F value`[i], w$`Pr(>F)`[i]), "SPSS RM-ANOVA; Change 1 Zeitpunkt = univariate Loesung")
b <- a[["Error: ID"]][[1]]; g <- grep("Group", rownames(b))
add("mulligan_PMC13092435", "Group main effect F, p", "not reported as number", sprintf("F(%d,%d) = %.3f, p = %.3f", b$Df[g], b$Df[nrow(b)], b$`F value`[g], b$`Pr(>F)`[g]), "")
chg <- d %>% group_by(Group) %>% summarise(pre = mean(NPRS1), post = mean(NPRS2), n = n())
add("mulligan_PMC13092435", "within-group means pre -> post", "Mulligan 4.79 -> 2.36; Maitland 5.07 -> 2.14; Control ?", paste(sprintf("%s %.2f -> %.2f (n=%d)", chg$Group, chg$pre, chg$post, chg$n), collapse = "; "), "")

## 2. Facial: Mann-Whitney U auf Change Score SFGS-Composite Baseline -> Tag 20, p = 0.002; Mediane (IQR) 59.0 (42.5-63.0) vs 24.0 (9.0-32.0)
f <- read_excel("studies/2024_effectiveness-of-novel-facial-stretching-with-st_PMC11164989/deposit/Data sheet.xlsx")
f <- f[!is.na(f$Group), ]; f$chg <- as.numeric(f$T3) - as.numeric(f$T1); f$Group <- factor(f$Group, levels = c(1,2), labels = c("Experimental","Conventional"))
wt <- wilcox.test(chg ~ Group, data = f, exact = TRUE)   # SPSS berichtet bei n < 30 die exakte Signifikanz
q <- f %>% group_by(Group) %>% summarise(med = median(chg, na.rm=TRUE), q1 = quantile(chg, .25, type = 6, na.rm=TRUE), q3 = quantile(chg, .75, type = 6, na.rm=TRUE), n = sum(!is.na(chg)))   # SPSS-Perzentile (HAVERAGE = Typ 6)
add("facial_PMC11164989", "Mann-Whitney U p (SFGS composite change, day 20 - baseline)", "p = 0.002", sprintf("p = %.4f (W = %.0f)", wt$p.value, wt$statistic), "exakter Test; asymptotisch mit Korrektur ergaebe p = 0.0033")
add("facial_PMC11164989", "median (IQR) change per group", "Exp 59.0 (42.5-63.0); Conv 24.0 (9.0-32.0)", paste(sprintf("%s %.1f (%.1f-%.1f), n=%d", q$Group, q$med, q$q1, q$q3, q$n), collapse = "; "), "")

## 3. Cluster sets: LMM 1RM ~ group * time + sex + (1|ID), Type III Satterthwaite; interaction p = 0.352; time F(1,34) = 80.67; sex F(1,33) = 95.13
c <- read_excel("studies/2026_acute-responses-and-chronic-adaptations-to-clust_PMC13140343/deposit/data.xlsx")
c <- c[!is.na(c$Group) & !is.na(c$`1RM`), ]; c$rm <- as.numeric(c$`1RM`); c$Group <- factor(c$Group); c$Time <- factor(c$Time, levels = c("pre","post")); c$Sex <- factor(c$Sex); c$ID <- factor(c$ID)
m <- lmer(rm ~ Group * Time + Sex + (1 | ID), data = c, REML = TRUE)
an <- anova(m, type = 3, ddf = "Satterthwaite")
add("clusterset_PMC13140343", "Group x Time interaction p (LMM, Type III, Satterthwaite)", "p = 0.352", sprintf("F(%.0f,%.1f) = %.3f, p = %.3f", an["Group:Time","NumDF"], an["Group:Time","DenDF"], an["Group:Time","F value"], an["Group:Time","Pr(>F)"]), "wie Methods 2.4.2")
add("clusterset_PMC13140343", "Time main effect F, p", "F(1,34) = 80.67, p < 0.001", sprintf("F(%.0f,%.1f) = %.2f, p = %.2g", an["Time","NumDF"], an["Time","DenDF"], an["Time","F value"], an["Time","Pr(>F)"]), "")
add("clusterset_PMC13140343", "Sex main effect F, p", "F(1,33) = 95.13, p < 0.001", sprintf("F(%.0f,%.1f) = %.2f, p = %.2g", an["Sex","NumDF"], an["Sex","DenDF"], an["Sex","F value"], an["Sex","Pr(>F)"]), "")

## 4. Phosphatidic acid: 2x2 mixed ANOVA LBM, Group x Time: F(1,16) = 33.30, p = 0.041 (Abstract: p < 0.001; intern widerspruechlich)
p <- read_excel("studies/2016_the-effects-of-phosphatidic-acid-supplementation_PMC4891923/deposit/Maxxtor male stats 8-12-15.xlsx")
p <- p[!is.na(p$Group), ]; p$Group <- factor(p$Group, levels = c(1,2), labels = c("MT","PLA"))
pl <- p %>% select(ID, Group, LBM1, LBM2) %>% pivot_longer(c(LBM1, LBM2), names_to = "Time", values_to = "LBM") %>% mutate(ID = factor(ID), Time = factor(Time))
a2 <- summary(aov(LBM ~ Group * Time + Error(ID/Time), data = pl)); w2 <- a2[["Error: ID:Time"]][[1]]; i2 <- grep("Group:Time", rownames(w2)); t2 <- grep("^Time", rownames(w2))
add("phosphatidic_PMC4891923", "Group x Time interaction F, p (2x2 mixed ANOVA, n = 18)", "F(1,16) = 33.30, p = 0.041 (Results); 'main effect F(1,16) = 33.30, p < 0.001' (Abstract)", sprintf("F(%d,%d) = %.2f, p = %.4f", w2$Df[i2], w2$Df[nrow(w2)], w2$`F value`[i2], w2$`Pr(>F)`[i2]), "Paper intern widerspruechlich: F = 33.30 bei df (1,16) impliziert p < 0.001, p = 0.041 impliziert F = 4.9")
add("phosphatidic_PMC4891923", "Time main effect F, p", "not separately reported", sprintf("F(%d,%d) = %.2f, p = %.2g", w2$Df[t2], w2$Df[nrow(w2)], w2$`F value`[t2], w2$`Pr(>F)`[t2]), "")
mm <- p %>% group_by(Group) %>% summarise(pre = mean(LBM1), post = mean(LBM2), sd_pre = sd(LBM1), sd_post = sd(LBM2), n = n())
add("phosphatidic_PMC4891923", "means pre/post per group", "MT 60.8+/-9.5 -> 62.7+/-10.2; PLA 61.2+/-9.7 -> 62.0+/-9.7", paste(sprintf("%s %.1f+/-%.1f -> %.1f+/-%.1f (n=%d)", mm$Group, mm$pre, mm$sd_pre, mm$post, mm$sd_post, mm$n), collapse = "; "), "")

res <- bind_rows(out); write.csv(res, "output/stage2_no_estimate.csv", row.names = FALSE)
for (i in seq_len(nrow(res))) cat(sprintf("%-26s %-58s\n   publiziert:    %s\n   nachgerechnet: %s\n   %s\n", res$study_id[i], res$statistic[i], res$published[i], res$recomputed[i], res$note[i]))
