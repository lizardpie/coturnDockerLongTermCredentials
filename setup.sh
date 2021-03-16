#! /usr/bin/env bash


function generate_env_file {
    ENV_FILE="./coturn.env"
    MIN_PORT="49152"
    MAX_PORT="65535"
    TURN_PORT="3478"

    echo "Setup coturn.env..."

    echo "TURN_FLAGS=-a" > $ENV_FILE
    echo "TURN_LISTEN_IP=0.0.0.0" >> $ENV_FILE
    echo "TURN_EXTERNAL_IP=${EXTERNAL_IP}" >> $ENV_FILE
    echo "TURN_SERVER_NAME=${TURN_SERVER_NAME}">> $ENV_FILE
    echo "TURN_REALM=${TURN_REALM}" >> $ENV_FILE
    echo "TURN_SECRET=${TURN_AUTH_SECRET}" >> $ENV_FILE
    echo "TURN_PORT=${TURN_PORT}" >> $ENV_FILE
    echo "TURN_PORT_START=${MIN_PORT}" >> $ENV_FILE
    echo "TURN_PORT_END=${MAX_PORT}" >> $ENV_FILE
    echo "TURN_EXTRA=" >> $ENV_FILE
}


if [[ $(which docker) ]] && [[ $(which docker-compose) ]]

  then
    echo "******************************"
    echo "* Coturn Configuration Setup *"
    echo "******************************"
    if [[ -f ./coturn.env ]]
    then
        echo "Coturn initial setup is already complete!"
        echo "To start/stop/cleanup coturn service:"
        echo "  - start: run ./start.sh"
        echo "  - stop: run ./stop.sh"
        echo "  - cleanup: run ./cleanup.sh"
        exit 0
    fi
    EXTERNAL_IP_D="$(curl -4 https://icanhazip.com 2>/dev/null)"
    read -e -p "Please enter your external IP (default is $EXTERNAL_IP_D): " EXTERNAL_IP
    # adopt the default, if 'enter' given
    EXTERNAL_IP="${EXTERNAL_IP:-${EXTERNAL_IP_D}}"

    read -e -p "Please enter the realm: " TURN_REALM

    read -e -p "Please enter the server name (default is $TURN_REALM): " TURN_SERVER_NAME
    # adopt the default, if 'enter' given
    TURN_SERVER_NAME="${TURN_SERVER_NAME:-${TURN_REALM}}"

    read -e -p "Please enter the authentication secret: " TURN_AUTH_SECRET

    generate_env_file
    ./start.sh

    echo 
    echo "**************************************"
    echo "* TURN Server Name: $TURN_SERVER_NAME "
    echo "* TURN Realm: $TURN_REALM "
    echo "* TURN External IP: $EXTERNAL_IP "
    echo "* TURN Auth Secret: $TURN_AUTH_SECRET "
    echo "**************************************"
    echo 
   else
    echo "Docker or Docker Compose not installed or not configured properly, please install it first and then try again."
fi

