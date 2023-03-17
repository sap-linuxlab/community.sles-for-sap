# cluster

This role create an SAP cluster. This role currently supports:

* SAP HANA Scale up HA cluster

The following platforms are supported:

* Azure

The following STONITH methods are supported

* SBD

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

platform - string - the name of the platform, supported platforms are:

* Azure

stonith - string - the name of the stonith method to use. Support methods are:

* sbd

sbd_devices - list of string - required when stonith is set to `sbd` is true
primary - string - the hostname of the host considered
to be the primary host, for HANA, this should be the host that is currently the
HANA System Replication master.
