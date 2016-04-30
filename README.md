# Self-contained Ansible distribution

## Requirements

- paramiko
- jinja2
- PyYAML
- setuptools
- pycrypto >= 2.6

## Installation

```sh
$ ./install.sh
[INFO] Prepare environment for installation
[INFO] Prepare Ansible distribution, version 1.9.6-1
[INFO] Prepare Ansible Core modules, latest version
[INFO] Prepare Ansible Extra modules, latest version
[INFO] Prepare Jinja2, version 2.8
[INFO] Prepare PyYAML, version 3.11
[INFO] Prepare MarkupSafe, version 0.23
[INFO] Install Ansible
[INFO] Remove temporary directories
[INFO] Installation is completed
$
```

## How to run

```sh
$ PYTHONPATH=lib/ bin/ansible localhost -m ping
localhost | success >> {
    "changed": false,
    "ping": "pong"
}
$  
```

## Links

- [ansible/ansible](https://github.com/ansible/ansible) Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy. Avoid writing scripts or custom code to deploy and update your applications— automate in a language that approaches plain English, using SSH, with no agents to install on remote systems. http://ansible.com/
- [ansible/ansible-modules-core](https://github.com/ansible/ansible-modules-core) Ansible modules - these modules ship with ansible
- [ansible/ansible-modules-extras](https://github.com/ansible/ansible-modules-extras) Ansible extra modules - these modules ship with ansible
