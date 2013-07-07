# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=4

inherit eutils autotools python

MY_P=seafile-${PV}
S="${WORKDIR}/${MY_P}/${PN}"

DESCRIPTION="RPC library for Seafile"
HOMEPAGE="http://www.seafile.com"
SRC_URI="http://seafile.googlecode.com/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="-demo"

DEPEND=">=dev-lang/python-2.5
	>=dev-libs/glib-2.0
	dev-util/pkgconfig"

RDEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	econf $(use_enable demo compile-demo) \
		--disable-glibtest \
		|| die "econf failed"
}

src_install() {
	#Fix wrong prefix in libsearpc.pc file
	sed -i 's/(DESTDIR)//' "${S}/libsearpc.pc"

	emake DESTDIR="${D}" install

	local d
	for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
			FAQ CREDITS CHANGELOG ; do
		[[ -s "${d}" ]] && dodoc "${d}"
	done
}
