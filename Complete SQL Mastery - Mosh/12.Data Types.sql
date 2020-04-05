/********************************************/
/*           Data Types                     */
/********************************************/

/********************************************/
/*          String     	                    */
/********************************************/

/*
- be consistent
VARCHAR (50) 		: short string
VARCHAR (255)		: medium lenght string

CHAR(x)				: fixed length
VARCHAR(x)			: MAX 65,535 characters (~64 KB)
MEDIUMTEXT			: MAX 16MB
LONGTEXT			: MAX 4GB
TINYTEXT			: MAX 255 bytes
TEXT				: MAX 64 KB


English				: 1B
European / Middle - eastern: 2B
Asian				: 3B

*/


/********************************************/
/*          Integers   	                    */
/********************************************/
/*
TINYINT			1b			[-128,127]
UNSIGNED TINYINT			[0-255]

SMALLINT		2b			[-32K,32K]
MEDIUMINT		3b			[-8M,8M]
INT				4b			[-2B,2B]
BIGINT			8b			[-9Z,9Z]

*/
/********************************************/
/*          ZERO FILL   	                */
/********************************************/
/*
IF using ZEROFILL,
for INT			=> 0001			 will be displayed.
`id` INT UNSIGNED ZEROFILL NOT NULL 

When you select a column with type ZEROFILL it pads the displayed value of the field with zeros up to the display width specified in the column definition. Values longer than the display width are not truncated. Note that usage of ZEROFILL also implies UNSIGNED.

Using ZEROFILL and a display width has no effect on how the data is stored. It affects only how it is displayed.

Here is some example SQL that demonstrates the use of ZEROFILL:

CREATE TABLE yourtable (x INT(8) ZEROFILL NOT NULL, y INT(8) NOT NULL);
INSERT INTO yourtable (x,y) VALUES
(1, 1),
(12, 12),
(123, 123),
(123456789, 123456789);
SELECT x, y FROM yourtable;
Result:

        x          y
 00000001          1
 00000012         12
 00000123        123
123456789  123456789

*/

/********************************************/
/*          Fixed Point and Floating Point  */
/********************************************/
/*

DECIMAL (p,s)				=> precision (maxium number of digits) , scale (number of digits after the decimal point)
DECIMAL (9,2)				=> 1234567.89

DEC
NUMERIC
FIXED

FLOAT			4b
DOUBLE			8b

*/

/********************************************/
/*          Boolean							*/
/********************************************/
/*
BOOL
BOOLEAN

TRUE/FALSE (or) 1/0

*/

/********************************************/
/*          ENUM / SET   					*/
/********************************************/
/*
if we want to restrict the values

ENUM('small','medium','large')

ADD COLUMN size ENUM('small','medium','large')

*/


/********************************************/
/*          DATE / TIME  					*/
/********************************************/
/*

DATE
TIME
DATETIME			8b
TIMESTAMP			4b	(only up to 2038) which is called  2038 probelm
YEAR

*/

/********************************************/
/*          Blobs        					*/
/********************************************/
/*

TINYBLOB			255b
BLOB				65KB
MEDIUMBLOB			16MB
LONGBLOB			4GB

*/

/********************************************/
/*          JSON        					*/
/********************************************/
/*
{"key":value}
*/

/********************************************/
/*          Creating JSON  					*/
/********************************************/
UPDATE products
SET properties ='
{
"dimensions":[1,2,3],
"weight":10,
"manufacture":{"name":"sony"}
}
'
WHERE product_id = 1;


UPDATE products
SET properties = JSON_OBJECT(
		'dimensions', JSON_ARRAY(1,2,3),
        'weight',10,
        'manufacture', JSON_OBJECT('name','sony')
)
WHERE product_id = 2;

/********************************************/
/*          Rerieving JSON					*/
/********************************************/

SELECT product_id, JSON_EXTRACT(properties, '$.weight')
FROM products
WHERE product_id = 1;

SELECT product_id, properties -> '$.di'
FROM products
WHERE product_id = 1;

SELECT product_id, properties -> '$.dimensions[0]'
FROM products
WHERE product_id = 1;

SELECT product_id, properties -> '$.manufacture.name'
FROM products
WHERE product_id = 1;

SELECT product_id, properties ->> '$.manufacture.name'
FROM products
WHERE properties ->> '$.manufacture.name' = 'sony';

/********************************************/
/*          Set / Update JSON    			*/
/********************************************/
UPDATE products
SET properties = JSON_SET(
	properties,
    '$.weight',20,
    '$.age',10
)
WHERE product_id = 2;

/********************************************/
/*          Remove JSON         			*/
/********************************************/
UPDATE products
SET properties = JSON_REMOVE(
	properties,
    '$.age'
)
WHERE product_id = 2;
