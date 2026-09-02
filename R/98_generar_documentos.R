# Caso 1 - Web Analytics at Quality Alloys, Inc.
# Convierte los documentos en markdown a Word, insertando las graficas en la
# pregunta que les corresponde. El paso de Word a PDF lo hace un script aparte
# Autor: Maximo Van Fulpen

library(officer)
library(flextable)
library(tidyverse)

# Quita las marcas de markdown que no se pueden representar como texto plano
limpiar <- function(x) {
  x |>
    str_replace_all("\\*\\*(.+?)\\*\\*", "\\1") |>
    str_replace_all("\\*(.+?)\\*", "\\1") |>
    str_replace_all("`(.+?)`", "\\1") |>
    str_replace_all("\\[(.+?)\\]\\(.+?\\)", "\\1")
}

# Las graficas de cada pregunta, para insertarlas al cierre de su seccion
figuras_de <- function(n) {
  patron <- paste0("^q", n, "_")
  archivos <- list.files("output/figures", pattern = patron, full.names = TRUE)
  sort(archivos)
}

texto_normal <- fp_text(font.family = "Calibri", font.size = 11)
texto_h1 <- fp_text(font.family = "Calibri", font.size = 20, bold = TRUE)
texto_h2 <- fp_text(font.family = "Calibri", font.size = 14, bold = TRUE,
                    color = "#1f4e79")
texto_h3 <- fp_text(font.family = "Calibri", font.size = 12, bold = TRUE)

tabla_desde_markdown <- function(lineas) {
  celdas <- lineas |>
    str_remove("^\\|") |>
    str_remove("\\|$") |>
    str_split("\\|") |>
    map(~ limpiar(str_trim(.x)))
  encabezado <- celdas[[1]]
  cuerpo <- celdas[-c(1, 2)]
  ancho <- length(encabezado)
  cuerpo <- keep(cuerpo, ~ length(.x) == ancho)
  datos <- as.data.frame(do.call(rbind, cuerpo), stringsAsFactors = FALSE)
  names(datos) <- ifelse(encabezado == "", paste0("v", seq_along(encabezado)), encabezado)
  flextable(datos) |>
    theme_booktabs() |>
    fontsize(size = 9, part = "all") |>
    font(fontname = "Calibri", part = "all") |>
    bold(part = "header") |>
    autofit()
}

# Recorre el markdown linea por linea y va escribiendo en el documento
convertir <- function(ruta_md, ruta_docx, con_figuras = FALSE) {
  lineas <- readLines(ruta_md, encoding = "UTF-8", warn = FALSE)
  doc <- read_docx()
  parrafo <- character(0)
  seccion <- NA_integer_

  volcar_parrafo <- function(doc) {
    if (length(parrafo) == 0) return(doc)
    body_add_fpar(doc, fpar(ftext(limpiar(paste(parrafo, collapse = " ")), texto_normal)))
  }

  volcar_figuras <- function(doc, n) {
    if (!con_figuras || is.na(n)) return(doc)
    for (f in figuras_de(n)) {
      doc <- body_add_img(doc, f, width = 6.2, height = 6.2 * 4.5 / 8)
      doc <- body_add_fpar(doc, fpar(ftext(basename(f),
                                           fp_text(font.family = "Calibri",
                                                   font.size = 8, italic = TRUE))))
    }
    doc
  }

  i <- 1
  while (i <= length(lineas)) {
    l <- lineas[i]

    if (str_detect(l, "^\\|")) {
      doc <- volcar_parrafo(doc); parrafo <- character(0)
      j <- i
      while (j <= length(lineas) && str_detect(lineas[j], "^\\|")) j <- j + 1
      doc <- body_add_flextable(doc, tabla_desde_markdown(lineas[i:(j - 1)]))
      doc <- body_add_par(doc, "")
      i <- j
      next
    }

    if (str_detect(l, "^#{1,4} ")) {
      doc <- volcar_parrafo(doc); parrafo <- character(0)
      nivel <- str_count(str_extract(l, "^#+"), "#")
      titulo <- limpiar(str_remove(l, "^#+ "))
      nueva <- suppressWarnings(as.integer(str_match(titulo, "^([0-9]+)\\)")[, 2]))
      if (!is.na(nueva)) {
        doc <- volcar_figuras(doc, seccion)
        seccion <- nueva
      }
      estilo <- switch(as.character(nivel), "1" = texto_h1, "2" = texto_h2, texto_h3)
      doc <- body_add_par(doc, "")
      doc <- body_add_fpar(doc, fpar(ftext(titulo, estilo)))
      i <- i + 1
      next
    }

    if (str_trim(l) == "" ) {
      doc <- volcar_parrafo(doc); parrafo <- character(0)
      i <- i + 1
      next
    }

    if (str_detect(l, "^(---|===)")) {
      doc <- volcar_parrafo(doc); parrafo <- character(0)
      i <- i + 1
      next
    }

    if (str_detect(l, "^\\s*[-*>] ")) {
      doc <- volcar_parrafo(doc); parrafo <- character(0)
      vineta <- limpiar(str_remove(l, "^\\s*[-*>] "))
      doc <- body_add_fpar(doc, fpar(ftext(paste0("•  ", vineta), texto_normal)))
      i <- i + 1
      next
    }

    # Las lineas del tipo "**Para:** ..." son campos de encabezado y cada una
    # va en su propio parrafo, no pegadas a la siguiente
    if (str_detect(l, "^\\*\\*[^*]+:\\*\\*")) {
      doc <- volcar_parrafo(doc); parrafo <- character(0)
      doc <- body_add_fpar(doc, fpar(ftext(limpiar(str_trim(l)), texto_normal)))
      i <- i + 1
      next
    }

    parrafo <- c(parrafo, str_trim(l))
    i <- i + 1
  }

  doc <- volcar_parrafo(doc)
  doc <- volcar_figuras(doc, seccion)
  print(doc, target = ruta_docx)
  cat("  escrito", ruta_docx, "\n")
}

dir.create("output/entrega", showWarnings = FALSE, recursive = TRUE)

convertir("docs/resumen-ejecutivo.md",
          "output/entrega/01-resumen-ejecutivo.docx")
convertir("output/respuestas-completas.md",
          "output/entrega/02-respuestas-1-a-10.docx", con_figuras = TRUE)
convertir("docs/nota-ia.md",
          "output/entrega/03-nota-uso-de-ia.docx")
