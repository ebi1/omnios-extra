#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}

# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=compiler-rt
PKG=ooce/developer/compiler-rt-120
VER=12.0.1
SUMMARY="LLVM runtime libraries"
DESC="Implementation for the runtime compiler support libraries"

MAJVER=${VER%.*}

BUILD_DEPENDS_IPS="ooce/developer/llvm-${MAJVER//./}"

set_builddir $PROG-$VER.src
set_patchdir patches-${MAJVER//./}

CONFIGURE_OPTS_32=
CONFIGURE_OPTS_64=
CONFIGURE_OPTS_WS="
    -DCOMPILER_RT_INSTALL_PATH=\"$PREFIX/clang-$MAJVER/lib/clang/$VER\"
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_C_COMPILER=\"$CC\"
    -DCMAKE_CXX_COMPILER=\"$CXX\"
    -DCMAKE_CXX_LINK_FLAGS=\"$LDFLAGS64\"
    -DLLVM_CONFIG_PATH=\"$PREFIX/llvm-$MAJVER/bin/llvm-config\"
    -DPYTHON_EXECUTABLE=\"$PYTHON\"
"

init
download_source $PROG $BUILDDIR
patch_source
prep_build cmake+ninja
build -noctf
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
