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
