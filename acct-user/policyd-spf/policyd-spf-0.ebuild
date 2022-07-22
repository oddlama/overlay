# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for policyd-spf"
ACCT_USER_ID=412
ACCT_USER_GROUPS=( policyd-spf )
acct-user_add_deps
