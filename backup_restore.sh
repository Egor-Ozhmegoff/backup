#!/bin/bash -e

DATABASE='wordpress_db'
USER='wordpress'
PASS='wordpress'
DIR="/tmp/backup"

for filename in $DIR/$DATABASE/*.txt;
do
tablename=`basename $filename .txt`
export MYSQL_PWD=$PASS; mysql -u $USER -h 10.110.1.130 --local-infile=1 $DATABASE < $DIR/$DATABASE/$tablename.sql;
export MYSQL_PWD=$PASS; mysql -u $USER -h 10.110.1.130 --local-infile=1 $DATABASE << EOF
  SET FOREIGN_KEY_CHECKS=0;
  LOAD DATA LOCAL INFILE '$filename' INTO TABLE \`$tablename\`;
EOF
done
