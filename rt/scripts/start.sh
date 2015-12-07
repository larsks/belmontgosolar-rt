#!/bin/sh

# exit on errors
set -e

RTCONF="/opt/rt4/etc/RT_SiteConfig.pm"
export RTCONF

PATH=/opt/rt4/sbin:/opt/rt4/bin:$PATH
export PATH

/scripts/initialize-rt-config.sh
/scripts/configure-msmtp.sh
/scripts/configure-getmail.sh
/scripts/configure-database.sh

cat >> $RTCONF <<EOF
1;
EOF

/scripts/initialize-db-schema.sh

systemctl enable httpd
systemd-machine-id-setup

echo "[i] starting services"
exec /sbin/init
