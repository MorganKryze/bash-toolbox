#!/usr/bin/env bash
# ==============================================================================
# Example: Simple Script with Bash Toolbox
# ==============================================================================
# Demonstrates basic usage of bash-toolbox in a simple script.
# ==============================================================================

# Source the library (local first, remote fallback)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"
if [[ -f "${SCRIPT_DIR}/src/prefix.sh" ]]; then
  source "${SCRIPT_DIR}/src/prefix.sh"
else
  source <(curl -s https://raw.githubusercontent.com/MorganKryze/bash-toolbox/main/src/prefix.sh)
fi

# Main script
header "SIMPLE EXAMPLE"

info "Starting the process..."
sleep 1

action "Processing data..."
sleep 1

success "Process completed successfully!"

separator

hint "This is a simple example of bash-toolbox usage"
