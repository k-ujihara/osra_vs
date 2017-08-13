@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

Set $PLATFORM=x86
if /I "%Platform%" == "X64" Set $PLATFORM=x64
MSBuild ocrad.sln /p:Configuration=Release,Platform=%$PLATFORM%

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

if errorlevel 1 goto :EBye
Set $OUTDIR=Release
if /I "%Platform%" == "X64" Set $OUTDIR=x64\%$OUTDIR%


pushd %$OUTDIR%
for %%i in ( ocrad-0.dll ocrad.exe ) do XCOPY /D /Y /I %%i "%INSTALL_PREFIX%\bin"
for %%i in ( libocrad.lib ocrad-0.lib ) do XCOPY /D /Y /I %%i "%INSTALL_PREFIX%\lib"
popd
XCOPY /D /Y ..\ocradlib.h "%INSTALL_PREFIX%\include"


:EBye
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
