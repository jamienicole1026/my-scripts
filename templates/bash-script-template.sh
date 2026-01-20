#!/bin/bash

# script-name.sh - Brief description
#
# Description:
#   Longer description of what this script does.
#
# Usage:
#   ./script-name.sh [options] <arguments>
#
# Options:
#   -h, --help     Show this help message
#   -v, --verbose  Enable verbose output
#
# Example:
#   ./script-name.sh example.txt
#
# Author: Jamie Albright
# Date: $(date +%Y-%m-%d)

set -euo pipefail  # Exit on error, undefined variables, pipe failures

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Global variables
VERBOSE=0
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function: Print usage information
usage() {
    cat << EOF
Usage: $(basename "$0") [options] <arguments>

Description:
    Brief description of what the script does.

Options:
    -h, --help     Show this help message
    -v, --verbose  Enable verbose output

Examples:
    $(basename "$0") example.txt
    $(basename "$0") -v file1.txt file2.txt

EOF
    exit 0
}

# Function: Log message (only if verbose)
log() {
    if [ "$VERBOSE" -eq 1 ]; then
        echo -e "${GREEN}[INFO]${NC} $*" >&2
    fi
}

# Function: Print error message and exit
error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
    exit 1
}

# Function: Print warning message
warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -v|--verbose)
            VERBOSE=1
            shift
            ;;
        -*)
            error "Unknown option: $1"
            ;;
        *)
            # Positional arguments
            break
            ;;
    esac
done

# Check for required arguments
if [ $# -eq 0 ]; then
    error "Missing required argument. Use -h for help."
fi

# Main script logic starts here
main() {
    local input="$1"
    
    log "Starting script..."
    log "Input: $input"
    
    # Check if input file exists (example)
    if [ ! -f "$input" ]; then
        error "File not found: $input"
    fi
    
    # Your script logic here
    echo "Processing: $input"
    
    log "Script completed successfully"
}

# Run main function with all arguments
main "$@"
