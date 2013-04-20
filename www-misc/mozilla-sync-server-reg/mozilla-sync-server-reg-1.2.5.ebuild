# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=(python2_{6,7})

inherit distutils-r1 mercurial

DESCRIPTION="Mozilla Sync Reg Server"
HOMEPAGE="https://hg.mozilla.org/services/server-reg"

EHG_REPO_URI="https://hg.mozilla.org/services/server-reg"

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
IUSE="test"

RDEPEND=">=dev-python/beaker-1.6.4
		 >=dev-python/cef-0.5[${PYTHON_USEDEP}]
		 >=dev-python/mako-0.7.2
		 >=dev-python/markupsafe-0.15
		 www-misc/mozilla-sync-server-core[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
		test? ( dev-python/nose[${PYTHON_USEDEP}] )
		dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
