FROM debian:bullseye-slim

RUN apt-get update
RUN apt-get install -y apt-utils

RUN apt-get install -y \
    lib32gcc-s1 gdb curl tree libc++1 libc++-dev unzip \
    && useradd -m steam \
    && mkdir /home/steam/Steam \
    && chown steam:steam /home/steam/Steam


RUN ln -sf /usr/lib/x86_64-linux-gnu/libc++.so.1 /usr/lib/x86_64-linux-gnu/libc++.so

USER steam
WORKDIR /home/steam/Steam

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# https://steamdb.info/app/622970/depots/
RUN ./steamcmd.sh +force_install_dir /home/steam/pavlovserver +login anonymous +app_update 622970 -beta shack_beta validate +exit

RUN ~/Steam/steamcmd.sh +login anonymous +app_update 1007 +quit \
    && mkdir -p ~/.steam/sdk64 \
    && cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/steamclient.so \
    && cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/pavlovserver/Pavlov/Binaries/Linux/steamclient.so \
    && mkdir -p /home/steam/pavlovserver/Pavlov/Saved/Logs \
    && mkdir -p /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer \
    && mkdir -p /home/steam/pavlovserver/Pavlov/Saved/maps

WORKDIR /home/steam/pavlovserver

RUN chmod +x ./PavlovServer.sh

EXPOSE 7777/udp
EXPOSE 8177/udp

CMD ./PavlovServer.sh -PORT=$PV_PORT

