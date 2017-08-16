# OSRA built by Visual Studio
OSRA <https://cactus.nci.nih.gov/osra/> built by Visual Studio 2015.

## How to build

Execute build.bat in Native Tools Command Prompt. It creates dependency binaries in a Release\bin dirctory. 
After that, execute build_osra.bat to create OSRA executable and the library. Binaries are created in Release directory.

CMAKE is required.
File path including spaces can be troublesome.

The following versions are used to make it.

osra-2.1.0
zlib-1.2.11
libpng-1.6.21
giflib-5.1.4
jpeg-9b
jbigkit-2.1
tiff-4.0.6
libxml2-2.9.3
GraphicsMagick-1.3.23
gocr-0.50pre
ocrad-0.25
potrace-1.15
openbabel-2.4.1
INCHI-1.0.4
tesseract-3.04.01
leptonica-1.73
tclap-1.2.1
