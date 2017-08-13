@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@CALL :CPIE INCHI
@CALL :CPIE INCHI_API

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
GOTO :End

:CPIE
if not exist "..\%~1\vc14" (
	mkdir "..\%~1\vc14"
	XCOPY /S /Y "%~1\vc14\*.*" "..\%~1\vc14"
)
@EXIT /b

:End
@endlocal
