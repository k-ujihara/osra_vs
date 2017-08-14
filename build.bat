pushd "%~dp0"

Call init-env.bat

Call "%VS140COMNTOOLS%VsDevCmd.bat"

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

popd

