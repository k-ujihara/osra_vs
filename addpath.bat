pushd %~dp0

if "%INSTALL_PREFIX%" == "" Call init-env.bat

Path %INSTALL_PREFIX%\bin\GraphicsMagick-Q8\bin;%INSTALL_PREFIX%\bin;%INSTALL_PREFIX%\bin;%Path%

popd
