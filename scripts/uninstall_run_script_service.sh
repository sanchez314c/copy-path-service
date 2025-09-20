#!/bin/bash
# Run Script Service Uninstaller for macOS
# Removes "Run Script" from right-click context menu

echo "🗑️  Uninstalling Run Script Service..."

SERVICES_DIR="$HOME/Library/Services"
WORKFLOW_DIR="$SERVICES_DIR/Run Script.workflow"

if [ -d "$WORKFLOW_DIR" ]; then
    rm -rf "$WORKFLOW_DIR"
    echo "✅ Run Script Service removed successfully!"
    echo ""
    echo "📝 Note: You may need to restart Finder for the change to take effect."
    echo "To restart Finder: killall Finder"
else
    echo "❌ Run Script Service not found - it may already be uninstalled."
fi

# Also remove log file if it exists
LOG_FILE="$HOME/Library/Logs/run-script-service.log"
if [ -f "$LOG_FILE" ]; then
    rm "$LOG_FILE"
    echo "🧹 Removed log file: $LOG_FILE"
fi