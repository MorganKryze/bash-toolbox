#!/usr/bin/env bash
# ==============================================================================
# Example: Simple Script with Bash Toolbox
# ==============================================================================
# Demonstrates basic usage of bash-toolbox in a simple script.
# ==============================================================================

# Source the library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"
source "${SCRIPT_DIR}/src/prefix.sh"

# Main script
header "SIMPLE EXAMPLE"

info "Starting the process..."
sleep 1

action "Processing data..."
sleep 1

success "Process completed successfully!"

separator

hint "This is a simple example of bash-toolbox usage"
