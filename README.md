# macOS Copy Path Service

[![macOS](https://img.shields.io/badge/macOS-10.6+-blue.svg)](https://www.apple.com/macos)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0-orange.svg)](CHANGELOG.md)
[![Documentation](https://img.shields.io/badge/Documentation-Complete-brightgreen.svg)](docs/README.md)

A simple macOS service that adds a "Copy Path" option to the Finder context menu, eliminating the need to drag files to Terminal to get their paths.

## 🚀 Quick Demo

Right-click any file or folder → **Copy Path** → Paste anywhere!

```bash
# Instead of dragging files to Terminal, just:
# 1. Right-click file
# 2. Select "Copy Path" 
# 3. Paste: /Users/username/Documents/my-file.txt
```

## ✨ Features

- **🖱️ Right-click integration** - Works in all Finder windows
- **📋 Instant copying** - No notifications, just clean clipboard action
- **📁 Files & Folders** - Works with any file system item
- **⚡ Zero overhead** - No background processes
- **🔧 Easy install** - One-command installation
- **🍎 Native integration** - Uses macOS Automator framework

## 🛠️ Installation

### Quick Install (Recommended)

```bash
# Download and run the installer
curl -fsSL https://raw.githubusercontent.com/USERNAME/macos-copy-path-service/main/scripts/install_copy_path_service.sh | bash
```

### Manual Install

1. **Clone the repository:**
   ```bash
   git clone https://github.com/USERNAME/macos-copy-path-service.git
   cd macos-copy-path-service
   ```

2. **Run the installer:**
   ```bash
   chmod +x scripts/install_copy_path_service.sh
   ./scripts/install_copy_path_service.sh
   ```

3. **That's it!** The service is now available in Finder's context menu.

## 📖 Usage

1. **Right-click** any file or folder in Finder
2. Navigate to **Services** → **Copy Path**
3. **Paste** the path anywhere you need it

The copied path format: `/Users/username/path/to/file.ext`

## 🔧 Requirements

- **macOS 10.6 or later** (all modern versions supported)
- **Finder** (built into macOS)
- **Automator** (built into macOS)

## 📚 Documentation

### Getting Started
- **[📖 Documentation Hub](docs/README.md)** - Complete documentation overview
- **[⚡ Quick Start](docs/quick-start.md)** - Get up and running in 5 minutes
- **[🔧 Installation Guide](docs/installation.md)** - Detailed setup instructions

### User Guides
- **[📚 User Guide](docs/user-guide.md)** - Complete usage instructions and tips
- **[❓ FAQ](docs/faq.md)** - Frequently asked questions

### Development
- **[🛠️ Development Guide](docs/development.md)** - Contributing and development setup
- **[🏗️ Technical Architecture](docs/technical-architecture.md)** - System design and implementation
- **[🔒 Security](docs/security.md)** - Security considerations and best practices

### Reference
- **[🔍 Troubleshooting](docs/troubleshooting.md)** - Common issues and solutions
- **[🛠️ Tech Stack](docs/tech-stack.md)** - Technologies and dependencies
- **[🗺️ Roadmap](docs/roadmap.md)** - Future development plans
- **[📦 Releases](docs/releases.md)** - Release information and history
- **[🤝 Contributing](CONTRIBUTING.md)** - How to contribute to the project

## 🐛 Troubleshooting

**Don't see "Copy Path" in the menu?**
- Wait 30 seconds for Services to refresh
- Restart Finder: `killall Finder`
- Check System Preferences → Extensions → Finder Extensions

**Service appears but doesn't work?**
- See [detailed troubleshooting guide](docs/troubleshooting.md)

**Need help?**
- Check the [FAQ](docs/faq.md) for common questions
- [Report an issue](https://github.com/USERNAME/macos-copy-path-service/issues) on GitHub

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with macOS Automator
- Inspired by the daily friction of path copying in Terminal workflows
- Created for developers who value efficiency

## 📊 Stats

- **Installation time:** < 30 seconds
- **File size:** < 10KB
- **Performance impact:** Zero
- **Time saved per use:** ~10-15 seconds

---

**⭐ Star this repo if it saves you time!**

Made with ❤️ for the macOS developer community