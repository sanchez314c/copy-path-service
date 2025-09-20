#!/bin/bash
# Copy Path Service Installer for macOS
# Adds "Copy Path" to right-click context menu in Finder

echo "🔧 Installing Copy Path Service..."

# Create Services directory if it doesn't exist
SERVICES_DIR="$HOME/Library/Services"
WORKFLOW_DIR="$SERVICES_DIR/Copy Path.workflow"
CONTENTS_DIR="$WORKFLOW_DIR/Contents"

mkdir -p "$CONTENTS_DIR"

# Create Info.plist
cat > "$CONTENTS_DIR/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleIdentifier</key>
	<string>com.apple.Automator.Copy Path</string>
	<key>CFBundleName</key>
	<string>Copy Path</string>
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
			<key>NSReturnTypes</key>
			<array/>
		</dict>
	</array>
</dict>
</plist>
EOF

# Create document.wflow (without notifications)
cat > "$CONTENTS_DIR/document.wflow" << 'EOF'
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
						<string>com.apple.cocoa.attributed-string</string>
					</array>
				</dict>
				<key>AMActionVersion</key>
				<string>2.1.1</string>
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
						<string>com.apple.cocoa.attributed-string</string>
					</array>
				</dict>
				<key>ActionBundlePath</key>
				<string>/System/Library/Automator/Run AppleScript.action</string>
				<key>ActionName</key>
				<string>Run AppleScript</string>
				<key>ActionParameters</key>
				<dict>
					<key>source</key>
					<string>on run {input, parameters}
	set the clipboard to POSIX path of (item 1 of input)
	return input
end run</string>
				</dict>
				<key>BundleIdentifier</key>
				<string>com.apple.Automator.RunScript</string>
				<key>CFBundleVersion</key>
				<string>2.1.1</string>
				<key>CanShowSelectedItemsWhenRun</key>
				<false/>
				<key>CanShowWhenRun</key>
				<true/>
				<key>Category</key>
				<array>
					<string>AMCategoryUtilities</string>
				</array>
				<key>Class Name</key>
				<string>RunScriptAction</string>
				<key>InputUUID</key>
				<string>A85A729B-4E23-4B96-B7E0-5B5C85B5F8A2</string>
				<key>Keywords</key>
				<array>
					<string>Run</string>
				</array>
				<key>OutputUUID</key>
				<string>FA9A5FB8-8C3D-4A5A-9A2E-D2F3F92B4C6E</string>
				<key>UUID</key>
				<string>D7A84B2C-5E9F-4C1A-8A3D-F2E4B6C8A1D5</string>
				<key>UnlocalizedApplications</key>
				<array>
					<string>Automator</string>
				</array>
				<key>arguments</key>
				<dict>
					<key>0</key>
					<dict>
						<key>default value</key>
						<string>on run {input, parameters}
	
	(* Your script goes here *)
	
	return input
end run</string>
						<key>name</key>
						<string>source</string>
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
				<string>/System/Library/Automator/Run AppleScript.action/Contents/Resources/Base.lproj/main.nib</string>
			</dict>
			<key>isViewVisible</key>
			<true/>
		</dict>
	</array>
	<key>connectors</key>
	<dict/>
	<key>workflowMetaData</key>
	<dict>
		<key>applicationBundleID</key>
		<string>com.apple.finder</string>
		<key>applicationBundleIDsByPath</key>
		<dict/>
		<key>applicationPath</key>
		<string>/System/Library/CoreServices/Finder.app</string>
		<key>applicationPaths</key>
		<array>
			<string>/System/Library/CoreServices/Finder.app</string>
		</array>
		<key>inputTypeIdentifier</key>
		<string>com.apple.Automator.fileSystemObject</string>
		<key>outputTypeIdentifier</key>
		<string>com.apple.Automator.nothing</string>
		<key>presentationMode</key>
		<integer>15</integer>
		<key>processesInput</key>
		<integer>0</integer>
		<key>serviceInputTypeIdentifier</key>
		<string>com.apple.Automator.fileSystemObject</string>
		<key>serviceOutputTypeIdentifier</key>
		<string>com.apple.Automator.nothing</string>
		<key>serviceApplicationBundleID</key>
		<string>com.apple.finder</string>
		<key>workflowTypeIdentifier</key>
		<string>com.apple.Automator.servicesMenu</string>
	</dict>
</dict>
</plist>
EOF

echo "✅ Copy Path service installed successfully!"
echo "📋 The service copies file paths to clipboard without notifications"
echo ""
echo "🔄 Refreshing Services menu..."

# Refresh Services menu
/System/Library/CoreServices/pbs -flush 2>/dev/null
killall Finder 2>/dev/null

echo "✨ Installation complete!"
echo ""
echo "Usage:"
echo "  1. Right-click any file or folder in Finder"
echo "  2. Select 'Copy Path' from the context menu"
echo "  3. Paste the path anywhere you need it"
echo ""
echo "Note: If you don't see 'Copy Path' immediately, wait 30 seconds or restart Finder."