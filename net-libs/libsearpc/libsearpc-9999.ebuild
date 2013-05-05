# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=4

inherit eutils autotools git-2 python

DESCRIPTION="RPC library for Seafile"
HOMEPAGE="http://www.seafile.com"
EGIT_REPO_URI="git://github.com/haiwen/libsearpc.git"
S=${WORKDIR}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="demo"

DEPEND=">=dev-lang/python-2.5
	>=dev-libs/glib-2.0
	dev-util/pkgconfig"

RDEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf $(use_enable demo compile-demo) \
		--disable-glibtest \
		|| die "econf failed"
}

src_install() {
	#Fix wrong prefix in libsearpc.pc file
	cat "${S}/libsearpc.pc" | sed 's/(DESTDIR)//' > "${S}/libsearpc.pc_m"
	mv "${S}/libsearpc.pc_m" "${S}/libsearpc.pc"

	emake DESTDIR="${D}" install

	local d
	for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
			FAQ CREDITS CHANGELOG ; do
		[[ -s "${d}" ]] && dodoc "${d}"
	done
}

