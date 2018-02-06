FROM ubuntu:16.04

RUN apt-get -y update

RUN apt-get -fy install

RUN apt-get -y install fastboot adb

RUN apt-get -y install openjdk-8-jdk openjdk-8-jre openjdk-8-jre-headless

RUN apt-get -y install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip

RUN apt-get -y install python bc

RUN apt-get -y install libssl-dev

RUN apt-get -y install python-mako
RUN apt-get -y install gettext
RUN apt-get -y install vim-common
RUN apt-get -y install python3
RUN apt-get -y install cmake
RUN apt-get -y install bear
RUN apt-get -y install libsecret-1-0

RUN mkdir -p /etc/udev/rules.d && echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="8087", MODE="0666", GROUP="plugdev"' > /etc/udev/rules.d/51-android.rules

RUN apt-get -y install wget
RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
RUN unzip -d /usr/local/sbin platform-tools-latest-linux.zip
RUN wget -O /usr/local/sbin/adb https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/adb
RUN wget -O /usr/local/sbin/fastboot https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/android/fastboot
RUN wget -O /usr/local/sbin/repo https://storage.googleapis.com/git-repo-downloads/repo
RUN chmod +x /usr/local/sbin/adb /usr/local/sbin/fastboot /usr/local/sbin/repo
RUN apt-get -y install tmux
