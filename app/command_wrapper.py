import os
import subprocess
import time

def execute_meshtastic_command(options):
    """Execute a meshtastic command with the given options."""
    command = ["meshtastic", "--host", "mmrelaydevice", "--port", "4403"] + options.split()
    print(f"Executing command: {' '.join(command)}")  # Add this line for debugging
    result = subprocess.run(command, capture_output=True, text=True)
    print(result.stdout)  # Add this line to print the output
    time.sleep(15)  # Pause for 30 seconds

# Loop through environment variables in sequence
index = 1
while True:
    command = os.environ.get(f'MESHTASTIC_COMMAND_{index}')
    if command:
        execute_meshtastic_command(command)
        index += 1
    else:
        break