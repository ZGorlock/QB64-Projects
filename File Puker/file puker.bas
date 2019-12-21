_TITLE "File Puker"
SCREEN 12

DO
    DO
        CLEAR
        DO
            _LIMIT 32
            CLS
            PRINT "What would you like to name this puke?"
            PRINT ": "; puke$
            DO
                _LIMIT 64
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            SELECT CASE ASC(k$)
                CASE 8
                    IF LEN(puke$) > 0 THEN puke$ = MID$(puke$, 1, (LEN(puke$) - 1))
                CASE 13
                    IF _DIREXISTS("puke\" + puke$) = -1 THEN
                        DO
                            times = times + 1
                            pukee$ = puke$ + "_" + LTRIM$(RTRIM$(STR$(times)))
                            IF _DIREXISTS("puke\" + pukee$) = 0 THEN EXIT DO
                        LOOP
                        puke$ = pukee$
                    END IF
                    EXIT DO
                CASE 27
                    SYSTEM
                CASE 32 TO 126
                    IF k$ <> CHR$(32) AND k$ <> CHR$(35) AND k$ <> CHR$(37) AND k$ <> CHR$(38) AND k$ <> CHR$(42) AND k$ <> CHR$(47) AND k$ <> CHR$(58) AND k$ <> CHR$(60) AND k$ <> CHR$(62) AND k$ <> CHR$(63) AND k$ <> CHR$(92) AND k$ <> CHR$(123) AND k$ <> CHR$(124) AND k$ <> CHR$(125) AND k$ <> CHR$(126) THEN puke$ = puke$ + k$
            END SELECT
        LOOP
        DO
            _LIMIT 32
            CLS
            PRINT "How many files would you like to puke?"
            PRINT ": "; num$
            DO
                _LIMIT 64
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            SELECT CASE ASC(k$)
                CASE 8
                    IF LEN(num$) > 0 THEN num$ = MID$(num$, 1, (LEN(num$) - 1))
                CASE 13
                    num& = VAL(num$)
                    IF num& > 0 AND num& <= 1073741824 THEN EXIT DO
                CASE 27
                    SYSTEM
                CASE 48 TO 57
                    num$ = num$ + k$
            END SELECT
            IF LEN(num$) > 10 THEN num$ = MID$(num$, 1, 10)
        LOOP
        DO
            _LIMIT 32
            CLS
            PRINT "You are about to puke "; num$; " files"
            PRINT "These files will be located in the folder puke\"; puke$
            PRINT "Puking a large number of files can take a very long time"
            PRINT "If at any time you wish to abort, press Esc"
            PRINT "To pause press Space at any time"
            PRINT "Press Enter to begin"
            PRINT "Press Space to Edit the details"
            DO
                _LIMIT 64
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            SELECT CASE ASC(k$)
                CASE 13
                    EXIT DO
                CASE 27
                    SYSTEM
                CASE 32
                    EXIT DO
            END SELECT
        LOOP
    LOOP UNTIL k$ = CHR$(13)
    DO
        FOR x = 1 TO 1024
            x$ = LTRIM$(RTRIM$(STR$(x)))
            FOR xadd = 1 TO (4 - LEN(x$))
                x$ = "0" + x$
            NEXT xadd
            SHELL _HIDE "mkdir puke\" + puke$ + "\" + x$
            FOR y = 1 TO 1024
                y$ = LTRIM$(RTRIM$(STR$(y)))
                FOR yadd = 1 TO (4 - LEN(y$))
                    y$ = "0" + y$
                NEXT yadd
                SHELL _HIDE "mkdir puke\" + puke$ + "\" + x$ + "\" + y$
                FOR z = 1 TO 1024
                    a& = a& + 1
                    a$ = LTRIM$(RTRIM$(STR$(a&)))
                    FOR aadd = 1 TO (10 - LEN(a$))
                        a$ = "0" + a$
                    NEXT aadd
                    OPEN "puke\" + puke$ + "\" + x$ + "\" + y$ + "\" + a$ + ".txt" FOR OUTPUT AS #1
                    CLOSE #1
                    CLS
                    PRINT "Puking file #"; a$
                    k$ = INKEY$
                    IF k$ <> "" THEN
                        SELECT CASE ASC(k$)
                            CASE 27
                                SYSTEM
                            CASE 32
                                SLEEP
                        END SELECT
                    END IF
                    IF a& = num& THEN EXIT DO
                NEXT z
            NEXT y
        NEXT x
    LOOP
    DO
        _LIMIT 32
        CLS
        PRINT "Puking succesful!"
        PRINT "Press Enter to exit the program"
        PRINT "Press Space to puke again"
        DO
            _LIMIT 64
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
        SELECT CASE ASC(k$)
            CASE 13
                EXIT DO
            CASE 27
                SYSTEM
            CASE 32
                EXIT DO
        END SELECT
    LOOP
LOOP UNTIL k$ = CHR$(13)
CLEAR
SYSTEM