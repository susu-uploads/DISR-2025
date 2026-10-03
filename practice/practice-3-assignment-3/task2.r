library(MASS)
data("Boston")

# 1. Размеры и структура данных
dim(Boston)
str(Boston)
?Boston

# 2. Пригороды с высокими значениями
head(Boston[order(-Boston$crim), ], 10)      # высокая преступность
head(Boston[order(-Boston$tax), ], 10)       # высокие налоги
head(Boston[order(-Boston$ptratio), ], 10)   # большое соотношение учеников к учителям

# 3. Сколько пригородов у реки Чарльз
table(Boston$chas)

# 4. Пригороды с большим средним числом комнат
sum(Boston$rm > 7)
sum(Boston$rm > 8)
subset(Boston, rm > 8)
