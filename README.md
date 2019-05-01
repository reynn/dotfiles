# dotfiles

## Requirements

Ansible 2.7+

## Run

### Locally

```console
$ ansible-playbook config-playbook.yaml -i inventory.yaml -l localhost
```

### Remote Host

Update the `inventory.yaml` file with the desired host.

```console
$ ansible-playbook config-playbook.yaml -i inventory.yaml -l <remote_host>
```
