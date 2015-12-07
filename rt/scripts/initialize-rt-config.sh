#!/bin/sh

(
echo "Set(\$rtname, '$RT_RTNAME');" 
echo "Set(\$Organization, '$RT_ORGANIZATION');" 
echo "Set(\$CorrespondAddress, '$RT_CORRESPONDADDRESS');" 
echo "Set(\$CommentAddress, '$RT_COMMENTADDRESS');" 
echo "Set(\$WebDomain, '$RT_WEBDOMAIN');" 
echo "Set(\$SendmailPath, '/usr/bin/msmtp');" 

if echo "$RT_RESTRICTREFERRER" | egrep -qi 'false|off|no'; then
	echo "Set(\$RestrictReferrer, '0');" 
fi

echo "Set(\$DatabaseHost,   'db');" 
echo "Set(\$DatabaseRTHost, 'localhost');" 
) > $RTCONFDIR/00-initial-config.pl
