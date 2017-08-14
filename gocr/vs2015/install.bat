@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

If "%Config%" == "" Set Config=Release

@Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

Set SolutionDir=%~dp0.

if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)


Set DestDir=%INSTALL_PREFIX%\bin\gocr

Set OutDir=%Config%
if "%$PLATFORM%" == "x64" Set OutDir=x64\%OutDir%

MSBuild gocr.sln /m /p:Configuration=%Config%,Platform=%$PLATFORM%
if errorlevel 1 goto :EBye

Set STATIC_LIB_RELEASE=Pgm2asc\%OutDir%\libPgm2asc.lib
Set SHARED_DLL=
Set SHARED_LIB=
Set INCLUDES=..\src\pgm2asc.h ..\src\pnm.h ..\src\unicode.h ..\src\list.h ..\src\output.h ..\src\gocr.h ..\src\list.h ..\src\output.h include\config.h
Set EXES=gocr\%OutDir%\gocr.exe

if not exist "%DestDir%" mkdir "%DestDir%"
if not exist "%DestDir%\bin" mkdir "%DestDir%\bin"
if not exist "%DestDir%\lib" mkdir "%DestDir%\lib"
if not exist "%DestDir%\include" mkdir "%DestDir%\include"

Set STATIC_LIB=%STATIC_LIB_RELEASE%
for %%i in ( %INCLUDES% ) do XCOPY /Y /D /I "%SolutionDir%\%%i" "%DestDir%\include"
if not "%STATIC_LIB%" == "" XCOPY /Y /D /I "%STATIC_LIB%" "%DestDir%\lib"
if not "%SHARED_LIB%" == ""  XCOPY /Y /D /I "%SHARED_LIB%" "%DestDir%\lib"
if not "%SHARED_DLL%" == ""  XCOPY /Y /D /I "%SHARED_DLL%" "%DestDir%\bin"
for %%i in ( %EXES% ) do XCOPY /Y /D /I "%%i" "%DestDir%\bin"

:EBye
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
