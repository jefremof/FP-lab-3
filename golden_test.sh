#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILENAME=$1

cat "test/$FILENAME" | dune exec fp_lab_3 -- -step=1.0 Linear Lagrange > "test/output/result_$FILENAME"

diff "test/golden_$FILENAME" "test/output/result_$FILENAME"