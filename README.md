## MMRELAYNODE
### A dockerized relay between Meshtastic and Matrix with native Meshtastic node connected via MQTT and the meshtastic node is virtualized too.

The repository uses firmware built based on [https://github.com/meshtastic/firmware](https://github.com/meshtastic/firmware).

Relay operation is implemented using the **Meshtastic <=> Matrix Relay** [https://github.com/geoffwhittington/meshtastic-matrix-relay](https://github.com/geoffwhittington/meshtastic-matrix-relay).

Feel free to explore the **Meshtastic** project on their website: [https://meshtastic.org](https://meshtastic.org).

This project consists of two containers `mmrealynode-app` and `mmrelaynode-device`.

First copy `docker-compose-sample.yaml` to `docker-compose.yaml` and customize it for your setup.

To build the containers:

```
git clone https://github.com/mate-dev/mmrelaynode.git
cd mmrelaynode && git submodule update --init
docker compose -f "docker-compose.yaml" up -d --build
docker compose restart
```

*Note: It is important to restart the containers after the first run so the virtual Meshtastic node can be rebooted after the `MESHTATIC_COMMAND_X:` commands that are definied in your `docker-compose.yaml` are issued.*


Use the following command to see the output of command_wrapper.py & the MESHTASTIC_COMMAND_X commands:
```
docker exec -it mmrelaynode-app cat /home/mesh/app/command_output.txt
```

The commands will only be executed the first time the container is started. To re-run the commands, delete the file flag file and restart the container.

To delete the flag file:
```
docker exec -it mmrelaynode-app rm /home/mesh/app/.commands_executed
```

If modifying the scripts, use these commands to rebuild the containers from scratch:

```
docker compose down --volumes
docker compose build --no-cache
docker compose up -d --force-recreate 
```