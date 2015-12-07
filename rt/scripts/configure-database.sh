#!/bin/sh

if [ "$DB_ENV_MYSQL_PASSWORD" != "" ]; then
	echo "[i] detected mysql"
	_DBTYPE=mysql
elif [ "$DB_ENV_POSTGRES_PASSWORD"  != "" ]; then
	echo "[i] detected postgres"
	_DBTYPE=pg
else
	echo "[i] no database detected; defaulting to sqlite"
	_DBTYPE=sqlite
fi

/scripts/db/$_DBTYPE/config
/scripts/db/$_DBTYPE/wait
