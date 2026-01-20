# File Scripts

Scripts for file manipulation, conversion, and organization.

## Available Scripts

### pdf_split_on_marker.sh
Split a PDF into multiple files based on a text marker.

**Usage:**
```bash
./pdf_split_on_marker.sh batch_reports.pdf
./pdf_split_on_marker.sh reports.pdf "END OF DOCUMENT" report
```

**Perfect for:**
- Splitting batch reports that all say "End of Report"
- Breaking up multi-document PDFs
- Processing scanned document batches

**Requirements:** `qpdf`, `poppler` (install with `brew install qpdf poppler`)

### pdf_find_ranges.sh
Helper script that finds page ranges based on text markers. Used by `pdf_split_on_marker.sh`.

**Usage:**
```bash
./pdf_find_ranges.sh reports.pdf
./pdf_find_ranges.sh reports.pdf "Page Break"
```

**Output:** Page ranges like `1-5`, `6-12`, `13-18`

## Script Ideas

### File Conversion
- PDF to text extraction
- Image format conversion (jpg → png, etc.)
- Audio/video format conversion
- Document to PDF conversion

### File Organization
- Bulk file renaming
- Sorting files by date/type
- Duplicate file finder
- File cleanup utilities

### Batch Operations
- Resize images in bulk
- Compress files
- Extract archives
- Merge PDFs

## Example Use Cases
- Organizing downloads folder
- Preparing files for archiving
- Batch processing scanned documents
