SCREEN 0
SCREEN 12
_TITLE "Particles"
DO
    _AUTODISPLAY
    CLEAR
    DO
        nop$ = ""
        DO
            SCREEN 12
            LOCATE 1, 1
            PRINT SPACE$(80)
            LOCATE 1, 1
            PRINT ">number of particles:"; nop$
            SLEEP
            key$ = INKEY$
            IF key$ >= CHR$(48) AND key$ <= CHR$(57) THEN
                nop$ = nop$ + key$
                inputlength = LEN(nop$)
            END IF
            IF key$ = CHR$(8) AND inputlength > 0 THEN
                nop$ = MID$(nop$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
            IF key$ = CHR$(13) THEN
                nop = VAL(nop$)
                IF nop < 1 OR nop > 307200 THEN
                    EXIT DO
                END IF
                exitloop = 1
                EXIT DO
            END IF
        LOOP
        IF exitloop = 1 THEN EXIT DO
    LOOP
    exitloop = 0
    DO
        inputlength = 0
        sod$ = ""
        DO
            LOCATE 2, 1
            PRINT SPACE$(80)
            LOCATE 2, 1
            PRINT ">seed of direction:"; sod$
            SLEEP
            key$ = INKEY$
            IF key$ >= CHR$(48) AND key$ <= CHR$(57) THEN
                sod$ = sod$ + key$
                inputlength = LEN(sod$)
            END IF
            IF key$ = CHR$(8) AND inputlength > 0 THEN
                sod$ = MID$(sod$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
            IF key$ = CHR$(13) THEN
                sod = VAL(sod$)
                IF sod = 4 OR sod = 8 THEN
                    exitloop = 1
                    EXIT DO
                ELSE
                    EXIT DO
                END IF
            END IF
        LOOP
        IF exitloop = 1 THEN EXIT DO
    LOOP
    exitloop = 0
    DO
        sos$ = ""
        inputlength = 0
        DO
            LOCATE 3, 1
            PRINT SPACE$(80)
            LOCATE 3, 1
            PRINT ">seed of speed:"; sos$
            SLEEP
            key$ = INKEY$
            IF key$ >= CHR$(48) AND key$ <= CHR$(57) THEN
                sos$ = sos$ + key$
                inputlength = LEN(sos$)
            END IF
            IF key$ = CHR$(8) AND inputlength > 0 THEN
                sos$ = MID$(sos$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
            IF key$ = CHR$(13) THEN
                sos = VAL(sos$)
                IF sos < 1 OR sos > 1000 THEN
                    EXIT DO
                END IF
                exitloop = 1
                EXIT DO
            END IF
        LOOP
        IF exitloop = 1 THEN EXIT DO
    LOOP
    exitloop = 0
    DO
        tups$ = ""
        inputlength = 0
        DO
            LOCATE 4, 1
            PRINT SPACE$(80)
            LOCATE 4, 1
            PRINT ">time units per second:"; tups$
            SLEEP
            key$ = INKEY$
            IF key$ >= CHR$(48) AND key$ <= CHR$(57) THEN
                tups$ = tups$ + key$
                inputlength = LEN(tups$)
            END IF
            IF key$ = CHR$(8) AND inputlength > 0 THEN
                tups$ = MID$(tups$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
            IF key$ = CHR$(13) THEN
                tups = VAL(tups$)
                IF tups < 1 OR tups > 100 THEN
                    EXIT DO
                END IF
                exitloop = 1
                EXIT DO
            END IF
        LOOP
        IF exitloop = 1 THEN EXIT DO
    LOOP
    exitloop = 0
    DO
        sac$ = ""
        inputlength = 0
        DO
            LOCATE 5, 1
            PRINT SPACE$(80)
            LOCATE 5, 1
            PRINT ">start at centre:"; sac$
            SLEEP
            key$ = INKEY$
            IF key$ >= CHR$(48) AND key$ <= CHR$(57) THEN
                sac$ = sac$ + key$
                inputlength = LEN(sac$)
            END IF
            IF key$ = CHR$(8) AND inputlength > 0 THEN
                sac$ = MID$(sac$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
            IF key$ = CHR$(13) THEN
                sac = VAL(sac$)
                IF sac = 1 OR sac = 0 THEN
                    exitloop = 1
                    EXIT DO
                ELSE
                    EXIT DO
                END IF
            END IF
        LOOP
        IF exitloop = 1 THEN EXIT DO
    LOOP
    exitloop = 0
    enviroment = _NEWIMAGE(800, 800, 32)
    SCREEN enviroment
    REDIM S(nop)
    REDIM M(nop)
    REDIM D(nop)
    REDIM X(nop)
    REDIM Y(nop)
    REDIM Z(nop)
    FOR p = 1 TO nop
        RANDOMIZE TIMER
        S(p) = INT(RND * sos + 1)
        RANDOMIZE TIMER
        D(p) = INT(RND * sod + 1)
        IF sac = 1 THEN
            X(p) = 400
            Y(p) = 400
            Z(p) = 400
        ELSE
            RANDOMIZE TIMER
            X(p) = INT(RND * 750 + 1)
            RANDOMIZE TIMER
            Y(p) = INT(RND * 750 + 1)
            RANDOMIZE TIMER
            Z(p) = INT(RND * 750 + 1)
        END IF
    NEXT p
    time~&& = 0
    viewpos = 0
    DO
        _LIMIT tups
        key$ = INKEY$
        IF key$ = CHR$(27) THEN
            EXIT DO
        END IF
        IF key$ = CHR$(122) THEN
            SLEEP
        END IF
        IF key$ = CHR$(113) THEN
            viewpos = 0
        END IF
        IF key$ = CHR$(119) THEN
            viewpos = 1
        END IF
        time~&& = time~&& + 1
        CLS
        LOCATE 1, 79
        PRINT time~&&
        FOR p = 1 TO nop
            IF D(p) = 1 THEN
                Y(p) = Y(p) - S(p)
            END IF
            IF D(p) = 2 THEN
                Y(p) = Y(p) + S(p)
            END IF
            IF D(p) = 3 THEN
                X(p) = X(p) - S(p)
            END IF
            IF D(p) = 4 THEN
                X(p) = X(p) + S(p)
            END IF
            IF sod = 8 THEN
                IF D(p) = 5 THEN
                    X(p) = X(p) - S(p)
                    Y(p) = Y(p) - S(p)
                END IF
                IF D(p) = 6 THEN
                    X(p) = X(p) + S(p)
                    Y(p) = Y(p) - S(p)
                END IF
                IF D(p) = 7 THEN
                    X(p) = X(p) + S(p)
                    Y(p) = Y(p) + S(p)
                END IF
                IF D(p) = 8 THEN
                    X(p) = X(p) - S(p)
                    Y(p) = Y(p) + S(p)
                END IF
            END IF
            IF X(p) > 750 THEN
                X(p) = 750
            END IF
            IF X(p) < 50 THEN
                X(p) = 50
            END IF
            IF Y(p) > 750 THEN
                Y(p) = 750
            END IF
            IF Y(p) < 50 THEN
                Y(p) = 50
            END IF
            IF X(p) = 750 OR X(p) = 50 OR Y(p) = 750 OR Y(p) = 50 THEN
                IF D(p) = 1 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 2
                        CASE 1
                            D(p) = 7
                        CASE 2
                            D(p) = 8
                    END SELECT
                END IF
                IF D(p) = 2 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 1
                        CASE 1
                            D(p) = 5
                        CASE 2
                            D(p) = 6
                    END SELECT
                END IF
                IF D(p) = 3 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 4
                        CASE 1
                            D(p) = 6
                        CASE 2
                            D(p) = 7
                    END SELECT
                END IF
                IF D(p) = 4 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 3
                        CASE 1
                            D(p) = 5
                        CASE 2
                            D(p) = 8
                    END SELECT
                END IF
                IF D(p) = 5 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 2
                        CASE 1
                            D(p) = 4
                        CASE 2
                            D(p) = 7
                    END SELECT
                END IF
                IF D(p) = 6 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 2
                        CASE 1
                            D(p) = 3
                        CASE 2
                            D(p) = 8
                    END SELECT
                END IF
                IF D(p) = 7 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 1
                        CASE 1
                            D(p) = 3
                        CASE 2
                            D(p) = 5
                    END SELECT
                END IF
                IF D(p) = 8 THEN
                    RANDOMIZE TIMER
                    N = INT(RND * 3)
                    SELECT CASE N
                        CASE 0
                            D(p) = 1
                        CASE 1
                            D(p) = 4
                        CASE 2
                            D(p) = 6
                    END SELECT
                END IF
            END IF
            IF viewpos = 0 THEN
                PSET (X(p), Y(p))
            END IF
            IF viewpos = 1 THEN
                PSET (X(p), Z(p))
            END IF
        NEXT p
        _DISPLAY
    LOOP
LOOP