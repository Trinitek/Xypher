
; Drawing functions

; 'drawBox'
; Draws a filled box on the screen
; PARAM:
;   al = color
;   bh = width
;   bl = height
;   ch = xPos
;   cl = yPos
drawBox:
    push    dx

    ; if (xPos > SCREEN_WIDTH_MAX) then return
    .checkXpos:
        cmp     ch, SCREEN_WIDTH_MAX
        jng     @f

        jmp     end

    ; if (yPos > SCREEN_HEIGHT_MAX) then return
    .checkYpos:
        cmp     cl, SCREEN_HEIGHT_MAX
        jng     @f

        jmp     end

    ; if (width+xPos > SCREEN_WIDTH) then resize
    .checkWidth:
        xor     dx, dx
        mov     dl, bh
        add     dx, ch
        cmp     dx, SCREEN_WIDTH
        jng     @f

        ; TODO!!

    ; if (height+yPos > SCREEN_HEIGHT) then resize
    .checkHeight:
        xor     dx, dx
        mov     dl, bl
        add     dx, cl
        cmp     dx, SCREEN_HEIGHT
        jng     @f

        ; TODO!!

    .end:
        pop     dx
        ret
