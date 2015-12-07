FROM fedora

MAINTAINER Lars Kellogg-Stedman <lars@oddbit.com>

# https://download.bestpractical.com/pub/rt/release/rt-4.2.12.tar.gz
ENV RT_VERSION=4.2.12
ENV RT_BASEURL=https://download.bestpractical.com/pub/rt/release/
ENV container=docker

RUN mkdir -p /scripts/pre-exec.d && \
	mkdir /scripts/pre-init.d && \
	mkdir /scripts/pre-initdb.d && \
	mkdir /scripts/post-initdb.d && \
	chmod -R 755 /scripts

# You didn't think it was gonna be *that* easy, did you?  Fedora provides
# an RT package, but it doesn't include the Postgres schemas...so we install
# the `rt` package to get all the dependencies (except the missing ones, which
# we fix also), and then we *remove* rt so that we can proceed to install
# it from source.
RUN dnf -y install \
	rt \
	postgresql \
	mysql \
	httpd \
	mod_fcgid \
	tar \
	findutils \
	cronie \
	msmtp \
	perl-CPAN \
	perl-Date-Extract \
	perl-Date-Manip \
	perl-DateTime-Format-Natural \
	perl-FCGI-ProcManager \
	perl-Crypt-SSLeay \
	perl-Mozilla-CA \
	perl-LWP-Protocol-https \
	perl-libwww-perl \
	perl-Convert-Color \
	getmail \
	; \
	dnf --setopt clean_requirements_on_remove=false -y remove rt

COPY scripts /scripts
RUN sh /scripts/install-rt.sh

COPY config/rt.conf /etc/httpd/conf.d/rt.conf
COPY config/rt-update-index.service /etc/systemd/system/
COPY config/rt-update-index.timer /etc/systemd/system/

EXPOSE 80
EXPOSE 443
CMD ["/scripts/start.sh"]
