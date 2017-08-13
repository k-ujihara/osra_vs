@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1
cd "%~dp0.."
for /r %%i in ( *.orig ) do echo %%i && GOTO :GoN
cd "%~dp0"
patch -b -f -p0 -d .. < vs14-ocrad-0.25.diff
:GoN
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
