#!/bin/sh

mkdir -p /etc/getmail

if echo "${GETMAIL_USE_SSL:-on}" | egrep -qi 'true|on|yes'; then
	_retriever=SimplePOP3SSLRetriever
else
	_retriever=SimplePOP3Retriever
fi

cat > /etc/getmailrc <<EOF
[retriever]
type = $_retriever
server = $GETMAIL_HOST
username = $GETMAIL_USER
password = $GETMAIL_PASS

[destination]
type = MDA_external
path = /opt/rt4/bin/rt-mailgate
arguments = ("--url", "http://localhost/", "--queue", "General", "--action", "correspond")
EOF

cat > /etc/systemd/system/rt-getmail.service <<EOF
[Unit]
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/getmail -r /etc/getmailrc -g /var/lib/getmail -v
User=apache
Group=apache
EOF

cat > /etc/systemd/system/rt-getmail.timer <<EOF
[Timer]
OnCalendar=*:0/5

[Install]
WantedBy=multi-user.target
EOF

mkdir /var/lib/getmail
chown apache:apache /var/lib/getmail
systemctl enable rt-getmail.timer
