# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: llvm.eclass
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# @AUTHOR:
# Michał Górny <mgorny@gentoo.org>
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Utility functions to build against slotted LLVM
# @DESCRIPTION:
# The llvm.eclass provides utility functions that can be used to build
# against specific version of slotted LLVM (with fallback to :0 for old
# versions).
#
# This eclass does not generate dependency strings. You need to write
# a proper dependency string yourself to guarantee that appropriate
# version of LLVM is installed.
#
# Example use for a package supporting LLVM 9 to 11:
# @CODE
# inherit cmake llvm
#
# RDEPEND="
#	<llvm-core/llvm-11:=
#	|| (
#		llvm-core/llvm:9
#		llvm-core/llvm:10
#		llvm-core/llvm:11
#	)
# "
# DEPEND=${RDEPEND}
#
# LLVM_MAX_SLOT=11
#
# # only if you need to define one explicitly
# pkg_setup() {
#	llvm_pkg_setup
#	do-something-else
# }
# @CODE
#
# Example for a package needing LLVM+clang w/ a specific target:
# @CODE
# inherit cmake llvm
#
# # note: do not use := on both clang and llvm, it can match different
# # slots then. clang pulls llvm in, so we can skip the latter.
# RDEPEND="
#	>=llvm-core/clang-9:=[llvm_targets_AMDGPU(+)]
# "
# DEPEND=${RDEPEND}
#
# llvm_check_deps() {
#	has_version -d "llvm-core/clang:${LLVM_SLOT}[llvm_targets_AMDGPU(+)]"
# }
# @CODE

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_LLVM_ECLASS} ]]; then
_LLVM_ECLASS=1

# make sure that the versions installing straight into /usr/bin
# are uninstalled
DEPEND="!!llvm-core/llvm:0"

# @ECLASS_VARIABLE: LLVM_MAX_SLOT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Highest LLVM slot supported by the package. Needs to be set before
# llvm_pkg_setup is called. If unset, no upper bound is assumed.

# @ECLASS_VARIABLE: _LLVM_KNOWN_SLOTS
# @INTERNAL
# @DESCRIPTION:
# Correct values of LLVM slots, newest first.
declare -g -r _LLVM_KNOWN_SLOTS=( {18..8} )

# @ECLASS_VARIABLE: LLVM_ECLASS_SKIP_PKG_SETUP
# @INTERNAL
# @DESCRIPTION:
# If set to a non-empty value, llvm_pkg_setup will not perform LLVM version
# check, nor set PATH.  Useful for bootstrap-prefix.sh, where AppleClang has
# unparseable version numbers, which are irrelevant anyway.

# @FUNCTION: get_llvm_slot
# @USAGE: [-b|-d] [<max_slot>]
# @DESCRIPTION:
# Find the newest LLVM install that is acceptable for the package,
# and print its major version number (i.e. slot).
#
# If -b is specified, the checks are performed relative to BROOT,
# and BROOT-path is returned.  This is appropriate when your package
# calls llvm-config executable.
#
# If -d is specified, the checks are performed relative to ESYSROOT,
# and ESYSROOT-path is returned.  This is appropriate when your package
# uses CMake find_package(LLVM).  -d is the default.
#
# If <max_slot> is specified, then only LLVM versions that are not newer
# than <max_slot> will be considered. Otherwise, all LLVM versions would
# be considered acceptable. The function does not support specifying
# minimal supported version -- the developer must ensure that a version
# new enough is installed via providing appropriate dependencies.
#
# If llvm_check_deps() function is defined within the ebuild, it will
# be called to verify whether a particular slot is accepable. Within
# the function scope, LLVM_SLOT will be defined to the SLOT value
# (0, 4, 5...). The function should return a true status if the slot
# is acceptable, false otherwise. If llvm_check_deps() is not defined,
# the function defaults to checking whether llvm-core/llvm:${LLVM_SLOT}
# is installed.
get_llvm_slot() {
	debug-print-function ${FUNCNAME} "${@}"

	local hv_switch=-d
	while [[ ${1} == -* ]]; do
		case ${1} in
			-b|-d) hv_switch=${1};;
			*) break;;
		esac
		shift
	done

	local max_slot=${1}
	local slot
	for slot in "${_LLVM_KNOWN_SLOTS[@]}"; do
		# skip higher slots
		if [[ -n ${max_slot} ]]; then
			if [[ ${max_slot} == ${slot} ]]; then
				max_slot=
			else
				continue
			fi
		fi

		if declare -f llvm_check_deps >/dev/null; then
			local LLVM_SLOT=${slot}
			llvm_check_deps || continue
		else
			# check if LLVM package is installed
			has_version ${hv_switch} "llvm-core/llvm:${slot}" || continue
		fi

		echo "${slot}"
		return
	done

	# max_slot should have been unset in the iteration
	if [[ -n ${max_slot} ]]; then
		die "${FUNCNAME}: invalid max_slot=${max_slot}"
	fi

	die "No LLVM slot${1:+ <= ${1}} satisfying the package's dependencies found installed!"
}

# @FUNCTION: get_llvm_prefix
# @USAGE: [-b|-d] [<max_slot>]
# @DESCRIPTION:
# Find the newest LLVM install that is acceptable for the package,
# and print an absolute path to it.
#
# The options and behavior is the same as for get_llvm_slot.
get_llvm_prefix() {
	debug-print-function ${FUNCNAME} "${@}"

	local prefix=${ESYSROOT}
	[[ ${1} == -b ]] && prefix=${BROOT}

	echo "${prefix}/usr/lib/llvm/$(get_llvm_slot "${@}")"
}

