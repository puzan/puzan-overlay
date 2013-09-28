# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=4

inherit eutils autotools python

MY_P=seafile-${PV}
S="${WORKDIR}/${MY_P}/${PN}"

DESCRIPTION="Networking library for Seafile"
HOMEPAGE="http://www.seafile.com"
SRC_URI="http://seafile.googlecode.com/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="-demo client server python cluster ldap -mysql"

DEPEND="=net-libs/libsearpc-${PV}
	>=dev-libs/glib-2.0
	server? ( dev-db/libzdb )
	dev-util/pkgconfig"

RDEPEND=""

src_configure() {
	econf $(use_enable demo compile-demo) \
		$(use_enable server) \
		$(use_enable client) \
		$(use_enable python) \
		$(use_enable cluster) \
		$(use_enable ldap) \
		$(use_enable mysql) \
		--enable-console \
		|| die "econf failed"

	# Fix problem with multitreading build
	MAKEOPTS="-j1"
}

src_install() {
	#Fix wrong prefix in libccnet.pc file
	sed -i 's/(DESTDIR)//' "${S}/libccnet.pc"

	emake DESTDIR="${D}" install
}
