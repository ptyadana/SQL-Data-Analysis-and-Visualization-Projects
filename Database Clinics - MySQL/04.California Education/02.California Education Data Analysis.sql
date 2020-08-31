/* What is the percentage of education attainment for each category across differnent age group? */
SELECT 
	ca_edu.age, 
	ca_edu.edu_attainment, 
    SUM(ca_edu.population) / total_pop_by_age.total_population AS cofficient
FROM ca_edu
JOIN 
	(SELECT age, SUM(population) as total_population
	FROM ca_edu
	GROUP BY age) AS total_pop_by_age
ON ca_edu.age = total_pop_by_age.age
GROUP BY ca_edu.age, ca_edu.edu_attainment;


/* create new demographics table from the result */
CREATE TABLE demographics AS
SELECT 
	ca_edu.age, 
	ca_edu.edu_attainment, 
    SUM(ca_edu.population) / total_pop_by_age.total_population AS coefficient
FROM ca_edu
JOIN 
	(SELECT age, SUM(population) as total_population
	FROM ca_edu
	GROUP BY age) AS total_pop_by_age
ON ca_edu.age = total_pop_by_age.age
GROUP BY ca_edu.age, ca_edu.edu_attainment;


/* 
Using Population Projection data,
What is the projection of education demand for each age group?
*/
SELECT 
	temp_pop.date_year AS 'Year',
    demographics.edu_attainment AS 'Education',
    ROUND(SUM(temp_pop.total_pop * demographics.coefficient)) AS 'Demand'
FROM
(SELECT date_year, age, SUM(population) AS total_pop
FROM pop_proj
GROUP BY age, date_year) AS temp_pop
JOIN demographics
ON demographics.age = CASE
	WHEN temp_pop.age < 18 THEN '00 to 17'
    WHEN temp_pop.age < 64 THEN '65 to 80+'
    ELSE '18 to 64'
    END
GROUP BY 1, 2;



