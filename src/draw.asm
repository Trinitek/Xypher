
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
            mov     bh, 0       ; Page number = 0
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
        mov     bh, 0       ; Page number = 0
        int     0x10
        popa
        ret

    .end:
        popa
        ret

; 'draw_drawLineHoriz'
; Draws a horizontal line from an origin point on the leftmost side
; al = color
; cl = length
; dl = xPos
; dh = yPos
draw_drawLineHoriz:
    pusha
        
    ; if (xPos > SCREEN_WIDTH_MAX) then exit
    .checkXpos:
        cmp     dl, SCREEN_WIDTH_MAX
        ja      .end
    
    ; if (yPos > SCREEN_HEIGHT_MAX) then exit
    .checkYpos:
        cmp     dh, SCREEN_HEIGHT_MAX
        ja      .end
    
    ; if (width+xPos > SCREEN_WIDTH) then resize
    .checkWidth:
        xor     bx, bx
        mov     bl, cl
        push    dx
        mov     dh, 0
        add     bx, dx
        pop     dx
        cmp     bx, SCREEN_WIDTH
        jb      @f
        
        ; width = width - (total - SCREEN_WIDTH)
        sub     bx, SCREEN_WIDTH
        sub     cl, bl
        @@:
    
    .setCursorPosition:
        mov     ah, 0x02    ; Mode number
        mov     bh, 0       ; Page number = 0
        int     0x10
    
    .plotChar:
        mov     ch, 0       ; Clear high
        mov     ah, 0x09    ; Mode number
        mov     bl, al      ; Attribute
        mov     bh, 0       ; Page number = 0
        mov     al, 0x00    ; Display null char
        int     0x10
    
    .end:
        popa
        ret
        
; 'draw_drawLineVert'
; Draws a vertical line from an origin point on the topmost side
; al = color
; cl = length
; dl = xPos
; dh = yPos
draw_drawLineVert:
    pusha
    
    ; if (xPos > SCREEN_WIDTH_MAX) then exit
    .checkXpos:
        cmp     dl, SCREEN_WIDTH_MAX
        ja      .end
    
    ; if (yPos > SCREEN_HEIGHT_MAX) then exit
    .checkYpos:
        cmp     dh, SCREEN_HEIGHT_MAX
        ja      .end
    
    ; if (height+xPos > SCREEN_HEIGHT) then resize
    .checkHeight:
        xor     bx, bx
        mov     bl, cl
        push    dx
        mov     dl, dh
        mov     dh, 0
        add     bx, dx
        pop     dx
        cmp     bx, SCREEN_HEIGHT
        jb      @f
        
        ; height = height - (total - SCREEN_HEIGHT)
        sub     bx, SCREEN_HEIGHT
        sub     cl, bl
        @@:
    
    ;.prepareForDrawing:
        mov     ch, 0       ; Will be used as iteration counter
        mov     bh, 0       ; Page number = 0
        mov     bl, al      ; Attribute
        mov     al, 0x00    ; Display null character
        
        
    .nextRow:
        ; set cursor position
        mov     ah, 0x02    ; Mode number
        int     0x10
        
        ; draw the pixel
        push    cx
        mov     cl, 1       ; Iterate once
        mov     ah, 0x09    ; Mode number
        int     0x10
        pop     cx
        
        ; update cursor coordinates
        ; yPos++
        inc     dh
        ; if (height == 0) then exit
        ; height--
        loop    .nextRow
    
    .end:
        popa
        ret
