# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="Ly - a TUI display manager."
HOMEPAGE="https://github.com/nullgemm/ly"
EGIT_REPO_URI="https://github.com/nullgemm/${PN}.git"
EGIT_COMMIT="v${PV}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X wayland systemd"

RDEPEND="x11-libs/libxcb"
#    >=media-libs/freetype-2.10
#    x11-libs/libxkbcommon[wayland?]
#    media-libs/fontconfig
#    virtual/opengl
#    libutf8proc? ( dev-libs/libutf8proc )
#    libnotify? ( x11-libs/libnotify )
#"
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
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	find "${D}/etc/" -type f -name '*.ini' -exec chmod 644 {} \;

	sed -e '/^#tty = /c tty = 1' \
		-e '/^#save = /c save = false' \
		-i "${D}/etc/ly/config.ini"

	sed -e '/^exec $@/c exec dbus-run-session $@' \
		-i "${D}/etc/ly/wsetup.sh"

	if use wayland; then
		sed -e '/^#wayland_cmd = /c wayland_cmd = /etc/ly/wsetup.sh' \
			-e '/^#wayland_specifier = true/c wayland_specifier = true' \
			-e '/^#waylandsessions = /c waylandsessions = /usr/share/wayland-sessions' \
			-i "${D}/etc/ly/config.ini"
	fi

	if use X; then
		sed -e '/^#x_cmd = /c x_cmd = /usr/bin/X' \
			-e '/^#x_cmd_setup = /c x_cmd_setup = /etc/ly/xsetup.sh' \
			-e '/^#xauth_cmd = /c xauth_cmd = /usr/bin/xauth' \
			-e '/^#xsessions = /c xsessions = /usr/share/xsessions' \
			-i "${D}/etc/ly/config.ini"
	fi

	if ! use systemd; then
		rm -rf "${D}/usr/lib"
		install -DZ "${FILESDIR}/ly" -m 755 -t "${D}/etc/init.d"
	fi
}
