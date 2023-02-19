#!/usr/bin/env python3
import os
import sys
import mmap

def hermit_verify_format(str_hex):
    try:
        ghex = int(str_hex, 16)
        return True, ghex
    except:
        return False, 0

def hermit_print_usage():
    print("Usage: hermit base_addr offset [write_value]")
    print("\nbase_addr:\tBase address of the device in hex format i.e: 0xAAAAAAAA.")
    print("offset:\t\tHex offset formatted.")
    print("write_value:\tHex value u32 int.")

def hermit_main(read, base_addr, offset, write_value):
    # try to open the /dev/mem file
    try:
        f = os.open('/dev/mem', os.O_RDRW | os.O_SYNC)
    except OSError as e:
        print('Check your permissions. Are you running this as root?\nError', e.strerror)
        sys.exit(-1)

    
    
if __name__ == "__main__":
    # check the inputs
    # Usage: hermit base_addr offset [write_value]
    args = sys.argv
    largs = len(args)
    read = True
    
    if largs < 3 or largs > 4:
        hermit_print_usage()
        sys.exit(-1)

    # verify
    bcheck, base_addr   = hermit_verify_format(args[1])
    ocheck, offset      = hermit_verify_format(args[2])
    if largs == 4:
        read = False
        wcheck, write_value = hermit_verify_format(args[3])

    hermit_main(read, base_addr, offset, write_value if largs == 4 else 0)
