; Write a program to display a t 0 x 10 solid box of asterisks.
; Hint: declare a string in the data segment that specifies the box,
; and display it with INT 2lh, function 9h.

; multi-segment executable file template.

data segment
    ; add your data here!
    row db "**********$"
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
    
    mov cx, 0d
    
    printRow:
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
        cmp cx, 10d
        jb printRow   
    
    
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
