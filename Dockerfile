FROM debian:stable
MAINTAINER 	Werner Dijkerman <ikben@werner-dijkerman.nl>

ENV VAULT_VERSION=0.6.0

RUN apt-get update && \
    apt-get install -y curl unzip bash net-tools ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sSLo /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip -d /bin /tmp/vault.zip && \
    rm -rf /tmp/vault.zip && \
    chmod +x /bin/vault && \
    mkdir /vault

ADD config.hcl /vault/config.hcl
ONBUILD ADD config.hcl /vault/config.hcl

EXPOSE 8200
ENV VAULT_ADDR "http://127.0.0.1:8200"

ENTRYPOINT ["/bin/vault"]
CMD ["server", "-config", "/vault/config.hcl"]
