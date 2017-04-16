#!/usr/bin/python

import sys
import re
import os

#print (os.path.dirname(os.path.abspath(__file__)))

f = open(os.path.dirname(os.path.abspath(__file__))+"/temp/out.txt", "r")
buff = f.read()
f.close()
regExp = re.compile(r"" + sys.argv[1] + "\s+Acronym:\s(.+)")
searchRes = regExp.search(buff)
if searchRes:
    print (searchRes.group(1))

