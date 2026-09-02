# Caso 1 — Web Analytics at Quality Alloys, Inc.
## Parte 2, tercera sección. Respuestas a las preguntas 8 a 10

**Curso:** Analítica de los Negocios (BA-2630) · **Profesor:** Juan Nicolás Velásquez Rey
**Equipo:** Máximo Van Fulpen · Helen Sofía Castiblanco · Camilo Hernández
**Autor de esta sección:** Camilo Hernández
**Fecha:** 2 de septiembre de 2026

Cálculos en `R/03_normalidad.R` (preguntas 8 y 9) y `R/04_demograficos.R`
(pregunta 10).

---

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
