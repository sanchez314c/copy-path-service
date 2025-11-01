# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Copy Path Service is a macOS-native utility that adds "Copy Path" and "Run Script" options to the Finder context menu. It uses macOS Automator Quick Actions with AppleScript and shell scripts to provide instant file path copying and script execution capabilities directly from Finder.

**Core Services:**
- **Copy Path**: Extract POSIX paths from files/folders and copy to clipboard
- **Run Script**: Execute Python, Bash, Node.js, and other scripts directly from Finder

**Technology Stack:**
- macOS Automator Quick Actions
- AppleScript for Finder integration
- Shell scripts for installation/uninstallation
- Plist configuration for service registration

## Essential Development Commands

### Installation and Testing

```bash
# Install Copy Path service
./scripts/install_copy_path_service.sh

# Install Run Script service
./scripts/install_run_script_service.sh

# Uninstall services
./scripts/uninstall_copy_path_service.sh
./scripts/uninstall_run_script_service.sh

# Build universal package
./scripts/build-universal.sh

# Test service installation
# After installation, right-click any file in Finder and check Services menu
```

### Development Workflow

```bash
# Verify service files are created
ls -la ~/Library/Services/

# Check service registration
plutil -lint ~/Library/Services/Copy\ Path.workflow/Contents/Info.plist
plutil -lint ~/Library/Services/Run\ Script.workflow/Contents/Info.plist

# Restart Finder to refresh services
killall Finder

# Services refresh (takes up to 30 seconds)
# Test by right-clicking files in Finder
```

### Verification Commands

```bash
# Check if services are properly installed
osascript -e 'tell application "System Events" to get name of every process whose name contains "Finder"'

# Verify service availability
# Look in System Preferences → Extensions → Finder Extensions

# Test plist syntax
plutil -lint ~/Library/Services/Copy\ Path.workflow/Contents/Info.plist
```

## Code Architecture

### High-Level Architecture

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

### Core Components

**Copy Path Service Structure:**
```
~/Library/Services/Copy Path.workflow/
├── Contents/
│   ├── Info.plist           # Service registration and metadata
│   ├── document.wflow       # Automator workflow definition
│   └── Resources/           # Additional resources if needed
```

**Run Script Service Structure:**
```
~/Library/Services/Run Script.workflow/
├── Contents/
│   ├── Info.plist           # Service registration
│   ├── document.wflow       # Workflow with script execution logic
│   └── Resources/           # Script templates and helpers
```

### Service Registration Pattern

**Info.plist Configuration:**
```xml
<key>NSServices</key>
<array>
    <dict>
        <key>NSMenuItem</key>
        <dict>
            <key>default</key>
            <string>Copy Path</string>
        </dict>
        <key>NSMessage</key>
        <string>runWorkflowAsService</string>
        <key>NSRequiredContext</key>
        <dict>
            <key>NSApplicationIdentifier</key>
            <string>com.apple.finder</string>
        </dict>
        <key>NSSendFileTypes</key>
        <array>
            <string>public.item</string>
        </array>
    </dict>
</array>
```

### Installation Architecture

**Installation Process:**
1. Create `~/Library/Services/` directory
2. Generate workflow structure with proper Info.plist
3. Create Automator workflow document
4. Register service with macOS Services framework
5. Trigger service refresh (automatic or manual Finder restart)

**File Management Pattern:**
- Services stored in user's Library directory
- No system-level installation required
- Per-user installation ensures privacy and security
- Easy installation/uninstallation without admin privileges

## Important Implementation Details

### AppleScript Integration

**Copy Path Implementation:**
```applescript
-- Extract POSIX path from selected items
tell application "Finder"
    set selectedItems to selection as alias list
    repeat with currentItem in selectedItems
        set filePath to POSIX path of currentItem
        -- Copy to clipboard
    end repeat
end tell
```

**Run Script Implementation:**
```applescript
-- Execute selected script files
tell application "Finder"
    set selectedItems to selection as alias list
    repeat with scriptFile in selectedItems
        set scriptPath to POSIX path of scriptFile
        -- Determine script type and execute
        -- Show output or errors
    end repeat
end tell
```

### Service Registration Details

**Bundle Identifier Pattern:**
- Copy Path: `com.apple.Automator.Copy Path`
- Run Script: `com.apple.Automator.Run Script`

**File Type Support:**
- Copy Path: `public.item` (all files and folders)
- Run Script: `public.unix-executable`, `public.shell-script`, `public.python-script`, `com.netscape.javascript-source`

**Context Restrictions:**
- Services only available in Finder (`com.apple.finder`)
- No background processes or persistent applications
- On-demand execution through Services framework

### Security and Permissions

**User Space Execution:**
- No admin privileges required
- Runs in user context with standard permissions
- Sandboxed within Services framework
- No network access or system modifications

**File Access:**
- Can access files user has permissions for
- Respects file ownership and access controls
- No privileged file operations
- Safe execution environment

## Development Guidelines

### Installation Script Patterns

**Service Installation Pattern:**
```bash
#!/bin/bash
# Standard service installation template

SERVICES_DIR="$HOME/Library/Services"
WORKFLOW_DIR="$SERVICES_DIR/Service Name.workflow"
CONTENTS_DIR="$WORKFLOW_DIR/Contents"

# Create directory structure
mkdir -p "$CONTENTS_DIR"

# Generate Info.plist with proper service configuration
cat > "$CONTENTS_DIR/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Service configuration here -->
</dict>
</plist>
EOF

# Create workflow document
# (Implementation varies by service type)

echo "✅ Service installed successfully"
echo "🔄 Restart Finder or wait 30 seconds for services to refresh"
```

