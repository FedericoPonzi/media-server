FROM federicoponzi/horust:latest
# Let's create the user and groups for our services:
RUN groupadd -r minidlna && useradd --no-log-init -r -g minidlna minidlna
RUN groupadd -r transmission && useradd --no-log-init -r -g transmission transmission

# * media: will contain the media files available via DLNA
# * download: download directory for our torrent files.
RUN mkdir -p /home/horust/media &&\
    mkdir /home/horust/download &&\
    mkdir -p /home/horust/incomplete-download/ &&\
    mkdir -p /home/transmission/.config/transmission-daemon/ &&\
    chown -R transmission:transmission /home/transmission/

# Horust config files:
ADD /horust-services/* /etc/horust/services/
# minidlna and transmission:
EXPOSE 8200 9091 51413 51413/udp

RUN apt-get update && apt-get install -y --no-install-recommends minidlna transmission-daemon
# Overwrite the conf
ADD transmission-settings.json /etc/transmission-daemon/settings.json
ADD transmission-settings.json /home/transmission/.config/transmission-daemon/settings.json
ADD minidlna.conf /etc/minidlna.conf
# ...and that's all folks!


HEALTHCHECK --interval=60s --timeout=15s \
            CMD netstat -lntp | grep -q '0\.0\.0\.0:9091'