#define ROP_POPPC 0x00100070
#define POP_R1PC 0x0019fcd4
#define POP_R3PC 0x00114efc
#define POP_R2R6PC 0x001f9384
#define POP_R4LR_BXR1 0x00153008
#define POP_R4R8LR_BXR2 0x0014944c
#define POP_R4R5R6PC 0x001001a0
#define POP_R4FPPC 0x00100b48
#define POP_R4R8PC 0x001008d8

#define ROP_STR_R1TOR0 0x001005fc
#define ROP_STR_R0TOR1 0x001115f8
#define ROP_LDR_R0FROMR0 0x00172e30
#define ROP_ADDR0_TO_R1 0x00117734

#define MEMCPY 0x001a0f9c
#define MEMSET32_OTHER 0x001a0130

#define svcControlMemory 0x00172c44
#define svcSleepThread 0x001d9294

#define GSPGPU_FlushDataCache 0x001f47dc
#define GSPGPU_SERVHANDLEADR 0x00221ebc

#define IFile_Read 0x0019e0b8
#define IFile_Write 0x001971a8

#define ROP_POPR3_ADDSPR3_POPPC 0x00100068
#define POP_R0PC 0x001004dc
#define ROP_CMPR0R1_ALT0 0x00126dec
#define ROP_INITOBJARRAY 0x001969ec
#define svcCreateThread 0x001d9270
#define svcConnectToPort 0x001ebd20
#define svcGetProcessId 0x00182f78
#define THROWFATALERR_IPC 0x001ec824
#define SRV_GETSERVICEHANDLE 0x00195490
//WARNING: CFGIPC_SecureInfoGetRegion not found.
#define ROP_COND_THROWFATALERR_ALT0 0x00115774
#define GXLOW_CMD4 0x001fa2f0
#define GSP_SHAREDMEM_SETUPFRAMEBUF 0x001fa0ec
#define FS_MountSdmc 0x00117228
#define IFile_Open 0x0019e228
#define IFile_Close 0x19e098
//WARNING: IFile_Seek not found.