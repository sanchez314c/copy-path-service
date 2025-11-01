# Contributing Guide

Thank you for your interest in contributing to Copy Path Service! This guide will help you get started with contributing to the project.

## 🤝 How to Contribute

### Ways to Contribute

#### Code Contributions
- **Bug Fixes**: Fix reported issues and bugs
- **New Features**: Implement new functionality
- **Performance**: Optimize existing code
- **Documentation**: Improve code documentation

#### Non-Code Contributions
- **Documentation**: Improve user guides and docs
- **Testing**: Test on different macOS versions
- **Translations**: Help with internationalization
- **Community**: Help other users and answer questions
- **Design**: Improve user interface and experience

#### Reporting Issues
- **Bug Reports**: Report bugs and issues
- **Feature Requests**: Suggest new features
- **Security Issues**: Report security vulnerabilities
- **Documentation Issues**: Report documentation problems

## 🚀 Getting Started

### Prerequisites

#### System Requirements
- **macOS**: 10.15 (Catalina) or later
- **Xcode**: Latest version for development
- **Git**: For version control
- **Text Editor**: VS Code, Sublime Text, or similar

#### Development Tools
- **Terminal**: For command-line operations
- **Automator**: For workflow development
- **AppleScript Editor**: For script development
- **GitHub Account**: For contributing to repository

### Setup Development Environment

#### 1. Fork Repository
```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/macos-copy-path-service.git
cd macos-copy-path-service
```

#### 2. Add Upstream Remote
```bash
# Add original repository as upstream
git remote add upstream https://github.com/USERNAME/macos-copy-path-service.git
git fetch upstream
```

#### 3. Create Development Branch
```bash
# Create a new branch for your contribution
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

#### 4. Set Up Development Environment
```bash
# Install development dependencies
./scripts/setup_dev.sh

# Run tests to verify setup
./scripts/test.sh
```

## 📝 Development Workflow

### Code Style Guidelines

#### AppleScript Style
```applescript
-- Use descriptive variable names
set selectedFiles to selection as alias list
set pathList to {}

-- Use proper indentation (2 spaces)
repeat with currentFile in selectedFiles
    set end of pathList to POSIX path of currentFile
end repeat

-- Add comments for complex logic
-- Copy paths to clipboard
set the clipboard to (pathList as string)
```

#### Shell Script Style
```bash
#!/bin/bash

# Use descriptive variable names
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_NAME="Copy Path Service"

# Use functions for reusable code
log_message() {
    echo "[$SERVICE_NAME] $1"
}

# Use proper error handling
if [ ! -d "$SCRIPT_DIR" ]; then
    log_message "Error: Script directory not found"
    exit 1
fi

# Use quotes for variables
cp "$SOURCE_FILE" "$DEST_FILE"
```

#### Documentation Style
```markdown
# Use descriptive headers
## Installation

### Prerequisites
- **macOS**: 10.15 or later
- **Permissions**: Administrator access required

### Steps
1. **Download**: Get the installation script
2. **Execute**: Run with proper permissions
3. **Verify**: Check installation success

