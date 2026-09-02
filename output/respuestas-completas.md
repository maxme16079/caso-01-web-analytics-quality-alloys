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


## 5) Ingresos contra libras vendidas

`output/figures/q5_ingresos_vs_libras.png`

**r = 0,8689.** Relación positiva y fuerte, como dictaba la intuición: la
facturación es esencialmente precio por cantidad, así que las dos variables
miden casi lo mismo. Que no sea 1,0 se explica por los cambios de precio y de
mezcla de producto entre semanas. La relación se sostiene dentro de los cuatro
periodos por separado (r entre 0,834 y 0,962,
`output/tables/q7_correlaciones_por_periodo.csv`), lo que confirma que es
estructural y no un efecto de agregación.

## 6) Ingresos contra visitas

`output/figures/q6_ingresos_vs_visitas.png`

**r = −0,0594.** Prácticamente cero, y con signo negativo. Era lo esperado
después de la pregunta 4: la nube de puntos no tiene pendiente. Las semanas de
más tráfico no son las de más ingresos.

Separando por periodo (`output/figures/q6_ingresos_vs_visitas_por_periodo.png`),
la correlación tampoco aparece: +0,200 en *initial*, +0,132 en *pre*, −0,030 en
*promotion* y +0,162 en *post*. Ninguna es significativa ni consistente en
signo. No es que la agregación esté escondiendo una relación: no hay relación
lineal en ningún tramo.

## 7) Síntesis de las relaciones entre variables

Matriz completa en `output/tables/q7_matriz_correlaciones.csv` y mapa de calor
en `output/figures/q7_matriz_correlaciones.png`.

| Pareja | r |
|---|---|
| Revenue – Lbs. Sold | 0,8689 |
| Revenue – Profit | 0,8872 |
| Revenue – Avg. Time on Site | 0,2380 |
| Revenue – Bounce Rate | −0,1557 |
| Inquiries – Visits | 0,1022 |
| Revenue – Visits | −0,0594 |
| Revenue – Unique Visits | −0,0692 |
| Revenue – Pageviews | 0,0354 |

**Implicación central: en el periodo analizado, el número de visitas al sitio no
sirve para explicar ni para predecir los ingresos de QA.** Un modelo de
regresión de ingresos sobre visitas explicaría el 0,35 % de la varianza
(r² = 0,0035). En términos de negocio: cada visita adicional no vale nada
medible en facturación.

Tres advertencias sobre esa lectura:

1. **Correlación cero no es prueba de que el sitio no sirva.** Es prueba de que
   *el conteo de visitas* no se traduce en ingresos. El sitio no tiene carrito de
   compras, así que la conversión es indirecta: visita → solicitud de cotización
   → llamada del comercial → orden, con rezago de semanas. Una correlación
   semanal contemporánea no puede capturar esa cadena.
2. **La correlación mide relación lineal.** Podría existir una relación no
   lineal, o un efecto de umbral, que r no detecta.
3. **Correlación no implica causalidad**, ni en un sentido ni en el otro. Aquí lo
   que hay es una variable omitida que mueve ambas series: la recesión.

Las correlaciones que sí informan son otras. `Avg. Time on Site` correlaciona
más con ingresos (0,238) que las visitas, y `Bounce Rate` lo hace en negativo
(−0,156). Débiles las dos, pero apuntan en la dirección correcta: importa el
tráfico que se queda, no el que entra. Y `Inquiries – Visits` = 0,102 muestra
que ni siquiera el paso intermedio del embudo responde al volumen de tráfico.


## 8) Modelado de las libras vendidas (ene 2005 – jul 2010)

### a) Descriptivos — `output/tables/q8a_descriptivos_libras.csv`

| Medida | Valor |
|---|---|
| n | 290 semanas |
| media | 18.681,7 |
| mediana | 17.672,5 |
| desv. estándar | 6.840,7 |
| mínimo | 3.826 |
| máximo | 44.740 |
| rango | 40.914 |

### b) Histograma

`output/figures/q8_histograma_libras.png`. Ancho de clase 2.273 libras, tomado
de la regla de la raíz del número de observaciones (√290 ≈ 17 clases).

### c) Descripción

Unimodal, con la moda entre 15.000 y 18.000 libras, y con una cola derecha algo
más larga que la izquierda: la media (18.681,7) queda por encima de la mediana
(17.672,5), señal de asimetría positiva leve. A ojo la forma es razonablemente
acampanada, aunque no perfectamente simétrica.

### d) Regla empírica — `output/tables/q8d_regla_empirica_libras.csv`

| Intervalo | % teórico | Obs. teóricas | Obs. reales | % real |
|---|---|---|---|---|
| media ± 1 desv. est. | 68 % | 197 | 201 | 69,3 % |
| media ± 2 desv. est. | 95 % | 276 | 276 | 95,2 % |
| media ± 3 desv. est. | 99 % | 287 | 288 | 99,3 % |

Ajuste notablemente bueno: las tres desviaciones respecto de lo teórico son de
4, 0 y 1 observaciones.

### e) Análisis refinado — `output/tables/q8e_regla_empirica_detalle_libras.csv`

