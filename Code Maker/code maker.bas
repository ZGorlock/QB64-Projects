_TITLE "Code Maker"
SCREEN 12
DO
    DO
        codetype$ = ""
        DO
            _LIMIT 32
            CLS
            PRINT "What type of code would you like to make?"
            PRINT "    0-ASCII"
            PRINT "    1-Hexidecimal"
            PRINT "    2-Binary"
            PRINT "    3-"
            PRINT "    4-"
            PRINT "    5-"
            PRINT "    6-"
            PRINT "    7-"
            PRINT
            PRINT ":"; codetype$
            k$ = INKEY$
            IF k$ = CHR$(27) THEN SYSTEM
            IF k$ = CHR$(13) THEN EXIT DO
            IF k$ = CHR$(8) AND LEN(codetype$) <> 0 THEN codetype$ = MID$(codetype$, 1, (LEN(codetype$) - 1))
            IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN codetype$ = codetype$ + k$
            IF LEN(codetype$) > 1 THEN codetype$ = MID$(codetype$, 1, (LEN(codetype$) - 1))
            _DISPLAY
        LOOP
        codetype = VAL(codetype$)
        IF codetype >= 0 AND codetype <= 7 THEN EXIT DO
    LOOP
    SELECT CASE codetype
        CASE 0
            codename$ = "-ASCII-"
        CASE 1
            codename$ = "-Hexidecimal-"
        CASE 2
            codename$ = "-Binary-"
        CASE 3
            codename$ = ""
        CASE 4
            codename$ = ""
        CASE 5
            codename$ = ""
        CASE 6
            codename$ = ""
        CASE 7
            codename$ = ""
    END SELECT
    SELECT CASE codetype
        CASE 0, 1, 2
            DO
                _LIMIT 32
                CLS
                PRINT codename$
                PRINT
                PRINT "Enter the message you want to encode:"
                PRINT ":"; message$
                k$ = INKEY$
                IF k$ = CHR$(27) THEN SYSTEM
                IF k$ = CHR$(13) THEN EXIT DO
                IF k$ = CHR$(8) AND LEN(message$) <> 0 THEN message$ = MID$(message$, 1, (LEN(message$) - 1))
                IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN message$ = message$ + k$
                _DISPLAY
            LOOP
            SELECT CASE codetype
                CASE 0
                    cmessage$ = ""
                    FOR coder = 1 TO LEN(message$)
                        cmessage$ = cmessage$ + LTRIM$(STR$(ASC(MID$(message$, coder, 1)))) + ":"
                    NEXT coder
                    cmessage$ = MID$(cmessage$, 1, (LEN(cmessage$) - 1))
                CASE 1
                CASE 2
            END SELECT
        CASE 3
        CASE 4
        CASE 5
        CASE 6
        CASE 7
    END SELECT
    PRINT ":"; cmessage$
    PRINT
    PRINT "Press Ctrl+C to copy the coded message to your clipboard"
    _DISPLAY
    DO
        _LIMIT 32
        k$ = INKEY$
        IF k$ = CHR$(27) THEN SYSTEM
        IF k$ = CHR$(3) THEN
            _CLIPBOARD$ = cmessage$
            k$ = ""
        END IF
    LOOP UNTIL k$ <> ""
    CLEAR
LOOP