### Code Examples
```bash
# Use syntax highlighting
curl -fsSL https://example.com/install.sh | bash
```
```

### Testing Guidelines

#### Unit Testing
```bash
# Test individual functions
test_path_extraction() {
    local test_file="/path/to/test/file.txt"
    local expected_result="/path/to/test/file.txt"
    
    local actual_result=$(extract_path "$test_file")
    
    if [ "$actual_result" = "$expected_result" ]; then
        echo "✅ Path extraction test passed"
    else
        echo "❌ Path extraction test failed"
        return 1
    fi
}
```

#### Integration Testing
```bash
# Test complete workflows
test_copy_path_service() {
    # Create test file
    local test_file=$(mktemp)
    echo "test content" > "$test_file"
    
    # Test service installation
    ./scripts/install_copy_path_service.sh
    
    # Test service functionality
    # (This would require GUI testing)
    
    # Cleanup
    rm -f "$test_file"
}
```

#### Manual Testing Checklist
- [ ] Service appears in Finder context menu
- [ ] Service works with files and folders
- [ ] Service works with multiple selections
- [ ] Service handles special characters
- [ ] Service provides appropriate error messages
- [ ] Service works on different macOS versions

## 🐛 Bug Reports

### Reporting Bugs

#### Before Reporting
1. **Search Existing Issues**: Check if bug is already reported
2. **Check Latest Version**: Ensure you're using latest version
3. **Try Troubleshooting**: Follow [troubleshooting guide](TROUBLESHOOTING.md)
4. **Reproduce Issue**: Verify you can reproduce the bug

#### Bug Report Template
```markdown
## Bug Description
[Brief description of the bug]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Environment
- **macOS Version**: [e.g., macOS 14.0 Sonoma]
- **Copy Path Service Version**: [e.g., 2.0.0]
- **File Types**: [Types of files you're working with]
- **Hardware**: [e.g., M1 MacBook Pro]

## Additional Context
[Any other relevant information]
- Screenshots
- Console logs
- Error messages
```

### Security Issues
**For security issues**, email us privately:
- **Email**: security@example.com
- **PGP Key**: [PGP Key ID]
- **Response Time**: 24 hours

## 💡 Feature Requests

### Requesting Features

#### Before Requesting
1. **Check Roadmap**: Review [project roadmap](ROADMAP.md)
2. **Search Existing**: Look for similar requests
3. **Consider Use Case**: Think about who would benefit
4. **Check Feasibility**: Consider technical feasibility

#### Feature Request Template
```markdown
## Feature Title
[Brief, descriptive title]

## Problem Description
[What problem are you trying to solve?]

## Proposed Solution
[How do you propose to solve it?]

## Use Cases
[Who would benefit from this feature?]
[How would they use it?]

## Alternatives Considered
[What other approaches did you consider?]

## Additional Context
[Any other relevant information]
```

## 📚 Documentation Contributions

### Types of Documentation

#### User Documentation
- **Installation Guides**: Step-by-step installation instructions
- **User Guides**: How to use features
- **Troubleshooting**: Common issues and solutions
- **FAQ**: Frequently asked questions

#### Developer Documentation
- **API Reference**: Technical API documentation
- **Architecture**: System architecture documentation
- **Development Setup**: How to set up development environment
- **Contributing Guide**: This guide

### Documentation Style

#### Writing Guidelines
- **Clear and Concise**: Use simple, direct language
- **Active Voice**: Use active voice when possible
- **Consistent Formatting**: Follow established patterns
- **Examples**: Include code examples and screenshots

#### Structure Guidelines
```markdown
# Main Header (H1)

## Section Header (H2)

### Subsection Header (H3)

#### Sub-subsection (H4)

- **Bullet Points**: Use for lists
- **Code Blocks**: Use for code examples
- **Emphasis**: Use **bold** and *italic* for emphasis
```

## 🔄 Pull Request Process

### Creating Pull Requests

#### 1. Prepare Your Branch
```bash
# Ensure your branch is up to date
git fetch upstream
git rebase upstream/main

# Run tests
./scripts/test.sh

# Commit your changes
git add .
git commit -m "feat: add new feature description"
```

#### 2. Create Pull Request
1. **Push to GitHub**: `git push origin feature/your-feature-name`
2. **Create PR**: Click "New Pull Request" on GitHub
3. **Fill Template**: Complete the PR template
4. **Request Review**: Request review from maintainers

#### 3. Pull Request Template
```markdown
## Description
[Brief description of changes]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] Tested on multiple macOS versions

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] No breaking changes (or documented)
```

### Review Process

#### What We Look For
- **Functionality**: Does the code work as intended?
- **Code Quality**: Is the code well-written and maintainable?
- **Testing**: Are there adequate tests?
- **Documentation**: Is the documentation updated?
- **Performance**: Does it affect performance?

#### Review Timeline
- **Initial Review**: 2-3 business days
- **Additional Review**: 1-2 business days
- **Merge Decision**: Within 1 week of approval

## 🏗️ Project Structure

### Directory Organization
```
macos-copy-path-service/
├── docs/                    # Documentation
│   ├── README.md             # Main documentation
│   ├── USER_GUIDE.md         # User guide
│   ├── CONTRIBUTING.md        # Contributing guide
│   └── ...                  # Other documentation
├── scripts/                 # Installation and utility scripts
│   ├── install_copy_path_service.sh
│   ├── install_run_script_service.sh
│   └── ...                  # Other scripts
├── tests/                   # Test files
│   ├── unit/                # Unit tests
│   ├── integration/          # Integration tests
│   └── manual/              # Manual test cases
└── workflows/               # Workflow definitions
    ├── copy-path.workflow/    # Copy Path workflow
    └── run-script.workflow/  # Run Script workflow
