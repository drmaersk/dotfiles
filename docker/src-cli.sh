docker run -e SRC_ACCESS_TOKEN=sgp_local_282ee279df0ea1fdda9a2a3dd2780df87a31b6a8 \
	   -e SRC_ENDPOINT=http://172.20.20.42:7080 \
	   --rm \
           --publish 3434:3434 \
           --volume $PWD:/data/repos:ro \
	   sourcegraph/src-cli:latest serve-git /data/repos
