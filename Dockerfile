FROM php:8.1-apache

LABEL maintainer="Thoralf Rickert-Wendt <trw@acoby.de>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="docker.fritzbox-tools" \
      org.label-schema.vendor="acoby GmbH" \
      org.label-schema.url="https://github.com/trickert76/docker.fritzbox-tools" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.version=${BUILD_VERSION}

ENV TZ="Europe/Berlin" \
    FRITZ_BOX_URL="http://user:pass@192.168.178.1" \
    LAN_NETWORK="192.168.178.0/24"

ENV DB_HOST database \
    DB_PORT 3306 \
    DB_NAME database \
    DB_USER username \
    DB_PASS password

COPY app/ /

RUN apt-get --quiet --yes --no-install-recommends update && \
    apt-get dist-upgrade --quiet --yes --no-install-recommends && \
    apt-get install --quiet --yes --no-install-recommends \
      cron \
      gdebi-core \
      nmap \
      wget && \
    wget -O fb-tools.deb 'http://mengelke.de'`wget -qO- http://mengelke.de/Projekte/FritzBox-Tools.html | grep -aoE '/Projekte/FritzBox;fb-tools.deb\?[a-f0-9]+'` && \
    ls -al && \
    dpkg -i --force-depends fb-tools.deb && \
    rm -rf fb-tools.deb && \
    chmod 755 /usr/local/bin/*.sh && \
    ln -s /usr/local/bin/php /usr/bin/php

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

VOLUME /var/log

EXPOSE 80
