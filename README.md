# csgo-edge

---------------------------------------------------------

How this was built
apt-get install docker.io
docker pull ubuntu
docker run --name csgo-edge -it ubuntu:latest bash
apt-get update
apt-get install -y lib32gcc1 libc6-i386 wget
cd root
wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 +quit
cd csgo
./srcds_run -console -usercon +net_public_adr X.X.X.X +ip X.X.X. -port 27015 -game csgo -tickrate 100 +game_type 0 +game_mode 0 +mapgroup mg_bomb +map de_dust2 +maxplayers 22 -maxplayers_override 22 +exec server.cfg -stringtables -condebug +sv_setsteamaccount 

---------------------------------------------------------

TO RUN CSGO DOCKER
git clone https://github.com/mathieuduperre/csgo-edge.git
docker build -t csgo-edge .
docker run -p 27015:27015 -p 27015:27015/udp -e STEAM_ACCOUNT_TOKEN=xxxxx -e PUBLIC_IP=X.X.X.X -e private_ip=X.X.X.X csgo-edge

----------------
