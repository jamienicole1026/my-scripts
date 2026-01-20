# PDF Splitting Scripts - Usage Examples

These two scripts work together to split multi-document PDFs into separate files.

## How It Works

1. **pdf_find_ranges.sh** scans the PDF and finds pages containing your marker text
2. **pdf_split_on_marker.sh** uses those ranges to split the PDF using qpdf

## Installation

First, install the required tools:

```bash
brew install qpdf poppler
```

## Basic Usage

### Example 1: Split batch reports

You have a PDF with multiple reports, each ending with "End of Report":

```bash
./pdf_split_on_marker.sh batch_reports.pdf
```

**Output:**
```
Scanning PDF for marker: 'End of Report'...
Wrote /path/to/batch_reports/chunk_01_1-5.pdf
Wrote /path/to/batch_reports/chunk_02_6-12.pdf
Wrote /path/to/batch_reports/chunk_03_13-18.pdf
Done! Created 3 PDF files.
```

### Example 2: Custom marker

If your PDFs use a different separator:

```bash
./pdf_split_on_marker.sh documents.pdf "--- PAGE BREAK ---"
```

### Example 3: Custom output prefix

Name your output files meaningfully:

```bash
./pdf_split_on_marker.sh assessments.pdf "End of Report" report
```

**Output:**
```
report_01_1-5.pdf
report_02_6-12.pdf
report_03_13-18.pdf
```

## Advanced Usage

### Preview ranges before splitting

Check what the script will do without actually splitting:

```bash
./pdf_find_ranges.sh batch_reports.pdf
```

**Output:**
```
1-5
6-12
13-18
```

This shows you'll get 3 PDFs with those page ranges.

### Custom marker examples

Common markers to look for:

```bash
# Medical/psychological reports
./pdf_split_on_marker.sh reports.pdf "End of Report"

# Legal documents
./pdf_split_on_marker.sh contracts.pdf "END OF DOCUMENT"

# Scanned forms
./pdf_split_on_marker.sh forms.pdf "New Record"

# Custom separator
./pdf_split_on_marker.sh file.pdf "==== SPLIT HERE ===="
```

### Case-insensitive matching

The marker search is case-insensitive, so these all work:

```bash
./pdf_split_on_marker.sh file.pdf "end of report"
./pdf_split_on_marker.sh file.pdf "End of Report"
./pdf_split_on_marker.sh file.pdf "END OF REPORT"
```

## Real-World Workflow

### Batch processing scanned reports

1. Scan multiple reports into one PDF
2. Make sure each report ends with "End of Report" (or your marker)
3. Run the script:

```bash
./pdf_split_on_marker.sh scanned_batch.pdf "End of Report" patient_report
```

4. Get individual files:
```
patient_report_01_1-8.pdf
patient_report_02_9-15.pdf
patient_report_03_16-23.pdf
```

### Processing downloaded documents

Sometimes you download a bundle of PDFs concatenated together:

```bash
# Check the structure first
./pdf_find_ranges.sh bundle.pdf "Document End"

# Split them up
./pdf_split_on_marker.sh bundle.pdf "Document End" extracted
```

## Troubleshooting

### "Error: pdfinfo not found"

Install poppler:
```bash
brew install poppler
```

### "Error: qpdf not found"

Install qpdf:
```bash
brew install qpdf
```

### No splits happening

- Check that your marker text actually appears in the PDF
- Try viewing the PDF as text: `pdftotext yourfile.pdf -`
- The marker is case-insensitive but must match exactly

### Script can't find pdf_find_ranges.sh

Make sure both scripts are in the same directory:
```bash
ls -l files/
# Should show:
# pdf_find_ranges.sh
# pdf_split_on_marker.sh
```

## Tips

1. **Test first** - Use `pdf_find_ranges.sh` to preview before splitting
2. **Consistent markers** - Standardize your "End of Report" text
3. **Backup originals** - Keep the original PDF just in case
4. **Batch friendly** - Can run in loops for multiple files
5. **Flexible markers** - Works with any text that appears at split points

## Script Chaining

Process multiple PDFs at once:

```bash
for pdf in *.pdf; do
    echo "Processing $pdf..."
    ./pdf_split_on_marker.sh "$pdf" "End of Report" "split_${pdf%.pdf}"
done
```
