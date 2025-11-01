# Technical Architecture

## System Overview

Copy Path Service is a macOS-native utility that provides file path copying and script execution capabilities through Finder context menu integration. The architecture leverages macOS system frameworks and follows Apple's design patterns for system services.

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    User Interface Layer                    │
│                 (Finder Context Menu)                      │
├─────────────────────────────────────────────────────────────┤
│                  macOS Services Framework                   │
│              (System Service Registration)                   │
├─────────────────────────────────────────────────────────────┤
│                 Automator Quick Actions                     │
│                (Service Execution Layer)                     │
├─────────────────────────────────────────────────────────────┤
│              AppleScript + Shell Scripts                   │
│                 (Implementation Layer)                      │
├─────────────────────────────────────────────────────────────┤
│                macOS System APIs                            │
│            (Finder, Clipboard, File System)                 │
└─────────────────────────────────────────────────────────────┘
```

## Core Components

### 1. Service Registration Layer

#### macOS Services Framework
- **Purpose**: System-wide service registration and discovery
- **Technology**: macOS Services Framework (NSServices)
- **Location**: System-level integration
- **Functionality**: 
  - Service registration with macOS
  - Context menu integration
  - File type filtering
  - Application-specific availability

#### Service Configuration
```xml
<!-- Info.plist Service Registration -->
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
    </dict>
</array>
```

### 2. Workflow Execution Layer

#### Automator Quick Actions
- **Purpose**: Service execution and workflow management
- **Technology**: macOS Automator Framework
- **Location**: `~/Library/Services/`
- **Components**:
  - Workflow definition files
  - Action sequences
  - Input/output handling
  - Error management

#### Workflow Structure
```
Service Name.workflow/
├── Contents/
│   ├── Info.plist           # Service registration
│   ├── document.wflow       # Workflow definition
│   └── Resources/           # Additional resources
│       ├── scripts/         # Shell scripts
│       └── icons/          # Service icons
```

### 3. Implementation Layer

#### AppleScript Integration
- **Purpose**: Finder interaction and file system access
- **Technology**: AppleScript (OSA)
- **Functionality**:
  - Finder selection handling
  - File path extraction
  - Clipboard operations
  - Error handling

**Copy Path AppleScript Example**:
```applescript
on run {input, parameters}
    try
        tell application "Finder"
            set selectedItems to selection as alias list
            set pathList to {}
            repeat with currentItem in selectedItems
                set end of pathList to POSIX path of currentItem
            end repeat
        end tell
        
        set the clipboard to (pathList as string)
        display notification "Path copied to clipboard"
        
    on error errMsg number errNum
        display dialog "Error: " & errMsg buttons {"OK"} default button "OK"
    end try
    
    return input
end run
```

#### Shell Script Integration
- **Purpose**: System-level operations and script execution
- **Technology**: Bash/Zsh shell scripts
- **Functionality**:
  - Script type detection
  - Process execution
  - Output handling
  - Error reporting

**Run Script Shell Example**:
```bash
#!/bin/bash

# Script execution for Run Script service
SCRIPT_PATH="$1"
SCRIPT_TYPE=$(file -b "$SCRIPT_PATH")

case "$SCRIPT_TYPE" in
    *"Python script"*)
        python3 "$SCRIPT_PATH"
        ;;
    *"Bourne-Again shell script"*)
        bash "$SCRIPT_PATH"
        ;;
    *"Node.js script"*)
        node "$SCRIPT_PATH"
        ;;
    *)
        echo "Unsupported script type: $SCRIPT_TYPE"
        exit 1
        ;;
esac
```

## Data Flow Architecture

### Copy Path Service Flow

```
User Action (Right-click) 
    ↓
Finder Context Menu
    ↓
Service Selection (Copy Path)
    ↓
Services Framework Activation
    ↓
Automator Workflow Execution
    ↓
AppleScript Execution
    ↓
Finder Selection Access
    ↓
Path Extraction (POSIX)
    ↓
Clipboard Operations
    ↓
User Notification
```

### Run Script Service Flow

```
User Action (Right-click)
    ↓
Finder Context Menu
    ↓
