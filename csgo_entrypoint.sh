#!/bin/bash
set -e
trap '' TERM INT HUP

# Ensure csgo is up to date
./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit

cd csgo
./srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount "$STEAM_ACCOUNT_TOKEN"
#./srcds_run -console -usercon +hostname "$CSGO_HOSTNAME" +net_public_adr "$PUBLIC_IP" +ip "$PRIVATE_IP" -port 27015 -game csgo -tickrate 100 +game_type 0 +game_mode 0 +mapgroup mg_bomb +map de_dust2 +maxplayers 22 -maxplayers_override 22 +exec server.cfg -stringtables -condebug +sv_setsteamaccount "$STEAM_ACCOUNT_TOKEN"
