#!/bin/bash

# delete existing files
DEFAULT_FILES=".vim .vimrc .bashrc .bash_aliases"

for file in $DEFAULT_FILES
do
    rm -rf ~/$file
done

# symlink
ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
ln -s ~/.dotfiles/bash/bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc

source ~/.bashrc

# patches (hopefully this doesnt grow too much)
function patch_dotfiles() {
    cp $1 $2
    cd $2
    patch --input=$1 $3
}

# this patch modifies the skwp powerline theme.
function patch_powerline() {
    patch="~/.dotfiles/utils/patches/skwp_colorscheme.patch"
    dir="~/.dotfiles/vim/bundle/powerline/autoload/Powerline/Colorschemes"
    file="skwp.vim"

    patch_dotfiles $patch $dir $file
}
