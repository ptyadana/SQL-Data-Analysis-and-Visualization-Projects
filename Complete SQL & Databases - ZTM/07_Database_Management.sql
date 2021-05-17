/************************ 5) Template Databases ****************/
/*
	In General, there are 2 templates; Template0 and Template1.
	Template0 is kinda like safty net and used it to create Template1.
	You don't want to mess up with Template0.
*/

/******** Create Own Templates **********/
CREATE DATABASE mysuperdupertemplate;
--connect to that db and run
CREATE TABLE superdupertable();
--after creating the database and connect to it, you will see that table.
CREATE DATABASE mysuperduperdatabase WITH mysuperdupertemplate;


/*--------------------------------------------------------------------------------------------------------------*/

/*********** 6) Creating a Database **************/
/*
		TEMPLATE			: template01
		ENCODING			: UTF8
		CONNECTION_LIMIT	: 100
		OWNER				: Current User
*/
CREATE DATABASE db_name
	[[WITH] [OWNER [=] user_name]
	 		[TEMPLATE [=] template]
	 		[ENCODING [=] encoding]
	 		[LC_COLLATE [=] lc_collate]
	 		[LC_CTYPE [=] lc_ctype]
	 		[TABLESPACE [=] tablespace]
	 		[CONNECTION LIMIT [=] connlimit]]
			
			
-- to store ZTM db to store courses
CREATE DATABASE ZTM;

-- Create Schema
CREATE SCHEMA Sales;


/*--------------------------------------------------------------------------------------------------------------*/

/*********** 9) Creating Role **************/
CREATE ROLE readonly WITH LOGIN ENCRYPTED PASSWORD 'readonly';

-- to check all avaliable roles
>> \du

/*
By default, when you create a new database - only Superuser and creater of the db can access to it. Other users must be given access to it, if required.
*/

/************ 10) Creating users and Configuring Login *************/

-- create role and user
CREATE ROLE test_role_with_login WITH LOGIN ENCRYPTED PASSWORD 'password';

CREATE USER test_user_with_login WITH ENCRYPTED PASSWORD 'password';

\du

/************ Another way of creating user *********/
-- if you are not connected with postgre, there is binary command that we can use, just follow on screen questions.
createuser --interactive 

/******* Altering Role *********/
AlTER ROLE test_interactive WITH ENCRYPTED PASSWORD 'password';

/*--------------------------------------------------------------------------------------------------------------*/

/******** Checking hba and config file location *****/
-- login with root user
SHOW hba_file;
SHOW config_file;

/*--------------------------------------------------------------------------------------------------------------*/

/******** 11/12) Privileges *********/
GRANT ALL PRIVILEGES ON <table> TO <user>;
GRANT ALL ON ALL TABLES [IN SCHEMA <schema>] TO <user>;
GRANT [SELECT, UPDATE, INSERT, ...] ON <table> [IN SCHEMA <schema>] TO <user>;

-- grant select to our test user
GRANT SELECT ON titles TO test_user_with_login;

-- revoke privileges from test user
REVOKE SELECT ON titles FROM test_user_with_login;

-- Grant all access
GRANT ALL ON ALL TABLES IN SCHEMA public TO test_user_with_login;

-- Revoke all access
REVOKE ALL ON ALL TABLES IN SCHEMA public TO test_user_with_login;

-- Create a role with privileges and grant that role a specific user
CREATE ROLE employee_read;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO employee_read;
GRANT employee_read TO test_user_with_login;
GRANT employee_read TO test_user_with_login;
REVOKE employee_read FROM test_user_with_login;


/*--------------------------------------------------------------------------------------------------------------*/

/******** 13) Best Practices For Role Management *********/

/*
	When managing Roles and Permissions, always go with the "Principle Of Least Privilege".
	Give no Privilege at all at first. Then stack on privileges as required.
	
	Don't use Super/Admin by default.
	
*/

/*--------------------------------------------------------------------------------------------------------------*/

/************ 15) Storing Texts **********/
CREATE TABLE test(
	fixed char(4),
	variable varchar(20),
	unlimited text
);

INSERT INTO test VALUES(
	'abcd',
	'efghijklm',
	'This is super unlimited'
);


/************ 16) Storing Numbers **********/

CREATE TABLE test(
	four float4,
	eight float8,
	big decimal
);

INSERT INTO test VALUES(
	1.123456789,
	1.123456789123456789,
	1.123456789123456789123456789123456789123456789123456789
);

/************ 17) Storing Arrays **********/
CREATE TABLE test(
	four char(2)[],
	eight text[],
	big float64[]
);

INSERT INTO test VALUES(
	ARRAY['ab', 'cd', 'ef'],
	ARRAY['test', 'sunny', 'goblin'],
	ARRAY[1.23, 3.45, 6.78, 9.2345234]
);

/*--------------------------------------------------------------------------------------------------------------*/

/************ 19) Create Tables **************/

CREATE TABLE <name> (
	<col1> TYPE [Constraint],
	table_constraint [Constraint]
)[INHERITS <existing_table>];

-- create table for ztm db
-- first need to create extension, otherwise we can't use uuid_generate_v4() function.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE student(
	student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	date_of_birth DATE NOT NULL
);

-- check the existing tables
>> \dt

-- check the newly created student table
>> \d student

/*--------------------------------------------------------------------------------------------------------------*/

/************ 21) Column Constraints **************/

/*
			NOT NULL			: cannot be Null
			PRIMARY KEY			: column will be primary key
			UNIQUE				: can only contain unique values (Null is Unique)
			CHECK				: apply a special condition check against the values in the column
			REFERENCES			: used in Foreign Key referencing
*/