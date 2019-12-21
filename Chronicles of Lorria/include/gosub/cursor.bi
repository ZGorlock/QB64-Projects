'draws a cursor on the screen at the mouse location
cursor:
IF NOT setting.hidecursor THEN
    IF MOVEMOUSE OR Updatecursor THEN
        IF CLICK THEN
            IF Hovering THEN
                SPRITEPUT MInput.x, MInput.y, Cursorhit
            ELSE
                SPRITEPUT MInput.x, MInput.y, Cursoraction
            END IF
        ELSE
            IF Hovering THEN
                SPRITEPUT MInput.x, MInput.y, Cursorhover
            ELSE
                SPRITEPUT MInput.x, MInput.y, Cursorstand
            END IF
        END IF
        Updatecursor = 0
    END IF
END IF
RETURN