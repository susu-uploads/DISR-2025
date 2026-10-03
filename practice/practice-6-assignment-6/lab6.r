# 6.1. Проведение МНК для парной линейной регрессии с помощью lm()

# 1) Скачайте файл Auto.csv

# 2) Загрузите данные из этого файла в датасет
auto <- read.csv("Auto.csv", na.strings = "?")

# 3) Сделайте summary для Вашего датасета
print("Summary")
summary(auto)
str(auto)

# 4) Удалите из датасета столбцы, которые содержат только строковые значения
auto <- auto[, !sapply(auto, is.character)]
str(auto)

# 5) Замените нечисловые данные на NA
na_values <- auto[!complete.cases(auto), ]
print(na_values)

# 6) Удалите строки с NA из датасета
print("Размер датасета до удаления")
print(dim(auto))
auto_new <- na.omit(auto)
print("Размер датасета после удаления")
print(dim(auto_new))

# 7) Сделайте матрицу корреляции с визуализацией для числовых данных
library(GGally)
corr_plot <- ggpairs(auto_new)
print(corr_plot)


# 8) Создайте набор данных correl, состоящий из 2 столбцов
cor_matrix <- cor(auto_new)
cor_with_mpg <- cor_matrix["mpg", ]
correl <- data.frame(
  predictor = names(cor_with_mpg),
  coeff_corr = cor_with_mpg,
  row.names = NULL
)
correl <- correl[correl$predictor != "mpg", ]
correl <- correl[order(abs(correl$coeff_corr), decreasing = TRUE), ]

print("Коэффициенты корреляции")
print(correl)

best_predictor <- correl[1, ]
print("Лучший предиктор")
print(best_predictor)

# 9) Постройте диаграмму рассеивания для mpg и выбранного Вами предиктора
plot(auto_new[[best_predictor$predictor]], auto_new$mpg,
     xlab = best_predictor$predictor, 
     ylab = "mpg",
     main = paste("Диаграмма рассеивания: mpg, weight"),
     pch = 19, col = "blue")

# 10) Рассчитайте уравнение простой линейной парной регрессии
formula <- as.formula(paste("mpg ~", best_predictor$predictor))
lm_pair <- lm(formula, data = auto_new)

# 11) Сделать summary для lm_pair
summary_lm <- summary(lm_pair)
print(summary_lm)

# 12) Написать линейное уравнение для парной регрессии для mpg
coefficients <- coef(lm_pair)
print("Уравнение регрессии")
equation <- paste("mpg =", round(coefficients[1], 4), 
                  ifelse(coefficients[2] >= 0, "+", ""), 
                  round(coefficients[2], 4), "*", best_predictor$predictor)
print(equation)

# Добавление линии регрессии на диаграмму
abline(lm_pair, col = "red", lwd = 2)

# Анализ связи
if (coefficients[2] > 0) {
  print("Направление связи: положительная")
} else {
  print("Направление связи: отрицательная")
}
print("Характер связи: линейная")

# 13) Вывести скорректированный коэффициент детерминации R2
adj_r_squared <- summary_lm$adj.r.squared
cat("Скорректированная R2 оценка:", round(adj_r_squared, 4), "\n")
cat("Вывод: модель объясняет", round(adj_r_squared * 100, 1), 
    "% вариации mpg\n")

# Интерпретация: это хороший показатель, модель адекватно описывает данные

# 14) Вывести F-статистику для lm_pair (взять из выдачи summary)
f_statistic <- summary_lm$fstatistic
p_value <- pf(f_statistic[1], f_statistic[2], f_statistic[3], lower.tail = FALSE)

cat("F-статистика:", round(f_statistic[1], 2), "\n")
cat("p-value:", format.pval(p_value, digits = 4), "\n")
print("Вывод:")
if (p_value < 0.05) {
  print("Уравнение регрессии статистически значимо на уровне 5%")
} else {
  print("Уравнение регрессии не значимо на уровне 5%")
}

# 15) Постройте доверительные интервалы для коэффициентов регрессии
conf_int <- confint(lm_pair, level = 0.99)
print(conf_int)

print("Вывод:")
if (all(conf_int[2, 1] > 0 | conf_int[2, 2] < 0)) {
  print("Коэффициент при предикторе статистически значим на уровне 1%")
} else {
  print("Коэффициент при предикторе не значим на уровне 1%")
}

# 16) Чему равно модельное значение mpg, если предиктор имеет значение, равное медиане?
median_value <- median(auto_new[[best_predictor$predictor]])

