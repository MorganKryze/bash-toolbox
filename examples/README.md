# Examples

This directory contains example scripts demonstrating various features of bash-toolbox.

## Available Examples

### 1. Simple Example (`simple.sh`)

Basic usage of bash-toolbox functions.

```bash
./examples/simple.sh
```

**Demonstrates:**

- Basic log functions (info, action, success)
- Headers and separators
- Hints

### 2. Backup Script (`backup.sh`)

A more realistic backup script with error handling.

```bash
./examples/backup.sh
```

**Demonstrates:**

- Error handling with `error()` and `fatal()`
- User prompts with `prompt()`
- Progress bars
- Directory operations
- File logging

### 3. Installer Script (`installer.sh`)

Interactive installation script with user input.

```bash
./examples/installer.sh
```

**Demonstrates:**

- User input with `input()`
- Interactive prompts
- Progress indicators
- Multi-step workflows
- Debug logging
- Acknowledgement

## Running Examples

Make sure you've sourced the library or run from the repository root:

```bash
# From repository root
./examples/simple.sh

# Or make executable and run directly
chmod +x examples/*.sh
./examples/simple.sh
```

## Creating Your Own

Use these examples as templates for your own scripts:

1. Copy an example that matches your needs
2. Customize the functions and logic
3. Add your own business logic
4. Test with the bash-toolbox test suite

## Tips

- Start with `simple.sh` for basic scripts
- Use `backup.sh` as a template for error-critical operations
- Use `installer.sh` for interactive user workflows
- Combine features as needed for your use case
