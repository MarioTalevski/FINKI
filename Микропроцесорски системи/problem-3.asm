; Write· a program to read one of the hex digits A-F, and display it
; on the next line in decimal.
; Sample execution:
; Enter a hex digit: C
; In decimal it is: 12

; multi-segment executable file template.

data segment
    ; add your data here!
    msg1 db "Enter a hex digit: $"
    msg2 db "In decimal it is: $"
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
    
    ; display first message on screen
    lea dx, msg1
    mov ah, 9
    int 21h
    
    ; input hex digit from keyboard 
    mov ah, 1
    int 21h
    
    ; convert and save hex digit in bl
    mov bl, al
    sub bl, 17d
    
    ; new line 
    mov ah, 02h
    mov dl, 0dh 
    int 21h
    mov dl, 0ah 
    int 21h
    
    ; display second message on screen
    lea dx, msg2
    mov ah, 9
    int 21h
    
    ; print 1 on screen
    mov ah, 2
    mov dl, 1d
    add dl, 48
    int 21h
     
    ; display decimal digit on screen
    mov ah, 2
    mov dl, bl
    int 21h    
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
