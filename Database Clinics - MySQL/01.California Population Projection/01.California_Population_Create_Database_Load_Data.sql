CREATE SCHEMA ca_population;

USE ca_population;

CREATE TABLE pop_proj(
	county_code VARCHAR(45) NOT NULL,
    county_name VARCHAR(45) NOT NULL,
    date_year INT NOT NULL,
    race_code INT NOT NULL,
    race TEXT NOT NULL,
    gender VARCHAR(6) NOT NULL,
    age INT NOT NULL,
    population INT NOT NULL
);

/* Load Data */
/* ignore first header line, delimiter setting, etc*/
LOAD DATA LOCAL INFILE 'C:\\Users\\User\\CA_DRU_proj_2010-2060.csv'
INTO TABLE pop_proj
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* check the loaded data */
SELECT * FROM pop_proj
LIMIT 10;

/* SIDE NOTE */
/*
If there is any issues with loading local data is disabled, we need to enable it.

Ref: https://stackoverflow.com/questions/59993844/error-loading-local-data-is-disabled-this-must-be-enabled-on-both-the-client

Ref: if you can't access mysql from cmd, add mysql path in path first https://www.qualitestgroup.com/resources/knowledge-center/how-to-guide/add-mysql-path-windows/

1) log into to mysql from command line >> mysql -u <username> -p
2) check local_infile varialbe current status >> show global variables like 'local_infile';
3) if that is OFF,enable it >> SET GLOBAL local_infile=1;
4) quit the server >> quit
5) connect to server again >> mysql --local_infile=1 -u root -p
6) run the load sql statement.
*/