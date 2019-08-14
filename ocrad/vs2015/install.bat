@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@if "%Config%" == "" Set Config=Release

Set $PLATFORM=x86
if /I "%Platform%" == "X64" Set $PLATFORM=x64

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

MSBuild ocrad.sln /m /p:Configuration=Release,Platform=%$PLATFORM%
if errorlevel 1 goto :EBye

Set OutDir=%Config%
if /I "%Platform%" == "X64" Set OutDir=x64\%OutDir%

Set BINS=ocrad-0.dll ocrad.exe
Set LIBS=libocrad.lib ocrad-0.lib
pushd %OutDir%
if not exist "%INSTALL_PREFIX%\bin" md "%INSTALL_PREFIX%\bin"
for %%i in ( %BINS% ) do XCOPY /D /Y /I %%i "%INSTALL_PREFIX%\bin"
if not exist "%INSTALL_PREFIX%\lib" md "%INSTALL_PREFIX%\lib"
for %%i in ( %LIBS% ) do XCOPY /D /Y /I %%i "%INSTALL_PREFIX%\lib"
popd
if not exist "%INSTALL_PREFIX%\include" md "%INSTALL_PREFIX%\include"
XCOPY /D /Y ..\ocradlib.h "%INSTALL_PREFIX%\include"

:EBye
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
