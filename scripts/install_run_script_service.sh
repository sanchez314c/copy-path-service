#!/bin/bash
# Run Script Service Installer for macOS
# Adds "Run Script" to right-click context menu for Python and Bash scripts

echo "🚀 Installing Run Script Service..."

# Create Services directory if it doesn't exist
SERVICES_DIR="$HOME/Library/Services"
WORKFLOW_DIR="$SERVICES_DIR/Run Script.workflow"
CONTENTS_DIR="$WORKFLOW_DIR/Contents"

mkdir -p "$CONTENTS_DIR"

# Create Info.plist
cat > "$CONTENTS_DIR/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleIdentifier</key>
	<string>com.apple.Automator.Run Script</string>
	<key>CFBundleName</key>
	<string>Run Script</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>NSServices</key>
	<array>
		<dict>
			<key>NSMenuItem</key>
			<dict>
				<key>default</key>
				<string>Run Script</string>
			</dict>
			<key>NSMessage</key>
			<string>runWorkflowWithInput</string>
			<key>NSRequiredContext</key>
			<array>
				<dict>
					<key>NSApplicationIdentifier</key>
					<string>com.apple.finder</string>
				</dict>
			</array>
			<key>NSSendFileTypes</key>
			<array>
				<string>public.unix-executable</string>
				<string>public.shell-script</string>
				<string>public.python-script</string>
				<string>com.netscape.javascript-source</string>
				<string>public.plain-text</string>
			</array>
		</dict>
	</array>
</dict>
</plist>
EOF

# Create document.wflow
cat > "$CONTENTS_DIR/document.wflow" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>AMApplicationBuild</key>
	<string>521.1</string>
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
					<key>COMMAND_STRING</key>
					<dict/>
					<key>CheckedForUserDefaultShell</key>
					<dict/>
					<key>inputMethod</key>
					<dict/>
					<key>shell</key>
					<dict/>
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
					<key>COMMAND_STRING</key>
					<string>#!/bin/bash

# Run Script Service - Intelligently executes Python or Bash scripts
# Created for macOS context menu integration

# Function to log messages
log_message() {
    echo "$(date +'%H:%M:%S') - $1" >> ~/Library/Logs/run-script-service.log
}

# Function to show notification
show_notification() {
    osascript -e "display notification \"$2\" with title \"Run Script\" subtitle \"$1\""
}

# Function to show error dialog
show_error() {
    osascript -e "display dialog \"$1\" with title \"Run Script Error\" buttons {\"OK\"} default button \"OK\" with icon stop"
}

