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


