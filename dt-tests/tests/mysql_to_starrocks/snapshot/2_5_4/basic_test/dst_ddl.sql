--  docker run -p 9030:9030 -p 8030:8030 -p 8040:8040 -itd starrocks.docker.scarf.sh/starrocks/allin1-ubuntu:2.5.4

DROP DATABASE IF EXISTS test_db_1;

CREATE DATABASE test_db_1;

CREATE TABLE test_db_1.one_pk_no_uk ( f_0 TINYINT, f_1 SMALLINT DEFAULT NULL, f_2 INT DEFAULT NULL, f_3 INT DEFAULT NULL, f_4 BIGINT DEFAULT NULL, f_5 DECIMAL(10,4) DEFAULT NULL, f_6 FLOAT DEFAULT NULL, f_7 DOUBLE DEFAULT NULL, f_9 DATETIME DEFAULT NULL, f_10 VARCHAR(255) DEFAULT NULL, f_11 DATE DEFAULT NULL, f_12 INT DEFAULT NULL, f_13 VARCHAR(255) DEFAULT NULL, f_14 CHAR(255) DEFAULT NULL, f_15 VARCHAR(255) DEFAULT NULL, f_18 VARCHAR(255), f_19 STRING, f_20 STRING, f_21 STRING) ENGINE=OLAP PRIMARY KEY(f_0) DISTRIBUTED BY HASH(f_0) PROPERTIES ("replication_num" = "1");
