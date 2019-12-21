SCREEN 0
SCREEN 12
_TITLE "Crypt Keeper"
BEGINCRYPTKEEPER:
DO
    _LIMIT 50
    CLS
    PRINT "What would you like to do?"
    PRINT "     1-Encrypt"
    PRINT "     2-Decrypt"
    DO
        k$ = INKEY$
    LOOP UNTIL LEN(k$)
    IF k$ = CHR$(49) THEN
        filename$ = ""
        inputlength = 0
        DO
            CLS
            PRINT "Name of file to be encrypted: ", filename$
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
        OPEN filename$ FOR INPUT AS #1
        IF LOF(1) <= 32000 THEN Text$ = INPUT$(LOF(1), 1)
        CLOSE #1
        Send$ = ""
        FOR i = 1 TO LEN(Text$)
            Letter$ = MID$(Text$, i, 1)
            Code = ASC(Letter$)
            IF Code >= 32 AND Code <= 124 THEN
                Letter$ = CHR$(Code + 130)
            END IF
            Send$ = Send$ + Letter$
        NEXT i
        OPEN filename$ FOR OUTPUT AS #1
        PRINT #1, Send$
        CLOSE #1
        CLS
        PRINT "Encrypt successful"
        SLEEP
        GOTO BEGINCRYPTKEEPER
    END IF
    IF k$ = CHR$(50) THEN
        filename$ = ""
        inputlength = 0
        DO
            CLS
            PRINT "Name of file to be decrypted: ", filename$
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
        OPEN filename$ FOR INPUT AS #1
        Text$ = INPUT$(LOF(1), 1)
        CLOSE #1
        Send$ = ""
        FOR i = 1 TO LEN(Text$)
            Letter$ = MID$(Text$, i, 1)
            Code = ASC(Letter$)
            IF Code >= 162 AND Code <= 254 THEN
                Letter$ = CHR$(Code - 130)
            END IF
            Send$ = Send$ + Letter$
        NEXT i
        OPEN filename$ FOR OUTPUT AS #1
        PRINT #1, Send$
        CLOSE #1
        CLS
        PRINT "Decrypt successful"
        SLEEP
        GOTO BEGINCRYPTKEEPER
    END IF
LOOP