# Assembler for KGP-RISC

The assembler script (written in Python) is provided in the repository to turn the kgp-risc assembly language into machine code. An example assembly program is provided in the repository: [recursive_fibonacci.s](https://github.com/parthjindal/CS39001/blob/master/KGP-RISC/Test-Files/rec_fibo.s)

Use the following command to assemble the source code into machine code:
```
python3 asm_kgp.py -s <source_file> -o <output_file>
```

Note:
1. Label addressing is done using Pseudo-direct addressing and or immediate addressing based on the instruction. For example, the instruction `br <register>` has immediate addressing, whereas `b <label>` has pseudo-direct addressing. More information is given in the documentation of the processor.
