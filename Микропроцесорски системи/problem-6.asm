; Write a program to display a "?", read two capital letters, and display
; them on the next line In alphabetical order.  

; multi-segment executable file template.

data segment
    ; add your data here!
    symbol db "?$"
    firstChar db ?
    secondChar db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    
    ; display question mark on screen        
    lea dx, symbol
    mov ah, 9
    int 21h 
    
    ; enter first letter from keyboard
    mov ah, 1
    int 21h
    
    mov bh, al
    
    ; enter second letter from keyboard
    mov ah, 1
    int 21h 
    
    mov bl, al
    
    ; compare letters
    mov firstChar, bh
    mov secondChar, bl
    cmp bh, bl
    ja firstIsGreater
    jb secondIsGreater 

    firstIsGreater:
        mov firstChar, bl
        mov secondChar, bh
        jmp continue
        
    secondIsGreater:
        mov firstChar, bh
        mov secondChar, bl
        jmp continue
    
    continue:    
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
        
        ; print first character on screen
        mov ah, 2
        mov dl, firstChar
        int 21h
    
        ; print second character
        mov ah, 2
        mov dl, secondChar
        int 21h        
               
        ; wait for any key....    
        mov ah, 1
        int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
