#!/usr/bin/env sh

sed 's/secure\.//g' fastboot_flashing.sh > ff.sh
sed -i 's/qtd\.//g' ff.sh
sed -i 's/fastboot flash system_a/fastboot flash --force system_a/g' ff.sh
chmod +x ff.sh
