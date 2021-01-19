/* Create a Time Series Schema */
CREATE SCHEMA time_series
    AUTHORIZATION postgres;


/* Create a table of location and temperature measurements */
CREATE TABLE time_series.location_temp
(
    event_time timestamp without time zone NOT NULL,
    temp_celcius integer,
    location_id character varying COLLATE pg_catalog."default"
);


ALTER TABLE time_series.location_temp OWNER to postgres;






/* Create table of server monitoring metrics */
CREATE TABLE time_series.utilization
(
    event_time timestamp without time zone NOT NULL,
    server_id integer NOT NULL,
    cpu_utilization real,
    free_memory real,
    session_cnt integer,
    CONSTRAINT utilization_pkey PRIMARY KEY (event_time, server_id)
);


ALTER TABLE time_series.utilization  OWNER to postgres;