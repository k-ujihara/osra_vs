@setlocal
@pushd "%~dp0"
@if not "%VisualStudioVersion%" == "" Set HAS_VSDEV=TRUE
@if not "%HAS_VSDEV%" == "TRUE" CALL "%VS140COMNTOOLS%VsDevCmd.bat" %1
copy ..\include\version.h include

if not exist _original mkdir _original
if not exist _original\barcode.c MOVE ..\src\barcode.c _original
patch -o ..\src\barcode.c _original\barcode.c barcode.c.diff

@popd
@if not "%HAS_VSDEV%" == "TRUE" pause
@endlocal