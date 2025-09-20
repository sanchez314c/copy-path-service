# Project Information

## 📁 Repository Structure

```
macos-copy-path-service/
├── README.md                           # Main project documentation
├── LICENSE                            # MIT License
├── CHANGELOG.md                       # Version history
├── CONTRIBUTING.md                    # Contribution guidelines
├── .gitignore                        # Git ignore rules
├── PROJECT_INFO.md                   # This file
│
├── scripts/                          # Installation and utility scripts
│   ├── install_copy_path_service.sh   # Main installer script
│   └── uninstall_copy_path_service.sh # Uninstaller script
│
├── docs/                             # Detailed documentation
│   ├── Copy_Path_Service_README.md    # Detailed usage guide
│   └── TROUBLESHOOTING.md             # Common issues and solutions
│
└── assets/                           # Screenshots, demos, media
    └── (future: demo.gif, screenshots, etc.)
```

## 🚀 Quick Start

### For Users
```bash
# Install the service
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/install_copy_path_service.sh | bash

# Or download and run locally
git clone https://github.com/USERNAME/macos-copy-path-service.git
cd macos-copy-path-service
chmod +x scripts/install_copy_path_service.sh
./scripts/install_copy_path_service.sh
```

### For Contributors
```bash
# Fork the repo, then:
git clone https://github.com/YOUR-USERNAME/macos-copy-path-service.git
cd macos-copy-path-service

# Make changes and test
./scripts/install_copy_path_service.sh  # Test installation
# ... test functionality ...
./scripts/uninstall_copy_path_service.sh  # Test removal

# Submit pull request
```

## 🎯 Project Goals

### Primary Goals
- **Simplicity** - One-click path copying
- **Reliability** - Works consistently across macOS versions  
- **Zero overhead** - No background processes
- **Easy installation** - Single script setup

### Non-Goals
- Complex path manipulation
- GUI applications or preference panes
- Multiple clipboard formats
- Integration with specific applications

## 🛠️ Technical Architecture

### Components
1. **Automator Quick Action** - macOS native service framework
2. **AppleScript** - Handles clipboard integration
3. **Shell Scripts** - Installation and maintenance tools
4. **Documentation** - Comprehensive user and developer guides

### File Locations
- **Service:** `~/Library/Services/Copy Path.workflow/`
- **Scripts:** Local repository only
- **Configuration:** None (zero-config design)

### Dependencies
- **macOS 10.6+** (all modern versions)
- **Finder** (built-in)
- **Automator** (built-in)
- **AppleScript** (built-in)

## 📈 Development Roadmap

### Version 1.0 (Current)
- [x] Basic path copying functionality
- [x] Installation script
- [x] Uninstallation script  
- [x] Comprehensive documentation
- [x] GitHub repository structure

### Future Versions
- [ ] Multiple file selection support
- [ ] Alternative path formats (relative, escaped)
- [ ] Keyboard shortcuts
- [ ] Optional notification preferences
- [ ] System Preferences integration

## 🧪 Testing Strategy

### Manual Testing
- Installation on fresh macOS systems
- Path copying with various file types
- Special characters and edge cases
- Service removal and cleanup

### Automated Testing
- [ ] Shell script linting (shellcheck)
- [ ] Documentation link checking
- [ ] Installation script CI/CD testing

### Compatibility Testing
- macOS Monterey (12.x)
- macOS Ventura (13.x)  
- macOS Sonoma (14.x)
- macOS Sequoia (15.x)

## 📊 Project Metrics

### Size & Performance
- **Repository size:** ~50KB
- **Installation time:** <30 seconds
- **Service file size:** <10KB
- **Memory usage:** 0 (no background processes)

### Documentation
- **README.md:** Comprehensive overview
- **Installation guide:** Step-by-step instructions
- **Troubleshooting:** Common issues covered
- **Contributing:** Developer guidelines
- **Changelog:** Version tracking

## 🏷️ Repository Tags & Releases

### Semantic Versioning
- **MAJOR.MINOR.PATCH** (e.g., 1.0.0)
- **Major:** Breaking changes
- **Minor:** New features (backwards compatible)
- **Patch:** Bug fixes

### Release Strategy
- **Stable releases:** Tagged versions on main branch
- **Pre-releases:** Beta testing with community
- **Hotfixes:** Critical bug fixes

## 📞 Support & Community

### Getting Help
- **GitHub Issues:** Bug reports and feature requests
- **GitHub Discussions:** Questions and community support
- **Documentation:** Comprehensive guides and troubleshooting

### Contributing
- **Code contributions:** Following contribution guidelines
- **Documentation:** Improvements and translations
- **Testing:** Cross-platform verification
- **Issue reporting:** Detailed bug reports

---

**Project Status:** ✅ Active Development  
**License:** MIT  
**Maintainers:** Community-driven  
**Last Updated:** 2025-01-15