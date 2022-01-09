# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="interactive git with the help of fzf"
HOMEPAGE="https://github.com/bigH/git-fuzzy"
EGIT_REPO_URI="https://github.com/bigH/git-fuzzy"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

DEPEND="
	>=app-shells/fzf-0.20.0
	sys-devel/bc
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/00-libdir-location.patch"
)

src_install() {
	dobin bin/git-fuzzy
	insinto "usr/share/${PN}"
	doins -r "lib/"*
}

pkg_postinst() {
	einfo "See ${HOMEPAGE} for environment variables configuration."
	einfo "You may also consider installing the following:"
	einfo "  - dev-util/git-delta (better diff) or diff-so-fancy (available from 0bs1d1an overlay)"
	einfo "  - sys-apps/bat (cat/less replacement with syntax highlighting)"
	einfo "  - sys-apps/exa (colorful ls)"
}
