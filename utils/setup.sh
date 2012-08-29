#!/bin/bash

# delete existing files
DEFAULT_FILES=".vim .vimrc .bashrc .bash_aliases"

for file in $DEFAULT_FILES
do
    rm -rf ~/$file
done

# symlink
echo "- symlinking dotfiles"
ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
ln -s ~/.dotfiles/bash/bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc

# source bashrc
echo "- source bashrc"
source ~/.bashrc

# patch function
function patch_dotfiles() {
    echo " - cp patch to dir"
    cp $1 $2
    echo " - cd to dir"
    cd $2
    echo " - applying patch"
    patch --input=$1 $3
}

# this patch modifies the skwp powerline theme.
function patch_powerline() {
    patch="~/.dotfiles/utils/patches/powerline_skwp.patch"
    dir="~/.dotfiles/vim/bundle/powerline/autoload/Powerline/Colorschemes/"
    file="skwp.vim"

    echo "- patching powerline"
    patch_dotfiles $patch $dir $file
}
patch_powerline
