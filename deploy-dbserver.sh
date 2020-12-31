#!/bin/bash
##### INSTALL MYSQL SERVER & GIT ######
sudo apt update -y
sudo apt install -y mysql-server git
##### note: give comment bind-address at file /etc/mysql/mysql.conf.d/mysqld.cnf #####
##### CREATE DATABASE & USER ######
sudo mysql << EOF
CREATE DATABASE IF NOT EXISTS dbsosmed;
CREATE USER IF NOT EXISTS 'faisal'@'localhost' IDENTIFIED BY '7654321';
GRANT ALL PRIVILEGES ON * . * TO 'faisal'@'localhost';
CREATE USER IF NOT EXISTS 'faisal'@'192.168.43.182 ' IDENTIFIED BY '7654321';
GRANT ALL PRIVILEGES ON * . * TO 'faisal'@'192.168.43.182 ';
FLUSH PRIVILEGES;
EOF
##### IMPORT DATABASE ######
git clone https://github.com/faisal1210/sosial-media.git
cd sosial-media/
sudo mysql dbsosmed < dbsosmed.sql
