#!/usr/bin/env bash
# ==============================================================================
# Example: Backup Script with Error Handling
# ==============================================================================
# Demonstrates error handling and user prompts with bash-toolbox.
# ==============================================================================

# Source the library (local first, remote fallback)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"
if [[ -f "${SCRIPT_DIR}/src/prefix.sh" ]]; then
  source "${SCRIPT_DIR}/src/prefix.sh"
else
  source <(curl -s https://raw.githubusercontent.com/MorganKryze/bash-toolbox/main/src/prefix.sh)
fi

# Configuration
BACKUP_DIR="/tmp/backup-demo"
SOURCE_DIR="./src"
LOG_FILE="/tmp/backup-demo.log"

# Main script
header "BACKUP SCRIPT"

info "Backup configuration:"
echo "  Source: ${SOURCE_DIR}"
echo "  Destination: ${BACKUP_DIR}"
echo "  Log file: ${LOG_FILE}"
echo

# Confirm with user
if ! prompt "Proceed with backup?" "y"; then
  warning "Backup cancelled by user"
  exit 0
fi

# Check if source exists
action "Checking source directory..."
if [[ ! -d "$SOURCE_DIR" ]]; then
  error "Source directory not found: ${SOURCE_DIR}"
  fatal "Cannot continue without source directory" 1
fi
success "Source directory found"

# Create backup directory
action "Creating backup directory..."
if mkdir -p "$BACKUP_DIR"; then
  success "Backup directory created"
else
  error "Failed to create backup directory"
  exit 1
fi

# Simulate backup with progress
action "Backing up files..."
total=10
for i in $(seq 1 $total); do
  progress_bar $i $total
  sleep 0.2
done
success "Backup completed"

# Summary
separator
info "Backup summary:"
echo "  Files backed up: 10"
echo "  Total size: 1.5 MB"
echo "  Duration: 2 seconds"
echo

success "Backup operation completed successfully!"
hint "Check logs at: ${LOG_FILE}"
