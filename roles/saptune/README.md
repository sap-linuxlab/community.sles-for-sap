# saptune

The `saptune` role ensures that SLES hosts have:

* saptune service enabled and started
* conflicting services stopped and disabled
* the requested saptune solution applied

**IMPORTANT**, this role does not install saptune.  Package management it
outside of the scope of this role.  If saptune is not installed, the role will
fail with a meaningful error.

**IMPORTANT**, this role only works with saptune 3.0 or newer.  If a version
older than 3.0 is discovered, the role with fail with a meaningful error.

**IMPORTANT**, this role deals with saptune `solutions` only.  It will apply and
revert solutions as necessary.  Any sapnotes applied or removed by saptune by a
user are out of the scope of this role.

## Variables

The following variable is mandatory:

* solution - the saptune solution the will be applied.  No default.

A list of possible solutions can be gathered by running `saptune solution list`.

### Optional variables

* platform - specifies the platform of the solution which may be required for
  some specific overrides. Supported values are 'azure' and 'default'. Default
  is default.
* clustered - boolean value that specifies if the systems are clustered or not.
  Some clustered systems required sepecific overrides. Default is 'false'.

## Pitfalls

Like the role, saptune will not add, update or remove packages to your
systems.  This will sometimes cause an error when a solution is applied but the
system fails to meet the minimum package requirements for the solution.  If this
happens, the task `Ensure that solution is verified`, will fail.  Ansible will
print the `stdout` from the "saptune solution verify \<solution\>" command.
However, this output is tabulated and will not be pleasantly displayed in by
Ansible.  Therefore, a better approach is to run the same command on the
host and record the output.

## Check mode

This role supports check mode.  Check mode demonstrate the actions that will be
taken if the role were to be run.  As no ansible modules for SLES registration
exist, a lot of the role relies on using the `ansible.builtin.command` module,
which fully support check mode.  However, the task `Print required action` will
provide a good summary of the action the role would take if run normally.
