import os
import yaml

# Read environment variables and construct the configuration dictionary
relay_config = {
    "matrix": {
        "homeserver": os.environ.get('MATRIX_HOMESERVER'),
        "access_token": os.environ.get('MATRIX_ACCESS_TOKEN'),
        "bot_user_id": os.environ.get('MATRIX_BOT_USER_ID')
    },
    "meshtastic": {
        "connection_type": os.environ.get('MESHTASTIC_CONNECTION_TYPE'),
        "serial_port": os.environ.get('MESHTASTIC_SERIAL_PORT'),
        "host": os.environ.get('MESHTASTIC_HOST'),
        "meshnet_name": os.environ.get('MESHTASTIC_MESHNET_NAME'),
        "broadcast_enabled": os.environ.get('MESHTASTIC_BROADCAST_ENABLED') == 'true'
    },
    "logging": {
        "level": os.environ.get('LOGGING_LEVEL')
    }
}

# Construct the matrix_rooms list based on environment variables
matrix_rooms = []
for i in range(1, 9):  # Loop for 8 rooms
    room_id = os.environ.get(f'MATRIX_ROOMS_ID_{i}')
    meshtastic_channel = os.environ.get(f'MATRIX_ROOMS_MESHTASTIC_CHANNEL_{i}')
    if room_id and meshtastic_channel is not None:
        matrix_rooms.append({
            "id": room_id,
            "meshtastic_channel": int(meshtastic_channel)
        })

# Add the matrix_rooms list to the relay_config dictionary
relay_config["matrix_rooms"] = matrix_rooms

# Construct the plugins dictionary based on environment variables
plugins_config = {}

health_plugin_active = os.environ.get('HEALTH_PLUGIN_ACTIVE')
if health_plugin_active:
    plugins_config["health"] = {"active": health_plugin_active.lower() == "true"}

map_plugin_active = os.environ.get('MAP_PLUGIN_ACTIVE')
if map_plugin_active:
    plugins_config["map"] = {"active": map_plugin_active.lower() == "true"}

nodes_plugin_active = os.environ.get('NODES_PLUGIN_ACTIVE')
if nodes_plugin_active:
    plugins_config["nodes"] = {"active": nodes_plugin_active.lower() == "true"}

chutilz_plugin_active = os.environ.get('CHUTILZ_PLUGIN_ACTIVE')
if chutilz_plugin_active:
    plugins_config["chutilz"] = {"active": chutilz_plugin_active.lower() == "true"}

airutilz_plugin_active = os.environ.get('AIRUTILZ_PLUGIN_ACTIVE')
if airutilz_plugin_active:
    plugins_config["airutilz"] = {"active": airutilz_plugin_active.lower() == "true"}

battery_plugin_active = os.environ.get('BATTERY_PLUGIN_ACTIVE')
if battery_plugin_active:
    plugins_config["battery"] = {"active": battery_plugin_active.lower() == "true"}

voltage_plugin_active = os.environ.get('VOLTAGE_PLUGIN_ACTIVE')
if voltage_plugin_active:
    plugins_config["voltage"] = {"active": voltage_plugin_active.lower() == "true"}

snr_plugin_active = os.environ.get('SNR_PLUGIN_ACTIVE')
if snr_plugin_active:
    plugins_config["snr"] = {"active": snr_plugin_active.lower() == "true"}

# Add the plugins dictionary to the relay_config if it's not empty
if plugins_config:
    relay_config["plugins"] = plugins_config

# Write the configuration to config.yaml
with open("config.yaml", "w") as f:
    yaml.dump(relay_config, f)

