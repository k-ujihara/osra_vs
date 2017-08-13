@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

Set BaseDir=%~dp0..

if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

Rem In:

Set BUILD_GUI=OFF
Set ENABLE_TESTS=OFF
Set BUILD_SHARED=ON
Set CSHARP_BINDINGS=OFF
Set JAVA_BINDINGS=OFF
Set PYTHON_BINDINGS=OFF
Set ENABLE_CAIRO=OFF

: If "%WXWIN%" == "" Set WXWIN=C:\wxWidgets-3.1.0
If "%EIGEN3_INCLUDE_DIR%" == "" Set EIGEN3_INCLUDE_DIR=C:\eigen-eigen-07105f7124f9
: If "%SWIG_EXECUTABLE%" == "" Set SWIG_EXECUTABLE=C:\swigwin-2.0.12
:Set SWIG_EXECUTABLE=C:\swigwin-3.0.10

Set WXWIN_LIB_DIR=%WXWIN%\lib\vc140_dll
if "%Platform%" == "X64" Set WXWIN_LIB_DIR=%WXWIN%\lib\vc140_x64_dll

@Set CFLAGS=
@Rem babelconfig.h decides exsistence of several function by definition of WIN32 macro, but it is normally not defined to make 64bit binary.
@if "%Platform%" == "X64" Set CFLAGS=%CFLAGS% /DWIN32
@Set CFLAGS=%CFLAGS% /D_SILENCE_STDEXT_HASH_DEPRECATION_WARNINGS /I%BaseDir%

@Set RUN_SWIG=OFF
@if "%CSHARP_BINDINGS%" == "ON" Set RUN_SWIG=ON
@if "%JAVA_BINDINGS%" == "ON" Set RUN_SWIG=ON
@if "%PYTHON_BINDINGS%" == "ON" Set RUN_SWIG=ON

@if "%Platform%" == "" Set CFLAGS=%CFLAGS% /DWIN32

@echo off
@CALL "cmake_setvar.bat"
@echo on

@if "%BUILD_PLATFORM%" == "x86" Set ARCH_DIR=i386
@if "%BUILD_PLATFORM%" == "x64" Set ARCH_DIR=x64

Set CMAKE_OPT=%CMAKE_OPT% -DMINIMAL_BUILD=OFF
Set CMAKE_OPT=%CMAKE_OPT% -DZLIB_LIBRARY="%INSTALL_PREFIX%\lib\zlib.lib" -DZLIB_INCLUDE_DIR="%INSTALL_PREFIX%\include"
Set CMAKE_OPT=%CMAKE_OPT% -DLIBXML2_LIBRARIES="%INSTALL_PREFIX%\lib\libxml2.lib" -DLIBXML2_INCLUDE_DIR="%INSTALL_PREFIX%\include\libxml2"
Set CMAKE_OPT=%CMAKE_OPT% -DINCHI_LIBRARY="%INSTALL_PREFIX%\lib\libinchi.lib" -DINCHI_INCLUDE_DIR="%INSTALL_PREFIX%\include\inchi"

If NOT "%ENABLE_CAIRO%" == "ON" Set CMAKE_OPT=%CMAKE_OPT% -DHAVE_CAIRO=FALSE -DCAIRO_FOUND=FALSE
If "%ENABLE_CAIRO%" == "ON" if "%BUILD_PLATFORM%" == "x86" (
	Set CMAKE_OPT=%CMAKE_OPT% -DCAIRO_LIBRARIES="%BaseDir%\%pathtolib%\%ARCH_DIR%\cairo.lib" 
	Set CMAKE_OPT=%CMAKE_OPT% -DCAIRO_INCLUDE_DIRS="%BaseDir%\%pathtoinclude%\cairo"
)
Set CMAKE_OPT=%CMAKE_OPT% -DHAVE_RPC_XDR_H=FALSE

