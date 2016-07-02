PYTHON ?= /usr/bin/env python
PROJECT_NAME_BIN ?= ansible
PROJECT_NAME_SRC ?= ansible

clean:
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/bin
	@ rm -rf $(shell pwd)/bin
	@ echo "[INFO] Cleaning directory:" $(shell pwd)/ansible
	@ rm -rf $(shell pwd)/ansible

deps:
	@ echo "[INFO] Install dependencies"


$(PROJECT_NAME_BIN): clean deps
	@ echo "[INFO] Compiling to binary, $(PROJECT_NAME_BIN)"
	@ mkdir -p $(shell pwd)/bin
	@ cd $(shell pwd)/$(PROJECT_NAME_SRC)/; zip --quiet -r ../bin/$(PROJECT_NAME_BIN) *
	@ echo '#!$(PYTHON)' > bin/$(PROJECT_NAME_BIN) && \
		cat bin/$(PROJECT_NAME_BIN).zip >> bin/$(PROJECT_NAME_BIN) && \
		rm bin/$(PROJECT_NAME_BIN).zip && \
		chmod a+x bin/$(PROJECT_NAME_BIN)
