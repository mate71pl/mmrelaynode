FROM frolvlad/alpine-glibc:glibc-2.34 AS node
LABEL "website"="https://github.com/mate-dev/mmrelaynode"
RUN apk --update add --no-cache g++ shadow
WORKDIR /bin
ADD https://github.com/mate-dev/mmrelaynode/releases/latest/download/meshtasticd_linux_amd64 /bin/meshtasticd
COPY run .
RUN chmod +x meshtasticd run
EXPOSE 4403
ENTRYPOINT [ "sh", "-c", "run" ]