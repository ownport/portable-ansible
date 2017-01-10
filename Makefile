PYTHON ?= /usr/bin/env python
PROJECT_NAME_BIN ?= ansible
PROJECT_NAME_SRC ?= ansible

PKGSTACK_VERSION ?= 0.1.9

clean:
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/bin
	@ rm -rf $(shell pwd)/bin
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/lib
	@ rm -rf $(shell pwd)/lib
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/tmp
	@ rm -rf $(shell pwd)/tmp

deps: clean
	@ $(shell pwd)/bin/pkgstack -p $(shell pwd)/conf/ansible.yml
	@ cp $(shell pwd)/templates/__main__.py $(shell pwd)/tmp/


pkgstack:
	@ if [ ! -f $(shell pwd)/bin/pkgstack ]; \
	then \
		mkdir -p $(shell pwd)/bin/ && \
		wget https://github.com/ownport/pkgstack/releases/download/v$(PKGSTACK_VERSION)/pkgstack \
			-O $(shell pwd)/bin/pkgstack && \
		chmod +x $(shell pwd)/bin/pkgstack; \
	else \
		echo "[INFO] pkgstack founded in $(shell pwd)/bin"; \
	fi


compile: clean pkgstack deps
	@ echo "[INFO] Compiling to binary, $(PROJECT_NAME_BIN)"
	@ mkdir -p $(shell pwd)/bin
	@ touch $(shell pwd)/tmp/__init__.py
	@ cd $(shell pwd)/tmp/; zip --quiet -r $(shell pwd)/bin/$(PROJECT_NAME_BIN) *
	@ echo '#!$(PYTHON)' > bin/$(PROJECT_NAME_BIN) && \
		cat bin/$(PROJECT_NAME_BIN).zip >> bin/$(PROJECT_NAME_BIN) && \
		rm bin/$(PROJECT_NAME_BIN).zip && \
		chmod a+x bin/$(PROJECT_NAME_BIN)


run-local-ci:
	@ local-ci -r $(shell pwd) -s $(shell pwd)/.local-ci.yml
