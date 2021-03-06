#!/bin/bash
set -e
trap '' TERM INT HUP

# Ensure csgo is up to date
# echo "Updating CSGO from the entrypoint before starting. This will slow down boot time of your container."
#./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit

cd csgo
echo "Running srcds_run for your game. Standby."
./srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount "$STEAM_ACCOUNT_TOKEN"
