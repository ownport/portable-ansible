# ansible-without-install

Ansible without requirements to be installed. The main purpose to be used in [Ansible Pull Mode](https://docs.ansible.com/playbooks_intro.html#ansible-pull).

Few advantages of pull mode:

- No central management server is required (depends on the type of repository)
- De-central repositories are possible. (Again: depends on type of repository.)
- Connections can be initiated by nodes (can be important if you're not allowed to alter firewall policies)
- Increased parallelism
- Nodes can pull when they are available. (In a push-based model, if a node is unavailable it cannot be configured.)
- Very fast, because the SSH-connection overhead incurred for each task is avoided.


Versions:

- Ansible, 1.9.2-1
- Ansible-Modules-Core Snapshot
- Ansible-Modules-Extras Snapshot
- Jinja2, 2.7.3
- MarkupSafe 0.23
- PyYAML 3.11

## Features:

- ansible core functionality
- callbacks support
- extra inventory support ()
- Ansible modules (Core)
- Ansible modules (Extra)
- Jinja2 support
- MarkupSafe support 
- PyYAML support

## Update current snapshot of Ansible-Without-Install

```sh
$ ansible-playbook update/update.yml
```

## Links

- [Ansible: pull instead of push](http://jpmens.net/2012/07/14/ansible-pull-instead-of-push/)