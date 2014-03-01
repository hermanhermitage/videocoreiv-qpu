# qpu-asm-test-negatives.s
# 
# This file is intented to be a set of negative tests for the assembler.
# It should fail on every line.
#
# Run:
#  nodejs qpuasm.js --ignore-errors qpu-test-asm.s
#

# Assembling junk
Junk line
;;

# Wrong number of slots
nop; nop; ldtmu0; nop

# Test incorrect number of arguments
nop r0
mov r0
mov r0, r1, r2
clz r0
clz r0, r1, r2
ftoi r0
ftoi r0, r1, r2
itof r0
itof r0, r1, r2

# sacq/srel errors
sacq -, 0 ; srel -, 0

# Test Expression failure
add r0, r1, unknown1+unknown2

# Label redefinition
#repeat:
#repeat:

