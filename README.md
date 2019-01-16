# csgo-edge

---------------------------------------------------------
Quick start:

You can easily start one instance by simply doing:

docker pull grido/csgo-edge

docker run -p 27015:27015 -p 27015:27015/udp -e STEAM_ACCOUNT_TOKEN=XXXXXXXXXXXXXXXXXXXXXXXX grido/csgo-edge


(make sure your steam account token, aka GSLT, is using the code 730. You need to install using 740, but the token to start it needs to be 730...)

---------------------------------------------------------
To build the docker image locally by using this git repo:

git clone https://github.com/mathieuduperre/csgo-edge.git

cd csgo-edge

chmod +x csgo_entrypoint.sh

docker build -t grido/csgo-edge .

docker run -p 27015:27015 -p 27015:27015/udp -e STEAM_ACCOUNT_TOKEN=XXXXXXXXXXXXXXXXXXXXXXXX grido/csgo-edge

(make sure your steam account token, aka GSLT, is using the code 730. You need to install using 740, but the token to start it needs to be 730...)




----------------------------------------------------------
How the docker was built. You should not need that, these are just notes.


SETUP CSGO ON CENTOS/Docker FROM BAREMETAL - WORKING
(as root)
yum update -y
yum upgrade -y
adduser csgo
yum install docker wget git -y
systemctl disable firewalld
systemctl stop firewalld
systemctl start docker

apt-get install docker.io

-----------------------------------------

docker pull ubuntu

docker run --name csgo-edge -it ubuntu:latest bash

dpkg --add-architecture i386

apt-get update

apt-get install -y lib32gcc1 libc6-i386 wget lib32stdc++6 lib32tinfo5

apt-get install libtinfo5:i386 libncurses5:i386 libcurl3-gnutls:i386

cd root

wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz

tar -xvzf steamcmd_linux.tar.gz

./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 +quit

cd csgo

mkdir /root/.steam/sdk32

ln -s /root/csgo/bin/steamclient.so /root/.steam/sdk32/steamclient.so

./srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount "60C0ED7D1EFC6251D716FE1354C6FB84"
