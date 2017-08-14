for /D /R %%d in ( vs2015\build* ) do rmdir /Q/S %%d
for /D /R %%d in ( DLL_Release* ) do rmdir /Q/S %%d
for /D /R %%d in ( DLL_Debug* ) do rmdir /Q/S %%d
for /D /R %%d in ( LIB_Release* ) do rmdir /Q/S %%d
for /D /R %%d in ( LIB_Debug* ) do rmdir /Q/S %%d
for /D /R %%d in ( Release ) do rmdir /Q/S %%d
for /D /R %%d in ( Debug ) do rmdir /Q/S %%d

rmdir /Q/S GraphicsMagick\vs2015-Q8\bin
rmdir /Q/S GraphicsMagick\vs2015-Q8\lib
rmdir /Q/S GraphicsMagick\vs2015-Q8-x64\bin
rmdir /Q/S GraphicsMagick\vs2015-Q8-x64\lib

pause

