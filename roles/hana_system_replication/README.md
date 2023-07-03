# hana-system-replication

The hana-system-replication role ensures that HANA system replication is
configured between two systems. A valid HANA system replication configuration is
required for HANA clustering and this role is therefore a prerequisite for
the clustering roles.

The role performs the following tasks:

* Ensure that the System PKI files are synced from primary host to secondary
  host
* HANA System Replication is configured as specified

## Variables

### Required Variables

* hana-sid - the three character 'System ID' of the HANA installation.
* instance number - the two digit instance ID of the HANA installation.
* hana_systemdb_password - the password of the HANA used that will update the
* hana_system_replication_nodes - a list of dictionaries that express the node
  configurations.

The elements of the `hana_system_replication_nodes` are as follows.

* hostname - the short hostname of the node
* ip_address - the ip_address to use for HANA system replication
* role - the role of the node within HANA system replication, allowed values
  are 'primary' & 'secondary'
* site - the alias used to represent your the site where the node resides.

Exactly **two** elements should be specified. See the example playbooks in the
[playbooks directory](../../playbooks).

### Optional Variables

* systemdb_user - The user to make changes to the HANA database. Default is
  'SYSTEM'
* hsr_replication_mode - Selects the log replication modes. Allowed values are:
  'sync', 'syncmem' & 'async'. Default is 'sync'
* hsr_operation_mode - Selects log operation mode. Allowed values are:
  'delta_datashipping', 'logreplay' & 'logreplay_readaccess'. Default is
  'logreplay'.

An example playbook is available in the [playbooks directory](../../playbooks)
of the repository.

## Prerequisites

The role requires:

* HANA to be installed on both hosts
* The same version of HANA to be installed on both hosts
* The SID and instance number must be identical on both nodes
* The primary nodes must be backed up
* The ability for the root user of both hosts to 'ssh' to the other host
  password-free

## Additional Information and Upcoming Features

This role currently configures HANA System Replication using the primary
network interface (eth0 or equivalent). A future release will allow the user to
specify the network interface to use and will allow the implementation of the
'internal' option for 'listeninterface'. The current implementation uses
the 'global' option for 'listeninterface' but will restrict the 'allowed_sender'
parameter for additional security.

If a HANA System Replication configuration is discovered that doesn't match the
desired configuration the role will fail with a meaningful message. A future
release will provide the a 'destructive' option which will destroy any
pre-existing configuration and then apply the new configuration.

Currently, the role configures HANA System Replication and quits. Another
possible new feature will be to choose to wait until the initial sync is
complete before the role quits.
