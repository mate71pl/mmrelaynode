#!/bin/bash
set -e

# Check linux distro
OS=$(uname -s | tr A-Z a-z)
source /etc/os-release
case $ID in
    debian|ubuntu|mint)
    RUN="apt-get"
    ;;
    fedora|rhel|centos)
    RUN="yum"
    ;;
    *)
    echo -n "unsupported linux distro"
    ;;
esac

# Check and install docker and git
if ! docker &> /dev/null; then
    echo "Docker is not installed. Installing it via the script from docker.com"
    echo "================================================================"
    sudo $RUN update &> /dev/null && sudo $RUN install -y curl &> /dev/null && sudo $RUN install -y git &> /dev/null
    sudo groupadd docker > /dev/null 2>&1 || true
    sudo usermod -aG docker $USER
    curl -fsSL https://get.docker.com -o get-docker.sh
    chmod +x get-docker.sh
    sh -c ./get-docker.sh
    rm get-docker.sh
fi

# Function to display help message
display_help() {
    echo "Usage: $0 [command] [container_name]"
    echo "Commands:"
    echo "  build - Build containers (optional: specify container_name)"
    echo "  up - Start containers (optional: specify container_name)"
    echo "  start - Start containers (optional: specify container_name)"
    echo "  down - Stop and remove containers (optional: specify container_name)"
    echo "  destroy - Stop, remove containers, and remove volumes (optional: specify container_name)"
    echo "  stop - Stop containers (optional: specify container_name)"
    echo "  restart - Restart containers (optional: specify container_name)"
    echo "  logs - Show container logs (optional: specify container_name)"
    echo "  --help, -h - Display this help message"
}

# Function to execute Docker Compose commands
docker_compose() {
    local command="$1"
    local container_name="$2"
    
    # If container_name is empty and the command is not "logs", set it to an empty string
    if [ -z "$container_name" ] && [ "$command" != "logs" ]; then
        container_name=""
    fi
    
    echo "$command container(s): $container_name"
    docker compose -f docker-compose.yaml $command $container_name
}

# Check for the help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    display_help
    exit 0
fi

# Check if "menu" is in the script name, and if so, display the menu
if [[ $0 == *"menu"* ]]; then
    while true; do
        clear
        echo "Bash Menu:"
        echo "1. Build [container_name]"
        echo "2. Up [container_name]"
        echo "3. Start [container_name]"
        echo "4. Down [container_name]"
        echo "5. Destroy [container_name]"
        echo "6. Stop [container_name]"
        echo "7. Restart [container_name]"
        echo "8. Logs [container_name]"
        echo "0. Exit"
        echo "--help, -h - Display this help message"

        read -p "Enter your choice: " choice

        case "$choice" in
            1) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "up -d --build" "$container_name" ;;
            2) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "up -d" "$container_name" ;;
            3) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "start" "$container_name" ;;
            4) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "down" "$container_name" ;;
            5) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "down -v" "$container_name" ;;
            6) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "stop" "$container_name" ;;
            7) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "restart" "$container_name" ;;
            8) read -p "Enter container name (or press Enter for default): " container_name
               docker_compose "logs --tail=100 -f" "$container_name" ;;
            0) exit ;;
            "--help" | "-h") display_help ;;
            *) echo "Invalid choice. Please try again." ;;
        esac

        read -p "Press Enter to continue..."
    done
else
    # If "menu" is not in the script name, execute the specified command
    docker_compose "$1" "$2"
fi

