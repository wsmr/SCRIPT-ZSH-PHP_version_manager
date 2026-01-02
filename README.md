![GitHub Stars](https://img.shields.io/github/stars/wsmr/SCRIPT-ZSH-PHP_version_manager?style=social)
![GitHub Forks](https://img.shields.io/github/forks/wsmr/SCRIPT-ZSH-PHP_version_manager?style=social)
![GitHub Issues](https://img.shields.io/github/issues/wsmr/SCRIPT-ZSH-PHP_version_manager)
![GitHub Last Commit](https://img.shields.io/github/last-commit/wsmr/SCRIPT-ZSH-PHP_version_manager)

# PVM (PHP Version Manager) for macOS

A lightweight PHP version manager for macOS (Apple Silicon & Intel) that works seamlessly with Homebrew. Switch between multiple PHP versions instantly without conflicts.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![macOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
![Shell](https://img.shields.io/badge/shell-zsh%20%7C%20bash-green.svg)

## ✨ Features

- 🚀 **Fast switching** between PHP versions
- 🍺 **Homebrew-based** - uses official PHP formulae
- 🔄 **Clean PATH management** - preserves other tools (NVM, rbenv, etc.)
- 📋 **List installed versions** at a glance
- 🎯 **Simple commands** - intuitive interface
- 🔍 **Version detection** - shows currently active PHP version
- 🔙 **System PHP fallback** - revert to macOS default anytime

## 📋 Prerequisites

- macOS (10.15+)
- [Homebrew](https://brew.sh/) installed
- Zsh or Bash shell

## 🚀 Installation

### Step 1: Add Homebrew PHP Tap

```bash
brew tap shivammathur/php
```

### Step 2: Install PHP Versions

Install the PHP versions you need:

```bash
# Install PHP 8.3
brew install shivammathur/php/php@8.3

# Install PHP 8.2
brew install shivammathur/php/php@8.2

# Install PHP 8.1
brew install shivammathur/php/php@8.1

# Install PHP 7.4
brew install shivammathur/php/php@7.4
```

### Step 3: Install PVM Function

#### Option A: Automatic Installation (Recommended)

```bash
# Download and append to your shell config
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/pvm-macos/main/pvm.sh >> ~/.zshrc

# Reload your shell
source ~/.zshrc
```

#### Option B: Manual Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/pvm-macos.git
cd pvm-macos
```

2. Add to your shell configuration:
```bash
# For Zsh (default on macOS)
cat pvm.sh >> ~/.zshrc
source ~/.zshrc

# For Bash
cat pvm.sh >> ~/.bash_profile
source ~/.bash_profile
```

## 📖 Usage

### List Available PHP Versions

```bash
pvm list
# or
pvm ls
```

**Output:**
```
Available PHP versions (installed via Homebrew):
7.4
8.1
8.2
8.3
system (default macOS PHP)
```

### Check Current PHP Version

```bash
pvm current
```

**Output:**
```
Current PHP version: 8.3
```

### Switch PHP Version

```bash
# Switch to PHP 8.3
pvm 8.3

# Switch to PHP 8.1
pvm 8.1

# Switch to system PHP (macOS default)
pvm system
```

### Quick Reference

```bash
pvm <version>    # Switch to specific PHP version
pvm system       # Switch to macOS system PHP
pvm list         # List all installed PHP versions
pvm ls           # Alias for list
pvm current      # Show currently active version
```

## 💡 Examples

### Example Workflow

```bash
# Check what's available
$ pvm list
Available PHP versions (installed via Homebrew):
8.1
8.2
8.3
system (default macOS PHP)

# Switch to PHP 8.3 for a Laravel project
$ pvm 8.3
Switched to PHP 8.3.

# Verify the switch
$ php -v
PHP 8.3.14 (cli) (built: Dec  3 2024 16:57:44) (NTS)

$ pvm current
Current PHP version: 8.3

# Switch to PHP 7.4 for a legacy project
$ pvm 7.4
Switched to PHP 7.4.

# Go back to system PHP
$ pvm system
Switched to system PHP.
```

### Project-Specific Usage

```bash
# Create a project alias
alias myproject='cd ~/projects/myapp && pvm 8.2'

# Or add to project directory
echo "pvm 8.2" > ~/projects/myapp/.php-version
```

## 🔧 How It Works

PVM manages PHP versions by:

1. **Linking/Unlinking**: Uses `brew link` and `brew unlink` to manage symlinks
2. **PATH Management**: Intelligently updates PATH without breaking other tools
3. **Version Detection**: Reads from Homebrew's installation directory (`/opt/homebrew/opt/php@*`)

### File Locations

- **Homebrew PHP**: `/opt/homebrew/opt/php@X.Y/`
- **System PHP**: `/usr/bin/php`
- **Config File**: `~/.zshrc` or `~/.bash_profile`

## 🐛 Troubleshooting

### PHP command not found after switching

```bash
# Reload shell configuration
source ~/.zshrc

# Or manually update command hash
hash -r
```

### Version not detected

```bash
# Verify installation location
ls -la /opt/homebrew/opt/php@*

# Reinstall if needed
brew reinstall shivammathur/php/php@8.3
```

### Composer using wrong PHP version

```bash
# Composer will automatically use the active PHP
composer --version

# If issues persist, reinstall Composer
brew reinstall composer
```

### PATH conflicts with other tools

PVM preserves your existing PATH entries. If you experience issues:

```bash
# Check your PATH
echo $PATH

# Ensure PVM is loaded last in your .zshrc
# (move the pvm function to the end of the file)
```

## ⚠️ Important Notes

- **Homebrew Requirement**: PVM only manages PHP versions installed via Homebrew
- **Extensions**: PHP extensions are version-specific; install them per version
- **Composer**: Will use the currently active PHP version
- **Shell Support**: Primarily tested with Zsh (macOS default); bash support included

## 🔄 Updating PHP Versions

```bash
# Update Homebrew
brew update

# Upgrade specific PHP version
brew upgrade shivammathur/php/php@8.3

# Upgrade all PHP versions
brew upgrade shivammathur/php/php@*
```

## 🗑️ Uninstalling

### Remove PHP Versions

```bash
# Uninstall specific version
brew uninstall php@8.3

# Uninstall all Homebrew PHP versions
brew uninstall php@*
```

### Remove PVM Function

Edit `~/.zshrc` and delete the PVM function block (lines starting with `function pvm()`).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Homebrew](https://brew.sh/) - The missing package manager for macOS
- [shivammathur/homebrew-php](https://github.com/shivammathur/homebrew-php) - PHP builds for Homebrew
- Inspired by NVM, rbenv, and other version managers

## 📧 Support

If you encounter any issues or have questions:

- 🐛 [Report bugs](https://github.com/YOUR_USERNAME/pvm-macos/issues)
- 💬 [Start a discussion](https://github.com/YOUR_USERNAME/pvm-macos/discussions)
- ⭐ Star this repo if you find it helpful!

---

Made with ❤️ for the PHP community