| Intervalo | % teórico | Obs. teóricas | Obs. reales | % real |
|---|---|---|---|---|
| media a media + 1σ | 34 % | 99 | 84 | 29,0 % |
| media − 1σ a media | 34 % | 99 | 117 | 40,3 % |
| 1σ a 2σ | 13,5 % | 39 | 35 | 12,1 % |
| −1σ a −2σ | 13,5 % | 39 | 40 | 13,8 % |
| 2σ a 3σ | 2 % | 6 | 9 | 3,1 % |
| −2σ a −3σ | 2 % | 6 | 3 | 1,0 % |

Aquí aparece la asimetría que el intervalo simétrico ocultaba. Hay 117
observaciones justo debajo de la media contra 84 justo encima: la masa se
acumula a la izquierda. Y en las colas la relación se invierte: 9 observaciones
entre 2σ y 3σ contra solo 3 entre −2σ y −3σ. Es exactamente el patrón de una
distribución con cola derecha: muchos valores algo por debajo de la media y unos
pocos muy por encima.

### f) ¿Sigue una distribución normal?

**Se aproxima razonablemente bien, con una asimetría positiva leve que no
invalida el modelo.** La evidencia:

- La media supera a la mediana en apenas 1.009 libras, un 5,4 % de la media.
- Los intervalos simétricos de la regla empírica se cumplen casi exactos
  (69,3 / 95,2 / 99,3 contra 68 / 95 / 99).
- La asimetría es 0,632, por debajo de 1 en valor absoluto, que es el umbral que
  se usa en clase para considerarla leve.
- La curtosis es 0,564, cerca de 0, o sea colas parecidas a las de la normal.
- El desajuste está en el detalle de la pregunta e: el desbalance entre las dos
  mitades y las colas.

Conclusión de negocio: para planeación de inventario y capacidad sí se puede
modelar como normal con media 18.682 y desviación estándar 6.841, teniendo
presente que el modelo va a subestimar levemente la frecuencia de las semanas
excepcionalmente altas.

### g) Asimetría y curtosis

**Asimetría = 0,6320. Curtosis = 0,5641.** Calculadas con las fórmulas
muestrales de Excel `=SKEW()` y `=KURT()`, replicadas en R para que sean
comparables con la salida que trae el caso (la curtosis es en exceso, cero para
la normal).

Son consistentes con todo lo anterior: la asimetría positiva confirma la cola
derecha que ya mostraban la media por encima de la mediana y el desbalance de
colas de la tabla e; la curtosis cercana a cero confirma que, fuera de esa
asimetría, el grosor de las colas es el de una normal.

## 9) Libras vendidas por semana contra visitas diarias

`output/figures/q9_histograma_visitas_diarias.png` y
`output/figures/q9_comparacion_distribuciones.png`

| Medida | Libras/semana (n=290) | Visitas/día (n=462) |
|---|---|---|
| media | 18.681,7 | 150,28 |
| mediana | 17.672,5 | 122 |
| desv. estándar | 6.840,7 | 98,17 |
| mínimo | 3.826 | 37 |
| máximo | 44.740 | 664 |
| **asimetría** | **0,632** | **2,167** |
| **curtosis** | **0,564** | **5,862** |
| media / mediana | 1,06 | 1,23 |
| coef. de variación | 36,6 % | 65,3 % |

Regla empírica de las visitas diarias:

| Intervalo | % teórico | Obs. teóricas | Obs. reales | % real |
|---|---|---|---|---|
| media ± 1σ | 68 % | 314 | 392 | 84,8 % |
| media ± 2σ | 95 % | 439 | 439 | 95,0 % |
| media ± 3σ | 99 % | 457 | 448 | 97,0 % |
| media a +1σ | 34 % | 157 | 108 | 23,4 % |
| −1σ a media | 34 % | 157 | 284 | 61,5 % |
| 2σ a 3σ | 2 % | 9 | 9 | 1,9 % |
| −2σ a −3σ | 2 % | 9 | **0** | 0 % |

**Las libras vendidas por semana son claramente más normales que las visitas
diarias.** Tres razones:

1. **Asimetría.** 0,632 contra 2,167. La de las visitas es más del triple y pasa
   con holgura el umbral de 1, así que ya no es una desviación leve. Se ve en la
   distancia entre media y mediana: la media de visitas está 23 % por encima de
   su mediana, contra 6 % en las libras.
2. **Curtosis.** 0,564 contra 5,862. Un valor de 5,86 significa colas mucho más
   gruesas que las de una normal: los días de tráfico extremo (hasta 664 visitas
   contra una media de 150) son mucho más frecuentes de lo que una normal
   predice.
3. **Regla empírica.** En las libras las tres desviaciones son de 4, 0 y 1
   observaciones. En las visitas, el intervalo de ±1σ contiene 392 casos cuando
   la teoría predice 314 —78 de más— y las mitades están descuadradas por
   completo: 284 abajo contra 108 arriba, cuando deberían ser 157 y 157. El dato
   más contundente es el intervalo de −2σ a −3σ: **cero observaciones** donde
   deberían haber 9. Es imposible que las haya, porque la media menos dos
   desviaciones (150,28 − 2 × 98,17 = −46) es un número negativo y no puede
   haber días con visitas negativas. Esa frontera en cero es lo que fuerza la
   asimetría.

