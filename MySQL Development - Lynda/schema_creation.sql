CREATE DATABASE movies;

USE movies;

/* movie basic data */
CREATE TABLE movie_basic(
title VARCHAR(100) NOT NULL,
genre VARCHAR(50) NOT NULL,
release_year INT NOT NULL,
director VARCHAR(50) NOT NULL,
studio VARCHAR(50) NOT NULL,
critic_rating DECIMAL(2,1) DEFAULT 0
);


/* ------------ */

/* movie genres*/
CREATE TABLE Genre(
id INT PRIMARY KEY AUTO_INCREMENT,
genre VARCHAR(20) NOT NULL
);

/* movie director */
CREATE TABLE Director(
id INT PRIMARY KEY AUTO_INCREMENT,
dir_name VARCHAR(40) NOT NULL
);

/* movie studio */
CREATE TABLE Studio(
id INT PRIMARY KEY AUTO_INCREMENT,
studio_name VARCHAR(30) NOT NULL,
city VARCHAR(50) NOT NULL
);


/* movie titles */
CREATE TABLE Titles(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100) NOT NULL,
genre_id INT NOT NULL,
release_year INT NOT NULL,
director_id INT NOT NULL,
studio_id INT NOT NULL,
FOREIGN KEY(genre_id) REFERENCES Genre(id),
FOREIGN KEY(director_id) REFERENCES Director(id),
FOREIGN KEY(studio_id) REFERENCES Studio(id)
);

/* movie critics rating */
CREATE TABLE Critic_Rating(
id INT PRIMARY KEY AUTO_INCREMENT,
titles_id INT NOT NULL,
critics_rating DECIMAL(2,1) DEFAULT 0,
FOREIGN KEY(titles_id) REFERENCES titles(id)
);

/* posters */
CREATE TABLE posters(
titles_id INT NOT NULL,
filename VARCHAR(100) NOT NULL,
resolution VARCHAR(20) NOT NULL,
FOREIGN KEY(titles_id) REFERENCES titles(id) 
);
