# Troubleshooting Guide

Common issues and solutions for the macOS Copy Path Service.

## 🔍 Quick Diagnosis

**Not seeing "Copy Path" in the context menu?**
1. Wait 30 seconds after installation
2. Restart Finder: `killall Finder`
3. Check System Preferences → Extensions → Finder Extensions

**"Copy Path" appears but doesn't work?**
1. Check Console.app for error messages
2. Verify service files exist
3. Try reinstalling the service

## 🚨 Common Issues

### Issue: "Copy Path" doesn't appear in context menu

**Symptoms:**
- Service installed successfully
- No "Copy Path" option when right-clicking files

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

3. **Check service file location:**
   ```bash
   ls -la ~/Library/Services/"Copy Path.workflow"
   # Should show the workflow directory
   ```

4. **Verify in System Preferences:**
   - System Preferences → Extensions → Finder Extensions
   - Look for "Copy Path" and ensure it's enabled

### Issue: Service appears but copying doesn't work

**Symptoms:**
- "Copy Path" appears in menu
- Clicking it does nothing or shows error

**Solutions:**

1. **Check Console for errors:**
   - Open Console.app
   - Look for messages related to "Copy Path" or "Automator"

2. **Verify workflow contents:**
   ```bash
   cat ~/Library/Services/"Copy Path.workflow/Contents/document.wflow"
   # Should contain AppleScript content
   ```

3. **Test manually:**
   ```bash
   # Test if the service is properly registered
   open ~/Library/Services/"Copy Path.workflow"
   ```

4. **Reinstall the service:**
   ```bash
   rm -rf ~/Library/Services/"Copy Path.workflow"
   ./scripts/install_copy_path_service.sh
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
   ```

2. **Run with explicit bash:**
   ```bash
   bash scripts/install_copy_path_service.sh
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

### Issue: Special characters in paths

**Symptoms:**
- Paths with spaces, quotes, or special characters cause issues
- Copied paths don't work in Terminal

**Solutions:**

1. **The service handles this automatically** - paths are properly formatted as POSIX paths

2. **If issues persist, check the AppleScript:**
   - The script uses `POSIX path` which handles special characters
   - Report this as a bug if you find cases it doesn't handle

### Issue: Multiple file selection

**Symptoms:**
- Selecting multiple files and using "Copy Path" only copies one path

**Current Behavior:**
- **This is expected** - the service currently copies the path of the first selected file
- **Feature request:** Multi-file support is planned for future versions

## 🔧 Advanced Troubleshooting

### Check service registration

```bash
# List all available services
defaults read pbs NSServicesStatus
```

### Manually test the AppleScript

```bash
# Create a test script
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
1. **Try the solutions above**
2. **Check existing GitHub issues**
3. **Test on a different file/folder**
4. **Try restarting your Mac** (if all else fails)

### When reporting issues:
1. **Include system information** (see above)
2. **Describe exact steps** to reproduce
3. **Include error messages** from Console.app
4. **Mention what you've already tried**

### Where to get help:
- **GitHub Issues**: [Report a bug](https://github.com/USERNAME/macos-copy-path-service/issues)
- **Discussions**: [Ask questions](https://github.com/USERNAME/macos-copy-path-service/discussions)

## 🔄 Clean Reinstallation

If all else fails, try a complete clean reinstall:

```bash
# 1. Remove existing service
rm -rf ~/Library/Services/"Copy Path.workflow"

# 2. Flush services
/System/Library/CoreServices/pbs -flush

# 3. Restart Finder
killall Finder

# 4. Wait 10 seconds
sleep 10

# 5. Reinstall
./scripts/install_copy_path_service.sh

# 6. Wait 30 seconds for services to refresh
sleep 30
```

## ✅ Verification Steps

After any fix, verify the service works:

1. **Right-click a file** in Finder
2. **Look for "Copy Path"** in Services submenu
3. **Click "Copy Path"**
4. **Open Terminal** and paste (`⌘+V`)
5. **Verify** the correct path appears

---

**Still having issues?** [Open a GitHub issue](https://github.com/USERNAME/macos-copy-path-service/issues) with your system info and error details!