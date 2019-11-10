; Write a program that will prompt the user to enter a hex digit
; character ("0"· ... "9" or "A" ... "F"), display it on the next line
; in decimal, and ask the user i.i he or she wants to do it again. If
; the user types "y" or "Y", the ·program repeats; If the user types
; anything else, the program terminates. If the user enters an illegal
; character, prompt the user to try again.

; multi-segment executable file template.

data segment
    ; add your data here!
    msg1 db "Enter a hex digit: $"
    msg2 db "In decimal it is: $"
    msg3 db "Do you want to do it again? $"
    msg4 db "Illegal character enter 0-9 or A-F $"
    warning db "Exceeded number of tries. $"
    one db "1$"
    number db ?
    cnt db ?
    
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
    
    ; initial counter value
    mov cnt, 0d    
    
    repeat:
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
            
        ; display message 1        
        lea dx, msg1
        mov ah, 9
        int 21h
           
        ; enter hex digit
        mov ah, 1
        int 21h
        mov number, al
        
        ; check illegal input
        cmp number, 70d
        ja illegal
    
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h

        ; print message 2 on screen
        lea dx, msg2
        mov ah, 9
        int 21h
             
        cmp number, 64d
        ja above9
        jb under9
    
    above9:
        ; print 1 on screen as first digit
        lea dx, one
        mov ah, 9
        int 21h
        
        ; print second digit
        mov ah, 2
        sub number, 16d
        mov dl, number
        int 21h
        jmp tryAgain         
        
    under9:    
        ; print decimal digit    
        mov ah, 2
        mov dl, number
        int 21h
        jmp tryAgain
        
    illegal:
        inc cnt
        cmp cnt, 3d
        je terminate
         
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
    
        ;display message 4
        lea dx, msg4
        mov ah, 9
        int 21h
    
    tryAgain:        
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
    
        ; display message 3
        lea dx, msg3
        mov ah, 9
        int 21h
        
        ; enter "Y" or "y" if you want to repeat
        mov ah, 1
        int 21h
        
        cmp al, 79h
        je repeat
        cmp al, 59h
        je repeat
        cmp al, 78d
        je end
        cmp al, 110d
        je end
        
    terminate:
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
        
        ; display warning message
        lea dx, warning
        mov ah, 9
        int 21h
        jmp end
        
    end:
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