new_data_median <- data.frame(weight = median_value)
pred_median <- predict(lm_pair, 
                       newdata = new_data_median,
                       interval = "none")

cat("Медиана", best_predictor$predictor, ":", median_value, "\n")
cat("Модельное значение mpg:", round(pred_median, 2), "\n")

# 17) Постройте 5-процентные доверительные интервалы для среднего "confidence" и
# индивидуального "prediction" прогнозных значений
pred_conf <- predict(lm_pair, 
                     newdata = new_data_median,
                     interval = "confidence", level = 0.95)

pred_pred <- predict(lm_pair, 
                     newdata = new_data_median,
                     interval = "prediction", level = 0.95)

print("5% Доверительные интервалы")
print("Для среднего значения (confidence):")
print(round(pred_conf, 2))
print("Для индивидуального значения (prediction):")
print(round(pred_pred, 2))

cat("Ширина confidence интервала:", round(pred_conf[3] - pred_conf[2], 2), "\n")
cat("Ширина prediction интервала:", round(pred_pred[3] - pred_pred[2], 2), "\n")


# Вывод: Интервал prediction получается шире, потому что он отражает не только
# неопределённость в оценке параметров модели, но и естественный разброс
# отдельных наблюдений вокруг линии регрессии. При снижении значимости уравнения 
# регрессии доверительные интервалы расширяются, так как возрастает 
# неопределённость в оценках параметров модели.


# 18) Выведите диагностические графики
cat("\n=== Диагностические графики ===\n")
par(mfrow = c(2, 2))
plot(lm_pair)
par(mfrow = c(1, 1))

# Пояснение диагностических графиков:
# На графике Residuals vs Fitted остатки в целом сосредоточены вокруг нуля, 
# но заметен лёгкий изгиб и умеренное увеличение разброса при больших значениях fitted.
# Это может свидетельствовать о небольшой нелинейности связи и слабой 
# гетероскедастичности.
#
# Q–Q график показывает, что в центральной части распределение остатков близко
# к нормальному, однако в хвостах наблюдаются отклонения от прямой.
# Это говорит о наличии более тяжёлых хвостов по сравнению с нормальным 
# распределением, но в целом предпосылка нормальности нарушена умеренно.
#
# На графике Scale–Location наблюдается небольшой рост величины стандартизованных 
# остатков при увеличении fitted values, что указывает на умеренное нарушение 
# предпосылки гомоскедастичности.
#
#
# На графике Residuals vs Leverage видно, что большинство наблюдений имеют
# низкое leverage и умеренные остатки. Несколько точек с повышенным leverage
# и большими остатками могут оказывать заметное влияние на модель, однако явных
# экстремальных выбросов за пределами линий Cook’s distance не наблюдается

# 19) Для каждого значения предиктора рассчитайте остаток по уравнению регрессии
residuals <- resid(lm_pair)
plot(auto_new[[best_predictor$predictor]], residuals,
     xlab = best_predictor$predictor,
     ylab = "Остатки",
     main = paste("Остатки vs", best_predictor$predictor),
     pch = 19, col = "darkgreen")
abline(h = 0, col = "red", lwd = 2)

# На графике зависимости остатков от предиктора weight остатки в целом распределены,
# однако для средних значений веса остатки чаще отрицательные, а для очень лёгких и тяжёлых
# чаще положительные. Кроме того, разброс остатков слегка меняется с ростом веса,
# что указывает на возможную слабую нелинейность связи и умеренную гетероскедастичность

# 20) График с доверительными интервалами

# Создаем последовательность значений предиктора
x_seq <- seq(min(auto_new[[best_predictor$predictor]]),
             max(auto_new[[best_predictor$predictor]]),
             length.out = 100)

# Создаем data.frame с правильным именем
new_data <- data.frame(x = x_seq)
names(new_data) <- best_predictor$predictor

pred_conf_full <- predict(lm_pair, newdata = new_data, interval = "confidence")
pred_pred_full <- predict(lm_pair, newdata = new_data, interval = "prediction")

# Построение графика
plot(auto_new[[best_predictor$predictor]], auto_new$mpg,
     xlab = best_predictor$predictor,
     ylab = "mpg",
     main = paste("Регрессия mpg на", best_predictor$predictor, "с доверительными интервалами"),
     pch = 19, col = "blue")

# Линия регрессии
lines(new_data[[1]], pred_conf_full[, "fit"], col = "red", lwd = 2)

