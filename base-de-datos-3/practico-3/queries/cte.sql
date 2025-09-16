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
