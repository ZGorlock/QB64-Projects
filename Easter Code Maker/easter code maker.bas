SCREEN 12
_TITLE "Easter Code Maker"
DO
    clue$ = ""
    codeclue$ = ""
    inputlength = 0
    x = 0
    DO
        CLS
        PRINT "Enter your clue."
        PRINT "Press Enter to copy your code to the clipboard, press ESC to clear."
        PRINT ": "; clue$
        SLEEP
        k$ = INKEY$
        IF k$ = CHR$(27) THEN EXIT DO
        IF k$ = CHR$(32) OR k$ = CHR$(40) OR k$ = CHR$(41) OR k$ = CHR$(46) OR k$ = CHR$(33) OR k$ = CHR$(63) THEN
            clue$ = clue$ + k$
            IF k$ = CHR$(32) THEN
                cluecode$ = cluecode$ + k$ + k$ + k$
            ELSE
                cluecode$ = cluecode$ + k$
            END IF
            inputlength = LEN(clue$)
            x = 0
        END IF
        IF (k$ >= CHR$(48) AND k$ <= CHR$(58)) OR (k$ >= CHR$(65) AND k$ <= CHR$(122)) THEN
            clue$ = clue$ + k$
            codekey = ASC(UCASE$(k$))
            IF codekey < 65 THEN
                codekey = codekey - 48
            ELSE
                codekey = codekey - 55
            END IF
            codekey$ = STR$(codekey)
            codekey$ = MID$(codekey$, 2, 4)
            IF x = 0 THEN
                codekey$ = codekey$
            ELSE
                codekey$ = "-" + codekey$
            END IF
            cluecode$ = cluecode$ + codekey$
            inputlength = LEN(clue$)
            x = 1
        END IF
    LOOP UNTIL k$ = CHR$(13)
    IF k$ <> CHR$(27) THEN
        _CLIPBOARD$ = cluecode$
        CLS
        PRINT "Your code has been copied. Paste it into a word document."
        PRINT "Press any key to continue."
        DO
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
        IF k$ = CHR$(27) THEN SYSTEM
    END IF
    clue$ = ""
    cluecode$ = ""
LOOP