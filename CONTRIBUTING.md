# Contributing to macOS Copy Path Service

Thank you for your interest in contributing! This project aims to provide a simple, reliable path copying service for macOS users.

## 🚀 Getting Started

1. **Fork the repository**
2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/macos-copy-path-service.git
   cd macos-copy-path-service
   ```
3. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 🛠️ Development Guidelines

### Code Style
- **Shell scripts:** Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- **Documentation:** Use clear, concise language with examples
- **Comments:** Explain complex logic and important decisions

### Testing
- Test on multiple macOS versions when possible
- Verify service installation and uninstallation
- Test edge cases (special characters in paths, permissions, etc.)

### File Structure
```
macos-copy-path-service/
├── scripts/                 # Installation and utility scripts
├── docs/                    # Detailed documentation
├── assets/                  # Screenshots, demos, etc.
├── README.md               # Main project documentation
├── LICENSE                 # MIT License
├── CONTRIBUTING.md         # This file
├── CHANGELOG.md           # Version history
└── .gitignore             # Git ignore rules
```

## 📝 Making Changes

### For Bug Fixes
1. **Create an issue** describing the bug (if one doesn't exist)
2. **Reference the issue** in your commit message: `Fix: Handle special characters in paths (#issue-number)`
3. **Test thoroughly** on different macOS versions if possible

### For New Features
1. **Open an issue** to discuss the feature first
2. **Keep it simple** - this project values simplicity and reliability
3. **Update documentation** - README, docs/, and inline comments
4. **Consider compatibility** with older macOS versions

### For Documentation
- **Clear examples** - Show don't tell
- **Screenshots** welcome for visual changes
- **Test instructions** - Verify docs are accurate

## 🧪 Testing

### Manual Testing Checklist
- [ ] Service installs without errors
- [ ] "Copy Path" appears in Finder context menu
- [ ] Path copying works with files
- [ ] Path copying works with folders
- [ ] Path copying works with special characters
- [ ] Service uninstalls cleanly
- [ ] No error messages or notifications (unless intended)

### Test Environments
Try to test on:
- **macOS Monterey (12.x)** and newer
- **Intel and Apple Silicon Macs** if available
- **Different user permission levels**

## 📋 Pull Request Process

1. **Update documentation** if needed
2. **Test your changes** thoroughly
3. **Write clear commit messages:**
   ```
   Fix: Handle paths with spaces correctly
   
   - Escape special characters in AppleScript
   - Add test case for paths with spaces
   - Update documentation with edge cases
   ```

4. **Open a pull request** with:
   - Clear description of changes
   - Reference related issues
   - Screenshots/demos if applicable

## 🐛 Reporting Issues

### Bug Reports
Please include:
- **macOS version** (System Settings → General → About)
- **Error messages** (check Console.app if needed)
- **Steps to reproduce** the issue
- **Expected vs actual behavior**

### Feature Requests
- **Describe the use case** - why is this needed?
- **Keep scope small** - this project values simplicity
- **Consider alternatives** - could existing features work?

## 💡 Ideas for Contributions

### Easy First Contributions
- **Documentation improvements** - clearer instructions, more examples
- **Testing** - verify on different macOS versions
- **Bug reports** - find and report edge cases

### Medium Contributions
- **Installation improvements** - better error handling, validation
- **Uninstaller script** - clean removal option
- **Multiple path support** - handle multiple selected files

### Advanced Contributions
- **Preferences integration** - System Preferences pane
- **Alternative formats** - relative paths, escaped paths, etc.
- **Keyboard shortcuts** - alternative access methods

## 🤝 Community Guidelines

- **Be respectful** and constructive
- **Help others** learn and contribute
- **Keep discussions focused** on the project
- **Remember:** This is a simple tool - avoid feature creep

## 📞 Getting Help

- **Open an issue** for project-related questions
- **Check existing issues** first
- **Be patient** - this is maintained by volunteers

## 🏆 Recognition

Contributors will be:
- **Listed in README.md** (if they want to be)
- **Credited in release notes** for significant contributions
- **Given commit access** for regular, quality contributors

---

Thanks for making macOS Copy Path Service better for everyone! 🎉