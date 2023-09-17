#!/bin/bash
set -e

#Check linux distro
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
    echo "Usage: $0 [command] (optional container_name)"
    echo "Commands:"
    echo "  build - Build containers (optional: specify container_name)"
    echo "  up - Start containers (optional: specify container_name)"
    echo "  start - Start containers (optional: specify container_name)"
    echo "  down - Stop and remove containers (optional: specify container_name)"
    echo "  destroy - Stop, remove containers, and remove volumes (optional: specify container_name)"
    echo "  stop - Stop containers (optional: specify container_name)"
    echo "  restart - Restart containers (optional: specify container_name)"
    echo "  logs - Show container logs (optional: specify container_name)"
    echo "  ps - List containers"
    echo "  login-timescale - Log in to the TimescaleDB container"
    echo "  login-api - Log in to the API container"
    echo "  db-shell - Open a database shell in the TimescaleDB container"
    echo "  menu - Enter to interactive menu"
    echo "  --help, -h - Display this help message"
}

# ... (reszta funkcji pozostaje taka sama)

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
        echo "9. PS"
        echo "10. Login to TimescaleDB Container"
        echo "11. Login to API Container"
        echo "12. Database Shell (TimescaleDB)"
        echo "0. Exit"
        echo "--help, -h - Display this help message"

        read -p "Enter your choice: " choice

        case "$choice" in
            1) read -p "Enter container name (or press Enter for default): " container_name
               build "$container_name" ;;
            2) read -p "Enter container name (or press Enter for default): " container_name
               up "$container_name" ;;
            3) read -p "Enter container name (or press Enter for default): " container_name
               start "$container_name" ;;
            4) read -p "Enter container name (or press Enter for default): " container_name
               down "$container_name" ;;
            5) read -p "Enter container name (or press Enter for default): " container_name
               destroy "$container_name" ;;
            6) read -p "Enter container name (or press Enter for default): " container_name
               stop "$container_name" ;;
            7) read -p "Enter container name (or press Enter for default): " container_name
               restart "$container_name" ;;
            8) read -p "Enter container name (or press Enter for default): " container_name
               logs "$container_name" ;;
            9) ps ;;
            10) login-timescale ;;
            11) login-api ;;
            12) db-shell ;;
            0) exit ;;
            "--help" | "-h") display_help ;;
            *) echo "Invalid choice. Please try again." ;;
        esac

        read -p "Press Enter to continue..."
    done
else
    # If "menu" is not in the script name, execute the specified command
    case "$1" in
        "build") build "$2" ;;
        "up") up "$2" ;;
        "start") start "$2" ;;
        "down") down "$2" ;;
        "destroy") destroy "$2" ;;
        "stop") stop "$2" ;;
        "restart") restart "$2" ;;
        "logs") logs "$2" ;;
        "ps") ps ;;
        "login-timescale") login-timescale ;;
        "login-api") login-api ;;
        "db-shell") db-shell ;;
        "--help" | "-h") display_help ;;
        *) echo "Invalid command. Use --help or -h for available commands." ;;
    esac
fi
