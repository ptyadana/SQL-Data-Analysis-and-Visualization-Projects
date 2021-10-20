  create schema interviews;

  set schema 'interviews';

    -- q1 
  drop table if exists post_events;

  CREATE TABLE post_events (
  user_id integer, 
  created_at date, 
  event_name varchar(50) -- (enter, post, cancel)
  );

  insert into post_events values (1, '2020-06-01', 'enter');
  insert into post_events values (1, '2020-06-01', 'post');
  insert into post_events values (2, '2020-06-01', 'enter');
  insert into post_events values (2, '2020-06-01', 'cancel');
  insert into post_events values (2, '2020-06-01', 'enter');
  insert into post_events values (2, '2020-06-01', 'cancel');
  insert into post_events values (1, '2020-06-02', 'enter');
  insert into post_events values (1, '2020-06-02', 'cancel');
  insert into post_events values (3, '2020-06-02', 'enter');
  insert into post_events values (3, '2020-06-02', 'post');
  insert into post_events values (1, '2020-06-03', 'enter');
  insert into post_events values (1, '2020-06-03', 'cancel');
  insert into post_events values (3, '2020-06-03', 'enter');
  insert into post_events values (3, '2020-06-03', 'cancel');

    -- q2 
  drop table if exists eu_energy;
  drop table if exists asia_energy;
  drop table if exists na_energy;
 
  CREATE TABLE eu_energy (
  date date, 
  consumption int
  );

  CREATE TABLE asia_energy (
  date date, 
  consumption int
  );

  CREATE TABLE na_energy (
  date date, 
  consumption int
  );

  insert into eu_energy values ('2019-06-01', 10);
  insert into eu_energy values ('2019-06-02', 11);
  insert into eu_energy values ('2019-06-03', 20);
  insert into eu_energy values ('2019-06-04', 10);
  insert into eu_energy values ('2019-06-05', 10);
  insert into eu_energy values ('2019-06-06', 10);

  insert into asia_energy values ('2019-06-01', 44);
  insert into asia_energy values ('2019-06-02', 30);
  insert into asia_energy values ('2019-06-03', 12);
  insert into asia_energy values ('2019-06-04', 30);
  insert into asia_energy values ('2019-06-05', 30);
  insert into asia_energy values ('2019-06-06', 44);

  insert into na_energy values ('2019-06-01', 29);
  insert into na_energy values ('2019-06-02', 30);
  insert into na_energy values ('2019-06-03', 29);
  insert into na_energy values ('2019-06-04', 29);
  insert into na_energy values ('2019-06-05', 29);
  insert into na_energy values ('2019-06-06', 29);

  -- q3 

  drop table if exists account_status;

  CREATE TABLE account_status (
  acc_id int, 
  date date, 
  status varchar(20) -- (open, closed)
  );

  insert into account_status values (1, '2020-01-07', 'open');
  insert into account_status values (2, '2020-01-07', 'open');
  insert into account_status values (3, '2020-01-07', 'open');
  insert into account_status values (4, '2020-01-07', 'open');
  insert into account_status values (1, '2020-01-08', 'open');
  insert into account_status values (2, '2020-01-08', 'closed');
  insert into account_status values (3, '2020-01-08', 'open');
  insert into account_status values (4, '2020-01-08', 'open');
  insert into account_status values (1, '2020-01-09', 'open');
  insert into account_status values (2, '2020-01-09', 'closed');
  insert into account_status values (3, '2020-01-09', 'open');
  insert into account_status values (4, '2020-01-09', 'closed');
  insert into account_status values (1, '2020-01-10', 'open');
  insert into account_status values (2, '2020-01-10', 'open');
  insert into account_status values (3, '2020-01-10', 'open');
  insert into account_status values (4, '2020-01-10', 'closed');

  -- q4 

  drop table if exists request_logs;

  CREATE TABLE request_logs (
  request_id int, 
  request_date date, 
  request_status varchar(20), -- ('canceled_by_driver', 'canceled_by_client', 'success')
  distance_to_travel float, 
  monetary_cost float, 
  driver_to_client_distance float
  );

  insert into request_logs values (1, '2020-01-07', 'success', 15, 22, 4);
  insert into request_logs values (2, '2020-01-09', 'success', 12, 10, 9);
  insert into request_logs values (3, '2020-01-11', 'success', 9, 4, 4);
  insert into request_logs values (4, '2020-01-21', 'canceled_by_driver', 13, 11, 40); 
  insert into request_logs values (5, '2020-02-07', 'success', 15, 22, 4);
  insert into request_logs values (6, '2020-02-09', 'canceled_by_client', 20, 32, 50);
  insert into request_logs values (7, '2020-02-11', 'success', 56, 60, 1);
  insert into request_logs values (8, '2020-02-21', 'canceled_by_driver', 3, 5, 99);   
  insert into request_logs values (9, '2020-03-07', 'success', 15, 22, 4);
  insert into request_logs values (10, '2020-03-09', 'success', 12, 10, 9);
  insert into request_logs values (11, '2020-03-11', 'success', 9, 4, 4);
  insert into request_logs values (12, '2020-03-21', 'canceled_by_client', 13, 11, 40); 
  insert into request_logs values (13, '2020-04-07', 'success', 15, 22, 4);
  insert into request_logs values (14, '2020-04-09', 'success', 16, 9, 1);
  insert into request_logs values (15, '2020-04-11', 'success', 18, 25, 6);
  insert into request_logs values (16, '2020-04-21', 'canceled_by_driver', 88, 121, 6);  

  -- q5
  drop table if exists twitter_employee;

  CREATE TABLE twitter_employee (
  id int,
  first_name varchar(50),
  last_name varchar(50),
  age int,
  sex varchar(10),
  employee_title varchar(50),
  department varchar(50),
  salary int,
  target int,
  bonus int,
  email varchar(50),
  city varchar(20),
  address varchar(100),
  manager_id int
  );

  insert into twitter_employee values (1, 'Jacob', 'Smith', 28, 'male', 'software engineer', 'tech', 80000, 82000, 10000, 
    'jacobsmith@twitter.com','bay area', NULL, 2);
  insert into twitter_employee values (2, 'Sally', 'White', 33, 'female', 'software engineer manager', 'tech', 110000, 120000, 15000, 
    'sallywhite@twitter.com','chicago', NULL, 4);
  insert into twitter_employee values (3, 'Arvind', 'Agarwal', 45, 'male', 'software engineer', 'tech', 400000, 420000, 50000, 
    NULL,'', NULL, 2);
  insert into twitter_employee values (4, 'Lisa', 'Kim', 28, NULL, 'data scientist', 'tech', 70000, 790000, 12000, 
    NULL,'charlotte', NULL, 2);


  insert into twitter_employee values (5, 'Ajay', 'Khan', 19, NULL, 'product manager intern', 'product', 40000, 40000, NULL, 
    NULL,'denver', NULL, NULL);
  insert into twitter_employee values (6, 'Walter', 'White', 25, NULL, 'project manager', 'product', 100000, 100000, NULL, 
    NULL,'toronto', NULL, NULL);
  insert into twitter_employee values (7, 'Paris', 'Green', 25, NULL, 'product manager', 'product', 100000, 100000, NULL, 
    NULL,'toronto', NULL, NULL);
  insert into twitter_employee values (12, 'Kyle', 'Kyle', 50, NULL, 'product manager', 'product', 1200000, 1200000, NULL, 
    NULL,'bay area', NULL, NULL);



  insert into twitter_employee values (8, 'Kelly', 'James', 19, NULL, NULL, 'hr', 40000, 40000, 20000, 
    NULL,NULL, NULL, NULL);
  insert into twitter_employee values (9, 'Susan', 'Lee', 43, 'female', NULL, 'hr', 60000, 60000, 20000, 
    NULL,NULL, NULL, NULL);
  insert into twitter_employee values (10, 'Jonas', 'Kwan', 25, 'male', NULL, 'hr', 60000, 60000, 20000, 
    NULL,NULL, NULL, NULL);
  insert into twitter_employee values (11, 'Amanda', 'Lee', 40, 'non-binary', 'hr lead', 'hr', 300000, 300000, 30000, 
    NULL,NULL, NULL, NULL);

