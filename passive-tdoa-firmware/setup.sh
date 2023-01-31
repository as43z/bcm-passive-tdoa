#!/usr/bin/env bash

# DEFINED
CURRENT=$(pwd)
COLOR_NC='\e[0m' # No Color
COLOR_BLACK='\e[0;30m'
COLOR_GRAY='\e[1;30m'
COLOR_RED='\e[0;31m'
COLOR_LIGHT_RED='\e[1;31m'
COLOR_GREEN='\e[0;32m'
COLOR_LIGHT_GREEN='\e[1;32m'
COLOR_BROWN='\e[0;33m'
COLOR_YELLOW='\e[1;33m'
COLOR_BLUE='\e[0;34m'
COLOR_LIGHT_BLUE='\e[1;34m'
COLOR_PURPLE='\e[0;35m'
COLOR_LIGHT_PURPLE='\e[1;35m'
COLOR_CYAN='\e[0;36m'
COLOR_LIGHT_CYAN='\e[1;36m'
COLOR_LIGHT_GRAY='\e[0;37m'
COLOR_WHITE='\e[1;37m'

# functions
function print_warn() {
    echo -e "$COLOR_YELLOW WARNING:$COLOR_NC$1"
}

function print_header() {
    echo -e "$COLOR_RED$1$COLOR_NC"
}

function print_finish() {
    echo -e "$COLOR_GREEN$1$COLOR_NC"
}

# script
print_warn "This firmware only works with old sources of the kernel. Be sure that the kernel version is <3.0.12 and that the sources.list file is actualised for EOL distributions. Thanks."
if [ "$EUID" -eq 0 ]
  then print_warn "Please do not run this script as root."
  exit
fi

print_header "Updating repositories"
sudo apt-get update
print_header "Installing packages"
xargs sudo apt-get install -y <package_requirements.txt
print_header "Downloading b43-tools sources"
if [[ ! -d $HOME/b43-tools ]]; then mkdir $HOME/b43-tools; fi; 
wget -O $HOME/b43-tools/b43-tools.tar.xz http://bues.ch/cgit/b43-tools.git/snapshot/b43-tools-b43-fwcutter-014.tar.xz --no-check-certificate
print_header "Unpacking b43-tools sources"
tar xvf $HOME/b43-tools/b43-tools.tar.xz
print_header "Making and installing b43-tools sources"
cd $HOME/b43-tools/b43-tools/b43-assembler
make && sudo make install
print_finish "Done!"
print_warn "Please review the output of this script and look if any errors occured during the setup process."

# Clean up
unset $COLOR_NC
unset $COLOR_BLACK
unset $COLOR_GRAY
unset $COLOR_RED
unset $COLOR_LIGHT_RED
unset $COLOR_GREEN
unset $COLOR_LIGHT_GREEN
unset $COLOR_BROWN
unset $COLOR_YELLOW
unset $COLOR_BLUE
unset $COLOR_LIGHT_BLUE
unset $COLOR_PURPLE
unset $COLOR_LIGHT_PURPLE
unset $COLOR_CYAN
unset $COLOR_LIGHT_CYAN
unset $COLOR_LIGHT_GRAY
unset $COLOR_WHITE
unset $CURRENT