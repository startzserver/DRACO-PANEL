#!/bin/bash

# Exit on any error
set -e

# Light blue ANSI color
LIGHT_BLUE='\033[1;34m'
NC='\033[0m' # No Color

# ========== INSTALL REQUIRED TOOLS ==========

# Install figlet if missing
if ! command -v figlet &> /dev/null; then
    echo "[+] Installing figlet..."
    sudo apt-get update && sudo apt-get install -y figlet
fi

# ========== SHOW BANNER ==========
echo -e "${LIGHT_BLUE}"
figlet STARTZ
echo -e "${NC}"

# ========== SETUP PROCESS ==========

echo "[+] Installing Node.js..."
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "[+] Cloning the panel repository..."
git clone https://github.com/draco-labes/panel-v1.0.0.git
cd panel-v1.0.0

echo "[+] Installing npm dependencies..."
npm install

echo "[+] Seeding database..."
npm run seed

echo "[+] Creating admin user..."
npm run createUser

echo "[+] Starting application..."
node .
