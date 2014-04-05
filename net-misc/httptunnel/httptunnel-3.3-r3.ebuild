# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httptunnel/httptunnel-3.3-r2.ebuild,v 1.4 2012/06/29 12:55:46 ranger Exp $

EAPI=4

inherit eutils toolchain-funcs user

DESCRIPTION="httptunnel can create IP tunnels through firewalls/proxies using HTTP"
HOMEPAGE="http://www.nocrew.org/software/httptunnel.html"
SRC_URI="http://www.nocrew.org/software/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND=""

pkg_preinst() {
	enewgroup httptunnel
	enewuser httptunnel -1 -1 -1 httptunnel
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix_write_stdin.patch
	tc-export CC
}

src_configure() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
}

src_install() {
	einstall || die "einstall failed"

	newinitd "${FILESDIR}/${PN}.initd" httptunnel || die
	newconfd "${FILESDIR}/${PN}.confd" httptunnel || die
}
