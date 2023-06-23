#!/bin/bash
set -e
set -f

if [ ! -f /var/www/fbtools/config/config.php ]; then
  echo "Create Config from Base..."
  cp -r /var/www/fbtools/config-base /var/www/fbtools/config
  chmod 755 /var/www/fbtools/config
fi

ls -al /var/www/fbtools/config
chown -R www-data:www-data /var/www/fbtools/config

echo "Create Crontab config"
printenv | cat - /var/www/fbtools/config/crontab > temp && mv temp /etc/crontab
crontab /etc/crontab
/etc/init.d/cron start

echo "Run Webservice"
docker-php-entrypoint --apache-foreground
