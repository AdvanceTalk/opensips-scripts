#!/bin/bash

export PGPASSWORD="admin1234"
primary_db_backup_dir=/var/backups/opensips/postgresql/primary
secondary_db_backup_dir=/var/backups/opensips/postgresql/secondary
cfg_backup_dir=/var/backups/opensips

mkdir -p $primary_db_backup_dir
#mkdir -p $secondary_db_backup_dir
mkdir -p $cfg_backup_dir

find $backup_dir/*.sql -mtime +3 -exec rm {} \;

cp /etc/opensips/opensips.cfg $cfg_backup_dir/$(date +%Y-%m-%d)_opensips.cfg
pg_dump -Fc --host=localhost --port=5432 --user=opensips --schema=public -f /$primary_db_backup_dir/opensips_$(date +%Y-%m-%d).sql --verbose
#pg_dump -Fc --host=localhost --port=5433 --user=opensips --dbname=opensips_cdr --schema=public -f /$secondary_db_backup_dir/opensips_$(date +%Y-%m-%d).sql --verbose

echo "Backup Completed"
