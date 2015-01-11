#!/bin/bash

DATE=`date +%Y%m%d`

DBHOST=localhost
DBUSER=user
DBPASS=secreto
DBNAMES=database

BACKUP_FOLDER="/path/to/backups-folder"
BACKUP_SOURCE="/path/to/site-folder"

echo "Running MySQL backup"

# Fetch all the databases if none is specified
if [[ $DBNAMES == '' ]]; then
  DBNAMES="$(mysql -u ${DBUSER} -h ${DBHOST} -p${DBPASS} -Bse 'show databases')"
fi

for db in $DBNAMES
do
  echo "Backing up ${db}"
  FILE=${BACKUP_FOLDER}/backup-${DATE}.${db}.sql.gz
  mysqldump --opt --skip-lock-tables -u ${DBUSER} -h ${DBHOST} -p${DBPASS} ${db} | gzip -9 > ${FILE}
done

echo "Running files backup"

tar -czf ${BACKUP_FOLDER}/backup-${DATE}-site.tar.gz ${BACKUP_SOURCE}

echo "deleting old files"

# Remove files older than 15 days
find ${BACKUP_FOLDER} -type f -name "backup-*" -mtime +15 -exec rm -f '{}' ';'