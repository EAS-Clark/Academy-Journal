#! /bin/bash
mkdir -p /media/plex_drive/Plex/Anime/"$2"/Season\ $1
#mkdir -p /media/plex_drive/torrents/transmission-rss/"$2"
#sudo mount --bind /media/plex_drive/Plex/Anime/"$2"/Season\ $1 /media/plex_drive/torrents/transmission-rss/"$2"
ln -s /media/plex_drive/Plex/Anime/"$2"/Season\ $1 "$2"
