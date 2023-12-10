# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.10

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.6
	aho-corasick@1.1.2
	amdgpu-sysfs@0.12.4
	anstream@0.6.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.4
	anyhow@1.0.75
	ash@0.37.3+1.3.251
	async-broadcast@0.5.1
	async-channel@2.1.0
	async-io@1.13.0
	async-io@2.2.0
	async-lock@2.8.0
	async-lock@3.1.1
	async-process@1.8.1
	async-recursion@1.0.5
	async-signal@0.2.5
	async-task@4.5.0
	async-trait@0.1.74
	atomic-waker@1.1.2
	autocfg@1.1.0
	backtrace@0.3.69
	bincode@1.3.3
	bitflags@1.3.2
	bitflags@2.4.1
	block-buffer@0.10.4
	blocking@1.5.1
	bytemuck@1.14.0
	bytemuck_derive@1.5.0
	byteorder@1.5.0
	bytes@1.5.0
	cairo-rs@0.18.3
	cairo-sys-rs@0.18.2
	cc@1.0.83
	cfg-expr@0.15.5
	cfg-if@1.0.0
	clap@4.4.8
	clap_builder@4.4.8
	clap_derive@4.4.7
	clap_lex@0.6.0
	colorchoice@1.0.0
	concurrent-queue@2.3.0
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	core-graphics-types@0.1.2
	cpufeatures@0.2.11
	crossbeam-queue@0.3.8
	crossbeam-utils@0.8.16
	crunchy@0.2.2
	crypto-common@0.1.6
	darling@0.20.3
	darling_core@0.20.3
	darling_macro@0.20.3
	derivative@2.2.0
	diff@0.1.13
	digest@0.10.7
	enum_dispatch@0.3.12
	enumflags2@0.7.8
	enumflags2_derive@0.7.8
	equivalent@1.0.1
	errno@0.3.7
	event-listener-strategy@0.3.0
	event-listener@2.5.3
	event-listener@3.1.0
	fastrand@1.9.0
	fastrand@2.0.1
	field-offset@0.3.6
	fnv@1.0.7
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-lite@1.13.0
	futures-lite@2.0.1
	futures-macro@0.3.29
	futures-sink@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	futures@0.3.29
	gdk-pixbuf-sys@0.18.0
	gdk-pixbuf@0.18.3
	gdk4-sys@0.7.2
	gdk4@0.7.3
	generic-array@0.14.7
	getrandom@0.2.11
	gimli@0.28.0
	gio-sys@0.18.1
	gio@0.18.3
	glib-macros@0.18.3
	glib-sys@0.18.1
	glib@0.18.3
	gobject-sys@0.18.0
	graphene-rs@0.18.1
	graphene-sys@0.18.1
	gsk4-sys@0.7.3
	gsk4@0.7.3
	gtk4-macros@0.7.2
	gtk4-sys@0.7.3
	gtk4@0.7.3
	half@2.3.1
	hashbrown@0.12.3
	hashbrown@0.14.2
	heck@0.4.1
	hermit-abi@0.3.3
	hex@0.4.3
	ident_case@1.0.1
	indexmap@1.9.3
	indexmap@2.1.0
	instant@0.1.12
	io-lifetimes@1.0.11
	itoa@1.0.9
	lazy_static@1.4.0
	libc@0.2.150
	libdrm_amdgpu_sys@0.2.2
	libloading@0.7.4
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.11
	lock_api@0.4.11
	log@0.4.20
	malloc_buf@0.0.6
	matchers@0.1.0
	memchr@2.6.4
	memoffset@0.7.1
	memoffset@0.9.0
	miniz_oxide@0.7.1
	mio@0.8.9
	nix@0.26.4
	nix@0.27.1
	nu-ansi-term@0.46.0
	objc@0.2.7
	object@0.32.1
	once_cell@1.18.0
	ordered-stream@0.2.0
	overload@0.1.1
	pango-sys@0.18.0
	pango@0.18.3
	parking@2.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	pciid-parser@0.7.1
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	piper@0.2.1
	pkg-config@0.3.27
	polling@2.8.0
	polling@3.3.0
	ppv-lite86@0.2.17
	pretty_assertions@1.4.0
	proc-macro-crate@1.3.1
	proc-macro-crate@2.0.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.69
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.4.1
	regex-automata@0.1.10
	regex-automata@0.4.3
	regex-syntax@0.6.29
	regex-syntax@0.8.2
	regex@1.10.2
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.37.27
	rustix@0.38.25
	ryu@1.0.15
	scopeguard@1.2.0
	semver@1.0.20
	serde@1.0.193
	serde_derive@1.0.193
	serde_json@1.0.108
	serde_repr@0.1.17
	serde_spanned@0.6.4
	serde_with@3.4.0
	serde_with_macros@3.4.0
	serde_yaml@0.9.27
	sha1@0.10.6
	sharded-slab@0.1.7
	signal-hook-registry@1.4.1
	slab@0.4.9
	smallvec@1.11.2
	socket2@0.4.10
	socket2@0.5.5
	static_assertions@1.1.0
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.39
	system-deps@6.2.0
	target-lexicon@0.12.12
	tempfile@3.8.1
	thiserror-impl@1.0.50
	thiserror@1.0.50
	thread_local@1.1.7
	tokio-macros@2.2.0
	tokio@1.34.0
	toml@0.8.8
	toml_datetime@0.6.5
	toml_edit@0.19.15
	toml_edit@0.20.7
	toml_edit@0.21.0
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	tracing@0.1.40
	typenum@1.17.0
	uds_windows@1.0.2
	unicode-ident@1.0.12
	unsafe-libyaml@0.2.9
	utf8parse@0.2.1
	valuable@0.1.0
	version-compare@0.1.1
	version_check@0.9.4
	vk-parse@0.8.0
	vulkano@0.33.0
	waker-fn@1.1.1
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@0.5.19
	xdg-home@1.0.0
	xml-rs@0.8.19
	yansi@0.5.1
	zbus@3.14.1
	zbus_macros@3.14.1
	zbus_names@2.6.0
	zerocopy-derive@0.7.26
	zerocopy@0.7.26
	zvariant@3.15.0
	zvariant_derive@3.15.0
	zvariant_utils@1.0.1
"

inherit cargo

DESCRIPTION="Linux AMDGPU Controller"
HOMEPAGE="https://github.com/ilya-zlobintsev/LACT"
SRC_URI="
	https://github.com/ilya-zlobintsev/LACT/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${P^^}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions BSD GPL-3 ISC MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="amd64"
IUSE="+drm +gtk"

DEPEND="
	drm? ( x11-libs/libdrm[video_cards_amdgpu] )
	gtk? ( gui-libs/gtk:4 )
"
RDEPEND="
	${DEPEND}
	sys-apps/hwdata
"
BDEPEND="
	dev-util/blueprint-compiler
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="usr/bin/lact"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.0-drmless.patch"
)

src_configure() {
	sed -i "s|target/release|target/$(usex debug debug release)|" Makefile || die
	sed -i "/^strip =/d" Cargo.toml || die

	local myfeatures=(
		$(usev gtk lact-gui)
		$(usev drm)
	)
	cargo_src_configure --no-default-features -p lact
}

src_install() {
	emake DESTDIR="${ED}/usr" install
	newinitd "${FILESDIR}"/lactd.init lactd
}
