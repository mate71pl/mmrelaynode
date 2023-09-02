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

# Sprawdzamy, czy docker działa poprzez listowanie kontenerów
if ! docker ps | grep -q "CONTAINER"; then
    echo "================================================================================"
    echo "If you see this error, type 'newgrp docker' and check if 'docker ps' returns an error."
    echo "Or log out and log in for the changes to take effect."
    echo "After this re-enable the script."
    exit 1
fi

# Pozostała część skryptu
echo "jedziemy"
#docker compose -f "docker-compose.yaml" up -d --build
