# Caso 1 - Web Analytics at Quality Alloys, Inc.
# Une las tres secciones de respuestas en el documento unico que se entrega
# Autor: Maximo Van Fulpen

partes <- c("docs/respuestas-q01-q04.md",
            "docs/respuestas-q05-q07.md",
            "docs/respuestas-q08-q10.md")

# De la segunda y la tercera seccion se descarta el encabezado propio, que va
# hasta la linea del separador, para que el documento final no lo repita
texto <- lapply(seq_along(partes), function(i) {
  lineas <- readLines(partes[i], encoding = "UTF-8")
  if (i == 1) return(lineas)
  corte <- which(lineas == "---")[1]
  lineas[(corte + 1):length(lineas)]
})

writeLines(unlist(texto), "output/respuestas-completas.md", useBytes = TRUE)
cat("Escrito output/respuestas-completas.md con", length(unlist(texto)), "lineas\n")
