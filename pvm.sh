#!/usr/bin/env bash
# PVM (PHP Version Manager) for macOS
# A lightweight PHP version manager that works with Homebrew
# GitHub: https://github.com/wsmr/macOS-ZSH-PHP_version_manager

# Installation: Add this function to your ~/.zshrc or ~/.bash_profile
# Usage: pvm <version> | pvm system | pvm list | pvm current

function pvm() {
    if [ -z "$1" ]; then
        echo "Usage: pvm <version> | pvm system | pvm list | pvm current"
        echo ""
        echo "Commands:"
        echo "  pvm <version>  Switch to specified PHP version (e.g., pvm 8.3)"
        echo "  pvm system     Switch to macOS system PHP"
        echo "  pvm list       List all installed PHP versions"
        echo "  pvm current    Show currently active PHP version"
        return 1
    fi
    
    case "$1" in
        "list" | "ls")
            echo "Available PHP versions (installed via Homebrew):"
            # Get directory names explicitly using a loop and basename
            for dir in /opt/homebrew/opt/php@*; do
                if [ -d "$dir" ]; then
                    basename "$dir" | sed -E 's/php@//'
                fi
            done 2>/dev/null | sort -V
            echo "system (default macOS PHP)"
            ;;
            
        "current")
            php_path=$(which php 2>/dev/null)
            if [ -z "$php_path" ]; then
                echo "No PHP installation found"
                return 1
            fi
            
            if [[ "$php_path" == *"/opt/homebrew/opt/php@"* ]]; then
                # Extract version from path like /opt/homebrew/opt/php@8.2/bin/php
                version=$(basename $(dirname $(dirname "$php_path")) | sed -E 's/php@//')
                echo "Current PHP version: $version"
            elif [[ "$php_path" == *"/usr/bin/php"* ]]; then
                echo "Current PHP version: system (macOS default)"
            else
                echo "Current PHP version: Unknown ($php_path)"
            fi
            ;;
            
        "system")
            echo "Switching to system PHP..."
            
            # Unlink any currently linked Homebrew PHP version
            for linked_php_dir in /opt/homebrew/opt/php@*; do
                if [ -d "$linked_php_dir" ]; then
                    linked_php_name=$(basename "$linked_php_dir")
                    if brew list --formula 2>/dev/null | grep -q "^$linked_php_name$"; then
                        brew unlink "$linked_php_name" 2>/dev/null
                    fi
                fi
            done
            
            # Remove Homebrew PHP paths from PATH while preserving other entries
            # This is safer than hardcoding the entire PATH
            new_path=$(echo "$PATH" | tr ':' '\n' | grep -v "/opt/homebrew/opt/php@" | tr '\n' ':' | sed 's/:$//')
            
            # Ensure system paths are at the beginning
            export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$new_path"
            
            # Update shell's command hash (works in both zsh and bash)
            if command -v rehash &> /dev/null; then
                rehash  # zsh
            else
                hash -r  # bash
            fi
            
            echo "✓ Switched to system PHP."
            php -v 2>/dev/null | head -n 1
            ;;
            
        *)
            version="$1"
            
            # Validate version format (basic check)
            if ! [[ "$version" =~ ^[0-9]+\.[0-9]+$ ]]; then
                echo "Error: Invalid version format. Use format like: 8.3 or 7.4"
                return 1
            fi
            
            # Check if the version is installed via Homebrew
            if [ ! -d "/opt/homebrew/opt/php@$version" ]; then
                echo "Error: PHP version $version is not installed via Homebrew."
                echo ""
                echo "Install it with:"
                echo "  brew install shivammathur/php/php@$version"
                return 1
            fi
            
            echo "Switching to PHP $version..."
            
            # Unlink any currently linked PHP version
            for linked_php_dir in /opt/homebrew/opt/php@*; do
                if [ -d "$linked_php_dir" ]; then
                    linked_php_name=$(basename "$linked_php_dir")
                    if brew list --formula 2>/dev/null | grep -q "^$linked_php_name$"; then
                        brew unlink "$linked_php_name" 2>/dev/null
                    fi
                fi
            done
            
            # Link the desired PHP version
            if brew link --force --overwrite "php@$version" 2>/dev/null; then
                # Update shell's command hash
                if command -v rehash &> /dev/null; then
                    rehash  # zsh
                else
                    hash -r  # bash
                fi
                
                echo "✓ Switched to PHP $version."
                php -v 2>/dev/null | head -n 1
            else
                echo "Error: Failed to link PHP $version. Try running:"
                echo "  brew link --force --overwrite php@$version"
                return 1
            fi
            ;;
    esac
}

# Auto-completion for zsh (optional)
if [ -n "$ZSH_VERSION" ]; then
    _pvm_completion() {
        local -a versions
        versions=("system" "list" "current")
        
        # Add installed PHP versions
        for dir in /opt/homebrew/opt/php@*; do
            if [ -d "$dir" ]; then
                version=$(basename "$dir" | sed -E 's/php@//')
                versions+=("$version")
            fi
        done
        
        _describe 'pvm commands and versions' versions
    }
    
    compdef _pvm_completion pvm
fi
