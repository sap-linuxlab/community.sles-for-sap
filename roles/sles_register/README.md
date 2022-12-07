# sles_register

The `sles_register` role ensures that SLES hosts are registered with SUSE so
that they can receive updates.

The role currently supports applying a single SLES registration code to all the
hosts in the play.

To assure efficient registration for cloud hosted systems, the role will use
`registercloudguest`.  If register cloud guest is not present, the role will
fail.  When using the role with non-cloud hosts, set `use_suseconnect` to true.

## Variables

The following variable is mandatory:

* reg_code - the SLES registration code.

The following variable is optional.

* use_suseconnect - if `true`, the role will use `SUSEConnect` and will not
  search for `registercloudguest`.  Default is `false`.

## Check mode

This role supports check mode.  Check mode demonstrate the actions that will be
taken if the role were to be run.  As no ansible modules for SLES registration
exist, a lot of the role relies on using the `ansible.builtin.command` module,
which fully support check mode.  However, the task `Print required action` will
provide a good summary of the action the role would take if run normally.
