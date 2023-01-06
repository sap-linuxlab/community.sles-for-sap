# Conventions

This document aims to to describe the conventions used in this project. As with
all such documents, this is a 'work in progress'.

## Markdown

All markdown files should be free or linting errors.

## Ansible

All ansible code should be free of linting errors.

### Variables

All variables should be lowercase and start with a alphabetical character.
An underbar should be used to separate words in a variable name.

| Good practice | Bad practice |
|---------------|--------------|
| filename      | Filename     |
| download_location | downloadLocation |

### Internal variables

Internal variables are variables, that cannot be set by the user. An example of
an internal variable could be a variable that holds the registered data of a
task or a fact that is set at runtime.

All internal variables must start `int` and be followed with a description of
the type of internal variable they are, such as `fact` or `reg` for
registration. See the following examples.

```yaml
- name: Check sapcar binary data
  ansible.builtin.stat:
    path: "{{ sapcar_binary }}"
  register: int_reg_sapcar_check
  changed_when: false
  failed_when: false
```

```yaml
- name: Get configuration names
  ansible.builtin.set_fact:
    int_fact_conf_names: "{{
      sap_storage |
      community.general.json_query('*[].label') }}"
  changed_when: false
  failed_when: false
```
