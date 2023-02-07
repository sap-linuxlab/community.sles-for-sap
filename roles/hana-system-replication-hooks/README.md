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

## Variables

### Required variables

* hana_sid - the three character 'System ID' of the HANA installation.
* hana_instance_number - the two digit instance ID of the HANA installation.
* primary - the host in the play that is the primary SAP HANA System Replication
  server.

An example playbook is available in the [playbooks directory](../../playbooks)
of the repository.

## Prerequisites

The role requires:

* HANA to be installed

This role is intended to be run after HANA System Replication is configured,
however the role can be run at anytime after the HANA installation. Hook should
be configured prior to any pacemaker clustering.
