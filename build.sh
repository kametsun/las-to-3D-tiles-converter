#!/bin/bash

set -e

LAS_FILES_PATH="${1:-las_files}"
CRS="${2:-EPSG:6676}"

if [ ! -d "$LAS_FILES_PATH" ]; then
  echo "error: Directory $LAS_FILES_PATH not found."
  exit 1
fi

mkdir -p output

echo "Building Docker image."
docker build -t las-to-3dtiles .

echo "Converting LAS files to $LAS_FILES_PATH to 3D Tiles."
docker run --rm -v "$(pwd)/$LAS_FILES_PATH:/data/input" -v "$(pwd)/output:/data/output" las-to-3dtiles \
  gocesiumtiler folder \
  --join \
  --crs $CRS \
  -o /data/output \
  /data/input

echo "Conversion completed. Results are stored in the output directory."