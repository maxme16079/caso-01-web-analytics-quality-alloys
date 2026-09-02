# Caso 1 — Web Analytics at Quality Alloys, Inc.
## Parte 2, primera sección. Respuestas a las preguntas 1 a 4

**Curso:** Analítica de los Negocios (BA-2630) · **Profesor:** Juan Nicolás Velásquez Rey
**Equipo:** Máximo Van Fulpen · Helen Sofía Castiblanco · Camilo Hernández
**Autor de esta sección:** Máximo Van Fulpen
**Fecha:** 2 de septiembre de 2026

Todos los cálculos se hicieron en R. Los scripts están en `R/`, las gráficas en
`output/figures/` y las tablas en `output/tables/`.

### Partición en los cuatro periodos

Los cortes no se estimaron a ojo: se leyeron del sombreado de la hoja
`Weekly Visits` del archivo original, que marca con color el periodo *initial* y
el de *promotion* y deja *pre* y *post* sin sombrear.

| Periodo | Semanas | Fechas | N |
|---|---|---|---|
| Initial | 1–14 | 25 may 2008 – 30 ago 2008 | 14 |
| Pre-Promotion | 15–35 | 31 ago 2008 – 17 ene 2009 | 21 |
| Promotion | 36–52 | 18 ene 2009 – 23 may 2009 | 17 |
| Post-Promotion | 53–66 | 24 may 2009 – 29 ago 2009 | 14 |

---

## 1) Series semanales de las cuatro variables

Cuatro gráficas de columnas, una por variable, con el periodo de promoción
resaltado en azul y el resto en gris.

- `output/figures/q1_unique_visits_semanal.png`
- `output/figures/q1_revenue_semanal.png`
- `output/figures/q1_profit_semanal.png`
- `output/figures/q1_lbs_sold_semanal.png`

Lo que se ve: las visitas tienen un pico marcado y aislado durante la promoción,
mientras que ingresos, utilidad y libras vendidas siguen una tendencia
descendente que **ya venía desde antes** y que el pico de visitas no interrumpe.

## 2) Estadísticos descriptivos por periodo

Tabla completa en `output/tables/q2_resumen_por_periodo.csv` (5 variables × 5
medidas × 4 periodos = 100 valores).

**Initial (semanas 1–14)**

| | Visits | Unique Visits | Revenue | Profit | Lbs. Sold |
|---|---|---|---|---|---|
| media | 1.055,2 | 975,9 | 608.250 | 200.233 | 18.736,7 |
| mediana | 899,0 | 846,5 | 586.170 | 208.913 | 17.270,1 |
| desv. est. | 355,4 | 320,5 | 155.930 | 60.692 | 5.427,0 |
| mínimo | 626 | 594 | 274.568 | 62.580 | 8.632,7 |
| máximo | 1.632 | 1.509 | 890.077 | 275.218 | 28.052,6 |

**Pre-Promotion (semanas 15–35)**

| | Visits | Unique Visits | Revenue | Profit | Lbs. Sold |
|---|---|---|---|---|---|
| media | 563,0 | 516,8 | 534.314 | 159.932 | 18.440,8 |
| mediana | 558,0 | 510,0 | 534.542 | 152.476 | 17.215,0 |
| desv. est. | 80,9 | 70,9 | 150.503 | 42.683 | 5.965,9 |
| mínimo | 383 | 366 | 315.647 | 100.388 | 8.992,0 |
| máximo | 795 | 734 | 951.216 | 273.175 | 31.968,7 |

**Promotion (semanas 36–52)**

| | Visits | Unique Visits | Revenue | Profit | Lbs. Sold |
|---|---|---|---|---|---|
| media | 1.814,4 | 1.738,8 | 456.399 | 131.930 | 17.112,9 |
| mediana | 1.663,0 | 1.585,0 | 413.937 | 114.328 | 17.299,0 |
| desv. est. | 758,2 | 743,3 | 161.741 | 47.777 | 6.518,6 |
| mínimo | 1.000 | 930 | 268.160 | 81.841 | 7.814,0 |
| máximo | 3.726 | 3.617 | 897.164 | 266.477 | 31.496,0 |

**Post-Promotion (semanas 53–66)**

