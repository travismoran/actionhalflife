FROM ubuntu:16.04

COPY s3cmd-2.0.1.tar.gz /root

RUN dpkg --add-architecture i386
RUN apt -y update && apt -y install wget curl lib32gcc1 build-essential python-setuptools libc6:i386 libstdc++6:i386 s3cmd

#RUN cd /root \
#    && tar zxvf s3cmd-2.0.1.tar.gz \
#    && cd s3cmd-2.0.1 \
#    && python setup.py install

RUN mkdir /root/steam -p
RUN cd /root/steam/ && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

RUN cd /root/steam/ \
    && chmod +x steamcmd.sh 
RUN cd /root/steam/ && ./steamcmd.sh +login anonymous +force_install_dir ~/hlds +app_set_config 90 mod cstrike +app_update 90 +quit; exit 0 

COPY appmanifest_10.acf appmanifest_70.acf appmanifest_90.acf /root/hlds/steamapps/
RUN cd /root/steam/ && ./steamcmd.sh +login anonymous +force_install_dir ~/hlds +app_set_config 90 mod cstrike +app_update 90 +quit; exit 0 

RUN cd /root/steam/ && ./steamcmd.sh +login anonymous +force_install_dir ~/hlds +app_set_config 90 mod cstrike +app_update 90 +quit; exit 0
    
RUN mkdir /root/.steam/sdk32 \
    && mkdir /root/hlds/action

RUN cp /root/steam/linux32/steamclient.so /root/.steam/sdk32/steamclient.so && \
    cp /root/steam/linux32/steamclient.so /root/hlds/steamclient.so
COPY config/server.cfg /root/hlds/action
COPY config/mapcycle.txt /root/hlds/action
COPY config/ahl_startup.sh /root/hlds/

RUN chmod +x /root/hlds/ahl_startup.sh

WORKDIR /root/hlds/

CMD ["/root/hlds/ahl_startup.sh"]
