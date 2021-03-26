#!/bin/sh

docker-compose -f docker-compose.yml down

rm traefik/acme/acme.json
touch traefik/acme/acme.json
chmod 600 traefik/acme/acme.json

rm traefik/traefik.log
touch traefik/traefik.log

rm traefik/root_ca.crt
touch traefik/root_ca.crt

rm traefik/acme/acme.json
touch traefik/acme/acme.json


rm -rf acmeca
mkdir acmeca

docker-compose -f docker-compose.yml up -d
#sleep 5

docker-compose -f docker-compose.yml down

#AcmeCA bug.. internal DB needs to be updated to v2 manually
sed -i "s/badger/badgerV2/g" acmeca/config/ca.json

rm -rf acmeca/db/
mkdir acmeca/db

cp acmeca/certs/root_ca.crt traefik/root_ca.crt

mkdir -p registry/certs
rm registry/root_ca.crt
cp acmeca/certs/root_ca.crt registry/certs/root_ca.crt

docker-compose -f docker-compose.yml up -d