insert into twitter_employee values (13, 'Beepbeep', 'Boop', 1, 'male', 'cat', 'entertainment', NULL, NULL, NULL, 
    NULL,'chicago', NULL, NULL);
  insert into twitter_employee values (14, 'Boop', 'Beepbeep', 1, 'female', 'cat', 'entertainment', NULL, NULL, NULL, 
    NULL,'chicago', NULL, NULL);

-- q6
drop table if exists users;
drop table if exists comments;

  CREATE TABLE users (
  id int,
  name varchar(50),
  joined_at date,
  city_id int,
  device int
  );

  CREATE TABLE comments (
  user_id int,
  body varchar(500),
  created_at date
  );

  insert into users values (1, 'Bob Smith', '2018-01-23', 12, 9421);
  insert into users values (2, 'Ashley Sparks', '2019-01-01', 12, 9422);
  insert into users values (3, 'Donald Rump', '2020-01-14', 11, 9421);
  insert into users values (4, 'Jacob Smith', '2018-08-31', 31, 9423);
  insert into users values (5, 'Amanda Leon', '2018-04-18', 31, 9424);
  insert into users values (6, 'Robert Little', '2018-07-23', 12, 9425);
  insert into users values (7, 'Robert Big', '2020-01-31', 12, 9426);
  insert into users values (8, 'Stuart Little', '2017-05-17', 11, 1356);
  insert into users values (9, 'Samantha Junior', '2018-01-23', 12, 3421);
  insert into users values (10, 'Kyle Curry', '2018-01-23', 12, 6537);
  insert into users values (11, 'Jay Kim', '2018-01-21', 12, 2952);
  insert into users values (12, 'Allen Barbara', '2018-11-25', 12, 6859);
  insert into users values (13, 'Kelley Patel', '2011-01-01', 11, 5909);
  insert into users values (14, 'Danielle Kaur', '2019-12-23', 12, 4950);


  insert into comments values (1, 'I love cats', '2020-01-23');
  insert into comments values (1, 'and dogs!', '2020-01-23');
  insert into comments values (1, 'because there is meaning', '2020-01-23');
  insert into comments values (7, 'cats are alright', '2020-01-18');
  insert into comments values (7, 'no cats are great', '2020-01-05');
  insert into comments values (12, 'I like papayas', '2020-01-21');
  insert into comments values (12, 'no', '2020-01-31');
  insert into comments values (12, 'im being nice', '2020-01-05');
  insert into comments values (4, 'no go away', '2020-01-05');
  insert into comments values (11, 'good', '2020-01-05');
  insert into comments values (11, 'jolly good', '2020-05-05');
  insert into comments values (11, 'cauliflower rice', '2020-11-05');
  insert into comments values (5, 'data science is great!', '2020-01-11');
  insert into comments values (11, 'yeah its alright', '2020-01-11');

