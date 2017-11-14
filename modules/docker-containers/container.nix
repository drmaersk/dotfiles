{stdenv, name, dockersource, xhost}:

let
build = ''
#!/usr/bin/env bash

USER_ID="$(id -u "$USER")"
DIR="$( cd "$( dirname "''${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$1" == "-p" ]]
then
  read -p "Proxy server (semegot-pr02.mecel.net, proxy-emea.delphiauto.net): " PROXY_SERVER
  read -p "Proxy port (80, 8080): " PROXY_PORT
  read -p "Proxy user (MichaelL, ljhld5): " PROXY_USER
  read -s -p "Proxy password: " PROXY_PASSWORD
  PROXY="http://$PROXY_USER:$PROXY_PASSWORD@$PROXY_SERVER:$PROXY_PORT"

  { cat << 'EOT'; cat << EOT; } | docker build -t "${name}" --build-arg http_proxy="$PROXY" --build-arg https_proxy="$PROXY" -
${dockersource}
EOT
RUN useradd -r -s /bin/bash -u $USER_ID $USER
USER $USER
EOT
else
  { cat << 'EOT'; cat << EOT; } | docker build -t "${name}" -
${dockersource}
EOT
RUN useradd -r -s /bin/bash -u $USER_ID $USER
USER $USER
EOT
fi
'';

run = ''
#!/usr/bin/env bash

USER_ID="$(id -u "$USER")"
${xhost}/bin/xhost +si:localuser:$USER

# To setup ccache from AOSP run prebuilts/misc/linux-x86/ccache/ccache -M 100G
docker run \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  --device /dev/kvm \
  -u "$USER_ID" \
  -e HOME=$HOME \
  -e USER=$USER \
  -e USE_CCACHE=1 \
  -v $HOME/:$HOME \
  -w "$PWD" \
  --net=host \
  -it "${name}"
'';

in
stdenv.mkDerivation {
  name = name;

  buildInputs = [ xhost ];

  buildCommand = ''
    mkdir -p $out/bin
    cat << 'EOF' > $out/bin/build-${name}
${build}
EOF
    chmod +x $out/bin/build-${name}

    cat << 'EOF' > $out/bin/${name}
${run}
EOF
    chmod +x $out/bin/${name}
  '';
}