Service Selection (Run Script)
    ↓
Services Framework Activation
    ↓
Automator Workflow Execution
    ↓
Script Type Detection
    ↓
Shell Script Execution
    ↓
Process Management
    ↓
Output Capture
    ↓
Result Display
```

## Security Architecture

### Sandboxing Model

#### User Space Execution
- **No Privileged Operations**: All operations in user context
- **Standard Permissions**: Respects user file permissions
- **No System Access**: No system-level modifications
- **Isolated Execution**: Sandboxed service execution

#### File Access Security
```
File Access Control:
┌─────────────────────────────────────────┐
│           User Permissions             │
│  ┌─────────────────────────────────┐  │
│  │     Service Permissions         │  │
│  │  ┌─────────────────────────┐    │  │
│  │  │   File System Access    │    │  │
│  │  │   (User Files Only)    │    │  │
│  │  └─────────────────────────┘    │  │
│  └─────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

#### Script Execution Security
- **Type Validation**: Script type verification
- **Path Sanitization**: Input path validation
- **Resource Limits**: Execution resource constraints
- **Audit Logging**: Execution audit trail

## Performance Architecture

### Optimization Strategies

#### Lazy Loading
- **Service Registration**: On-demand service loading
- **Resource Allocation**: Dynamic resource management
- **Memory Management**: Efficient memory usage
- **Cleanup Operations**: Automatic resource cleanup

#### Caching Strategy
```
Cache Architecture:
┌─────────────────────────────────────────┐
│           L1 Cache (Memory)           │
│  • Recent file paths                  │
│  • Script type detection             │
│  • Service metadata                  │
├─────────────────────────────────────────┤
│           L2 Cache (Disk)             │
│  • Configuration settings            │
│  • User preferences                 │
│  • Service registration data         │
└─────────────────────────────────────────┘
```

#### Performance Metrics
- **Execution Time**: <200ms average service execution
- **Memory Usage**: <10MB peak memory usage
- **CPU Usage**: <5% CPU during execution
- **Startup Time**: <50ms service activation

## Integration Architecture

### System Integration

#### macOS Framework Dependencies
```
Framework Dependencies:
┌─────────────────────────────────────────┐
│           Application Services         │
│  • Services Framework               │
│  • Automator Framework             │
│  • AppleScript Object Architecture  │
├─────────────────────────────────────────┤
│           Core Services              │
│  • Foundation Framework             │
│  • Core Foundation                 │
│  • Core Services                  │
├─────────────────────────────────────────┤
│           System Services            │
│  • Finder Framework                │
│  • Clipboard Services              │
│  • File System APIs               │
└─────────────────────────────────────────┘
```

#### Application Integration
- **Finder**: Primary integration target
- **TextEdit**: Text editing integration
- **Terminal**: Command-line integration
- **Third-party Apps**: Generic file handling

### API Architecture

#### Public Interfaces
- **Service Registration**: macOS Services API
- **File Operations**: Standard file system APIs
- **Clipboard Operations**: NSPasteboard API
- **Notification System**: NSUserNotification API

#### Internal APIs
- **Path Extraction**: Custom path handling
- **Script Detection**: File type identification
- **Error Handling**: Centralized error management
- **Logging System**: Structured logging

## Deployment Architecture

### Installation System

#### Directory Structure
```
Installation Structure:
~/Library/Services/
├── Copy Path.workflow/
│   ├── Contents/
│   │   ├── Info.plist
│   │   ├── document.wflow
│   │   └── Resources/
│   └── (version-specific files)
├── Run Script.workflow/
│   ├── Contents/
│   │   ├── Info.plist
│   │   ├── document.wflow
│   │   └── Resources/
│   └── (version-specific files)
```

#### Installation Process
1. **Directory Creation**: Create service directories
2. **File Deployment**: Copy workflow files
3. **Registration**: Register with Services framework
4. **Verification**: Validate installation
5. **Cleanup**: Remove temporary files

### Update Architecture

#### Version Management
- **Semantic Versioning**: MAJOR.MINOR.PATCH format
- **Backward Compatibility**: Maintained within major versions
- **Migration Path**: Automatic settings migration
- **Rollback Support**: Version rollback capabilities

