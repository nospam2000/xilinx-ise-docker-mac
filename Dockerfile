# syntax=docker/dockerfile:1
#FROM debian:stretch-slim
#FROM ubuntu:18.04
#FROM ubuntu:16.04
FROM ubuntu:14.04

ENV TZ="Europe/Berlin"

RUN useradd -m xilinx -s /bin/bash \
    && mkdir /opt/Xilinx \
    && chown -R xilinx /opt/Xilinx

# libxp is no longer officially supported (was part of jessie) and unfortunately depends on multilib
# see also https://bugs.launchpad.net/ubuntu/+source/libxp/+bug/1517884 
RUN apt-get update \
    && echo "tzdata tzdata/Zones/Europe select Berlin" | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y iputils-ping iproute2 less software-properties-common libstdc++5

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y xterm fxload libxm4

# for Debian based container
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gpg iceweasel

# for Ubuntu based container
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg firefox

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libqt4-network

# not necessary for ubuntu:14.04, but for newer versions
#RUN add-apt-repository ppa:zeehio/libxp \
#    && apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libxp6

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT "/opt/entrypoint.sh"
CMD ""

USER xilinx
WORKDIR /code