if "%JAVA_BINDINGS%" == "ON" Set CMAKE_OPT=%CMAKE_OPT% -DJAVA_BINDINGS=%JAVA_BINDINGS% 
if "%PYTHON_BINDINGS%" == "ON" Set CMAKE_OPT=%CMAKE_OPT% -DPYTHON_BINDINGS=%PYTHON_BINDINGS%
if "%CSHARP_BINDINGS%" == "ON" (
	if not exist "%BaseDir%\windows-vc2008" mklink /d "%BaseDir%\windows-vc2008" "%BaseDir%\msvc-dependencies"
	if not exist "%BaseDir%\windows-vc2008\Distribution" mklink /d "%BaseDir%\windows-vc2008\Distribution" "%BaseDir%\windows-vc2008\dist"
	Set CMAKE_OPT=%CMAKE_OPT% -DCSHARP_BINDINGS=%CSHARP_BINDINGS%
)
Set CMAKE_OPT=%CMAKE_OPT% -DCSHARP_EXECUTABLE="%FrameworkDir%%FrameworkVersion%\csc.exe"
Set CMAKE_OPT=%CMAKE_OPT% -DRUN_SWIG=%RUN_SWIG%

if "%RUN_SWIG%" == "ON" If Not "%SWIG_EXECUTABLE%" == "" Set CMAKE_OPT=%CMAKE_OPT% -DSWIG_EXECUTABLE=%SWIG_EXECUTABLE%\swig.exe -DSWIG_DIR=%SWIG_EXECUTABLE%

@Set CMAKE_OPT=%CMAKE_OPT% -DBUILD_GUI=%BUILD_GUI%
If Not "%WXWIN%" == "" Set CMAKE_OPT=%CMAKE_OPT% -DwxWidgets_ROOT_DIR="%WXWIN%" -DwxWidgets_LIB_DIR="%WXWIN_LIB_DIR%" -DwxWidgets_CONFIGURATION=msw 

@if "%BUILD_GUI%" == "ON" (
	@if "%BUILD_SHARED%" == "ON" (
		@echo BUILD_GUI=ON.
	) else (
		@echo BUILD_SHARED should be ON when BUILD_GUI=ON.
		@EXIT /b 1
	)
)
@Set CMAKE_OPT=%CMAKE_OPT% -DENABLE_TESTS=%ENABLE_TESTS% 
If Not "%EIGEN3_INCLUDE_DIR%" == "" Set CMAKE_OPT=%CMAKE_OPT% -DEIGEN3_INCLUDE_DIR=%EIGEN3_INCLUDE_DIR% 
@Set CMAKE_OPT=%CMAKE_OPT% -DBUILD_SHARED=%BUILD_SHARED% 

@pushd "%BUILD_DIR%"
@Set CMAKE_OPT=%CMAKE_OPT%
cmake -Wno-dev %CMAKE_OPT%  ..\..

@Rem Copy all dependencies to out-dir
@if not exist bin mkdir bin
for %%i in ( Debug Release ) do if not exist bin\%%i mkdir bin\%%i
for %%i in ( Debug Release ) do XCOPY /D /Y "%BaseDir%\%pathtolib%\%ARCH_DIR%\*.dll" bin\%%i
for %%j in ( libxml2.dll zlib1.dll iconv.dll libinchi.dll ) do for %%i in ( Debug Release ) do XCOPY /D /Y "%INSTALL_PREFIX%\bin\%%j" bin\%%i
for %%i in ( Debug Release ) do XCOPY /D /Y "%WXWIN%\lib\vc140_dll" bin\%%i
@if "%BUILD_PLATFORM%" == "x86" (
	for %%j in ( jsoncpp.dll ) do for %%i in ( Debug Release ) do XCOPY /D /Y "%BaseDir%\msvc-dependencies\libs-vs12\%ARCH_DIR%\%%j" bin\%%i
)


@popd

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause

GOTO :End

:AddOptIfExist

@if not exist "%~2" GOTO :AddOptIfExist1
@Set CMAKE_OPT=%CMAKE_OPT% -D%~1_LIBRARIES="%~2"
@if "%~3" == "" GOTO :AddOptIfExist1
@Set CMAKE_OPT=%CMAKE_OPT% -D%~1_INCLUDE_DIR="%~3"
:AddOptIfExist1
@EXIT /b

:End
@endlocal
