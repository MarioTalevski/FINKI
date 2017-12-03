# -*- coding: utf-8 -*-
import math
  
def createTable(start,end):
    table = {}
    for i in range(start,end+1):
        tuple = (int(math.pow(i,2)),
                 int(math.pow(i,3)),
                 round(math.sqrt(i),16))
        table[i] = tuple
    return table

if __name__ == "__main__":
    start = input()
    end = input()
    x = input()
    table = createTable(start, end)
    if x < start or x > end:
        print "nema podatoci"
    else:
        print table[x]
    print table