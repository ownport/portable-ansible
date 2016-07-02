#!/usr/bin/env bash
#
#   install Ansible env first time
#

# ANSIBLE_VERSION="1.9.6-1"
ANSIBLE_VERSION="2.0.2.0-1"
JINJA2_VERSION="2.8"
PYYAML_VERSION="3.11"
MARKSAFE_VERSION="0.23"

set -o nounset -o pipefail

echo "[INFO] Prepare environment for installation"
[ -d tmp/ ] && { rm -rf tmp/; }
[ -d bin/ ] && { rm -rf bin/; }
[ -d lib/ ] && { rm -rf lib/; }

mkdir -p tmp/
mkdir -p tmp/ansible/

echo "[INFO] Prepare Ansible distribution, version ${ANSIBLE_VERSION}"
wget -c -q https://github.com/ansible/ansible/archive/v${ANSIBLE_VERSION}.tar.gz -O tmp/ansible.tar.gz && \
    tar xzf tmp/ansible.tar.gz --directory=tmp/ && \
    cp -r tmp/ansible-${ANSIBLE_VERSION}/bin/ tmp/ansible/ && \
    cp -r tmp/ansible-${ANSIBLE_VERSION}/lib/ tmp/ansible/ && \
    rm -rf tmp/ansible.tar.gz tmp/ansible-${ANSIBLE_VERSION}/

echo "[INFO] Prepare Ansible Core modules, latest version"
wget -c -q https://github.com/ansible/ansible-modules-core/archive/devel.tar.gz -O tmp/ansible-modules-core.tar.gz && \
    tar xzf tmp/ansible-modules-core.tar.gz --directory=tmp/ && \
    mv tmp/ansible-modules-core-devel/* tmp/ansible/lib/ansible/modules/core/ && \
    rm -rf tmp/ansible-modules-core.tar.gz tmp/ansible-modules-core-devel/

echo "[INFO] Prepare Ansible Extra modules, latest version"
wget -c -q https://github.com/ansible/ansible-modules-extras/archive/devel.tar.gz -O tmp/ansible-modules-extras.tar.gz && \
    tar xzf tmp/ansible-modules-extras.tar.gz --directory=tmp/ && \
    mv tmp/ansible-modules-extras-devel/* tmp/ansible/lib/ansible/modules/extras/ && \
    rm -rf tmp/ansible-modules-extras.tar.gz tmp/ansible-modules-extras-devel/

echo "[INFO] Prepare Jinja2, version ${JINJA2_VERSION}"
wget -c -q https://github.com/pallets/jinja/archive/${JINJA2_VERSION}.tar.gz -O tmp/jinja2.tar.gz && \
    tar xzf tmp/jinja2.tar.gz --directory=tmp/ && \
    mv tmp/jinja-${JINJA2_VERSION}/jinja2 tmp/ansible/lib/ && \
    rm -rf tmp/jinja*

echo "[INFO] Prepare PyYAML, version ${PYYAML_VERSION}"
wget -c -q https://pypi.python.org/packages/source/P/PyYAML/PyYAML-${PYYAML_VERSION}.tar.gz -O tmp/pyyaml.tar.gz && \
    tar xzf tmp/pyyaml.tar.gz --directory=tmp/ && \
    mv tmp/PyYAML-${PYYAML_VERSION}/lib/yaml/ tmp/ansible/lib/ && \
    rm -rf tmp/pyyaml* tmp/PyYAML*

echo "[INFO] Prepare MarkupSafe, version ${MARKSAFE_VERSION}"
wget -c -q https://github.com/pallets/markupsafe/archive/${MARKSAFE_VERSION}.tar.gz -O tmp/markupsafe.tar.gz && \
    tar xzf tmp/markupsafe.tar.gz --directory=tmp/ && \
    mv tmp/markupsafe-${MARKSAFE_VERSION}/markupsafe/ tmp/ansible/lib/ && \
    rm -rf tmp/markupsafe*

echo "[INFO] Install Ansible"
mv tmp/ansible/bin . && mv tmp/ansible/lib .

echo "[INFO] Remove temporary directories"
rm -rf tmp/

echo "[INFO] Installation is completed"
