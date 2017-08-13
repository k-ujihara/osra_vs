cd "%~dp0"

rem We don't use original jmorecfg.h.
if exist ..\jmorecfg.h ren ..\jmorecfg.h jmorecfg.h.bak

rem Use Visual C++ version.
copy ..\jconfig.vc jpeg\jconfig.h

