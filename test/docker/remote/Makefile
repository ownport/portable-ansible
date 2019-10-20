SSH_PUB_KEY = "$(shell cat ../ssh-keys/ansible.id_rsa.pub)"

build:
	@ docker build -t ownport/ansible-remote:latest \
		--build-arg SSH_PUB_KEY=${SSH_PUB_KEY} \
		.

console:
	@ docker run -ti --rm --name ansible-remote-console ownport/ansible-remote:latest bash

server:
	@ docker run -ti --rm --name ansible-remote-server ownport/ansible-remote:latest
