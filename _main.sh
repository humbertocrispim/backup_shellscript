#!/bin/bash

#===========================================================
#   File            _main.sh
#   Descripition    Script take a DB backup
#   Author          Humberto Crispim
#   Email           humberto.cunha.crispim@gmail.com
#   Git             https://github.com/humbertocrispim
#
#============================================================


# Date Format
DT=$(date "+%d-%m-%Y")

# Take a DB backup

docker-compose exec -T postgres sh -c 'pg_dump -cU $POSTGRES_USER $POSTGRES_DB' | gzip > db_dump-$DT.sql.gz


# delete every file that's between 5 and 40 days old
for i in {5..40}; do 
    olddate=$(date --date="$i days ago" +%d-%m-%Y)
    echo "Deleting files from $olddate..."
    rm "db_dump-$olddate.sql.gz"
    
done
