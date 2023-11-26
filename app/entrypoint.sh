#!/bin/bash
printenv
/home/mesh/.local/bin/wait-for-it.sh mmrelaydevice:4403 -t 60
python3 /home/mesh/app/command_wrapper.py
python3 /home/mesh/app/conf_wrapper.py
python3 /home/mesh/app/main.py