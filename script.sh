#!/bin/bash

export TERM=xterm

ROOT_PATH=$PWD
DEVICE=lettuce
BUILD_PATH="$ROOT_PATH/out/target/product/$DEVICE"

#Get Filesize
cd $BUILD_PATH
STAG="$(ls StagOS*.zip)"
size=$(du -sh $STAG | awk '{print $1}')

#Upload to Sourceforge
echo "Uploading to Sourceforge"
echo "put $STAG /home/frs/project/team-xtreme/" | sftp ravi9967@frs.sourceforge.net

#Upload to drive
echo "Uploading To Google Drive"
fileid=$(gdrive upload ${STAG} -p 1bYCLRWIPfuH7Uf7WT9lk7Vgj9iYhQJll | tail -1 | awk '{print $2}')

#Send Notifications to channel
echo "Sending Notifications to group"
telegram-send --image "$ROOT_PATH/stag.jpg"
telegram-send --format markdown "Device :- $DEVICE
Download :- [SourceForge](https://sourceforge.net/projects/team-xtreme/file/$STAG/download) | [GDrive Mirror](https://drive.google.com/uc?id=$fileid&export=download)
FileSize :- $size"
