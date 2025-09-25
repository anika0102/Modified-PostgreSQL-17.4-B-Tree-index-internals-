FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server postgresql postgresql-contrib && \
    mkdir /var/run/sshd


# Permit root login for SSH (optional)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH and PostgreSQL ports
EXPOSE 22 5432


# Start SSH and PostgreSQL on container startup
CMD service ssh start && service postgresql start && tail -f /dev/null

# apt-get update
# apt-get install -y iproute2


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash-completion \
        bison \
        bc \
        build-essential \
        cmake \
        curl \
        dstat \
        flex \
        gdb \
        git \
        libc6-dbg \
        libicu-dev \
        libreadline-dev \
        locales \
        pkg-config \
        tmux \
        valgrind \
        vim \
        wget \
        zlib1g \
        zlib1g-dev && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN adduser --disabled-password --gecos "" sajid && \
    echo 'sajid:123456' | chpasswd && \
    usermod -aG sudo sajid

RUN printf '\n# enable bash completion if available\nif [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n  . /etc/bash_completion\nfi\n' >> /etc/bash.bashrc

USER sajid

CMD ["/bin/bash"]
