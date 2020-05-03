FROM federicoponzi/horust:latest
ARG DOWNLOAD_DIR=/home/downloads/
RUN apt-get update && apt-get install -y --no-install-recommends minidlna transmission-daemon
RUN mkdir ${DOWNLOAD_DIR}
ADD transmission-settings.json /etc/transmission-daemon/settings.json 
ADD minidlna.conf /etc/minidlna.conf
RUN sed -i "/DOWNLOAD_DIR/${DOWNLOAD_DIR}/g" /etc/minidlna.conf
RUN sed -i "/DOWNLOAD_DIR/${DOWNLOAD_DIR}/g" /etc/transmission-daemon/settings.json 

ADD minidlna.toml /etc/horust/services/
ADD transmission.toml /etc/horust/services/

