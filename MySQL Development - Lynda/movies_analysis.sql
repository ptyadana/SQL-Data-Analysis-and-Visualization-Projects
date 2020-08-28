/* Selecting Data */
SELECT id,IF(critic_rating > 6, 'Good', 'Bad') AS score
FROM critic_rating;

SELECT id,
	CASE
		WHEN critic_rating > 8 THEN 'Good'
		WHEN critic_rating > 6 THEN 'Decent'
		ELSE 'Bad'
	END AS score
FROM critic_rating;

/* Challenge: Filter movie by score */
SELECT 
t.title AS 'Title:', 
IF (t.release_year > 2000, '21st Century', '20th Century') AS 'Released:', 
d.dir_name AS 'Director:', 
cr.critic_rating,
CASE
	WHEN cr.critic_rating >= 9 THEN 'Amazing'
    WHEN cr.critic_rating > 7 AND cr.critic_rating < 9 THEN 'Good'
    WHEN cr.critic_rating > 5 AND cr.critic_rating <= 7 THEN 'Decent'
    ELSE 'Bad'
END AS 'Reviews:'
FROM titles t
JOIN director d ON t.director_id = d.id
JOIN critic_rating cr ON t.id = cr.titles_id
ORDER BY 1 DESC;

/* Challenge: fixing mistakes */
/* add Rence movies */
INSERT INTO movie_basic(title, genre, release_year, director, studio, critic_rating)
VALUES('Run for the Forest', 'Drama', 1946, 'Rence Pera', 'Lionel Brownstone', 7.3),
('Luck of the Night', 'Drama', 1951, 'Rence Pera', 'Lionel Brownstone', 6.8),
('Invader Glory', 'Adventure', 1953, 'Rence Pera', 'Lionel Brownstone', 5.5);

/* change genre 'sci-fi' to 'sf' for all falsted group flims*/
SELECT * FROM movie_basic
WHERE studio LIKE 'Falstead Group';

UPDATE movie_basic
SET genre = 'SF'
WHERE genre = 'Sci-Fi'
AND studio LIKE 'Falstead Group';

/* remove all the flims Garry Scott did for Lionel Brownstone as those were lost */
SELECT * FROM movie_basic
WHERE director = 'Garry Scott'
AND studio = 'Lionel Brownstone';

DELETE
FROM movie_basic
WHERE director = 'Garry Scott'
AND studio = 'Lionel Brownstone';


/* Challenge: Find the best film */
SELECT t.title, d.dir_name, cr.critic_rating, p.filename
FROM titles t
JOIN director d ON t.director_id = d.id
JOIN critic_rating cr ON t.id = cr.titles_id
JOIN posters p ON t.id = p.titles_id
ORDER BY critic_rating DESC
LIMIT 10;