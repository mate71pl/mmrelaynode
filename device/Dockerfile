FROM debian:bookworm-slim AS device
LABEL "website"="https://github.com/mate-dev/mmrelaynode"
RUN apt-get update && apt-get -y install wget python3 g++ zip python3-venv git vim ca-certificates libgpiod-dev libyaml-cpp-dev libbluetooth-dev
WORKDIR /bin
ADD https://github.com/mate-dev/mmrelaynode/releases/latest/download/meshtasticd_linux_amd64 /bin/meshtasticd
RUN chmod +x meshtasticd 
EXPOSE 4403
ENTRYPOINT [ "sh", "-c", "meshtasticd" ]
HEALTHCHECK NONE