| | Visits | Unique Visits | Revenue | Profit | Lbs. Sold |
|---|---|---|---|---|---|
| media | 856,6 | 800,8 | 371.728 | 111.046 | 14.577,8 |
| mediana | 848,0 | 800,0 | 348.397 | 104.530 | 13.646,5 |
| desv. est. | 70,9 | 72,4 | 145.728 | 49.065 | 5.941,7 |
| mínimo | 772 | 709 | 133.967 | 32.825 | 3.826,0 |
| máximo | 963 | 912 | 615.950 | 206.441 | 23.762,0 |

## 3) Medias de cada variable en los cuatro periodos

Cinco gráficas de columnas, `output/figures/q3_media_*.png`, y la tabla en
`output/tables/q3_medias_por_periodo.csv`.

| Media | Initial | Pre-Promo | Promotion | Post-Promo |
|---|---|---|---|---|
| Visits | 1.055,2 | 563,0 | **1.814,4** | 856,6 |
| Unique Visits | 975,9 | 516,8 | **1.738,8** | 800,8 |
| Revenue (USD) | 608.250 | 534.314 | 456.399 | 371.728 |
| Profit (USD) | 200.233 | 159.932 | 131.930 | 111.046 |
| Lbs. Sold | 18.736,7 | 18.440,8 | 17.112,9 | 14.577,8 |

## 4) Interpretación de los descriptivos

Tomando *pre-promotion* como línea base, porque es el nivel estable inmediato
anterior a la promoción (`output/tables/q4_cambios_porcentuales.csv`):

| Variable | Promotion vs Pre | Post vs Pre |
|---|---|---|
| Visits | **+222,3 %** | +52,2 % |
| Unique Visits | **+236,5 %** | +54,9 % |
| Revenue | **−14,6 %** | −30,4 % |
| Profit | **−17,5 %** | −30,6 % |
| Lbs. Sold | −7,2 % | −20,9 % |
| Inquiries | −1,9 % | −16,2 % |

**Visitas.** El sitio arranca con 1.055 visitas semanales promedio en el periodo
*initial*, pero esa cifra es un artefacto del estreno: la serie cae de 1.632 en
la primera semana a 626 en la semana 14. En *pre-promotion* se estabiliza en 563
con una desviación estándar de apenas 80,9 (coeficiente de variación 14,4 %), el
tramo más estable de toda la serie. Durante la promoción la media se triplica a
1.814,4 y la variabilidad se multiplica por nueve (desv. est. 758,2). Después
retrocede a 856,6, un 52,2 % por encima del nivel pre-promoción: la promoción
dejó un piso más alto de tráfico, no solo un pico.

**Finanzas.** Se mueven en dirección contraria y sin quiebre. Los ingresos
promedio bajan de forma monótona en los cuatro periodos: 608.250 → 534.314 →
456.399 → 371.728. La utilidad hace lo mismo: 200.233 → 159.932 → 131.930 →
111.046. Las libras vendidas caen menos en la promoción (−7,2 %) que los
ingresos (−14,6 %), lo que indica que además del volumen se deterioró el precio
o la mezcla de producto.

**Efecto aparente de la promoción.** La promoción de USD 25.000 sí compró
tráfico —y mucho— pero ese tráfico no aparece en ninguna variable financiera. El
punto decisivo es que **la caída de ingresos empieza antes** de la promoción: ya
entre *initial* y *pre-promotion* los ingresos habían bajado 12,2 %. La ventana
del caso (may 2008 – ago 2009) coincide con la recesión de 2008-2009, que golpeó
justo a la manufactura industrial que compra estas aleaciones. Atribuirle la
caída a la promoción sería confundir una coincidencia temporal con una causa.

**Calidad del tráfico.** Las métricas de comportamiento muestran que el tráfico
de la promoción fue de peor calidad que el habitual:

| Periodo | Páginas/visita | Tiempo en sitio (s) | Bounce rate | % visitas nuevas |
|---|---|---|---|---|
| Initial | 2,28 | 80,3 | 67,3 % | 86,8 % |
| Pre-Promotion | 2,67 | 95,9 | 59,4 % | 83,9 % |
| **Promotion** | **1,80** | **48,8** | **77,3 %** | **91,1 %** |
| Post-Promotion | 2,18 | 70,0 | 66,3 % | 86,3 % |

Tres veces más visitas que ven un 33 % menos de páginas, se quedan la mitad del
tiempo y se van sin pasar de la primera página en el 77 % de los casos. Las
consultas al equipo comercial (*inquiries*) incluso bajaron 1,9 %.

