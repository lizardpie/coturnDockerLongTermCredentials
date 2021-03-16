#!/bin/bash

echo "Starting TURN/STUN server"

turnserver ${TURN_FLAGS} \
    -L ${TURN_LISTEN_IP} \
    -X ${TURN_EXTERNAL_IP} \
    --realm="${TURN_REALM}" \
    --server-name="${TURN_SERVER_NAME}" \
    --static-auth-secret="${TURN_SECRET}" \
    --cert="${TURN_CERT}" \
    --pkey="${TURN_PKEY}" \
    -p ${TURN_PORT} \
    --tls-listening-port=${TURN_TLS_PORT} \
    --min-port ${TURN_PORT_START} \
    --max-port ${TURN_PORT_END} \
    ${TURN_EXTRA}
