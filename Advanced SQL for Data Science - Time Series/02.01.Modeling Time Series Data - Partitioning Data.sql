/*********** Partitioning Data ****************/


--------  Create new table with associated Partion Column (event hour: 0 - 24 hours) --------

/* Create a table of location and temperature measurements */
CREATE TABLE time_series.location_temp_p(
	event_time TIMESTAMP NOT NULL,
	event_hour INT,
	temp_celcius INT,
	location_id CHARACTER VARYING COLLATE pg_catalog."default"
)PARTITION BY RANGE(event_hour);



/* Create 12 partition nodes for that above table */
-- range start value is inclusive, end value is exclusive
CREATE TABLE time_series.location_temp_p1 PARTITION OF time_series.location_temp_p
	FOR VALUES FROM (0) TO (2);

-- together we will create index event_time for each partition node table
CREATE INDEX idx_loc_temp_p1 ON time_series.location_temp_p1(event_time);



/* continue creating another 11 nodes */
CREATE TABLE time_series.location_temp_p2 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (2) TO (4);
CREATE INDEX idx_loc_temp_p2 ON time_series.location_temp_p2(event_time);


CREATE TABLE time_series.location_temp_p3 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (4) TO (6);
CREATE INDEX idx_loc_temp_p3 ON time_series.location_temp_p3(event_time);


CREATE TABLE time_series.location_temp_p4 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (6) TO (8);
CREATE INDEX idx_loc_temp_p4 ON time_series.location_temp_p4(event_time);


CREATE TABLE time_series.location_temp_p5 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (8) TO (10);
CREATE INDEX idx_loc_temp_p5 ON time_series.location_temp_p5(event_time);


CREATE TABLE time_series.location_temp_p6 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (10) TO (12);
CREATE INDEX idx_loc_temp_p6 ON time_series.location_temp_p5(event_time);


CREATE TABLE time_series.location_temp_p7 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (12) TO (14);
CREATE INDEX idx_loc_temp_p7 ON time_series.location_temp_p7(event_time);


CREATE TABLE time_series.location_temp_p8 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (14) TO (16);
CREATE INDEX idx_loc_temp_p8 ON time_series.location_temp_p8(event_time);


CREATE TABLE time_series.location_temp_p9 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (16) TO (18);
CREATE INDEX idx_loc_temp_9 ON time_series.location_temp_p9(event_time);


CREATE TABLE time_series.location_temp_p10 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (18) TO (20);
CREATE INDEX idx_loc_temp_p10 ON time_series.location_temp_p10(event_time);


CREATE TABLE time_series.location_temp_p11 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (20) TO (22);
CREATE INDEX idx_loc_temp_p11 ON time_series.location_temp_p11(event_time);


CREATE TABLE time_series.location_temp_p12 PARTITION OF time_series.location_temp_p
    FOR VALUES FROM (22) TO (24);
CREATE INDEX idx_loc_temp_p12 ON time_series.location_temp_p12(event_time);


--------- Copy original data to newly created Partitioned Table ------------
INSERT INTO time_series.location_temp_p(
	event_time, event_hour, temp_celcius, location_id
)
(
SELECT event_time, EXTRACT(HOUR FROM event_time), temp_celcius, location_id
	FROM time_series.location_temp
);