```

### File Naming Conventions
- **Scripts**: `snake_case.sh` for shell scripts
- **Documentation**: `PascalCase.md` for documentation files
- **Tests**: `snake_case_test.sh` for test files
- **Workflows**: `kebab-case.workflow/` for workflows

## 🧪 Testing

### Test Types

#### Unit Tests
- **Function Testing**: Test individual functions
- **Error Handling**: Test error conditions
- **Edge Cases**: Test boundary conditions
- **Input Validation**: Test input validation

#### Integration Tests
- **Service Installation**: Test service installation process
- **Service Registration**: Test service registration
- **Finder Integration**: Test Finder context menu
- **Clipboard Operations**: Test clipboard functionality

#### Manual Tests
- **User Workflows**: Test common user workflows
- **macOS Versions**: Test on different macOS versions
- **File Types**: Test with different file types
- **Performance**: Test performance characteristics

### Running Tests

#### Automated Tests
```bash
# Run all tests
./scripts/test.sh

# Run specific test suite
./scripts/test.sh unit
./scripts/test.sh integration
./scripts/test.sh manual
```

#### Manual Testing
```bash
# Test installation
./scripts/install_copy_path_service.sh

# Verify in Finder
# 1. Right-click file
# 2. Check Services menu
# 3. Test functionality
```

## 📋 Development Guidelines

### Code Review Guidelines

#### Reviewer Responsibilities
- **Thorough Review**: Review all changes carefully
- **Constructive Feedback**: Provide helpful, specific feedback
- **Timely Response**: Respond within 2-3 business days
- **Mentorship**: Help contributors improve

#### Contributor Responsibilities
- **Self-Review**: Review your own code first
- **Test Thoroughly**: Test all changes
- **Document Changes**: Update documentation
- **Respond to Feedback**: Address review comments

### Release Process

#### Version Bumping
```bash
# Update version numbers
# 1. Update Info.plist files
# 2. Update documentation
# 3. Update CHANGELOG.md
# 4. Create release tag
git tag -a v2.1.0 -m "Release version 2.1.0"
git push origin v2.1.0
```

#### Release Checklist
- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version numbers updated
- [ ] Release notes prepared
- [ ] Security review completed

## 🌟 Recognition

### Contributor Recognition

#### Ways We Recognize Contributors
- **Contributors List**: Listed in README.md
- **Release Notes**: Mentioned in release notes
- **GitHub Stars**: Recognition for valuable contributions
- **Community Shoutouts**: Highlighted in community channels

#### Becoming a Maintainer
- **Active Contribution**: Regular, high-quality contributions
- **Community Leadership**: Help other contributors
- **Technical Expertise**: Deep understanding of codebase
- **Commitment**: Long-term commitment to project

## 📞 Getting Help

### Development Support

#### Getting Help
- **GitHub Discussions**: Ask development questions
- **Discord**: Real-time development chat
- **Email**: development@example.com
- **Office Hours**: Weekly development office hours

#### Resources
- **Documentation**: [Development Guide](development.md)
- **Architecture**: [Technical Architecture](ARCHITECTURE.md)
- **API Reference**: [API Documentation](API_REFERENCE.md)
- **Examples**: [Code Examples](examples/)

### Community Support

#### Helping Others
- **Answer Questions**: Help in GitHub Discussions
- **Review PRs**: Review pull requests from others
- **Mentor New Contributors**: Help new contributors get started
- **Share Knowledge**: Write tutorials and guides

---

**Thank you for contributing to Copy Path Service!** Your contributions help make this project better for everyone. 🎉