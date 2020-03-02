/* data prep*/
CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

/*customers by spending high to low order */
/*send them loyality programs,etc*/
SELECT first_name, last_name,SUM(amount) AS total_spending
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spending DESC;


/* customers who haven't spent anything or ordered anything yet */
/*we can send out discount cupons.. etc*/
SELECT first_name, last_name,amount
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
WHERE orders.customer_id IS NULL;

/*-------------------------------------------*/

/*------------------ Challenges -------------------------*/
CREATE TABLE students(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150)
);


CREATE TABLE papers(
	title VARCHAR(150) NOT NULL,
	grade INT NOT NULL,
	student_id INT,
	FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);


/*----------------------*/
/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Samantha   | De Montaigne and The Art of The Essay |    98 |
| Samantha   | Russian Lit Through The Ages          |    94 |
| Carlos     | Borges and Magical Realism            |    89 |
| Caleb      | My Second Book Report                 |    75 |
| Caleb      | My First Book Report                  |    60 |
+------------+---------------------------------------+-------+
*/
SELECT first_name, title,grade
FROM students
JOIN papers ON students.id = papers.student_id
ORDER BY grade DESC;

/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Caleb      | My First Book Report                  |    60 |
| Caleb      | My Second Book Report                 |    75 |
| Samantha   | Russian Lit Through The Ages          |    94 |
| Samantha   | De Montaigne and The Art of The Essay |    98 |
| Raj        | NULL                                  |  NULL |
| Carlos     | Borges and Magical Realism            |    89 |
| Lisa       | NULL                                  |  NULL |
+------------+---------------------------------------+-------+
*/
SELECT first_name, title, grade
FROM students
LEFT JOIN papers ON students.id = papers.student_id;


/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Caleb      | My First Book Report                  | 60    |
| Caleb      | My Second Book Report                 | 75    |
| Samantha   | Russian Lit Through The Ages          | 94    |
| Samantha   | De Montaigne and The Art of The Essay | 98    |
| Raj        | MISSING                               | 0     |
| Carlos     | Borges and Magical Realism            | 89    |
| Lisa       | MISSING                               | 0     |
+------------+---------------------------------------+-------+
*/
SELECT first_name, 
	IFNULL(title,'MISSING'), 
	IFNULL(grade,0)
FROM students
LEFT JOIN papers ON students.id = papers.student_id;


/*
+------------+---------+
| first_name | average |
+------------+---------+
| Samantha   | 96.0000 |
| Carlos     | 89.0000 |
| Caleb      | 67.5000 |
| Raj        | 0       |
| Lisa       | 0       |
+------------+---------+
*/
SELECT first_name,
	IFNULL(AVG(grade),0) AS average
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;


/*
+------------+---------+----------------+
| first_name | average | passing_status |
+------------+---------+----------------+
| Samantha   | 96.0000 | PASSING        |
| Carlos     | 89.0000 | PASSING        |
| Caleb      | 67.5000 | FAILING        |
| Raj        | 0       | FAILING        |
| Lisa       | 0       | FAILING        |
+------------+---------+----------------+
*/
SELECT first_name,
	IFNULL(AVG(grade),0) AS average,
	CASE
		WHEN AVG(grade) >= 75 THEN 'PASSING'
		WHEN AVG(grade) IS NULL THEN 'FAILING'
		ELSE 'FAILING'
	END AS passing_status
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;