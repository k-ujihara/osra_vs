@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

Rem *** For shared version ***

@Set BUILD_DIR_SUFFIX=_shared
@echo off
@CALL "cmake_setvar.bat"
@echo on

@pushd "%BUILD_DIR%"
@Set CMAKE_OPT=%CMAKE_OPT% -DZLIB_LIBRARY="%INSTALL_PREFIX%\lib\zlib.lib" -DZLIB_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DPNG_SHARED=ON
@Set CMAKE_OPT=%CMAKE_OPT% -DPNG_STATIC=OFF
@Set CMAKE_OPT=%CMAKE_OPT% -DPNG_TESTS=ON
cmake %CMAKE_OPT%  ..\..
@popd

Rem *** For static version ***

@Set BUILD_DIR_SUFFIX=_static
@echo off
@CALL "cmake_setvar.bat"
@echo on
@pushd "%BUILD_DIR%"
@Set CMAKE_OPT=%CMAKE_OPT% -DZLIB_LIBRARY="%INSTALL_PREFIX%\lib\zdll.lib" -DZLIB_INCLUDE_DIR="%INSTALL_PREFIX%\include"
@Set CMAKE_OPT=%CMAKE_OPT% -DPNG_SHARED=OFF
@Set CMAKE_OPT=%CMAKE_OPT% -DPNG_STATIC=ON
@Set CMAKE_OPT=%CMAKE_OPT% -DPNG_TESTS=ON
cmake %CMAKE_OPT%  ..\..
@popd

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal

