FROM mcr.microsoft.com/vscode/devcontainers/php:8.1-bullseye

# Install node and yarn
ENV NODE_VERSION=16.13.0
RUN bash -c ". /usr/local/share/nvm/nvm.sh \
    && nvm install $NODE_VERSION \
    && npm install -g typescript yarn node-gyp"

# Install tools
RUN apt update \
  && apt install -y vim silversearcher-ag \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o ~/awscliv2.zip \
  && unzip ~/awscliv2.zip -d ~/ && ~/aws/install && rm -rf aws*

USER vscode

# Install Vim config
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
  && sh ~/.vim_runtime/install_awesome_vimrc.sh

# Enable git completion in bash
RUN echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
