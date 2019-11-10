; Write a program to display the extended ASCII characters (ASCJI
; codes 80h to FF_h). Display 10 characters per line, separated by
; blanks. Stop after the extended characters have been displayed once.

; multi-segment executable file template.

data segment
    ; add your data here!
    space db " $"
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
    
    ; set initial values 
    mov bl, 128d
    mov cx, 0d    
    
    loopCharacters:
        ; print character
        mov ah, 2
        mov dl, bl
        int 21h
            
        ; print empty space         
        lea dx, space
        mov ah, 9
        int 21h
        
        ; increase counters
        inc bl
        inc cx
        
        ; print a new line if counter reaches 10
        cmp cx, 10d
        ja newLine     
        
        ; repeat character loop until counter reaches 255
        cmp bl, 255d
        jb loopCharacters
        jmp end  
        
    newLine:
        ; reset counter
        mov cx, 0d
            
        ; new line 
        mov ah, 02h
        mov dl, 0dh 
        int 21h
        mov dl, 0ah 
        int 21h
        jmp loopCharacters
        
    end:   

    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