La diferencia tiene explicación estructural, no es casualidad. Las visitas
diarias están acotadas por abajo en cero y no tienen tope por arriba, así que su
distribución se apila contra el cero y se estira a la derecha. Las libras
vendidas por semana, en cambio, son la suma de muchas órdenes independientes de
clientes distintos, y por el teorema del límite central esa suma tiende a la
normal. La agregación semanal también suaviza: el tráfico diario recoge el ciclo
laboral —los fines de semana casi no hay visitas industriales— y ese patrón
bimodal desaparece al sumar por semana.

**Consecuencia práctica:** los intervalos basados en la regla empírica y en la
normal son defendibles para las libras vendidas; para las visitas diarias no.
Ahí conviene describir con mediana y cuartiles, que no se distorsionan con los
extremos, o modelar el logaritmo de la variable.

## 10) Datos demográficos

Seis gráficas de barras horizontales en orden descendente, en
`output/figures/q10_*.png`, con la categoría dominante en azul y el resto en
gris. Tablas en `output/tables/q10_demograficos.csv` y
`output/tables/q10_top3_por_bloque.csv`.

**10.1 Fuentes de tráfico** — `q10_1_fuentes_trafico.png`
Referring Sites 38.754 (55,8 %), Search Engines 20.964 (30,2 %), Direct Traffic
9.709 (14,0 %), Other 4. Más de la mitad del tráfico llega por enlaces de
terceros y solo un 14 % escribe la dirección directamente. Para una marca que
buscaba legitimidad, ese 14 % de tráfico directo es la métrica preocupante: casi
nadie busca a QA por su nombre.

**10.2 Sitios remitentes** — `q10_2_sitios_remitentes.png`
googleads.g.doubleclick.net 15.626 (52,4 %) y pagead2.googlesyndication.com
8.044 (27,0 %) suman **79,3 %** del top diez. Ambos son dominios de la red de
anuncios de Google, es decir tráfico comprado vía AdWords. El tercero es
sedoparking.com (3.138, 10,5 %), un servicio de dominios aparcados, que es
tráfico de bajísima intención. Los dos portales del sector que QA paga
deliberadamente —globalspec.com (693) y thomasnet.com (379)— aportan juntos
apenas 1.072 visitas, un 3,6 % del top diez. Aparece también psicofxp.com (310),
un foro argentino sin nada que ver con aleaciones industriales.

**10.3 Motores de búsqueda** — `q10_3_motores_busqueda.png`
google 17.681 (84,7 %), yahoo 1.250 (6,0 %), el resto marginal. Concentración
casi total en un solo motor: cualquier cambio de algoritmo o de puja en Google
mueve el tráfico de QA de golpe. Es un riesgo de dependencia.

**10.4 Regiones geográficas** — `q10_4_regiones.png`
South America 22.616 (34,5 %) es la primera región, por encima de Northern
America 17.509 (26,7 %). Le siguen Central America 6.776 (10,3 %) y Western
Europe 5.214 (7,9 %). Esto **contradice de frente el objetivo declarado** de la
compañía: QA es un distribuidor estadounidense que quería expandirse a Europa y
sobre todo a Asia por el desplazamiento de la manufactura al Pacífico. Pero
Eastern Asia (3.228) y South-Eastern Asia (1.968) juntas son 5.196 visitas,
menos que Suramérica sola dividida en cuatro. Cruzado con 10.2, la lectura es
que la pauta en la red de anuncios de Google está sirviendo impresiones en
mercados donde QA no vende.

**10.5 Navegadores** — `q10_5_navegadores.png`
Internet Explorer 53.080 (76,5 %), Firefox 13.142 (18,9 %), el resto por debajo
del 1,5 %. Consistente con visitantes corporativos en equipos con software
estandarizado, propio de compradores industriales en 2008-2009. Implicación
técnica: el sitio se debe probar y optimizar primero en IE.

**10.6 Sistemas operativos** — `q10_6_sistemas_operativos.png`
Windows 67.063 (96,6 %), Macintosh 1.184 (1,7 %), Linux 1.045 (1,5 %). Móviles
casi inexistentes: iPhone 29, SymbianOS 20, iPod 8. Refuerza lo anterior: el
visitante entra desde el escritorio de una oficina, no desde un teléfono. En
2008-2009 no había caso para invertir en versión móvil.

**Conclusión conjunta de la pregunta 10.** Los seis bloques cuentan la misma
historia y explican el resultado de la pregunta 6. El tráfico de QA es en su
mayoría comprado, viene de redes de anuncios y dominios aparcados, y se
concentra en regiones que no son su mercado. Ese tipo de visita no tenía por qué
convertirse en ingresos, y en efecto no lo hizo: es la explicación de por qué
r(ingresos, visitas) = −0,0594. El problema no fue medir mal la conversión, fue
comprar el tráfico equivocado.
