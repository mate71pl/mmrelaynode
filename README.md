## MMRELAYNODE
### A relay between Meshtastic and Matrix with native Meshtastic node connected via MQTT

The repository uses firmware built based on [https://github.com/meshtastic/firmware](https://github.com/meshtastic/firmware).

Relay operation is implemented using the **Meshtastic <=> Matrix Relay** [https://github.com/geoffwhittington/meshtastic-matrix-relay](https://github.com/geoffwhittington/meshtastic-matrix-relay).

Feel free to explore the **Meshtastic** project on their website: [https://meshtastic.org](https://meshtastic.org).

```
git clone https://github.com/mate-dev/mmrelaynode.git
cd mmrelaynode && git submodule update --init
docker compose -f "docker-compose.yaml" up -d --build
```

If modifying scripts, with the containers stopped use these commands to rebuild them:

```
docker system prune -af
docker-compose build --no-cache
docker-compose up -d --force-recreate 
```

Use the following command to see the output of command_wrapper.py & the MESHTASTIC_COMMAND_X commands:
```
docker exec -it mmrelaynode-app cat /home/mesh/app/command_output.txt
```