; Write a program to (a) prompt the user, (b) read first, middle, and
; last initials of a person's name, and (c) display them down the
; left margin.
; Sample execution:
; ENTER THRl::E INITIALS: JFK
; J
; F
; K

; multi-segment executable file template.

data segment
    ; add your data here!
    msg db "ENTER THREE INITIALS: $"
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
    
    ; output message on screen
    lea dx, msg
    mov ah, 09h
    int 21h 
    
    ; input first letter from keyboard
    mov ah, 01h
    int 21h
    
    mov bh, al
    
    ; input second letter from keyboard
    mov ah, 01h
    int 21h
    
    mov bl, al
    
    ; input third letter from keyboard
    mov ah, 01h
    int 21h 
    
    mov ch, al
    
    ; new line 
    mov ah, 02h
    mov dl, 0dh 
    int 21h
    mov dl, 0ah 
    int 21h
    
    ; display first letter on screen
    mov dl, bh 
    mov ah, 02h
    int 21h
    
    ; new line 
    mov ah, 02h
    mov dl, 0dh 
    int 21h
    mov dl, 0ah 
    int 21h
    
    ; display second letter on screen
    mov dl, bl
    mov ah, 02h
    int 21h
    
    ; new line 
    mov ah, 02h
    mov dl, 0dh 
    int 21h
    mov dl, 0ah 
    int 21h
    
    ; display third letter on screen
    mov dl, ch
    mov ah, 02h
    int 21h
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
