# Caso 1 - Web Analytics at Quality Alloys, Inc.
# Carga de datos y definicion de los cuatro periodos
# Autor: Maximo Van Fulpen

library(tidyverse)
library(readxl)
library(moments)

ruta <- "data/Web_Analytics.xls"

# Hoja Weekly Visits: el encabezado real esta en la fila 5 del archivo
weekly_visits <- read_excel(ruta, sheet = "Weekly Visits", skip = 4) |>
  rename(semana = 1, visits = 2, unique_visits = 3, pageviews = 4,
         pages_visit = 5, avg_time = 6, bounce_rate = 7, pct_new = 8)

financials <- read_excel(ruta, sheet = "Financials", skip = 4) |>
  select(1:5) |>
  rename(semana = 1, revenue = 2, profit = 3, lbs_sold = 4, inquiries = 5)

# Base semanal unificada con la particion en los cuatro periodos del caso.
# Los cortes se tomaron del sombreado de la hoja Weekly Visits del archivo
# original, que marca el periodo initial y el de promocion:
#   Initial        semanas  1-14  25 may 2008 - 30 ago 2008
#   Pre-Promotion  semanas 15-35  31 ago 2008 - 17 ene 2009
#   Promotion      semanas 36-52  18 ene 2009 - 23 may 2009
#   Post-Promotion semanas 53-66  24 may 2009 - 29 ago 2009
qa <- weekly_visits |>
  bind_cols(financials |> select(revenue, profit, lbs_sold, inquiries)) |>
  mutate(n_semana = row_number(),
         periodo = case_when(n_semana <= 14 ~ "Initial",
                             n_semana <= 35 ~ "Pre-Promotion",
                             n_semana <= 52 ~ "Promotion",
                             TRUE ~ "Post-Promotion"),
         periodo = factor(periodo, levels = c("Initial", "Pre-Promotion",
                                              "Promotion", "Post-Promotion")))

# Hoja Lbs. Sold: serie larga, enero 2005 a julio 2010
lbs_largo <- read_excel(ruta, sheet = "Lbs. Sold", skip = 4) |>
  rename(semana = 1, lbs_sold = 2) |>
  mutate(fecha = as.Date(semana)) |>
  filter(!is.na(lbs_sold))

visitas_diarias <- read_excel(ruta, sheet = "Daily Visits", skip = 4) |>
  rename(dia = 1, visits = 2) |>
  filter(!is.na(visits)) |>
  mutate(fecha = seq(as.Date("2008-05-25"), by = "day", length.out = n()))

# Hoja Demographics: seis bloques apilados en la misma hoja. El titulo de cada
# bloque esta en la fila que trae el numero, asi que se propaga hacia abajo
demograficos <- read_excel(ruta, sheet = "Demographics", col_names = FALSE) |>
  rename(bloque = 1, categoria = 2, visits = 3) |>
  mutate(titulo = if_else(!is.na(bloque), categoria, NA_character_)) |>
  fill(titulo) |>
  filter(!is.na(categoria), !is.na(visits), visits != "Visits", categoria != titulo) |>
  mutate(visits = as.numeric(visits)) |>
  select(titulo, categoria, visits)

# Tema comun para todas las graficas del caso
tema_qa <- theme_minimal(base_size = 11) +
  theme(plot.title = element_text(face = "bold"),
        panel.grid.minor = element_blank())

guardar <- function(grafica, nombre, ancho = 8, alto = 4.5) {
  ggsave(file.path("output/figures", nombre), grafica,
         width = ancho, height = alto, dpi = 300)
}
