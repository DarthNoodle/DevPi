# DevPi
Raspberry Pi Dev Environment (Traefik, Docker Registry, AcmeCA, DNS, Keycloak..) 

BASE OS: Ubuntu

#NOT FOR PROD USE... YET!!



prep.environment.sh  - run this to pull down KeyCloak GIT and modify to build on Debian, makes folders and touches files ready to bring up using docker-compose

reset.environment.sh - run this to wipe the certs, regenerate and copy them over to traefik for use, environment will come back up with new certs automatically
