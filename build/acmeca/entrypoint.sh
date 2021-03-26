#!/bin/sh

#export CONFIG_FILE=${CONFIG_FILE-"/home/step/config/ca.json"}
#export PASSWORD_FILE=${PASSWORD_FILE-"/home/step/secrets/password"}
#export PASSWORD="password"
#export DNS_ROOT="ca.internal"
#export AUTHORITY_NAME="Fake Authority"


if [[ ! -f "${PASSWORD_FILE}" ]]; then
  mkdir -p $(dirname $PASSWORD_FILE)
  echo $PASSWORD > $PASSWORD_FILE
fi

if [ -f "${CONFIG_FILE}" ]; then
  echo "Using existing configuration file"
else
  echo "No configuration file found at ${CONFIG_FILE}"

  echo "Executing 'step ca init --name '${AUTHORITY_NAME}' --provisioner admin --dns '${DNS_ROOT}' --address ':443' --password-file='${PASSWORD_FILE}'"

  /usr/local/bin/step ca init --name "${AUTHORITY_NAME}" --provisioner admin --dns "${DNS_ROOT}" --address ":443" --password-file=${PASSWORD_FILE}

  /usr/local/bin/step ca provisioner add ${CA_AREA} --type ACME

  # Increase certificate validity period
  #echo $(cat config/ca.json | jq '.authority.provisioners[[.authority.provisioners[] | .name=="${CA_AREA}"] | index(true)].claims |= (. + {"maxTLSCertDuration":"21600h","defaultTLSCertDuration":"7200h"})') > config/ca.json
  sed -i "/\"authority\"\: {/a \"claims\":{\"maxTLSCertDuration\": \"17520h\",\"defaultTLSCertDuration\":\"17520h\"}," config/ca.json


fi


exec "$@"