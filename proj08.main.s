    .global main
    .text
    
main:   push {lr}

        mov r4, #0      @ Initialize character count
        mov r5, #0      @ Initialize decimal count
        mov r6, #0      @ Initialize whitespace count
        mov r3, #0      @ Initialize newline count
        mov r7, #0      @ Initialize octal count
        mov r8, #0      @ Initialize hex count
        mov r2, #0      @ Initialize letter count
        
loop:   bl getchar      @ Read one character (returned in r0)

        cmp r0, #-1     @ Compare return value to EOF
        beq end         @ When EOF found, exit loop
        
        add r4, r4, #1  @ Increment character count

//DECIMAL & OCTAL & 1/3 HEX
if1:
        cmp r0, #’0’    @ Compare character to ’0’
        blt endif1
        cmp r0, #’9’    @ Compare character to ’9’
        bgt endif1      
then1:
        add r5, r5, #1  @ Increment decimal count
        add r8, r8, #1  @ Increment hex count
        //octal test 
        cmp r0, #'7'    @ Compare character to '7'
        bgt endif1
        
thenOct:
        add r7, r7, #1  @ Increment octal count
endif1:

//BLANKS
if2:
        cmp r0, #0x20   @ Compare return value to blank
        bne endif2  
then2:
        add r6, r6, #1  @ Increment whitespace count
endif2:

//NEWLINE
if3:
        cmp r0, #0x0a   @ Compare return value to newline
        bne endif3
then3:
        add r3, r3, #1  @ Increment newline count
        add r6, r6, #1  @ Increment whitespace count
endif3:

// CAP LETTER TEST & 2/3 HEX
if4:
        cmp r0, 0x41    @ Compare character with "A"
        blt endif4                 
        cmp r0, 0x5A    @ Compare character with "Z" 
        bgt endif4
                        
then4: 
        add r2, r2, #1  @ Increment letter count           
        cmp r0, 0x46    @ Compare character with "F"
        bgt endif4:
        
thenHex:
        add r8, r8, #1  @ Increment Hex count
endif4:

// LOW LETTER TEST & 3/3 HEX
if5:
        cmp r0, 0x61               @ Compare r0 with "a"
        blt endif5                 
        cmp r0, 0x7A               @ compare r0 with "z"
        bgt endif5  
        
then5:
        add r2, r2, #1  @ Increment letter count           
        cmp r0, 0x66    @ Compare character with "f"
        bgt endif5:
        
thenHex2:

        add r8, r8, #1  @ Increment Hex count
        
endif5:

//TABS
if6:
        cmp r0, #0x9   @ Compare return value to tab
        bne endif6  
then6:
        add r6, r6, #1  @ Increment whitespace count
endif6:

        bl putchar       @ CODE TO DISPLAY CHARACTER HERE
        b loop          @ Jump to top of loop
        
end:    
        //CODE TO OUTPUT COUNTS HERE
        ldr r0, =fmt1    @ First arg -- address of format string
        mov r1, r4      @ Second arg -- character count        
        bl printf       @ Print the number of characters
        
        ldr r0, =fmt2    @ First arg -- address of format string
        mov r1, r3      @ Second arg -- character count        
        bl printf       @ Print the number of characters
        
        ldr r0, =fmt3    @ First arg -- address of format string
        mov r1, r6      @ Second arg -- character count        
        bl printf       @ Print the number of characters
        
        ldr r0, =fmt4    @ First arg -- address of format string
        mov r1, r7      @ Second arg -- character count        
        bl printf       @ Print the number of characters
        
        ldr r0, =fmt5    @ First arg -- address of format string
        mov r1, r5      @ Second arg -- character count        
        bl printf       @ Print the number of characters
        
        ldr r0, =fmt6    @ First arg -- address of format string
        mov r1, r8      @ Second arg -- character count        
        bl printf       @ Print the number of characters
        
        ldr r0, =fmt7    @ First arg -- address of format string
        mov r1, r2      @ Second arg -- character count        
        bl printf       @ Print the number of characters
        
        pop {lr}
        bx lr
        
fmt1:    .asciz "\nTotal Characters = %d\n"
fmt2:    .asciz "\nNewline Characters = %d\n"
fmt3:    .asciz "\nWhitespace Characters = %d\n"
fmt4:    .asciz "\nOctal Digits = %d\n"
fmt5:    .asciz "\nDecimal Digits = %d\n"
fmt6:    .asciz "\nHex Digits = %d\n"
fmt7:    .asciz "\nLetters = %d\n"
