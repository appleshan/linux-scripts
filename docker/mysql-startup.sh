#!/usr/bin/env bash

# startup mysql in docker

# Start a MySQL Server Instance
docker run --name appleshan.sqlims-test-mysql \
       -p 3306:3306 \
       -e MYSQL_ROOT_PASSWORD=123456 \
       -e EXTRA_OPTS="--lower_case_table_names=1" \
       -e ON_CREATE_DB="sqlims" \
       -v /data/docker/mysql:/var/lib/mysql \
       -d mysql

# Connect to MySQL from the MySQL Command Line Client
mysql -h127.0.0.1 -P3306 -uroot -p123456

# Create Database
--
--  Create Database 'sqlims'
--
CREATE DATABASE IF NOT EXISTS sqlims DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

# cd sql scripts dir
cd /data/download/test/data-import/mysql

# Import Table Structure
mysql -h127.0.0.1 -P3306 -uroot -p123456 sqlims < sqlims-tables.sql

# Import Table Data
mysql -h127.0.0.1 -P3306 -uroot -p123456 sqlims < sqlims-data.sql
