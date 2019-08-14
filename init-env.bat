Set Config=Release
Set INSTALL_BASE=%~dp0%Config%

If Not Exist "%INSTALL_BASE%" md "%INSTALL_BASE%"
If "%INSTALL_PREFIX%" == "" (
	If /I "%Platform%" == "X64" (
		Set INSTALL_PREFIX=%INSTALL_BASE%\x64
	) else (
		Set INSTALL_PREFIX=%INSTALL_BASE%
	)
)

if not exist "%INSTALL_PREFIX%" md "%INSTALL_PREFIX%"
if not exist "%INSTALL_PREFIX%\bin" md "%INSTALL_PREFIX%\bin"
if not exist "%INSTALL_PREFIX%\lib" md "%INSTALL_PREFIX%\lib"
if not exist "%INSTALL_PREFIX%\include" md "%INSTALL_PREFIX%\include"

Set EIGEN3_INCLUDE_DIR=%~dp0eigen-eigen-323c052e1731
Set WXWIN=%~dp0wxMSW-3.1.2

@Path %~dp0bat;%PATH%
