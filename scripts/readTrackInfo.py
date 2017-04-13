#!/usr/bin/python

import sys
import re
import os

#print (os.path.dirname(os.path.abspath(__file__)))

f = open(os.path.dirname(os.path.abspath(__file__))+"/temp/out.txt", "r")
buff = f.read()
f.close()
regExp = re.compile(r"Track Acronym:\s(.+)[\S\s]+" + sys.argv[1])
searchRes = regExp.search(buff)
if searchRes:
    print (searchRes.group(1))

