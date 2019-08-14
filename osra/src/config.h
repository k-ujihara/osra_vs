/******************************************************************************
 OSRA: Optical Structure Recognition Application

 Created by Igor Filippov, 2007-2013 (igor.v.filippov@gmail.com)

 This program is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License as published by the Free Software
 Foundation; either version 2 of the License, or (at your option) any later
 version.

 This program is distributed in the hope that it will be useful, but WITHOUT ANY
 WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 PARTICULAR PURPOSE.  See the GNU General Public License for more details.

 You should have received a copy of the GNU General Public License along with
 this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
 St, Fifth Floor, Boston, MA 02110-1301, USA
 *****************************************************************************/

/* Tell CImg library that there is not going to be a X11-capable display attached. It doesn't matter for Linux hosts, but matters for OS X. */
#define cimg_display_type 0

/* Define to the full name of this package. */
#define PACKAGE_NAME "osra"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "osra 2.1.0"

/* Define to the version of this package. */
#define PACKAGE_VERSION "2.1.0"

/* Define the location of data files. */
#define DATA_DIR "C:/Users/Public/share"

/* Is tesseract library present? */
/* #define HAVE_TESSERACT_LIB 1 */

/* Is cuneiform library present? */
/* #undef HAVE_CUNEIFORM_LIB */
