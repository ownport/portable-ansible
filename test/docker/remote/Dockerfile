FROM ubuntu:19.04

ARG SSH_PUB_KEY

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "[INFO] Updating apt repo" && \
        apt update && \
        apt install -y --no-install-recommends \
            openssh-server \
            python3 && \
    echo "[INFO] SSH configuration" && \
        mkdir -p /run/sshd /root/.ssh && \
        chmod 0700 /root/.ssh && \
        echo "$SSH_PUB_KEY" > /root/.ssh/authorized_keys && \
        chmod 600 /root/.ssh/authorized_keys && \
    echo "[INFO] Adding ansible user" && \
        useradd -d /home/ansible ansible && \
        echo "ansible:ansible" | chpasswd && \
        mkdir -p /home/ansible && \
        chown ansible:ansible /home/ansible && \
    echo "[INFO] Remove apt lists" && \
        rm -rf /var/lib/apt/lists/*

CMD ["/usr/sbin/sshd", "-D"]
