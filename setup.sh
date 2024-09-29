#!/bin/bash

# Banner and center functions
center_banner() {
    local termwidth=$(stty size | cut -d" " -f2)

    local banner=(
        "+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+"
        "|M|e|t|a|s|p|l|o|i|t| |i|n| |G|i|t|p|o|d|"
        "+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+"
        "+-+-+ +-+-+-+-+-+-+-+-+-+-+"
        "|b|y| |G|u|s|h|m|a|z|u|k|o|"
        "+-+-+ +-+-+-+-+-+-+-+-+-+-+"
    )

    echo -e "\e[34m" # Blue color
    for line in "${banner[@]}"; do
        printf "%*s\n" $(( (termwidth + ${#line}) / 2 )) "$line"
    done
    echo -e "\e[0m" # Reset color
}

center() {
  termwidth=$(stty size | cut -d" " -f2)
  padding="$(printf '%0.1s' ={1..500})"
  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

clear
center_banner

# Dependencies Installation
center "* Dependencies installation..."
apt update -y
apt upgrade -y
apt install -y git curl ruby ruby-dev build-essential libpq-dev libreadline-dev libssl-dev libsqlite3-dev

# Erase Old Metasploit Folder
center "* Erasing old metasploit folder..."
if [ -d "/opt/metasploit-framework" ]; then
  rm -rf /opt/metasploit-framework
fi

# Download Metasploit
center "* Downloading..."
git clone https://github.com/rapid7/metasploit-framework.git --depth=1 /opt/metasploit-framework

# Install Metasploit
center "* Installation..."
cd /opt/metasploit-framework
gem install bundler
bundle install

# Link Metasploit Executables
ln -sf /opt/metasploit-framework/msfconsole /usr/local/bin/
ln -sf /opt/metasploit-framework/msfvenom /usr/local/bin/
ln -sf /opt/metasploit-framework/msfrpcd /usr/local/bin/

echo -e "\033[32m" # Green color
center "Installation complete"
echo -e "\nStart Metasploit using the command: msfconsole"
echo -e "\033[0m" # Reset color
