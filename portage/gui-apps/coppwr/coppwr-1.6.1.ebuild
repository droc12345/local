# SPDX-License-Identifier: GPL-2.0
# Copyright 2024 Gentoo Authors
# Copyright 2024 Jason André Charles Gantner
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

RESTRICT="mirror"

CRATES="
	ab_glyph@0.2.29
	ab_glyph_rasterizer@0.1.8
	accesskit@0.16.3
	accesskit_atspi_common@0.9.3
	accesskit_consumer@0.24.3
	accesskit_macos@0.17.4
	accesskit_unix@0.12.3
	accesskit_windows@0.23.2
	accesskit_winit@0.22.4
	adler2@2.0.0
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	android-activity@0.6.0
	android-properties@0.2.2
	android_system_properties@0.1.5
	annotate-snippets@0.9.2
	anyhow@1.0.90
	arboard@3.4.1
	arrayref@0.3.9
	arrayvec@0.7.6
	as-raw-xcb-connection@1.0.1
	ash@0.38.0+1.3.281
	ashpd@0.9.2
	async-broadcast@0.7.1
	async-channel@2.3.1
	async-executor@1.13.1
	async-fs@2.1.2
	async-io@2.3.4
	async-lock@3.4.0
	async-net@2.0.0
	async-process@2.3.0
	async-recursion@1.1.1
	async-signal@0.2.10
	async-task@4.7.1
	async-trait@0.1.83
	atomic-waker@1.1.2
	atspi@0.22.0
	atspi-common@0.6.0
	atspi-connection@0.6.0
	atspi-proxies@0.6.0
	autocfg@1.4.0
	base64@0.21.7
	bindgen@0.69.5
	bit-set@0.6.0
	bit-vec@0.7.0
	bitflags@1.3.2
	bitflags@2.6.0
	block@0.1.6
	block-buffer@0.10.4
	block2@0.5.1
	blocking@1.6.1
	bumpalo@3.16.0
	bytemuck@1.19.0
	bytemuck_derive@1.8.0
	byteorder@1.5.0
	byteorder-lite@0.1.0
	bytes@1.8.0
	calloop@0.13.0
	calloop-wayland-source@0.3.0
	cc@1.1.31
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-expr@0.15.8
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	cfg_aliases@0.2.1
	cgl@0.3.2
	clang-sys@1.8.1
	clipboard-win@5.4.0
	codespan-reporting@0.11.1
	com@0.6.0
	com_macros@0.6.0
	com_macros_support@0.6.0
	combine@4.6.7
	concurrent-queue@2.5.0
	convert_case@0.6.0
	cookie-factory@0.3.3
	core-foundation@0.9.4
	core-foundation@0.10.0
	core-foundation-sys@0.8.7
	core-graphics@0.23.2
	core-graphics-types@0.1.3
	cpufeatures@0.2.14
	crc32fast@1.4.2
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	cursor-icon@1.1.0
	digest@0.10.7
	dispatch@0.2.0
	dlib@0.5.2
	document-features@0.2.10
	downcast-rs@1.2.1
	dpi@0.1.1
	duplicate@2.0.0
	ecolor@0.29.1
	eframe@0.29.1
	egui@0.29.1
	egui-wgpu@0.29.1
	egui-winit@0.29.1
	egui_dock@0.14.0
	egui_glow@0.29.1
	egui_plot@0.29.0
	either@1.13.0
	emath@0.29.1
	endi@1.1.0
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	enumn@0.1.14
	epaint@0.29.1
	epaint_default_fonts@0.29.1
	equivalent@1.0.1
	errno@0.3.9
	error-code@3.3.1
	event-listener@5.3.1
	event-listener-strategy@0.5.2
	fastrand@2.1.1
	fdeflate@0.3.5
	flate2@1.0.34
	foreign-types@0.5.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	form_urlencoded@1.2.1
	futures@0.3.31
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.3.0
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	generic-array@0.14.7
	gethostname@0.4.3
	getrandom@0.2.15
	gl_generator@0.14.0
	glob@0.3.1
	glow@0.13.1
	glow@0.14.2
	glutin@0.32.1
	glutin-winit@0.5.0
	glutin_egl_sys@0.7.0
	glutin_glx_sys@0.6.0
	glutin_wgl_sys@0.6.0
	gpu-alloc@0.6.0
	gpu-alloc-types@0.3.0
	gpu-allocator@0.26.0
	gpu-descriptor@0.3.0
	gpu-descriptor-types@0.2.0
	hashbrown@0.14.5
	hashbrown@0.15.0
	hassle-rs@0.11.0
	heck@0.5.0
	hermit-abi@0.4.0
	hex@0.4.3
	hexf-parse@0.2.1
	home@0.5.9
	idna@0.5.0
	image@0.25.4
	immutable-chunkmap@2.0.6
	indexmap@2.6.0
	itertools@0.12.1
	jni@0.21.1
	jni-sys@0.3.0
	jobserver@0.1.32
	js-sys@0.3.72
	khronos-egl@6.0.0
	khronos_api@3.1.0
	lazy_static@1.5.0
	lazycell@1.3.0
	libc@0.2.161
	libloading@0.8.5
	libredox@0.1.3
	linux-raw-sys@0.4.14
	litrs@0.4.1
	lock_api@0.4.12
	log@0.4.22
	malloc_buf@0.0.6
	memchr@2.7.4
	memmap2@0.9.5
	memoffset@0.9.1
	metal@0.29.0
	minimal-lexical@0.2.1
	miniz_oxide@0.8.0
	naga@22.1.0
	ndk@0.9.0
	ndk-context@0.1.1
	ndk-sys@0.5.0+25.2.9519653
	ndk-sys@0.6.0+11769913
	nix@0.27.1
	nix@0.29.0
	nohash-hasher@0.2.0
	nom@7.1.3
	num-traits@0.2.19
	num_enum@0.7.3
	num_enum_derive@0.7.3
	objc@0.2.7
	objc-sys@0.3.5
	objc2@0.5.2
	objc2-app-kit@0.2.2
	objc2-cloud-kit@0.2.2
	objc2-contacts@0.2.2
	objc2-core-data@0.2.2
	objc2-core-image@0.2.2
	objc2-core-location@0.2.2
	objc2-encode@4.0.3
	objc2-foundation@0.2.2
	objc2-link-presentation@0.2.2
	objc2-metal@0.2.2
	objc2-quartz-core@0.2.2
	objc2-symbols@0.2.2
	objc2-ui-kit@0.2.2
	objc2-uniform-type-identifiers@0.2.2
	objc2-user-notifications@0.2.2
	once_cell@1.20.2
	orbclient@0.3.48
	ordered-stream@0.2.0
	owned_ttf_parser@0.25.0
	parking@2.2.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	percent-encoding@2.3.1
	pin-project@1.1.6
	pin-project-internal@1.1.6
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.31
	png@0.17.14
	polling@3.7.3
	pollster@0.3.0
	ppv-lite86@0.2.20
	presser@0.3.1
	proc-macro-crate@3.2.0
	proc-macro2@1.0.88
	proc-macro2-diagnostics@0.10.1
	profiling@1.0.16
	quick-xml@0.30.0
	quick-xml@0.36.2
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	raw-window-handle@0.6.2
	rayon@1.10.0
	rayon-core@1.12.1
	redox_syscall@0.4.1
	redox_syscall@0.5.7
	regex@1.11.0
	regex-automata@0.4.8
	regex-syntax@0.8.5
	renderdoc-sys@1.1.0
	ron@0.8.1
	rustc-hash@1.1.0
	rustix@0.38.37
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sctk-adwaita@0.10.1
	serde@1.0.211
	serde_derive@1.0.211
	serde_repr@0.1.19
	serde_spanned@0.6.8
	sha1@0.10.6
	shlex@1.3.0
	signal-hook-registry@1.4.2
	simd-adler32@0.3.7
	slab@0.4.9
	slotmap@1.0.7
	smallvec@1.13.2
	smithay-client-toolkit@0.19.2
	smithay-clipboard@0.7.2
	smol_str@0.2.2
	spirv@0.3.0+sdk-1.3.268.0
	static_assertions@1.1.0
	strict-num@0.1.1
	syn@1.0.109
	syn@2.0.82
	system-deps@6.2.2
	target-lexicon@0.12.16
	tempfile@3.13.0
	termcolor@1.4.1
	thiserror@1.0.64
	thiserror-impl@1.0.64
	tiny-skia@0.11.4
	tiny-skia-path@0.11.4
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	ttf-parser@0.25.0
	type-map@0.5.0
	typenum@1.17.0
	uds_windows@1.1.0
	unicode-bidi@0.3.17
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	unicode-xid@0.2.6
	url@2.5.2
	version-compare@0.2.0
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.95
	wasm-bindgen-backend@0.2.95
	wasm-bindgen-futures@0.4.45
	wasm-bindgen-macro@0.2.95
	wasm-bindgen-macro-support@0.2.95
	wasm-bindgen-shared@0.2.95
	wayland-backend@0.3.7
	wayland-client@0.31.6
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.6
	wayland-protocols@0.32.4
	wayland-protocols-plasma@0.3.4
	wayland-protocols-wlr@0.3.4
	wayland-scanner@0.31.5
	wayland-sys@0.31.5
	web-sys@0.3.72
	web-time@1.1.0
	webbrowser@1.0.2
	wgpu@22.1.0
	wgpu-core@22.1.0
	wgpu-hal@22.0.0
	wgpu-types@22.0.0
	widestring@1.1.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.52.0
	windows@0.58.0
	windows-core@0.52.0
	windows-core@0.58.0
	windows-implement@0.58.0
	windows-interface@0.58.0
	windows-result@0.2.0
	windows-strings@0.1.0
	windows-sys@0.45.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winit@0.30.5
	winnow@0.6.20
	x11-dl@2.21.0
	x11rb@0.13.1
	x11rb-protocol@0.13.1
	xcursor@0.3.8
	xdg-home@1.3.0
	xkbcommon-dl@0.4.2
	xkeysym@0.2.1
	xml-rs@0.8.22
	yansi@1.0.1
	yansi-term@0.1.2
	zbus@4.4.0
	zbus-lockstep@0.4.4
	zbus-lockstep-macros@0.4.4
	zbus_macros@4.4.0
	zbus_names@3.0.0
	zbus_xml@4.0.0
	zerocopy@0.7.35
	zerocopy-derive@0.7.35
	zvariant@4.2.0
	zvariant_derive@4.2.0
	zvariant_utils@2.1.0
