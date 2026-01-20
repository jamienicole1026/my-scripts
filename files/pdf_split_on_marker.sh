#!/usr/bin/env bash

# pdf_split_on_marker.sh - Split PDF into chunks based on text markers
#
# Description:
#   Splits a PDF file into multiple smaller PDFs wherever a text marker
#   appears. Useful for splitting batch reports or multi-document PDFs.
#
# Usage:
#   ./pdf_split_on_marker.sh <input.pdf> [marker] [out_prefix]
#
# Arguments:
#   input.pdf    PDF file to split
#   marker       Text marker to split on (default: "End of Report")
#   out_prefix   Output filename prefix (default: "chunk")
#
# Output:
#   Creates multiple PDFs in the same directory as the input:
#   - chunk_01_1-5.pdf
#   - chunk_02_6-12.pdf
#   - chunk_03_13-18.pdf
#   etc.
#
# Requirements:
#   - qpdf
#   - poppler-utils (pdfinfo, pdftotext)
#   - pdf_find_ranges.sh (companion script in same directory)
#
# Install on macOS:
#   brew install qpdf poppler
#
# Examples:
#   ./pdf_split_on_marker.sh batch_reports.pdf
#   ./pdf_split_on_marker.sh reports.pdf "END OF DOCUMENT" report
#   ./pdf_split_on_marker.sh file.pdf "Page Break" output
#
# How it works:
#   1. Uses pdf_find_ranges.sh to find pages containing the marker
#   2. Splits PDF at those pages using qpdf
#   3. Names output files with sequential numbers and page ranges
#
# Author: Jamie Albright
# Date: 2026-01-20

set -euo pipefail

PDF="${1:?Usage: pdf_split_on_marker.sh input.pdf [marker] [out_prefix]}"
MARKER="${2:-End of Report}"
PREFIX="${3:-chunk}"

# Check if required tools are installed
if ! command -v qpdf &> /dev/null; then
    echo "Error: qpdf not found. Install with: brew install qpdf" >&2
    exit 1
fi

# Check if PDF exists
if [ ! -f "$PDF" ]; then
    echo "Error: File not found: $PDF" >&2
    exit 1
fi

# Find the companion script in the same directory as this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIND_RANGES="$SCRIPT_DIR/pdf_find_ranges.sh"

if [ ! -f "$FIND_RANGES" ]; then
    echo "Error: Cannot find pdf_find_ranges.sh in $SCRIPT_DIR" >&2
    echo "Make sure both scripts are in the same directory." >&2
    exit 1
fi

# Folder + base name
DIR="$(cd "$(dirname "$PDF")" && pwd)"
BASE="$(basename "$PDF" .pdf)"

echo "Scanning PDF for marker: '$MARKER'..."
i=1
while IFS= read -r range; do
  out="${DIR}/${PREFIX}_$(printf "%02d" "$i")_${range}.pdf"
  qpdf --warning-exit-0 "$PDF" --pages . "$range" -- "$out"
  echo "Wrote $out"
  i=$((i + 1))
done < <("$FIND_RANGES" "$PDF" "$MARKER")

echo "Done! Created $((i-1)) PDF files."
