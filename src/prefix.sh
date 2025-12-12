# ==================================== COLORS ==========================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
RESET='\033[0m'
LINK='\033[0;36m'
UNDERLINE='\033[4m'

# ================================== FUNCTIONS =========================================

# Returns the current timestamp in "YYYY-MM-DD HH:MM:SS" format.
function get_timestamp() {
  date +"%Y-%m-%d %T"
}

# Displays a raw message.
# $1: The message to display.
function txt() {
  echo -e "${RESET}$1"
}

# Displays a blue message.
# $1: The message to display.
function blue() {
  txt "${BLUE}$1${RESET}"
}

# Displays a green message.
# $1: The message to display.
function green() {
  txt "${GREEN}$1${RESET}"
}

# Displays an information message.
# $1: The message to display.
function info() {
  txt "[${BLUE} $(get_timestamp) ${RESET}] [${BLUE}  INFO   ${RESET}] ${BLUE}$1${RESET}"
}

# Display a hint message.
# $1: The message to display.
function hint() {
  txt "[${YELLOW} $(get_timestamp) ${RESET}] [${YELLOW}  HINT   ${RESET}] ${YELLOW}$1${RESET}"
}

# Displays an action message.
# $1: The message to display.
function action() {
  txt "[${BLUE} $(get_timestamp) ${RESET}] [${BLUE} ACTION  ${RESET}] ${BLUE}$1${RESET}"
}

# Displays a warning message.
# $1: The message to display.
function warning() {
  txt "[${ORANGE} $(get_timestamp) ${RESET}] [${ORANGE} WARNING ${RESET}] ${ORANGE}$1${RESET}"
}

# Displays a success message.
# $1: The message to display.
function success() {
  txt "[${GREEN} $(get_timestamp) ${RESET}] [${GREEN} SUCCESS ${RESET}] ${GREEN}$1${RESET}"
}

# Displays an error message when a command fails.
# $1: The error message to display.
function error() {
  txt "[${RED} $(get_timestamp) ${RESET}] [${RED}  ERROR  ${RESET}] ${RED}$1${RESET}"
  return 1
}

# Displays a description of a function.
# $1: The function name.
# $2: The description of the function.
function description() {
  info "${GREEN}The ${BLUE}$1${GREEN} command $2 ${RESET}"
  sleep 2
}

# Displays message to wait for user acknowledgement.
# $1: The message to display.
function acknowledge() {
  action $1
  action "Press any key to continue..."
  read -k 1 -s
}

# =============================================================================
