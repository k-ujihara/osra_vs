@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

@If "%Config%" == "" Config=Release

@if /I "%Platform%" == "X64" Set $DIR_SIFFIX=_x64
@pushd build%$DIR_SIFFIX%
MSBuild INSTALL.vcxproj /m /p:Configuration=%Config%,Platform=%$PLATFORM%
@popd

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
