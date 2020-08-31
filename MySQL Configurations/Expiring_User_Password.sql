-- Password Expiration for a user
-- This will immediately make user to enter a new password when he/she tries to make a connection
ALTER USER 'tempuser'@'%' PASSWORD EXPIRE;

-- password expire in 90 days for that particular user
ALTER USER 'tempuser'@'%' PASSWORD EXPIRE INTERVAL 90 DAY;


-- Default Password Expiration Setting
/*
This setting will allow us to set default password expiration on organization wide
1)go to "Administration tab"
2) Management tab > Status and System Variables
3) System Variables > search for "default"
4) default_password_lifetime		: default is 0 which means never expire
5) we can set by 30 days, 90 days etc.
6) if we want this setting to be Persist, we can check the checkbox. This means everytime server is restarted, server will remember the setting.
*/