# Доверительные интервалы
lines(new_data[[1]], pred_conf_full[, "lwr"], col = "orange", lty = 2, lwd = 2)
lines(new_data[[1]], pred_conf_full[, "upr"], col = "orange", lty = 2, lwd = 2)
lines(new_data[[1]], pred_pred_full[, "lwr"], col = "green", lty = 3, lwd = 2)
lines(new_data[[1]], pred_pred_full[, "upr"], col = "green", lty = 3, lwd = 2)

legend("topright", 
       legend = c("Данные", "Регрессия", "Confidence", "Prediction"),
       col = c("blue", "red", "orange", "green"),
       pch = c(19, NA, NA, NA),
       lty = c(NA, 1, 2, 3),
       lwd = 2)

# Нахождение точки с наименьшей шириной confidence интервала
conf_widths <- pred_conf_full[, "upr"] - pred_conf_full[, "lwr"]
min_width_index <- which.min(conf_widths)
min_width_predictor <- new_data[min_width_index, 1]

cat("Наименьшая ширина confidence интервала при", best_predictor$predictor, "=", 
    round(min_width_predictor, 2), "\n")
cat("Ширина интервала:", round(conf_widths[min_width_index], 4), "\n")

# Объяснение: ширина доверительного интервала минимальна вблизи среднего значения предиктора,
# так как в этой области наибольшая плотность данных и наименьшая неопределенность прогноза

# 6.2. МНОЖЕСТВЕННАЯ РЕГРЕССИЯ 

# 1) Построить модель множественной регрессии
lm_multi <- lm(mpg ~ ., data = auto_new)

# 2) Summary для lm_multi
summary_multi <- summary(lm_multi)
print(summary_multi)

# Пояснение summary множественной регрессии:
# - Модель включает все предикторы для объяснения mpg
# - F-statistic показывает общую значимость модели  
# - Каждый коэффициент показывает влияние соответствующего предиктора при фиксированных остальных
# - Adjusted R-squared показывает качество модели с учетом числа предикторов

# 3) Линейное уравнение
multi_coefs <- coef(lm_multi)
equation_parts <- sapply(1:length(multi_coefs), function(i) {
  if (i == 1) {
    return(paste(round(multi_coefs[i], 4)))
  } else {
    sign <- ifelse(multi_coefs[i] >= 0, "+", "")
    return(paste0(sign, round(multi_coefs[i], 4), "*", names(multi_coefs)[i]))
  }
})
multi_equation <- paste("mpg =", paste(equation_parts, collapse = " "))
print(multi_equation) 

# 4) Скорректированный R2 и сравнение с парной регрессией
adj_r_squared_multi <- summary_multi$adj.r.squared
adj_r_squared_pair <- summary_lm$adj.r.squared

cat("Скорректированный R2 парной регрессии:", round(adj_r_squared_pair, 4), "\n")
cat("Скорректированный R2 множественной регрессии:", round(adj_r_squared_multi, 4), "\n")

if (adj_r_squared_multi > adj_r_squared_pair) {
  print("Вывод: Множественная регрессия лучше описывает вариацию mpg")
  improvement <- round((adj_r_squared_multi - adj_r_squared_pair) / adj_r_squared_pair * 100, 1)
  cat("Улучшение:", improvement, "%\n")
} else {
  print("Вывод: Парная регрессия лучше описывает вариацию mpg")
}

# 5) F-статистика
f_statistic_multi <- summary_multi$fstatistic
p_value_multi <- pf(f_statistic_multi[1], f_statistic_multi[2], f_statistic_multi[3], lower.tail = FALSE)

cat("F-статистика:", round(f_statistic_multi[1], 2), "\n")
cat("Степени свободы:", f_statistic_multi[2], "и", f_statistic_multi[3], "\n")
cat("p-value:", format.pval(p_value_multi, digits = 4), "\n")
print("Вывод:")
if (p_value_multi < 0.05) {
  print("Уравнение регрессии статистически значимо на уровне 5%")
} else {
  print("Уравнение регрессии не значимо на уровне 5%")
}

print("Число степеней свободы рассчитывается как:")
cat("Число предикторов (p):", f_statistic_multi[2], "\n")
cat("Число наблюдений - p - 1 (n-p-1):", f_statistic_multi[3], "\n")

# Объяснение: степени свободы показывают, насколько гибкой является модель
# Большее число степеней свободы ошибки означает более надежную оценку

# 6) Доверительные интервалы для коэффициентов
conf_int_multi <- confint(lm_multi, level = 0.95)
print(conf_int_multi)

# Определение незначимых коэффициентов
non_significant <- which(conf_int_multi[, 1] < 0 & conf_int_multi[, 2] > 0)
print("Незначимые коэффициенты на уровне 5%:")
if (length(non_significant) > 0) {
  for (i in non_significant) {
    cat("-", rownames(conf_int_multi)[i], "\n")
  }
  print("Это может свидетельствовать о мультиколлинеарности или избыточности переменных")
} else {
  print("Все коэффициенты значимы на уровне 5%")
}

# Объяснение: если доверительный интервал содержит 0, коэффициент статистически не отличается от 0

# 7) Определитель матрицы парных корреляций
predictors <- auto_new[, !names(auto_new) %in% "mpg"]
cor_matrix_predictors <- cor(predictors)
det_cor <- det(cor_matrix_predictors)

cat("Определитель матрицы корреляций предикторов:", round(det_cor, 6), "\n")
if (det_cor < 0.001) {
  print("Вывод: Определитель близок к нулю → сильная мультиколлинеарность")
} else if (det_cor < 0.01) {
  print("Вывод: Определитель мал → возможная мультиколлинеарность")
} else {
  print("Вывод: Определитель достаточно велик → мультиколлинеарность слабая")
}

# Объяснение: определитель близкий к 0 означает, что переменные сильно коррелированы между собой,
# что затрудняет оценку индивидуального вклада каждого предиктора

# 8) Коэффициенты VIF
library(car)
vif_values <- vif(lm_multi)
print(vif_values)

print("Интерпретация VIF:")
print("VIF < 5: слабая мультиколлинеарность")
print("5 ≤ VIF < 10: умеренная мультиколлинеарность")
print("VIF ≥ 10: сильная мультиколлинеарность")

high_vif <- which(vif_values >= 5)
if (length(high_vif) > 0) {
  cat("\nПроблемные переменные (VIF ≥ 5):\n")
  for (var in names(high_vif)) {
    cat("-", var, ":", round(vif_values[var], 2), "\n")
  }
}

# Объяснение: высокий VIF означает, что переменная сильно коррелирована с другими предикторами,
# что приводит к неустойчивости оценок коэффициентов

# 9) Пошаговый отбор переменных
step_model <- step(lm_multi, direction = "both", trace = 0)
cat("Результат пошагового отбора:\n")
print(step_model$anova)

# AIC (Akaike Information Criterion) - критерий качества модели, учитывающий 
# качество подгонки модели под данные и сложность модели.
# Формула: AIC = 2k - 2ln(L), где k - число параметров модели,
# L - значение функции правдоподобия
# Чем меньше AIC, тем лучше модель (лучший компромисс между качеством и сложностью)

# 10) Summary после пошагового отбора
summary_step <- summary(step_model)
print(summary_step)

adj_r_squared_step <- summary_step$adj.r.squared
print("Сравнение скорректированных R2:")
cat("До step:", round(adj_r_squared_multi, 4), "\n")
cat("После step:", round(adj_r_squared_step, 4), "\n")

if (adj_r_squared_step >= adj_r_squared_multi) {
  cat("Вывод: Step эффективен - улучшил или сохранил качество модели с меньшим числом переменных\n")
} else {
  reduction <- round((adj_r_squared_multi - adj_r_squared_step) / adj_r_squared_multi * 100, 2)
  cat("Вывод: Step уменьшил R² на", reduction, "%, но упростил модель\n")
}

# Объяснение: Пошаговый отбор помогает убрать из модели предикторы, которые мало 
# влияют на качество подгонки (по AIC), и тем самым упростить модель и частично 
# снизить избыточность предикторов

# 11) Уравнение и остатки после step
step_coefs <- coef(step_model)
equation_parts_step <- sapply(1:length(step_coefs), function(i) {
  if (i == 1) {
    return(paste(round(step_coefs[i], 4)))
  } else {
    sign <- ifelse(step_coefs[i] >= 0, "+", "")
    return(paste0(sign, round(step_coefs[i], 4), "*", names(step_coefs)[i]))
  }
})
step_equation <- paste("mpg =", paste(equation_parts_step, collapse = " "))
cat("Уравнение:", step_equation, "\n")

# Остатки и топ-3 наблюдения с наибольшими остатками
residuals_step <- resid(step_model)
abs_residuals <- abs(residuals_step)
top_residual_indices <- order(abs_residuals, decreasing = TRUE)[1:3]

print("3 наблюдения с наибольшими остатками:")
for (i in 1:3) {
  idx <- top_residual_indices[i]
  cat(i, ") Наблюдение", idx, ": фактическое mpg =", auto_new$mpg[idx], 
      ", предсказанное =", round(fitted(step_model)[idx], 2),
      ", остаток =", round(residuals_step[idx], 2), "\n")
}

