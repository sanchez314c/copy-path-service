# User Guide

Complete guide to using Copy Path Service and Run Script Service on macOS.

## 🎯 Overview

Copy Path Service adds two powerful options to your Finder context menu:

- **Copy Path**: Instantly copy file and folder paths to clipboard
- **Run Script**: Execute Python, Bash, Node.js, and other scripts directly from Finder

No more dragging files to Terminal or typing long paths manually!

## 📋 Table of Contents

- [Copy Path Service](#copy-path-service)
- [Run Script Service](#run-script-service)
- [Use Cases](#use-cases)
- [Tips and Tricks](#tips-and-tricks)
- [Troubleshooting](#troubleshooting)
- [Keyboard Shortcuts](#keyboard-shortcuts)

---

## 📋 Copy Path Service

### Basic Usage

#### Step-by-Step Instructions

1. **Select a File or Folder**
   - Click any file or folder in Finder
   - Works with all file types and directories

2. **Right-Click (or Control+Click)**
   - Opens the context menu
   - Look for "Services" submenu

3. **Select "Copy Path"**
   - Navigate to Services → Copy Path
   - Click to copy the path to clipboard

4. **Paste Anywhere**
   - Switch to Terminal, text editor, or any application
   - Paste with `⌘+V` or right-click → Paste

### Visual Guide

```
Finder Context Menu:
├── Open
├── Get Info
├── Compress
├── Services ▸
│   ├── Copy Path ← Click this!
│   ├── Run Script (if installed)
│   └── Other services...
├── Copy
└── Move to Trash
```

### Working with Different File Types

#### Regular Files
```
Selected: document.pdf
Copied: /Users/username/Documents/document.pdf
```

#### Folders
```
Selected: Photos folder
Copied: /Users/username/Pictures/Photos
```

#### Files with Special Characters
```
Selected: "My File (2024).txt"
Copied: /Users/username/Desktop/My\ File\ \(2024\).txt
```

#### Files with Spaces
```
Selected: "project folder/main.js"
Copied: /Users/username/Desktop/project\ folder/main.js
```

#### Hidden Files
```
Selected: .gitignore
Copied: /Users/username/project/.gitignore
```

### Path Formats

The service always copies **POSIX paths** that work universally in macOS:

```bash
# POSIX format (what you get)
/Users/username/Documents/file.txt

# NOT HFS format (what you don't get)
Macintosh HD:Users:username:Documents:file.txt
```

---

## 🚀 Run Script Service

### Basic Usage

#### Step-by-Step Instructions

1. **Select a Script File**
   - Click any Python (.py), Bash (.sh), or Node.js (.js) file
   - Works with executable files too

2. **Right-Click (or Control+Click)**
   - Opens the context menu
   - Look for "Services" submenu

3. **Select "Run Script"**
   - Navigate to Services → Run Script
   - Click to execute the script

4. **View Results**
   - Script output appears in a dialog box
   - Errors are displayed with clear messages

### Supported File Types

| Extension | Executor | Example |
|-----------|----------|---------|
| `.py` | `python3` | `my_script.py` |
| `.sh` | `bash` | `deploy.sh` |
| `.bash` | `bash` | `build.bash` |
| `.js` | `node` | `app.js` |
| No extension | Direct execution | Any executable file |

### Shebang Support

The service recognizes these shebang patterns:

```bash
#!/usr/bin/env python3
#!/usr/bin/env python
#!/usr/bin/env bash
#!/bin/bash
#!/bin/sh
```

### Script Examples

#### Python Script
```python
#!/usr/bin/env python3
print("Hello from Python!")
print("Current directory:", os.getcwd())
```

#### Bash Script
```bash
#!/bin/bash
echo "Hello from Bash!"
echo "Current user: $USER"
ls -la
```

#### Node.js Script
```javascript
#!/usr/bin/env node
console.log("Hello from Node.js!");
console.log("Platform:", process.platform);
```

### Output Handling

- **Success**: Shows output in a dialog with ✅ success icon
- **Error**: Shows error output with ⚠️ warning icon
- **Long Output**: Truncates output over 500 characters
- **No Output**: Shows "Script executed successfully" message

---

## 💻 Use Cases

### Development Workflow

#### Terminal Operations
```bash
# Navigate to directories
cd [paste path here]

# Open files in editors
code [paste file path here]
vim [paste file path here]

# File operations
cp [paste source] [paste destination]
mv [paste old location] [paste new location]
```

#### Programming
```python
# Python - reading files
with open('[paste path here]', 'r') as f:
    content = f.read()

# Node.js - requiring modules
const config = require('[paste path here]')
```

#### Version Control
```bash
# Git operations
git add [paste file path]
git checkout [paste file path]
git diff [paste file path]
```

### Documentation and Writing

#### Markdown Files
```markdown
# Link to local file
[Configuration File](file:///Users/username/.config/app/settings.json)

# Include code from file
```bash
# See: [paste script path]
```

#### Technical Documentation
```
Configuration located at: [paste path]
Log files available in: [paste directory path]
```

### System Administration

#### Configuration Files
```bash
# Edit system files
sudo nano [paste config file path]

# Check permissions
ls -la [paste file path]

# Change ownership
sudo chown user:group [paste file path]
```

#### Scripting
```bash
# Make scripts executable
chmod +x [paste script path]

# Run scripts
./[paste script path]
```

### Media and Design

#### File References
```
Image source: [paste image path]
Font location: [paste font path]
Asset directory: [paste directory path]
```

#### Creative Workflow
```bash
# Open files in specific applications
open -a "Adobe Photoshop" [paste image path]
open -a "Sketch" [paste design path]
```

---

## 🎯 Tips and Tricks

### Productivity Tips

1. **Keyboard Navigation**
   - Use `Tab` to navigate context menu
   - `Enter` to select service
   - Faster than mouse for frequent use

2. **Quick Testing**
   - Test with a simple file first
   - Verify path appears correctly when pasted

3. **Integration with Other Tools**
   - Works with Alfred, Raycast, and other launchers
   - Integrates with Terminal multiplexers (tmux, screen)

### Time-Saving Workflows

#### Development Environment Setup
```bash
# Instead of typing paths:
cd ~/Projects/web-app && npm start

# Use copy path:
cd [paste project path] && npm start
```

#### File Management
```bash
# Instead of browsing:
cp ~/Downloads/report.pdf ~/Documents/Work/

# Use copy path:
cp [paste downloaded file] [paste destination]
```

#### Configuration Management
```bash
# Backup configuration files
cp [paste config file] [paste backup location]

# Compare configurations
diff [paste config1] [paste config2]
```

### Path Handling

#### Quoting in Shell
```bash
# Single quotes (safer for complex paths)
cd '[paste path here]'

# Double quotes (works for most cases)
cd "[paste path here]"
```

#### Special Characters
The service automatically escapes special characters:
- Spaces → `\ `
- Parentheses → `\(` `\)`
- Quotes → `\"`
- Other special characters → `\X`

---

## 🔍 Troubleshooting

### Common Issues

#### Service Doesn't Appear in Menu

**Symptoms:**
- Service options missing from Services menu

**Solutions:**
1. **Wait 30 seconds** after installation
2. **Restart Finder**: `killall Finder`
3. **Check System Preferences** → Extensions → Finder Extensions
4. **Restart your Mac** (if all else fails)

#### Path Doesn't Copy Correctly

**Symptoms:**
- Clipboard empty after using service
- Incorrect path format

**Solutions:**
1. **Try again** - sometimes service needs a second attempt
2. **Check Console.app** for error messages
3. **Reinstall service**: Run installer again
4. **Test with different files** to isolate the issue

#### Script Execution Fails

**Symptoms:**
- Scripts don't run when using Run Script service
- Error messages appear

**Solutions:**
1. **Check interpreter installation**: `python3 --version`, `node --version`
2. **Verify script syntax** and permissions
3. **Check log file**: `~/Library/Logs/run-script-service.log`
4. **Test script manually** in Terminal

### System-Specific Issues

#### macOS Version Compatibility

**macOS 10.6-10.14:**
- Full compatibility expected
- No known issues

**macOS 10.15+ (Catalina and newer):**
- May need to grant permissions
- Check Security & Privacy preferences

**macOS 11+ (Big Sur and newer on Apple Silicon):**
- Rosetta 2 compatibility verified
- Native Apple Silicon support

#### File System Issues

**External Drives:**
- Works with most external drives
- May have issues with network drives
- Check drive format and permissions

**Cloud Storage:**
- Works with iCloud Drive
- Works with Dropbox/Google Drive
- Path may reflect local cache location

---

## ⌨️ Keyboard Shortcuts

### System Shortcuts

| Action | Shortcut | Context |
|--------|----------|---------|
| Copy Path | Context menu only | Finder |
| Run Script | Context menu only | Finder |
| Paste | `⌘+V` | Any application |
| Context Menu | `Control+Click` | Finder |
| Tab Navigation | `Tab` | Context menu |
| Select Item | `Enter` | Context menu |

### Application-Specific

#### Terminal
```bash
# Quick paste with quotes
Command+V → Type single quotes around pasted path
```

#### Text Editors
- **VS Code**: `⌘+V` to paste path
- **Sublime Text**: `⌘+V` to paste path
- **TextEdit**: `⌘+V` to paste path

#### Browsers
- **Chrome**: `⌘+V` to paste path in address bar
- **Safari**: `⌘+V` to paste path in address bar

---

## 🔄 Maintenance

### Keeping Services Updated

1. **Check for Updates**
   - Visit GitHub repository periodically
   - Look for new releases

2. **Reinstall for Updates**
   ```bash
   # Reinstall to get latest version
   ./scripts/install_copy_path_service.sh
   ./scripts/install_run_script_service.sh
   ```

3. **Verify Functionality**
   - Test with various file types
   - Ensure performance is acceptable

### System Health

1. **Regular Restarts**
   - Restart Finder weekly: `killall Finder`
   - Restart Mac monthly for best performance

2. **Monitor Performance**
   - Services should be instant (<200ms)
   - No background processes

3. **Check Storage**
   - Services use <10KB of disk space
   - No logs or cache files (except Run Script logs)

---

## 📚 Advanced Topics

### For Power Users

#### Integration with Other Tools

**Alfred/Raycast:**
- Create workflow that includes Copy Path service
- Set up custom keywords

**Terminal Multiplexers:**
- Works with tmux and screen sessions
- Path copying persists across sessions

**IDE Integration:**
- VS Code: Use with integrated terminal
- IntelliJ: Works with built-in terminal
- Vim/Emacs: Terminal-based editors

#### Custom Workflows

**Development Environment Setup:**
```bash
# One-time setup script
PROJECT_PATH=$(pbpaste)  # Paste copied path
cd "$PROJECT_PATH"
npm install
code .
```

**Backup Automation:**
```bash
# Backup script
SOURCE_PATH=$(pbpaste)
DESTINATION="/backup/$(date +%Y%m%d)/"
cp -r "$SOURCE_PATH" "$DESTINATION"
```

### Technical Details

#### What Actually Happens

**Copy Path Service:**
1. **User Action**: Right-click → Services → Copy Path
2. **System Event**: Finder sends file selection to Services framework
3. **Service Execution**: Automator Quick Action runs
4. **AppleScript**: Extracts POSIX path and copies to clipboard
5. **Completion**: Service terminates, no user feedback

**Run Script Service:**
1. **User Action**: Right-click → Services → Run Script
2. **System Event**: Finder sends file selection to Services framework
3. **Service Execution**: Automator Quick Action runs
4. **Script Detection**: Determines script type and executor
5. **Execution**: Runs script with appropriate interpreter
6. **Output Display**: Shows results in dialog box
7. **Logging**: Records activity to log file

#### Performance Characteristics

- **Startup Time**: <100ms
- **Execution Time**: <10ms (Copy Path), <1s (Run Script)
- **Memory Usage**: <5MB (temporary)
- **Disk Usage**: <10KB total
- **Network Usage**: None

---

## 🆘 Getting Help

### Additional Resources

- **[Installation Guide](INSTALLATION.md)** - Installation and setup
- **[Troubleshooting Guide](TROUBLESHOOTING.md)** - Detailed troubleshooting
- **[FAQ](FAQ.md)** - Frequently asked questions
- **[Security Guide](SECURITY.md)** - Security considerations

### Support Channels

- **GitHub Issues**: [Open an issue](https://github.com/USERNAME/copy-path-service/issues)
- **Documentation**: Check all docs in `/docs` folder
- **Community**: Join discussions in GitHub repository

---

**Need more help?** Check our [troubleshooting guide](TROUBLESHOOTING.md) or [open an issue](https://github.com/USERNAME/copy-path-service/issues).