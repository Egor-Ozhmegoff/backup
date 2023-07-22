#!/bin/bash -e

DATABASES=`ls | grep *_db`
USER='wordpress'
PASS='wordpress'
DIR="/tmp/backup"

for db in $DATABASES;
do
for filename in $DIR/$db/*.txt;
do
tablename=`basename $filename .txt`
mysql --user=$USER --password=$PASS $db << EOF
  SET FOREIGN_KEY_CHECKS=0;
  LOAD DATA INFILE '$filename' INTO TABLE \`$tablename\`;
EOF
done
done
