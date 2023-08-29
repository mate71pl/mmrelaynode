#!/bin/sh
HWID=$(grep 'hwid: "' /home/mesh/app/config.yaml)
/usr/bin/meshtasticd -d /home/mesh/node -h $HWID