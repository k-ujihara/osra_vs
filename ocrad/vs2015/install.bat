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

Set $OUTDIR=%Config%
if /I "%Platform%" == "X64" Set $OUTDIR=x64\%$OUTDIR%

for %%i in ( ocrad-0\%$OUTDIR%\ocrad-0.dll ocrad\%$OUTDIR%\ocrad.exe ) do XCOPY /D /Y /I %%i "%INSTALL_PREFIX%\bin"
for %%i in ( libocrad\%$OUTDIR%\libocrad.lib ocrad-0\%$OUTDIR%\ocrad-0.lib ) do XCOPY /D /Y /I %%i "%INSTALL_PREFIX%\lib"
XCOPY /D /Y ..\ocradlib.h "%INSTALL_PREFIX%\include"

:EBye
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
