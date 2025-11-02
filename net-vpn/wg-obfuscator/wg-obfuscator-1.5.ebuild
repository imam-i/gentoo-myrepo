# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit

DESCRIPTION="WireGuard Obfuscator is a tool designed to disguise WireGuard traffic as random data or a different protocol."
HOMEPAGE="https://github.com/ClusterM/wg-obfuscator"
SRC_URI="https://github.com/ClusterM/wg-obfuscator/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"

DEPEND=""
RDEPEND=""
BDEPEND=""

src_compile() {
    make
}

src_install() {
	dobin wg-obfuscator
    dodoc wg-obfuscator.conf
    dodoc README.md
    dodoc LICENSE
	newinitd "${FILESDIR}/wg-obfuscator.initd" wg-obfuscator
	keepdir /etc/wg-obfuscator
}
