FROM ubuntu:latest
MAINTAINER Mathieu Duperre <mathieu.duperre@gmail.com>

RUN dpkg --add-architecture i386

RUN apt-get update

RUN apt-get install -y lib32gcc1 libc6-i386 wget lib32stdc++6 lib32tinfo5 wget

RUN apt-get install -y libtinfo5:i386 libncurses5:i386 libcurl3-gnutls:i386

WORKDIR root

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

# Install CSGO once to speed up container startup
RUN ./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit

ENV CSGO_HOSTNAME Counter-Strike Source Dedicated Server
ENV PUBLIC_IP ""
ENV PRIVATE_IP ""
ENV STEAM_ACCOUNT_TOKEN ""

EXPOSE 27015/udp
EXPOSE 27015

RUN mkdir /root/.steam/sdk32

RUN ln -s /root/csgo/bin/steamclient.so /root/.steam/sdk32/steamclient.so

ADD ./csgo_entrypoint.sh csgo_entrypoint.sh

CMD ./csgo_entrypoint.sh
