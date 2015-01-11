# Backup script

This script can be used to backup a MySQL database and the site folder. It deletes older archives as well. It's basic, very basic, but it's a start.

Just set up the config variables:

```bash
DBHOST=localhost
DBUSER=user
DBPASS=secreto
DBNAMES=database

BACKUP_FOLDER="/path/to/backups-folder"
BACKUP_SOURCE="/path/to/site-folder"
```

..amd run it

```bash
chmod +x backup-site.sh
./backup-site.sh
```

### TODO
* Email notification?