SCREEN 0
SCREEN 12
_TITLE "Division Wizard"
DO
    DO
        CLS
        PRINT "Enter a number and see a list of its factors"
        PRINT "Entering large numbers may cause the program to run out of memory"
        PRINT ": "; number$
        SLEEP
        k$ = INKEY$
        IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
            number$ = number$ + k$
            inputlength = LEN(number$)
        END IF
        IF k$ = CHR$(8) AND inputlength > 0 THEN
            number$ = MID$(number$, 1, (inputlength - 1))
            inputlength = (inputlength - 1)
        END IF
    LOOP UNTIL k$ = CHR$(13) AND number$ <> ""
    number## = VAL(number$)
    CLS
    PRINT ">determining factors"
    REDIM factors$(number##)
    factors = 0
    FOR i## = 1 TO number##
        a## = number## / i##
        IF INT(a##) = a## THEN
            factors = factors + 1
            factors$(factors) = STR$(i##)
        END IF
    NEXT i##
    PRINT ">complete"
    _DELAY .5
    DO
        CLS
        PRINT "This number has"; factors; "factors"
        PRINT "Press Space to see the list of factors"
        PRINT "Use the scroll wheel to move up and down through the list"
        PRINT "When you are finished looking press Space to exit"
        SLEEP
        k$ = INKEY$
    LOOP UNTIL k$ = CHR$(32)
    DO
        k$ = INKEY$
    LOOP UNTIL k$ <> CHR$(32)
    IF factors <= 27 THEN
        DO
            CLS
            FOR n = row TO factors
                PRINT factors$(n)
            NEXT
            SLEEP
            k$ = INKEY$
        LOOP UNTIL k$ = CHR$(32)
    ELSE
        row = 1
        DO
            k$ = INKEY$
            DO WHILE _MOUSEINPUT
                row = row + (_MOUSEWHEEL * 3)
                IF prevrow <> row THEN
                    IF row < 1 THEN
                        row = 1
                    END IF
                    IF row > (factors - 27) THEN
                        row = (factors - 27)
                    END IF
                    CLS
                    FOR n = row TO row + 27
                        PRINT factors$(n)
                    NEXT
                END IF
                prevrow = row
            LOOP
        LOOP UNTIL k$ = CHR$(32)
    END IF
    CLEAR
LOOP