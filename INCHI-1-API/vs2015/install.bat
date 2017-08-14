@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@if "%Platform%" == "" Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

@CALL setup
@pushd ..\INCHI_API\vc14\inchi_dll
MSBuild inchi_dll.vcxproj /m /p:Configuration=Release,Platform=%$PLATFORM%
@popd
@pushd ..\INCHI\vc14\inchi-1
MSBuild inchi-1.vcxproj /m /p:Configuration=Release,Platform=%$PLATFORM%
@popd

if "%INSTALL_PREFIX%" == "" (
	if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
)
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

@Set $ARCH_DIR=
@if "%Platform%" == "X64" Set $ARCH_DIR=x64\

XCOPY /D /Y "..\INCHI\vc14\inchi-1\%$ARCH_DIR%Release\inchi-1.exe" "%INSTALL_PREFIX%\bin"
XCOPY /D /Y "..\INCHI_API\vc14\inchi_dll\%$ARCH_DIR%Release\libinchi.dll" "%INSTALL_PREFIX%\bin"
XCOPY /D /Y "..\INCHI_API\vc14\inchi_dll\%$ARCH_DIR%Release\libinchi.lib" "%INSTALL_PREFIX%\lib"
@CALL :FMD "%INSTALL_PREFIX%\include\inchi"
XCOPY /D /Y "..\INCHI_API\inchi_dll\*.h" "%INSTALL_PREFIX%\include\inchi"

@Set $PLATFORM=
@Set $ARCH_DIR=
@Set $PLATFORM=

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@GOTO :End

:FMD
@if not exist "%~1" mkdir "%~1"
@EXIT /b

:End
@endlocal
