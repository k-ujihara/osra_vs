# GIFLIB utilities makefile to build with Visual Studio 2015
# Copyright (C) 2016 Kazuya Ujihara
#
# In: 
#	CONFIGURATION: Debug or Release
#	INSTALL_PREFIX: Where to install. Default is $(ProgemFiles).
#	SRCDIR: Location of utils directory. Default is current. Containig spaces is not allowed.
#	INCDIR: Location of lib directory. Default is $(SRCDIR)\..\lib.
#	GIF_LIB: like giflib5.lib. Default is giflib.lib
#	CFLAGS_OPT: Addtional CFLAGS
#

!IFNDEF SRCDIR
SRCDIR=.
!ENDIF

!IFNDEF INCDIR
INCDIR=$(SRCDIR)\..\lib
!ENDIF 

!IFNDEF CONFIGURATION
CONFIGURATION=Release
!ENDIF

!IFNDEF INSTALL_PREFIX
INSTALL_PREFIX=$(ProgemFiles)
!ENDIF

###################################################################

CFLAGS=/nologo /Zi /EHsc /W3
CFLAGS_DEBUG=/MDd /Od
CFLAGS_RELEASE=/MD /Ox /Gy /GL
LDFLAGS=/nologo
LDFLAGS_DEBUG=
LDFLAGS_RELEASE=/LTCG /OPT:REF
ARFLAGS=/nologo
ARFLAGS_DEBUG=
ARFLAGS_RELEASE=/LTCG

!IF "$(CONFIGURATION)" == "Debug"
CFLAGS=$(CFLAGS) $(CFLAGS_DEBUG)
LDFLAGS = $(LDFLAGS) $(LDFLAGS_DEBUG)
ARFLAGS = $(ARFLAGS) $(ARFLAGS_DEBUG)
!ELSEIF "$(CONFIGURATION)" == "Release"
CFLAGS = $(CFLAGS) $(CFLAGS_RELEASE)
LDFLAGS = $(LDFLAGS) $(LDFLAGS_RELEASE)
ARFLAGS = $(ARFLAGS) $(ARFLAGS_RELEASE)
!ELSE
!ERROR Unknown configuration '$(CONFIGURATION)'.
!ENDIF 

###################################################################

!IFNDEF GIF_LIB
GIF_LIB=giflib.lib
!ENDIF 

CFLAGS=$(CFLAGS) /D_CRT_SECURE_NO_WARNINGS /I "$(INCDIR)" $(CFLAGS_OPT)

# Declare the include files and libraries for the GIF utils:
GIF_INC_DEPEND = $(GIF_LIB) "$(INCDIR)\gif_lib.h" "$(INCDIR)getarg.h

# The no-install programs are test pattern generators and example code.
noinst_PROGRAMS = gifbg.exe gifcolor.exe giffilter.exe gifhisto.exe gifsponge.exe gifwedge.exe

bin_PROGRAMS = \
	gif2rgb.exe \
	gifbuild.exe \
	gifecho.exe \
	giffix.exe \
	gifinto.exe \
	giftext.exe \
	giftool.exe \
	gifclrmp.exe

BINARIES = $(bin_PROGRAMS) $(noinst_PROGRAMS)

all: $(BINARIES)

{$(SRCDIR)}.c{}.exe: 
	$(CC) $(CFLAGS) libgetarg.lib "$(GIF_LIB)" $< 

clean:
	for %%i in ($(BINARIES)) do if exist "%%~pni.*" del /Q "%%~pni.*"

install-all:
	for %%i in ($(bin_PROGRAMS)) do XCOPY /Y /D %%i $(INSTALL_PREFIX)\bin

.PHONY: all clean install-all

