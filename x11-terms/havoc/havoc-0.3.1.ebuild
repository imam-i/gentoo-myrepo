# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit

DESCRIPTION="A minimal terminal emulator for Wayland on Linux."
HOMEPAGE="https://github.com/ii8/havoc"
SRC_URI="https://github.com/ii8/${PN}/archive/refs/tags/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE=""

#RDEPEND="
#	>=media-libs/freetype-2.10
#	x11-libs/libxkbcommon[wayland?]
#	media-libs/fontconfig
#	virtual/opengl
#	libutf8proc? ( dev-libs/libutf8proc )
#	libnotify? ( x11-libs/libnotify )
#"
#DEPEND="${RDEPEND}"

#IUSE='X wayland libutf8proc libnotify'

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
#RESTRICT="strip"

# Run-time dependencies. Must be defined to whatever this depends on to run.
# Example:
#    ssl? ( >=dev-libs/openssl-1.0.2q:0= )
#    >=dev-lang/perl-5.24.3-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
#RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
# being built (CHOST). These include libraries that we link against.
# The below is valid if the same run-time depends are required to compile.
#DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
# only need to be present in the native build system (CBUILD). Example:
#BDEPEND="virtual/pkgconfig"

src_compile() {
	emake
}

src_install() {
	install -DZ ./havoc -t "${D}/usr/bin"
	install -DZ ./havoc.cfg -m 644 -t "${D}/usr/share/havoc"
	install -DZ ./LICENSE -m 644 -t "${D}/usr/share/havoc"
}
