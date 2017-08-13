@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

Set BUILD=build

if not exist %BUILD% mkdir %BUILD%
cd %BUILD%

Set CFLAGS=/I%PUBLIC%\include
Set LDFLAGS=/LIBPATH:%PUBLIC%\lib

@echo off
@CALL "cmake_setvar.bat"
@echo on

@Set CMAKE_OPT=%CMAKE_OPT% -DZLIB_LIBRARY="%INSTALL_PREFIX%\lib\zlib.lib" -DZLIB_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DGIF_LIBRARY="%INSTALL_PREFIX%\lib\giflib.lib" -DGIF_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DJPEG_LIBRARY="%INSTALL_PREFIX%\lib\jpeg.lib" -DJPEG_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DPNG_LIBRARY="%INSTALL_PREFIX%\lib\libpng16.lib" -DPNG_PNG_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DTIFF_LIBRARY="%INSTALL_PREFIX%\lib\tiff.lib" -DTIFF_INCLUDE_DIR="%INSTALL_PREFIX%\include"

cmake %CMAKE_OPT%  ..\..

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
