/* 1_setup */
/* Setting up MySQL with Cloud9: 
# start MySQL: $mysql-ctl start
# stop MySQL: $mysql-ctl stop
# run the MySQL interactive shell: $mysql-ctl cli
# exit the shell: exit or quit or \q or ctrl-c*/

/* Database generation:
# In MySQL environment(after $mysql-ctl cli):
*/
DROP DATABASE my_db;
SHOW DATABASES;
CREATE DATABASE my_db; 
USE my_db;
SELECT DATABASE();

-- Running SQL Files: SOURCE MySQL_Ex/1_setup.sql;

