# -*- coding: utf-8 -*-
import math

def createTable(start,end):
    table = {}
    for i in range(start,end+1):
        table[int(math.pow(i,3))] = i
    return table

if __name__ == "__main__":
    start = input()
    end = input()
    x = input()
    table = createTable(start,end)    
    if x not in table:
        print "nema podatoci"	
    else:
        print int(round(math.pow(x, 1/3.0)))
    print table