# Function to show success dialog with output
show_output() {
    local script_name="$1"
    local output="$2"
    local exit_code="$3"
    
    if [ ${#output} -gt 500 ]; then
        output="${output:0:500}..."
    fi
    
    if [ $exit_code -eq 0 ]; then
        osascript -e "display dialog \"Script executed successfully!

Output:
$output\" with title \"$script_name - Success\" buttons {\"OK\"} default button \"OK\" with icon note"
    else
        osascript -e "display dialog \"Script failed with exit code $exit_code

Output:
$output\" with title \"$script_name - Error\" buttons {\"OK\"} default button \"OK\" with icon caution"
    fi
}

# Function to determine script type and execute
run_script() {
    local file_path="$1"
    local file_name=$(basename "$file_path")
    local extension="${file_path##*.}"
    
    log_message "Attempting to run: $file_path"
    
    # Check if file exists
    if [ ! -f "$file_path" ]; then
        show_error "File not found: $file_path"
        return 1
    fi
    
    # Check if file is readable
    if [ ! -r "$file_path" ]; then
        show_error "Cannot read file: $file_path"
        return 1
    fi
    
    # Change to the script's directory
    cd "$(dirname "$file_path")"
    
    # Determine execution method based on extension and shebang
    local executor=""
    local exec_args=""
    
    # Check shebang first
    local shebang=$(head -n1 "$file_path" 2>/dev/null)
    
    if [[ "$shebang" =~ ^#!.*python ]]; then
        executor="python3"
        log_message "Detected Python script via shebang"
    elif [[ "$shebang" =~ ^#!/bin/bash ]] || [[ "$shebang" =~ ^#!/bin/sh ]]; then
        executor="bash"
        log_message "Detected Bash script via shebang"
    elif [[ "$shebang" =~ ^#!/usr/bin/env\ python ]]; then
        executor="python3"
        log_message "Detected Python script via env shebang"
    elif [[ "$shebang" =~ ^#!/usr/bin/env\ bash ]]; then
        executor="bash"
        log_message "Detected Bash script via env shebang"
    else
        # Fall back to extension
        case "$extension" in
            py)
                executor="python3"
                log_message "Detected Python script via extension"
                ;;
            sh|bash)
                executor="bash"
                log_message "Detected Bash script via extension"
                ;;
            js)
                executor="node"
                log_message "Detected Node.js script via extension"
                ;;
            *)
                # Check if file is executable
                if [ -x "$file_path" ]; then
                    executor=""
                    log_message "File is executable, running directly"
                else
                    # Try to detect by content
                    if grep -q "python" "$file_path" 2>/dev/null; then
                        executor="python3"
                        log_message "Detected Python script via content analysis"
                    elif grep -q "#!/bin/bash\|#!/bin/sh" "$file_path" 2>/dev/null; then
                        executor="bash"
                        log_message "Detected Bash script via content analysis"
                    else
                        show_error "Cannot determine script type for: $file_name

Supported types:
• Python scripts (.py)
• Bash scripts (.sh, .bash)
• Node.js scripts (.js)
• Executable files with shebang"
                        return 1
                    fi
                fi
                ;;
        esac
    fi
    
    # Check if executor exists
    if [ -n "$executor" ] && ! command -v "$executor" &> /dev/null; then
        show_error "$executor is not installed or not in PATH.

Please install $executor to run this script."
        return 1
    fi
    
    # Show starting notification
    show_notification "Starting..." "$file_name"
    
    # Execute the script and capture output
    local output
    local exit_code
    
    if [ -n "$executor" ]; then
        log_message "Executing: $executor $file_path"
        output=$($executor "$file_path" 2>&1)
        exit_code=$?
    else
        log_message "Executing: $file_path"
        output=$("$file_path" 2>&1)
        exit_code=$?
    fi
    
    log_message "Script completed with exit code: $exit_code"
    
    # Show result
    show_output "$file_name" "$output" "$exit_code"
    
    return $exit_code
}

# Main execution
log_message "Run Script Service started"

# Process each input file
for file_path in "$@"; do
    log_message "Processing file: $file_path"
    run_script "$file_path"
done

log_message "Run Script Service completed"
</string>
					<key>CheckedForUserDefaultShell</key>
					<true/>
					<key>inputMethod</key>
					<integer>1</integer>
					<key>shell</key>
					<string>/bin/bash</string>
					<key>source</key>
					<string></string>
				</dict>
				<key>BundleIdentifier</key>
				<string>com.apple.RunShellScript</string>
				<key>CFBundleVersion</key>
				<string>2.0.3</string>
				<key>CanShowSelectedItemsWhenRun</key>
				<false/>
				<key>CanShowWhenRun</key>
				<true/>
				<key>Category</key>
				<array>
					<string>AMCategoryUtilities</string>
				</array>
				<key>Class Name</key>
				<string>RunShellScriptAction</string>
				<key>InputUUID</key>
				<string>A4F8F43A-6C4A-4B85-8B5F-6E1A24E8F8DC</string>
				<key>Keywords</key>
				<array>
					<string>Shell</string>
					<string>Script</string>
					<string>Command</string>
					<string>Run</string>
					<string>Unix</string>
				</array>
				<key>OutputUUID</key>
				<string>B8F9E54B-7D5B-4C96-9C6F-7F2B35F9F9ED</string>
				<key>UUID</key>
				<string>C9FAF65C-8E6C-4DA7-AD7F-8E3C46FAFAEE</string>
				<key>UnlocalizedApplications</key>
				<array>
					<string>Automator</string>
				</array>
				<key>arguments</key>
				<dict>
					<key>0</key>
					<dict>
						<key>default value</key>
						<string></string>
						<key>name</key>
						<string>COMMAND_STRING</string>
						<key>required</key>
						<string>0</string>
						<key>type</key>
						<string>0</string>
						<key>uuid</key>
						<string>0</string>
					</dict>
				</dict>
				<key>isViewVisible</key>
				<true/>
				<key>location</key>
				<string>449.000000:316.000000</string>
				<key>nibPath</key>
				<string>/System/Library/Automator/Run Shell Script.action/Contents/Resources/Base.lproj/main.nib</string>
			</dict>
			<key>isViewVisible</key>
			<true/>
		</dict>
	</array>
	<key>connectors</key>
	<dict/>
	<key>workflowMetaData</key>
	<dict>
		<key>serviceApplicationBundleID</key>
		<string>com.apple.finder</string>
		<key>serviceApplicationPath</key>
		<string>/System/Library/CoreServices/Finder.app</string>
		<key>serviceInputTypeIdentifier</key>
		<string>com.apple.Automator.fileSystemObject</string>
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

echo "✅ Run Script Service installed successfully!"
echo ""
echo "📋 Features:"
echo "• Automatically detects Python (.py) and Bash (.sh, .bash) scripts"
echo "• Supports shebang detection (#!/usr/bin/env python, #!/bin/bash, etc.)"
echo "• Handles Node.js scripts (.js)"
echo "• Shows script output in dialog boxes"
echo "• Logs activity to ~/Library/Logs/run-script-service.log"
echo "• Works with executable files"
echo ""
echo "🚀 Usage:"
echo "1. Right-click any Python or Bash script in Finder"
echo "2. Select 'Run Script' from the context menu"
echo "3. The script will execute and show results"
echo ""
echo "📝 Note: You may need to restart Finder or log out/in for the service to appear."
echo "To restart Finder: killall Finder"