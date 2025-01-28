#!/usr/bin/env sh
rsync -avh --delete --max-size=500m \
    --exclude="NoBackup/"  \
    --exclude=".cache/"    \
    --exclude=".config/google-chrome"    \
    --exclude=".config/Epic"    \
    --exclude=".ccache/"    \
    --exclude="sources/"   \
    --exclude="Documents/grok/"   \
    --exclude="Documents/zoekt/"   \
     --compare-dest=/home/backup/ /home/roberth/ /home/delta/
mydate=$(date +%Y%m%d%H%M)
tar -czf /home/roberth/NoBackup/dtbackup/desktop_delta_"$mydate".tar.gz /home/delta/
ls /home/roberth/NoBackup/dtbackup/desktop_delta_"$mydate".tar.gz
/home/roberth/.nix-profile/bin/onedrive --synchronize --upload-only --no-remote-delete --single-directory "/home/roberth/NoBackup/dtbackup/"
