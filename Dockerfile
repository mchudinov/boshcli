FROM ubuntu:bionic
RUN apt-get update -y
RUN apt-get install -y linuxbrew-wrapper
# RUN apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline7 libreadline-dev libyaml-dev libsqlite3-dev sqlite3
RUN useradd -m -s /bin/zsh linuxbrew && \
    usermod -aG sudo linuxbrew &&  \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
USER linuxbrew
# RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
RUN brew install --quiet cloudfoundry/tap/bosh-cli
USER root
RUN brew info cloudfoundry/tap/bosh-cli
RUN ln -s /home/linuxbrew/.linuxbrew/Cellar/bosh-cli/6.4.0/bin/bosh /usr/bin
RUN bosh -v
RUN bosh envs
RUN mkdir bosh-1 && cd bosh-1
RUN git clone https://github.com/cloudfoundry/bosh-deployment
