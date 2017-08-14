@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1

if "%INSTALL_BASE%" == "" Set INSTALL_BASE=%PUBLIC%
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

Set GMTYPE=GraphicsMagick-Q8
if "%Platform%" == "" (
	Set GM_INSTALL_PREFIX=%INSTALL_PREFIX%\bin\%GMTYPE%
) else if "%Platform%" == "X64" (
	Set GM_INSTALL_PREFIX=%INSTALL_PREFIX%\x64\bin\%GMTYPE%
)

echo %GM_INSTALL_PREFIX%

if "%Platform%" == "" (
	Set GM_INSTALL_PREFIX=%INSTALL_PREFIX%\bin\%GMTYPE%
	cd ..\vs2015-Q8
	CALL :InstallTarget x86
) else if "%Platform%" == "X64" (
	Set GM_INSTALL_PREFIX=%INSTALL_PREFIX%\x64\bin\%GMTYPE%
	cd ..\vs2015-Q8-x64
	CALL :InstallTarget x64
)



@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@GOTO :End

:InstallTarget
MSBuild VisualDynamicMT.sln /m /p:Configuration=Release,Platform=%1
if ERRORLEVEL 1 EXIT /b %ERRORLEVEL% 

@CALL :FMD "%GM_INSTALL_PREFIX%"
@CALL :FMD "%GM_INSTALL_PREFIX%\bin"
@CALL :FMD "%GM_INSTALL_PREFIX%\lib"
@CALL :FMD "%GM_INSTALL_PREFIX%\include"

Rem Executables 

@pushd ..\VisualMagick\bin
XCOPY /D /Y *.mgk "%GM_INSTALL_PREFIX%\bin" 
@popd
@pushd bin
for %%i in ( gm.exe dcraw.exe ) do XCOPY /D /Y %%i "%GM_INSTALL_PREFIX%\bin"
COPY imdisplay.exe gmdisplay.exe
XCOPY /D /Y gmdisplay.exe "%GM_INSTALL_PREFIX%\bin"

XCOPY /D /Y CORE_RL*.dll "%GM_INSTALL_PREFIX%\bin" 
XCOPY /D /Y IM_MOD_RL*.dll "%GM_INSTALL_PREFIX%\bin" 
XCOPY /D /Y analyze.dll "%GM_INSTALL_PREFIX%\bin"
@popd 
@pushd lib
XCOPY /D /Y CORE_RL*.lib "%GM_INSTALL_PREFIX%\lib" 
XCOPY /D /Y IM_MOD_RL*.lib "%GM_INSTALL_PREFIX%\lib" 
XCOPY /D /Y analyze.lib "%GM_INSTALL_PREFIX%\lib"
@popd

@pushd ..
XCOPY /D /Y magick\GraphicsMagick.ico "%GM_INSTALL_PREFIX%\bin"
Rem Headers
@CALL :FMD "%GM_INSTALL_PREFIX%\include\magick"
@CALL :FMD "%GM_INSTALL_PREFIX%\include\wand"
@CALL :FMD "%GM_INSTALL_PREFIX%\include\Magick++"
XCOPY /D /Y magick\*.h "%GM_INSTALL_PREFIX%\include\magick"
for %%i in ( drawing_wand.h  magick_wand.h  pixel_wand.h  wand_api.h ) do XCOPY /D /Y "wand\%%i" "%GM_INSTALL_PREFIX%\include\wand" 
XCOPY /D /Y "Magick++\lib\Magick++.h" "%GM_INSTALL_PREFIX%\include" 
XCOPY /D /Y "Magick++\lib\Magick++\*.h" "%GM_INSTALL_PREFIX%\include\Magick++" 
@popd

@Set $A=
@EXIT /b

:FMD
@if not exist "%~1" mkdir "%~1"  
@EXIT /b

:End
@endlocal
