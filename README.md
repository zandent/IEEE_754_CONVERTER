# IEEE_754_CONVERTER
## Objectives
The main purpose of the project is to convert and process customized floating point representation using given interger part and fraction part, such as add, substarct and multiply in hardware implementation.
## Details
### ----Basics
Following IEEE 754 repesentation (https://en.wikipedia.org/wiki/IEEE_754), similarly, sign part, exponent part and fraction part are the components for output. The sample file for IEEE 754 is "ieee_754_converter.v and ieee_mul.v"
### ----Advanced
Now the bit width for fraction part is customized so that the precision is adjusted by users. Moreover, the processing of adding, substarcting and multiplying is supported for customized representation.
## Addition
Supported by Intelligent Sensory Microsystems Laboratory, Department of Electrical and Computer Engineering, University of Toronto, the application for the represeation is square root function for interger inputin hardware implementaiton, which is named "op_amp.v" with other helper modules. Theoretically, it supports input from 1 to 2^128 in decimal. It is testing currently.
