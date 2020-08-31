CREATE SCHEMA shakespeare;

USE shakespeare;

/* play and characters table */
CREATE TABLE amnd(
	line_number INT NOT NULL AUTO_INCREMENT,
    char_name TEXT,
    play_text TEXT,
    PRIMARY KEY (line_number)
);

/* performance table */
CREATE TABLE performance(
	query_type TEXT,
    query_time FLOAT
);