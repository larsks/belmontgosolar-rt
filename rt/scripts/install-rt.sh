#!/bin/sh

set -e

curl -L -o /tmp/rt-$RT_VERSION.tar.gz $RT_BASEURL/rt-$RT_VERSION.tar.gz
tar -xvz -C /tmp -f /tmp/rt-$RT_VERSION.tar.gz

(
cd /tmp/rt-$RT_VERSION
(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan

./configure --with-web-user=apache --with-web-group=apache
make fixdeps
make install
)

mkdir -p /opt/rt4/var/data/RT-Shredder
chown apache:apache /opt/rt4/var/data/RT-Shredder

rm -rf /tmp/rt-$RT_VERSION rt-$RT_VERSION.tar.gz /opt/rt4/etc/RT_SiteConfig.pm
