_TITLE "Universe"
SCREEN 0
SCREEN 12
ux = 1000
uy = 1000
uz = 1000
units = 1000
DIM x(units)
DIM y(units)
DIM z(units)
timeunit = 0
timeunit$ = STR$(timeunit)
timeunit$ = LTRIM$(timeunit$)
OPEN "log.txt" FOR OUTPUT AS #1
PRINT #1, timeunit$
FOR unit = 1 TO units
    DO
        RANDOMIZE TIMER
        x(unit) = INT(RND * ux)
        RANDOMIZE TIMER
        y(unit) = INT(RND * uy)
        RANDOMIZE TIMER
        z(unit) = INT(RND * uz)
        FOR oldunit = 1 TO (unit - 1)
            FOR checkunit = 1 TO (unit - 1)
                IF oldunit <> checkunit THEN
                    IF x(oldunit) = x(checkunit) THEN
                        IF y(oldunit) = y(checkunit) THEN
                            IF z(oldunit) = z(checkunit) THEN
                                EXIT DO
                            END IF
                        END IF
                    END IF
                END IF
            NEXT checkunit
        NEXT oldunit
        x$ = STR$(x(unit))
        y$ = STR$(y(unit))
        z$ = STR$(z(unit))
        x$ = LTRIM$(x$)
        y$ = LTRIM$(y$)
        z$ = LTRIM$(z$)
        unit$ = STR$(unit)
        unit$ = LTRIM$(unit$)
        loc$ = unit$ + " - (" + x$ + ", " + y$ + ", " + z$ + ")"
        PRINT #1, loc$
        EXIT DO
    LOOP
NEXT unit
DO
    timeunit = timeunit + 1
    timeunit$ = STR$(timeunit)
    timeunit$ = LTRIM$(timeunit$)
    PRINT #1, ""
    PRINT #1, timeunit$
    CLS
    PRINT timeunit
    FOR unit = 1 TO units
        DO
            RANDOMIZE TIMER
            dimadd = INT(RND * 2)
            RANDOMIZE TIMER
            cas = INT(RND * 2)
            IF cas = 1 THEN
                x(unit) = x(unit) + dimadd
            END IF
            IF cas = 0 THEN
                x(unit) = x(unit) - dimadd
            END IF
            RANDOMIZE TIMER
            dimadd = INT(RND * 2)
            RANDOMIZE TIMER
            cas = INT(RND * 2)
            IF cas = 1 THEN
                y(unit) = y(unit) + dimadd
            END IF
            IF cas = 0 THEN
                y(unit) = y(unit) - dimadd
            END IF
            RANDOMIZE TIMER
            dimadd = INT(RND * 2)
            RANDOMIZE TIMER
            cas = INT(RND * 2)
            IF cas = 1 THEN
                z(unit) = z(unit) + dimadd
            END IF
            IF cas = 0 THEN
                z(unit) = z(unit) - dimadd
            END IF
            FOR oldunit = 1 TO (unit - 1)
                FOR checkunit = 1 TO (unit - 1)
                    IF oldunit <> checkunit THEN
                        IF x(oldunit) = x(checkunit) THEN
                            IF y(oldunit) = y(checkunit) THEN
                                IF z(oldunit) = z(checkunit) THEN
                                    EXIT DO
                                END IF
                            END IF
                        END IF
                    END IF
                NEXT checkunit
            NEXT oldunit
            x$ = STR$(x(unit))
            y$ = STR$(y(unit))
            z$ = STR$(z(unit))
            x$ = LTRIM$(x$)
            y$ = LTRIM$(y$)
            z$ = LTRIM$(z$)
            unit$ = STR$(unit)
            unit$ = LTRIM$(unit$)
            loc$ = unit$ + " - (" + x$ + ", " + y$ + ", " + z$ + ")"
            PRINT #1, loc$
            EXIT DO
        LOOP
    NEXT unit
    k$ = INKEY$
    IF k$ = CHR$(32) THEN
        DO
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
    END IF
    ' This is your god, to make contact use 'PRINT [message]' or 'PRINT #client, [message]' to print something to my screen, or 'SYSTEM' to close your universe.
LOOP UNTIL k$ = CHR$(27)
CLOSE #1
SYSTEM