# Caso 1 - Web Analytics at Quality Alloys, Inc.
# Preguntas 8 y 9: modelado de la distribucion de libras vendidas y de las
# visitas diarias
# Autor: Camilo Hernandez

source("R/00_setup.R")

# Excel calcula la asimetria y la curtosis con las formulas muestrales de
# =SKEW() y =KURT(). La curtosis que reporta es en exceso, es decir cero para
# la normal. Se replican aqui para que los valores sean comparables con la
# salida que trae el caso
asimetria_excel <- function(x) {
  n <- length(x)
  z <- (x - mean(x)) / sd(x)
  n / ((n - 1) * (n - 2)) * sum(z^3)
}

curtosis_excel <- function(x) {
  n <- length(x)
  z <- (x - mean(x)) / sd(x)
  n * (n + 1) / ((n - 1) * (n - 2) * (n - 3)) * sum(z^4) -
    3 * (n - 1)^2 / ((n - 2) * (n - 3))
}

# Tabla de la regla empirica: intervalos simetricos alrededor de la media
regla_empirica <- function(x) {
  n <- length(x)
  z <- (x - mean(x)) / sd(x)
  tibble(intervalo = c("media +/- 1 desv. est.", "media +/- 2 desv. est.",
                       "media +/- 3 desv. est."),
         teorico_pct = c(68, 95, 99),
         teorico_obs = round(n * teorico_pct / 100),
         real_obs = c(sum(abs(z) <= 1), sum(abs(z) <= 2), sum(abs(z) <= 3)),
         real_pct = round(real_obs / n * 100, 1))
}

# Version detallada: cada cola por separado
regla_empirica_detalle <- function(x) {
  n <- length(x)
  z <- (x - mean(x)) / sd(x)
  tibble(intervalo = c("media a media + 1 desv. est.", "media - 1 desv. est. a media",
                       "1 a 2 desv. est.", "-1 a -2 desv. est.",
                       "2 a 3 desv. est.", "-2 a -3 desv. est."),
         teorico_pct = c(34, 34, 13.5, 13.5, 2, 2),
         teorico_obs = round(n * teorico_pct / 100),
         real_obs = c(sum(z > 0 & z <= 1), sum(z >= -1 & z <= 0),
                      sum(z > 1 & z <= 2), sum(z >= -2 & z < -1),
                      sum(z > 2 & z <= 3), sum(z >= -3 & z < -2)),
         real_pct = round(real_obs / n * 100, 1))
}

descriptivos <- function(x) {
  tibble(n = length(x),
         media = mean(x),
         mediana = median(x),
         desv_est = sd(x),
         minimo = min(x),
         maximo = max(x),
         rango = max(x) - min(x),
         asimetria = asimetria_excel(x),
         curtosis = curtosis_excel(x))
}

# ---- Pregunta 8a: descriptivos de libras vendidas, enero 2005 a julio 2010 ----
lbs <- lbs_largo$lbs_sold
desc_lbs <- descriptivos(lbs)
write_csv(desc_lbs, "output/tables/q8a_descriptivos_libras.csv")

# ---- Pregunta 8b: histograma ----
# Ancho de clase por la regla de la raiz del numero de observaciones
n_clases <- ceiling(sqrt(length(lbs)))
ancho_clase <- diff(range(lbs)) / n_clases

g8 <- ggplot(lbs_largo, aes(x = lbs_sold)) +
  geom_histogram(binwidth = ancho_clase, fill = "grey70", color = "white") +
  geom_vline(xintercept = mean(lbs), color = "#1f6feb", linewidth = 0.7) +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Distribucion de las libras de material vendidas por semana",
       subtitle = paste0("290 semanas, enero de 2005 a julio de 2010. En azul la media (",
                         scales::comma(round(mean(lbs))), " libras)"),
       x = "Libras vendidas por semana", y = "Numero de semanas") +
  tema_qa
guardar(g8, "q8_histograma_libras.png", ancho = 7.5, alto = 4.5)

# ---- Preguntas 8d y 8e: regla empirica ----
re_lbs <- regla_empirica(lbs)
re_lbs_detalle <- regla_empirica_detalle(lbs)
write_csv(re_lbs, "output/tables/q8d_regla_empirica_libras.csv")
write_csv(re_lbs_detalle, "output/tables/q8e_regla_empirica_detalle_libras.csv")

# ---- Pregunta 9: visitas diarias ----
vd <- visitas_diarias$visits
desc_visitas <- descriptivos(vd)
re_visitas <- regla_empirica(vd)
re_visitas_detalle <- regla_empirica_detalle(vd)

write_csv(desc_visitas, "output/tables/q9_descriptivos_visitas_diarias.csv")
write_csv(re_visitas, "output/tables/q9_regla_empirica_visitas_diarias.csv")
write_csv(re_visitas_detalle, "output/tables/q9_regla_empirica_detalle_visitas_diarias.csv")

g9 <- ggplot(visitas_diarias, aes(x = visits)) +
  geom_histogram(binwidth = diff(range(vd)) / ceiling(sqrt(length(vd))),
                 fill = "grey70", color = "white") +
  geom_vline(xintercept = mean(vd), color = "#1f6feb", linewidth = 0.7) +
  labs(title = "Distribucion de las visitas diarias al sitio web",
       subtitle = paste0("462 dias, 25 de mayo de 2008 a 29 de agosto de 2009. En azul la media (",
                         round(mean(vd)), " visitas)"),
       x = "Visitas por dia", y = "Numero de dias") +
  tema_qa
guardar(g9, "q9_histograma_visitas_diarias.png", ancho = 7.5, alto = 4.5)

# Comparacion lado a lado de las dos distribuciones, en puntaje z para que
# queden en la misma escala
comparacion <- bind_rows(
  tibble(serie = "Libras vendidas por semana", z = (lbs - mean(lbs)) / sd(lbs)),
  tibble(serie = "Visitas por dia", z = (vd - mean(vd)) / sd(vd)))

g9b <- ggplot(comparacion, aes(x = z)) +
  geom_histogram(binwidth = 0.4, fill = "grey70", color = "white") +
  facet_wrap(~ serie, scales = "free_y") +
  labs(title = "Las dos distribuciones en puntaje z",
       subtitle = "Las libras vendidas son casi simetricas, las visitas diarias tienen cola derecha larga",
       x = "Puntaje z (desviaciones estandar desde la media)", y = "Frecuencia") +
  tema_qa
guardar(g9b, "q9_comparacion_distribuciones.png", ancho = 9, alto = 4.5)

comparativo <- bind_rows(mutate(desc_lbs, serie = "Libras vendidas por semana"),
                         mutate(desc_visitas, serie = "Visitas por dia")) |>
  select(serie, everything())
write_csv(comparativo, "output/tables/q9_comparativo_distribuciones.csv")

cat("--- Libras vendidas por semana ---\n"); print(desc_lbs)
print(re_lbs); print(re_lbs_detalle)
cat("\n--- Visitas diarias ---\n"); print(desc_visitas)
print(re_visitas); print(re_visitas_detalle)
cat("\nAncho de clase del histograma de libras:", round(ancho_clase), "\n")
