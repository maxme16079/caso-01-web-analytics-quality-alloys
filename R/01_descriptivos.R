# Caso 1 - Web Analytics at Quality Alloys, Inc.
# Preguntas 1 a 4: estadisticos descriptivos por periodo
# Autor: Maximo Van Fulpen

source("R/00_setup.R")

# ---- Pregunta 1: series semanales de las cuatro variables ----
# La promocion se resalta en color y el resto queda en gris, siguiendo la
# recomendacion de la lecture de DataViz
series <- qa |>
  select(n_semana, semana, periodo, unique_visits, revenue, profit, lbs_sold) |>
  pivot_longer(cols = c(unique_visits, revenue, profit, lbs_sold),
               names_to = "variable", values_to = "valor")

etiquetas <- c(unique_visits = "Visitas unicas por semana",
               revenue = "Ingresos por semana (USD)",
               profit = "Utilidad por semana (USD)",
               lbs_sold = "Libras vendidas por semana")

for (v in names(etiquetas)) {
  g <- series |>
    filter(variable == v) |>
    ggplot(aes(x = n_semana, y = valor, fill = periodo == "Promotion")) +
    geom_col() +
    scale_fill_manual(values = c(`TRUE` = "#1f6feb", `FALSE` = "grey70")) +
    scale_y_continuous(labels = scales::comma) +
    labs(title = etiquetas[[v]],
         subtitle = "Semanas del 25 de mayo de 2008 al 29 de agosto de 2009. En azul, el periodo de promocion",
         x = "Semana (1 = 25 de mayo de 2008)", y = etiquetas[[v]]) +
    tema_qa +
    theme(legend.position = "none")
  guardar(g, paste0("q1_", v, "_semanal.png"))
}

# ---- Pregunta 2: 25 estadisticos por periodo ----
resumen_periodos <- qa |>
  select(periodo, visits, unique_visits, revenue, profit, lbs_sold) |>
  pivot_longer(cols = -periodo, names_to = "variable", values_to = "valor") |>
  group_by(periodo, variable) |>
  summarise(media = mean(valor),
            mediana = median(valor),
            desv_est = sd(valor),
            minimo = min(valor),
            maximo = max(valor),
            .groups = "drop") |>
  mutate(variable = factor(variable, levels = c("visits", "unique_visits",
                                                "revenue", "profit", "lbs_sold"))) |>
  arrange(periodo, variable)

write_csv(resumen_periodos, "output/tables/q2_resumen_por_periodo.csv")

# ---- Pregunta 3: medias de cada variable en los cuatro periodos ----
medias <- resumen_periodos |>
  select(periodo, variable, media)

write_csv(pivot_wider(medias, names_from = variable, values_from = media),
          "output/tables/q3_medias_por_periodo.csv")

etiquetas_medias <- c(visits = "Visitas promedio por semana",
                      unique_visits = "Visitas unicas promedio por semana",
                      revenue = "Ingresos promedio por semana (USD)",
                      profit = "Utilidad promedio por semana (USD)",
                      lbs_sold = "Libras vendidas promedio por semana")

for (v in names(etiquetas_medias)) {
  g <- medias |>
    filter(variable == v) |>
    ggplot(aes(x = periodo, y = media, fill = periodo == "Promotion")) +
    geom_col(width = 0.65) +
    geom_text(aes(label = scales::comma(media, accuracy = 1)), vjust = -0.4, size = 3.2) +
    scale_fill_manual(values = c(`TRUE` = "#1f6feb", `FALSE` = "grey70")) +
    scale_y_continuous(labels = scales::comma, expand = expansion(mult = c(0, 0.12))) +
    labs(title = etiquetas_medias[[v]],
         subtitle = "Promedio de cada uno de los cuatro periodos del caso",
         x = "Periodo", y = etiquetas_medias[[v]]) +
    tema_qa +
    theme(legend.position = "none")
  guardar(g, paste0("q3_media_", v, ".png"), ancho = 7, alto = 4.5)
}

# ---- Pregunta 4: variaciones que sustentan la interpretacion ----
# Cambio porcentual de cada media contra el periodo pre-promotion, que es el
# nivel estable inmediatamente anterior a la promocion
cambios <- medias |>
  pivot_wider(names_from = periodo, values_from = media) |>
  mutate(var_promo_vs_pre = (Promotion / `Pre-Promotion` - 1) * 100,
         var_post_vs_pre = (`Post-Promotion` / `Pre-Promotion` - 1) * 100)

write_csv(cambios, "output/tables/q4_cambios_porcentuales.csv")

print(resumen_periodos, n = 100)
print(cambios)
