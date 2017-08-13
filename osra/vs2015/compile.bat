@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set DIR=build
@if "%Platform%" == "X64" Set DIR=%DIR%_x64
@if "%Platform%" == "" Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64


if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)


MSBuild osra.sln /p:Configuration=Release,Platform=%$PLATFORM%

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
