#!/bin/sh

echo "[i] generating $RTCONF"

cat $RTCONFDIR/* > $RTCONF
cat >> $RTCONF <<EOF

1;
EOF

