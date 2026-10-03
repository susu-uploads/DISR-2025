vector("numeric", 10)
vector("complex", 10)
vector("logical", 10)
vector("character", 10)
x = c(3, 5, -2, 4); x
y = c(TRUE, FALSE, TRUE, TRUE); y
z = c("a", "b", "ab", "abc"); z
x = c(2, 3, -2, TRUE, FALSE, TRUE); x
y = c(4, -6, 2.8, TRUE, "a", FALSE, 3, "abc"); y
x = c(1, -3.2, 2); x
y = c(-0.6, pi, Inf, 5); y
z = c(2, x, -1, y); z
y=scan()
y=scan()
н
y
y = c(TRUE, FALSE, 1, -3, 2, 1+1i*2); y
z = factor(y); z
is.vector(y)
is.vector(z)
w = as.vector(z); w
is.vector(w)
w
c(c(1, 2, 3, 4, 5), 6, c(7, 8))
seq(0, 1, by = 0.1)
seq(0, 1, len = 11)
rep(c(1, 2), 3)
x = rep(c(1, 2, 3, 4, 5), c(1, 2, 3, 4, 5)); x
age = c(23, NA, NA, 18, 19, Inf, NaN)
age
c(1, 2, 3, 4) + c(1, 2)
c(1, 2, 3, 4) - c(1, 2)
c(1, 2, 3, 4) * c(1, 2)
c(1, 2, 3, 4) / c(1, 2)
c(1, 2, 3, 4) ^ c(1, 2)
c(1, 2, 3, 4) / c(1, 0)
2 * c(1, 2, 3, 4, 5)
c(3, 1, 4, 1, 5, 9, 2) + c(9, 5)
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
x1 * 2
x1 / 4
x1 + 5
x1 - 2
x = c(0, pi/2, pi)
sin(x)
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
sqrt(x1)
x = c(1:5, NA, NaN, 6:10); x
length(x)
x = c(1:5, NA, NaN, 6:10); x
min(x)
max(x)
min(x, na.rm = TRUE)
max(x, na.rm = TRUE)
x = rpois(10, 1); x
y = rpois(6, 1); y
pmax(x, y)
pmin(x, y)
x = c(NA, NaN, NaN)
y = c(NaN, NA, NaN)
pmin(x, y, na.rm = T)
pmax(x, y, na.rm = T)
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
mean(x1)
mean(x1, na.rm = TRUE)
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
range(x1)
range(x1, na.rm = TRUE)
x = c(1:5, NA, 6:10)
sum(x)
sum(x, na.rm = TRUE)
x = c(1:5, NA, NaN, 6:10); x
prod(x)
prod(x, na.rm = TRUE)
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
sort(x1)
sort(x1, decreasing = TRUE)
rev(sort(x1))
x = c(5:1, 6, 9, 10, 8, 7); x
random = rank(x, ties.method = "random")
average = rank(x, ties.method = "average")
first = rank(x, ties.method = "first")
max = rank(x, ties.method = "max")
min = rank(x, ties.method = "min")
rbind(x, random, average, first, max, min)
x = c(6, 11, 10, 9, 13, 12, 8, 7, 10, 6); x
random = rank(x, ties.method = "random")
average = rank(x, ties.method = "average")
first = rank(x, ties.method = "first")
max = rank(x, ties.method = "max")
min = rank(x, ties.method = "min")
rbind(x, random, average, first, max, min)
last = rank(x, na.last = TRUE)
first = rank(x, na.last = FALSE)
Na = rank(x, na.last = NA)
keep = rank(x, na.last = "keep")
rbind(x, last, first, keep)
Na
x = c(8, 11, 13, 9, 7, 11, 10, 12, 14, 7)
y = c(9, 10, 9, 10, 9)
match(x, y)
match(y, x)
x = 1:10
cumsum(x)
y = -5:5
cumprod(y)
x = -5:4
cummax(x)
cummin(x)
y = character(10); y
for (i in 1:length(y)) y[i] = letters[i]
y
x = "a"; x
y = "тоже символьная переменная"; y
времена_года = c("зима", "весна", "лето", "осень")
времена_года
character(10)
letters
LETTERS
paste("зима", "первый", "сезон", "года")
paste(c("зима", "весна", "лето", "осень"), c("-время года"), sep = "")
paste("x", 1:5)
paste("x", 1:5, sep = "")
phrase = "сытое брюхо к учению глухо"
q = character(26)
for (i in 1:26) q[i] = substr(phrase, 1, i)
q
phrase = "сытое брюхо к учению глухо"
strsplit(phrase, split = character(0))
strsplit(phrase, split = " ")
nchar(phrase)
nchar(q)
age = c(1, 2, NA, Inf, NaN, 18, 19, 40)
young <- (age >= 2) & (age <= 30)
young
a = c(0, 1, Inf, NaN, NA)
is.na(a)
is.nan(a)
group = c(17, 19, 25, 13, 7)
names(group) = c("НП-201", "НП-202", "НП-203", "НК-201", "НИ-201")
group
group[2]
group["НП-203"]
group["НП-203"] = 18
group
u <- 1
u[5] <- 5
u
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
length(x1)
x1[-6]
x1[]
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
x2 = c(TRUE, FALSE, TRUE, FALSE, FALSE)
y = x1[x2]; y
x3 = rep(c(TRUE, FALSE), 10); x3
y = x1[x3]; y
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
x = c(1, 3, 5, 15)
y = x1[x]; y
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
x = c(-1, -3, -5)
y = x1[x]; y
y = x1[-(2:6)]; y
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
names(x1) = letters[1:length(x1)]; x1
y = x1[c("a", "c", "f")]; y
y = x1[letters[3:8]]; y
y = x1[c("g", "a", "j", "d")]; y
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
y1 = x1[x1 < 5]; y1
y2 = x1[(-4 < x1) & (x1 < 3)]; y2
y3 = x1[(x1 <= -2) | (x1 > 3)]; y3
y4 = x1[!((-3 <= x1) & (x1 < 3))]; y4
y5 = x1[!is.na(x1)]; y5
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
x1[8] = NaN; x1
y6 = x1[!is.nan(x1)]; y6
x1 = c(10, -3, 6, 2, -4, NA, 1:5); x1
z = (x1 + 1)[(!is.na(x1)) & x1 > 0]; z
x = c(10, 4, 7, 9, 7, 8, 6, 14, 10, 10, 5, 8, 11, 11, 20)
length(x)
which(x > 10)
x[13]
y = which(x > 10)
x[y[2]]
x = c(10, 4, 7, 9, 7, 8, 6, 14, 10, 10, 5, 8, 11, 11, 20)
y = which(x %% 5 == 0); y
x[y[2]]
which.max(x)
which.min(x)
y = which(abs(x - 12) == min(abs(x - 12))); y
x[y]
matrix(1:6, nrow = 2, ncol = 3)
matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE, dimnames = list(c(1, 2), c("A", "B", "C")))
matrix(1:2, nrow = 2, ncol = 3)
matrix(1, nrow = 2, ncol = 3)
matrix(1:12, nrow = 5, ncol = 3)
matrix(1:12, ncol = 3)
A = matrix(1:12, ncol = 5); A
B = matrix(1:12, nrow = 5); B
nrow(A)
ncol(B)
dim(A)
C = cbind(A, B)
A = matrix(1:12, nrow = 3); A
B = matrix(13:24, nrow = 3); B
Z = cbind(A, B); Z
A = rbind(A, B); A
Z = rbind(A, B); Z
diag(1, 3, 3)
diag(nrow = 4)
X = matrix(1:16, nrow = 4); X
diag(X)
A = matrix(1:16, nrow = 4); A
View(A)
View(A)
View(A)
View(A)
fix(A)
A = matrix(1:9, nrow = 3)
B = matrix(-(1:9), ncol = 3, byrow = TRUE)
A
B
A + B
A + 3
B + 3
(1:3) * A
A * (1:3)
(1:9) + A
B^2
A = matrix(1:9, nrow = 3)
(0:3) * A
(0:9) * A
A = matrix(1:9, nrow = 3)
B = matrix(-(1:9), ncol = 3, byrow = TRUE)
sqrt(A)
log(abs(B))
x = 1:5; x
y = -2:3; y
outer(x, y, "*")
outer(x, y, "^")
x %o% y
A = matrix(1:9, nrow = 3)
B = matrix(-(1:9), ncol = 3, byrow = TRUE)
A %*% B
B %*% A
A = matrix(c(3, 4, 4, 4), nrow = 2); A
b = c(1, 0)
solve(A, b)
A = matrix(c(3, 0, 4, 4), nrow = 2); A
b = c(1, 1)
backsolve(A, b)
B = matrix(c(3, 4, 0, 4), nrow = 2); B
forwardsolve(B, b)
A = matrix(c(3, 0, 4, 4), nrow = 2); A
det(A)
solve(A)
X = matrix(c(1,2,4,2,1,1,3,1,2), nrow = 3); X
determinant(X)
X = matrix(c(1, 2, 4, 2, 1, 1, 3, 1, 2), nrow = 3); X
solve(X)
library(MASS)
ginv(X)
A = matrix(1:12, nrow = 3); A
colSums(A)
rowSums(A)
colMeans(A)
rowMeans(A)
X = matrix(c(1, 2, 4, 2, 1, 1, 3, 1, 2), nrow = 3)
eigen(X, symmetric = FALSE, only.values = FALSE)
X = matrix(c(1, 2, 4, 2, 1, 1, 3, 1, 2), nrow = 3); X
eigen(X)
X = matrix(c(1, 2, 4, 2, 1, 1, 3, 1, 2), nrow = 3); X
lower.tri(X, diag = FALSE)
X = matrix(c(1, 2, 4, 2, 1, 1, 3, 1, 2), nrow = 3); X
upper.tri(X, diag = FALSE)
A = matrix(1:12, nrow = 3)
rownames(A) = letters[1:nrow(A)]
colnames(A) = LETTERS[1:ncol(A)]
A
A['a', 'C']
A[2, 'B']
A[, 'B']
A['b', ]
A = array(1:60, c(3, 5, 4))
A
dim1 = c('A', 'B', 'C')
dim2 = c('X1', 'X2', 'X3', 'X4', 'X5')
dim3 = c('Зима', 'Весна', 'Лето', 'Осень')
dimnames(A) = list(dim1, dim2, dim3)
A
A[, , "Осень"]
A[, "X2", "Зима"]
writer <- list(
"Шекспир", "Уильям", "1564", "1616", TRUE,
"драматург", "Хатауэй Анна", 3,
"Ромео и Джульетта", "Гамлет", "Отелло"
)
writer
writer[[12]] <- "Англия"
writer
names(writer) <- c("фамилия", "имя", "год_рождения", "год_смерти",
"семейный_статус", "профессия", "имя_жены",
"число_детей", "произведение1", "произведение2",
"произведение3", "страна")
writer
names(writer)[12] <- "Страна"
writer
writer <- list(
фамилия = "Шекспир",
имя = "Уильям",
'год рождения' = "1564",
'год смерти' = "1616",
'семейное положение' = TRUE,
профессия = "драматург",
'имя жены' = "Хатауэй Анна",
'число детей' = 3,
произведение1 = "Ромео и Джульетта",
произведение2 = "Гамлет",
произведение3 = "Отелло"
)
writer$`имя жены`
writer$фамилия
writer$профессия
writer[['имя']]
writer[["имя"]]
Pushkin <- list(name = "Александр Сергеевич Пушкин", year = 1799)
Gogol <- list(name = "Николай Васильевич Гоголь", year = 1809)
lst <- list(Pushkin, Gogol)
lst[[1]]$name
length(lst)
clst <- c(Pushkin, Gogol)
clst
length(clst)
clst[[1]]
clst[[2]]
clst[[3]]
clst[[4]]
X
Y <- determinant(X)
Y
z <- unlist(Y)
z
Z = list(c(1), c(1))
Y = relist(z, Z)
Y
opros <- c(
rep("не знаю", 25),
rep("Андрей Рублев", 20),
rep("Иваново детство", 20),
rep("Сталкер", 20),
rep("Солярис", 20),
rep("Зеркало", 20),
rep("не знаю", 25)
)
length(opros)
opros_factor <- factor(opros)
opros_factor
levels(opros_factor)
opros2 <- opros[10:40]
opros2
is.ordered(opros2)
opros3 <- ordered(opros2)
opros3
is.ordered(opros3)
is.factor(opros2)
as.factor(opros2)
x = rep(c(1,5,7,3,2), 6)
y = factor(x)
is.vector(y)
z = as.vector(y)
is.vector(z)
gl(5, 3)
gl(5, 3, 15)
gl(5, 3, 12)
gl(5, 3, 25)
gl(5, 3, 15, labels = LETTERS[1:5])
gl(5, 3, 15, labels = c('категория1','категория2','категория3','категория4','категория5'))
gl(5, 3, 15, labels = c('категория1','категория2','категория3','категория4','категория5'), ordered = TRUE)
table(opros2)
opros2 <- c(opros2, rep(c(NA, NaN), times = c(6, 9)))
opros2
table(opros2[!is.nan(opros2)], exclude = NULL)
x <- rep(c(1,5,7,3,2), 6)
y <- factor(x)
y
is.table(x)
is.table(y)
z = as.table(x)
z
is.table(z)
z = as.table(y)
is.table(z)
as.vector(z)
Y = matrix(c(1988,1987,1989,1989,2005,2005,2006,2005), nrow = 4)
rownames(Y) = c("Иванов", "Ульянов", "Краснова", "Устюгов")
colnames(Y) = c("год рождения", "год поступления")
Y
n = c(FALSE, TRUE, FALSE, FALSE)
y = c(2, 1, 3, 2)
Y1 = data.frame(Y, n, y)
colnames(Y1)[3] = "задолженность"
colnames(Y1)[4] = "курс"
Y1
lst = list(1:4, FALSE, c("A", "B"))
data.frame(lst)
Y1["Иванов", "курс"]
Y1["Устюгов", ]
Y1[4, 3]
Y1[, c(2, 4)]
Y1$курс
Y1[["задолженность"]][3]
Y1[["задолженность"]][2]
x <- data.frame(a = letters[1:3], b = 1:3)
rownames(x) <- LETTERS[1:3]
x
write.table(x, file = "example.csv", sep = ",", row.names = TRUE, col.names = NA, qmethod = "double")
read.table("example.csv", header = TRUE, sep = ",", row.names = 1)
write.csv(x, file = "example.csv", row.names = TRUE)
read.csv("example.csv", row.names = 1)
savehistory(file="lab3.r")
