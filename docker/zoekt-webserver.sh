docker run -d \
   --rm \
   --network host \
  -v /home/roberth/Documents/zoekt/index:/data \
   zoekt-webserver
