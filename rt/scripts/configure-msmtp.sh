#!/bin/sh

: ${MSMTPRC:=/etc/msmtprc}
: ${SMTP_HOST:=localhost}
: ${SMTP_FROM:=rt@localhost}
: ${SMTP_TLS:=on}
: ${SMTP_TLS_STARTTLS:=on}

# Look for a trusted certificate bundle in a few places
if [ -z "$SMTP_TLS_TRUST_FILE" ]; then
	for bundle in /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt; do
		if [ -f "$bundle" ]; then
			SMTP_TLS_TRUST_FILE=$bundle
			break
		fi
	done
fi

cat > $MSMTPRC <<EOF
account rt
host $SMTP_HOST
port ${SMTP_PORT:=25}
from $SMTP_FROM

EOF

if echo "${SMTP_AUTH:=off}" | is_true; then
cat >> $MSMTPRC <<EOF
auth on
user $SMTP_USER
password $SMTP_PASS
EOF
fi

if echo "${SMTP_TLS:=off}" | is_true; then
cat >> $MSMTPRC <<EOF
tls on
tls_trust_file ${SMTP_TLS_TRUST_FILE}
tls_starttls $(echo ${SMTP_TLS_STARTTLS:=on} | is_true && echo on || echo off)
EOF
fi

cat >> $MSMTPRC <<EOF
account default : rt
EOF
