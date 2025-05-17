#!/bin/bash

# Variables
DEV_COMPOSE_FILE="docker/dev/docker-compose.dev.yml"
PREPROD_COMPOSE_FILE="docker/preprod/docker-compose.preprod.yml"
PROD_COMPOSE_FILE="docker/prod/docker-compose.prod.yml"

# Fonctions
function start_dev() {
    echo "Starting development environment..."
    docker-compose -f $DEV_COMPOSE_FILE up -d
    echo "Development environment started: http://localhost:8080"
}

function start_preprod() {
    echo "Starting pre-production environment..."
    docker-compose -f $PREPROD_COMPOSE_FILE up -d
    echo "Pre-production environment started: http://localhost:8081"
}

function start_prod() {
    echo "Starting production environment..."
    docker-compose -f $PROD_COMPOSE_FILE up -d
    echo "Production environment started: http://localhost:8082"
}

function stop_dev() {
    echo "Stopping development environment..."
    docker-compose -f $DEV_COMPOSE_FILE down
}

function stop_preprod() {
    echo "Stopping pre-production environment..."
    docker-compose -f $PREPROD_COMPOSE_FILE down
}

function stop_prod() {
    echo "Stopping production environment..."
    docker-compose -f $PROD_COMPOSE_FILE down
}

function rebuild_dev() {
    echo "Rebuilding development environment..."
    docker-compose -f $DEV_COMPOSE_FILE down
    docker-compose -f $DEV_COMPOSE_FILE build --no-cache
    docker-compose -f $DEV_COMPOSE_FILE up -d
}

function rebuild_preprod() {
    echo "Rebuilding pre-production environment..."
    docker-compose -f $PREPROD_COMPOSE_FILE down
    docker-compose -f $PREPROD_COMPOSE_FILE build --no-cache
    docker-compose -f $PREPROD_COMPOSE_FILE up -d
}

function rebuild_prod() {
    echo "Rebuilding production environment..."
    docker-compose -f $PROD_COMPOSE_FILE down
    docker-compose -f $PROD_COMPOSE_FILE build --no-cache
    docker-compose -f $PROD_COMPOSE_FILE up -d
}

# Menu principal
case "$1" in
    dev)
        case "$2" in
            start)
                start_dev
                ;;
            stop)
                stop_dev
                ;;
            rebuild)
                rebuild_dev
                ;;
            *)
                echo "Usage: $0 dev {start|stop|rebuild}"
                ;;
        esac
        ;;
    preprod)
        case "$2" in
            start)
                start_preprod
                ;;
            stop)
                stop_preprod
                ;;
            rebuild)
                rebuild_preprod
                ;;
            *)
                echo "Usage: $0 preprod {start|stop|rebuild}"
                ;;
        esac
        ;;
    prod)
        case "$2" in
            start)
                start_prod
                ;;
            stop)
                stop_prod
                ;;
            rebuild)
                rebuild_prod
                ;;
            *)
                echo "Usage: $0 prod {start|stop|rebuild}"
                ;;
        esac
        ;;
    *)
        echo "Usage: $0 {dev|preprod|prod} {start|stop|rebuild}"
        ;;
esac