# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="A python based postfix policy engine for Sender Policy Framework (SPF) checking"
HOMEPAGE="https://launchpad.net/pypolicyd-spf"
SRC_URI="http://launchpad.net/pypolicyd-spf/$(ver_cut 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 riscv x86"
IUSE=""

DEPEND="
	acct-group/policyd-spf
	acct-user/policyd-spf
	dev-python/authres
	>=dev-python/pyspf-2.0.14"
RDEPEND="${DEPEND}"

DOCS="CHANGES policyd-spf.conf.commented README README.per_user_whitelisting"