"

declare -A GIT_CRATES=(
	[egui_node_graph]="https://github.com/dimtpap/egui_node_graph;87b3f084c1cf70ac9ad489ae1f2e2a8234efdde4;egui_node_graph-%commit%/egui_node_graph"
	[pipewire]="https://gitlab.freedesktop.org/dimtpap/pipewire-rs;605d15996f3258b3e1cc34e445dfbdf16a366c7e;pipewire-rs-%commit%/pipewire"
	[pipewire-sys]="https://gitlab.freedesktop.org/dimtpap/pipewire-rs;605d15996f3258b3e1cc34e445dfbdf16a366c7e;pipewire-rs-%commit%/pipewire-sys"
	[libspa]="https://gitlab.freedesktop.org/dimtpap/pipewire-rs;605d15996f3258b3e1cc34e445dfbdf16a366c7e;pipewire-rs-%commit%/libspa"
	[libspa-sys]="https://gitlab.freedesktop.org/dimtpap/pipewire-rs;605d15996f3258b3e1cc34e445dfbdf16a366c7e;pipewire-rs-%commit%/libspa-sys"
)

inherit cargo desktop

DESCRIPTION="Low level control GUI for the PipeWire multimedia server"
HOMEPAGE="https://github.com/dimtpap/coppwr"
SRC_URI="
		${CARGO_CRATE_URIS}
		https://github.com/dimtpap/coppwr/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	media-video/pipewire
	"
RDEPEND="${DEPEND}"
BDEPEND="
	|| ( dev-lang/rust dev-lang/rust-bin )
	llvm-core/clang
	"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install(){
	domenu assets/io.github.dimtpap.coppwr.desktop
	for size in 32 48 64 128 256 512;do
		newicon -s ${size} assets/icon/${size}.png io.github.dimtpap.coppwr.png
	done
	newicon -s scalable assets/icon/scalable.svg io.github.dimtpap.coppwr.svg
	cargo_src_install
}
