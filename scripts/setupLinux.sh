#!/bin/bash
############################################################
#
# Description:  Generic Linux Terminal Configuration Script
# Author:       James Solum
#
############################################################

# Setup Vimrc
ln -s ~/git/dotFiles/vimrc ~/.vimrc

# Setup Git Config 
ln -s ~/git/dotFiles/gitconfig  ~/.gitconfig

# Setup Tmux Config
ln -s ~/git/dotFiles/tmux.conf ~/.tmux.conf

# Setup Bashrc
ln -s ~/git/dotFiles/bashrc ~/.bashrc

# Setup System variables
ln -s ~/git/dotFiles/system_variables/personal_vars ~/.custom_system_vars

# Setup Generic Linux Profile
ln -s ~/git/dotFiles/custom_bash_configs/linux_generic_profile ~/.bash_profile

# Setup
ln -s ~/git/dotFiles/custom_bash_configs/personal_profile ~/.custom_bash_config