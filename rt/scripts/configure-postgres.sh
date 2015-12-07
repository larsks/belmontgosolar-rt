#!/bin/sh

echo "Set(\$DatabaseType, 'Pg');" >> $RTCONF
echo "Set(\$DatabaseUser, '$DB_ENV_POSTGRES_USER');" >> $RTCONF
echo "Set(\$DatabasePassword, '$DB_ENV_POSTGRES_PASSWORD');" >> $RTCONF
echo "Set(\$DatabaseName, '$DB_ENV_POSTGRES_DB');" >> $RTCONF

/scripts/wait-for-postgres
