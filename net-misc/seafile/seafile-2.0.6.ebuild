# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils python

SEAFILE_VERSION=2.0.4-server
SEAFILE_TAG="v${SEAFILE_VERSION}"
S="${WORKDIR}/${PN}-${SEAFILE_VERSION}"

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/${SEAFILE_TAG}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-server client"

DEPEND=">=dev-lang/python-2.5[sqlite]
	net-libs/ccnet[client?,server?,python]
	dev-python/webpy
	dev-python/mako
	server? ( =net-libs/libevhtp-1.1.7
			  dev-python/django
			  dev-python/Djblets
			  www-servers/gunicorn
			  dev-python/chardet )
	sys-devel/gettext
	dev-util/pkgconfig"

RDEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf $(use_enable server) \
		$(use_enable client) \
		--enable-console \
		--enable-python \
		|| die "econf failed"

	# Fix problem with multitreading build
	MAKEOPTS="-j1"
}
