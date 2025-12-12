#!/usr/bin/env bash
# ==============================================================================
# BASH TOOLBOX - Demo Script
# ==============================================================================
# This script demonstrates all available functions in the bash-toolbox library.
# ==============================================================================

# Source the library (local first, remote fallback)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "${SCRIPT_DIR}/src/prefix.sh" ]]; then
  source "${SCRIPT_DIR}/src/prefix.sh"
else
  source <(curl -s https://raw.githubusercontent.com/MorganKryze/bash-toolbox/main/src/prefix.sh)
fi

# ==============================================================================
# DEMONSTRATION
# ==============================================================================

header "BASH TOOLBOX DEMO"
echo

# Basic colored messages
echo -e "${BOLD}1. Basic Colored Messages:${RESET}"
blue "This is a blue message"
green "This is a green message"
cyan "This is a cyan message"
gray "This is a gray message"
echo

# Log levels
echo -e "${BOLD}2. Log Levels (with timestamps and icons):${RESET}"
debug "Debug message - for detailed troubleshooting"
info "Info message - general information"
hint "Hint message - helpful suggestions"
action "Action message - something is happening"
warning "Warning message - potential issue"
success "Success message - operation completed"
error "Error message - something went wrong" || true
echo

# Configuration examples
echo -e "${BOLD}3. Configuration Options:${RESET}"
info "Current settings:"
echo "  • ENABLE_TIMESTAMPS: ${ENABLE_TIMESTAMPS}"
echo "  • ENABLE_COLORS: ${ENABLE_COLORS}"
echo "  • ENABLE_ICONS: ${ENABLE_ICONS}"
echo "  • LOG_LEVEL: ${LOG_LEVEL}"
echo

# Disable timestamps temporarily
echo -e "${BOLD}4. Without Timestamps:${RESET}"
ENABLE_TIMESTAMPS=false
info "This message has no timestamp"
success "Timestamp disabled temporarily"
ENABLE_TIMESTAMPS=true
echo

# Disable icons temporarily
echo -e "${BOLD}5. Without Icons:${RESET}"
ENABLE_ICONS=false
warning "This message has no icon"
error "Icon disabled temporarily" || true
ENABLE_ICONS=true
echo

# Progress bar demo
echo -e "${BOLD}6. Progress Bar:${RESET}"
for i in {0..100..10}; do
  progress_bar $i 100
  sleep 0.1
done
echo

# Separator and header
echo -e "${BOLD}7. Separators and Headers:${RESET}"
separator
separator "-"
separator "~"
echo
header "CUSTOM HEADER"
echo

# Description
echo -e "${BOLD}8. Function Description:${RESET}"
description "demo.sh" "demonstrates all bash-toolbox features"

# User prompts
echo -e "${BOLD}9. User Prompts:${RESET}"
if prompt "Do you like this demo?" "y"; then
  success "Great! Thank you for trying bash-toolbox!"
else
  hint "Try exploring the features in your own scripts!"
fi
echo

name=$(input "What's your name?" "Developer")
info "Hello, ${name}!"
echo

# Log levels filtering
echo -e "${BOLD}10. Log Level Filtering (LOG_LEVEL=2):${RESET}"
LOG_LEVEL=2
debug "This debug message is hidden (level 0)"
info "This info message is hidden (level 1)"
warning "This warning is shown (level 2)"
error "This error is shown (level 3)" || true
LOG_LEVEL=0
echo

# File logging demo
echo -e "${BOLD}11. File Logging:${RESET}"
LOG_FILE="/tmp/bash-toolbox-demo.log"
info "Logging to file: ${LOG_FILE}"
debug "This goes to both terminal and file"
success "File logging enabled"
info "Check ${LOG_FILE} to see the log output"
LOG_FILE=""
echo

# Final separator
separator "="
echo
success "Demo completed successfully!"
hint "Check the source code in src/prefix.sh for more details"
echo
acknowledge "Demo finished"
