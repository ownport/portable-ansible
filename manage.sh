#!/bin/bash

set -eu

OPTION=${1:-help}

source metadata
source libs/console.sh

case ${OPTION} in
    help)
        cat << EOM
Usage: ./manage.sh <option> [arguments]

Available options:
    help                        - this screen
    metadata                    - print out details about meta
    build-container-start       - start docker container for Ansible build
    build-container-stop        - stop docker container with Ansible build
    build-container-connect     - connect to docker container with Ansible build
    build-container-run         - run build of portable-ansible in docker container
    test-container-start        - start docker container for Ansible tests
    test-container-stop         - stop docker container with Ansible tests
    test-container-connect      - connect to docker container with Ansible tests
    test-container-run          - run portable-ansible tests in docker container
    prepare                     - prepare docker container for Ansible build
    clean                       - remove target directory
    dependencies                - prepare dependencies
    build                       - make build
    post-clean                  - cleanup after build
    tarball                     - make tarball

EOM
        ;;
    metadata)
        shift
        info "Portable-Ansible version: ${VERSION}"
        info "Tagball: ${TARBALL_NAME}"
        ;;
    build-container-start)
        shift
        info "Starting docker container for Ansible build" && \
            docker run -d --name ansible-build \
                -v "$(pwd)":/build alpine:latest tail -f /dev/null
        ;;
    build-container-stop)
        shift
        info "Stoping and removing docker container for Ansible build" && \
            docker container stop ansible-build && \
            docker container rm ansible-build
        ;;
    build-container-connect)
        shift
        info "Connecting to Ansible build container" && \
            docker container exec -ti ansible-build /bin/sh
        ;;
    build-container-run)
        shift
        docker container exec -ti ansible-build \
            apk add --no-cache \
                bash ncurses \
                python3 py3-pip \
                py3-wheel py3-setuptools
        docker container exec -ti ansible-build \
            /bin/bash -c "cd /build && \
                ./manage.sh clean && \
                ./manage.sh dependencies && \
                ./manage.sh build && \
                ./manage.sh post-clean && \
                ./manage.sh tarball"
        ;;
    test-container-start)
        shift
        info "Starting docker container for Ansible tests" && \
            docker run -d --name ansible-tests \
                -v "$(pwd)":/build alpine:latest tail -f /dev/null
        ;;
    test-container-stop)
        shift
        info "Stoping and removing docker container for Ansible tests" && \
            docker container stop ansible-tests && \
            docker container rm ansible-tests
        ;;
    test-container-connect)
        shift
        info "Connecting to Ansible tests container" && \
            docker container exec -ti ansible-tests /bin/sh
        ;;
    test-container-run)
        shift
        docker container exec -ti ansible-tests \
            apk add --no-cache \
                bash ncurses python3
        docker container exec -ti ansible-tests \
            /bin/bash -c "cd /build && \
                mkdir -p /build/opt && rm -rf /build/opt/* && \
                tar -xjf /build/builds/${TARBALL_NAME}-py3.tar.bz2 -C /build/opt/ && \
                ln -s /build/opt/ansible /build/opt/ansible-playbook && \
                python3 /build/opt/ansible-playbook -i /build/conf/hosts /build/test/local.yaml"
        ;;
    clean)
        shift
        info "Cleaning directory: $(pwd)/target"
        [ -d /build/target ] && rm -rf /build/target
        ;;
    dependencies)
        shift
        info "Preparing dependecies" && \
        mkdir -p "/build/target/ansible/" && \
            cp "/build/templates/__main__.py" "$(pwd)/target/ansible/"
        mkdir -p "/build/target/ansible/extras/"
        # cp $(shell pwd)/templates/ansible-compat-six-init.py $(shell pwd)/ansible/ansible/compat/six/__init__.py
        ;;
    build)
        shift
        info "Installing Ansible packages" && \
            pip3 install --no-deps \
                --no-compile --requirement conf/requirements \
                --target /build/target/ansible/
        ;;
    post-clean)
        shift
        info 'Removing extra dirs and files' && \
            rm -rf /build/target/ansible/*.dist-info && \
            rm -rf /build/target/ansible/*.egg-info && \
            rm -rf /build/target/ansible/*.gz && \
            rm -rf /build/target/ansible/*.whl && \
            rm -rf /build/target/ansible/bin/ && \
            rm -rf /build/target/ansible/ansible_test/ && \
        info 'Removing __pycache__ dirs' && \
            [ -d "/build/target/ansible/" ] && {
                find "/build/target/ansible/" -path '*/__pycache__/*' -delete
                find "/build/target/ansible/" -type d -name '__pycache__' -empty -delete
            }
            # rm -rf /build/target/ansible/bin && \
        ;;
    tarball)
        info 'Building tarball' && \
            mkdir -p "$(pwd)/builds" && \
            tar cjf builds/${TARBALL_NAME}-py3.tar.bz2 -C "$(pwd)/target/" ansible
        ;;
    *)
        if [ ! "$@" ]; then
            warning "No arguments specified, use help for more details" 
        else
            exec "$@"
        fi
        ;;
esac 
