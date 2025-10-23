#!/bin/zsh

# Script to check for Alamofire and HTTPTypes symbols in framework binaries

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check for symbols in a framework
check_framework() {
    local framework_path="$1"
    local framework_name=$(basename "$framework_path" .framework)
    
    if [[ ! -f "$framework_path" ]]; then
        echo "${RED}✗${NC} $framework_name: Binary not found"
        return
    fi
    
    echo "\n${YELLOW}Checking $framework_name:${NC}"
    
    local symbols=("${@:2}")
    for symbol in "${symbols[@]}"; do
        local count=$(nm "$framework_path" 2>/dev/null | grep -i "$symbol" | wc -l | xargs)
        if [[ $count -gt 0 ]]; then
            echo "  ${GREEN}✓${NC} $symbol: Found ($count symbols)"
        else
            echo "  ${RED}✗${NC} $symbol: Not found"
        fi
    done
}

# Main script
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <path_to_xcarchive_or_app> [symbol1] [symbol2] ..."
    echo ""
    echo "Arguments:"
    echo "  path_to_xcarchive_or_app  Path to .xcarchive or .app bundle"
    echo "  symbol1, symbol2, ...     Optional: Symbols to search for (default: alamofire, httptype)"
    echo ""
    echo "Examples:"
    echo "  $0 /path/to/App.xcarchive"
    echo "  $0 /path/to/App.app alamofire httptype"
    echo "  $0 /path/to/App.xcarchive combine swiftui"
    echo ""
    exit 1
fi

ARCHIVE_PATH="$1"
shift

# Default symbols to check if none provided
if [[ $# -eq 0 ]]; then
    SYMBOLS=("alamofire" "httptype")
else
    SYMBOLS=("$@")
fi

# Determine the path to the Frameworks directory
if [[ "$ARCHIVE_PATH" == *.xcarchive ]]; then
    FRAMEWORKS_DIR="$ARCHIVE_PATH/Products/Applications/$(basename "$ARCHIVE_PATH" .xcarchive | sed 's/ [0-9][0-9]\.[0-9][0-9]\.[0-9][0-9], [0-9][0-9]\.[0-9][0-9]//').app/Frameworks"
elif [[ "$ARCHIVE_PATH" == *.app ]]; then
    FRAMEWORKS_DIR="$ARCHIVE_PATH/Frameworks"
else
    echo "${RED}Error: Please provide either a .xcarchive or .app path${NC}"
    exit 1
fi

if [[ ! -d "$FRAMEWORKS_DIR" ]]; then
    echo "${RED}Error: Frameworks directory not found at $FRAMEWORKS_DIR${NC}"
    exit 1
fi

echo "${YELLOW}========================================${NC}"
echo "${YELLOW}Framework Symbol Checker${NC}"
echo "${YELLOW}========================================${NC}"
echo "Archive/App: $ARCHIVE_PATH"
echo "Frameworks: $FRAMEWORKS_DIR"
echo "Searching for: ${SYMBOLS[*]}"

# Check each framework
for framework in "$FRAMEWORKS_DIR"/*.framework; do
    if [[ -d "$framework" ]]; then
        framework_name=$(basename "$framework" .framework)
        binary_path="$framework/$framework_name"
        check_framework "$binary_path" "${SYMBOLS[@]}"
    fi
done

echo "\n${YELLOW}========================================${NC}"
