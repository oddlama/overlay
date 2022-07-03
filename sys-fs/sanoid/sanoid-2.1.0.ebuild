# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Policy-driven snapshot management and replication tools."
HOMEPAGE="https://github.com/jimsalterjrs/sanoid"
SRC_URI="https://github.com/jimsalterjrs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DOCS="CHANGELIST README.md sanoid.conf"

RDEPEND=">=dev-lang/perl-5.30
	dev-perl/Config-IniFiles
	dev-perl/Capture-Tiny
	sys-apps/pv
	virtual/ssh
	app-arch/lzop
	sys-block/mbuffer
	app-arch/gzip"

src_install() {
	einstalldocs
	dobin sanoid syncoid findoid sleepymutex
	insinto /etc/sanoid
	doins sanoid.defaults.conf
}

pkg_postinst() {
	elog "Please refer to the provided example configuration in /usr/share/doc/${PF}"
	elog "and create your own /etc/sanoid/sanoid.conf from that template."
	elog "Afterwards start sanoid by activating the systemd timer:"
	elog ""
	elog "  systemctl enable --now sanoid.timer"
	elog ""
}
