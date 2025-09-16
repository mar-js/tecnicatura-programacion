SELECT
  titulo,
  recaudacion_usd,
  RANK() OVER (ORDER BY recaudacion_usd DESC) AS rank_recaudacion,
  PERCENT_RANK() OVER (ORDER BY recaudacion_usd DESC) AS percent_rank_recaudacion,
  NTILE(4) OVER (ORDER BY recaudacion_usd DESC) AS quartil_recaudacion
FROM
  peliculas;