-- q7

drop table if exists transactions;

  CREATE TABLE transactions (
  id int,
  created_at date,
  value int,
  purchase_id int
  );

  insert into transactions values (1, '2020-01-23', 10, 100);
  insert into transactions values (1, '2020-01-23', 99, 101);
  insert into transactions values (1, '2020-02-23', 242, 102);
  insert into transactions values (1, '2020-02-23', 135, 103);
  insert into transactions values (1, '2020-02-23', 234, 104);
  insert into transactions values (1, '2020-03-23', 3453, 105);
  insert into transactions values (1, '2020-04-23', 112, 106);
  insert into transactions values (1, '2020-04-23', 1453, 107);
  insert into transactions values (1, '2020-05-23', 4564, 108);

-- q8 = q4 

-- q9 
drop table if exists web_log;

CREATE TABLE web_log (
  user_id int,
  timestamp timestamp,
  action varchar(20)
  -- ('page_load', 'page_exit', 'scoll_up', 'scroll_down')
);

insert into web_log values (1, NOW() - interval '1 hour 30 minutes', 'page_load');
insert into web_log values (1, NOW() - interval '1 hour 10 minutes', 'page_load');
insert into web_log values (1, NOW() - interval '1 hour 5 minutes', 'scroll_up');
insert into web_log values (1, NOW() - interval '1 hour 4 minutes', 'scroll_down');
insert into web_log values (1, NOW() - interval '1 hour 3 minutes', 'scroll_down');
insert into web_log values (1, NOW() - interval '1 hour 3 minutes', 'page_exit');

