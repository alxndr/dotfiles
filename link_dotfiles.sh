#!/bin/bash

FILES=$(find . -name ".*" -not -name "*.sw*" -type f -depth 1)
cd ~
for FILE in $FILES; do
  ln -s workspace/dotfiles/$FILE
done
cd -
