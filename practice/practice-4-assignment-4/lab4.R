vecpoisson <- rpois(100, 5)
mean(vecpoisson)

set.seed(198911)
vecpoisson <- rpois(100, 5)
mean(vecpoisson)

set.seed(198911)
vecpoisson <- rpois(100, 5)
mean(vecpoisson)

reps <- 50000
nexps <- 5
rate <- 0.1

set.seed(0)

system.time(
  x1 <- replicate(reps, sum(rexp(n = nexps, rate = rate)))
)  # replicate

head(x1)


require(ggplot2)

ggplot(data.frame(x1), aes(x1)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightblue", color = "black") +
  stat_function(
    fun = function(x) dgamma(x, shape = nexps, scale = 1 / rate),
    color = "red",
    size = 2
  )

set.seed(0)

system.time(
  x1 <- sapply(1:reps, function(i) {
    sum(rexp(n = nexps, rate = rate))
  })
)  # simple apply

head(x1)

set.seed(0)

system.time(
  x1 <- lapply(1:reps, function(i) {
    sum(rexp(n = nexps, rate = rate))
  })
)  # list apply

head(x1)

set.seed(0)
system.time(
  x1 <- apply(
    matrix(rexp(n = nexps * reps, rate = rate), nrow = nexps),
    2,
    sum
  )
)  # apply on a matrix

head(x1)

set.seed(0)
system.time(
  x1 <- colSums(
    matrix(rexp(n = nexps * reps, rate = rate), nrow = nexps)
  )
)  # using colSums

head(x1)

require(parallel)

set.seed(0)

system.time(
  x1 <- mclapply(1:reps, function(i) {
    sum(rexp(n = nexps, rate = rate))
  })
)  # multi-cluster apply

head(x1)

samples = rnorm(1000, 0, 1)
require(ggplot2)
sampa=rnorm(1000000,0,1)
sampb=rnorm(1500000,3,1)
combined = c(sampa, sampb)
plt = ggplot(data.frame(combined), aes(x=combined)) +
  stat_bin(binwidth=0.25, position="identity")
plt
#Упражнение 1
ggplot(data.frame(combined), aes(x = combined)) +
  geom_density(fill = "lightgreen", alpha = 0.5) +
  labs(title = "Плотность смешанного распределения", x = "Значение", y = "Плотность")
#Упражнение 2
pop1=rnorm(2000000)
pop2=rnorm(1000000, 1, 2)
combined = c(pop1, pop2)
plt= ggplot(data.frame(data=c(combined, pop1, pop2), labels=rep(c("combined", "pop1",
                                                                  "pop2"), c(3e6, 2e6, 1e6))), aes(x=data)) + stat_bin(aes(fill=labels),
                                                                                                                       position="identity", binwidth=0.25, alpha=0.5) + theme_bw()
plt
#Упражнение 3
require(MASS)
Sigma=matrix(c(5,3,3,2),2,2)
ex1=mvrnorm(100000,rep(0,2),Sigma)
Sigma=matrix(c(9,-5,-1,5),2,2)
ex2=mvrnorm(n=100000, rep(3, 2), Sigma)
require(ggplot2)

# Создаём датафреймы для кластеров
df1 <- data.frame(x = ex1[,1], y = ex1[,2], cluster = "ex1")
df2 <- data.frame(x = ex2[,1], y = ex2[,2], cluster = "ex2")
df <- rbind(df1, df2)

# Построение диаграммы частот
ggplot(df, aes(x = x, y = y, color = cluster)) +
  geom_point(alpha = 0.1, size = 0.5) +       # точки
  geom_density2d(aes(color = cluster), size = 1) +  # линии плотности
  theme_minimal() +
  labs(title = "Функции частот распределения двух кластеров", x = "X", y = "Y")

isEvent = function(numDice, numSides, targetValue, numTrials){
  apply(matrix(sample(1:numSides, numDice*numTrials, replace=TRUE), nrow=numDice),
        +2, sum) >= targetValue
}

set.seed(0)
outcomes = isEvent(2, 6, 7, 5)
mean(outcomes)

set.seed(0)
outcomes = isEvent(2, 6, 7, 10000)
mean(outcomes)

require(parallel)
isEventPar = function(numDice, numSides, targetValue, trialIndices){
  sapply(1:length(trialIndices), function(x) sum(sample(1:numSides, numDice,
                                                        replace=TRUE)) >= targetValue)
}
set.seed(0)
outcomes = pvec(1:10000, function(x) isEventPar(2, 6, 7, x))
mean(outcomes)
install.packages("profvis", repos="https://cran.r-project.org")
install.packages("bench", repos="https://cran.r-project.org")
library(profvis) 
library(bench) 
f <- function() { 
  pause(0.1) 
  g() 
  h() 
} 
g <- function() { 
  pause(0.1) 
  h() 
} 
h <- function() { 
  pause(0.1) 
} 
tmp <- tempfile() 
Rprof(tmp, interval = 0.1) 
f() 
Rprof(NULL) 
writeLines(readLines(tmp))
profvis(f())

library(profvis)

profvis({
  x <- integer()
  for (i in 1:1e4) {
    x <- c(x, i)
  }
})
#Упражнение 4
library(profvis)

profvis({
  f <- function(n = 1e5) {
    x <- rep(1, n)
    rm(x)
  }
  
  f()
})

library(bench)

# Генерируем данные
x <- runif(100)

# Сравниваем производительность
lb <- bench::mark(
  sqrt(x),
  x ^ 0.5
)

# Выводим таблицу результатов
print(lb)

# Визуализация результатов
plot(lb)

#Упражнение 5
# Устанавливаем и подключаем нужный пакет
install.packages("microbenchmark")  
library(microbenchmark)

# Создаём случайный вектор
x <- runif(1000)

# Проводим microbenchmark
res <- microbenchmark(
  power = x ^ (1 / 2),
  exp_log = exp(log(x) / 2),
  times = 1000
)

# Выводим результаты
print(res)

# Визуализируем
boxplot(res, main = "Сравнение производительности", ylab = "Время (наносекунды)")
