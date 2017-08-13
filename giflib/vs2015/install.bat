@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

@Set $PLATFORM=x86
@if "%Platform%" == "X64" Set $PLATFORM=x64

if not exist "%INSTALL_BASE%" md "%INSTALL_BASE%"
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

MSBuild giflib.sln /p:Configuration=Release,Platform=%$PLATFORM%

Set STATIC_LIB_RELEASE=
Set STATIC_LIB_DEBUG=
Set SHARED_DLL=giflib.dll
Set SHARED_LIB=giflib.lib
Set INCLUDES=..\lib\gif_lib.h
Set EXES=gif2rgb.exe gifbuild.exe gifecho.exe giffix.exe gifinto.exe giftext.exe giftool.exe gifclrmp.exe

Set OutDir=Release

Set STATIC_LIB=%STATIC_LIB_RELEASE%
for %%i in ( %INCLUDES% ) do XCOPY /Y /D /I "%%i" "%INSTALL_PREFIX%\include"
if not "%STATIC_LIB%" == "" XCOPY /Y /D /I "%OutDir%\%STATIC_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_LIB%" == ""  XCOPY /Y /D /I "%OutDir%\%SHARED_LIB%" "%INSTALL_PREFIX%\lib"
if not "%SHARED_DLL%" == ""  XCOPY /Y /D /I "%OutDir%\%SHARED_DLL%" "%INSTALL_PREFIX%\bin"
for %%i in ( %EXES% ) do XCOPY /Y /D /I "%OutDir%\%%i" "%INSTALL_PREFIX%\bin"



@Set $PLATFORM=
@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
