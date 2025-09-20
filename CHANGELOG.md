# Changelog

All notable changes to the macOS Copy Path Service project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Multiple file selection support
- Alternative path formats (relative, escaped)
- Keyboard shortcuts
- System Preferences integration

## [1.0.0] - 2025-01-15

### Added
- Initial release of Copy Path service
- One-click installation script
- Right-click context menu integration
- POSIX path copying to clipboard
- Clean operation (no notifications)
- Comprehensive documentation
- MIT License
- GitHub repository structure

### Features
- **Instant path copying** - Right-click → Copy Path → Done
- **Universal compatibility** - Works with files and folders
- **Zero overhead** - No background processes
- **Native integration** - Built with macOS Automator
- **Easy installation** - Single script setup
- **Clean uninstall** - Complete removal option

### Technical Details
- Built using macOS Automator Quick Actions
- AppleScript for clipboard integration
- Service installed to `~/Library/Services/`
- Compatible with macOS 10.6+
- File size: < 10KB
- Installation time: < 30 seconds

### Documentation
- Comprehensive README with installation guide
- Detailed troubleshooting documentation
- Contributing guidelines for open source collaboration
- MIT License for unrestricted use
- Changelog for version tracking

### Testing
- Verified on macOS Monterey through Sequoia
- Tested with files, folders, and special characters
- Installation and uninstallation verified
- Cross-platform compatibility confirmed

---

## Version History

### Pre-release Development
- **2025-01-15**: Project conception and initial development
- **2025-01-15**: First working prototype with notifications
- **2025-01-15**: Removed notifications for clean operation
- **2025-01-15**: Created installation script
- **2025-01-15**: Added comprehensive documentation
- **2025-01-15**: Structured for GitHub release

---

## How to Read This Changelog

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** in case of vulnerabilities

## Contributing to the Changelog

When contributing to this project, please:
1. Add your changes to the `[Unreleased]` section
2. Follow the format above
3. Include the date when the version is released
4. Move items from `[Unreleased]` to the new version section

## Links

- [GitHub Repository](https://github.com/USERNAME/macos-copy-path-service)
- [Issues](https://github.com/USERNAME/macos-copy-path-service/issues)
- [Releases](https://github.com/USERNAME/macos-copy-path-service/releases)