/************************************************/
/* Transactions and Concurrency				    */
/************************************************/
/*
ACID properties

Atomicity
Consistency
Isolation
Durability
*/

/************************************************/
/* Creating Transactions			     	    */
/************************************************/
SHOW VARIABLES like 'autocommit';
SET autocommit = 0;

USE mosh_sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES(1,'2020-04-05',1);

INSERT INTO ordessr_items
VALUES(LAST_INSERT_ID(),1,1,1);

COMMIT;

SET autocommit = 1;

/************************************************/
/* Concurrency and Locking			     	    */
/************************************************/

/************************************************/
/* Cocurrency Problems                          */
/************************************************/

/*
	- Lost Updates
    - Dirty Reads
    - Non Repating Reads
    - Phantom Reads
    
    
 1) Lost Updates
 - This problem occurs when multiple transactions execute concurrently and updates from one or more transactions get lost.
 
 Solution Isolation Level: LOCK
 
 
 2) Dirty Reads
 - Reading the data written by an uncommitted transaction is called as dirty read.
 
  Solution Isolation Level: READ COMMITTED
 
 
 3) Non Repating Reads / Unrepeatable Reads
 - This problem occurs when a transaction gets to read unrepeated 
 i.e. different values of the same variable in its different read operations even when it has not updated its value.
 
 Solution Isolation Level: REPEATABLE READ
 
 
 4) Phantom Reads
 - This problem occurs when a transaction reads some variable from the buffer 
 and when it reads the same variable later, it finds that the variable does not exist.
 
  Solution Isolation Level:	SERIALIZABLE

*/

/************************************************/
/* Transaction Isolation Levels                 */
/************************************************/
/*

- the higher the isolation level, the lower the concurrency issues as it can solve these.
- but the price is cost is very expensive as it can slow the queries.
- SERIALIZABLE make sure each queries are running in sequences and wait other to be completed.

									Lost Updates		Dirty Reads			Non-Repeating Reads			Phantom Reads

(isolation level)
4) SERIALIZABLE						   SOLVED              SOLVED                 SOLVED                  SOLVED

3) REPEATABLE READ					   SOLVED              SOLVED                 SOLVED

2) READ COMMITED                                           SOLVED

1) READ UNCOMMITED 
*/

SHOW VARIABLES LIKE 'transaction_isolation';

/*for session only*/
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

/*for global*/
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;



/************************************************/
/* DeadLocks                                    */
/************************************************/
/*
A deadlock is a situation in which two or more transactions are waiting for one another to give up locks.
*/