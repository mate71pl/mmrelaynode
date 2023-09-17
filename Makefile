#sprawdź czy jest zainstalowany program docker i git jeśli nie zapytaj czy zainstalować ten którego nie ma
# Zbuduj i uruchom konteneryxds

.PHONY: help build up start down destroy stop restart logs logs-api ps login-timescale login-api db-shell
help:
        
build:
        docker compose -f docker-compose.yaml up -d --build #container-name #or empty for two
up:
        docker compose -f docker-compose.yml up -d #container-name #or empty for two
start:
        docker compose -f docker-compose.yml start #container-name #or empty for two
down:
        docker compose -f docker-compose.yml down #container-name #or empty for two
destroy:
        docker compose -f docker-compose.yml down -v #container-name #or empty for two
stop:
        docker compose -f docker-compose.yml stop #container-name #or empty for two
restart:
        docker compose -f docker-compose.yml stop #container-name #or empty for two
        docker compose -f docker-compose.yml up -d #container-name #or empty for two
logs:
        docker compose -f docker-compose.yml logs --tail=100 -f #container-name #or empty for two
logs-api:
        docker compose -f docker-compose.yml logs --tail=100 -f api
ps:
        docker compose -f docker-compose.yml ps
login-timescale:
        docker compose -f docker-compose.yml exec timescale /bin/bash
login-api:
        docker-compose -f docker-compose.yml exec api /bin/bash
db-shell:
        docker-compose -f docker-compose.yml exec timescale psql -Upostgres