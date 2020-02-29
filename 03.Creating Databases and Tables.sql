CREATE DATABASE ultimate_mysql_bootcamp;

USE ultimate_mysql_bootcamp;

CREATE TABLE pastries(
	name VARCHAR(50) PRIMARY KEY NOT NULL,
	quantity INT DEFAULT 0
);


SHOW tables;

DESC pastries;

DROP TABLE pastries;

SHOW tables;
