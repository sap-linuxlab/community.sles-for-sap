# cluster

This role create an SAP cluster. This role currently supports:

* SAP HANA Scale up HA cluster

The following platforms are supported:

* Azure

The following STONITH methods are supported

* SBD
* Azure Native Fencing Agent

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

## Variables

WIP list of variables - some will be required some will not, this will get
messy!

### Required variables

* platform - string - the name of the platform, supported platforms are:
  * Azure
* stonith - string - the name of the stonith method to use. Support methods are:
  * sbd
  * native (will automagically choose the correct native stonith based on the
    platform)
* primary - string - the hostname of the host considered
to be the primary host, for HANA, this should be the host that is currently the
HANA System Replication master.

### Optional variable

* sbd_devices - list of string - required when stonith is set to `sbd` is true
* primary_computer_name - some stonith primitives may use an identifier that
  doesn't match the hostname when working cluster members. For example, a VM
  in Azure may be named `hana01-vm` but the hostname may be `hana01`. The
  fence agent needs to know the Azure name when performing fencing actions.
  Enter the name that the stonith primitive will use for the primary node, if it
  is different to the hostname.
* secondary_computer_name: As above but for the secondary node.

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

Only native fencing is officially supported in GCP. This role uses the STONITH
fencing agent  `fence_gce`.