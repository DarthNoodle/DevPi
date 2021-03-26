FROM smallstep/step-ca:latest AS ca

FROM smallstep/step-cli:latest

# We need root access to bind port 443
USER root

RUN apk --update add jq && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

ENV CONFIG_FILE="/home/step/config/ca.json"
ENV PASSWORD_FILE="/home/step/secrets/password"
ENV PASSWORD="password"
ENV DNS_ROOT="ca.internal"
ENV AUTHORITY_NAME="Fake Authority"
ENV CA_AREA = "Production"

COPY entrypoint.sh /usr/local/src/entrypoint.sh
RUN chmod +x /usr/local/src/entrypoint.sh

COPY --chown=step:step --from=ca /usr/local/bin/step-ca /usr/local/bin/step-ca

ENTRYPOINT ["/usr/local/src/entrypoint.sh"]

CMD exec /bin/sh -c "/usr/local/bin/step-ca --password-file $PASSWORD_FILE $CONFIG_FILE"