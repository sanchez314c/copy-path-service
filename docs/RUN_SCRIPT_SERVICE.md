# 🚀 Run Script Service for macOS

A macOS service that adds "Run Script" to the right-click context menu in Finder, allowing you to execute Python, Bash, and Node.js scripts directly from the file system.

## ✨ Features

- **🔍 Smart Detection**: Automatically detects script type based on:
  - File extension (`.py`, `.sh`, `.bash`, `.js`)
  - Shebang lines (`#!/usr/bin/env python`, `#!/bin/bash`, etc.)
  - Content analysis as fallback
  
- **🐍 Python Support**: Executes Python scripts using `python3`
- **🔧 Bash Support**: Runs shell scripts using `bash`
- **📦 Node.js Support**: Executes JavaScript files using `node`
- **⚡ Executable Files**: Runs any executable file with proper permissions

- **📋 Output Display**: Shows script output in dialog boxes
- **📝 Logging**: Logs all activity to `~/Library/Logs/run-script-service.log`
- **🔔 Notifications**: macOS notifications for script start/completion
- **❌ Error Handling**: Clear error messages for common issues

## 🚀 Installation

Run the installation script:

```bash
cd /Volumes/apfsRAID/Development/Github/macos-copy-path-service
./scripts/install_run_script_service.sh
```

After installation, restart Finder:
```bash
killall Finder
```

## 📋 Usage

1. **Right-click** any Python, Bash, or Node.js script file in Finder
2. Select **"Run Script"** from the context menu
3. The script will execute and show results in a dialog

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

## 🔧 Examples

### Python Script
```python
#!/usr/bin/env python3
print("Hello from Python!")
print("Current directory:", os.getcwd())
```

### Bash Script
```bash
#!/bin/bash
echo "Hello from Bash!"
echo "Current user: $USER"
ls -la
```

### Node.js Script
```javascript
#!/usr/bin/env node
console.log("Hello from Node.js!");
console.log("Platform:", process.platform);
```

## 📊 Output Handling

- **Success**: Shows output in a dialog with ✅ success icon
- **Error**: Shows error output with ⚠️ warning icon
- **Long Output**: Truncates output over 500 characters
- **No Output**: Shows "Script executed successfully" message

## 📝 Logging

All activity is logged to:
```
~/Library/Logs/run-script-service.log
```

Log format:
```
15:30:25 - Run Script Service started
15:30:25 - Processing file: /path/to/script.py
15:30:25 - Detected Python script via extension
15:30:25 - Executing: python3 /path/to/script.py
15:30:26 - Script completed with exit code: 0
15:30:26 - Run Script Service completed
```

## ❌ Error Handling

The service handles common errors gracefully:

- **File not found**: "File not found: /path/to/script"
- **Permission denied**: "Cannot read file: /path/to/script"
- **Unknown type**: Shows supported file types
- **Missing interpreter**: "python3 is not installed or not in PATH"

## 🔧 Requirements

- **macOS**: 10.14+ (Mojave or later)
- **Python**: For `.py` scripts (install from [python.org](https://python.org))
- **Node.js**: For `.js` scripts (install from [nodejs.org](https://nodejs.org))
- **Bash**: Built into macOS

## 🗑️ Uninstallation

To remove the service:

```bash
./scripts/uninstall_run_script_service.sh
```

This removes:
- The service workflow
- Log files
- All associated data

## 🔒 Security Notes

- Scripts run with **your user permissions**
- No elevation or admin privileges
- Scripts execute in their **directory context**
- **Review scripts** before running from untrusted sources

## 🐛 Troubleshooting

### Service doesn't appear in context menu
1. Restart Finder: `killall Finder`
2. Log out and log back in
3. Check if service was installed: `ls ~/Library/Services/`

### Python scripts fail
1. Check if Python 3 is installed: `python3 --version`
2. Install Python from [python.org](https://python.org/downloads/)
3. Check script syntax and permissions

### Permission errors
1. Make script executable: `chmod +x script.py`
2. Check file ownership and permissions
3. Ensure you have read access to the file

### Check logs for debugging
```bash
tail -f ~/Library/Logs/run-script-service.log
```

## 🎯 Advanced Usage

### Custom Interpreters

The service can be extended to support other interpreters by modifying the detection logic in the install script.

### Environment Variables

Scripts inherit your shell environment, including:
- `PATH`
- `HOME`
- `USER`
- Custom environment variables

### Working Directory

Scripts execute with their containing directory as the working directory, making relative paths work correctly.

## 📚 Related Services

This complements the existing **Copy Path** service:
- **Copy Path**: Right-click → copy file path to clipboard
- **Run Script**: Right-click → execute script directly

Both services work together to enhance your macOS workflow.

---

**Created for enhanced macOS productivity** 🚀