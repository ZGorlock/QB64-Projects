SCREEN 0
SCREEN 12
_TITLE "File Maker"
DO
    DO
        CLS
        PRINT "ex/ 'file.txt'"
        PRINT "Enter the name of a file you would like to create: "; file$
        DO
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
        IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
            inputlength = inputlength + 1
            filename$ = filename$ + k$
        END IF
        IF k$ = CHR$(8) AND inputlength <> 0 THEN
            inputlength = inputlength - 1
            filename$ = MID$(filename$, 1, (inputlength - 1))
        END IF
    LOOP UNTIL k$ = CHR$(13)
    OPEN file$ FOR OUTPUT AS #1
    CLOSE #1
LOOP