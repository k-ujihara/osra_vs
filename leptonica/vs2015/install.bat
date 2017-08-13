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

@pushd %DIR%
MSBuild src\leptonica.vcxproj /p:Configuration=Release,Platform=%$PLATFORM%
@popd

Set DestIncl=%INSTALL_PREFIX%\include\leptonica
Set DestLib=%INSTALL_PREFIX%\lib
Set DestBin=%INSTALL_PREFIX%\bin

XCOPY /D /Y /I ..\src\*.h "%DestIncl%"
XCOPY /D /Y /I build\src\Release\lept173.lib "%DestLib%"
XCOPY /D /Y /I build\bin\Release\lept173.dll "%DestBin%"


@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal

