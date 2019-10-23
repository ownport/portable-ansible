FROM ubuntu:19.04

ENV DEBIAN_FRONTEND=noninteractive

COPY target/* /tmp/target/

RUN echo "[INFO] Updating apt repo" && \
        apt update && \
        apt install -y --no-install-recommends \
            openssh-client \
            python3 \
            python3-distutils && \
    echo "[INFO] SSH configuration" && \
        mkdir -p /root/.ssh && \
        mv /tmp/target/ansible.id_rsa /root/.ssh/ansible.id_rsa && \
        chmod 0700 /root/.ssh && \
        chmod 600 /root/.ssh/ansible.id_rsa && \
    echo "[INFO] Install portable-ansible" && \
        mkdir -p /opt/ && \
        tar xjf /tmp/target/portable-ansible-v0.3.2-py3.tar.bz2 -C /opt/ && \
    echo "[INFO] Remove apt lists" && \
        rm -rf \
            /var/lib/apt/lists/* \
            /tmp/target
