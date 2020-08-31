USE ca_population;

CREATE TABLE ca_edu(
	date_year TEXT,
    age TEXT,
    gender VARCHAR(6),
    edu_attainment TEXT,
    income TEXT,
    population INT
);


/* Load data
mysql --local_infile=1 -u root -p 
*/
LOAD DATA LOCAL INFILE 'C:\\Users\\User\\cleaned_CA_Educational_Attainment___Personal_Income_2008-2014.csv'
INTO TABLE ca_edu
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;