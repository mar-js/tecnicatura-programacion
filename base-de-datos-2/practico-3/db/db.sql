CREATE DATABASE peliculas_db;
USE peliculas_db;

CREATE TABLE peliculas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  anio YEAR NOT NULL,
  director VARCHAR(255),
  duracion_minutos INT,
  genero VARCHAR(100),
  idioma_original VARCHAR(50),
  actores_principales TEXT,
  guionistas TEXT,
  musica VARCHAR(255),
  productora VARCHAR(255),
  rating_imdb DECIMAL(3,1),
  presupuesto_usd BIGINT,
  recaudacion_usd BIGINT
);
