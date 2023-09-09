import os
import subprocess
import time

def execute_meshtastic_command(options):
    """Execute a meshtastic command with the given options."""
    command = ["meshtastic", "--set"] + options.split()
    subprocess.run(command)
    time.sleep(30)  # Pause for 30 seconds

# Loop through environment variables in sequence
index = 1
while True:
    command = os.environ.get(f'MESHTASTIC_COMMAND_{index}')
    if command:
        execute_meshtastic_command(command)
        index += 1
    else:
        break

# Finally, run the main Meshtastic process (or whatever process you want to keep the container running)
subprocess.run(["meshtastic"])
