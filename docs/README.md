# Copy Path Service

A macOS-native utility that adds "Copy Path" and "Run Script" options to the Finder context menu for instant file path copying and script execution capabilities.

## Overview

Copy Path Service enhances macOS Finder with two powerful Quick Actions:

- **Copy Path**: Extract POSIX paths from files/folders and copy to clipboard
- **Run Script**: Execute Python, Bash, Node.js, and other scripts directly from Finder

Built using macOS Automator Quick Actions with AppleScript and shell scripts for seamless system integration.

## Features

### Copy Path Service
- ✅ Copy full POSIX paths of selected files and folders
- ✅ Handle multiple selections simultaneously
- ✅ Works with files, folders, and mixed selections
- ✅ Instant clipboard integration
- ✅ No background processes or system modifications

### Run Script Service
- ✅ Execute scripts directly from Finder context menu
- ✅ Support for multiple script types:
  - Python scripts (`.py`)
  - Bash scripts (`.sh`)
  - Node.js scripts (`.js`)
  - Other executable formats
- ✅ Real-time output display
- ✅ Error handling and reporting
- ✅ Secure execution in user context

## Quick Start

### Installation

```bash
# Install Copy Path service
./scripts/install_copy_path_service.sh

# Install Run Script service
./scripts/install_run_script_service.sh

# Install both services
./scripts/build-universal.sh
```

### Usage

1. **Copy Path**: Right-click any file/folder → Services → Copy Path
2. **Run Script**: Right-click script file → Services → Run Script

## System Requirements

- **macOS**: 10.6 (Snow Leopard) or later
- **Recommended**: macOS 10.15 (Catalina) or later
- **Permissions**: Standard user permissions (no admin required)
- **Dependencies**: Built-in macOS components only

## Architecture

```
Copy Path Service Architecture:

┌─────────────────────────────────────────┐
│           Finder Context Menu            │
│         (User Interaction Layer)         │
├─────────────────────────────────────────┤
│        macOS Services Framework         │
│      (System Integration Layer)         │
├─────────────────────────────────────────┤
│          Automator Quick Actions        │
│         (Service Execution Layer)        │
├─────────────────────────────────────────┤
│    AppleScript + Shell Scripts          │
│        (Implementation Layer)           │
└─────────────────────────────────────────┘
```

## Security & Privacy

- **User-space execution only** - No privileged operations
- **Sandboxed within Services framework** - Safe execution environment
- **No network access** - Local operations only
- **No persistent processes** - On-demand execution
- **Respects file permissions** - Standard macOS security model

## Documentation

- **[Installation Guide](INSTALLATION.md)** - Detailed setup instructions
- **[User Guide](USER_GUIDE.md)** - Complete usage documentation
- **[API Reference](API_REFERENCE.md)** - Technical implementation details
- **[Architecture](ARCHITECTURE.md)** - System design and architecture
- **[Troubleshooting](TROUBLESHOOTING.md)** - Common issues and solutions
- **[FAQ](FAQ.md)** - Frequently asked questions
- **[Security](SECURITY.md)** - Security considerations and best practices

## Development

- **[Contributing](CONTRIBUTING.md)** - Development guidelines
- **[Changelog](CHANGELOG.md)** - Version history
- **[Roadmap](ROADMAP.md)** - Future development plans
- **[Release Notes](RELEASE_NOTES.md)** - Release information

## Support

- **[Support](SUPPORT.md)** - Getting help and support
- **[Code of Conduct](CODE_OF_CONDUCT.md)** - Community guidelines
- **[License](LICENSE.md)** - Legal information

## Quick Commands

```bash
# Verify service installation
ls -la ~/Library/Services/

# Check service registration
plutil -lint ~/Library/Services/Copy\ Path.workflow/Contents/Info.plist

# Restart Finder to refresh services
killall Finder

# Uninstall services
./scripts/uninstall_copy_path_service.sh
./scripts/uninstall_run_script_service.sh
```

## Project Status

✅ **Stable** - Production-ready with active maintenance  
🔄 **Compatible** - Supports macOS 10.6+  
🛡️ **Secure** - No security vulnerabilities reported  
📚 **Documented** - Comprehensive documentation available  

---

**Copy Path Service** - Enhancing macOS Finder productivity since 2024