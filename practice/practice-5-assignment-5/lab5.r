# install.packages("palmerpenguins")
library(palmerpenguins)

library(tidyverse)
dat <- penguins %>%
    select(species, flipper_length_mm)

summary(dat)

library(ggplot2)
ggplot(dat) +
    aes(x = species, y = flipper_length_mm, color = species) +
    geom_jitter() +
    theme(legend.position = "none")

res_aov <- aov(flipper_length_mm ~ species,
    data = dat
)

par(mfrow = c(1, 2)) # combine plots
# histogram
hist(res_aov$residuals)
# QQ-plot
library(car)
qqPlot(res_aov$residuals,
    id = FALSE # id = FALSE to remove point identification
)

shapiro.test(res_aov$residuals)

# Boxplot
boxplot(flipper_length_mm ~ species,
    data = dat
)

# Dotplot
library("lattice")
dotplot(flipper_length_mm ~ species,
    data = dat
)

# Levene's test
library(car)
leveneTest(flipper_length_mm ~ species,
    data = dat
)

par(mfrow = c(1, 2)) # combine plots
# 1. Homogeneity of variances
plot(res_aov, which = 3)
# 2. Normality
plot(res_aov, which = 2)

boxplot(flipper_length_mm ~ species,
    data = dat
)

boxplot(flipper_length_mm ~ species,
    data = dat
)

library(ggplot2)
ggplot(dat) +
    aes(x = species, y = flipper_length_mm) +
    geom_boxplot()

aggregate(flipper_length_mm ~ species,
    data = dat,
    function(x) round(c(mean = mean(x), sd = sd(x)), 2)
)

library(dplyr)
group_by(dat, species) %>%
    summarise(
        mean = mean(flipper_length_mm, na.rm = TRUE),
        sd = sd(flipper_length_mm, na.rm = TRUE)
    )

# 1st method:
oneway.test(flipper_length_mm ~ species,
    data = dat,
    var.equal = TRUE # assuming equal variances
)

# 2nd method:
res_aov <- aov(flipper_length_mm ~ species,
    data = dat
)
summary(res_aov)

oneway.test(flipper_length_mm ~ species,
    data = dat,
    var.equal = FALSE # assuming unequal variances
)

# install.packages("remotes")
# remotes::install_github("easystats/report") # You only need to do that once
library("report") # Load the package every time you start R
report(res_aov)

library(multcomp)
# Tukey HSD test:
post_test <- glht(res_aov,
    linfct = mcp(species = "Tukey")
)
summary(post_test)

par(mar = c(3, 8, 3, 3))
plot(post_test)

TukeyHSD(res_aov)

plot(TukeyHSD(res_aov))

library(multcomp)
# Dunnett's test:
post_test <- glht(res_aov,
    linfct = mcp(species = "Dunnett")
)
summary(post_test)

par(mar = c(3, 8, 3, 3))
plot(post_test)

# Change reference category:
dat$species <- relevel(dat$species, ref = "Gentoo")
# Check that Gentoo is the reference category:
levels(dat$species)

res_aov2 <- aov(flipper_length_mm ~ species,
    data = dat
)

# Dunnett's test:
post_test <- glht(res_aov2,
    linfct = mcp(species = "Dunnett")
)
summary(post_test)

par(mar = c(3, 8, 3, 3))
plot(post_test)

pairwise.t.test(dat$flipper_length_mm, dat$species,
    p.adjust.method = "holm"
)

# Edit from here
x <- which(names(dat) == "species") # name of grouping variable
y <- which(
    names(dat) == "flipper_length_mm" # names of variables to test
)
method1 <- "anova" # one of "anova" or "kruskal.test"
method2 <- "t.test" # one of "wilcox.test" or "t.test"
my_comparisons <- list(c("Chinstrap", "Adelie"), c("Gentoo", "Adelie"),
c("Gentoo", "Chinstrap")) # comparisons for post-hoc tests
# Edit until here
# Edit at your own risk
library(ggpubr)
for (i in y) {
    for (j in x) {
        p <- ggboxplot(dat,
            x = colnames(dat[j]), y = colnames(dat[i]),
            color = colnames(dat[j]),
            legend = "none",
            palette = "npg",
            add = "jitter"
        )
        print(
            p + stat_compare_means(
                aes(label = paste0(after_stat(method), ", p-value =", after_stat(p.format))),
                method = method1, 
                label.y = max(dat[, i], na.rm = TRUE)
            ) + stat_compare_means(
                comparisons = my_comparisons, 
                method = method2, 
                label = "p.format"
            ) # remove if p-value of ANOVA or Kruskal-Wallis test >= alpha
        )
    }
}

library(ggstatsplot)
ggbetweenstats(
    data = dat,
    x = species,
    y = flipper_length_mm,
    type = "parametric", # ANOVA or Kruskal-Wallis
    var.equal = TRUE, # ANOVA or Welch ANOVA
    plot.type = "box",
    pairwise.comparisons = TRUE,
    pairwise.display = "significant",
    centrality.plotting = FALSE,
    bf.message = FALSE
)
