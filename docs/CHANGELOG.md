# Changelog

All notable changes to the Bash Toolbox project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2024-12-12

### Added

#### New Features

- **Log Level Control**: Environment variable `LOG_LEVEL` to filter log messages (DEBUG=0, INFO=1, WARNING=2, ERROR=3, FATAL=4)
- **File Logging**: Optional `LOG_FILE` variable to write logs to a file in addition to terminal output
- **Color Detection**: Automatic terminal color capability detection with `ENABLE_COLORS` override
- **Configuration Options**: Environment variables for customization:
  - `ENABLE_TIMESTAMPS`: Toggle timestamp display (default: true)
  - `ENABLE_COLORS`: Toggle colored output (default: auto-detect)
  - `ENABLE_ICONS`: Toggle emoji icons (default: true)
  - `LOG_LEVEL`: Control minimum log level displayed (default: 0/DEBUG)
  - `LOG_FILE`: Optional file path for log output

#### New Functions

- `debug()`: Gray colored debug messages for verbose logging
- `fatal()`: Red colored fatal error messages that exit the script
- `cyan()`: Display cyan colored text
- `gray()`: Display gray colored text
- `prompt()`: Interactive yes/no confirmation with default values
- `input()`: User input prompt with optional default value
- `spinner()`: Animated spinner for long-running operations
- `progress_bar()`: Visual progress indicator with percentage
- `separator()`: Display customizable separator lines
- `header()`: Display centered header text with separators

#### Documentation

- Comprehensive inline documentation with examples for all functions
- Expected output examples in function comments
- Parameter descriptions and return value documentation
- Added file header with author, version, and description
- Created demo.sh script showcasing all features
- Created comprehensive CHANGELOG.md

### Changed

#### Improvements

- **Unified Logging**: Introduced internal `_log_message()` function for consistent log formatting
- **Consistent Styling**: All log functions now use the same format with optional timestamps and icons
- **Better Quotes**: Fixed variable quoting throughout for better security and reliability
- **Function Syntax**: Standardized function declarations (removed `function` keyword)
- **Color Consistency**: Fixed ORANGE color code to match other color definitions
- **Multi-line Support**: Better handling of messages with newlines

#### Enhanced Functions

- `info()`: Now uses unified logging with configurable timestamps and icons
- `hint()`: Enhanced with icon support and consistent formatting
- `action()`: Improved formatting and configuration support
- `warning()`: Now fully configurable with timestamp and icon options
- `success()`: Enhanced with checkmark icon and better visibility
- `error()`: Improved error handling with consistent formatting
- `acknowledge()`: Fixed quoting and improved compatibility

### Technical

#### Architecture

- Modular internal logging system with `_log_message()` function
- Environment-based configuration system
- Terminal capability detection for better compatibility
- Separated concerns: colors, logging, prompts, utilities

#### Compatibility

- Added shebang line for better portability
- Color detection for terminals that don't support colors
- Fallback values for all configuration options
- Cross-shell compatibility improvements (bash/zsh)

## [1.0.0] - 2024-12-11

### Initial Release

#### Features

- Basic colored output functions (blue, green)
- Log level functions (info, hint, action, warning, success, error)
- Timestamp support via `get_timestamp()`
- Simple text display with `txt()`
- Function description utility
- User acknowledgement prompts

#### Colors

- GREEN, BLUE, RED, ORANGE, YELLOW
- RESET, LINK, UNDERLINE

---

## Future Enhancements

### Planned for 2.1.0

- [ ] Separate modules (colors.sh, logging.sh, prompts.sh)
- [ ] Namespace functions with `bt_` prefix option
- [ ] Enhanced spinner with custom animation options
- [ ] Table formatting utilities
- [ ] JSON output mode for parsing
- [ ] Quiet mode for non-interactive scripts

### Planned for 2.2.0

- [ ] Test suite with automated testing
- [ ] Performance optimizations
- [ ] Caching for frequently called functions
- [ ] Plugin system for extensions
- [ ] Color theme support

---

[2.0.0]: https://github.com/MorganKryze/bash-toolbox/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/MorganKryze/bash-toolbox/releases/tag/v1.0.0
