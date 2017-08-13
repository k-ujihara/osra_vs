@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

for %%i in ( vs2015-Q8 vs2015-Q8-x64 ) do (
	@CALL :FMD ..\%%i\bin
	XCOPY /D /Y ..\VisualMagick\bin\*.* ..\%%i\bin
	@CALL :FMD ..\%%i\lib
	XCOPY /D /Y ..\VisualMagick\lib\*.* ..\%%i\lib
)

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
GOTO :End

:FMD
@if not exist "%~1" mkdir "%~1"
@EXIT /b

:End
@endlocal
