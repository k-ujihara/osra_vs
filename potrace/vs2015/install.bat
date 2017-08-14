@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

if "%Config%" == "" Set Config=Release

@Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

MSBuild potrace.sln /m /p:Configuration=Release,Platform=%$PLATFORM%

If "%INSTALL_PREFIX%" == "" (
	If "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
)
If "%INSTALL_PREFIX%" == "" (
	If "%$PLATFORM%" == "X64" Set INSTALL_BASE=%INSTALL_BASE%\x64
	Set INSTALL_PREFIX=%INSTALL_BASE%
)

Set $OUTDIR=%Config%
if /I "%Platform%" == "X64" Set $OUTDIR=x64\%$OUTDIR%

Set STATIC_LIB_RELEASE=libpotrace\%$OUTDIR%\libpotrace.lib
Set STATIC_LIB_DEBUG=libpotrace\%$OUTDIR%\libpotraced.lib
Set SHARED_DLL=
Set SHARED_LIB=
Set INCLUDES=..\src\potracelib.h
Set EXES=potrace mkbitmap

if not exist "%INSTALL_PREFIX%" mkdir "%INSTALL_PREFIX%"
if not exist "%INSTALL_PREFIX%\bin" mkdir "%INSTALL_PREFIX%\bin"
if not exist "%INSTALL_PREFIX%\lib" mkdir "%INSTALL_PREFIX%\lib"
if not exist "%INSTALL_PREFIX%\include" mkdir "%INSTALL_PREFIX%\include"

Set STATIC_LIB=%STATIC_LIB_RELEASE%
for %%i in ( %INCLUDES% ) do XCOPY /Y /D "%%i" "%INSTALL_PREFIX%\include"

if not "%STATIC_LIB%" == "" XCOPY /Y /D /I "%STATIC_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_LIB%" == "" XCOPY /Y /D /I "%SHARED_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_DLL%" == "" XCOPY /Y /D /I "%SHARED_DLL%" "%INSTALL_PREFIX%\bin"
for %%i in ( %EXES% ) do XCOPY /Y /D /I "%%i\%$OutDir%\%%i.exe" "%INSTALL_PREFIX%\bin"

@Set $PLATFORM=

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
