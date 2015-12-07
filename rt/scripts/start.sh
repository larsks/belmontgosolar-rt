#!/bin/sh

# exit on errors
set -e

RTCONF="/opt/rt4/etc/RT_SiteConfig.pm"
export RTCONF

PATH=/opt/rt4/sbin:/opt/rt4/bin:$PATH
export PATH

DBFLAGFILE=/opt/rt4/etc/db_initialized

/scripts/initialize-rt-config.sh
/scripts/configure-msmtp.sh
/scripts/configure-getmail.sh

if [ "$SKIP_DB_INIT" = 1 ]; then
	echo skipped > $DBFLAGFILE
fi

if [ ! -f "$DBFLAGFILE" ]; then
	/scripts/configure-database.sh

	cat >> $RTCONF <<-EOF
	1;
	EOF

	rt-setup-database --action init --skip-create &&
		date > $DBFLAGFILE
fi

systemctl enable httpd

echo "[i] starting services"
exec /sbin/init
