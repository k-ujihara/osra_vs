@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set DIR=build
@if "%Platform%" == "X64" Set DIR=%DIR%_x64
@if "%Platform%" == "" Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

@pushd
MSBuild tesseract.sln /p:Configuration=DLL_Release

if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

Set DestIncl=%INSTALL_PREFIX%\include\tesseract
if not exist %DestIncl% mkdir %DestIncl%
Set DestLib=%INSTALL_PREFIX%\lib
Set DestBin=%INSTALL_PREFIX%\bin
XCOPY /D /Y DLL_Release\libtesseract304.dll "%DestBin%"
XCOPY /D /Y DLL_Release\libtesseract304.lib "%DestLib%"
cd ..
XCOPY /D /Y api\*.h %DestIncl%
XCOPY /D /Y ccmain\*.h %DestIncl%
XCOPY /D /Y ccutil\*.h %DestIncl%
XCOPY /D /Y ccstruct\*.h %DestIncl%
XCOPY /D /Y classify\*.h %DestIncl%
XCOPY /D /Y cube\*.h %DestIncl%
XCOPY /D /Y cutil\*.h %DestIncl%
XCOPY /D /Y dict\*.h %DestIncl%
XCOPY /D /Y image\*.h %DestIncl%
XCOPY /D /Y neural_networks\runtime\*.h %DestIncl%
XCOPY /D /Y textord\*.h %DestIncl%
XCOPY /D /Y viewer\*.h %DestIncl%
XCOPY /D /Y wordrec\*.h %DestIncl%
XCOPY /D /Y opencl\*.h %DestIncl%

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal

