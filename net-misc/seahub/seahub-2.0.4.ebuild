# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

SEAFILE_HOME=/var/lib/seafile/seafile-server/seahub
SEAFILE_VERSION=2.0.4-server
SEAFILE_TAG="v${SEAFILE_VERSION}"
S="${WORKDIR}/${PN}-${SEAFILE_VERSION}"

DESCRIPTION="Web frontend for Seafile"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/${SEAFILE_TAG}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-python/django-1.5*
	=dev-python/Djblets-0.6*"

src_install() {
	insinto "${SEAFILE_HOME}"
	doins -r .

	fowners -R seafile:seafile "${SEAFILE_HOME}"
}
