#!/bin/bash
#

DATABASES=`ls | grep *_db`
USER='wordpress'
PASS='wordpress'
DIR="/tmp/backup"

for db in $DATABASES;
  do
  for table in `ls -1 $DIR/$db`;
    do
    echo "--> $s restoring... ";
    mysqldump --user=$USER --password=$PASS -h 10.110.1.130 $db < $DIR/$db/$table;
    done
done
