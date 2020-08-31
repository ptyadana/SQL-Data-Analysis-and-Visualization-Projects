-- show engines
SHOW ENGINES;

/*
Default Storage Engine is InnoDB
Others Engines are: MyISAM, MEMORY, CSV, BLACKHOLE, ARCHIVE, MERGE_MYISAM, performance, FEDERATED
*/
CREATE TABLE IF NOT EXISTS test(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30)
)ENGINE = InnoDB;

-- check engine information of a schema
SELECT table_name, engine
FROM information_schema.tables WHERE table_schema='movies';