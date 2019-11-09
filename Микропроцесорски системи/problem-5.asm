; Write a program to (a) display"?", (b) read three initials,(<;) display
; them in the middle of an 11 x 11 box of asterix, and (d)
; beep the computer.

; multi-segment executable file template.

data segment
    ; add your data here!
    row db "***********$"
    chunk db "****$"
    symbol db "?$"
    tmp db ?
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
    mov ah,02h
    mov dl, symbol
    int 21h
    
    ; enter first letter from keyboard
    mov ah, 1
    int 21h
    
    mov bh, al
    
    ; enter second letter from keyboard
    mov ah, 1
    int 21h
    
    mov bl, al
    
    ; enter third letter from keyboard
    mov ah, 1
    int 21h
    
    mov tmp, al
    
    ; new line 
    mov ah, 02h
    mov dl, 0dh 
    int 21h
    mov dl, 0ah 
    int 21h
    
    ; set counter to 0
    mov cx, 0d 
   
    ; print the first half of the box  
    printRow1:
        ; print row
        lea dx, row
        mov ah, 9
        int 21h
        
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
        
        ; increase loop counter
        inc cx
        
        ; compare counter with 10
        cmp cx, 5d
        jb printRow1
        
    mov cx, 0d
    
    ; print first middle chunk
    lea dx, chunk
    mov ah, 9
    int 21h
    
    ; print first letter
    mov ah, 2
    mov dl, bh
    int 21h
    
    ; print second letter
    mov ah, 2
    mov dl, bl
    int 21h
    
    ; print third letter
    mov ah, 2
    mov dl, tmp
    int 21h
    
    ; print second middle chunk
    lea dx, chunk
    mov ah, 9
    int 21h
    
    ; new line 
    mov ah, 02h
    mov dl, 0dh 
    int 21h
    mov dl, 0ah 
    int 21h
    
    ; print the second half of the box  
    printRow2:
        ; print row
        lea dx, row
        mov ah, 9
        int 21h
        
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
        
        ; increase loop counter
        inc cx
        
        ; compare counter with 10
        cmp cx, 5d
        jb printRow2  

    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
