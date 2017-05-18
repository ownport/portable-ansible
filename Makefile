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


compile-bin: clean pkgstack deps
	@ echo "[INFO] Compiling to binary, $(PROJECT_NAME_BIN)"
	@ mkdir -p $(shell pwd)/bin
	@ touch $(shell pwd)/ansible/__init__.py
	@ cd $(shell pwd)/ansible/; zip --quiet -r $(shell pwd)/bin/$(PROJECT_NAME_BIN) *
	@ echo '#!$(PYTHON)' > bin/$(PROJECT_NAME_BIN) && \
		cat bin/$(PROJECT_NAME_BIN).zip >> bin/$(PROJECT_NAME_BIN) && \
		rm bin/$(PROJECT_NAME_BIN).zip && \
		chmod a+x bin/$(PROJECT_NAME_BIN)

compile-bin-from-ansible-dir:
	@ echo "[INFO] Compiling to binary from temporary directory, $(PROJECT_NAME_BIN)"
	@ mkdir -p $(shell pwd)/bin
	@ touch $(shell pwd)/ansible/__init__.py
	@ cd $(shell pwd)/ansible/; zip --quiet -r $(shell pwd)/bin/$(PROJECT_NAME_BIN) *
	@ echo '#!$(PYTHON)' > bin/$(PROJECT_NAME_BIN) && \
		cat bin/$(PROJECT_NAME_BIN).zip >> bin/$(PROJECT_NAME_BIN) && \
		rm bin/$(PROJECT_NAME_BIN).zip && \
		chmod a+x bin/$(PROJECT_NAME_BIN)


run-local-ci:
	@ local-ci -r $(shell pwd) -s $(shell pwd)/.local-ci.yml

tarball: prepare
	tar cvjf $(TARBALL_NAME).tar.bz2 ansible
