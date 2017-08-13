@cd "%~dp0"
@if "%VisualStudioVersion%" == "" Set NO_VSDEV=ON
@if "%NO_VSDEV%" == "ON" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1
call setbuildvar.bat
@pushd %BUILD_DIR%
nmake tests
@popd

@if "%NO_VSDEV%" == "ON" pause