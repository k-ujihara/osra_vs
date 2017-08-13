@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@pushd "%~dp0.."

del /Q windows-vc2008\Distribution
del /Q windows-vc2008

@popd

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal