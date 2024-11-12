# ==================================== COLORS ==========================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
RESET='\033[0m'
LINK='\033[0;36m'
UNDERLINE='\033[4m'

# ================================== FUNCTIONS =========================================

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
  txt "[${BLUE}  INFO   ${RESET}] ${BLUE}$1${RESET}"
}

# Displays an action message.
# $1: The message to display.
function action() {
  txt "[${BLUE} ACTION  ${RESET}] ${BLUE}$1${RESET}"
}

# Displays a warning message.
# $1: The message to display.
function warning() {
  txt "[${ORANGE} WARNING ${RESET}] ${ORANGE}$1${RESET}"
}

# Displays a success message.
# $1: The message to display.
function success() {
  txt "[${GREEN} SUCCESS ${RESET}] ${GREEN}$1${RESET}"
}

# Displays an error message when a command fails.
# $1: The error message to display.
function error() {
  txt "[${RED}  ERROR  ${RESET}] ${RED}$1${RESET}"
  return 1
}

# Displays a description of a function.
# $1: The function name.
# $2: The description of the function.
function description() {
  info "${GREEN}The ${BLUE}$1${GREEN} command $2 ${RESET}"
  sleep 2
}

# Displays message to wait for user acknoledgement.
# $1: The message to display.
function acknoledge() {
  action $1
  action "Press any key to continue..."
  read -k 1 -s
}

# =============================================================================
