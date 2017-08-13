# OSRA built by Visual Studio
OSRA <https://cactus.nci.nih.gov/osra/> built by Visual Studio 2015.

## How to build

Execute build.bat, which creates dependency binaries in a Release\bin dirctory.
Execute osra\vs2015\compile.bat to create OSRA executable and the library. Binaries are created in Release directory.

CMAKE is required.
Path incljding space is not supported. (You can avoid it by useing MKLINK.)

The following versions are used to make it.

zlib-1.2.11
libpng-1.6.21
giflib-5.1.4
jpeg-9b
jbigkit-2.1
tiff-4.0.6
libxml2-2.9.3
GraphicsMagick-1.3.23
gocr-0.50
ocrad-0.25
potrace-1.13
openbabel-2.4.1
INCHI-1.0.4
tesseract-3.04.01
leptonica-1.73
osra-2.0.1
tclap-1.2.1
