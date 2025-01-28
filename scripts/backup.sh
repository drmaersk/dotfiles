#! /usr/bin/env bash

rsync -avh --delete --max-size=500m \
    --exclude="NoBackup/"  \
    --exclude=".cache/"    \
    --exclude=".config/google-chrome"    \
    --exclude=".config/Epic"    \
    --exclude=".ccache/"    \
    --exclude="sources/"   \
    --exclude="Documents/grok/"   \
    --exclude="Documents/zoekt/"   \
    /home/roberth/ /home/backup/
tar -czf /home/roberth/NoBackup/dtbackup/desktop_backup_$(date +%Y%m%d).tar.gz /home/backup/
ls /home/roberth/NoBackup/dtbackup/desktop_backup_$(date +%Y%m%d).tar.gz

/home/roberth/.nix-profile/bin/onedrive --synchronize --upload-only --no-remote-delete --single-directory "/home/roberth/NoBackup/dtbackup/"

#onedrive --synchronize --upload-only --single-directory dtbackup --syncdir ~/NoBackup
