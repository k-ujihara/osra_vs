@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@CALL :FRD ..\INCHI\vc14
@CALL :FRD ..\INCHI_API\vc14

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
GOTO :End

:FRD
if exist "%~1" rmdir /S /Q "%~1"
@EXIT /b

:End
@endlocal
