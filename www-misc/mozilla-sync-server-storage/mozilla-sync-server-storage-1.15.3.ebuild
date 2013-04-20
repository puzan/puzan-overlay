# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=(python2_{6,7})

inherit distutils-r1 eutils mercurial

DESCRIPTION="Mozilla Sync Storage Server"
HOMEPAGE="https://hg.mozilla.org/services/server-storage/"

EHG_REPO_URI="https://hg.mozilla.org/services/server-storage"

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
IUSE="ldap memcached mysql sqlite test"

REQUIRED_USE="|| ( ldap memcached mysql sqlite )"

RDEPEND=">=dev-python/metlog-py-0.1[${PYTHON_USEDEP}]
		 >=dev-python/paste-1.7.5.1
		 >=dev-python/pastedeploy-1.5.0
		 ldap? ( dev-python/python-ldap )
		 memcached? ( >=dev-python/python-memcached-1.48 )
		 mysql? ( >=dev-python/sqlalchemy-0.7.9[mysql] )
		 sqlite? ( >=dev-python/sqlalchemy-0.7.9[sqlite] )
		 www-misc/mozilla-sync-server-core[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
		test? ( dev-python/nose[${PYTHON_USEDEP}] >=dev-python/webtest-1.3.3 )
		dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
