#!/bin/bash

# getpdfs.sh - Download all PDF files from a webpage
# 
# Description:
#   Recursively downloads all PDF files linked from a given URL.
#   Uses wget to crawl the page and fetch only PDF files.
#
# Usage:
#   ./getpdfs.sh https://example.com/page.html
#
# Options:
#   -r          Recursive download
#   -l1         Limit recursion depth to 1 level (only the specified page)
#   -nd         No directories - save all files to current directory
#   -A pdf      Accept only PDF files
#   --content-disposition  Use filename from Content-Disposition header if available
#   -e robots=off  Ignore robots.txt (use responsibly!)
#
# Example:
#   ./getpdfs.sh https://research.example.com/papers.html
#
# Notes:
#   - PDFs will be saved to the current directory
#   - Make sure you have permission to download the content
#   - The script ignores robots.txt, so use responsibly

URL="$1"

if [ -z "$URL" ]; then
  echo "Usage: ./getpdfs.sh https://example.com/page.html"
  exit 1
fi

wget \
  -r \
  -l1 \
  -nd \
  -A pdf \
  --content-disposition \
  -e robots=off \
  "$URL"
