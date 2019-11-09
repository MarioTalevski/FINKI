; Write a program to (a) display a "?", (b) read two decimal digits
; who.se sum "is less than 10, (c) display them and their sum on the
; next line, with an appropriate message.
; Sample execution:
; ?27
; THE SUM OF 2 AND 7 IS 9 

; multi-segment executable file template.

data segment
    ; add your data here!
    msg1 db "THE SUM OF $"
    msg2 db " AND $"
    msg3 db " IS $"
    symbol db "?$"
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
    
    ; input first digit from keyboard 
    mov ah, 01h
    int 21h 
    
    ; save first digit in bl 
    mov bl, al
    sub bl, 48d 
    
    ; input second digit from keyboard 
    mov ah, 01h
    int 21h
    
    ; save second digit in cl 
    mov cl, al
    sub cl, 48d
    
    ; new line 
    mov ah,2
    mov dl, 0dh 
    int 21h
    mov dl, 0ah 
    int 21h
    
    ; display first message on screen 
    lea dx, msg1
    mov ah, 09h
    int 21h    
    
    ; display first digit on screen
    mov dl, bl
    add dl, 48d
    mov ah, 02h
    int 21h
    
    ; display second message on screen
    lea dx, msg2
    mov ah, 09h
    int 21h
    
    ; display second digit on screen
    mov dl, cl
    add dl, 48d
    mov ah, 02h
    int 21h
     
    ; display third digit on screen
    lea dx, msg3
    mov ah, 09h
    int 21h
    
    ; display the sum of the digits on screen 
    mov dl, 0d 
    add dl, bl  
    add dl, cl
    add dl, 48d
    mov ah, 02h
    int 21h
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
