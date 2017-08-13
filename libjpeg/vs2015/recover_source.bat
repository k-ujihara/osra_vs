cd "%~dp0"

rem We don't use original jmorecfg.h.
if exist ..\jmorecfg.h.bak (
	copy ..\jmorecfg.h.bak ..\jmorecfg.h
	del /Q ..\jmorecfg.h.bak
)