**Uninstallation Pattern:**
```bash
#!/bin/bash
# Standard service removal template

WORKFLOW_DIR="$HOME/Library/Services/Service Name.workflow"

if [ -d "$WORKFLOW_DIR" ]; then
    rm -rf "$WORKFLOW_DIR"
    echo "✅ Service uninstalled successfully"
else
    echo "❌ Service not found"
fi
```

### Workflow Document Structure

**Automator Workflow Format:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>AMApplicationBuild</key>
    <string>521</string>
    <key>AMApplicationVersion</key>
    <string>2.10</string>
    <key>AMDocumentVersion</key>
    <string>2</string>
    <key>actions</key>
    <array>
        <!-- Action definitions here -->
    </array>
    <key>workflowType</key>
    <string>Service</string>
</dict>
</plist>
```

### Testing and Verification

**Manual Testing Checklist:**
- [ ] Service appears in Finder context menu
- [ ] Service works with files and folders
- [ ] Service works with different file types
- [ ] Clipboard operations function correctly
- [ ] Script execution works for supported types
- [ ] Error handling displays appropriate messages
- [ ] Services persist after Finder restart
- [ ] Installation/uninstallation cycles work correctly

**Platform Testing:**
- Test on multiple macOS versions (10.6+)
- Verify compatibility with different Finder versions
- Test with various file system locations (local, network, external)
- Check behavior with special characters in paths

## Common Development Tasks

### Adding New Services

1. **Create Installation Script:**
   ```bash
   # Copy existing script as template
   cp scripts/install_copy_path_service.sh scripts/install_new_service.sh
   # Modify service name and configuration
   ```

2. **Configure Service Registration:**
   ```xml
   <!-- Update Info.plist with new service details -->
   <key>NSMenuItem</key>
   <dict>
       <key>default</key>
       <string>New Service Name</string>
   </dict>
   ```

3. **Implement Workflow Logic:**
   ```applescript
   -- Create AppleScript or shell script logic
   -- Handle input from Finder
   -- Process and return results
   ```

4. **Test Installation:**
   ```bash
   ./scripts/install_new_service.sh
   # Verify in Finder context menu
   ```

### Modifying Existing Services

1. **Create Backup:**
   ```bash
   TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
   cp scripts/install_copy_path_service.sh scripts/install_copy_path_service.sh.backup.$TIMESTAMP
   ```

2. **Update Installation Script:**
   - Modify plist configuration
   - Update workflow document
   - Change service metadata

3. **Test Changes:**
   ```bash
   # Uninstall existing version
   ./scripts/uninstall_copy_path_service.sh

   # Install updated version
   ./scripts/install_copy_path_service.sh

   # Verify functionality
   ```

### Debugging Service Issues

**Common Problems and Solutions:**

1. **Service Not Appearing:**
   ```bash
   # Restart Services framework
   killall pbs
   /System/Library/CoreServices/pbs -flush

   # Restart Finder
   killall Finder
   ```

2. **Plist Syntax Errors:**
   ```bash
   # Validate plist syntax
   plutil -lint ~/Library/Services/Copy\ Path.workflow/Contents/Info.plist
   ```

3. **Permission Issues:**
   ```bash
   # Check file permissions
   ls -la ~/Library/Services/

   # Fix permissions if needed
   chmod -R 755 ~/Library/Services/
   ```

4. **Workflow Document Issues:**
   ```bash
   # Rebuild workflow using Automator app
   # Export as workflow file
   # Replace existing document.wflow
   ```

### Building Distribution Packages

**Universal Build Process:**
```bash
# Build distribution package
./scripts/build-universal.sh

# This script typically:
# 1. Creates installation package
# 2. Includes both services
# 3. Adds uninstaller
# 4. Creates documentation
# 5. Generates distributable archive
```

**Package Contents:**
- Installation scripts for both services
- Uninstallation scripts
- README and documentation
- License file
- Version information

## File Organization Notes

**Critical Files:**
- `scripts/install_copy_path_service.sh` - Copy Path installation
- `scripts/install_run_script_service.sh` - Run Script installation
- `scripts/uninstall_*.sh` - Service removal scripts
- `scripts/build-universal.sh` - Distribution packaging

**Service Locations:**
- `~/Library/Services/Copy Path.workflow/` - Installed Copy Path service
- `~/Library/Services/Run Script.workflow/` - Installed Run Script service

**Documentation Structure:**
- `docs/README.md` - Documentation hub
- `docs/installation.md` - Installation guide
- `docs/troubleshooting.md` - Common issues
- `docs/technical-architecture.md` - System design

**Configuration Files:**
- `Info.plist` files (generated during installation)
- `document.wflow` files (Automator workflow definitions)
- Shell scripts with proper error handling

## Platform-Specific Considerations

### macOS Version Compatibility
- **Minimum**: macOS 10.6 (Snow Leopard)
- **Recommended**: macOS 10.15 (Catalina) or later
- **Tested on**: Multiple macOS versions for compatibility

### Finder Integration
- Services appear in Finder context menu under "Services"
- Available when right-clicking files and folders
- Respect Finder's file selection and context

### Security Model
- User-space execution only
- No privileged operations
- Respects macOS security sandboxing
- No persistent background processes

---

**For detailed technical documentation, see the `docs/` directory.**