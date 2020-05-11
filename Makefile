
build:
	docker build -t media-server .
run:
	docker run -it --rm -p 8200 \
			   -p 8200:8200 \
               -p 9091:9091 \
               -p 51413:51413 \
               -p 51413:51413/udp \
               media-server
			   # TODO: set proper owner / permissions on these scripts.
               #-v /tmp/media-server/media:/home/horust/media/ \
               #-v /tmp/media-server/download:/home/horust/download/ \

