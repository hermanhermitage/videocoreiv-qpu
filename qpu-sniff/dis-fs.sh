#!/bin/sh
( for f in fs/*.fs; do echo "Disassembling ${f}"; ./qpu-sniff --testgl vs/null.vs ${f} > ${f}.qdis; done )
