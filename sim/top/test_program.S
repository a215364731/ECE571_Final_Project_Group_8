/* initialize registers */
/* https://riscvasm.lucasteske.dev/# */
addi x1, x0, 1
addi x2, x0, 2
addi x3, x0, 3
addi x4, x0, 4
addi x5, x0, 5
addi x6, x0, 6
addi x7, x0, 7
addi x8, x0, 8
addi x9, x0, 9
addi x10, x0, 10
addi x11, x0, 11
addi x12, x0, 12
addi x13, x0, 13
addi x14, x0, 14
addi x15, x0, 15
addi x16, x0, 16
addi x17, x0, 17
addi x18, x0, 18
addi x19, x0, 19
addi x20, x0, 20
addi x21, x0, 21
addi x22, x0, 22
addi x23, x0, 23
addi x24, x0, 24
addi x25, x0, 25
addi x26, x0, 26
addi x27, x0, 27
addi x28, x0, 28
addi x29, x0, 29
addi x30, x0, 30
addi x31, x0, 31

/* store all registers to dmem */
sw x0,  0(x0)
sw x1,  4(x0)
sw x2,  8(x0)
sw x3,  12(x0)
sw x4,  16(x0)
sw x5,  20(x0)
sw x6,  24(x0)
sw x7,  28(x0)
sw x8,  32(x0)
sw x9,  36(x0)
sw x10, 40(x0)
sw x11, 44(x0)
sw x12, 48(x0)
sw x13, 52(x0)
sw x14, 56(x0)
sw x15, 60(x0)
sw x16, 64(x0)
sw x17, 68(x0)
sw x18, 72(x0)
sw x19, 76(x0)
sw x20, 80(x0)
sw x21, 84(x0)
sw x22, 88(x0)
sw x23, 92(x0)
sw x24, 96(x0)
sw x25, 100(x0)
sw x26, 104(x0)
sw x27, 108(x0)
sw x28, 112(x0)
sw x29, 116(x0)
sw x30, 120(x0)
sw x31, 124(x0)

/* basic arithmatic */
add x16, x1, x2    /* x16 = 1 + 2 = 3  */
sub x17, x3, x1    /* x17 = 3 - 1 = 2  */
and x18, x4, x2    /* x18 = 4 & 2 = 0  */
or  x19, x5, x6    /* x19 = 5 | 6 = 7  */
xor x20, x3, x2    /* x20 = 3 ^ 2 = 1  */
sll x21, x1, x2    /* x21 = 1 << 2 = 4 */
srl x22, x4, x1    /* x22 = 4 >> 1 = 2 */

for_loop:
addi x1, x1, 1
blt x1, x31, for_loop

lw x0,  0(x0)
lw x1,  4(x0)
lw x2,  8(x0)
lw x3,  12(x0)
lw x4,  16(x0)
lw x5,  20(x0)
lw x6,  24(x0)
lw x7,  28(x0)
lw x8,  32(x0)
lw x9,  36(x0)
lw x10, 40(x0)
lw x11, 44(x0)
lw x12, 48(x0)
lw x13, 52(x0)
lw x14, 56(x0)
lw x15, 60(x0)
lw x16, 64(x0)
lw x17, 68(x0)
lw x18, 72(x0)
lw x19, 76(x0)
lw x20, 80(x0)
lw x21, 84(x0)
lw x22, 88(x0)
lw x23, 92(x0)
lw x24, 96(x0)
lw x25, 100(x0)
lw x26, 104(x0)
lw x27, 108(x0)
lw x28, 112(x0)
lw x29, 116(x0)
lw x30, 120(x0)
lw x31, 124(x0)