#!/bin/bash
/home/mesh/.local/bin/wait-for-it.sh mmrelaydevice:4403 -t 60
python3 command_wrapper.py
python3 conf_wrapper.py
python3 main.py