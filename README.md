# SLES for SAP Ansible Roles

![markdown badge](https://github.com/mr-stringer/sles-for-sap-roles/actions/workflows/markdown-lint.yml/badge.svg)

This repository provides a collection of Ansible roles for SLES for SAP. The
roles are written to support the provision of SLES for SAP along with the
configuration of storage and the provisioning of SAP software such as S4 and
HANA.

## Role design

These roles all consist of three steps:

* Pre-checks
* Tasks
* Post-checks

### Pre-checks

Pre-checks are run to ensure that the tasks the role performs can be completed.
This includes checking that mandatory variables are defined and populated and
that required software packages are present. If any of the prerequisites are
not met, a meaningful error message will be printed instructing the user how
what is required.

### Tasks

The tasks section executes the tasks required to attain the required state that
the role provides.

### Post-checks

The post-checks section of the role verifies that the tasks section yielded the
expected results. Again, if any check fails, a meaningful error message will be
printed for the user.

## Package Management

Be aware that the roles **will not** install or remove any packages. If packages
required for the roles are missing, an error will be printed when running
pre-checks.

It is the opinion of the authors that package managed should be handled
externally from the roles.