insert into web_log values (2, NOW() - interval '3 hour 30 minutes', 'page_load');
insert into web_log values (2, NOW() - interval '3 hour 10 minutes', 'page_load');
insert into web_log values (2, NOW() - interval '2 hour 5 minutes', 'scroll_up');
insert into web_log values (2, NOW() - interval '2 hour 4 minutes', 'scroll_down');
insert into web_log values (2, NOW() - interval '2 hour 3 minutes 4 seconds', 'scroll_down');
insert into web_log values (2, NOW() - interval '2 hour 3 minutes 1 second', 'scroll_down');
insert into web_log values (2, NOW() - interval '2 hour 3 minutes', 'scroll_down');
insert into web_log values (2, NOW() - interval '1 hour', 'page_exit');
insert into web_log values (2, NOW() - interval '1 hour', 'page_exit');

insert into web_log values (3, NOW() - interval '10 days 2 hours 5 minutes', 'scroll_down');
insert into web_log values (3, NOW() - interval '10 days 2 hours 4 minutes', 'scroll_down');

insert into web_log values (4, NOW() - interval '13 days 21 hours 10 minutes', 'page_load');
insert into web_log values (4, NOW() - interval '13 days 2 hours 4 minutes', 'scroll_down');
insert into web_log values (4, NOW() - interval '13 days 2 hours 3 minutes', 'scroll_down');

-- q10 

  DROP TABLE IF EXISTS orders; 
  DROP TABLE IF EXISTS customers;

  CREATE TABLE customers (
    id INTEGER,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(10) NOT NULL,
    city VARCHAR(20),
    address VARCHAR(50),
    phone_number VARCHAR(10),
    PRIMARY KEY (id)
  );

  CREATE TABLE orders (
    id INTEGER,
    cust_id INTEGER NOT NULL,
    order_date VARCHAR(10) NOT NULL,
    order_quantity INTEGER NOT NULL,
    order_details VARCHAR(50),
    order_cost INTEGER NOT NULL,
    PRIMARY KEY (id)
  );


  INSERT INTO customers VALUES (1, 'John', 'Adam','London', '2020 Park Drive', '9944563214');
  INSERT INTO customers VALUES (2, 'Sally','Brown','Chicago', NULL, '9594836054');
  INSERT INTO customers VALUES (7, 'Jim','Tee','Tokyo', '50 North Street', '9594896054');
  INSERT INTO customers VALUES (3, 'Pauline', 'Jones', NULL, NULL, NULL);
  INSERT INTO customers VALUES (4, 'David', 'White', 'Colorado', NULL, NULL);
  INSERT INTO customers VALUES (5, 'Sal', 'Tan', 'Amsterdam', '10 Amsterdam Road', NULL);
  INSERT INTO customers VALUES (6, 'Karen', 'Lee', 'Kingston', NULL, '4563978500');

  INSERT INTO orders VALUES (1, 1,'2019-03-04', 5, 'hat', 20);
  INSERT INTO orders VALUES (2, 1, '2019-03-12', 1, 'sweater', 100);
  INSERT INTO orders VALUES (3, 3, '2019-04-12', 1, 'sweater', 100);
  INSERT INTO orders VALUES (4, 3, '2019-04-12', 2, 'coat', 400);
  INSERT INTO orders VALUES (5, 2, '2019-01-01', 1, 'coat', 400);
  INSERT INTO orders VALUES (6, 6, '2019-04-01', 3, 'shoes', 100);
  INSERT INTO orders VALUES (7, 6, '2019-04-01', 3, 'vest', 200);
  INSERT INTO orders VALUES (8, 6, '2019-04-28', 1, 'vest', 200);

  COMMIT;