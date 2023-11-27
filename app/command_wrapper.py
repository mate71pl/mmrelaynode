import os
import subprocess
import time

def log_to_file(message):
    with open('/home/mesh/app/command_output.txt', 'a') as f:
        f.write(message + "\n")

def execute_meshtastic_command(options):
    """Execute a meshtastic command with the given options."""
    command = ["meshtastic", "--host", "mmrelaydevice", "--port", "4403"] + options.split()
    log_to_file(f"Executing command: {' '.join(command)}")
    result = subprocess.run(command, capture_output=True, text=True)
    log_to_file("Standard Output:\n" + result.stdout)
    log_to_file("Standard Error:\n" + result.stderr)
    time.sleep(1)  # Pause for 1 second between commands

# Print all environment variables at the start
log_to_file("All environment variables:\n" + str(os.environ))

# Loop through environment variables in sequence
index = 1
while True:
    command = os.environ.get(f'MESHTASTIC_COMMAND_{index}')
    if command:
        log_to_file(f"Found command variable: MESHTASTIC_COMMAND_{index} with value: {command}")
        execute_meshtastic_command(command)
        index += 1
    else:
        log_to_file(f"No more MESHTASTIC_COMMAND variables found, ending at index {index-1}.")
        break