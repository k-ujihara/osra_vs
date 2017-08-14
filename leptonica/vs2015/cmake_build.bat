@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

Set BUILD=build

if not exist %BUILD% mkdir %BUILD%
cd %BUILD%

Set CFLAGS=/I%INSTALL_PREFIX%\include
Set LDFLAGS=/LIBPATH:%INSTALL_PREFIX%\lib

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
