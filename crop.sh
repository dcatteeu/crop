#!/bin/bash

# Universal crop tool. Removes white border around images. Supports
# many types of images.

# Requires EPSTOOL to crop EPS files, PDFCROP to crop PDF files, and
# ImageMagick's CONVERT to crop bitmap images (JPEG, PNG, TIFF,
# ...). These command line programs should be available on the search
# path.

# Makes a backup of the original image (same name but with a ~
# attached.

# TODO: Handle multiple files: crop.sh <img1> <img2> ...
# TODO: Allow specific output filename with option '-o <filename>'.

# Usage: crop.sh [-v] <image>
# <image>: Filename of a bitmap (JPEG, PNG, TIFF, ...) or vector graphics image (EPS, PDF, ...).
# -v: Activate verbose output.

# Parse options.
while getopts :v opt; do
    case "$opt" in
	v) verbose="on";;
	*) echo "ERROR: unknown option" ${opt}; exit 4;;
    esac
done
shift $[ $OPTIND - 1 ]

# Verify input file.
input_file="${1}"
! [ -f "${input_file}" ] && echo "ERROR: image does not exist or is not a file!" && exit 1
! [ -r "${input_file}" ] && echo "ERROR: image not readable!" && exit 2

# Get filetype
filetype=$(file -I -b "${input_file}" | cut -f1 -d';')
[[ -n ${verbose} ]] && echo "INFO: filetype is" ${filetype}

# Create backup.
backup_file="${input_file}~"
mv "${input_file}" "${backup_file}"
if [ $? -eq 0 ]; then
    [[ -n ${verbose} ]] && echo "INFO: created backup" ${backup_file}
else
    echo "ERROR: could not create backup file" ${backup_file}
    exit 3
fi

if [ ${filetype} == "application/postscript" ]; then
    # For EPS, use EPSTOOL. This probably doesn't work with PS, but
    # who uses PS?
    if [[ -n ${verbose} ]]; then
	echo "INFO: image is EPS, using EPSTOOL"
    else
	options="--quiet"
    fi
    epstool ${options} --copy --bbox "${backup_file}" "${input_file}"
elif [ ${filetype} == "application/pdf" ]; then
    # For PDF, use PDFCROP.
    if [[ -n ${verbose} ]]; then
	echo "INFO: image is PDF, using PDFCROP"
	options="--verbose" #By default PDFCROP is (almost) silent.
    fi
    pdfcrop ${options} "${backup_file}" "${input_file}"
else
    # For bitmap images, use CONVERT.
    [[ -n ${verbose} ]] && echo "INFO: image is not EPS or PDF, using CONVERT"
    convert "${backup_file}" -trim "${input_file}"
fi
