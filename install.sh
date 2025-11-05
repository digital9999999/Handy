#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Node.js and npm
if ! command -v node &> /dev/null; then
    echo "Installing Node.js..."
    brew install node
fi

# Install Bun
if ! command -v bun &> /dev/null; then
    echo "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
    # Add Bun to PATH permanently
    echo 'export BUN_INSTALL="$HOME/.bun"' >> ~/.zshrc
    echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
fi

# Install Rust and Cargo
if ! command -v cargo &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

# Install Tauri prerequisites
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
fi

# Navigate to project directory
cd "$(dirname "$0")"

# Install project dependencies
bun install

# Build the project
bun run build

# Run the project
bun run tauri dev
