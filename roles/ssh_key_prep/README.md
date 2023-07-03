# ssh-key-prep

This role creates and distributes the relevant files that allow password-free
login between the hosts in the play as root. Password-free login as root is a
prerequisite for the `cluster` and `hana_system_replication` role.

The role creates a ssh keypair on each host for the root user. The
public keys of all hosts in the play are shared with all of the other nodes in
the play. In addition, the relevant data is added to the known hosts file for
each host.

The role will create a unique RSA key with a bit length of 4096 on each host,
the private key pair will be named  `id_rsa` and the public key will be named
`id_rsa.pub` and both will be placed in the user's `~/.ssh` directory.

In future versions of the role, it may be possible to change the key type bit
length and name of the key as well as the user.

## Variables

### Required Variables

None

### Optional variables

None
