#!/usr/bin/env bash

# pdf_find_ranges.sh - Find page ranges based on text markers in PDFs
#
# Description:
#   Scans a PDF and identifies page ranges separated by a text marker.
#   Used by pdf_split_on_marker.sh to determine where to split.
#
# Usage:
#   ./pdf_find_ranges.sh <input.pdf> [marker]
#
# Arguments:
#   input.pdf   PDF file to scan
#   marker      Text marker to search for (default: "End of Report")
#
# Output:
#   Page ranges in format "start-end", one per line
#   Example: 1-5
#            6-12
#            13-18
#
# Requirements:
#   - pdfinfo (from poppler-utils)
#   - pdftotext (from poppler-utils)
#
# Install on macOS:
#   brew install poppler
#
# Examples:
#   ./pdf_find_ranges.sh reports.pdf
#   ./pdf_find_ranges.sh reports.pdf "END OF DOCUMENT"
#
# Author: Jamie Albright
# Date: 2026-01-20

set -euo pipefail

PDF="${1:?Usage: pdf_find_ranges.sh input.pdf [marker]}"
MARKER="${2:-End of Report}"

# Check if required tools are installed
if ! command -v pdfinfo &> /dev/null; then
    echo "Error: pdfinfo not found. Install with: brew install poppler" >&2
    exit 1
fi

if ! command -v pdftotext &> /dev/null; then
    echo "Error: pdftotext not found. Install with: brew install poppler" >&2
    exit 1
fi

# Check if PDF exists
if [ ! -f "$PDF" ]; then
    echo "Error: File not found: $PDF" >&2
    exit 1
fi

# Get total pages
TOTAL_PAGES="$(pdfinfo "$PDF" | awk '/^Pages:/ {print $2}')"

starts=(1)
ends=()

for ((p=1; p<=TOTAL_PAGES; p++)); do
  # Extract just this page as text
  page_txt="$(pdftotext -f "$p" -l "$p" -layout "$PDF" - 2>/dev/null | tr -d '\f')"

  # Marker match (case-insensitive)
  if printf "%s" "$page_txt" | grep -qi -- "$MARKER"; then
    ends+=("$p")
    if (( p < TOTAL_PAGES )); then
      starts+=("$((p+1))")
    fi
  fi
done

# Always end at last page
ends+=("$TOTAL_PAGES")

# Print ranges: start-end (one per line)
for i in "${!starts[@]}"; do
  echo "${starts[$i]}-${ends[$i]}"
done
