#!/bin/bash

# Date Format
CDATE=$(date "+%d-%m-%Y")

# Take a DB backup

docker-compose exec -T postgres sh -c 'pg_dump -cU $POSTGRES_USER $POSTGRES_DB' | gzip > db_dump-$CDATE.sql.gz


# delete every file that's between 5 and 40 days old
for i in {1..40}; do 
    olddate=$(date --date="$i days ago" +%d-%m-%Y)
    echo "Deleting files from $olddate..."
    rm "db_dump-$olddate.sql.gz" > log.txt
done
