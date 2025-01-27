docker run -p 3000:3000 --rm --name sourcebot -v /home/roberth/.config/sourcebot:/data -e CONFIG_PATH=/data/my_config.json ghcr.io/sourcebot-dev/sourcebot:latest
