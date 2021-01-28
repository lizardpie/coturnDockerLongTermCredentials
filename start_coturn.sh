#!/bin/bash

echo "Starting TURN/STUN server"

turnserver ${TURN_FLAGS} -v -L ${TURN_LISTEN_IP} -X ${TURN_EXTERNAL_IP} --server-name "${TURN_SERVER_NAME}" --static-auth-secret="${TURN_SECRET}" --realm=${TURN_REALM} -p ${TURN_PORT} --min-port ${TURN_PORT_START} --max-port ${TURN_PORT_END} ${TURN_EXTRA}
