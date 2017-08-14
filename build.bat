pushd "%~dp0"

CALL "%VS140COMNTOOLS%VsDevCmd.bat"

Set Config=Release
SET INSTALL_BASE=%~dp0%Config%

if not exist "%INSTALL_BASE%" md "%INSTALL_BASE%"
if "%INSTALL_PREFIX%" == "" (
	if /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

md %INSTALL_PREFIX%
md %INSTALL_PREFIX%\bin
md %INSTALL_PREFIX%\lib
md %INSTALL_PREFIX%\include

del /Q bin
mklink /D bin %INSTALL_PREFIX%\bin
del /Q lib
mklink /D lib %INSTALL_PREFIX%\lib
del /Q include
mklink /D include %INSTALL_PREFIX%\include

PATH %~dp0bat;%PATH%

call gocr\vs2015\install
call ocrad\vs2015\install
call potrace\vs2015\install

call zlib\vs2015\cmake_build
call zlib\vs2015\install

call libpng\vs2015\cmake_build
call libpng\vs2015\install

call giflib\vs2015\install
call libjpeg\vs2015\install
call jbigkit\vs2015\install

call libtiff\vs2015\cmake_build
call libtiff\vs2015\install

call win-iconv\vs2015\cmake_build
call win-iconv\vs2015\install

call libxml2\vs2015\install

call INCHI-1-API\vs2015\install

call openbabel\vs2015\cmake_build
Rem openbabel\vs2015\cmake_build needs to be called twice
call openbabel\vs2015\cmake_build
call openbabel\vs2015\install

call leptonica\vs2015\cmake_build
call leptonica\vs2015\install

call tesseract\vs2015\install

call GraphicsMagick\vs2015\install

XCOPY /Y /D /I tclap\include\tclap\*.h %INSTALL_PREFIX%\include\tclap


pause

