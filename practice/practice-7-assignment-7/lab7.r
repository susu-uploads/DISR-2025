# ПОДГОТОВКА СРЕДЫ И ПАКЕТОВ
# install.packages(c("ggplot2", "dplyr", "readr"))
library(ggplot2)
library(dplyr)
library(readr)

# ЗАГРУЗКА ДАННЫХ
data(mtcars)
head(mtcars)

# 7.1. БАЗОВЫЕ ДИАГРАММЫ

# 7.1.1. СТОЛБЧАТАЯ ДИАГРАММА
# 7.1.1.1 Среднее mpg по количеству цилиндров
mpg_by_cyl <- tapply(mtcars$mpg, mtcars$cyl, mean)

# 7.1.1.2 Столбчатая диаграмма с цветами и подписями
colors <- c("lightblue", "lightgreen", "lightcoral")
bp <- barplot(mpg_by_cyl, 
              main = "Средний расход топлива по количеству цилиндров",
              xlab = "Количество цилиндров", 
              ylab = "Средний mpg",
              col = colors,
              ylim = c(0, max(mpg_by_cyl) + 5))
text(x = bp, y = mpg_by_cyl, 
     labels = round(mpg_by_cyl, 1), 
     pos = 3, cex = 0.8)
legend("topright", 
       legend = names(mpg_by_cyl),
       fill = colors,
       title = "Цилиндры")

# 7.1.2. КРУГОВАЯ ДИАГРАММА
cyl_counts <- table(mtcars$cyl)

# 7.1.2.2 С подписями процентов
pie(cyl_counts, 
    main = "Доля автомобилей по количеству цилиндров",
    labels = paste0(names(cyl_counts), " цил. (", 
                    round(prop.table(cyl_counts)*100, 1), "%)"))

# 7.1.2.3 С цветами rainbow
pie(cyl_counts, 
    main = "Доля автомобилей по количеству цилиндров (rainbow)",
    col = rainbow(length(cyl_counts)),
    labels = paste0(names(cyl_counts), " цил. (", 
                    round(prop.table(cyl_counts)*100, 1), "%)"))

# 7.1.2.4 С заданными цветами
custom_colors <- c("blue", "red", "green")
pie(cyl_counts, 
    main = "Доля автомобилей по количеству цилиндров (custom)",
    col = custom_colors,
    labels = paste0(names(cyl_counts), " цил. (", 
                    round(prop.table(cyl_counts)*100, 1), "%)"))

# 7.1.2.5 С colorRampPalette
color_palette <- colorRampPalette(c("lightblue", "darkblue"))(length(cyl_counts))
pie(cyl_counts, 
    main = "Доля автомобилей по количеству цилиндров (gradient)",
    col = color_palette,
    labels = paste0(names(cyl_counts), " цил. (", 
                    round(prop.table(cyl_counts)*100, 1), "%)"))

# 7.1.3. ГИСТОГРАММА
# 7.1.3.1 Распределение лошадиных сил
hist(mtcars$hp,
     main = "Распределение лошадиных сил",
     xlab = "Лошадиные силы (hp)",
     ylab = "Частота",
     col = "lightblue")

# 7.1.3.2 Настройка количества интервалов
hist(mtcars$hp,
     main = "Распределение лошадиных сил (15 интервалов)",
     xlab = "Лошадиные силы (hp)",
     ylab = "Частота",
     col = "lightgreen",
     breaks = 15)

# 7.1.3.4 Изменение шага оси Y
hist(mtcars$hp,
     main = "Распределение лошадиных сил (шаг оси Y = 2)",
     xlab = "Лошадиные силы (hp)",
     ylab = "Частота",
     col = "lightcoral",
     breaks = 15,
     ylim = c(0, 10),
     yaxt = "n")
axis(2, at = seq(0, 10, by = 2))

# 7.1.4. ДИАГРАММА РАССЕЯНИЯ
# 7.1.4.1 Зависимость mpg от веса
plot(mtcars$wt, mtcars$mpg,
     main = "Зависимость расхода топлива от веса автомобиля",
     xlab = "Вес (тыс. фунтов)",
     ylab = "Расход топлива (mpg)",
     pch = 19,
     col = "blue")

# 7.1.4.2 Добавление линии регрессии
plot(mtcars$wt, mtcars$mpg,
     main = "Зависимость расхода топлива от веса с линией регрессии",
     xlab = "Вес (тыс. фунтов)",
     ylab = "Расход топлива (mpg)",
     pch = 19,
     col = "darkred")
abline(lm(mpg ~ wt, data = mtcars), 
       col = "blue", lwd = 2)

# 7.2. ПРОДВИНУТАЯ ВИЗУАЛИЗАЦИЯ (GGPLOT2)

# 7.2.1. ТОЧЕЧНАЯ ДИАГРАММА С ЦВЕТОВОЙ ГРУППИРОВКОЙ
# 7.2.1.1 Точечная диаграмма с группировкой по cyl
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  labs(title = "Зависимость расхода топлива от веса",
       x = "Вес (тыс. фунтов)",
       y = "Расход топлива (mpg)",
       color = "Цилиндры") +
  theme_minimal()

# 7.2.1.2 Добавление сглаживающей линии
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  geom_smooth(method = "lm") +
  labs(title = "Зависимость расхода топлива от веса со сглаживанием",
       x = "Вес (тыс. фунтов)",
       y = "Расход топлива (mpg)",
       color = "Цилиндры") +
  theme_minimal()

# 7.2.1.3 Добавление эллипсов рассеивания
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  geom_smooth(method = "lm") +
  stat_ellipse(level = 0.95) +
  labs(title = "Зависимость расхода топлива от веса с эллипсами",
       x = "Вес (тыс. фунтов)",
       y = "Расход топлива (mpg)",
       color = "Цилиндры") +
  theme_minimal()

# 7.2.2. ЯЩИК С УСАМИ
# 7.2.2.1 Распределение mpg по группам cyl
ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  labs(title = "Распределение расхода топлива по количеству цилиндров",
       x = "Количество цилиндров",
       y = "Расход топлива (mpg)",
       fill = "Цилиндры") +
  theme_minimal()

# 7.2.2.2 Добавление точек наблюдений
ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.6) +
  labs(title = "Распределение расхода топлива по количеству цилиндров",
       x = "Количество цилиндров",
       y = "Расход топлива (mpg)",
       fill = "Цилиндры") +
  theme_minimal()

# 7.2.3. ГИСТОГРАММА С ФАСЕТИРОВАНИЕМ
ggplot(mtcars, aes(x = hp, fill = factor(cyl))) +
  geom_histogram(binwidth = 20, alpha = 0.7, color = "black") +
  facet_wrap(~cyl, scales = "free_y") +
  labs(title = "Распределение лошадиных сил по количеству цилиндров",
       x = "Лошадиные силы (hp)",
       y = "Частота",
       fill = "Цилиндры") +
  theme_minimal()
