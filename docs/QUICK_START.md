# Quick Start Guide

Get Copy Path Service up and running in under 5 minutes.

## 🚀 Quick Installation

### One-Line Installation

Copy and paste these commands in Terminal:

```bash
# Install Copy Path Service
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/install_copy_path_service.sh | bash

# Install Run Script Service  
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/install_run_script_service.sh | bash
```

### Manual Installation

1. **Download Scripts**: 
   - [Copy Path Service](https://github.com/USERNAME/macos-copy-path-service/raw/main/scripts/install_copy_path_service.sh)
   - [Run Script Service](https://github.com/USERNAME/macos-copy-path-service/raw/main/scripts/install_run_script_service.sh)

2. **Run Scripts**:
   ```bash
   chmod +x install_*.sh
   ./install_copy_path_service.sh
   ./install_run_script_service.sh
   ```

## ✅ Verification

### Check Services
1. **Open Finder**
2. **Right-click** any file or folder
3. **Look for "Services"** in context menu
4. **Verify both services** appear:
   - "Copy Path"
   - "Run Script" (for script files)

### Test Copy Path
1. **Select any file** in Finder
2. **Right-click** → **Services** → **Copy Path**
3. **Paste** anywhere (Cmd+V) to verify path was copied

### Test Run Script
1. **Create a test script**:
   ```bash
   echo 'echo "Hello from script!"' > test.sh
   chmod +x test.sh
   ```
2. **Right-click test.sh** → **Services** → **Run Script**
3. **Check output** in Terminal or notification

## 🔧 Basic Usage

### Copy Path Service

#### Single File
1. **Select file** in Finder
2. **Right-click** → **Services** → **Copy Path**
3. **Path copied** to clipboard

#### Multiple Files
1. **Select multiple files** (Cmd+click or Shift+click)
2. **Right-click** → **Services** → **Copy Path**
3. **All paths copied** (separated by newlines)

#### Folders
1. **Select folder** in Finder
2. **Right-click** → **Services** → **Copy Path**
3. **Folder path copied** to clipboard

### Run Script Service

#### Supported Script Types
- **Python** (`.py`)
- **Bash** (`.sh`, `.bash`)
- **Node.js** (`.js`)
- **Perl** (`.pl`, `.perl`)
- **Ruby** (`.rb`, `.ruby`)

#### Running Scripts
1. **Select script file** in Finder
2. **Right-click** → **Services** → **Run Script**
3. **Script executes** and shows output

## ⚡ Pro Tips

### Keyboard Shortcuts

Set up keyboard shortcuts for faster access:

1. **System Preferences** → **Keyboard** → **Shortcuts**
2. **Select "Services"** from left sidebar
3. **Find "Copy Path"** and "Run Script"**
4. **Click** and set your preferred shortcut
5. **Recommended shortcuts**:
   - Copy Path: ⌃⌥C (Ctrl+Option+C)
   - Run Script: ⌃⌥R (Ctrl+Option+R)

### Common Workflows

#### Development Workflow
```bash
# Copy path, then use in Terminal
cd /path/to/your/project
ls -la $(pbpaste)  # pbpaste gets clipboard content
```

#### Documentation Workflow
```markdown
# Copy file paths for documentation
- File: `/path/to/your/file.txt`
- Location: `/path/to/your/folder/`
```

#### Script Development Workflow
```bash
# Quick script testing
echo 'print("Hello World")' > test.py
# Right-click test.py → Run Script
```

## 🛠️ Troubleshooting

### Services Not Appearing

**Quick Fix**:
```bash
# Restart services
killall pbs
/System/Library/CoreServices/pbs -flush

# Restart Finder
killall Finder
```

**Wait 30 seconds** for services to refresh.

### Installation Issues

**Check Permissions**:
```bash
# Ensure scripts are executable
chmod +x install_*.sh

# Run with bash explicitly
bash install_copy_path_service.sh
```

**Check macOS Version**:
```bash
# Verify macOS 10.15+ compatibility
sw_vers
```

### Script Execution Issues

**Make Script Executable**:
```bash
chmod +x your_script.sh
```

**Check Script Syntax**:
```bash
# For shell scripts
bash -n your_script.sh

# For Python scripts
python3 -m py_compile your_script.py
```

## 📚 Next Steps

### Learn More
- **[User Guide](USER_GUIDE.md)**: Complete usage instructions
- **[Installation Guide](INSTALLATION.md)**: Detailed installation options
- **[Troubleshooting](TROUBLESHOOTING.md)**: Common issues and solutions
- **[FAQ](FAQ.md)**: Frequently asked questions

### Advanced Features
- **Multiple File Selection**: Select multiple files before copying
- **Script Types**: Support for many scripting languages
- **Integration**: Works with Terminal, editors, and more
- **Customization**: Configure keyboard shortcuts and preferences

### Community
- **GitHub**: [Report issues](https://github.com/USERNAME/macos-copy-path-service/issues)
- **Discussions**: [Join discussions](https://github.com/USERNAME/macos-copy-path-service/discussions)
- **Discord**: [Community chat](https://discord.gg/example)

## 🎉 You're Ready!

Congratulations! You now have Copy Path Service installed and ready to use. Here are some ideas to get you started:

### Try These Now
1. **Copy a file path** and paste it in Terminal
2. **Create a simple Python script** and run it with Run Script
3. **Select multiple files** and copy all their paths at once
4. **Set up keyboard shortcuts** for faster access

### Common Use Cases
- **Development**: Quickly copy file paths for code
- **Documentation**: Add file paths to documentation
- **Scripting**: Run scripts directly from Finder
- **File Management**: Copy paths for file operations
- **Automation**: Integrate with other workflows

### Productivity Tips
- **Use keyboard shortcuts** for faster access
- **Combine with Terminal** for powerful workflows
- **Create script templates** for common tasks
- **Use multiple file selection** for batch operations

---

**Need help?** Check our [Support](SUPPORT.md) page or [FAQ](FAQ.md) for more assistance.