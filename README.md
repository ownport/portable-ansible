# Self-contained Ansible distribution

## Requirements

- ansible-2.4.0.0
- jinja2-2.9.4
- PyYAML-3.12
- setuptools
- pycrypto >= 2.6 (optional)
- paramiko-2.1.1 (optional)

## How to install and use

You just need to download latest version of portable-ansible tarball (.tar.bz2) from
Releases page https://github.com/ownport/portable-ansible/releases and unpack the files

```sh
$ wget https://github.com/ownport/portable-ansible/releases/download/ansible-2.3.0.0/ansible.tar.bz2
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

```sh
$ make prepare
[INFO] Cleaning directory: /media/dev/github/portable-ansible/bin
[INFO] Cleaning directory: /media/dev/github/portable-ansible/lib
[INFO] Cleaning directory: /media/dev/github/portable-ansible/ansible
--2017-05-01 08:37:35--  https://github.com/ownport/pkgstack/releases/download/v0.1.9/pkgstack
...
['install', '--target', 'ansible/', '--no-deps', 'ansible==2.3.0.0']
Collecting ansible==2.3.0.0
Installing collected packages: ansible
Successfully installed ansible-2.3.0.0
Package: {'target': 'ansible/', 'install': 'PyYAML==3.12', 'no-deps': True}
['install', '--target', 'ansible/', '--no-deps', 'PyYAML==3.12']
Collecting PyYAML==3.12
Installing collected packages: PyYAML
Successfully installed PyYAML-3.12
Package: {'target': 'ansible/', 'install': 'paramiko==2.1.1', 'no-deps': True}
['install', '--target', 'ansible/', '--no-deps', 'paramiko==2.1.1']
Collecting paramiko==2.1.1
  Using cached paramiko-2.1.1-py2.py3-none-any.whl
Installing collected packages: paramiko
Successfully installed paramiko-2.1.1
Package: {'target': 'ansible/', 'install': 'jinja2==2.9.4'}
['install', '--target', 'ansible/', 'jinja2==2.9.4']
Collecting jinja2==2.9.4
  Using cached Jinja2-2.9.4-py2.py3-none-any.whl
Collecting MarkupSafe>=0.23 (from jinja2==2.9.4)
Installing collected packages: MarkupSafe, jinja2
Successfully installed MarkupSafe-1.0 jinja2-2.9.4
Package: {'target': 'ansible/', 'install': 'six==1.10.0', 'no-deps': True}
['install', '--target', 'ansible/', '--no-deps', 'six==1.10.0']
Collecting six==1.10.0
  Using cached six-1.10.0-py2.py3-none-any.whl
Installing collected packages: six
Successfully installed six-1.10.0
$
```

## Links

- [ansible/ansible](https://github.com/ansible/ansible) Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy. Avoid writing scripts or custom code to deploy and update your applications— automate in a language that approaches plain English, using SSH, with no agents to install on remote systems. http://ansible.com/
- [ansible/ansible-modules-core](https://github.com/ansible/ansible-modules-core) Ansible modules - these modules ship with ansible
- [ansible/ansible-modules-extras](https://github.com/ansible/ansible-modules-extras) Ansible extra modules - these modules ship with ansible
