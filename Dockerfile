FROM ubuntu:latest
MAINTAINER Mathieu Duperre <mathieu.duperre@gmail.com>

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y apt-transport-https

RUN apt-get update

RUN apt-get install -y lib32gcc1 libc6-i386 wget lib32stdc++6 lib32tinfo5 wget

RUN apt-get install -y libtinfo5:i386 libncurses5:i386 libcurl3-gnutls:i386

RUN useradd -ms /bin/bash steam
WORKDIR /home/steam
USER steam

RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz

RUN tar -xvzf steamcmd_linux.tar.gz

# Install CSGO once to speed up container startup
RUN ./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 +quit

ENV CSGO_HOSTNAME Counter-Strike Source Dedicated Server
ENV PUBLIC_IP ""
ENV PRIVATE_IP ""
ENV STEAM_ACCOUNT_TOKEN ""

EXPOSE 27015/udp
EXPOSE 27015

USER root
RUN mkdir /home/steam/.steam/sdk32
RUN ln -s /home/steam/csgo/bin/steamclient.so /home/steam/.steam/sdk32/steamclient.so

USER steam
ADD ./csgo_entrypoint.sh csgo_entrypoint.sh
USER root
RUN ["chmod", "775", "./csgo_entrypoint.sh"]
USER steam

CMD ./csgo_entrypoint.sh
