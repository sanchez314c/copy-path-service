# API Reference

Technical reference for Copy Path Service and Run Script Service implementation.

## 📋 Table of Contents

- [Service Architecture](#service-architecture)
- [File Structure](#file-structure)
- [AppleScript Reference](#applescript-reference)
- [Shell Script Reference](#shell-script-reference)
- [Configuration Options](#configuration-options)
- [Extension Points](#extension-points)
- [Debugging](#debugging)

---

## 🏗️ Service Architecture

### Core Components

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

### Service Registration

#### Bundle Identifiers

| Service | Bundle ID | Registration Path |
|----------|-------------|-------------------|
| Copy Path | `com.apple.Automator.Copy Path` | `~/Library/Services/Copy Path.workflow/` |
| Run Script | `com.apple.Automator.Run Script` | `~/Library/Services/Run Script.workflow/` |

#### Service Metadata

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

---

## 📁 File Structure

### Installation Directory Structure

```
~/Library/Services/
├── Copy Path.workflow/
│   └── Contents/
│       ├── document.wflow      # Automator workflow definition
│       └── Info.plist          # Service metadata
└── Run Script.workflow/        # If installed
    └── Contents/
        ├── document.wflow
        └── Info.plist
```

### Workflow File Format

#### document.wflow Structure

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

#### Info.plist Configuration

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>com.apple.Automator.Copy Path</string>
    <key>CFBundleName</key>
    <string>Copy Path</string>
    <key>CFBundleShortVersionString</key>
    <string>2.0.0</string>
    <key>NSServices</key>
    <array>
        <!-- Service definitions here -->
    </array>
</dict>
</plist>
```

---

## 🍎 AppleScript Reference

### Copy Path Service Implementation

```applescript
-- Main handler for Copy Path service
on run {input, parameters}
    try
        -- Get the first selected item
        set theItem to item 1 of input
        
        -- Extract POSIX path
        set thePath to POSIX path of theItem
        
        -- Copy to clipboard
        set the clipboard to thePath
        
        -- Return success
        return input
        
    on error errMsg number errNum
        -- Handle errors gracefully
        display dialog "Error: " & errMsg buttons {"OK"} default button 1
        return input
    end try
end run
```

### Run Script Service Implementation

```applescript
-- Main handler for Run Script service
on run {input, parameters}
    try
        -- Get the first selected item
        set theItem to item 1 of input
        
        -- Extract POSIX path
        set thePath to POSIX path of theItem
        
        -- Determine script type and execute
        set theResult to executeScript(thePath)
        
        -- Display result
        display dialog theResult buttons {"OK"} default button 1
        
        return input
        
    on error errMsg number errNum
        -- Handle errors gracefully
        display dialog "Error: " & errMsg buttons {"OK"} default button 1
        return input
    end try
end run

-- Script execution handler
on executeScript(scriptPath)
    try
        -- Get file extension
        set theExtension to name extension of (info for file scriptPath)
        
        -- Execute based on type
        if theExtension is "py" then
            return do shell script "python3 " & quoted form of scriptPath
        else if theExtension is "sh" or theExtension is "bash" then
            return do shell script "bash " & quoted form of scriptPath
        else if theExtension is "js" then
            return do shell script "node " & quoted form of scriptPath
        else
            -- Try direct execution
            return do shell script quoted form of scriptPath
        end if
        
    on error errMsg
        return "Error executing script: " & errMsg
    end try
end executeScript
```

### AppleScript API Reference

#### File System Operations

| Function | Syntax | Description |
|----------|---------|-------------|
| `POSIX path of` | `POSIX path of fileAlias` | Convert to Unix-style path |
| `info for` | `info for fileAlias` | Get file information |
| `name extension of` | `name extension of fileInfo` | Extract file extension |
| `quoted form of` | `quoted form of string` | Escape shell arguments |

#### Clipboard Operations

| Function | Syntax | Description |
|----------|---------|-------------|
| `set the clipboard to` | `set the clipboard to "text"` | Copy text to clipboard |
| `the clipboard as string` | `the clipboard as string` | Read clipboard content |

#### User Interface

| Function | Syntax | Description |
|----------|---------|-------------|
| `display dialog` | `display dialog "message" buttons {"OK"} default button 1` | Show alert dialog |
| `display alert` | `display alert "title" message "text"` | Show system alert |

---

## 🔧 Shell Script Reference

### Installation Script Structure

```bash
#!/bin/bash

# Copy Path Service Installation Script
# Version: 2.0.0

# Configuration
SERVICE_NAME="Copy Path"
WORKFLOW_DIR="$HOME/Library/Services/$SERVICE_NAME.workflow"
CONTENTS_DIR="$WORKFLOW_DIR/Contents"

# Functions
create_directory_structure() {
    mkdir -p "$CONTENTS_DIR"
}

create_info_plist() {
    cat > "$CONTENTS_DIR/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Service configuration here -->
</dict>
</plist>
EOF
}

create_workflow_document() {
    cat > "$CONTENTS_DIR/document.wflow" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Workflow definition here -->
</dict>
</plist>
EOF
}

verify_installation() {
    if [ -d "$WORKFLOW_DIR" ]; then
        echo "✅ Service installed successfully"
        return 0
    else
        echo "❌ Installation failed"
        return 1
    fi
}

# Main execution
main() {
    echo "🚀 Installing $SERVICE_NAME Service..."
    
    create_directory_structure
    create_info_plist
    create_workflow_document
    
    if verify_installation; then
        echo "🔄 Refreshing services..."
        killall Finder 2>/dev/null || true
        echo "✅ Installation complete!"
        echo "📝 Restart Finder or wait 30 seconds for services to appear"
    else
        echo "❌ Installation failed"
        exit 1
    fi
}

main "$@"
```

### Uninstallation Script Structure

```bash
#!/bin/bash

# Copy Path Service Uninstallation Script
# Version: 2.0.0

SERVICE_NAME="Copy Path"
WORKFLOW_DIR="$HOME/Library/Services/$SERVICE_NAME.workflow"

uninstall_service() {
    if [ -d "$WORKFLOW_DIR" ]; then
        rm -rf "$WORKFLOW_DIR"
        echo "✅ Service uninstalled successfully"
        return 0
    else
        echo "⚠️ Service not found"
        return 1
    fi
}

refresh_services() {
    echo "🔄 Refreshing services..."
    /System/Library/CoreServices/pbs -flush 2>/dev/null || true
    killall Finder 2>/dev/null || true
}

main() {
    echo "🗑️ Uninstalling $SERVICE_NAME Service..."
    
    if uninstall_service; then
        refresh_services
        echo "✅ Uninstallation complete!"
    else
        echo "❌ Uninstallation failed"
        exit 1
    fi
}

main "$@"
```

### Shell Script Utilities

#### File Operations

```bash
# Directory creation
mkdir -p "$DIRECTORY_PATH"

# File creation with content
cat > "$FILE_PATH" << 'EOF'
File content here
EOF

# File permissions
chmod +x "$SCRIPT_PATH"

# File removal
rm -rf "$FILE_OR_DIRECTORY"

# File existence check
if [ -f "$FILE_PATH" ]; then
    echo "File exists"
fi
```

#### System Integration

```bash
# Service refresh
/System/Library/CoreServices/pbs -flush

# Finder restart
killall Finder

# Process management
ps aux | grep -i finder

# User detection
CURRENT_USER=$(whoami)
HOME_DIRECTORY="/Users/$CURRENT_USER"
```

---

## ⚙️ Configuration Options

### Service Configuration

#### File Type Support

| Service | Supported Types | Configuration |
|----------|-----------------|-------------|
| Copy Path | `public.item` | All files and folders |
| Run Script | `public.unix-executable`, `public.shell-script`, `public.python-script`, `com.netscape.javascript-source` | Executable files and scripts |

#### Context Restrictions

```xml
<key>NSRequiredContext</key>
<dict>
    <key>NSApplicationIdentifier</key>
    <string>com.apple.finder</string>
</dict>
```

#### Menu Integration

```xml
<key>NSMenuItem</key>
<dict>
    <key>default</key>
    <string>Copy Path</string>
    <key>keyEquivalent</key>
    <string></string>  <!-- No keyboard shortcut -->
</dict>
```

### Runtime Configuration

#### Execution Environment

| Variable | Value | Description |
|----------|--------|-------------|
| `PATH` | System PATH | Available to shell scripts |
| `HOME` | User home directory | User's home directory |
| `USER` | Current username | Current user |
| `PWD` | Working directory | Script execution directory |

#### Security Context

| Permission | Level | Description |
|-----------|--------|-------------|
| File Access | Read-only, selected files | Can only access user-selected files |
| Clipboard Access | Write-only | Can write to system clipboard |
| Network Access | None | No network connectivity |
| System Access | Minimal | Only through standard APIs |

---

## 🔌 Extension Points

### Custom Script Types

#### Adding New Script Support

```applescript
-- Extended script type detection
on executeScript(scriptPath)
    try
        -- Get file extension
        set theExtension to name extension of (info for file scriptPath)
        
        -- Extended type checking
        if theExtension is "py" then
            return do shell script "python3 " & quoted form of scriptPath
        else if theExtension is "sh" or theExtension is "bash" then
            return do shell script "bash " & quoted form of scriptPath
        else if theExtension is "js" then
            return do shell script "node " & quoted form of scriptPath
        else if theExtension is "rb" then
            return do shell script "ruby " & quoted form of scriptPath
        else if theExtension is "pl" then
            return do shell script "perl " & quoted form of scriptPath
        else
            -- Try direct execution
            return do shell script quoted form of scriptPath
        end if
        
    on error errMsg
        return "Error executing script: " & errMsg
    end try
end executeScript
```

### Custom Output Handling

#### Enhanced Output Display

```applescript
-- Enhanced result display
on displayResult(result, isError)
    try
        if isError then
            display dialog result buttons {"OK"} default button 1 with icon stop
        else
            -- Truncate long output
            if length of result > 500 then
                set result to text 1 thru 500 of result & "..."
            end if
            
            display dialog result buttons {"OK"} default button 1 with icon note
        end if
        
    on error errMsg
        display dialog "Display error: " & errMsg buttons {"OK"} default button 1
    end try
end displayResult
```

---

## 🐛 Debugging

### AppleScript Debugging

#### Console Logging

```applescript
-- Debug logging
on logMessage(message)
    try
        do shell script "echo '" & message & "' >> ~/Library/Logs/copy-path-service.log"
    on error
        -- Ignore logging errors
    end try
end logMessage

-- Usage in handlers
on run {input, parameters}
    logMessage("Copy Path service started")
    
    try
        -- Service logic here
        logMessage("Path copied successfully")
    on error errMsg
        logMessage("Error: " & errMsg)
    end try
end run
```

#### Error Handling Patterns

```applescript
-- Comprehensive error handling
on run {input, parameters}
    try
        -- Main logic
        set theItem to item 1 of input
        set thePath to POSIX path of theItem
        
        -- Validate path
        if thePath is "" then
            error "No valid file selected"
        end if
        
        set the clipboard to thePath
        
    on error errMsg number errNum
        -- Log error
        logMessage("Error " & errNum & ": " & errMsg)
        
        -- Show user-friendly message
        if errNum is -1728 then
            display dialog "No file selected" buttons {"OK"} default button 1
        else
            display dialog "Operation failed: " & errMsg buttons {"OK"} default button 1
        end if
    end try
end run
```

### Shell Script Debugging

#### Debug Functions

```bash
# Debug logging
debug_log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> ~/Library/Logs/installation-debug.log"
}

# Error handling
handle_error() {
    local exit_code=$?
    local line_number=$1
    debug_log "Error at line $line_number: exit code $exit_code"
    exit $exit_code
}

# Usage with trap
trap 'handle_error $LINENO' ERR

debug_log "Installation started"
```

#### Validation Functions

```bash
# System validation
validate_macos_version() {
    local required_version="$1"
    local current_version=$(sw_vers -productVersion)
    
    if [[ "$(printf '%s\n' "$required_version" "$current_version" | sort -V | head -n1)" == "$required_version" ]]; then
        debug_log "macOS version $current_version is supported"
        return 0
    else
        debug_log "macOS version $current_version is too old (required: $required_version)"
        return 1
    fi
}

# Dependency validation
validate_dependency() {
    local dependency="$1"
    local command="$2"
    
    if command -v "$command" >/dev/null 2>&1; then
        debug_log "$dependency is available: $command"
        return 0
    else
        debug_log "$dependency is not available: $command"
        return 1
    fi
}
```

### Service Testing

#### Manual Testing Procedures

```bash
# Service installation test
test_service_installation() {
    local service_name="$1"
    local workflow_path="$HOME/Library/Services/$service_name.workflow"
    
    # Check directory exists
    if [ ! -d "$workflow_path" ]; then
        echo "❌ Service directory not found: $workflow_path"
        return 1
    fi
    
    # Check required files
    local required_files=("Contents/Info.plist" "Contents/document.wflow")
    for file in "${required_files[@]}"; do
        if [ ! -f "$workflow_path/$file" ]; then
            echo "❌ Required file missing: $file"
            return 1
        fi
    done
    
    # Validate plist syntax
    if ! plutil -lint "$workflow_path/Contents/Info.plist" >/dev/null 2>&1; then
        echo "❌ Info.plist has syntax errors"
        return 1
    fi
    
    echo "✅ Service installation test passed"
    return 0
}
```

#### Functional Testing

```bash
# Copy Path service test
test_copy_path_service() {
    local test_file="/tmp/test-file.txt"
    
    # Create test file
    echo "test content" > "$test_file"
    
    # Simulate service call (would need AppleScript)
    echo "🧪 Testing Copy Path service with: $test_file"
    
    # Cleanup
    rm -f "$test_file"
}

# Run Script service test
test_run_script_service() {
    local test_script="/tmp/test-script.sh"
    
    # Create test script
    cat > "$test_script" << 'EOF'
#!/bin/bash
echo "Test script executed successfully"
EOF
    
    chmod +x "$test_script"
    
    # Simulate service call
    echo "🧪 Testing Run Script service with: $test_script"
    
    # Cleanup
    rm -f "$test_script"
}
```

---

## 📚 Additional Resources

### Documentation References

- [AppleScript Language Guide](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/)
- [macOS Services Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/SysServices/)
- [Automator User Guide](https://support.apple.com/guide/automator/)
- [Property List (plist) Reference](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/)

### Development Tools

- **Script Editor**: `/Applications/Utilities/Script Editor.app`
- **Automator**: `/Applications/Automator.app`
- **Console**: `/Applications/Utilities/Console.app`
- **Property List Editor**: `/usr/bin/plutil`

---

**Need more technical details?** Check our [Architecture Guide](ARCHITECTURE.md) or [open an issue](https://github.com/USERNAME/copy-path-service/issues).