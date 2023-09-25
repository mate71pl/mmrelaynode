FROM debian:bookworm-slim AS device
LABEL "website"="https://github.com/mate-dev/mmrelaynode"
RUN apt-get update && apt-get install g++ -y
WORKDIR /bin
ADD https://github.com/mate-dev/mmrelaynode/releases/latest/download/meshtasticd_linux_amd64 /bin/meshtasticd
RUN chmod +x meshtasticd 
EXPOSE 4403
ENTRYPOINT [ "sh", "-c", "meshtasticd" ]