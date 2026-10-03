'a' < 'b'
'иэ' >= 'ия'
'иэ' != 'ия'
'и' > 'э'
c('и', 'вг') >= 'вв'
x = 10000; y = 'a'; x > y
x = 10000; y = 'a'; y > x
x = F; y = T
x < y
x = 10; y = NA
x > y
x = NA; y = NaN; x >= y
x = 0.235; xfor
x = .235; x
x = 23.5e-2; x
x = 235E-3; x
x = 0.00235e2; x
2 * (7 - 9)^8 + 6 / 3
'+'(2,3)
'/'(9,2)
x = exp(2); x
log(x)
logb(x)
log10(100)
log(8)
log1p(0.01)
log1p(-0.99999)
log(125, base = 5)
logb(256, base = 16)
x = 1.5555
ceiling(x)
floor(x)
trunc(x)
y = -1.5
ceiling(y)
floor(y)
trunc(y)
x = 1/33; x
round(x)
round(x, 4)
signif(x, 5)
x = -5; y = F; abs(x)
abs(y)
z = T; abs(z)
z = 5 - 1i*2; abs(z)
x = 4; sqrt(x)
y = -4; sqrt(y)
y = as.complex(y); sqrt(y)
x = -8.9; gamma(x)
x = 2.15; gamma(x)
digamma(x)
psigamma(x)
trigamma(x)
a = 2; b = 3
beta(a, b)
lbeta(a, b)
n = 5.4; k = 3; x = 4.6; x1 = 4
choose(n, k)
choose(round(n), k)
factorial(x)
factorial(x1)
sin(pi/6)
cos(pi/3)
tan(pi/4)
asin(0.5)
acos(0.5)
atan(1)
y <- 1
x <- 1
atan2(y, x)
cosh(1)
acosh(1.5)
sinh(1)
asinh(1)
tanh(1)
atanh(0.5)
x = 5 + 1i*5
y = 4 - 1i*5
x + y
x - y
x * y
x / y
x ^ y
x = 2 + 1i*2
y = 2 - 1i*3
Re(x)
Im(y)
Mod(x)
Arg(x)
Conj(x)
cos(x)
x = 5
y = 4
if (x > y) {
z = x + y
z
}
x = 5
y = 4
if (x < y) {
w = x + y
}
x = 1:10
y = 10:1
if (all(x < y)) {
x / y
}
x = 5
y = 4
if (x < y) {
x + y
} else {
x - y
}
x = c(1,3,1,5,1,7,1,9)
y = c(2,3,4,5,2,7,1,8)
z = ifelse(x == y, 1:10, (-1):(-10))
sqrt(ifelse(x >= 0, x, NA))
x = rep(c(1,2,3), 3)
x = matrix(x, 3, 3)z
z = cos(ifelse(1 < x, x * pi, x * pi / 2))
x = 1:10
y = 10:1
w = vector(length = 10, mode = 'numeric')
for (i in 1:10) {
if (x[i] < y[i]) {
w[i] = x[i] / y[i]
} else {
w[i] = x[i] * y[i]
}
}
x = 1:10
y = 10:1
for (i in 1:10) {
if (x[i] < y[i]) {
w = x[i] / y[i]
} else {
w = x[i] * y[i]
}
}
c = integer(0)
for (i in c) {
m = i
}
x = -10
while (x < 0) {
z = x
x = x + 1
}
t = -10
repeat {
if (t > 0) break
f = log(abs(t))
t = t + 1
}
for (i in 1:10) {
if (i %% 2 == 0) {
next
}
print(i)
}
x = numeric(5)
for (i in 1:5) {
x[i] = switch(i, cos(pi), exp(1), log2(4), log10(0.01), TRUE)
}
x
savehistory(file="lab2.r")
