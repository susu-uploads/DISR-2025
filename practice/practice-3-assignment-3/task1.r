college <- read.csv("College.csv")
fix(college)
rownames(college) <- college[, 1]
college <- college[, -1]
fix(college)
summary(college)
Elite <- rep("No", nrow(college))
Elite[college$Top10perc > 50] <- "Yes"
Elite <- as.factor(Elite)
college <- data.frame(college, Elite)
summary(college$Elite)
