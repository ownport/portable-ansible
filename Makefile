
VERSION ?= 'v0.3.1'
TARBALL_NAME ?= portable-ansible-$(VERSION)


.PHONY: clean
clean:
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/target
	@ rm -rf \
		$(shell pwd)/target 


.PHONY: post-clean
post-clean:
	echo '[INFO] Removing extra dirs and files' && \
		rm -rf \
			$(shell pwd)/target/ansible/*.dist-info \
			$(shell pwd)/target/ansible/*.egg-info \
			$(shell pwd)/target/ansible/*.gz \
			$(shell pwd)/target/ansible/*.whl \
			$(shell pwd)/target/ansible/bin && \
	echo '[INFO] Removing __pycache__ dirs' && \
		find $(shell pwd)/target/ansible/ -path '*/__pycache__/*' -delete
		find $(shell pwd)/target/ansible/ -type d -name '__pycache__' -empty -delete


.PHONY: deps
deps: 
	@ mkdir -p $(shell pwd)/target/ansible/ && \
		cp $(shell pwd)/templates/__main__.py $(shell pwd)/target/ansible/
	@ mkdir -p $(shell pwd)/target/ansible/extras/
	# @ cp $(shell pwd)/templates/ansible-compat-six-init.py $(shell pwd)/ansible/ansible/compat/six/__init__.py


.PHONY: prepare-py2
prepare-py2: clean deps
	@ echo '[INFO] Installing Ansible packages' && \
		pip install --no-deps \
			--no-compile \
			-r conf/requirements \
			--target $(shell pwd)/target/ansible/


.PHONY: prepare-py3
prepare-py3: clean deps
# prepare: clean pkgstack deps
	@ echo '[INFO] Installing Ansible packages' && \
		pip3 install --no-deps \
			--no-compile \
			--requirement conf/requirements \
			--target $(shell pwd)/target/ansible/


.PHONY: prepare-in-docker-py2
prepare-in-docker-py2:
	@ echo '[INFO] Run docker container for building Ansible packages' && \
		docker run -ti --rm --name ansible-build \
			-v $(shell pwd):/data \
			bitnami/minideb:latest /bin/sh -c "apt update && \
					apt install -y --no-install-recommends \
						python \
						python-pip \
						make && \
					pip install --upgrade \
						pip \
						setuptools && \
					cd /data && make prepare-py2 && make post-clean"

.PHONY: prepare-in-docker-py3
prepare-in-docker-py3:
	@ echo '[INFO] Run docker container for building Ansible packages' && \
		docker run -ti --rm --name ansible-build \
			-v $(shell pwd):/data \
			bitnami/minideb:latest /bin/sh -c "apt update && \
					apt install -y --no-install-recommends \
						python3 \
						python3-pip \
						make && \
					pip3 install --upgrade \
						pip \
						setuptools && \
					cd /data && make prepare-py3 && make post-clean"

.PHONY: tarball-py2 
tarball-py2: prepare-in-docker-py2
	@ echo '[INFO] Building tarball' && \
		mkdir -p $(shell pwd)/builds && \
		tar cjf builds/$(TARBALL_NAME)-py2.tar.bz2 -C $(shell pwd)/target/ ansible


.PHONY: tarball-py3
tarball-py3: prepare-in-docker-py3
	@ echo '[INFO] Building tarball' && \
		mkdir -p $(shell pwd)/builds && \
		tar cjf builds/$(TARBALL_NAME)-py3.tar.bz2 -C $(shell pwd)/target/ ansible

.PHONY: tarballs
tarballs: tarball-py2 tarball-py3
	@ echo '[INFO] Completed' 
