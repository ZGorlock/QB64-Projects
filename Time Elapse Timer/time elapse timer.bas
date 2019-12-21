_TITLE "Time Elapse Timer"
SCREEN 12
DO
    adate$ = ""
    atime$ = ""
    bdate$ = ""
    btime$ = ""
    enterwhich = 1
    DO
        _LIMIT 32
        CLS
        PRINT "This program finds the amount of time between two times and dates"
        PRINT "Dates in the form of 'MM/DD/YYYY'"
        PRINT "Times in the form of 'HH:MM:SS' (Military Time)"
        PRINT "Enter your first date: "; adate$
        PRINT "Enter your first time: "; atime$
        PRINT "Enter your second date: "; bdate$
        PRINT "Enter your second time: "; btime$
        k$ = INKEY$
        IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
            DO
                IF k$ = CHR$(13) THEN
                    enterwhich = enterwhich + 1
                    DO
                        k$ = INKEY$
                    LOOP UNTIL k$ = ""
                    EXIT DO
                END IF
                SELECT CASE enterwhich
                    CASE 1
                        IF k$ = CHR$(8) THEN
                            adate$ = MID$(adate$, 1, (LEN(adate$) - 1))
                        ELSE
                            adate$ = adate$ + k$
                        END IF
                    CASE 2
                        IF k$ = CHR$(8) THEN
                            atime$ = MID$(atime$, 1, (LEN(atime$) - 1))
                        ELSE atime$ = atime$ + k$
                        END IF
                    CASE 3
                        IF k$ = CHR$(8) THEN
                            bdate$ = MID$(bdate$, 1, (LEN(bdate$) - 1))
                        ELSE
                            bdate$ = bdate$ + k$
                        END IF
                    CASE 4
                        IF k$ = CHR$(8) THEN
                            btime$ = MID$(btime$, 1, (LEN(btime$) - 1))
                        ELSE
                            btime$ = btime$ + k$
                        END IF
                END SELECT
                EXIT DO
            LOOP
        END IF
        _DISPLAY
    LOOP UNTIL enterwhich = 5
    DO
    LOOP WHILE TIMER < 2
    amonth = VAL(LEFT$(adate$, 2))
    aday = VAL(MID$(adate$, 4, 2))
    ayear = VAL(RIGHT$(adate$, 4))
    ahour = VAL(LEFT$(atime$, 2))
    aminute = VAL(MID$(atime$, 4, 2))
    asecond = VAL(RIGHT$(atime$, 2))
    bmonth = VAL(LEFT$(bdate$, 2))
    bday = VAL(MID$(bdate$, 4, 2))
    byear = VAL(RIGHT$(bdate$, 4))
    bhour = VAL(LEFT$(btime$, 2))
    bminute = VAL(MID$(btime$, 4, 2))
    bsecond = VAL(RIGHT$(btime$, 2))
    elapse## = 0
    FOR years = (ayear + 1) TO (byear - 1)
        isleap = (years MOD 4 = 0 AND years MOD 100 <> 0) OR years MOD 400 = 0
        elapse## = elapse## + (86400 * (365 - isleap))
    NEXT
    IF ayear <> byear THEN
        FOR amonths = (amonth + 1) TO 12
            SELECT CASE amonths
                CASE 2
                    isleap = (ayear MOD 4 = 0 AND ayear MOD 100 <> 0) OR ayear MOD 400 = 0
                    daysinmonth = 29 - isleap
                CASE 4, 6, 9, 11
                    daysinmonth = 30
                CASE ELSE
                    daysinmonth = 31
            END SELECT
            elapse## = elapse## + (86400 * daysinmonth)
        NEXT amonths
        FOR bmonths = 1 TO (bmonth - 1)
            SELECT CASE bmonths
                CASE 2
                    isleap = (byear MOD 4 = 0 AND byear MOD 100 <> 0) OR byear MOD 400 = 0
                    daysinmonth = 29 - isleap
                CASE 4, 6, 9, 11
                    daysinmonth = 30
                CASE ELSE
                    daysinmonth = 31
            END SELECT
            elapse## = elapse## + (86400 * daysinmonth)
        NEXT bmonths
        SELECT CASE amonth
            CASE 2
                isleap = (ayear MOD 4 = 0 AND ayear MOD 100 <> 0) OR ayear MOD 400 = 0
                daysinmonth = 29 - isleap
            CASE 4, 6, 9, 11
                daysinmonth = 30
            CASE ELSE
                daysinmonth = 31
        END SELECT
        elapse## = elapse## + ((daysinmonth - aday) * 86400)
        elapse## = elapse## + ((bday - 1) * 86400)
    END IF
    IF ayear = byear AND amonth <> bmonth THEN
        FOR months = (amonth + 1) TO (bmonth - 1)
            SELECT CASE month
                CASE 2
                    isleap = (ayear MOD 4 = 0 AND ayear MOD 100 <> 0) OR ayear MOD 400 = 0
                    daysinmonth = 29 - isleap
                CASE 4, 6, 9, 11
                    daysinmonth = 30
                CASE ELSE
                    daysinmonth = 31
            END SELECT
            elapse## = elapse## + (86400 * daysinmonth)
        NEXT months
        SELECT CASE amonth
            CASE 2
                isleap = (ayear MOD 4 = 0 AND ayear MOD 100 <> 0) OR ayear MOD 400 = 0
                daysinmonth = 29 - isleap
            CASE 4, 6, 9, 11
                daysinmonth = 30
            CASE ELSE
                daysinmonth = 31
        END SELECT
        elapse## = elapse## + ((daysinmonth - aday) * 86400)
        elapse## = elapse## + ((bday - 1) * 86400)
        elapse## = elapse## + (24 - 1 - ahour) * 3600
        elapse## = elapse## + (bhour * 3600)
        elapse## = elapse## + (60 - 1 - aminute) * 60
        elapse## = elapse## + (bminute * 60)
        elapse## = elapse## + 60 - asecond
        elapse## = elapse## + bsecond
    END IF
    IF ayear = byear AND amonth = bmonth AND aday <> bday THEN
        elapse## = elapse## + ((bday - (aday + 1)) * 86400)
        elapse## = elapse## + (24 - 1 - ahour) * 3600
        elapse## = elapse## + (bhour * 3600)
        elapse## = elapse## + (60 - 1 - aminute) * 60
        elapse## = elapse## + (bminute * 60)
        elapse## = elapse## + 60 - asecond
        elapse## = elapse## + bsecond
    END IF
    IF ayear = byear AND amonth = bmonth AND aday = bday AND ahour <> bhour THEN
        elapse## = elapse## + (bhour - 1 - ahour) * 3600
        elapse## = elapse## + (60 - 1 - aminute) * 60
        elapse## = elapse## + (bminute * 60)
        elapse## = elapse## + 60 - asecond
        elapse## = elapse## + bsecond
    END IF
    IF ayear = byear AND amonth = bmonth AND aday = bday AND ahour = bhour AND aminute <> bminute THEN
        elapse## = elapse## + (bminute - 1 - aminute) * 60
        elapse## = elapse## + 60 - asecond
        elapse## = elapse## + bsecond
    END IF
    IF ayear = byear AND amonth = bmonth AND aday = bday AND ahour = bhour AND aminute = bminute THEN elapse## = elapse## + bsecond - asecond
    DO
        _LIMIT 32
        CLS
        PRINT elapse##
        k$ = INKEY$
        _DISPLAY
    LOOP UNTIL k$ <> ""
LOOP