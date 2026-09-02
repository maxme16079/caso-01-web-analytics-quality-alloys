# Caso 1 - Web Analytics at Quality Alloys, Inc.
# Pregunta 10: representacion grafica de los datos demograficos
# Autor: Camilo Hernandez

source("R/00_setup.R")

# Los seis bloques de la hoja Demographics, con su participacion sobre el total
demo <- demograficos |>
  group_by(titulo) |>
  mutate(participacion = visits / sum(visits) * 100,
         destacado = visits == max(visits)) |>
  ungroup()

write_csv(demo, "output/tables/q10_demograficos.csv")

titulos <- c("All Traffic Sources" = "Visitas por tipo de fuente de trafico",
             "Top Ten Referring Sites" = "Diez sitios que mas remiten visitas",
             "Top Ten Search Engine Sources of Visits" = "Diez motores de busqueda que mas visitas traen",
             "Top Ten Geographic Sources by Sub Continent Region" = "Diez regiones que mas visitas generan",
             "Top Ten Browsers Used" = "Diez navegadores mas usados",
             "Top Ten Operating Systems Used" = "Diez sistemas operativos mas usados")

archivos <- c("All Traffic Sources" = "q10_1_fuentes_trafico.png",
              "Top Ten Referring Sites" = "q10_2_sitios_remitentes.png",
              "Top Ten Search Engine Sources of Visits" = "q10_3_motores_busqueda.png",
              "Top Ten Geographic Sources by Sub Continent Region" = "q10_4_regiones.png",
              "Top Ten Browsers Used" = "q10_5_navegadores.png",
              "Top Ten Operating Systems Used" = "q10_6_sistemas_operativos.png")

# Barras horizontales en orden descendente. La categoria mas grande queda en
# azul y el resto en gris, para que el ojo vaya primero a lo que importa
for (t in names(titulos)) {
  datos <- demo |> filter(titulo == t)
  g <- ggplot(datos, aes(x = visits, y = reorder(categoria, visits), fill = destacado)) +
    geom_col() +
    geom_text(aes(label = paste0(scales::comma(visits), "  (",
                                 round(participacion, 1), "%)")),
              hjust = -0.05, size = 3) +
    scale_fill_manual(values = c(`TRUE` = "#1f6feb", `FALSE` = "grey70")) +
    scale_x_continuous(labels = scales::comma, expand = expansion(mult = c(0, 0.25))) +
    labs(title = titulos[[t]],
         subtitle = "Visitas acumuladas del 25 de mayo de 2008 al 29 de agosto de 2009",
         x = "Visitas", y = NULL) +
    tema_qa +
    theme(legend.position = "none", panel.grid.major.y = element_blank())
  guardar(g, archivos[[t]], ancho = 8, alto = 4.8)
}

# Cuadro de participaciones que sustenta la lectura de cada grafica
resumen_demo <- demo |>
  group_by(titulo) |>
  slice_max(visits, n = 3) |>
  mutate(participacion = round(participacion, 1)) |>
  select(titulo, categoria, visits, participacion) |>
  ungroup()

write_csv(resumen_demo, "output/tables/q10_top3_por_bloque.csv")
print(resumen_demo, n = 30)

# Cuanto pesan los dos dominios de anuncios de Google dentro de los sitios
# remitentes, dato clave para la recomendacion de inversion
remitentes <- demo |> filter(titulo == "Top Ten Referring Sites")
cat("\nParticipacion de doubleclick + googlesyndication en el top 10 de remitentes:",
    round(sum(remitentes$participacion[1:2]), 1), "%\n")
