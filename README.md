Shell script that removes white border around images. Supports many image types by relying on several file type specific crop tools such as `epstool` and ImageMagick.

Makes a backup of the original image (same name but with a `~` attached).

# Dependencies

Requires `epstool` to crop `eps` files, `pdfcrop` to crop `pdf` files, and ImageMagick's `convert` to crop bitmap images (`jpeg`, `png`, `tiff`, ...). These command line programs should be available on the search path.

* [epstool](http://pages.cs.wisc.edu/~ghost/gsview/epstool.htm): Available for MacOS through [Homebrew](http://brew.sh).

* [pdfcrop](http://pdfcrop.sourceforge.net): May already be
installed on your system if you use (La)TeX.

* [ImageMagick](http://www.imagemagick.org): Popular command line tools and library for image manipulation. Available for MacOS through [Homebrew](http://brew.sh).

# Usage

    $ crop.sh [-v] <image>

Where `<image>` is the path to a bitmap (`jpeg`, `png`, `tiff`, ...) or vector graphics image (`eps`, `pdf`, ...).

The optional option `-v` activates verbose output.

# Code, Issues, Suggestions, ...

The [source code](https://github.com/dcatteeu/crop/) is available on GitHub. Please [report](https://github.com/dcatteeu/crop/issues/new) any bugs or suggestions via GitHub.
