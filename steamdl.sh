#!/usr/bin/env bash

# checking for steamcmd
if which steamcmd | grep -q 'not found' 
then
    echo "SteamCMD not found! Please install it."
else
    echo "SteamCMD found successfully!"
fi

# shellcheck disable=SC2162
read -p "Workshop item ID: " id;
# shellcheck disable=SC2162
read -p "App ID (Enter 0 for last used App ID)\n(can be found in SteamDB or in the url of the store page for the game.): " appid;
# shellcheck disable=SC2162
read -p "Directory to which you want the mod to be installed. (Enter 0 for last used path) (Leave blank for default): " path;


if [ "$appid" = 0 ]
then
    appid=$(cat appIdMemory)
fi

if [ "$path" = 0 ]
then
    path=$(cat pathMemory)
fi

echo "$appid" > appIdMemory
echo "$path" > pathMemory

printf "Workshop item ID: $id\nApp ID: $appid $game\nInstall path: $path";
echo;
read -p "Is that correct? (Y/N)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Initializing script.";
    steamcmd +login anonymous +workshop_download_item $appid $id +quit &&
    mv -v "$HOME"/.local/share/Steam/steamapps/workshop/content/"$appid"/"$id" "$path"
fi
