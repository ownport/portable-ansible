PORTABLE_ANSIBLE_VERSION = "0.3.1"

build:
	@ rm -rf target/ && \
		mkdir -p target && \
		cp ../../../ssh-keys/ansible.id_rsa target/ && \
		cp ../../../../../builds/portable-ansible-v${PORTABLE_ANSIBLE_VERSION}-*.tar.bz2 target/
	@ docker build -t ownport/ansible-runner:centos7-py2 .

console:
	@ docker run -ti --rm --name ansible-runner-console \
		-v $(shell pwd)/../../playbooks:/root/playbooks \
		ownport/ansible-runner:centos7-py2
		bash
