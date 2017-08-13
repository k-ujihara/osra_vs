#
# This makefile is included from all other makefiles.
#
# Notes:
# - Use $(CXX) variable for compiler.
# - Use $(LINK.cpp) for linker. Currently it is equal to "$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)", but if you need real linker detection, use libtool + LT_PATH_LD macros
# - Pass optimization flags as follows:
#   CXXFLAGS="-g -O3" ./configure
#   There are no defaults for any options as there is no guarantee, that target compiler supports them, see http://www.gnu.org/software/autoconf/manual/make/Command-Variables.html.
#

NAME			:= osra
VERSION			:= 2.0.1
LIB_MAJOR_VERSION	:= 1
LIB_MINOR_VERSION	:= 0
LIB_PATCH_VERSION	:= 20001
NAME_VERSION		:= $(NAME)-$(VERSION)

prefix			:= /usr/local
exec_prefix		:= ${prefix}
bindir			:= ${exec_prefix}/bin
libdir			:= ${exec_prefix}/lib
includedir		:= ${prefix}/include
datarootdir		:= ${prefix}/share
datadir			:= ${prefix}/share
docdir			:= ${prefix}/share/doc/osra
mandir			:= ${datarootdir}/man

TARGET_CPU		:= i686
TARGET_OS		:= mingw

CXX			:= g++
RM			:= /bin/rm
LN_S			:= cp -pR
RANLIB			:= ranlib
AR			:= /mingw/bin/ar
INSTALL			:= /bin/install -c
INSTALL_PROGRAM		:= ${INSTALL} -s
INSTALL_DATA		:= ${INSTALL} -m 644
INSTALL_DIR		:= ${INSTALL} -d -m 755
NATURALDOCS		:= 
XSLTPROC		:= 
TESSERACT_LIB		:= 
OSRA_LIB		:= 
OSRA_JAVA		:= 

# Notes: see "configure --enable-static-linking" to enable static linking; use "configure --enable-profiling" to include extra debug info.

CXXFLAGS		:= -g -O2
CPPFLAGS		:= -I/usr/local/include/GraphicsMagick -D_LIB -I/usr/local/include/openbabel-2.0/ -I/usr/local/include/gocr/ -I/usr/local/include -I/usr/local/include
LDFLAGS			:= -L/usr/local/lib -static -L/usr/local/lib -L/usr/local/bin -static-libgcc -Wl,-static
# Important that this variable is re-evaluated each time when used: 
LDSHAREDFLAGS		= -shared -Wl,--kill-at -Wl,--out-implib,$@.a

EXEEXT			:= .exe
SHAREDEXT		:= .dll

LIBS			:= -lPgm2asc -lGraphicsMagick++ -lGraphicsMagick -ljbig -llcms -ltiff -ljasper -ljpeg -lpng16 -lz -lgdi32 -lm -lopenbabel -lz -linchi -lws2_32 -locrad -lpotrace -lm 

PHONY_TARGETS		:= all install uninstall clean distclean

.PHONY: $(PHONY_TARGETS)

.SUFFIXES: .c .cpp
