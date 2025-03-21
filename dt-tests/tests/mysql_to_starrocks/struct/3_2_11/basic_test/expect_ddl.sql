test_db_1
CREATE DATABASE `test_db_1`

dst_test_db_2
CREATE DATABASE `dst_test_db_2`

test_db_1.one_pk_no_uk
CREATE TABLE `one_pk_no_uk` (
  `f_0` tinyint(4) NOT NULL COMMENT "",
  `f_1` smallint(6) NULL COMMENT "",
  `f_2` int(11) NULL COMMENT "",
  `f_3` int(11) NULL COMMENT "",
  `f_4` bigint(20) NULL COMMENT "",
  `f_5` decimal(10, 4) NULL COMMENT "",
  `f_6` float NULL COMMENT "",
  `f_7` double NULL COMMENT "",
  `f_8` bigint(20) NULL COMMENT "",
  `f_9` datetime NULL COMMENT "",
  `f_10` varchar(255) NULL COMMENT "",
  `f_11` date NULL COMMENT "",
  `f_12` int(11) NULL COMMENT "",
  `f_13` datetime NULL COMMENT "",
  `f_14` char(255) NULL COMMENT "",
  `f_15` varchar(255) NULL COMMENT "",
  `f_16` varbinary NULL COMMENT "",
  `f_17` varbinary NULL COMMENT "",
  `f_18` varchar(65533) NULL COMMENT "",
  `f_19` varchar(65533) NULL COMMENT "",
  `f_20` varchar(65533) NULL COMMENT "",
  `f_21` varchar(65533) NULL COMMENT "",
  `f_22` varbinary NULL COMMENT "",
  `f_23` varbinary NULL COMMENT "",
  `f_24` varbinary NULL COMMENT "",
  `f_25` varbinary NULL COMMENT "",
  `f_26` varchar(255) NULL COMMENT "",
  `f_27` varchar(255) NULL COMMENT "",
  `f_28` json NULL COMMENT "",
  `_ape_dts_is_deleted` boolean NULL COMMENT "",
  `_ape_dts_timestamp` bigint(20) NULL COMMENT ""
) ENGINE=OLAP 
PRIMARY KEY(`f_0`)
DISTRIBUTED BY HASH(`f_0`)
PROPERTIES (
"replication_num" = "1",
"in_memory" = "false",
"enable_persistent_index" = "true",
"replicated_storage" = "true",
"compression" = "LZ4"
);

test_db_1.check_pk_cols_order
CREATE TABLE `check_pk_cols_order` (
  `pk_1` int(11) NOT NULL COMMENT "",
  `pk_2` int(11) NOT NULL COMMENT "",
  `pk_3` int(11) NOT NULL COMMENT "",
  `col_1` int(11) NULL COMMENT "",
  `col_2` int(11) NULL COMMENT "",
  `col_3` int(11) NULL COMMENT "",
  `col_4` int(11) NULL COMMENT "",
  `col_5` int(11) NULL COMMENT "",
  `_ape_dts_is_deleted` boolean NULL COMMENT "",
  `_ape_dts_timestamp` bigint(20) NULL COMMENT ""
) ENGINE=OLAP 
PRIMARY KEY(`pk_1`, `pk_2`, `pk_3`)
DISTRIBUTED BY HASH(`pk_1`)
PROPERTIES (
"replication_num" = "1",
"in_memory" = "false",
"enable_persistent_index" = "true",
"replicated_storage" = "true",
"compression" = "LZ4"
);

dst_test_db_2.router_test_1
CREATE TABLE `router_test_1` (
  `pk` int(11) NOT NULL COMMENT "",
  `col_1` int(11) NULL COMMENT "",
  `_ape_dts_is_deleted` boolean NULL COMMENT "",
  `_ape_dts_timestamp` bigint(20) NULL COMMENT ""
) ENGINE=OLAP 
PRIMARY KEY(`pk`)
DISTRIBUTED BY HASH(`pk`)
PROPERTIES (
"replication_num" = "1",
"in_memory" = "false",
"enable_persistent_index" = "true",
"replicated_storage" = "true",
"compression" = "LZ4"
);

dst_test_db_2.dst_router_test_2
CREATE TABLE `dst_router_test_2` (
  `pk` int(11) NOT NULL COMMENT "",
  `col_1` int(11) NULL COMMENT "",
  `_ape_dts_is_deleted` boolean NULL COMMENT "",
  `_ape_dts_timestamp` bigint(20) NULL COMMENT ""
) ENGINE=OLAP 
PRIMARY KEY(`pk`)
DISTRIBUTED BY HASH(`pk`)
PROPERTIES (
"replication_num" = "1",
"in_memory" = "false",
"enable_persistent_index" = "true",
"replicated_storage" = "true",
"compression" = "LZ4"
);