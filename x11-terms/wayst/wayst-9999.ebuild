# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="Simple terminal emulator for Wayland and X11 with OpenGL rendering."
HOMEPAGE="https://github.com/91861/wayst"
EGIT_REPO_URI="https://github.com/91861/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE='X wayland libutf8proc libnotify'

RDEPEND="
	>=media-libs/freetype-2.10
	x11-libs/libxkbcommon[wayland?]
	media-libs/fontconfig
	virtual/opengl
	libutf8proc? ( dev-libs/libutf8proc )
	libnotify? ( x11-libs/libnotify )
"
DEPEND="${RDEPEND}"

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
	if use X && use wayland; then
		unset window_protocol
	elif use wayland; then
		export window_protocol=wayland
	elif use X; then
		window_protocol=x11
	fi

	emake
}

src_install() {
	install -d "${D}/usr/bin"
	emake INSTALL_DIR="${D}/usr/bin" install

	install -Dm 644 LICENSE "${D}/usr/share/wayst/"
	install -Dm 644 config.example "${D}/usr/share/wayst/"
	install -Dm 755 install_desktop_file.sh "${D}/usr/share/wayst/"
	install -Dm 755 uninstall_desktop_file.sh "${D}/usr/share/wayst/"
	install -Dm 644 icons/pngs/48.png "${D}/usr/share/icons/hicolor/48x48/wayst.png"
	install -Dm 644 icons/pngs/192.png "${D}/usr/share/icons/hicolor/192x192/wayst.png"
	install -Dm 644 icons/pngs/512.png "${D}/usr/share/icons/hicolor/512x512/wayst.png"
}

pkg_postinst() {
	/usr/share/wayst/install_desktop_file.sh
}

pkg_prerm() {
	/usr/share/wayst/uninstall_desktop_file.sh
}
