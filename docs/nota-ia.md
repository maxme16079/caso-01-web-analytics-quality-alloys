# Nota de uso de inteligencia artificial

**Caso 1 — Web Analytics at Quality Alloys, Inc.**
Equipo: Máximo Van Fulpen · Helen Sofía Castiblanco · Camilo Hernández
Fecha: 2 de septiembre de 2026

Esta nota se incluye en cumplimiento de la política de divulgación del syllabus:
*"En cada entrega incluye una nota breve indicando dónde y cómo usaste IA.
Usarla sin declararlo se considera falta de integridad académica."*

## Herramienta

Claude Code (Anthropic), modelo Opus 5, usado desde la terminal sobre este mismo
repositorio.

## Dónde se usó

| Componente | Uso de IA |
|---|---|
| `R/00_setup.R` a `R/04_demograficos.R` | La IA escribió el código de lectura del Excel, la partición en periodos, los cálculos y las gráficas en ggplot. |
| Lectura del PDF del caso | La IA extrajo el texto del PDF con `pdftools` para listar las diez preguntas y el enunciado del entregable. |
| Verificación de los cortes de periodo | La IA leyó los colores de relleno de las celdas del archivo `.xls` vía COM de Excel para determinar los límites exactos de los cuatro periodos, en lugar de estimarlos a ojo del gráfico. |
| `docs/respuestas.md` y `docs/resumen-ejecutivo.md` | La IA produjo el borrador. El equipo revisó cifras, ajustó redacción y asumió las interpretaciones. |
| Estructura del repositorio y mensajes de commit | Propuestos por la IA. |

## Dónde no se usó

La selección de qué comparar, la lectura de negocio de los resultados y las
recomendaciones a la gerencia son del equipo. Cada integrante revisó y verificó
la sección que firma en el reparto del `README.md`.

## Prompts principales

Se transcriben los que dirigieron el trabajo. Los intermedios fueron
correcciones puntuales de código y de redacción.

1. > *"vamos a resolver lo que dice esta carpeta del trabajo que se entrega hoy
   > del caso"* — punto de partida, con la carpeta del caso del repositorio del
   > profesor como contexto.

2. > *"vamos a hacer todo el caso pero vamos a dar espacio para que los otros dos
   > integrantes de mi grupo puedan hacer el mismo número de contribuciones que
   > nos pide la clase"* — de aquí salió el reparto en archivos separados por
   > integrante.

3. > *"crear el proyecto en público para poder ver las contribuciones"* —
   > decisión sobre la visibilidad del repositorio.

4. Instrucción de estilo de código dada a la IA, tomada de lo que el profesor
   escribe en las lectures: asignar con `<-`, pipe nativo `|>`, verbos de dplyr,
   gráficas con ggplot, rutas relativas, y la rúbrica de gráficas de la lecture
   de DataViz (título, ejes nombrados, escala en cada eje, sin 3D).

## Verificación de la salida

No se aceptó ningún número sin comprobarlo:

- **Los cortes de los cuatro periodos** se validaron contra el sombreado del
  archivo original, no contra el supuesto inicial de la IA, que estaba
  equivocado. La primera partición que propuso daba +153 % de visitas; con los
  cortes reales el resultado es +222 %.
- **Los estadísticos de las visitas diarias** que calculó nuestro código en R
  (media 150,2835 · mediana 122 · desv. est. 98,1695 · asimetría 2,166972 ·
  curtosis 5,861990 · rango 627 · n 462) coinciden **dígito por dígito** con la
  salida de Excel que el propio caso publica en la pregunta 9. También coinciden
  las dos filas de la tabla de la regla empírica que el caso muestra resueltas
  (2σ a 3σ: 9 teóricas y 9 reales; −2σ a −3σ: 9 teóricas y 0 reales). Esa
  coincidencia es la prueba de que las fórmulas de asimetría y curtosis
  replicadas de Excel están bien implementadas.
- **La suma de las cuatro fuentes de tráfico** de la hoja Demographics (38.754 +
  20.964 + 9.709 + 4 = 69.431) cuadra con el total de visitas de las 66 semanas
  de la hoja Weekly Visits.

Cualquier error que quede en la interpretación es responsabilidad del equipo, no
de la herramienta.
