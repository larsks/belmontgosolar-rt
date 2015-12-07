#!/bin/sh

DBFLAGFILE=/opt/rt4/etc/db_initialized

if [ ! -f "$DBFLAGFILE" ]; then
	if [ "$SKIP_DB_INIT" != 1 ]; then
		if ! rt-setup-database --action init --skip-create; then
			cat <<-EOF
			[!] failed to initialize database schema
			[i] but this is probably because it already exists, so continuing...
			EOF
		fi
	fi

	date > $DBFLAGFILE
fi


