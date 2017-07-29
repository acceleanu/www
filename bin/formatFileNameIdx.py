#!/usr/bin/python

import os, sys, re

path = "." if len(sys.argv)==1 else sys.argv[1]
dirs = os.listdir(path)

files=[f for f in dirs if f.endswith('.webm')]

def format(str):
    "pad number with zeroes in front"
    return "%02d" % int(str)

def replace(match):
    return "Episode %s" % format(match.group(1))

for file in files:
    oldf=file
    newf=re.sub(r'Episode (\d+)', replace, file)
    print oldf + " | " + newf
    os.rename(path+oldf, path+newf)

