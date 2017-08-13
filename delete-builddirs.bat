for /D /R %%d in ( vs2015\build* ) do rmdir /Q/S %%d
for /D /R %%d in ( DLL_Release* ) do rmdir /Q/S %%d
for /D /R %%d in ( DLL_Debug* ) do rmdir /Q/S %%d
for /D /R %%d in ( LIB_Release* ) do rmdir /Q/S %%d
for /D /R %%d in ( LIB_Debug* ) do rmdir /Q/S %%d

pause

