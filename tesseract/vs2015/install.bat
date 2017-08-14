@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

If "%Config%" == "" Set Config=Release

@if "%Platform%" == "" Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

@pushd
MSBuild tesseract.sln /m /p:Configuration=DLL_%Config%,Platform=%$PLATFORM%

if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

Set OutDir=DLL_%Config%
if /I "%Platform%" == "X64" Set OutDir=x64\%OutDir%
Set DestIncl=%INSTALL_PREFIX%\include\tesseract
if not exist "%DestIncl%" mkdir "%DestIncl%"
Set DestLib=%INSTALL_PREFIX%\lib
Set DestBin=%INSTALL_PREFIX%\bin
XCOPY /D /Y /I libtesseract\%OutDir%\libtesseract304.dll "%DestBin%"
XCOPY /D /Y /I libtesseract\%OutDir%\libtesseract304.lib "%DestLib%"
cd ..
XCOPY /D /Y /I api\*.h "%DestIncl%"
XCOPY /D /Y /I ccmain\*.h "%DestIncl%"
XCOPY /D /Y /I ccutil\*.h "%DestIncl%"
XCOPY /D /Y /I ccstruct\*.h "%DestIncl%"
XCOPY /D /Y /I classify\*.h "%DestIncl%"
XCOPY /D /Y /I cube\*.h "%DestIncl%"
XCOPY /D /Y /I cutil\*.h "%DestIncl%"
XCOPY /D /Y /I dict\*.h "%DestIncl%"
XCOPY /D /Y /I image\*.h "%DestIncl%"
XCOPY /D /Y /I neural_networks\runtime\*.h "%DestIncl%"
XCOPY /D /Y /I textord\*.h "%DestIncl%"
XCOPY /D /Y /I viewer\*.h "%DestIncl%"
XCOPY /D /Y /I wordrec\*.h "%DestIncl%"
XCOPY /D /Y /I opencl\*.h "%DestIncl%"

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal

