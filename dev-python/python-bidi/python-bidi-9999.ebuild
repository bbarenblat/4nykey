# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
CRATES="
	heck@0.5.0
	libc@0.2.155
	once_cell@1.21.3
	portable-atomic@1.6.0
	proc-macro2@1.0.86
	pyo3-build-config@0.29.0
	pyo3-ffi@0.29.0
	pyo3-macros-backend@0.29.0
	pyo3-macros@0.29.0
	pyo3@0.29.0
	quote@1.0.45
	syn@2.0.70
	target-lexicon@0.13.3
	unicode-bidi@0.3.18
	unicode-ident@1.0.12
"
inherit cargo distutils-r1
if [[ -z ${PV%%*9999} ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MeirKriheli/${PN}.git"
else
	MY_PV="fc0bb57"
	[[ -n ${PV%%*_p*} ]] && MY_PV="v${PV}"
	SRC_URI="
		mirror://githubcl/MeirKriheli/${PN}/tar.gz/${MY_PV} -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	RESTRICT="primaryuri"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${MY_PV#v}"
fi
RESTRICT+=" test"

DESCRIPTION="BiDi layout implementation in pure python"
HOMEPAGE="https://python-bidi.readthedocs.org"

LICENSE="LGPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions Unicode-DFS-2016
	|| ( Apache-2.0 MIT )
"
SLOT="0"
distutils_enable_tests pytest
