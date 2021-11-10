xor $1, $1 
addi $1, 4 # &arr[0] = 4
xor $2, $2
addi $2, 5 # sizeof(arr) = 5
xor $3, $3 # i = 0
# fill a with series a + i*r
xor $4, $4 
addi $4, -3 # a = 3
xor $5, $5
addi $5, -10 # r = 2
xor $11, $11
addi $11, 2
for:
    xor $6, $6
    add $6, $3
    shll $6, 2 # i*4
    add $6, $1 # &arr[i]
    sw $4, 0($6) # arr[i] = a
    addi $3, 1 # i++
    add $4, $5 # a += r
    comp $6, $2
    add $6, $3 # i < sizeof(arr)
    bnz $6, for
endfor:
    # dividing all elements by 4 (stored in $11)
    xor $3, $3
    for2:
        xor $6, $6
        add $6, $3
        shll $6, 2 # i*4
        add $6, $1 # &arr[i]
        lw $4, 0($6) # arr[i]
        shllv $4, $11 # arr[i] * 2
        sw $4, 0($6) # arr[i] = arr[i] * 2
        addi $3, 1 # i++
        comp $6, $2
        add $6, $3 # i < sizeof(arr)
        bnz $6, for2
endfor2:
    xor $12, $12
    addi $12, 1
    bl LB0
    xor $12, $1 # (xor $12, 4)
    b LB0
    bz $6, LB0
LB0:
    br $31
