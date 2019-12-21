SCREEN 0
SCREEN 12
_TITLE "Odd-Even"
DO
    DO
        k$ = INKEY$
    LOOP UNTIL k$ = ""
    wa$ = ""
    DO
        CLS
        PRINT "Enter the winning amount"
        PRINT ": "; wa$
        SLEEP
        k$ = INKEY$
        IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
            wa$ = wa$ + k$
            inputlength = LEN(wa$)
        END IF
        IF k$ = CHR$(8) AND inputlength > 0 THEN
            wa$ = MID$(wa$, 1, (inputlength - 1))
            inputlength = (inputlength - 1)
        END IF
    LOOP UNTIL k$ = CHR$(13) AND wa$ <> ""
    wa## = VAL(wa$)
    DO
        mta$ = ""
        DO
            CLS
            PRINT "Enter the maximum throw amount"
            PRINT ": "; mta$
            SLEEP
            k$ = INKEY$
            IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                mta$ = mta$ + k$
                inputlength = LEN(mta$)
            END IF
            IF k$ = CHR$(8) AND inputlength > 0 THEN
                mta$ = MID$(mta$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
        LOOP UNTIL k$ = CHR$(13) AND mta$ <> ""
        mta## = VAL(mta$)
        IF mta## < wa## THEN EXIT DO
    LOOP
    once = 1
    FOR loops = 1 TO 10
        k$ = INKEY$
        IF team = 1 THEN
            team = 2
        ELSE
            team = 1
        END IF
        IF once = 1 THEN
            RANDOMIZE TIMER
            team = INT(RND * 2 + 1)
            once = 0
        END IF
        IF team = 1 THEN team$ = "Even"
        IF team = 2 THEN team$ = "Odd"
        CLS
        PRINT "You are Team "; team$
        delaytime = loops / 12
        _DELAY delaytime
    NEXT loops
    PLAY "O3B8"
    DO
        score## = 0
        cpu## = 0
        DO
            DO
                k$ = INKEY$
            LOOP UNTIL k$ = ""
            DO
                throw$ = ""
                DO
                    CLS
                    LOCATE 2, 5
                    PRINT "Score:"; score##
                    LOCATE 3, 5
                    PRINT "CPU:"; cpu##
                    LOCATE 10, 10
                    PRINT "Enter your throw: "; throw$
                    SLEEP
                    k$ = INKEY$
                    IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                        throw$ = throw$ + k$
                        inputlength = LEN(throw$)
                    END IF
                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                        throw$ = MID$(throw$, 1, (inputlength - 1))
                        inputlength = (inputlength - 1)
                    END IF
                LOOP UNTIL k$ = CHR$(13) AND throw$ <> ""
                throw## = VAL(throw$)
                IF throw## <= mta## THEN EXIT DO
            LOOP
            even = 0
            odd = 0
            leave = 0
            CLS
            LOCATE 2, 5
            PRINT "Score:"; score##
            LOCATE 3, 5
            PRINT "CPU:"; cpu##
            LOCATE 10, 10
            PRINT "You threw:"; throw##
            _DELAY 1
            RANDOMIZE TIMER
            cputhrow## = INT(RND * mta## + 1)
            LOCATE 11, 10
            PRINT "The CPU threw:"; cputhrow##
            _DELAY .5
            LOCATE 12, 10
            cumulativethrow## = throw## + cputhrow##
            PRINT "The cumulative throw is:"; cumulativethrow##
            _DELAY .5
            oecheck## = (cumulativethrow## / 2)
            LOCATE 13, 10
            check## = _ROUND(oecheck##)
            IF check## = oecheck## THEN
                PRINT "This number is even"
                even = 1
            ELSE
                PRINT "This number is odd"
                odd = 1
            END IF
            _DELAY .5
            LOCATE 14, 10
            IF (even = 1 AND team = 1) OR (odd = 1 AND team = 2) THEN
                PRINT "You get the pot!"
                score## = score## + cumulativethrow##
            ELSE
                PRINT "CPU got the pot"
                cpu## = cpu## + cumulativethrow##
            END IF
            _DELAY .5
            IF (score## >= wa##) OR (cpu## >= wa##) THEN
                CLS
                LOCATE 12, 36
                IF score## > cpu## THEN
                    PRINT "YOU WON!"
                    _DELAY 1
                ELSE
                    PRINT "CPU WON!"
                END IF
                PRINT "Press any key to play again"
                leave = 1
            ELSE
                LOCATE 2, 5
                PRINT "Score:"; score##
                LOCATE 3, 5
                PRINT "CPU:"; cpu##
                LOCATE 16, 1
                PRINT "Press any key to continue to next round"
            END IF
            SLEEP
            IF leave = 1 THEN EXIT DO
        LOOP
        IF leave = 1 THEN EXIT DO
    LOOP
LOOP