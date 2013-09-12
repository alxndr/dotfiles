Nothin' to see here but some invisible files.

When you clone this, don't forget that you then need to

    cd dotfiles/ \
    && git submodule init \
    && git submodule update \
    && cd .vim/bundle/YouCompleteMe/ \
    && ./install.sh  --clang-completer \
    && cd -

