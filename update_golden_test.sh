#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILENAME=$1

cat "test/$FILENAME" | opam exec -- dune exec fp_lab_3 -- -step=1.0 Linear Lagrange > "test/golden_$FILENAME"