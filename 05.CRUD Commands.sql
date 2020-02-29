/*
data preparation
*/

DROP TABLE cats; 

CREATE TABLE cats 
  ( 
     cat_id INT NOT NULL AUTO_INCREMENT, 
     name   VARCHAR(100), 
     breed  VARCHAR(100), 
     age    INT, 
     PRIMARY KEY (cat_id) 
  ); 

DESC cats; 

INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

#--------------------------#

#id only
SELECT cat_id FROM cats;

#name,breed columns
SELECT name,breed
FROM cats;

#just Tabby breed cats only
SELECT name,age
FROM cats
WHERE breed LIKE 'Tabby';

#cat id same as age
SELECT cat_id,age
FROM cats
WHERE cat_id = age;

#Change Jackson's name to "Jack"
UPDATE cats
SET name = 'Jack'
WHERE name ='Jackson';

#Change Ringo's breed to "British Shorthair"
UPDATE cats
SET breed = 'British Shorthair'
WHERE name = 'Ringo';

#Update both Maine Coons' ages to be 12
UPDATE cats
SET age = 12
WHERE breed = 'Maine Coon';

#DELETE all 4 year old cats
DELETE FROM cats
WHERE age = 4;

#DELETE cats whose age is the same as their cat_id
DELETE FROM cats
WHERE cat_id = age;

#DELETE all cats
DELETE FROM cats;