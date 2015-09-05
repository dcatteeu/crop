Shell script that removes white border around images. Supports many
types of images by relying on several file type specific crop tools
such as EPSTOOL and ImageMagick.

Makes a backup of the original image (same name but with a ~
attached). The backup file is overwritten if it already existed.



Dependencies
------------

Requires EPSTOOL to crop EPS files, PDFCROP to crop PDF files, and
ImageMagick's CONVERT to crop bitmap images (JPEG, PNG, TIFF,
...). These command line programs should be available on the search
path.

EPSTOOL: See
http://pages.cs.wisc.edu/~ghost/gsview/epstool.htm. Available for
MacOS through homebrew.

PDFCROP: See http://pdfcrop.sourceforge.net but may already be
installed on your system if you use (La)TeX.

ImageMagick: See http://www.imagemagick.org. Available for MacOS
through Homebrew.



Usage
-----

$ crop.sh [-v] <image>

Where <image> is the path to a bitmap (JPEG, PNG, TIFF, ...) or vector
graphics image (EPS, PDF, ...).

The optional option -v activates verbose output.