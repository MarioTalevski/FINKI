# -*- coding: utf-8 -*-
__operators = ('+','-', '/' , '//', '*', '**', '%')


def calculator():
    x=input()
    operator=input()
    y=input()
    
	# your code here
    rezultat = eval("x" + operator + "y")
    print rezultat
    return rezultat
    
if __name__ == "__main__":
    calculator()