#!/bin/sh

echo "Set(\$DatabaseType, 'mysql');" >> $RTCONF
echo "Set(\$DatabaseUser, '$DB_ENV_MYSQL_USER');" >> $RTCONF
echo "Set(\$DatabasePassword, '$DB_ENV_MYSQL_PASSWORDr');" >> $RTCONF
echo "Set(\$DatabaseName, '$DB_ENV_MYSQL_DATABASE');" >> $RTCONF

/scripts/wait-for-mysql
