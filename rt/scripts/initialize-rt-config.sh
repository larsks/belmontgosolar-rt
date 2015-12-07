#!/bin/sh

if ! [ -f "$RTCONF" ]; then
	echo "Set(\$rtname, '$RT_RTNAME');" >> $RTCONF
	echo "Set(\$Organization, '$RT_ORGANIZATION');" >> $RTCONF
	echo "Set(\$CorrespondAddress, '$RT_CORRESPONDADDRESS');" >> $RTCONF
	echo "Set(\$CommentAddress, '$RT_COMMENTADDRESS');" >> $RTCONF
	echo "Set(\$WebDomain, '$RT_WEBDOMAIN');" >> $RTCONF
	echo "Set(\$SendmailPath, '/usr/bin/msmtp');" >> $RTCONF

	if echo "$RT_RESTRICTREFERRER" | egrep -qi 'false|off|no'; then
		echo "Set(\$RestrictReferrer, '0');" >> $RTCONF
	fi
fi
