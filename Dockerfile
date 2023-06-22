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

ENV TZ="Europe/Berlin"

RUN apt-get --quiet --yes --no-install-recommends update && \
    apt-get dist-upgrade --quiet --yes --no-install-recommends && \
    apt-get install --quiet --yes --no-install-recommends \
      gdebi-core \
      wget && \
    wget -O fb-tools.deb 'http://mengelke.de'`wget -qO- http://mengelke.de/Projekte/FritzBox-Tools.html | grep -aoE '/Projekte/FritzBox;fb-tools.deb\?[a-f0-9]+'` && \
    ls -al && \
    dpkg -i --force-depends fb-tools.deb && \
    rm -rf fb-tools.deb && \
    ln -s /usr/local/bin/php /usr/bin/php && \
    touch /var/www/html/index.html
