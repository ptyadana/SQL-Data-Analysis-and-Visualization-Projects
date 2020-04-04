/* Regular Expressions */
SELECT *
FROM customers
WHERE last_name LIKE '%field%';

SELECT *
FROM customers
WHERE last_name REGEXP 'field';

/* 
^		: beginning of the string of the field
$		: end of the string
|		: either OR
[]		: includes one of these insides []. set of characters [abc] OR [a-h]
*/
SELECT *
FROM customers
WHERE last_name REGEXP 'field$';

SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac|rose';

SELECT *
FROM customers
WHERE last_name REGEXP '^field|mac|rose';

/*
ge
ie
me
includes in last name
*/
SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';

/*
ae
be
...
he
includes in last name
*/
SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';

/*
Get the customers whose
- first names are ELKA or AMBUR
- last names end with EY or ON
- last name start with MY or contain SE
- last name contain B followed by R or U
*/
SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';

SELECT *
FROM customers
WHERE last_name REGEXP 'EY$|ON$';

SELECT *
FROM customers
WHERE last_name REGEXP '^MY|SE';

SELECT *
FROM customers
WHERE last_name REGEXP 'B[R|U]';