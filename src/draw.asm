
; Drawing functions

; 'draw_drawFilledBox'
; Draws a filled box on the screen
; PARAM:
;   al = color
;   bh = width
;   bl = height
;   ch = xPos
;   cl = yPos
draw_drawFilledBox:
    pusha
    
    ; if (xPos > SCREEN_WIDTH_MAX) then exit
    .checkXpos:
        cmp     ch, SCREEN_WIDTH_MAX
        ja      .end

    ; if (yPos > SCREEN_HEIGHT_MAX) then exit
    .checkYpos:
        cmp     cl, SCREEN_HEIGHT_MAX
        ja      .end

    ; if (width+xPos > SCREEN_WIDTH) then resize
    .checkWidth:
        xor     dx, dx
        mov     dl, bh
        push    cx
        mov     cl, ch
        mov     ch, 0
        add     dx, cx
        pop     cx
        cmp     dx, SCREEN_WIDTH
        jb      @f

        ; width = width - (total - SCREEN_WIDTH)
        sub     dx, SCREEN_WIDTH
        sub     bh, dl
        @@:

    ; if (height+yPos > SCREEN_HEIGHT) then resize
    .checkHeight:
        xor     dx, dx
        mov     dl, bl
        push    cx
        mov     ch, 0
        add     dx, cx
        pop     cx
        cmp     dx, SCREEN_HEIGHT
        jb      @f

        ; height = height - (total - SCREEN_HEIGHT)
        sub     dx, SCREEN_HEIGHT
        sub     bl, dl
        @@:

    .prepareForDrawing:
        ; dl = xPos
        ; dh = yPos
        mov     dx, cx
        xchg    dh, dl
        call    .proc_setCursorPosition
        ; clear cx for use as an iteration counter
        xor     cx, cx

    .nextRow:
        ; Draw the row...
        .plotChar:
            pusha
            mov     cl, bh      ; Iterate for (width) times
            mov     ah, 0x09    ; Mode number
            mov     bl, al      ; Attribute
            mov     bh, 0x00    ; Page number = 0
            mov     al, 0x00    ; Display null char
            int     0x10
            popa

        ; yPos++
        inc     dh
        ; height--
        dec     bl
        ; if (height == 0) then exit
        cmp     bl, 0
        jz      .end

        ; move the cursor to the beginning of the next row
        call    .proc_setCursorPosition
        jmp     .nextRow

    .proc_setCursorPosition:
        pusha
        mov     ah, 0x02    ; Mode number
        mov     bh, 0x00    ; Page number = 0
        int     0x10
        popa
        ret

    .end:
        popa
        ret
