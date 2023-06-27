# hana-system-replication-hooks

The hana-system-replication-hooks role ensures that the HANA system replication
are configured on all hosts in the play. All hosts in the play must share a
common SID and instance number. If multiple different SIDs and instance numbers
are required, multiple playbooks should be created, one for each SID/instance
number combination.

The role performs the following tasks:

* Ensures a the HanaSR package and hook file are installed
* Stops HANA
* Updates HANA `global.ini` file with the hook data
* Creates a sudoers to allow the HANA user access to the hook
* Starts HANA

Currently, the role supports the 'Scale-up Performance Optimized' scenario only.

The role will search for following hooks and install them if present:

* SAPHanaSR
* susTkOver
* susChkSrv

## Variables

Many of the variables used in the `hana-system-replication` can be reused here.
However, like all of the roles in the collection, this role can be used
independently of the other roles.

### Required variables

* hana-sid - the three character 'System ID' of the HANA installation.
* instance number - the two digit instance ID of the HANA installation.
* hana_systemdb_password - the password of the HANA used that will update the
* hana_system_replication_primary - the hostname of the primary node
* hana_system_replication_secondary - the hostname of the secondary node

### Optional variables

* always_check_traces - enables the checking of HANA trace files for the correct
  installation of the System Replication hooks regardless of the system state.
  The use of this feature is discouraged. Trace files checks are carried out
  automatically when hooks are freshly installed and do not usually need to be
  rechecked. If hooks are not yet installed, using this option will cause
  assertions to fail. Default is: false.

An example playbook is available in the [playbooks directory](../../playbooks)
of the repository.

## Prerequisites

The role requires:

* HANA to be installed

This role is intended to be run after HANA System Replication is configured,
however the role can be run at anytime after the HANA installation. Hook should
be configured prior to any pacemaker clustering.
