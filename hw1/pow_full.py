#! /usr/bin/env python
import sys


def powI(power,base):
    ret = 1
    for i in range(power):
        ret *= base
    return ret

def powF(power,base):
    if power != 1:
        return base * powF(power-1,base)
    return base

if len(sys.argv) != 3:
    print("%s usage: [POWER] [BASE]"% sys.argv[0])

print("powI: ",powI(int(sys.argv[2]),int(sys.argv[1])))
print("powF: ",powF(int(sys.argv[2]),int(sys.argv[1])))
