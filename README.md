# Caso 1 — Web Analytics at Quality Alloys, Inc.

Análisis del caso *Web Analytics at Quality Alloys, Inc.* (Rob Weitz y David
Rosenthal, Columbia CaseWorks) para el curso **Analítica de los Negocios
(BA-2630)**, Pontificia Universidad Javeriana, periodo 2026-3. Profesor: Juan
Nicolás Velásquez Rey.

## Equipo y reparto

| Integrante | Preguntas | Archivos |
|---|---|---|
| Máximo Van Fulpen | 1 a 4 | `R/00_setup.R`, `R/01_descriptivos.R`, `docs/respuestas-q01-q04.md` |
| Helen Sofía Castiblanco | 5 a 7 + resumen ejecutivo | `R/02_relaciones.R`, `docs/respuestas-q05-q07.md`, `docs/resumen-ejecutivo.md` |
| Camilo Hernández | 8 a 10 | `R/03_normalidad.R`, `R/04_demograficos.R`, `docs/respuestas-q08-q10.md` |

Cada integrante trabaja en archivos distintos, así que no hay conflictos de
merge. El reparto se refleja en el historial de commits.

## Entregable

El caso pide el informe en dos partes:

**Parte 1 — Resumen ejecutivo** con recomendaciones a la gerencia
→ [`docs/resumen-ejecutivo.md`](docs/resumen-ejecutivo.md)

**Parte 2 — Respuestas numeradas** a las diez preguntas de la sección *Analysis*,
repartidas por integrante:

- [`docs/respuestas-q01-q04.md`](docs/respuestas-q01-q04.md) — preguntas 1 a 4
- [`docs/respuestas-q05-q07.md`](docs/respuestas-q05-q07.md) — preguntas 5 a 7
- [`docs/respuestas-q08-q10.md`](docs/respuestas-q08-q10.md) — preguntas 8 a 10

Para armar el documento único que se entrega:

```r
source("R/99_unir_respuestas.R")
```

Genera `output/respuestas-completas.md` con las diez preguntas en orden.

**Nota de uso de IA**, exigida por el syllabus
→ [`docs/nota-ia.md`](docs/nota-ia.md)

## Estructura

```
caso-01-web-analytics/
├── data/
│   └── Web_Analytics.xls          datos originales del caso, seis hojas
├── R/
│   ├── 00_setup.R                 carga de datos y partición en periodos
│   ├── 01_descriptivos.R          preguntas 1 a 4
│   ├── 02_relaciones.R            preguntas 5 a 7
│   ├── 03_normalidad.R            preguntas 8 y 9
│   ├── 04_demograficos.R          pregunta 10
│   └── 99_unir_respuestas.R       arma el documento final de la parte 2
├── docs/
│   ├── respuestas-q01-q04.md      parte 2, preguntas 1 a 4
│   ├── respuestas-q05-q07.md      parte 2, preguntas 5 a 7
│   ├── respuestas-q08-q10.md      parte 2, preguntas 8 a 10
│   ├── resumen-ejecutivo.md       parte 1 del entregable
│   └── nota-ia.md                 divulgación de uso de IA
└── output/
    ├── figures/                   22 gráficas en png
    └── tables/                    14 tablas en csv
```

## Cómo reproducir

Requiere R 4.x con `tidyverse`, `readxl`, `moments` y `scales`. Desde la raíz
del repositorio:

```r
source("R/01_descriptivos.R")
source("R/02_relaciones.R")
source("R/03_normalidad.R")
source("R/04_demograficos.R")
```

Cada script hace `source("R/00_setup.R")` por su cuenta, así que se pueden
correr en cualquier orden y de forma independiente. Todas las rutas son
relativas a la raíz del repositorio.

## Los cuatro periodos

Los cortes se leyeron del sombreado de la hoja `Weekly Visits` del archivo
original, que marca con color el periodo *initial* y el de *promotion*.

| Periodo | Semanas | Fechas | N |
|---|---|---|---|
| Initial | 1–14 | 25 may 2008 – 30 ago 2008 | 14 |
| Pre-Promotion | 15–35 | 31 ago 2008 – 17 ene 2009 | 21 |
| Promotion | 36–52 | 18 ene 2009 – 23 may 2009 | 17 |
| Post-Promotion | 53–66 | 24 may 2009 – 29 ago 2009 | 14 |

## Hallazgos principales

- La promoción de USD 25.000 aumentó las visitas semanales promedio **222 %**
  (563 → 1.814) y no movió ninguna variable financiera.
- La correlación entre visitas semanales e ingresos semanales es **−0,0594**.
  Ingresos contra libras vendidas, en cambio, es **0,8689**.
- La caída de ingresos **empieza antes** de la promoción y es monótona en los
  cuatro periodos (608k → 534k → 456k → 372k), lo que coincide con la recesión
  de 2008-2009 e impide atribuirla a la promoción.
- El 79,3 % de los sitios remitentes principales son dominios de la red de
  anuncios de Google, y la primera región de origen es Suramérica con el 34,5 %,
  no el mercado que QA atiende.
- Las libras vendidas por semana se aproximan bien a una normal (asimetría
  0,632, curtosis 0,564). Las visitas diarias no (asimetría 2,167, curtosis
  5,862), porque están acotadas en cero.

## Nota sobre los datos

`data/Web_Analytics.xls` es material del caso, © 2010 The Trustees of Columbia
University. Se incluye únicamente para poder reproducir el análisis del curso.
