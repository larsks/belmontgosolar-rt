#!/bin/sh

echo "Set(\$DatabaseHost,   'db');" >> $RTCONF
echo "Set(\$DatabaseRTHost, 'localhost');" >> $RTCONF

if [ "$DB_ENV_MYSQL_PASSWORD" != "" ]; then
	echo "[i] detected mysql"
	/scripts/configure-mysql.sh
elif [ "$DB_ENV_POSTGRES_PASSWORD"  != "" ]; then
	echo "[i] detected postgres"
	/scripts/configure-postgres.sh
else
	echo "[i] no database detected; defaulting to sqlite"
	/scripts/configure-sqlite.sh
fi