#### Update Process
1. **Version Check**: Compare installed vs. available
2. **Backup Creation**: Backup current installation
3. **File Update**: Update workflow files
4. **Settings Migration**: Migrate user preferences
5. **Verification**: Validate updated installation

## Testing Architecture

### Test Strategy

#### Unit Testing
- **AppleScript Testing**: Script validation and testing
- **Shell Script Testing**: Command-line script testing
- **Configuration Testing**: Plist and settings validation
- **Error Handling Testing**: Exception scenario testing

#### Integration Testing
- **Service Registration**: Service availability testing
- **Finder Integration**: Context menu testing
- **File Operations**: File handling testing
- **Clipboard Operations**: Clipboard functionality testing

#### System Testing
- **macOS Compatibility**: Version compatibility testing
- **Performance Testing**: Load and stress testing
- **Security Testing**: Security vulnerability testing
- **Usability Testing**: User experience testing

### Test Environment

#### Test Matrix
```
Test Environment Matrix:
┌─────────────────────────────────────────┐
│           macOS Versions              │
│  • macOS 10.15 (Catalina)         │
│  • macOS 11 (Big Sur)              │
│  • macOS 12 (Monterey)             │
│  • macOS 13 (Ventura)              │
│  • macOS 14 (Sonoma)               │
├─────────────────────────────────────────┤
│           File System Types          │
│  • Local File System               │
│  • Network File System             │
│  • External Storage                │
│  • Cloud Storage                   │
├─────────────────────────────────────────┤
│           File Types                │
│  • Regular Files                  │
│  • Directories                    │
│  • Symbolic Links                 │
│  • Special Files                  │
└─────────────────────────────────────────┘
```

## Monitoring and Observability

### Logging Architecture

#### Log Levels
- **DEBUG**: Detailed debugging information
- **INFO**: General information messages
- **WARN**: Warning messages for potential issues
- **ERROR**: Error messages for failures
- **FATAL**: Critical errors requiring attention

#### Log Destinations
```
Logging Architecture:
┌─────────────────────────────────────────┐
│           Console.app                 │
│  • System logs                      │
│  • Service logs                     │
│  • Error logs                       │
├─────────────────────────────────────────┤
│           Log Files                  │
│  • ~/Library/Logs/                  │
│  • Service-specific logs            │
│  • Rotation and cleanup             │
├─────────────────────────────────────────┤
│           Debug Output               │
│  • Development debugging            │
│  • Performance metrics             │
│  • Troubleshooting information     │
└─────────────────────────────────────────┘
```

### Performance Monitoring

#### Metrics Collection
- **Execution Time**: Service execution duration
- **Memory Usage**: Memory consumption patterns
- **Error Rates**: Frequency and types of errors
- **Usage Patterns**: Service usage statistics

#### Health Checks
- **Service Availability**: Service registration status
- **File System Access**: File system connectivity
- **Clipboard Access**: Clipboard functionality
- **Script Execution**: Script execution capability

## Future Architecture Evolution

### Planned Enhancements

#### Modern Architecture (v3.0)
- **Swift Implementation**: Migration from AppleScript to Swift
- **Modern Frameworks**: Adoption of modern macOS frameworks
- **Enhanced Performance**: Improved performance characteristics
- **Better Integration**: Enhanced system integration

#### Cross-Platform Support
- **iOS Support**: Extension to iOS platform
- **Web Interface**: Web-based configuration
- **Cloud Integration**: Cloud service integration
- **API Development**: RESTful API for third-party integration

### Scalability Considerations

#### Performance Scaling
- **Concurrent Execution**: Parallel service execution
- **Resource Management**: Dynamic resource allocation
- **Load Balancing**: Distribution of service load
- **Caching Strategy**: Advanced caching mechanisms

#### Feature Expansion
- **Plugin Architecture**: Extensible plugin system
- **Custom Workflows**: User-defined workflows
- **Integration APIs**: Third-party integration APIs
- **Advanced Scripting**: Enhanced scripting capabilities

---

**For implementation details, see the [Development Guide](development.md) and [API Reference](API_REFERENCE.md).**