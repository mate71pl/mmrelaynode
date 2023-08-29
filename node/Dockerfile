FROM alpine:3.18 AS node
LABEL "website"="https://github.com/mate-dev/mmrelaynode"
RUN apk --update add --no-cache g++ shadow && \
        groupadd -g 1000 mesh && useradd -ml -u 1000 -g 1000 mesh
ADD https://github.com/mate-dev/mmrelaynode/releases/latest/download/meshtasticd_linux_amd64 /usr/bin/meshtasticd
RUN chmod +x /usr/bin/meshtasticd
RUN mkdir /home/mesh/node 
COPY run.sh /home/mesh/node/
RUN chown mesh:mesh -R /home/mesh/node && chmod +x /home/mesh/node/run.sh
WORKDIR /home/mesh/node/
#ENTRYPOINT ["sh", "-c", "/usr/bin/meshtasticd -d /home/mesh/node -h 12345"]



