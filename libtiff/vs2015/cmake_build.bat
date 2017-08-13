@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set CFLAGS=/DHAVE_SNPRINTF /DWIN32
@echo off
CALL "cmake_setvar.bat"
@echo on
@Set CMAKE_OPT=%CMAKE_OPT% -DZLIB_LIBRARY="%INSTALL_PREFIX%\lib\zlib.lib" -DZLIB_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DJPEG_LIBRARY="%INSTALL_PREFIX%\lib\jpeg.lib" -DJPEG_INCLUDE_DIR="%INSTALL_PREFIX\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DJBIG_LIBRARY="%INSTALL_PREFIX%\lib\jbig1.lib" -DJBIG_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DBUILD_SHARED_LIBS=ON
@pushd "%BUILD_DIR%"
cmake %CMAKE_OPT% ..\..
@popd
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal