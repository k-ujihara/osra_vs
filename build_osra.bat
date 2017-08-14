@pushd "%~dp0"

Call "%VS140COMNTOOLS%VsDevCmd.bat"

Call init-env.bat
Call osra\vs2015\compile.bat

@popd

pause
