/* To increase performance, index on county name */
CREATE INDEX county_name
ON pop_proj(county_name);

/* Inital list of male and female populations per county for 2014 */
SELECT county_name, gender, SUM(population) As total_population
FROM pop_proj
WHERE date_year = 2014
GROUP BY county_name, gender
ORDER BY county_name;

/* return information in specially formatted table */
/* list of male and female populations per county for 2014 */
SELECT p.county_name, 
	SUM(p.population) AS Male, 
    female_pop.Female FROM 
		(SELECT county_name, SUM(population) AS Female
		FROM pop_proj
		WHERE date_year = 2014 and gender = 'Female'
		GROUP BY county_name
		ORDER BY county_name) AS female_pop
JOIN pop_proj p
ON p.county_name = female_pop.county_name
WHERE p.date_year = 2014 AND p.gender = 'Male'
GROUP BY p.county_name
ORDER BY p.county_name;


