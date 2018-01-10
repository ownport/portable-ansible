# Self-contained Ansible 2.4.2 distribution

## Requirements

- ansible-2.4.2.0
- jinja2-2.9.4
- PyYAML-3.12
- paramiko-2.1.1
- six-1.10.0

## How to install and use

You just need to download latest version of portable-ansible tarball (.tar.bz2) from
Releases page https://github.com/ownport/portable-ansible/releases and unpack the files

```sh
$ wget https://github.com/ownport/portable-ansible/releases/download/ansible-2.4.2.0/ansible.tar.bz2 -O ansible.tar.bz2
$ tar -xjf ansible.tar.bz2
$ python ansible localhost -m ping
 [WARNING]: provided hosts list is empty, only localhost is available

localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

If you need to run ansible playbooks, after having extracted the tarball contents:

```sh
$ ln -s ansible ansible-playbook
$ python ansible-playbook playbook.yml
```

## For developers

to collect all packages in ansible/ directory
```sh
$ make prepare-in-docker
```
or to create tarball with required packages
```
$ make tarball
```

## Links

- [ansible/ansible](https://github.com/ansible/ansible) Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy. Avoid writing scripts or custom code to deploy and update your applications— automate in a language that approaches plain English, using SSH, with no agents to install on remote systems. http://ansible.com/
- [ansible/ansible-modules-core](https://github.com/ansible/ansible-modules-core) Ansible modules - these modules ship with ansible
- [ansible/ansible-modules-extras](https://github.com/ansible/ansible-modules-extras) Ansible extra modules - these modules ship with ansible
