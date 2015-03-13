#!/bin/bash
# Ubuntu Developer Script For Initial-Ubuntu-Setup
# Created by Sourabh-Singh.
#   chrome
#   Apache An
#   Android
#   NPM
#   Apache Cordova
#   Ionic Framework

#chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable
#sublime
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text
#git
sudo apt-get update
sudo apt-get install git
#terminator
sudo apt-get update
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator
#zsh
sudo apt-get install zsh
#oh-my-zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
#variety
sudo add-apt-repository ppa:peterlevi/ppa
sudo apt-get update
sudo apt-get install variety
#pip
sudo apt-get install python-pip
#postgres
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
