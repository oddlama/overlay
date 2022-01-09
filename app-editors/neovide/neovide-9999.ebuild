# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cargo git-r3

DESCRIPTION="No Nonsense Neovim Client in Rust"
HOMEPAGE="https://github.com/neovide/neovide"
EGIT_REPO_URI="https://github.com/neovide/neovide"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-editors/neovim
	virtual/rust
	media-libs/mesa
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
