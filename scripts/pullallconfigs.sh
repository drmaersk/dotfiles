#! /usr/bin/env bash
#

foldername="configfiles$(date +%y%m%d%H%M)"

if adb root; then
    mkdir $foldername
    cd $foldername
    adb pull /vendor/etc/backend_conf.xml
    adb pull /vendor/etc/usecaseKvManager.xml
    adb pull /vendor/etc/resourcemanager_gvmauto8255_adp_star.xml
    adb pull /vendor/etc/audio_policy_configuration.xml
    adb pull /vendor/etc/car_audio_configuration.xml
    mkdir audio_ar
    cd audio_ar
    adb pull /vendor/etc/audio_ar/audio_policy_configuration.xml
    adb pull /vendor/etc/audio_ar/car_audio_configuration.xml
else
    echo "ERROR: couldn't root"
fi
