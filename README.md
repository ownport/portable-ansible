# Self-contained Ansible distribution

Ansible package with required python modules. No need to install, just download, unpack and use. The main idea of this package is to run Ansible playbooks on local machine



## Included in the distribution

Version: 0.2.2

| Package  | Version |
| -------- | ------- |
| ansible  | 2.7.8   |
| jinja2   | 2.10    |
| PyYAML   | 3.12    |
| paramiko | 2.4.1   |
| six      | 1.11.0  |
| cryptography | 2.4.2 |

## How to install and use

You just need to download latest version of portable-ansible tarball (.tar.bz2) from
Releases page https://github.com/ownport/portable-ansible/releases and unpack the files

```sh
$ wget https://github.com/ownport/portable-ansible/releases/download/v0.2.1/portable-ansible-v0.2.1-py2.tar.bz2 -O ansible.tar.bz2
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

## Supporting additional python packages

Install python packages into `ansible/extras` directory
```
pip install -t ansible/extras <package>
```
or 
```
pip install -t ansible/extras -r requirements.txt
```

Instead of installing the python packages to `ansible/extras`, you can also install them in user directory to be available for ansible:
```
pip install --user -r requirements.txt
```


## For developers

to create tarball with required packages just run

For python2
```
$ make tarball-py2
```
For python3
```
$ make tarball-py3
```
For both python versions
```
$ make tarballs
```

## Changelog

All notable changes to this project will be documented in the file CHANGELOG.md


## Links

- [ansible/ansible](https://github.com/ansible/ansible) Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy. Avoid writing scripts or custom code to deploy and update your applications— automate in a language that approaches plain English, using SSH, with no agents to install on remote systems. http://ansible.com/
- [ansible/ansible-modules-core](https://github.com/ansible/ansible-modules-core) Ansible modules - these modules ship with ansible
- [ansible/ansible-modules-extras](https://github.com/ansible/ansible-modules-extras) Ansible extra modules - these modules ship with ansible
