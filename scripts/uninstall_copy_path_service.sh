#!/bin/bash
# Copy Path Service Uninstaller for macOS
# Removes the "Copy Path" service from Finder context menu

echo "🗑️  Uninstalling Copy Path Service..."

# Service location
SERVICE_PATH="$HOME/Library/Services/Copy Path.workflow"

# Check if service exists
if [ -d "$SERVICE_PATH" ]; then
    echo "📁 Found service at: $SERVICE_PATH"
    
    # Remove the service
    rm -rf "$SERVICE_PATH"
    
    if [ $? -eq 0 ]; then
        echo "✅ Service removed successfully"
    else
        echo "❌ Error removing service"
        exit 1
    fi
else
    echo "ℹ️  Service not found - may already be uninstalled"
fi

echo "🔄 Refreshing Services menu..."

# Refresh Services menu
/System/Library/CoreServices/pbs -flush 2>/dev/null

# Optional: Restart Finder for immediate effect
read -p "🔄 Restart Finder for immediate effect? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    killall Finder 2>/dev/null
    echo "🔄 Finder restarted"
fi

echo "✅ Uninstallation complete!"
echo ""
echo "The 'Copy Path' service has been removed from your system."
echo "If you change your mind, you can reinstall using:"
echo "  ./scripts/install_copy_path_service.sh"