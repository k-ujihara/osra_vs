@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

MSBuild potrace.sln /p:Configuration=Release,Platform=%$PLATFORM%

If "%INSTALL_PREFIX%" == "" (
	If "%INSTALL_BASE%" == "" Set INSTALL_BASE=%USERPROFILE% 
	If "%$PLATFORM%" == "X64" Set INSTALL_BASE=%INSTALL_BASE%\x64
	Set INSTALL_PREFIX=%INSTALL_BASE%
)

Set Config=Release

Set STATIC_LIB_RELEASE=libpotrace.lib
Set STATIC_LIB_DEBUG=libpotraced.lib
Set SHARED_DLL=
Set SHARED_LIB=
Set INCLUDES=..\src\potracelib.h
Set EXES=potrace.exe mkbitmap.exe

if not exist "%INSTALL_PREFIX%" mkdir "%INSTALL_PREFIX%"
if not exist "%INSTALL_PREFIX%\bin" mkdir "%INSTALL_PREFIX%\bin"
if not exist "%INSTALL_PREFIX%\lib" mkdir "%INSTALL_PREFIX%\lib"
if not exist "%INSTALL_PREFIX%\include" mkdir "%INSTALL_PREFIX%\include"

Set $OUTDIR=%Config%
if /I "%Platform%" == "X64" Set $OUTDIR=x64\%$OUTDIR%

Set STATIC_LIB=%STATIC_LIB_RELEASE%
for %%i in ( %INCLUDES% ) do XCOPY /Y /D "%%i" "%INSTALL_PREFIX%\include"

if not "%STATIC_LIB%" == "" XCOPY /Y /D "%$OutDir%\%STATIC_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_LIB%" == "" XCOPY /Y /D "%$OutDir%\%SHARED_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_DLL%" == "" XCOPY /Y /D "%$OutDir%\%SHARED_DLL%" "%INSTALL_PREFIX%\bin"
for %%i in ( %EXES% ) do XCOPY /Y /D "%$OutDir%\%%i" "%INSTALL_PREFIX%\bin"

@Set $PLATFORM=

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
