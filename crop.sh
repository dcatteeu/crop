#!/bin/bash

# Universal crop tool. Removes white border around images. Supports
# many types of images.

# Requires EPSTOOL to crop EPS files, PDFCROP to crop PDF files, and
# ImageMagick's CONVERT to crop bitmap images (JPEG, PNG, TIFF,
# ...). These command line programs should be available on the search
# path.

# Makes a backup of the original image (same name but with a ~
# attached.

# Usage: crop.sh <image>
# <image>: Filename of a bitmap (JPEG, PNG, TIFF, ...) or vector graphics image (EPS, PDF, ...).

input_file="${1}"
if ! [ -f "${input_file}" ]; then
    echo "ERROR: image does not exist or is not a file!"
    exit 1
fi
if ! [ -r "${input_file}" ]; then
    echo "ERROR: image not readable!"
    exit 1
fi

filetype=$(file -I -b ${input_file} | cut -f1 -d';')

backup_file="${input_file}~"
mv ${input_file} ${backup_file}

if [ ${filetype} == "application/postscript" ]; then
    # For EPS, use EPSTOOL. This probably doesn't work with PS, but
    # who uses PS?
    echo "INFO: image is EPS, using EPSTOOL"
    epstool --copy --bbox "${backup_file}" "${input_file}"
elif [ ${filetype} == "application/pdf" ]; then
    # For PDF, use PDFCROP.
    echo "INFO: image is PDF, using PDFCROP"
    pdfcrop "${backup_file}" "${input_file}"
else
    # For bitmap images, use CONVERT.
    echo "INFO: image is not EPS, using CONVERT"
    convert "${backup_file}" -trim "${input_file}"
fi
