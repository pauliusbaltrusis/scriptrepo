#!/usr/bin/env bash

find . -maxdepth 1 -name '*.txt*' -print | while read SRC_FILE; do #maxdepth = in the current dir only!
  DEST_FILE=$(echo $SRC_FILE | sed 's|\.\.|\.|') # replace two ".." with "." in file names!
  mv $SRC_FILE $DEST_FILE
done