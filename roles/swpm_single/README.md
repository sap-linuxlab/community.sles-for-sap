# swpm_single

The SWPM role will eventually offer two ways of provisioning SAP software,
Guided and passthrough. Guided mode allows users to provide variables to ansible
in order to install a relatively small number of SAP products in a 'standalone'
scenario (no high availability).

The passthrough mode will allow users to provide their own configuration files
in the correct SWPM format and will allow for the installation of any SAP
software product that is supported by SWPM.

Currently, only the guided mode is supported and this currently only supports
S4 2022.

It is strongly recommended that users acquire SAP software using SAP's
Maintenance Planner tool. This tool will collate all of the required software
for a full S4 installation and add it to the user's software basket so that it
can be downloaded using SAP Download Manager. The process of using Maintenance
Planner and Download Manager is out of scope for this document.

## Variables

### Required variables

* install_mode - string - defines the install mode. Supported values, 'guided'.
* sapcar_exe - string - the location of the sapcar executable.
* sapinst_sar - string - the location of the SWPM sar archive.

### Guided variables

The following variables are required when `install_mode` is set to `guided`.

* guided_product - the product ID of the install. Currently supported product
  IDs are:
  * NW_ABAP_OneHost:S4HANA2022.CORE.HDB.ABAP

### NW_ABAP_OneHost:S4HANA2022.CORE.HDB.ABAP variables

When using the guided install of NW_ABAP_OneHost:S4HANA2022.CORE.HDB.ABAP, the
following variables must be set:

* guided_s4_sid - string - The SID of the S4 system to install
* guided_master_password - string - The master password to use for the s4
  install
* guided_ascs_instance_number - string - the ASCS instance number, must be a two
  digit number, for example '00'
* guided_ci_instance_number - string - the PAS instance number, must be a two
  digit number and must not be the same as the ASCS instance.
* guided_hana_hostname - string - the hostname of the HANA server which must
  already be installed.
* guided_hana_sid - string - The SID of the target HANA instance system.
* guided_hana_instance - string - The two digit instance number of the target
  HANA system.
* guided_hana_systemdb_system_password - string - The SystemDB password of the
  target HANA system.
* guided_hana_admin_user_password - string - The password of the HANA user
  on the HANA server/cluster (\<sid\>adm).
* guided_sapexe_sar_path - string - The full path of the sapcar exe.
* guided_igs_sar_path - string - The full path of the IGS archive.
* guided_igs_helper_sar_path - The full path of the IGS Helper archive.
* guided_sapexedb_sar_path - The full path of the SAPEXEDB archive.
* guided_media_path - The full path of the directory containing the S4 database
  archive.
