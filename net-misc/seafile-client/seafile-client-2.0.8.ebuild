# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime cmake-utils

DESCRIPTION="Seafile Client"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=net-misc/seafile-2.0.5[client]
	=net-libs/libsearpc-1.1.0
	=net-libs/ccnet-1.3.8
	dev-qt/qtgui:4
	dev-util/cmake
	dev-libs/jansson
	dev-util/desktop-file-utils"

RDEPEND=""

src_configure() {
	BUILD_DIR=${WORKDIR}/${P}
	cmake-utils_src_configure
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
