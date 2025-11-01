# Troubleshooting Guide

Common issues and solutions for Copy Path Service - a macOS utility that adds "Copy Path" and "Run Script" options to the Finder context menu.

## 🔍 Quick Diagnosis

**Not seeing services in the context menu?**
1. Wait 30 seconds after installation
2. Restart Finder: `killall Finder`
3. Check System Preferences → Extensions → Finder Extensions

**Services appear but don't work?**
1. Check Console.app for error messages
2. Verify service files exist
3. Try reinstalling services

## 🚨 Common Issues

### Issue: Services don't appear in context menu

**Symptoms:**
- Services installed successfully
- No "Copy Path" or "Run Script" options when right-clicking files

**Solutions:**

1. **Wait for Services to refresh:**
   ```bash
   # Services can take up to 30 seconds to appear
   # Just wait and try again
   ```

2. **Manually refresh Services:**
   ```bash
   /System/Library/CoreServices/pbs -flush
   killall Finder
   ```

3. **Check service file locations:**
   ```bash
   ls -la ~/Library/Services/"Copy Path.workflow"
   ls -la ~/Library/Services/"Run Script.workflow"
   # Should show workflow directories
   ```

4. **Verify in System Preferences:**
   - System Preferences → Extensions → Finder Extensions
   - Look for "Copy Path" and "Run Script" and ensure they're enabled

### Issue: Service appears but doesn't work

**Symptoms:**
- Services appear in menu
- Clicking them does nothing or shows error

**Solutions:**

1. **Check Console for errors:**
   - Open Console.app
   - Look for messages related to "Copy Path", "Run Script", or "Automator"

2. **Verify workflow contents:**
   ```bash
   cat ~/Library/Services/"Copy Path.workflow/Contents/document.wflow"
   cat ~/Library/Services/"Run Script.workflow/Contents/document.wflow"
   # Should contain AppleScript content
   ```

3. **Test manually:**
   ```bash
   # Test if services are properly registered
   open ~/Library/Services/"Copy Path.workflow"
   open ~/Library/Services/"Run Script.workflow"
   ```

4. **Reinstall services:**
   ```bash
   rm -rf ~/Library/Services/"Copy Path.workflow"
   rm -rf ~/Library/Services/"Run Script.workflow"
   ./scripts/install_copy_path_service.sh
   ./scripts/install_run_script_service.sh
   ```

### Issue: Installation script fails

**Symptoms:**
- Script exits with error
- Permission denied messages
- Files not created

**Solutions:**

1. **Check script permissions:**
   ```bash
   chmod +x scripts/install_copy_path_service.sh
   chmod +x scripts/install_run_script_service.sh
   ```

2. **Run with explicit bash:**
   ```bash
   bash scripts/install_copy_path_service.sh
   bash scripts/install_run_script_service.sh
   ```

3. **Check disk space:**
   ```bash
   df -h ~
   # Ensure adequate free space
   ```

4. **Verify write permissions:**
   ```bash
   ls -la ~/Library/
   # Should show write permissions for your user
   ```

### Issue: Run Script service doesn't execute scripts

**Symptoms:**
- "Run Script" appears in menu
- Clicking it does nothing or shows "cannot execute" error

**Solutions:**

1. **Check script permissions:**
   ```bash
   chmod +x your_script.py
   chmod +x your_script.sh
   ```

2. **Verify script shebang:**
   ```bash
   # Python scripts must start with:
   #!/usr/bin/env python3
   
   # Bash scripts must start with:
   #!/bin/bash
   ```

3. **Test script manually:**
   ```bash
   ./your_script.py
   # Should run without errors
   ```

4. **Check supported file types:**
   - Python: `.py` files
   - Bash: `.sh` files
   - Node.js: `.js` files
   - Other: Check file has execute permissions

### Issue: Special characters in paths

**Symptoms:**
- Paths with spaces, quotes, or special characters cause issues
- Copied paths don't work in Terminal

**Solutions:**

1. **The services handle this automatically** - paths are properly formatted as POSIX paths

2. **If issues persist, check AppleScript:**
   - The script uses `POSIX path` which handles special characters
   - Report this as a bug if you find cases it doesn't handle

### Issue: Multiple file selection

**Symptoms:**
- Selecting multiple files and using services only processes one file

**Current Behavior:**
- **This is expected** - services currently process the first selected file
- **Feature request:** Multi-file support is planned for future versions

## 🔧 Advanced Troubleshooting

### Check service registration

```bash
# List all available services
defaults read pbs NSServicesStatus
```

### Manually test AppleScript

```bash
# Create a test script for Copy Path
cat > test_copy_path.scpt << 'EOF'
on run {input, parameters}
    set the clipboard to POSIX path of (item 1 of input)
    return input
end run
EOF

# Test with a file
osascript test_copy_path.scpt "/Users/$(whoami)/Desktop"
```

### Check Automator functionality

```bash
# Verify Automator is working
automator --version
```

### Reset Services database

```bash
# Nuclear option: reset all services
/System/Library/CoreServices/pbs -flush_pboard
/System/Library/CoreServices/pbs -flush
killall Finder
```

## 📊 System Information

When reporting issues, please include:

### macOS Version
```bash
sw_vers
```

### Service Status
```bash
ls -la ~/Library/Services/"Copy Path.workflow/Contents/"
ls -la ~/Library/Services/"Run Script.workflow/Contents/"
```

### Console Errors
```bash
# Check for recent errors
log show --predicate 'subsystem contains "com.apple.automator"' --last 1h
```

### Finder Extensions
```bash
# List enabled Finder extensions
pluginkit -m -p com.apple.Finder.FinderSync
```

## 🆘 Getting Help

### Before seeking help:
1. **Try to solutions above**
2. **Check existing GitHub issues**
3. **Test on a different file/folder**
4. **Try restarting your Mac** (if all else fails)

### When reporting issues:
1. **Include system information** (see above)
2. **Describe exact steps** to reproduce
3. **Include error messages** from Console.app
4. **Mention what you've already tried**

### Where to get help:
- **GitHub Issues**: [Report a bug](https://github.com/USERNAME/copy-path-service/issues)
- **Discussions**: [Ask questions](https://github.com/USERNAME/copy-path-service/discussions)

## 🔄 Clean Reinstallation

If all else fails, try a complete clean reinstall:

```bash
# 1. Remove existing services
rm -rf ~/Library/Services/"Copy Path.workflow"
rm -rf ~/Library/Services/"Run Script.workflow"

# 2. Flush services
/System/Library/CoreServices/pbs -flush

# 3. Restart Finder
killall Finder

# 4. Wait 10 seconds
sleep 10

# 5. Reinstall both services
./scripts/install_copy_path_service.sh
./scripts/install_run_script_service.sh

# 6. Wait 30 seconds for services to refresh
sleep 30
```

## ✅ Verification Steps

After any fix, verify services work:

### Copy Path Service:
1. **Right-click a file** in Finder
2. **Look for "Copy Path"** in Services submenu
3. **Click "Copy Path"**
4. **Open Terminal** and paste (`⌘+V`)
5. **Verify** correct path appears

### Run Script Service:
1. **Create a test script** (e.g., `test.py` with `print("Hello World")`)
2. **Make it executable**: `chmod +x test.py`
3. **Right-click the script** in Finder
4. **Look for "Run Script"** in Services submenu
5. **Click "Run Script"**
6. **Verify** script executes and shows output

---

**Still having issues?** [Open a GitHub issue](https://github.com/USERNAME/copy-path-service/issues) with your system info and error details!