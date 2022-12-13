# sap_storage

The `sap_storage` role ensures that storage is configured ready for SAP
applications.  The roles is intended to be used with traditionally attached
storage (storage that appears as a SCSI device in /dev) rather than network
storage or cloud native storage.

The role performs the following tasks:

* Creates a Logical Volume Group
* Creates a single Logical Volume that fills the Volume Group
* Creates a single partitions on the Logical Volume
* Creates a single file system on the partition
* Mounts the file system.

## Variables

The role expects a list of dictionaries name `sap_storage_config`.  Each
dictionary needs contains the following keys with appropriate values.

* label - a label to identify the dictionary, this is used to label the LVG and
  LV
* devices - a list of SCSI devices to be used in the LVG
* mount_point - the required mount point
* stripe_size - the stripe size for the LV
* file_system - the type of file system to create
* file_system_options - any additional arguments to pass while creating
  the file system
* mount_options - any additional mount options

**Note** When a LVG consists of a single device no striping will be
attempted, however, when an LVG consists of multiple devices, the LV will be
striped across all devices.

**Note** `stripe_size` is ignored when the LVG consists of a single device
and can be omitted.

**Note** `extra_file_system_arguments` is optional and can be omitted.

## Example configuration

```yaml
sap_storage_config:
  usr_sap:
    label: "usr_sap"
    devices: ["/dev/disk/azure/scsi1/lun0"]
    mount_point: "/usr/sap"
    file_system: "xfs"
# LVM striped partition
  hana:
    label: "hana"
    devices: ["/dev/disk/azure/scsi1/lun1","/dev/disk/azure/scsi1/lun2","/dev/disk/azure/scsi1/lun3"]
    mount_point: "hana"
    file_system: "xfs"
    stripe_size: "32"
    mount_options: "noatime,nodiratime,logbsize=256k"
```

## Check mode

Check mode is not currently supported for this role.
