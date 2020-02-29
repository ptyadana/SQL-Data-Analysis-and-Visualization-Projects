/*
Define an Employees table, with the following fields:

id - number(automatically increments), mandatory, primary key
last_name - text, mandatory
first_name - text, mandatory
middle_name - text, not mandatory
age - number mandatory
current_status - text, mandatory, defaults to 'employed'
*/

CREATE TABLE employees(
	id int auto_increment not null primary key,
	last_name varchar(100) not null,
	first_name varchar(100) not null,
	middle_name varchar(100),
	age int not null,
	current_status varchar(150) not null default 'employed'
);


INSERT INTO employees(first_name,last_name,age,current_status)
VALUES
('Richard','Johnson',30,'Super Employed'),
('Jessica','Wong',25,'Student')