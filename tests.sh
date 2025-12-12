#!/usr/bin/env bash
# ==============================================================================
# BASH TOOLBOX - Test Suite
# ==============================================================================
# This script tests all functions in the bash-toolbox library.
# ==============================================================================

# Source the library (local first, remote fallback)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "${SCRIPT_DIR}/src/prefix.sh" ]]; then
  source "${SCRIPT_DIR}/src/prefix.sh"
else
  source <(curl -s https://raw.githubusercontent.com/MorganKryze/bash-toolbox/main/src/prefix.sh)
fi

# ==============================================================================
# TEST FRAMEWORK
# ==============================================================================

TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0

# Test assertion function
assert_equals() {
  local expected="$1"
  local actual="$2"
  local test_name="$3"
  
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  
  if [[ "$expected" == "$actual" ]]; then
    TESTS_PASSED=$((TESTS_PASSED + 1))
    echo -e "${GREEN}✓${RESET} ${test_name}"
    return 0
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo -e "${RED}✗${RESET} ${test_name}"
    echo "  Expected: ${expected}"
    echo "  Actual:   ${actual}"
    return 1
  fi
}

# Test exit code function
assert_exit_code() {
  local expected="$1"
  local command="$2"
  local test_name="$3"
  
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  
  eval "$command" >/dev/null 2>&1
  local actual=$?
  
  if [[ $expected -eq $actual ]]; then
    TESTS_PASSED=$((TESTS_PASSED + 1))
    echo -e "${GREEN}✓${RESET} ${test_name}"
    return 0
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo -e "${RED}✗${RESET} ${test_name}"
    echo "  Expected exit code: ${expected}"
    echo "  Actual exit code:   ${actual}"
    return 1
  fi
}

# Test that function exists
assert_function_exists() {
  local func_name="$1"
  
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  
  if declare -f "$func_name" >/dev/null 2>&1; then
    TESTS_PASSED=$((TESTS_PASSED + 1))
    echo -e "${GREEN}✓${RESET} Function ${func_name} exists"
    return 0
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo -e "${RED}✗${RESET} Function ${func_name} does not exist"
    return 1
  fi
}

# ==============================================================================
# TESTS
# ==============================================================================

header "BASH TOOLBOX TEST SUITE"
echo

# Test 1: Function existence
echo -e "${BOLD}Test Group 1: Function Existence${RESET}"
assert_function_exists "get_timestamp"
assert_function_exists "txt"
assert_function_exists "blue"
assert_function_exists "green"
assert_function_exists "cyan"
assert_function_exists "gray"
assert_function_exists "debug"
assert_function_exists "info"
assert_function_exists "hint"
assert_function_exists "action"
assert_function_exists "warning"
assert_function_exists "success"
assert_function_exists "error"
assert_function_exists "fatal"
assert_function_exists "spinner"
assert_function_exists "progress_bar"
assert_function_exists "prompt"
assert_function_exists "input"
assert_function_exists "acknowledge"
assert_function_exists "description"
assert_function_exists "separator"
assert_function_exists "header"
echo

# Test 2: Configuration variables
echo -e "${BOLD}Test Group 2: Configuration Variables${RESET}"
assert_equals "true" "${ENABLE_TIMESTAMPS}" "ENABLE_TIMESTAMPS default is true"
assert_equals "true" "${ENABLE_ICONS}" "ENABLE_ICONS default is true"
assert_equals "0" "${LOG_LEVEL}" "LOG_LEVEL default is 0"
echo

# Test 3: Timestamp format
echo -e "${BOLD}Test Group 3: Timestamp Format${RESET}"
timestamp=$(get_timestamp)
if [[ $timestamp =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
  TESTS_PASSED=$((TESTS_PASSED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${GREEN}✓${RESET} Timestamp format is valid"
else
  TESTS_FAILED=$((TESTS_FAILED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${RED}✗${RESET} Timestamp format is invalid: ${timestamp}"
fi
echo

# Test 4: Error function returns 1
echo -e "${BOLD}Test Group 4: Return Values${RESET}"
assert_exit_code 1 "error 'test error'" "error() returns exit code 1"
echo

# Test 5: Color disabling
echo -e "${BOLD}Test Group 5: Configuration Changes${RESET}"
ENABLE_COLORS=false
source "${SCRIPT_DIR}/src/prefix.sh"
assert_equals "" "${GREEN}" "Colors disabled when ENABLE_COLORS=false"
assert_equals "" "${BLUE}" "Colors disabled for BLUE"
ENABLE_COLORS=true
source "${SCRIPT_DIR}/src/prefix.sh"
if [[ -n "${GREEN}" ]]; then
  TESTS_PASSED=$((TESTS_PASSED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${GREEN}✓${RESET} Colors enabled when ENABLE_COLORS=true"
else
  TESTS_FAILED=$((TESTS_FAILED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${RED}✗${RESET} Colors not enabled when ENABLE_COLORS=true"
fi
echo

# Test 6: Log level filtering
echo -e "${BOLD}Test Group 6: Log Level Filtering${RESET}"
LOG_LEVEL=2
output=$(debug "test" 2>&1)
if [[ -z "$output" ]]; then
  TESTS_PASSED=$((TESTS_PASSED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${GREEN}✓${RESET} Debug messages hidden when LOG_LEVEL=2"
else
  TESTS_FAILED=$((TESTS_FAILED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${RED}✗${RESET} Debug messages not hidden when LOG_LEVEL=2"
fi

output=$(warning "test" 2>&1)
if [[ -n "$output" ]]; then
  TESTS_PASSED=$((TESTS_PASSED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${GREEN}✓${RESET} Warning messages shown when LOG_LEVEL=2"
else
  TESTS_FAILED=$((TESTS_FAILED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${RED}✗${RESET} Warning messages not shown when LOG_LEVEL=2"
fi
LOG_LEVEL=0
echo

# Test 7: File logging
echo -e "${BOLD}Test Group 7: File Logging${RESET}"
TEST_LOG_FILE="/tmp/bash-toolbox-test-$$.log"
LOG_FILE="$TEST_LOG_FILE"
info "test log message"
if [[ -f "$TEST_LOG_FILE" ]]; then
  TESTS_PASSED=$((TESTS_PASSED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${GREEN}✓${RESET} Log file created"
  
  if grep -q "test log message" "$TEST_LOG_FILE"; then
    TESTS_PASSED=$((TESTS_PASSED + 1))
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    echo -e "${GREEN}✓${RESET} Log message written to file"
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    echo -e "${RED}✗${RESET} Log message not found in file"
  fi
  rm -f "$TEST_LOG_FILE"
else
  TESTS_FAILED=$((TESTS_FAILED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${RED}✗${RESET} Log file not created"
fi
LOG_FILE=""
echo

# Test 8: Timestamp toggle
echo -e "${BOLD}Test Group 8: Timestamp Toggle${RESET}"
ENABLE_TIMESTAMPS=false
output=$(info "test" 2>&1)
if [[ ! "$output" =~ [0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
  TESTS_PASSED=$((TESTS_PASSED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${GREEN}✓${RESET} Timestamps hidden when ENABLE_TIMESTAMPS=false"
else
  TESTS_FAILED=$((TESTS_FAILED + 1))
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  echo -e "${RED}✗${RESET} Timestamps not hidden when ENABLE_TIMESTAMPS=false"
fi
ENABLE_TIMESTAMPS=true
echo

# ==============================================================================
# RESULTS
# ==============================================================================

separator "="
echo
if [[ $TESTS_FAILED -eq 0 ]]; then
  success "All tests passed! ($TESTS_PASSED/$TESTS_TOTAL)"
  exit 0
else
  error "Some tests failed! ($TESTS_PASSED passed, $TESTS_FAILED failed, $TESTS_TOTAL total)"
  exit 1
fi
