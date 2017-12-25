#!/usr/bin/env python3
import nlzss
import struct
from sys import stdout, argv
from binascii import crc32

data = open(argv[1], "rb").read()
outfile = open(argv[2], "wb")

# Savedata is 680 bytes long, with the CRC of [0->676] being the last 4 bytes.

crc = crc32(data[0:676]) & 0xFFFFFFFF
data = data[0:676] + struct.pack('I', crc) + data[680:] # append the rest (our payload :) )
nlzss.compress(data, outfile)
outfile.close()