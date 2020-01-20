#!/bin/bash

export TERM=xterm

ROOT_PATH=$PWD
BUILD_PATH="$ROOT_PATH/out/target/product/$DEVICE"

#Get Filesize
cd $BUILD_PATH
STAG="$(ls StagOS*.zip)"
size=$(du -sh $STAG | awk '{print $1}')

#Upload to drive
echo "Uploading"
fileid=$(gdrive upload ${STAG} -p 1bYCLRWIPfuH7Uf7WT9lk7Vgj9iYhQJll | tail -1 | awk '{print $2}')

#Send Notifications to channel
telegram-send --image "$ROOT_PATH/stag.jpg"
telegram-send --format markdown "Device :- $DEVICE
Download :- [SourceForge](https://sourceforge.net/projects/stagos-10/files/$DEVICE/$STAG/download) | [GDrive Mirror](https://drive.google.com/uc?id=$fileid&export=download)
FileSize :- $size"
