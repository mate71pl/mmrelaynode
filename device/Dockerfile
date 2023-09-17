FROM frolvlad/alpine-glibc AS node
LABEL "website"="https://github.com/mate-dev/mmrelaynode"
RUN apk --update add --no-cache g++ shadow
WORKDIR /bin
ADD https://github.com/mate-dev/mmrelaynode/releases/latest/download/meshtasticd_linux_amd64 /bin/meshtasticd
RUN chmod +x meshtasticd 
EXPOSE 4403
ENTRYPOINT [ "sh", "-c", "meshtasticd" ]