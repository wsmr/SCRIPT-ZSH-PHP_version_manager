# Contributing to PVM (PHP Version Manager)

First off, thank you for considering contributing to PVM! It's people like you that make PVM such a great tool.

## 🤝 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include your environment details:**
  - macOS version
  - Homebrew version (`brew --version`)
  - Shell (zsh/bash)
  - PHP versions installed

**Bug Report Template:**
```markdown
**Environment:**
- macOS: [e.g., 14.0 Sonoma]
- Homebrew: [e.g., 4.2.0]
- Shell: [e.g., zsh 5.9]
- PVM version: [commit hash or version]

**Steps to Reproduce:**
1. Run command `...`
2. See error `...`

**Expected Behavior:**
[What you expected to happen]

**Actual Behavior:**
[What actually happened]

**Additional Context:**
[Any other relevant information]
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any alternatives you've considered**

### Pull Requests

1. **Fork the repo** and create your branch from `main`
2. **Make your changes** with clear, descriptive commit messages
3. **Test thoroughly** on your macOS system
4. **Update documentation** if needed
5. **Submit a pull request**

## 🔧 Development Setup

1. Fork and clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/pvm-macos.git
cd pvm-macos
```

2. Create a test branch:
```bash
git checkout -b feature/my-new-feature
```

3. Test your changes:
```bash
# Source the modified function
source pvm.sh

# Test basic commands
pvm list
pvm current
pvm 8.3
```

## 📝 Coding Guidelines

### Shell Script Standards

- Use **4 spaces** for indentation (no tabs)
- Follow [ShellCheck](https://www.shellcheck.net/) recommendations
- Add comments for complex logic
- Use meaningful variable names
- Include error handling for edge cases

### Function Structure

```bash
function command_name() {
    # Validate input
    if [ -z "$1" ]; then
        echo "Error message"
        return 1
    fi
    
    # Main logic with error handling
    if some_command; then
        echo "Success message"
    else
        echo "Error message"
        return 1
    fi
}
```

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance tasks

**Examples:**
```
feat: add support for PHP 8.4
fix: resolve PATH conflict with system tools
docs: update installation instructions for M1 Macs
refactor: improve error handling in version switching
```

## 🧪 Testing Checklist

Before submitting a PR, test the following:

- [ ] `pvm list` - Lists all installed versions correctly
- [ ] `pvm current` - Shows accurate current version
- [ ] `pvm 8.3` - Switches to PHP 8.3 successfully
- [ ] `pvm system` - Reverts to system PHP correctly
- [ ] `pvm invalid` - Shows appropriate error message
- [ ] PATH preservation - Other tools (NVM, rbenv) still work
- [ ] Works in both zsh and bash
- [ ] Error messages are clear and helpful
- [ ] No breaking changes to existing functionality

## 📚 Documentation

When adding features, please update:

- **README.md** - Main documentation
- **pvm.sh** - Inline comments
- **.zshrc-example** - Usage examples if applicable

## 🎯 Areas We Need Help With

- **Testing on Intel Macs** (current focus is Apple Silicon)
- **Bash compatibility improvements**
- **Auto-version detection** (.php-version file support)
- **Performance optimizations**
- **Windows WSL support** (future consideration)
- **Integration with IDEs** (VS Code, PhpStorm)

## ❓ Questions?

Feel free to:
- Open an issue with the `question` label
- Start a discussion in GitHub Discussions
- Reach out to maintainers

## 📜 Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all.

### Our Standards

- Be respectful and inclusive
- Welcome constructive feedback
- Focus on what's best for the community
- Show empathy towards others

### Enforcement

Unacceptable behavior can be reported to the project maintainers. All complaints will be reviewed and investigated.

## 🎉 Recognition

Contributors will be recognized in:
- README.md acknowledgments section
- GitHub contributors page
- Release notes for significant contributions

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for making PVM better! 🚀
