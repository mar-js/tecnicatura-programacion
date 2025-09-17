# Explicación de la base de datos de películas

## Estructura de la base de datos

La base de datos se llama `peliculas_db` y contiene una única tabla llamada `peliculas`.
Cada registro en `peliculas` representa una película con metadatos clave para análisis y reporting.

Los campos de la tabla `peliculas` son:

- id: Identificador único auto incremental.
- titulo: Título de la película.
- anio: Año de estreno (tipo YEAR).
- director: Nombre del director.
- duracion_minutos: Duración en minutos.
- genero: Género o géneros separados por punto y coma.
- idioma_original: Idioma original de la película.
- actores_principales: Lista de actores separados por punto y coma.
- guionistas: Lista de guionistas separados por punto y coma.
- musica: Autor de la banda sonora.
- productora: Nombre de la productora.
- rating_imdb: Puntuación en IMDb (decimal).
- presupuesto_usd: Presupuesto en dólares estadounidenses.
- recaudacion_usd: Recaudación en dólares estadounidenses.

---

## Descripción de las consultas SQL

### 1. Common Table Expression (CTE)

Esta consulta calcula primero el presupuesto promedio de todas las películas usando una CTE llamada `promedio_presupuesto`.
Luego se unen los resultados de la CTE con la tabla principal para filtrar solo las películas cuyo presupuesto supera ese promedio.
Finalmente, se ordenan de mayor a menor presupuesto para identificar fácilmente los proyectos más costosos.

```sql
WITH promedio_presupuesto AS (
  SELECT AVG(presupuesto_usd) AS avg_presupuesto
  FROM peliculas
)
SELECT
  p.titulo,
  p.presupuesto_usd
FROM
  peliculas p
  JOIN promedio_presupuesto mp
    ON p.presupuesto_usd > mp.avg_presupuesto
ORDER BY
  p.presupuesto_usd DESC;
```

---

### 2. Window Function

Utilizamos funciones de ventana para crear métricas de clasificación y distribución dentro del conjunto de datos de recaudación:

- `RANK()` asigna un rango basado en la recaudación de forma descendente.
- `PERCENT_RANK()` escala esa posición al rango [0, 1] para ver qué tan cerca está cada película de la más taquillera.
- `NTILE(4)` divide el conjunto en cuatro grupos (cuartiles), mostrando en qué segmento de recaudación cae cada título.

```sql
SELECT
  titulo,
  recaudacion_usd,
  RANK() OVER (ORDER BY recaudacion_usd DESC) AS rank_recaudacion,
  PERCENT_RANK() OVER (ORDER BY recaudacion_usd DESC) AS percent_rank_recaudacion,
  NTILE(4) OVER (ORDER BY recaudacion_usd DESC) AS quartil_recaudacion
FROM
  peliculas;
```

---

### 3. OLAP con GROUPING SETS

Esta consulta aprovecha `GROUPING SETS` para generar agregados en múltiples niveles sin múltiples pasadas sobre la tabla:

- Combinación por `genero` e `idioma_original`.
- Agregado por cada `genero` independientemente.
- Agregado por cada `idioma_original` independientemente.
- Total global de películas.

De esta manera se obtienen recuentos detallados y totales en una sola ejecución.

```sql
SELECT
  genero,
  idioma_original,
  COUNT(*) AS cantidad
FROM
  peliculas
GROUP BY
  GROUPING SETS (
    (genero, idioma_original),
    (genero),
    (idioma_original),
    ()
  )
ORDER BY
  genero,
  idioma_original;
```

---

## Conclusión

Estas estructuras y consultas permiten abordar desde análisis básicos de presupuesto hasta reportes avanzados de clasificación y agregación multidimensional.
Con ellas puedes identificar tendencias de gasto, rendimiento de taquilla y la distribución de géneros e idiomas en tu catálogo cinematográfico.
