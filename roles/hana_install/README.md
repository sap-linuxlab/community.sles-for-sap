# hana_install

The `hana_install` role ensures that HANA is installed as specified.  The role
should only be used for initial installation of HANA.  The role cannot handle
upgrades or changes to existing HANA installations.

The role performs the following tasks:

* Unpacks the HANA installation SAR file
* Installs HANA

## Idempotency

If the role discovers a HANA installation that matches the required SID and
instance number, the role will assume that the required HANA installation is
complete and make no changes to the system.  No other variables will be taken
in to consideration.

## Variables

The following variables are used with the role

### Required variables

* sapcar_binary - the full path to the sapcar binary required to unpack the
  hana installation SAR file.
* hana_sar - the full path of the HANA sar file.
* hana_unpack_directory - the location where the content of the HANA
  sar file should be unpacked to.
* hana_sid - the three character 'System ID' of the HANA installation.
* hana_instance_number - the two digit instance ID of the HANA installation.
* hana_master_password - a password that will be set for all password options.
  It is recommended to change passwords after the installation.

**NOTE** The HANA master password needs to be at least 8 characters in length,
and include at least 1 uppercase, 1 lowercase and 1 numerical character.

### Optional variables

The following options are optional, if they are not specified, defaults will be
used.

* hana_install_dir - the location where HANA will be installed. Default:
  /hana/shared.
* hana_hostname - the hostname to use for the installation, useful when using
  service names rather than real hostnames. By default, the hosts 'real'
  hostname will be used.
* hana_usage - the usage classification of the HANA installation. =Valid values
  are: 'production', 'test', 'development' or 'custom'. Default: 'test'
* hana_volume_encryption - controls if hana data volume encryptions is enabled.
  Valid values are 'y' or 'n'. Default: 'n'.
* hana_data_path - the location where HANA will store its data volume. By
  default, the path will be '/hana/data/\<hana_sid\>'.
* hana_log_path - the location where HANA will store its log volume. By
  default, the path will be '/hana/log/\<hana_sid\>'.
* hana_restrict_max_mem - controls if HANA memory should be restricted.
  Required when more than more one HANA instance is installed on a hosts and
  sometimes useful on low-memory hosts. Valid values are 'y' and 'n'. Default:
  'n'.
* hana_max_memory - Used in when `hana_restrict_max_mem` is set to 'y', specifies
  in MiB, the maximum memory footprint of all HANA services. Default: '0' (no
  limit).
* hana_system_size_dependent_parameters - Controls if size dependant database
  parameters defaults should be written to the configuration. For more
  information, see SAP Note 3014176. Valid values 'y' or 'no'. Default: 'n'.
* hana_home - The location of the hana user's home directory.  The given value
  must be a string to the location that will be used.  The directory does not
  need to pre-exist. By default, the path will be '/usr/sap/\<hana_sid\>/home'.
* hana_user_id - The user ID of the HANA user. The value need to be a positive
  integer.  The UID must be free.  By default, the users ID will be
  '30\<hana_instance_number\>'.
* hana_group_id - The group ID of sapsys.  The value need to be a positive
  integer.  The UID must be free.  Default: '79'
* initial_backup - decided if an initial backup should be created for the
  systemdb and the default tenant. Default: 'true'
