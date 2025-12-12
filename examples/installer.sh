#!/usr/bin/env bash
# ==============================================================================
# Example: Installation Script with User Input
# ==============================================================================
# Demonstrates interactive prompts and configuration with bash-toolbox.
# ==============================================================================

# Source the library (local first, remote fallback)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"
if [[ -f "${SCRIPT_DIR}/src/prefix.sh" ]]; then
  source "${SCRIPT_DIR}/src/prefix.sh"
else
  source <(curl -s https://raw.githubusercontent.com/MorganKryze/bash-toolbox/main/src/prefix.sh)
fi

# Configuration
LOG_LEVEL=0  # Show debug messages

# Main script
header "APPLICATION INSTALLER"

info "Welcome to the application installer"
echo

# Get user input
app_name=$(input "Application name" "MyApp")
install_dir=$(input "Installation directory" "/usr/local/bin")
debug "User selected: app_name=${app_name}, install_dir=${install_dir}"

echo

# Confirm configuration
info "Installation configuration:"
echo "  Application: ${app_name}"
echo "  Directory: ${install_dir}"
echo

if ! prompt "Is this correct?" "y"; then
  warning "Installation cancelled"
  exit 0
fi

# Simulate installation steps
action "Checking system requirements..."
sleep 1
success "System requirements met"

action "Downloading ${app_name}..."
for i in {1..100}; do
  progress_bar $i 100 30
  sleep 0.02
done
success "Download complete"

action "Installing ${app_name}..."
sleep 1
success "Installation complete"

action "Configuring ${app_name}..."
sleep 1
success "Configuration complete"

# Final message
separator "="
success "🎉 ${app_name} has been installed successfully!"
echo
info "Installation location: ${install_dir}/${app_name}"
hint "Run '${app_name} --help' to get started"
echo

acknowledge "Installation finished"
