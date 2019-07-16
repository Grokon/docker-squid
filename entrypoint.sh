#!/usr/bin/env sh

set -e

# check if ssl generated crts dir is to be created
if [ ! -d /var/lib/squid/ssl_db ] ; then
  mkdir -p /var/lib/squid/
  /usr/lib/squid/security_file_certgen -c -s /var/lib/squid/ssl_db -M 4MB
  chown squid:squid -R /var/lib/squid/
fi

#make cache
/usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -z
