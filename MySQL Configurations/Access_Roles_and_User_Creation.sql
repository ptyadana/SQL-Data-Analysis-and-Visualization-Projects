-- creation of new Access Roles
CREATE ROLE 'app_dev', 'app_read', 'app_write';


/* ---------------------------------------------------------- */

-- granting specific access to the roles
GRANT ALL ON movies.* TO 'app_dev';

GRANT SELECT on movies.* TO 'app_read';

GRANT INSERT, UPDATE, DELETE ON movies.* TO 'app_write';

FLUSH PRIVILEGES;

/* ---------------------------------------------------------- */

-- creation of user
CREATE USER 'read1'@'localhost' IDENTIFIED BY 'password123';

-- grand access role to testuser
GRANT 'app_read' TO 'read1'@'localhost';

-- set default role
SET DEFAULT ROLE 'app_read' TO 'read1'@'localhost';

/* ---------------------------------------------------------- */
/* If we don't want to write the "SET DEFAULT ROLE" statement everytime we create new user,
we can do like below.
1) go to Admistration tab
2) Under "Management" > "Status and System Variables"
3) System Variables > search wit "activate"
4) activate_all_roles_on_log_in = ON
5) if we want this setting to be Persist, we can check the checkbox. This means everytime server is restarted, server will remember the setting.
*/

/* ---------------------------------------------------------- */
-- deletion of user
DROP USER 'read1'@'localhost';

-- deletion of roles
DROP ROLE 'app_dev', 'app_read', 'app_write';