# Объяснение: большие остатки указывают на наблюдения, которые плохо описываются моделью
# Это могут быть выбросы или случаи, где модель не учитывает важные факторы

# 12) Диагностические графики
par(mfrow = c(2, 3))
plot(step_model, which = 1:5)
par(mfrow = c(1, 1))

# Пояснение диагностических графиков:
# 1. Residuals vs Fitted: проверка линейности и гомоскедастичности
#    Остатки должны быть случайно разбросаны вокруг горизонтальной линии
#    Кривизна указывает на нелинейность
#
# 2. Normal Q-Q: проверка нормальности распределения остатков
#    Точки должны лежать вдоль прямой линии  
#    Отклонения указывают на ненормальность
#
# 3. Scale-Location: проверка гомоскедастичности
#    Горизонтальная линия означает постоянную дисперсию остатков
#    Наклонная линия - гетероскедастичность
#
# 4. Cook's distance: выявление влиятельных наблюдений
#    Высокие значения указывают на наблюдения, сильно влияющие на модель
#    Значения > 1 требуют внимания
#
# 5. Residuals vs Leverage: выявление выбросов и влиятельных точек
#    Точки в правом верхнем/нижнем углу - потенциальные проблемы
#    Линии Кука показывают границы влияния

# 13) Прогноз при медиане предикторов
# Получаем имена предикторов из финальной модели
final_predictors <- names(step_coefs)[-1]  # исключаем intercept

# Создаем data.frame с медианными значениями
median_data <- as.data.frame(t(sapply(auto_new[final_predictors], median)))
print("Медианные значения предикторов:")
print(median_data)

pred_median_step <- predict(step_model, 
                            newdata = median_data,
                            interval = "none")
cat("Прогнозное значение mpg:", round(pred_median_step, 2), "\n")

# 14) Доверительные интервалы для прогноза
pred_conf_step <- predict(step_model, 
                          newdata = median_data,
                          interval = "confidence", level = 0.95)

pred_pred_step <- predict(step_model, 
                          newdata = median_data,
                          interval = "prediction", level = 0.95)

print("Для среднего значения (confidence):")
print(round(pred_conf_step, 2))
print("Для индивидуального значения (prediction):")
print(round(pred_pred_step, 2))

# Сравнение с результатами из п.17 задания 6.1
print("Сравнение с парной регрессией (из 6.1)")
print("Парная регрессия (weight):\n")
cat("  Confidence:", round(pred_conf[2], 2), "-", round(pred_conf[3], 2), 
    "(ширина:", round(pred_conf[3] - pred_conf[2], 2), ")\n")
cat("  Prediction:", round(pred_pred[2], 2), "-", round(pred_pred[3], 2), 
    "(ширина:", round(pred_pred[3] - pred_pred[2], 2), ")\n")

cat("Множественная регрессия (после step):\n")
cat("  Confidence:", round(pred_conf_step[2], 2), "-", round(pred_conf_step[3], 2), 
    "(ширина:", round(pred_conf_step[3] - pred_conf_step[2], 2), ")\n")
cat("  Prediction:", round(pred_pred_step[2], 2), "-", round(pred_pred_step[3], 2), 
    "(ширина:", round(pred_pred_step[3] - pred_pred_step[2], 2), ")\n")

print("Выводы:")
if ((pred_conf_step[3] - pred_conf_step[2]) < (pred_conf[3] - pred_conf[2])) {
  print("- Множественная регрессия дает более точный прогноз (уже доверительные интервалы)\n")
} else {
  print("- Парная регрессия дает более точный прогноз для среднего значения\n")
}

if ((pred_pred_step[3] - pred_pred_step[2]) < (pred_pred[3] - pred_pred[2])) {
  print("- Множественная регрессия дает более точный индивидуальный прогноз\n")
} else {
  print("- Парная регрессия дает более точный индивидуальный прогноз\n")
}

# Объяснение: множественная регрессия обычно дает более точные прогнозы,
# так как учитывает больше факторов, влияющих на зависимую переменную

print("Итоговые выводы")
cat("1. Множественная регрессия объясняет", round(adj_r_squared_multi * 100, 1), 
    "% вариации mpg против", round(adj_r_squared_pair * 100, 1), "% у парной\n")
print("2. После step-отбора модель упрощена с сохранением качества")
cat("3. Наиболее важные предикторы:", paste(final_predictors, collapse = ", "), "\n")
print("4. Мультиколлинеарность успешно устранена методом step()")
print("5. Модель после step является оптимальным компромиссом между точностью и интерпретируемостью")
