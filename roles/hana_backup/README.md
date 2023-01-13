# hana_backup

The hana_backup role performs a full data backup of all tenants found in a HANA
instance, including the systemdb. Running a backup is a prerequisite for
configuring HANA System Replication. As HANA clusters rely on HANA System
Replication, a backup must be conducted prior to clustering. In addition, HANA
log backups will not occur until a full backup has been taken. Failure to create
a backup will eventually lead to the log volume filling up and causing the
database to fail.

The role queries the database to retrieve a list of databases within the
instance. The role checks if the HANA database has been previously been backed
up. If a backup has previously occurred, and the backup files are still in their
written location, the role will not conduct another backup.

By default, a file-based full backup for each database will be created in its
default location. Each database will have the name 'ANSIBLE_INITIAL_BACKUP'.
The backup name can be set to a custom value. At this time, there is no plan to
add support for backing up to a custom path.

This role communicates with the HANA database by writing SQL commands to files.
These files are then read by the HANA client `hdbsql`. The output of queries are
also written to disk. A files are removed even if tasks in the role fail.

This role is intended to perform the initial backup of HANA only! Using this
role as a backup solution is not recommended as is unsupported.

## Variables

The following variables are mandatory:

* hana_sid - the three UPPER CASE character 'System ID' of the HANA
  installation.
* hana_instance_number - the two digit instance ID of the HANA installation.
* hana_systemdb_password - the password of the systemdb user. This will probably
  be what was set as the `hana_master_password` with the `hana_install` role.

The following variables are optional:

* backup_name - the label assigned to the backup, used mostly for reference.
  Default: ANSIBLE_INITIAL_BACKUP

## Check mode

The role supports ansible check mode. In check mode, no changes will be made to
the system and no backups will be made. The task `Print required action` will
print a plain English description of what the role will do in the role were
run without check mode enabled.
