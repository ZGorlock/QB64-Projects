SCREEN 0
SCREEN 12
_TITLE "Pi Master"
DO
    CLS
    PRINT "What would you like to do?"
    PRINT "     1-View a scroll of x digits of pi"
    PRINT "     2-Find a digit in pi"
    PRINT "     3-Search for a series of digits for a string"
    PRINT "     4-Write x digits of pi to a file"
    DO
        k$ = INKEY$
    LOOP UNTIL LEN(k$)
    IF k$ = CHR$(49) THEN

    END IF
    IF k$ = CHR$(50) THEN
        pi$ = ""
        DO
            CLS
            PRINT "Enter the digit of pi you want to calculate"
            PRINT ": "; pi$
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                inputlength = inputlength + 1
                pi$ = pi$ + k$
            END IF
            IF k$ = CHR$(8) AND inputlength <> 0 THEN
                inputlength = inputlength - 1
                pi$ = MID$(pi$, 1, (LEN(pi$) - 1))
            END IF
        LOOP UNTIL k$ = CHR$(13)
        pi## = VAL(pi$)

(16^(-1 * pi##) * ((4 /     ((8*pi##)-1)) - (2/((8*pi##)+4)) - (1/((8*pi##)+5)) - (1/((8*pi##)+6))        )      )




    END IF
    IF k$ = CHR$(51) THEN

    END IF
    IF k$ = CHR$(52) THEN

    END IF
LOOP