# @FUNCTION: llvm_tuple_to_target
# @USAGE: [<tuple>]
# @DESCRIPTION:
# Translate a tuple into a target suitable for LLVM_TARGETS.
# Defaults to ${CHOST} if not specified.
llvm_tuple_to_target() {
	debug-print-function ${FUNCNAME} "${@}"

	case ${1:-${CHOST}} in
		aarch64*) echo "AArch64";;
		amdgcn*) echo "AMDGPU";;
		arc*) echo "ARC";;
		arm*) echo "ARM";;
		avr*) echo "AVR";;
		bpf*) echo "BPF";;
		csky*) echo "CSKY";;
		loong*) echo "LoongArch";;
		m68k*) echo "M68k";;
		mips*) echo "Mips";;
		msp430*) echo "MSP430";;
		nvptx*) echo "NVPTX";;
		powerpc*) echo "PowerPC";;
		riscv*) echo "RISCV";;
		sparc*) echo "Sparc";;
		s390*) echo "SystemZ";;
		x86_64*|i?86*) echo "X86";;
		xtensa*) echo "Xtensa";;
		*) die "Unknown LLVM target for tuple ${1:-${CHOST}}"
	esac
}

# @FUNCTION: llvm_fix_clang_version
# @USAGE: <variable-name>...
# @DESCRIPTION:
# Fix the clang compiler name in specified variables to include
# the major version, to prevent PATH alterations from forcing an older
# clang version being used.
llvm_fix_clang_version() {
	debug-print-function ${FUNCNAME} "${@}"

	local shopt_save=$(shopt -p -o noglob)
	set -f
	local var
	for var; do
		local split=( ${!var} )
		case ${split[0]} in
			*clang|*clang++|*clang-cpp)
				local version=()
				read -r -a version < <("${split[0]}" --version)
				local major=${version[-1]%%.*}
				if [[ -n ${major//[0-9]} ]]; then
					die "${var}=${!var} produced invalid --version: ${version[*]}"
				fi

				split[0]+=-${major}
				if ! type -P "${split[0]}" &>/dev/null; then
					die "${split[0]} does not seem to exist"
				fi
				declare -g "${var}=${split[*]}"
				;;
		esac
	done
	${shopt_save}
}

# @FUNCTION: llvm_fix_tool_path
# @USAGE: <variable-name>...
# @DESCRIPTION:
# Fix the LLVM tools referenced in the specified variables to their
# current location, to prevent PATH alterations from forcing older
# versions being used.
llvm_fix_tool_path() {
	debug-print-function ${FUNCNAME} "${@}"

	local shopt_save=$(shopt -p -o noglob)
	set -f
	local var
	for var; do
		local split=( ${!var} )
		local path=$(type -P ${split[0]} 2>/dev/null)
		# if it resides in one of the LLVM prefixes, it's an LLVM tool!
		if [[ ${path} == "${BROOT}/usr/lib/llvm"* ]]; then
			split[0]=${path}
			declare -g "${var}=${split[*]}"
		fi
	done
	${shopt_save}
}

# @FUNCTION: llvm_pkg_setup
# @DESCRIPTION:
# Prepend the appropriate executable directory for the newest
# acceptable LLVM slot to the PATH. For path determination logic,
# please see the get_llvm_prefix documentation.
#
# The highest acceptable LLVM slot can be set in LLVM_MAX_SLOT variable.
# If it is unset or empty, any slot is acceptable.
#
# The PATH manipulation is only done for source builds. The function
# is a no-op when installing a binary package.
#
# If any other behavior is desired, the contents of the function
# should be inlined into the ebuild and modified as necessary.
llvm_pkg_setup() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ ${LLVM_ECLASS_SKIP_PKG_SETUP} ]]; then
		return
	fi

	if [[ ${MERGE_TYPE} != binary ]]; then
		LLVM_SLOT=$(get_llvm_slot "${LLVM_MAX_SLOT}")

		llvm_fix_clang_version CC CPP CXX
		# keep in sync with profiles/features/llvm/make.defaults!
		llvm_fix_tool_path ADDR2LINE AR AS LD NM OBJCOPY OBJDUMP RANLIB
		llvm_fix_tool_path READELF STRINGS STRIP

		# Set LLVM_CONFIG to help Meson (bug #907965) but only do it
		# for empty ESYSROOT (as a proxy for "are we cross-compiling?").
		if [[ -z ${ESYSROOT} ]] ; then
			llvm_fix_tool_path LLVM_CONFIG
		fi

		local prefix=${ESYSROOT}
		local llvm_path=${prefix}/usr/lib/llvm/${LLVM_SLOT}/bin
		local IFS=:
		local split_path=( ${PATH} )
		local new_path=()
		local x added=

		# prepend new path before first LLVM version found
		for x in "${split_path[@]}"; do
			if [[ ${x} == */usr/lib/llvm/*/bin ]]; then
				if [[ ${x} != ${llvm_path} ]]; then
					new_path+=( "${llvm_path}" )
				elif [[ ${added} && ${x} == ${llvm_path} ]]; then
					# deduplicate
					continue
				fi
				added=1
			fi
			new_path+=( "${x}" )
		done
		# ...or to the end of PATH
		[[ ${added} ]] || new_path+=( "${llvm_path}" )

		export PATH=${new_path[*]}
	fi
}

fi

EXPORT_FUNCTIONS pkg_setup
