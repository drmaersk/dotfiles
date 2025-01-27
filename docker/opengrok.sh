#!/bin/bash

# Check if the container "my_app" is already running
if ! docker ps --filter "name=grok" --format "{{.Names}}" | grep -w grok > /dev/null; then
  # If the container is not running, start it
  echo "Starting grok container"

docker run -d \
   --name grok \
   --rm \
   --network host \
   -v /home/roberth/sources/haleytek-gpa:/opengrok/haleytek-gpa \
   -v /home/roberth/Documents/grok/data:/opengrok/data \
   -v /home/roberth/Documents/grok/src:/opengrok/src \
   -v /home/roberth/Documents/grok/etc:/opengrok/etc \
   -e OPENGROK_SRC_ROOT="/opengrok/haleytek-gpa/android/" \
   -e SRC_ROOT="/opengrok/haleytek-gpa/android/" \
   -e SYNC_PERIOD_MINUTES=0 \
   -e NOMIRROR=1 \
   -e WORKERS=4 \
   -e INDEXER_OPT="-T 4 --depth 20" \
   opengrok-dev
else
  echo "grok is already running."
fi

exit 0

INDEXER_JAVA_OPTS
INDEXER_OPT


   -v /home/roberth/Documents/grok/src:/opengrok/src \
INFO: Indexer options: [-s, /opengrok/src, -d, /opengrok/data, -c, /usr/local/bin/ctags, --remote, on, -H, -S, -W, /opengrok/etc/configuration.xml, --noIndex, -P]

   -e OPENGROK_SRC_ROOT="/opengrok/haleytek-gpa/android" \
   -e SRC_ROOT="/opengrok/haleytek-gpa/android" \
