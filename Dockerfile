FROM ubuntu:latest
MAINTAINER Mathieu Duperre <mathieu.duperre@gmail.com>

RUN apt-get update && \
    apt-get install -y wget lib32gcc1 lib32tinfo5 unzip nginx lib32gcc1 libc6-i386 wget lib32stdc++6


RUN useradd -ms /bin/bash steam
WORKDIR /home/steam
USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

# Install CSGO once to speed up container startup
#RUN ./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit

ENV CSGO_HOSTNAME Counter-Strike Source Dedicated Server
ENV PUBLIC_IP ""
ENV PRIVATE_IP ""
ENV STEAM_ACCOUNT_TOKEN ""

EXPOSE 27015/udp
EXPOSE 27015

RUN ln -s /home/steam/linux32 /home/steam/.steam/sdk32

ADD ./csgo_entrypoint.sh csgo_entrypoint.sh

CMD ./csgo_entrypoint.sh
