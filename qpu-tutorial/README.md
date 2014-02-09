qpu-tutorial
============

**Preliminary**

Some sample QPU programs for getting started.

* [qpu-01.c](qpu-01.c) Almost empty program that signals completion.
* [qpu-02.c](qpu-02.c) VPM writes and transfer of VPM to memory (sdram).

Glossary:

* QPU - 16 way SIMD with add and multiply floating point units.
* VPM - Vertex and Primitive Memory.  A 8192 byte buffer for each QPU.  Typically vertices would be processed here.

