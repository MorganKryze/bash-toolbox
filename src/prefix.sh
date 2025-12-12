#!/usr/bin/env bash
# ==============================================================================
# BASH TOOLBOX - Logging and UI Utilities
# ==============================================================================
# Author: Morgan Kryze
# Repository: https://github.com/MorganKryze/bash-toolbox
# Version: 2.0.0
# Description: A comprehensive bash utility library for colored logging,
#              user prompts, and terminal UI elements.
# ==============================================================================

# ================================ CONFIGURATION ===================================

# Enable/disable timestamps (default: enabled)
: "${ENABLE_TIMESTAMPS:=true}"

# Enable/disable colored output (default: auto-detect)
if [[ -z "${ENABLE_COLORS}" ]]; then
  if [[ -t 1 ]] && command -v tput >/dev/null 2>&1 && [[ $(tput colors 2>/dev/null) -ge 8 ]]; then
    ENABLE_COLORS=true
  else
    ENABLE_COLORS=false
  fi
fi

# Log level control (DEBUG=0, INFO=1, WARNING=2, ERROR=3, FATAL=4)
: "${LOG_LEVEL:=0}"

# Enable/disable emoji icons (default: enabled)
: "${ENABLE_ICONS:=true}"

# Log file path (default: disabled, set to enable file logging)
: "${LOG_FILE:=}"

# ==================================== COLORS ======================================

if [[ "${ENABLE_COLORS}" == "true" ]]; then
  GREEN='\033[0;32m'
  BLUE='\033[0;34m'
  RED='\033[0;31m'
  ORANGE='\033[0;33m'
  YELLOW='\033[1;33m'
  CYAN='\033[0;36m'
  GRAY='\033[0;90m'
  RESET='\033[0m'
  BOLD='\033[1m'
  DIM='\033[2m'
  UNDERLINE='\033[4m'
else
  GREEN=''
  BLUE=''
  RED=''
  ORANGE=''
  YELLOW=''
  CYAN=''
  GRAY=''
  RESET=''
  BOLD=''
  DIM=''
  UNDERLINE=''
fi

# ================================== FUNCTIONS =====================================

# Returns the current timestamp in "YYYY-MM-DD HH:MM:SS" format.
# Output: Timestamp string
get_timestamp() {
  date +"%Y-%m-%d %T"
}

# Internal logging function with file support.
# $1: Level name
# $2: Color code
# $3: Icon (optional)
# $4: Message
_log_message() {
  local level="$1"
  local color="$2"
  local icon="$3"
  local message="$4"
  local timestamp=""
  local log_line=""
  
  # Check log level filter
  local level_num=0
  case "$level" in
    DEBUG) level_num=0 ;;
    INFO) level_num=1 ;;
    WARNING) level_num=2 ;;
    ERROR) level_num=3 ;;
    FATAL) level_num=4 ;;
  esac
  
  if [[ $level_num -lt $LOG_LEVEL ]]; then
    return
  fi
  
  # Build timestamp
  if [[ "${ENABLE_TIMESTAMPS}" == "true" ]]; then
    timestamp="[${color}$(get_timestamp)${RESET}] "
  fi
  
  # Left-align the level text within 7 characters
  local aligned_level="$(printf "%-7s" "$level")"
  
  # Build log line
  if [[ "${ENABLE_ICONS}" == "true" && -n "$icon" ]]; then
    log_line="${timestamp}${icon} [${color}${aligned_level}${RESET}] ${color}${message}${RESET}"
  else
    log_line="${timestamp}[${color}${aligned_level}${RESET}] ${color}${message}${RESET}"
  fi
  
  # Output to terminal
  echo -e "$log_line"
  
  # Output to log file if configured
  if [[ -n "$LOG_FILE" ]]; then
    echo -e "[$(date +"%Y-%m-%d %T")] [$level] $message" >> "$LOG_FILE"
  fi
}

# Displays a raw message without formatting.
# $1: The message to display
# Example: txt "Hello, world!"
txt() {
  echo -e "${RESET}$1"
}

# ================================ SIMPLE COLORS ===================================

# Displays a blue message.
# $1: The message to display
# Example: blue "Processing..."
blue() {
  txt "${BLUE}$1${RESET}"
}

# Displays a green message.
# $1: The message to display
# Example: green "Completed"
green() {
  txt "${GREEN}$1${RESET}"
}

# Displays a cyan message.
# $1: The message to display
# Example: cyan "https://example.com"
cyan() {
  txt "${CYAN}$1${RESET}"
}

# Displays a gray message.
# $1: The message to display
# Example: gray "Optional information"
gray() {
  txt "${GRAY}$1${RESET}"
}

# ================================ LOG FUNCTIONS ===================================

# Displays a debug message (gray).
# $1: The message to display
# Example: debug "Variable x = 42"
# Output: [2024-12-12 10:30:45] [  DEBUG ] Variable x = 42
debug() {
  _log_message "DEBUG" "${GRAY}" "" "$1"
}

# Displays an information message (blue).
# $1: The message to display
# Example: info "Starting process"
# Output: [2024-12-12 10:30:45] [   INFO ] Starting process
info() {
  _log_message "INFO" "${BLUE}" "" "$1"
}

# Displays a hint message (yellow).
# $1: The message to display
# Example: hint "Try using --verbose for more details"
# Output: [2024-12-12 10:30:45] [   HINT ] Try using --verbose for more details
hint() {
  _log_message "HINT" "${YELLOW}" "" "$1"
}

# Displays an action message (blue).
# $1: The message to display
# Example: action "Installing dependencies"
# Output: [2024-12-12 10:30:45] [ ACTION ] Installing dependencies
action() {
  _log_message "ACTION" "${BLUE}" "" "$1"
}

