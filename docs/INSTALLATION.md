# Installation Guide

Complete installation instructions for Copy Path Service on macOS.

## System Requirements

### Supported macOS Versions
- **macOS 10.15 (Catalina)** or later
- **Recommended**: macOS 12 (Monterey) or later
- **Tested on**: macOS 10.15 - macOS 14 (Sonoma)

### Hardware Requirements
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 50MB free space for installation
- **Processor**: Intel or Apple Silicon (M1/M2/M3)

### Software Requirements
- **Administrator Access**: Required for installation
- **Finder**: Must be available and functional
- **Terminal**: For installation script execution

## Installation Methods

### Method 1: Automated Installation (Recommended)

#### Quick Install
```bash
# Download and run installation script
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/install_copy_path_service.sh | bash

# For Run Script service
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/install_run_script_service.sh | bash
```

#### Manual Download
1. **Download Scripts**: 
   - [Copy Path Service](https://github.com/USERNAME/macos-copy-path-service/raw/main/scripts/install_copy_path_service.sh)
   - [Run Script Service](https://github.com/USERNAME/macos-copy-path-service/raw/main/scripts/install_run_script_service.sh)

2. **Make Executable**:
   ```bash
   chmod +x install_copy_path_service.sh
   chmod +x install_run_script_service.sh
   ```

3. **Run Installation**:
   ```bash
   ./install_copy_path_service.sh
   ./install_run_script_service.sh
   ```

### Method 2: Manual Installation

#### Step 1: Create Service Directories
```bash
# Create services directory
mkdir -p ~/Library/Services

# Create Copy Path service directory
mkdir -p ~/Library/Services/Copy\ Path.workflow/Contents

# Create Run Script service directory
mkdir -p ~/Library/Services/Run\ Script.workflow/Contents
```

#### Step 2: Create Service Configuration

**Copy Path Service Info.plist**:
```bash
cat > ~/Library/Services/Copy\ Path.workflow/Contents/Info.plist << 'EOF'
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
    <key>CFBundleVersion</key>
    <string>2.0.0</string>
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
</dict>
</plist>
EOF
```

**Run Script Service Info.plist**:
```bash
cat > ~/Library/Services/Run\ Script.workflow/Contents/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>com.apple.Automator.Run Script</string>
    <key>CFBundleName</key>
    <string>Run Script</string>
    <key>CFBundleShortVersionString</key>
    <string>2.0.0</string>
    <key>CFBundleVersion</key>
    <string>2.0.0</string>
    <key>NSServices</key>
    <array>
        <dict>
            <key>NSMenuItem</key>
            <dict>
                <key>default</key>
                <string>Run Script</string>
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
                <string>public.unix-executable</string>
                <string>public.shell-script</string>
                <string>public.python-script</string>
                <string>com.netscape.javascript-source</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
EOF
```

#### Step 3: Create Workflow Documents

**Copy Path Workflow**:
```bash
cat > ~/Library/Services/Copy\ Path.workflow/Contents/document.wflow << 'EOF'
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
        <dict>
            <key>action</key>
            <dict>
                <key>AMAccepts</key>
                <dict>
                    <key>Container</key>
                    <string>List</string>
                    <key>Optional</key>
                    <true/>
                    <key>Types</key>
                    <array>
                        <string>com.apple.cocoa.string</string>
                    </array>
                </dict>
                <key>AMActionVersion</key>
                <string>2.0.3</string>
                <key>AMApplication</key>
                <array>
                    <string>Automator</string>
                </array>
                <key>AMParameterProperties</key>
                <dict>
                    <key>source</key>
                    <dict/>
                </dict>
                <key>AMProvides</key>
                <dict>
                    <key>Container</key>
                    <string>List</string>
                    <key>Types</key>
                    <array>
                        <string>com.apple.cocoa.string</string>
                    </array>
                </dict>
                <key>ActionBundlePath</key>
                <string>/System/Library/Automator/Run AppleScript.action</string>
                <key>ActionName</key>
                <string>Run AppleScript</string>
                <key>ActionParameters</key>
                <dict>
                    <key>source</key>
                    <dict>
                        <key>Value</key>
                        <string>on run {input, parameters}
    try
        tell application "Finder"
            set selectedItems to selection as alias list
            set pathList to {}
            repeat with currentItem in selectedItems
                set end of pathList to POSIX path of currentItem
            end repeat
        end tell
        
        set the clipboard to (pathList as string)
        display notification "Path copied to clipboard" with title "Copy Path Service"
        
    on error errMsg number errNum
        display dialog "Error: " & errMsg buttons {"OK"} default button "OK" with icon stop
    end try
    
    return input
end run</string>
                    </dict>
                </dict>
            </dict>
            <key>isViewVisible</key>
            <true/>
        </dict>
    </array>
    <key>connectors</key>
    <dict/>
    <key>workflowMetaData</key>
    <dict>
        <key>serviceInputTypeIdentifier</key>
        <string>com.apple.Automator.item</string>
        <key>serviceOutputTypeIdentifier</key>
        <string>com.apple.Automator.nothing</string>
        <key>serviceProcessesInput</key>
        <integer>0</integer>
        <key>workflowTypeIdentifier</key>
        <string>com.apple.Automator.servicesMenu</string>
    </dict>
</dict>
</plist>
EOF
```

**Run Script Workflow**:
```bash
cat > ~/Library/Services/Run\ Script.workflow/Contents/document.wflow << 'EOF'
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
        <dict>
            <key>action</key>
            <dict>
                <key>AMAccepts</key>
                <dict>
                    <key>Container</key>
                    <string>List</string>
                    <key>Optional</key>
                    <true/>
                    <key>Types</key>
                    <array>
                        <string>com.apple.cocoa.string</string>
                    </array>
                </dict>
                <key>AMActionVersion</key>
                <string>2.0.3</string>
                <key>AMApplication</key>
                <array>
                    <string>Automator</string>
                </array>
                <key>AMParameterProperties</key>
                <dict>
                    <key>source</key>
                    <dict/>
                </dict>
                <key>AMProvides</key>
                <dict>
                    <key>Container</key>
                    <string>List</string>
                    <key>Types</key>
                    <array>
                        <string>com.apple.cocoa.string</string>
                    </array>
                </dict>
                <key>ActionBundlePath</key>
                <string>/System/Library/Automator/Run Shell Script.action</string>
                <key>ActionName</key>
                <string>Run Shell Script</string>
                <key>ActionParameters</key>
                <dict>
                    <key>source</key>
                    <dict>
                        <key>Value</key>
                        <string>#!/bin/bash

# Run Script Service
for f in "$@"
do
    if [ -f "$f" ]; then
        # Determine script type
        script_type=$(file -b "$f")
        
        case "$script_type" in
            *"Python script"*)
                echo "Running Python script: $f"
                python3 "$f"
                ;;
            *"Bourne-Again shell script"*|*"Bourne shell script"*)
                echo "Running Shell script: $f"
                bash "$f"
                ;;
            *"Node.js script"*)
                echo "Running Node.js script: $f"
                node "$f"
                ;;
            *"Perl script"*)
                echo "Running Perl script: $f"
                perl "$f"
                ;;
            *"Ruby script"*)
                echo "Running Ruby script: $f"
                ruby "$f"
                ;;
            *)
                echo "Unsupported script type: $script_type"
                echo "File: $f"
                exit 1
                ;;
        esac
        
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            echo "Script failed with exit code: $exit_code"
            osascript -e "display dialog \"Script execution failed\\nFile: $f\\nExit code: $exit_code\" buttons {\"OK\"} default button \"OK\" with icon stop"
        fi
    fi
done</string>
                    </dict>
                </dict>
            </dict>
            <key>isViewVisible</key>
            <true/>
        </dict>
    </array>
    <key>connectors</key>
    <dict/>
    <key>workflowMetaData</key>
    <dict>
        <key>serviceInputTypeIdentifier</key>
        <string>com.apple.Automator.item</string>
        <key>serviceOutputTypeIdentifier</key>
        <string>com.apple.Automator.nothing</string>
        <key>serviceProcessesInput</key>
        <integer>0</integer>
        <key>workflowTypeIdentifier</key>
        <string>com.apple.Automator.servicesMenu</string>
    </dict>
</dict>
</plist>
EOF
```

#### Step 4: Set Permissions
```bash
# Set correct permissions
chmod -R 755 ~/Library/Services/Copy\ Path.workflow
chmod -R 755 ~/Library/Services/Run\ Script.workflow
```

#### Step 5: Refresh Services
```bash
# Restart services
killall pbs
/System/Library/CoreServices/pbs -flush

# Restart Finder
killall Finder
```

## Verification

### Check Installation
```bash
# Verify service files exist
ls -la ~/Library/Services/Copy\ Path.workflow/
ls -la ~/Library/Services/Run\ Script.workflow/

# Check plist syntax
plutil -lint ~/Library/Services/Copy\ Path.workflow/Contents/Info.plist
plutil -lint ~/Library/Services/Run\ Script.workflow/Contents/Info.plist
```

### Test Services
1. **Open Finder**: Navigate to any file or folder
2. **Right-click**: Select a file or folder
3. **Context Menu**: Look for "Services" submenu
4. **Verify Services**: 
   - "Copy Path" should appear for any file/folder
   - "Run Script" should appear for script files

### Troubleshooting Installation

#### Common Issues

**Services Not Appearing**:
```bash
# Restart services
killall pbs
/System/Library/CoreServices/pbs -flush

# Restart Finder
killall Finder

# Wait 30 seconds for services to refresh
```

**Permission Errors**:
```bash
# Fix permissions
sudo chown -R $(whoami) ~/Library/Services/
chmod -R 755 ~/Library/Services/
```

**Installation Script Fails**:
```bash
# Check script permissions
ls -la install_*.sh

# Make executable
chmod +x install_*.sh

# Run with bash explicitly
bash install_copy_path_service.sh
```

#### System Requirements Check
```bash
# Check macOS version
sw_vers

# Check available space
df -h ~/Library/

# Check permissions
ls -la ~/Library/
```

## Uninstallation

### Automated Uninstallation
```bash
# Download and run uninstallation scripts
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/uninstall_copy_path_service.sh | bash
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/uninstall_run_script_service.sh | bash
```

### Manual Uninstallation
```bash
# Remove service directories
rm -rf ~/Library/Services/Copy\ Path.workflow
rm -rf ~/Library/Services/Run\ Script.workflow

# Restart services
killall pbs
/System/Library/CoreServices/pbs -flush
```

## Upgrading

### From Version 1.x to 2.0.0
1. **Backup Settings**: Export current preferences if needed
2. **Uninstall Old Version**: Run uninstallation scripts
3. **Install New Version**: Run new installation scripts
4. **Verify Services**: Test both services in Finder
5. **Migrate Settings**: Settings will be migrated automatically

### Automatic Upgrade
```bash
# Download and run upgrade script
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/upgrade.sh | bash
```

## Configuration

### Service Preferences

#### Copy Path Service
- **Default Format**: POSIX path format
- **Multiple Files**: Newline separator
- **Notifications**: Success notifications enabled

#### Run Script Service
- **Supported Languages**: Python, Bash, Node.js, Perl, Ruby
- **Output Display**: Terminal output
- **Error Handling**: Error dialogs on failure

### Customization

#### Modify Service Names
```bash
# Edit Info.plist to change service names
# Change the 'default' string in NSMenuItem
```

#### Add File Types
```bash
# Edit Info.plist to add supported file types
# Add to NSSendFileTypes array
```

## Security Considerations

### Script Execution Safety
- **User Confirmation**: Scripts run with user permissions
- **No Privilege Escalation**: Scripts cannot gain admin privileges
- **File Access**: Scripts can only access files user can access
- **Network Access**: Scripts have network access if user does

### Recommended Practices
- **Review Scripts**: Always review scripts before execution
- **Source Verification**: Only run scripts from trusted sources
- **Backup Data**: Backup important data before running unknown scripts
- **Sandbox Testing**: Test scripts in safe environment first

## Advanced Installation

### Enterprise Deployment

#### Mass Installation
```bash
# Create deployment script
#!/bin/bash
# Deploy to multiple users

for user in $(dscl . list /Users | grep -v '^_'); do
    if [ -d "/Users/$user/Library" ]; then
        sudo -u "$user" ./install_copy_path_service.sh
        sudo -u "$user" ./install_run_script_service.sh
    fi
done
```

#### Configuration Management
```bash
# Create default configuration
sudo mkdir -p /Library/Preferences/com.copypath.service.plist
# Add default settings
```

### Development Installation

#### From Source
```bash
# Clone repository
git clone https://github.com/USERNAME/macos-copy-path-service.git
cd macos-copy-path-service

# Install from source
./scripts/install_copy_path_service.sh
./scripts/install_run_script_service.sh
```

#### Development Version
```bash
# Install development version
./scripts/install_copy_path_service.sh --dev
./scripts/install_run_script_service.sh --dev
```

## Getting Help

### Installation Issues
- **[Troubleshooting Guide](TROUBLESHOOTING.md)**: Common installation problems
- **[FAQ](FAQ.md)**: Frequently asked questions
- **[Support](SUPPORT.md)**: Additional support options

### Community Support
- **GitHub Issues**: Report installation problems
- **GitHub Discussions**: Get help from community
- **Discord**: Real-time community support

---

**For detailed usage instructions, see the [User Guide](USER_GUIDE.md).**