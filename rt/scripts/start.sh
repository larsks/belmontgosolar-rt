#!/bin/sh

# exit on errors
set -e

RTCONF="/opt/rt4/etc/RT_SiteConfig.pm"
RTCONFDIR="/opt/rt4/etc/rt_siteconfig_parts"
export RTCONF RTCONFDIR

mkdir -p $RTCONFDIR

PATH=/opt/rt4/sbin:/opt/rt4/bin:$PATH
export PATH

is_true () {
	egrep -qi 'true|on|yes'
}

. /scripts/initialize-rt-config.sh
. /scripts/configure-msmtp.sh
. /scripts/configure-getmail.sh
. /scripts/configure-database.sh

# we need this before we can call rt-setup-database
. /scripts/generate-rt-siteconfig.sh

. /scripts/initialize-db-schema.sh
. /scripts/db/$_DBTYPE/install-fts

# we need to re-generate the config after we add in
# the fts configuration
. /scripts/generate-rt-siteconfig.sh

systemctl enable httpd
systemd-machine-id-setup

echo "[i] starting services"
exec /sbin/init
