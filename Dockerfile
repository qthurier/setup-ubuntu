FROM ubuntu:18.04

# fetch package lists
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# enable installation of man pages & reinstall coreutils so
# we have manpages for ls etc.
RUN rm -f /etc/dpkg/dpkg.cfg.d/excludes
RUN apt-get install --reinstall -y coreutils

# setup sudo and ubuntu user with sudo rights and no password
RUN apt-get install -y sudo
RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# don't leave the locale as POSIX, otherwise we get the dreaded UnicodeDecodeError
ENV LANG=C.UTF-8

# copy and run files one at a time to create individual caching layers
COPY install/system.sh /tmp/install/
RUN sudo /tmp/install/system.sh

COPY install/docker.sh /tmp/install/
RUN sudo /tmp/install/docker.sh

COPY install/git.sh /tmp/install/
RUN sudo /tmp/install/git.sh

COPY install/python.sh /tmp/install/
RUN sudo /tmp/install/python.sh

COPY install/java.sh /tmp/install/
RUN sudo /tmp/install/java.sh

COPY install/node.sh /tmp/install/
RUN sudo /tmp/install/node.sh

COPY install-user/packages.sh /tmp/install/
RUN /tmp/install/packages.sh

COPY dotfiles/ /tmp/dotfiles/

COPY install-user/config.sh /tmp/install/
RUN /tmp/install/config.sh

ENTRYPOINT [ "/usr/bin/zsh" ]
