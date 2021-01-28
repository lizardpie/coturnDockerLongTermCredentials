#! /usr/bin/env bash

secret=${1:-davesecret}
time=$(date +%s)
expiry=24*3600

username=$(( $time + $expiry ))

echo secret: $secret
echo time: $time
echo expiry: $expiry
echo username: $username
echo password: $(echo -n $username | openssl dgst -binary -sha1 -hmac $secret | openssl base64)

