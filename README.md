# csgo-edge

---------------------------------------------------------

How this was built

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

docker pull ubuntu

docker run --name csgo-edge -it ubuntu:latest bash

apt-get update

apt-get install -y lib32gcc1 libc6-i386 wget lib32stdc++6

cd root

wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz

tar -xvzf steamcmd_linux.tar.gz

./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 +quit

cd csgo

./srcds_run -console -usercon +net_public_adr X.X.X.X +ip X.X.X. -port 27015 -game csgo -tickrate 100 +game_type 0 +game_mode 0 +mapgroup mg_bomb +map de_dust2 +maxplayers 22 -maxplayers_override 22 +exec server.cfg -stringtables -condebug +sv_setsteamaccount 


---------------------------------------------------------

git clone https://github.com/mathieuduperre/csgo-edge.git
cd csgo-edge
chmod +x csgo_entrypoint.sh
docker build -t grido/csgo-edge .
docker run -p 27015:27015 -p 27015:27015/udp -e STEAM_ACCOUNT_TOKEN=4E9BE9DCE9E8954D015414FE099A1730 grido/csgo-edge


(make sure your steam account token, aka GSLT, is using the code 730. You need to install using 740, but the token to start it needs to be 730...)

----------------
