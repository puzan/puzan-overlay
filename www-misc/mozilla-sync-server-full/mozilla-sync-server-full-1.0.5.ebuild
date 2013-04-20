# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /usr/local/portage/www-misc/mozilla-sync-server-full/RCS/mozilla-sync-server-full-1.0.5.ebuild,v 1.1 2013/04/19 18:27:50 root Exp root $

EAPI=5
PYTHON_COMPAT=(python2_{6,7})

inherit distutils-r1 mercurial

DESCRIPTION="Mozilla Sync Server"
HOMEPAGE="https://hg.mozilla.org/services/server-full"

EHG_REPO_URI="https://hg.mozilla.org/services/server-full"

case ${PV} in
9999)
	EHG_REVISION="default"
	;;
*)
	inherit versionator
	MY_PV=$(replace_version_separator 2 '-' "${PV}")
	MY_P="${PN}-${MY_PV}"
	EHG_QUIET="OFF"
	EHG_REVISION="rpm-${MY_PV}"
	S="${WORKDIR}/${PN}"
	;;
esac

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap memcached mysql sqlite +wsgi"

REQUIRED_USE="|| ( ldap memcached mysql sqlite )"

RDEPEND="www-misc/mozilla-sync-server-reg[${PYTHON_USEDEP}]
		 www-misc/mozilla-sync-server-storage[${PYTHON_USEDEP},ldap?,mysql?,sqlite?]
		 wsgi? (
			|| ( www-apache/mod_wsgi www-servers/uwsgi[python] )
		 )"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]"

MOZILLA_SYNC_DIR="/var/lib/mozilla-sync-server"

pkg_setup() {
	enewgroup mozillasync
	enewuser mozillasync -1 -1 "${MOZILLA_SYNC_DIR}" mozillasync
}

src_prepare() {
	sed -i 's_file:%(here)s/etc/_file:%(here)s/_' *.ini
}

src_install() {
	distutils-r1_src_install

	keepdir /etc/mozilla-sync-server
	insinto /etc/mozilla-sync-server
	use ldap && (
		doins etc/ldap.conf
		newins tests_ldap.ini ldap.ini

		use memcached && (
			doins etc/memcachedldap.conf
			newins tests_memcachedldap.ini memcached_ldap.ini
		)
	)
	use memcached && (
		doins etc/memcached.conf
		newins tests_memcached.ini memcached.ini
	)
	use mysql && (
		doins etc/mysql.conf
		newins tests_mysql.ini mysql.ini
	)
	use sqlite && (
		newins etc/sync.conf sqlite.conf
		newins development.ini sqlite.ini
	)
	use wsgi && newins sync.wsgi server.wsgi

	newinitd "${FILESDIR}/${PN}.initd" mozilla-sync-server || die
	keepdir /var/run/mozilla-sync || die
	fowners -R mozillasync:mozillasync /var/run/mozilla-sync || die
}
