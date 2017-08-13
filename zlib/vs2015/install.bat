@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1
@if "%Platform%" == "X64" Set $DIR_SIFFIX=_x64
@pushd build%$DIR_SIFFIX%
MSBuild INSTALL.vcxproj /p:Configuration=Release
@popd
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
