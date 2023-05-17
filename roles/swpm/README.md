# SWPM

The SWPM role offers two ways of provisioning software, Guided and passthrough.
Guided mode allows users to provide variables to ansible in order to install a
relatively small number of SAP products in a small number of pre-set scenarios.

## Variables

### Required variables

* install_mode - string - defines the install mode. Supported values, 'guided'.

### Guided variables

The following variables are required when `install_mode` is set to `guided`.

* guided_product - the product ID of the install. Currently supported product
  IDs are:
  * NW_ABAP_OneHost:S4HANA2022.CORE.HDB.ABAP
*