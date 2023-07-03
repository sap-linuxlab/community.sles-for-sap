# cluster

This role creates clusters for SAP products. This role currently supports:

* SAP HANA Scale up HA cluster

The following platforms are supported:

* Azure
* GCP
* AWS
* Generic

The following STONITH methods are supported

* SBD (Azure and Generic only)
* Native (Azure, GCP, AWS)

## Idempotency

In this initial version, idempotency is limited. On successfully completing a
cluster configuration, a file will be written to the host machines stating that
clustering has been successfully completed. The presences of this file will
force future attempts to be skipped. While this is not ideal, it does provide
a basic and safe level of idempotency but it doesn't provide protection from
configuration drift.

A future release will support a fully idempotent approach which will compare the
current cluster state with the desired state and only make changes when changes
are required.

## Package Requirements

This role requires the following packages to be installed:

* corosync
* crmsh
* fence-agents
* ha-cluster-bootstrap
* pacemaker
* patterns-ha-ha_sles
* resource-agents
* cluster-glue
* socat
* libxml2-tools
* ClusterTools2
* SAPHanaSR
* rsyslog

For SLES 15.3 and earlier, some specific package versions are required:

* SAPHanaSR >= 0.162.1
* socat >= "1.7.3.2
* ClusterTools2 >= 3.1.2
* libxml2-tools >= 2.9.7

For SLES 15.4 and later, the following specific package versions are required:

* SAPHanaSR >= 0.162.1
* socat >= 1.7.3.2
* ClusterTools2 >= 3.1.2
* libxml2-tools >= 2.9.14

GCP has the following additional package requirements:

* python3-httplib2
* python3-google-auth-httplib2
* python3-google-api-python-client

Azure has the following additional package requirements:

* python3-azure-mgmt-compute
* python3-azure-identity

## Expectations

The following expectation must be met for this role to work correctly. Where
possible, expectations are tested during the pre-checks phase, however, it is
not always practical or possible to check expectations.

### General expectations

Currently, the role can only run with two hosts. Ensure the role is called with
a playbook that only sources two hosts only.

To create multiple clusters, the role must be run once for each cluster.

### Azure Expectations

To deploy the role for Azure, you should ensure that you have followed the
[Azure documentation](https://learn.microsoft.com/en-us/azure/sap/workloads/get-started).

This role expects the following:

* If using Azure native fencing, ensure that you are using a service principle.
  Managed Identity may be supported in the future.
* Ensure that health probes are set to the correct port of 625\<SAP Instance Number\>.
  For example, if using the an instance number of 40, the health probe should be
  set to 625**40**
* Ensure the all required ports registered in the load balancer.

### GCP Expectations

To deploy this role for GCP, ensure that you have followed the
[GCP Documentation](https://cloud.google.com/solutions/sap/docs/sap-hana-ha-config-sles)

This roles expects the following:

* The VIP should be in the same subnet as the HANA nodes.
* The VMs should be given adequate IAM privileges to be able to fence each other.

### AWS Expectations

To deploy this role for AWS, ensure that you have followed the
[AWS Documentation](https://docs.aws.amazon.com/sap/latest/sap-hana/sap-hana-on-aws-manual-deployment-of-sap-hana-on-aws-with-high-availability-clusters.html)

The roles expects the following:

* Instance tags are set correctly to enable fencing
* The VIP will be outside of the HANA subnets and is present in the routing table.

### Generic Expectations

The role supports `generic` clustering which is not platform specific. The only
supported STONITH is `sbd`.

## Variables

The sections provides information regarding required, optional and platform
specific variables.

### Required variables

* platform - string - the name of the platform, supported platforms are:
  azure, gcp, aws & generic
* stonith - string - the name of the stonith type to use. Support methods are:
  sbd & native (will automagically choose the correct native stonith based on
  the platform)
* primary - string - the hostname of the host considered
  to be the primary host, for HANA, this should be the host that is currently
  the HANA System Replication master.
* virtual_ip - string - the Virtual IP address that the cluster will use.
* hacluster_password - string - the password to be set for the Linux OS user
  `hacluster`, the same password will be used on all nodes.

### Optional variable

* use_softdog - bool - when using sbd, a watchdog is necessary. The role can
  configure the software watchdog `softdog`, but if a hardware or virtual
  watchdog is available that should be used instead. The role is not capable of
  configure every possible watchdog, so when setting `use_softdog` to `false`,
  it is the user's responsibility to ensure that the watchdog is configured.
  By default, `use_softdog` is set to `true`.
* sbd_devices - list of string - required when stonith is set to `sbd` is true
* primary_computer_name - string - some stonith primitives may use an identifier
  that doesn't match the hostname when working cluster members. For example, a
  VM in Azure may be named `hana01-vm` but the hostname may be `hana01`. The
  fence agent needs to know the Azure name when performing fencing actions.
  Enter the name that the stonith primitive will use for the primary node, if it
  is different to the hostname.
* secondary_computer_name - string - As above but for the secondary node.
* dual_corosync_rings - bool - by default the a single corosync ring will be
  created using eth0 interfaces. If this value is set to `true` the corosync
  configuration will be made up of two rings, the first using eth0 and the
  second using eth1. By default, `dual_corosync_rings` is set to `false`.
* auto_register - bool - the HANA resource agent can automate the
  registration of the former master node when it rejoins the cluster after a
  failover. By default `auto_register` is set to `false` and registration must
  be done manually. However, setting `auto_register` to `true` will enable
  automatic registration.

### Required Variables for Azure Fence Agent

To create the Azure Fence Agent, follow the instructions [here](https://learn.microsoft.com/en-us/azure/sap/workloads/high-availability-guide-suse-pacemaker#use-an-azure-fence-agent-1).
Currently, this role supports the Azure Fence Agent when using a service
principle, although managed identity may be supported in the future. When using
the Azure Fence Agent the following variables are required. The

* afa_subscription_id - string - the subscription ID that the VMs and fence
  agent app reside in.
* afa_resource_group - string - the resource group that the VMs reside in.
* afa_tenant_id - string - the id of the tenant that the VMs and fence agent
  app reside in.
* afa_app_id - string - the Azure Fence Agent app id.
* afa_app_secret - string - the Azure Fence Agent app password

### Required Variables for GCP

There are no specific variable requirements for GCP.

### Required Variables for AWS

* aws_stonith_tag - string - When creating the AWS, some special tagging is
  required. The tag name created for the cluster must be passed to ansible
  here. See this
  [link](https://docs.aws.amazon.com/sap/latest/sap-hana/sap-hana-on-aws-tagging-the-ec2-instances-required-only-for-sles.html)
  for more information on the required tagging.
* aws_route_table_id - string - The route table id of the route table that
  contains the virtual IP address. Required so the cluster can update the route
  table when a failover occurs.
* aws_access_key_id - string - access key id of the account to be used to
  perform stonith actions
* aws_secret_access_key - string - secret access key of the account to be used
  to perform stonith actions

### Required Variables for generic

There are no specific requirements for the generic platform.
