#!/bin/sh

# workaround for sending control-h from terminal to neovim
# https://github.com/neovim/neovim/issues/2048#issuecomment-78045837

infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > /tmp/$TERM.ti && \
tic /tmp/$TERM.ti && \
rm /tmp/$TERM.ti