# Displays a warning message (orange).
# $1: The message to display
# Example: warning "File not found, using default"
# Output: [2024-12-12 10:30:45] [WARNING ] File not found, using default
warning() {
  _log_message "WARNING" "${ORANGE}" "" "$1"
}

# Displays a success message (green).
# $1: The message to display
# Example: success "Build completed successfully"
# Output: [2024-12-12 10:30:45] [SUCCESS ] Build completed successfully
success() {
  _log_message "SUCCESS" "${GREEN}" "" "$1"
}

# Displays an error message (red).
# $1: The error message to display
# Return: 1 (error code)
# Example: error "Failed to connect to database"
# Output: [2024-12-12 10:30:45] [  ERROR ] Failed to connect to database
error() {
  _log_message "ERROR" "${RED}" "" "$1"
  return 1
}

# Displays a fatal error message and exits (red).
# $1: The fatal error message to display
# $2: Optional exit code (default: 1)
# Example: fatal "Critical configuration missing" 2
# Output: [2024-12-12 10:30:45] [  FATAL ] Critical configuration missing
fatal() {
  local exit_code="${2:-1}"
  _log_message "FATAL" "${RED}" "" "$1"
  exit "$exit_code"
}

# ============================== PROGRESS INDICATORS ===============================

# Displays a spinner while a command runs.
# $1: Command to execute
# $2: Optional message to display
# Example: spinner "sleep 5" "Processing"
spinner() {
  local cmd="$1"
  local msg="${2:-Working}"
  local delay=0.1
  local spinstr='|/-\'
  
  # Disable job control messages
  set +m
  
  # Execute command in background
  eval "$cmd" &
  local pid=$!
  
  # Trap to ensure cleanup on interrupt
  trap "kill $pid 2>/dev/null; printf '    \r'; set -m; return 130" INT TERM
  
  # Show spinner while process runs
  while kill -0 "$pid" 2>/dev/null; do
    local temp=${spinstr#?}
    printf " [${BLUE}%c${RESET}] %s\r" "$spinstr" "$msg"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
  done
  
  # Clear spinner and reset trap
  printf "    \r"
  trap - INT TERM
  
  # Wait for process and return its exit code
  wait $pid
  local exit_code=$?
  
  # Re-enable job control
  set -m
  
  return $exit_code
}

# Displays a progress bar.
# $1: Current value
# $2: Maximum value
# $3: Optional bar width (default: 50)
# Example: progress_bar 75 100
progress_bar() {
  local current=$1
  local max=$2
  local width=${3:-50}
  local percent=$((current * 100 / max))
  local filled=$((current * width / max))
  local empty=$((width - filled))
  
  printf "\r[${GREEN}"
  printf "%${filled}s" | tr ' ' '='
  printf "${RESET}"
  printf "%${empty}s" | tr ' ' '-'
  printf "] %3d%%" "$percent"
  
  if [[ $current -eq $max ]]; then
    printf "\n"
  fi
}

# =============================== USER PROMPTS =====================================

# Prompts user for yes/no confirmation.
# $1: The question to ask
# $2: Default answer (y/n, default: n)
# Return: 0 for yes, 1 for no
# Example: if prompt "Continue?" "y"; then echo "Continuing..."; fi
prompt() {
  local question="$1"
  local default="${2:-n}"
  local answer
  
  if [[ "$default" == "y" ]]; then
    printf "${YELLOW}❓ %s [Y/n]:${RESET} " "$question"
  else
    printf "${YELLOW}❓ %s [y/N]:${RESET} " "$question"
  fi
  
  read -r answer
  answer=${answer:-$default}
  
  case "$answer" in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) 
      if [[ "$default" == "y" ]]; then
        return 0
      else
        return 1
      fi
      ;;
  esac
}

# Prompts user for input with optional default value.
# $1: The prompt message
# $2: Optional default value
# Example: name=$(input "Enter your name" "John Doe")
input() {
  local message="$1"
  local default="$2"
  local value
  
  if [[ -n "$default" ]]; then
    printf "${CYAN}➤ %s [%s]:${RESET} " "$message" "$default" >&2
  else
    printf "${CYAN}➤ %s:${RESET} " "$message" >&2
  fi
  
  read -r value
  echo "${value:-$default}"
}

# Displays message and waits for user acknowledgement.
# $1: The message to display
# Example: acknowledge "Installation complete. Press any key to exit."
acknowledge() {
  action "$1"
  action "Press any key to continue..."
  read -n 1 -s -r
}

# ============================== UTILITY FUNCTIONS =================================

# Displays a description of a function or command.
# $1: The function/command name
# $2: The description
# Example: description "install.sh" "installs all dependencies"
description() {
  info "${GREEN}The ${BLUE}$1${GREEN} command $2${RESET}"
  sleep 2
}

# Displays a separator line.
# $1: Optional character to use (default: =)
# $2: Optional width (default: terminal width or 80)
# Example: separator
separator() {
  local char="${1:-=}"
  local width="${2:-$(tput cols 2>/dev/null || echo 80)}"
  local line=$(printf "%${width}s" | tr ' ' "$char")
  printf "${GRAY}%s${RESET}\n" "$line"
}

# Displays a header with text centered.
# $1: Header text
# Example: header "BUILD PROCESS"
header() {
  local text="$1"
  local width=$(tput cols 2>/dev/null || echo 80)
  local padding=$(( (width - ${#text} - 4) / 2 ))
  
  separator "="
  printf "${BOLD}${BLUE}%${padding}s  %s  %${padding}s${RESET}\n" "" "$text" ""
  separator "="
}

# ==============================================================================
