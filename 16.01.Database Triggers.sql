CREATE DATABASE trigger_demo;

use trigger_demo;


CREATE TABLE users(
	username VARCHAR(50),
	age INT);


/*CREATION demo trigger*/
DELIMITER $$
CREATE TRIGGER must_be_adult
	BEFORE INSERT ON users FOR EACH ROW
	BEGIN
		IF NEW.age < 18
		THEN
			SIGNAL SQLSTATE '45000'
				SET message_text = 'must be an adult!';
		END IF;
	END;
$$

DELIMITER ;

INSERT INTO users(username,age)
VALUES('adam',20);

/*Error Code: 1644. must be an adult!*/
INSERT INTO users(username,age)
VALUES('bob',15);

/*DELETE demo trigger*/
DROP TRIGGER must_be_adult;

/*-------------------------------------------*/

/* follower id cannot equal to followee id */
DELIMITER $$
CREATE TRIGGER follower_trigger
	BEFORE INSERT ON follows FOR EACH ROW
	BEGIN
		IF NEW.follower_id = NEW.followee_id
		THEN
			SIGNAL SQLSTATE '45000'
			SET message_text = 'Follower Id cannot be same as Followee Id !';
		END IF;
	END;
$$
DELIMITER ;

/*-------------------------------------------*/

/*log the history of unfollow cases VERSION 1*/
DELIMITER $$
CREATE TRIGGER capture_unfollow
	AFTER DELETE ON follows FOR EACH ROW
	BEGIN
		INSERT INTO unfollows(follower_id,followee_id)
		VALUES(OLD.follower_id,OLD.followee_id);
	END;
$$
DELIMITER ;


/*log the history of unfollow cases VERSION 2*/
DELIMITER $$
CREATE TRIGGER capture_unfollow
	AFTER DELETE ON follows FOR EACH ROW
	BEGIN
		INSERT INTO unfollows
		SET follower_id = OLD.follower_id,
			followee_id = OLD.followee_id;
	END;
$$
DELIMITER ;

/*-------------------------------------------*/
