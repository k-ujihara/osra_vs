@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1
@Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64
@Set BUILD_DIR=build
@if "%Platform%" == "X64" Set BUILD_DIR=%BUILD_DIR%_x64
@pushd "%BUILD_DIR%"
MSBuild INSTALL.vcxproj /p:Configuration=Release,Platform=%$PLATFORM%
@popd
@Set $PLATFORM=
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal
