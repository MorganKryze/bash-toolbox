# Bash Toolbox v2.0.0 - Quick Reference

## Installation

```bash
source /path/to/bash-toolbox/src/prefix.sh
```

## Configuration

```bash
ENABLE_TIMESTAMPS=true   # Show/hide timestamps
ENABLE_COLORS=true       # Enable/disable colors (auto-detect)
ENABLE_ICONS=true        # Show/hide emoji icons
LOG_LEVEL=0              # 0=DEBUG, 1=INFO, 2=WARNING, 3=ERROR, 4=FATAL
LOG_FILE=""              # Optional file path for logging
```

## Basic Colors

```bash
blue "text"              # Blue colored text
green "text"             # Green colored text
cyan "text"              # Cyan colored text
gray "text"              # Gray colored text
```

## Log Levels (with timestamps & icons)

```bash
debug "message"          # 🔍 [  DEBUG ] Gray
info "message"           # ℹ️  [   INFO ] Blue
hint "message"           # 💡 [   HINT ] Yellow
action "message"         # ▶️  [ ACTION ] Blue
warning "message"        # ⚠️  [WARNING ] Orange
success "message"        # ✓ [SUCCESS ] Green
error "message"          # ✗ [  ERROR ] Red (returns 1)
fatal "message" [code]   # ☠️  [  FATAL ] Red (exits)
```

## Progress Indicators

```bash
spinner $pid "message"              # Animated spinner
progress_bar $current $max [$width] # Progress bar
```

## User Prompts

```bash
prompt "question?" "y/n"            # Yes/no confirmation (returns 0/1)
input "prompt" "default"            # Text input (returns value)
acknowledge "message"               # Wait for keypress
```

## Utilities

```bash
separator ["char"] [width]          # Display separator line
header "text"                       # Centered header with separators
description "name" "text"           # Function description
txt "message"                       # Plain text output
get_timestamp                       # Returns current timestamp
```

## Example Usage

```bash
#!/usr/bin/env bash
source /path/to/bash-toolbox/src/prefix.sh

header "MY SCRIPT"
info "Starting process..."

if prompt "Continue?" "y"; then
  action "Processing..."
  for i in {1..100}; do
    progress_bar $i 100
    sleep 0.01
  done
  success "Complete!"
else
  warning "Cancelled"
fi
```

## Files

- `src/prefix.sh` - Main library
- `demo.sh` - Full feature demo
- `tests.sh` - Test suite
- `examples/` - Example scripts
- `CHANGELOG.md` - Version history
- `README.md` - Full documentation

## Testing

```bash
./tests.sh           # Run all tests
./demo.sh            # See live demo
./examples/simple.sh # Run example
```

## Links

- Repository: <https://github.com/MorganKryze/bash-toolbox>
- License: MIT
- Author: @MorganKryze
