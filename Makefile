build:
	docker build -t coturn-long-term-cred .

start-host-a:
	docker run -d \
		--net=host \
		--name my-coturn \
		--env TURN_FLAGS="-a" \
		--env TURN_SECRET="davesecret" \
		--env TURN_REALM="dave.example.com" \
		--env TURN_LISTEN_IP="0.0.0.0" \
		--env TURN_EXTERNAL_IP="192.168.1.22" \
                --env TURN_PORT="3478" \
                --env TURN_PORT_START="49152" \
                --env TURN_PORT_END="65535" \
                --env TURN_EXTRA="" \
		coturn-long-term-cred

start-host-use:
	docker run -d \
                --net=host \
                --name my-coturn \
                --env TURN_FLAGS="--use-auth-secret" \
                --env TURN_SECRET="davesecret" \
                --env TURN_REALM="dave.example.com" \
                --env TURN_LISTEN_IP="0.0.0.0" \
                --env TURN_EXTERNAL_IP="192.168.1.22" \
                --env TURN_PORT="3478" \
                --env TURN_PORT_START="49152" \
                --env TURN_PORT_END="65535" \
                --env TURN_EXTRA="" \
                coturn-long-term-cred

start:
	docker run -d \
                --name my-coturn \
		-p 80:80 \
		-p 443:443 \
                -p 3478:3478 \
		-p 3478:3478/udp \
		-p 49160-49200:49160-49200/udp \
		--env TURN_FLAGS="--no-tls --no-dtls --use-auth-secret" \
                --env TURN_SECRET="davesecret" \
                --env TURN_REALM="dave.example.com" \
		--env TURN_LISTEN_IP="0.0.0.0" \
                --env TURN_EXTERNAL_IP="192.168.1.22" \
                --env TURN_PORT="3478" \
		--env TURN_PORT_START="49160" \
		--env TURN_PORT_END="49200" \
		--env TURN_EXTRA="" \
                coturn-long-term-cred

