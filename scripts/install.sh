#!/bin/sh
#
#   install Ansible env first time
#

source conf/versions

set -o nounset -o pipefail

prepare_env() {

    echo "[INFO] Prepare environment for dependencies download"
    [ -d tmp/ ] && { rm -rf tmp/; }
    [ -d bin/ ] && { rm -rf bin/; }

    mkdir -p tmp/ansible/
    mkdir -p tmp/ansible/packages
}

download_ansible() {

    echo "[INFO] Download Ansible distribution, version ${ANSIBLE_VERSION}"
    wget -c -q https://github.com/ansible/ansible/archive/v${ANSIBLE_VERSION}.tar.gz -O tmp/ansible.tar.gz && \
    tar xzf tmp/ansible.tar.gz --directory=tmp/ && \
    cp -r tmp/ansible-${ANSIBLE_VERSION}/lib/ansible/ tmp/ansible/packages
    cp -r tmp/ansible-${ANSIBLE_VERSION}/bin/ansible tmp/ansible/__main__.py && \
    touch tmp/ansible/__init__.py && \
    rm -rf tmp/ansible.tar.gz tmp/ansible-${ANSIBLE_VERSION}/
    # chmod -x tmp/ansible/__main__.py && \
}

download_ansible_core_modules() {

    echo "[INFO] Download Ansible Core modules, latest version"
    wget -c -q https://github.com/ansible/ansible-modules-core/archive/devel.tar.gz -O tmp/ansible-modules-core.tar.gz && \
    tar xzf tmp/ansible-modules-core.tar.gz --directory=tmp/ && \
    mv tmp/ansible-modules-core-devel/* tmp/ansible/packages/ansible/modules/core/ && \
    rm -rf tmp/ansible-modules-core.tar.gz tmp/ansible-modules-core-devel/
}


download_ansible_extra_modules() {

    echo "[INFO] Download Ansible Extra modules, latest version"
    wget -c -q https://github.com/ansible/ansible-modules-extras/archive/devel.tar.gz -O tmp/ansible-modules-extras.tar.gz && \
    tar xzf tmp/ansible-modules-extras.tar.gz --directory=tmp/ && \
    mv tmp/ansible-modules-extras-devel/* tmp/ansible/packages/ansible/modules/extras/ && \
    rm -rf tmp/ansible-modules-extras.tar.gz tmp/ansible-modules-extras-devel/
}

download_jinja() {

    echo "[INFO] Download Jinja2, version ${JINJA2_VERSION}"
    wget -c -q https://github.com/pallets/jinja/archive/${JINJA2_VERSION}.tar.gz -O tmp/jinja2.tar.gz && \
    tar xzf tmp/jinja2.tar.gz --directory=tmp/ && \
    mv tmp/jinja-${JINJA2_VERSION}/jinja2 tmp/ansible/packages/ && \
    rm -rf tmp/jinja*
}


download_pyyaml() {

    echo "[INFO] Download PyYAML, version ${PYYAML_VERSION}"
    wget -c -q https://pypi.python.org/packages/source/P/PyYAML/PyYAML-${PYYAML_VERSION}.tar.gz -O tmp/pyyaml.tar.gz && \
    tar xzf tmp/pyyaml.tar.gz --directory=tmp/ && \
    mv tmp/PyYAML-${PYYAML_VERSION}/lib/yaml/ tmp/ansible/packages/ && \
    rm -rf tmp/pyyaml* tmp/PyYAML*
}

download_markupsafe() {

    echo "[INFO] Download MarkupSafe, version ${MARKSAFE_VERSION}"
    wget -c -q https://github.com/pallets/markupsafe/archive/${MARKSAFE_VERSION}.tar.gz -O tmp/markupsafe.tar.gz && \
    tar xzf tmp/markupsafe.tar.gz --directory=tmp/ && \
    mv tmp/markupsafe-${MARKSAFE_VERSION}/markupsafe/ tmp/ansible/packages/ && \
    rm -rf tmp/markupsafe*
}


prepare_env && \
download_ansible && \
    download_ansible_core_modules && \
    download_ansible_extra_modules && \
    download_jinja && \
    download_pyyaml && \
    download_markupsafe && \
echo "[INFO] Dependencies were downloaded"
