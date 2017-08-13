@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1
@pushd "%~dp0.."
for /r %%i in ( *.orig ) do copy "%%i" "%%~dpni" && del /Q "%%i"
for /r %%i in ( *.rej ) do del /Q "%%i"
del /Q Makefile.vc ocrad.def
@popd
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
