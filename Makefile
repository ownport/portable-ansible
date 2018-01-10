PYTHON ?= /usr/bin/env python2
PROJECT_NAME_BIN ?= ansible
PROJECT_NAME_SRC ?= ansible

PKGSTACK_VERSION ?= 0.1.9

ANSIBLE_VERSION = $(shell awk '/ansible==.*$$/ {split($$3,a,"=="); print a[2]}' conf/ansible.yml)
TARBALL_NAME = portable-ansible-$(ANSIBLE_VERSION)

clean:
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/bin
	@ rm -rf $(shell pwd)/bin
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/lib
	@ rm -rf $(shell pwd)/lib
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/ansible
	@ rm -rf $(shell pwd)/ansible

deps: clean
	@ $(PYTHON) $(shell pwd)/bin/pkgstack -p $(shell pwd)/conf/ansible.yml
	@ cp $(shell pwd)/templates/__main__.py $(shell pwd)/ansible/
	# @ cp $(shell pwd)/templates/ansible-compat-six-init.py $(shell pwd)/ansible/ansible/compat/six/__init__.py


pkgstack:
	@ if [ ! -f $(shell pwd)/bin/pkgstack ]; \
	then \
		mkdir -p $(shell pwd)/bin/ && \
		wget https://github.com/ownport/pkgstack/releases/download/v$(PKGSTACK_VERSION)/pkgstack \
			-O $(shell pwd)/bin/pkgstack && \
		chmod +x $(shell pwd)/bin/pkgstack; \
	else \
		echo "[INFO] pkgstack found in $(shell pwd)/bin"; \
	fi

prepare: clean pkgstack deps

prepare-in-docker:
	docker run -ti --rm --name ansible-build \
		-v $(shell pwd):/data \
		alpine:3.7 /bin/sh -c "apk add --no-cache python py2-pip make && cd /data && make prepare"

tarball: prepare-in-docker
	tar cvjf $(TARBALL_NAME).tar.bz2 ansible
