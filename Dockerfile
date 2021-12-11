# syntax=docker/dockerfile:1
#FROM debian:stretch-slim
#FROM ubuntu:18.04
#FROM ubuntu:16.04
FROM ubuntu:14.04

ENV TZ="Europe/Berlin"

RUN useradd -m xilinx -s /bin/bash \
    && mkdir /opt/Xilinx \
    && chown -R xilinx /opt/Xilinx

RUN apt-get update \
    && echo "tzdata tzdata/Zones/Europe select Berlin" | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y iputils-ping iproute2 less software-properties-common gcc libstdc++5 xterm fxload libxm4 libqt4-network

# for Debian based container
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gpg iceweasel

# for Ubuntu based container
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg firefox

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y xfonts-75dpi xfonts-100dpi

# to get XKeysymDB
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y xemacs21-support

# not necessary for ubuntu:14.04, but for newer versions
# libxp is no longer officially supported (was part of jessie) and unfortunately depends on multilib
# see also https://bugs.launchpad.net/ubuntu/+source/libxp/+bug/1517884 
#RUN add-apt-repository ppa:zeehio/libxp \
#    && apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libxp6

# The script /opt/Xilinx/14.7/ISE_DS/ISE/sysgen/util/sysgen assumes bash features for sh, so we use bash for sh
RUN ln -sf /bin/bash /bin/sh

COPY entrypoint*.sh /opt/
ENTRYPOINT "/opt/entrypoint.sh"
CMD ""

USER xilinx
WORKDIR /code
