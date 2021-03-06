# Created by: Sunpoet Po-Chuan Hsieh <sunpoet@FreeBSD.org>
# $FreeBSD$

PORTNAME=	rocksdb
PORTVERSION=	6.8.1
DISTVERSIONPREFIX=	v
CATEGORIES=	databases

MAINTAINER?=	sunpoet@FreeBSD.org
COMMENT?=	Persistent key-value store for fast storage environments

LICENSE=	APACHE20 GPLv2
LICENSE_COMB=	dual
LICENSE_FILE_APACHE20=	${WRKSRC}/LICENSE.Apache
LICENSE_FILE_GPLv2=	${WRKSRC}/COPYING

BROKEN_armv6?=		does not build: db/c.cc:2281:44: implicit conversion loses integer precision: 'uint64_t' (aka 'unsigned long long') to 'size_t' (aka 'unsigned int')
BROKEN_armv7?=		does not build: /nxb-bin/usr/bin/ld: undefined reference to symbol `__gnu_Unwind_Find_exidx@@FBSD_1.4' (try adding -lc) #'`
BROKEN_powerpc64=	does not build: util/crc32c.cc:435:22: 'arch_ppc_probe' was not declared in this scope

BUILD_DEPENDS=	bash:shells/bash
LIB_DEPENDS=	libgflags.so:devel/gflags \
		libsnappy.so:archivers/snappy

OPTIONS_DEFINE=	DEBUG LZ4 ZSTD
OPTIONS_DEFAULT=LZ4

USES=		compiler:c++11-lib gmake localbase:ldflags shebangfix

ALL_TARGET=	shared_lib static_lib all
CFLAGS+=	-DOS_FREEBSD
CONFIGURE_ARGS=	make_config.mk
CONFIGURE_ENV=	PORTABLE=0 ROCKSDB_ROOT=${WRKSRC}
CONFIGURE_SCRIPT=	build_tools/build_detect_platform
HAS_CONFIGURE=	yes
MAKE_ENV=	CXX=${CXX} INSTALL_PATH=${STAGEDIR}${PREFIX} USE_RTTI=1
USE_CXXSTD=	c++11
USE_LDCONFIG=	yes
TEST_TARGET=	check

PLIST_SUB=	PORTVERSION=${PORTVERSION} SHLIB_MAJOR=${PORTVERSION:R:R} SHLIB_MINOR=${PORTVERSION:R:E}
PORTDATA=	make_config.mk

GH_ACCOUNT=	facebook
USE_GITHUB=	yes

SHEBANG_FILES=	*/*.sh

BENCHMARKS=	cache_bench db_bench memtablerep_bench persistent_cache_bench range_del_aggregator_bench table_reader_bench
TOOLS=		blob_dump db_repl_stress db_sanity_test db_stress ldb rocksdb_dump rocksdb_undump sst_dump trace_analyzer write_stress

DEBUG_MAKE_ENV=		DEBUG_LEVEL=2
DEBUG_MAKE_ENV_OFF=	DEBUG_LEVEL=0
LZ4_LIB_DEPENDS=	liblz4.so:archivers/liblz4
LZ4_MAKE_ENV_OFF=	ROCKSDB_DISABLE_LZ4=yes
ZSTD_LIB_DEPENDS=	libzstd.so:archivers/zstd
ZSTD_MAKE_ENV_OFF=	ROCKSDB_DISABLE_ZSTD=yes

.if !defined(LITE)
CONFLICTS_INSTALL=	rocksdb-lite
PLIST_SUB+=	LITE=""
.else
PKGNAMESUFFIX=	-lite
CONFLICTS_INSTALL=	rocksdb
CFLAGS+=	-DROCKSDB_LITE=1
MAKE_ENV+=	LIBNAME=librocksdb${PKGNAMESUFFIX} DISABLE_JEMALLOC=1
PLIST_SUB+=	LITE=${PKGNAMESUFFIX}
.endif

.include <bsd.port.pre.mk>

.if ${CHOSEN_COMPILER_TYPE} == clang
CXXFLAGS+=	-Wno-inconsistent-missing-override
# Clang 8 detects shadow enums and stops the build. This workaround adds -Wno-error=shadow to bypass it.
.if ${COMPILER_VERSION} >= 80
CXXFLAGS+=	-Wno-error=shadow
.endif
.endif

post-patch:
	@${REINPLACE_CMD} -e '/^dummy :=/d; /^all: / s| $$(TESTS)||' ${WRKSRC}/Makefile
	@${REINPLACE_CMD} -e 's| -fno-builtin-memcmp||; s| -ltcmalloc||' ${WRKSRC}/build_tools/build_detect_platform
.if ${ARCH} != x86_64 && ${ARCH} != i386
	@${REINPLACE_CMD} -e 's| -march=native||' ${WRKSRC}/build_tools/build_detect_platform
.endif
	@${REINPLACE_CMD} -e 's|#include "gtest/gtest.h"|#include "gtest.h"|' ${WRKSRC}/third-party/gtest-1.8.1/fused-src/gtest/gtest-all.cc
.if defined(WITHOUT_PROFILE)
	@${REINPLACE_CMD} -e '/pg = / s| -pg||' ${WRKSRC}/Makefile
.endif
# Disable SSE4.2 on i386 architecture to fix i386 builds on FreeBSD package building cluster
.if ${ARCH} == i386
	@${REINPLACE_CMD} -e 's|#ifdef __SSE4_2__|&DISABLED__|' ${WRKSRC}/util/crc32c.cc
.endif

post-install:
	${MKDIR} ${STAGEDIR}${DATADIR}/
	cd ${WRKSRC}/ && ${INSTALL_PROGRAM} ${BENCHMARKS} ${TOOLS} ${STAGEDIR}${PREFIX}/bin/
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/librocksdb${PKGNAMESUFFIX}.so
	${INSTALL_DATA} ${WRKSRC}/librocksdb${PKGNAMESUFFIX}_tools.a ${STAGEDIR}${PREFIX}/lib/
	${INSTALL_DATA} ${WRKSRC}/make_config.mk ${STAGEDIR}${DATADIR}/

.include <bsd.port.post.mk>
