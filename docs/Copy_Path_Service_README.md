# Copy Path Service for macOS

Adds a "Copy Path" option to the right-click context menu in Finder, making it easy to copy file and folder paths without dragging them to Terminal.

## 📋 What It Does

- **Right-click any file or folder** → Select "Copy Path"
- **Copies the full POSIX path** to your clipboard (e.g., `/Users/username/Desktop/file.txt`)
- **Works instantly** with no notifications or popups (clean operation)
- **Perfect for Terminal work** - no more dragging files to get paths!

## 🚀 Quick Install

Run the install script:

```bash
# Make executable and run
chmod +x ~/Desktop/install_copy_path_service.sh
~/Desktop/install_copy_path_service.sh
```

## 💻 Manual Installation

If you prefer to install manually:

1. **Create the workflow directory:**
   ```bash
   mkdir -p ~/Library/Services/"Copy Path.workflow/Contents"
   ```

2. **Run the install script** (recommended) or manually copy the files from the script

3. **Refresh Services:**
   ```bash
   /System/Library/CoreServices/pbs -flush
   killall Finder
   ```

## 🔧 Usage

1. **Right-click** any file or folder in Finder
2. Look for **"Copy Path"** in the Services submenu
3. **Click it** to copy the full path
4. **Paste** anywhere you need the path (Terminal, text editor, etc.)

## ⚙️ Customization

### Add Notifications (Optional)

If you want to see a notification when the path is copied, modify the AppleScript in the workflow to:

```applescript
on run {input, parameters}
	set the clipboard to POSIX path of (item 1 of input)
	set filePath to POSIX path of (item 1 of input)
	
	display notification "Path copied: " & filePath with title "Copy Path" sound name "Glass"
	
	return input
end run
```

### Remove the Service

To uninstall:

```bash
rm -rf ~/Library/Services/"Copy Path.workflow"
/System/Library/CoreServices/pbs -flush
```

## 🐛 Troubleshooting

**Don't see "Copy Path" in the menu?**
- Wait 30 seconds for Services to refresh
- Try restarting Finder: `killall Finder`
- Check System Preferences → Extensions → Finder Extensions

**Service appears but doesn't work?**
- Make sure the workflow files are properly formatted
- Check Console.app for error messages
- Try reinstalling with the script

## 📁 File Locations

- **Service Location:** `~/Library/Services/Copy Path.workflow/`
- **Install Script:** `~/Desktop/install_copy_path_service.sh`
- **This README:** `~/Desktop/Copy_Path_Service_README.md`

## 🎯 Technical Details

- **Technology:** macOS Automator Quick Action (Service)
- **Script:** AppleScript to copy POSIX path to clipboard
- **Compatibility:** macOS 10.6+ (all modern versions)
- **Performance:** Instant execution, no background processes

## 📚 What's Included

1. **`install_copy_path_service.sh`** - Automated installer script
2. **`Copy_Path_Service_README.md`** - This documentation
3. **Installed Service** - The actual Copy Path service in your Services menu

## 💡 Pro Tips

- **Multiple files:** The service works on the first selected file
- **Folders work too:** Right-click any folder to copy its path
- **Terminal integration:** Perfect for `cd` commands and file operations
- **No spaces issues:** Paths are properly formatted for Terminal use

## 🔄 Updates

To update the service, simply run the install script again. It will overwrite the existing service with the latest version.

---

**Created by:** Claude & heathen-admin  
**Date:** September 2025  
**Version:** 1.0 (No Notifications)