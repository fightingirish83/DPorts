# $FreeBSD$

PORTNAME=	libretro-prosystem
PORTVERSION=	0.20200313
CATEGORIES=	games

MAINTAINER=	menelkir@itroll.org
COMMENT=	Port of ProSystem to the libretro API

LICENSE=	GPLv2

USES=		compiler:c++11-lib gmake
USE_LDCONFIG=	yes

USE_GITHUB=	yes
GH_ACCOUNT=	libretro
GH_PROJECT=	prosystem-libretro
GH_TAGNAME=	6f7e34a

PLIST_FILES=	libexec/libretro/prosystem_libretro.so

do-install:
	${MKDIR} ${STAGEDIR}/${PREFIX}/libexec/libretro;
	${INSTALL_LIB} $$(find ${WRKSRC}/${COREDIR}/ -name "*.so") ${STAGEDIR}/${PREFIX}/libexec/libretro;

.include <bsd.port.mk>
