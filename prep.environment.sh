#!/bin/bash


rm -rf build/keycloak
rm -rf tmp/keycloak

mkdir -p tmp/keycloak
mkdir -p build/keycloak
git clone https://github.com/keycloak/keycloak-containers.git tmp/keycloak

# Convert to Debian based OS
sed -i "/^RUN microdnf/a RUN apt update && apt -y install curl gzip hostname openssl tar && apt -y install openjdk-11-jdk-headless" tmp/keycloak/server/Dockerfile
sed -i "s/RUN microdnf/#RUN microdnf/g" tmp/keycloak/server/Dockerfile
sed -i "s/FROM registry.access.redhat.com\/ubi8-minimal/FROM debian/g" tmp/keycloak/server/Dockerfile

sed -i "s/microdnf/apt/g" tmp/keycloak/server/tools/build-keycloak.sh



cp -R tmp/keycloak/server/* build/keycloak

mkdir -p traefik/acme
touch traefik/traefik.log
touch traefik/root_ca.crt
touch traefik/acme/acme.json
chmod 600 traefik/acme/acme.json

mkdir -p registry/certs
mkdir -p acmeca