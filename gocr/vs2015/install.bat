@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

Set SolutionDir=%~dp0.

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

if "%$PLATFORM%" == "x64" Set INSTALL_BASE=%INSTALL_PREFIX%\x64
Set OutDir=%~dp0.
if "%$PLATFORM%" == "x64" Set OutDir=%OutDir%\x64
Set OutDir=%OutDir%\Release

MSBuild gocr.sln /m /p:Configuration=Release,Platform=%$PLATFORM%
if errorlevel 1 goto :EBye

Set INSTALL_PREFIX=%INSTALL_BASE%\bin\gocr
Set STATIC_LIB_RELEASE=libPgm2asc.lib
Set SHARED_DLL=
Set SHARED_LIB=
Set INCLUDES=..\src\pgm2asc.h ..\src\pnm.h ..\src\unicode.h ..\src\list.h ..\src\output.h ..\src\gocr.h ..\src\list.h ..\src\output.h include\config.h
Set EXES=gocr.exe

if not exist "%INSTALL_PREFIX%" mkdir "%INSTALL_PREFIX%"
if not exist "%INSTALL_PREFIX%\bin" mkdir "%INSTALL_PREFIX%\bin"
if not exist "%INSTALL_PREFIX%\lib" mkdir "%INSTALL_PREFIX%\lib"
if not exist "%INSTALL_PREFIX%\include" mkdir "%INSTALL_PREFIX%\include"

Set STATIC_LIB=%STATIC_LIB_RELEASE%
for %%i in ( %INCLUDES% ) do XCOPY /Y /D "%SolutionDir%\%%i" "%INSTALL_PREFIX%\include"
if not "%STATIC_LIB%" == "" XCOPY /Y /D "%OutDir%\%STATIC_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_LIB%" == ""  XCOPY /Y /D "%OutDir%\%SHARED_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_DLL%" == ""  XCOPY /Y /D "%OutDir%\%SHARED_DLL%" "%INSTALL_PREFIX%\bin"
for %%i in ( %EXES% ) do XCOPY /Y /D "%OutDir%\%%i" "%INSTALL_PREFIX%\bin"

:EBye
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
