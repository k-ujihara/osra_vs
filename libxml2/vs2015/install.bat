@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set BUILD_DIR=..\x86
@if "%Platform%" == "X64" @Set BUILD_DIR=..\x64

if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

@if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
XCOPY /D /Y /I ..\win32\*.* "%BUILD_DIR%"
copy "Makefile.msvc.replace" "%BUILD_DIR%\Makefile"

@pushd "%BUILD_DIR%"
call cscript configure.js zlib=yes prefix="%INSTALL_PREFIX%" vcmanifest=yes
@popd

@pushd "%BUILD_DIR%"
nmake install
@popd

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal

