#!/bin/bash

if [ -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi

if [ -f $HOME/.bash.local ]; then
    echo Loading local env
    . $HOME/.bash.local
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    echo Loading brew bash completion
    . $(brew --prefix)/etc/bash_completion
fi

