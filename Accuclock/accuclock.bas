_TITLE "AccuClock"
SCREEN 0
LoTS# = ((((365.242199 / 365) - 1) / 86400) + 1)
DO
    Year$ = RIGHT$(DATE$, 4)
    Month$ = LEFT$(DATE$, 2)
    Day$ = MID$(DATE$, 3, 5)
    Hour$ = LEFT$(TIME$, 2)
    Minute$ = MID$(TIME$, 3, 3)
    Second$ = RIGHT$(TIME$, 2)
    Year = VAL(Year$)
    Month = VAL(Month$)
    Day = VAL(Day$)
    Hour = VAL(Hour$)
    Minute = VAL(Minute$)
    Second = VAL(Second$)
    TiS~&& = ((Year * 31536000) + (Day * 86400) + (Hour * 3600) + (Minute * 60) + Second)
    IF Month = 2 THEN
        TiS~&& = TiS~&& + 2678400
    END IF
    IF Month = 3 THEN
        TiS~&& = TiS~&& + 5097600
    END IF
    IF Month = 4 THEN
        TiS~&& = TiS~&& + 7776000
    END IF
    IF Month = 5 THEN
        TiS~&& = TiS~&& + 10368000
    END IF
    IF Month = 6 THEN
        TiS~&& = TiS~&& + 13046400
    END IF
    IF Month = 7 THEN
        TiS~&& = TiS~&& + 15638400
    END IF
    IF Month = 8 THEN
        TiS~&& = TiS~&& + 18316800
    END IF
    IF Month = 9 THEN
        TiS~&& = TiS~&& + 20995200
    END IF
    IF Month = 10 THEN
        TiS~&& = TiS~&& + 23587200
    END IF
    IF Month = 11 THEN
        TiS~&& = TiS~&& + 26265600
    END IF
    IF Month = 12 THEN
        TiS~&& = TiS~&& + 28857600
    END IF
    TTiS# = TiS~&& * LoTS#
    CLS
    PRINT TiS~&&
    PRINT LoTS#
    PRINT TTiS#
TTiY# = INT(TTiS# / 31556925.9936)
TTiY$ = STR$(TTiY#)
TTiY$ = LTRIM$(TTiY$)
TTiYl# = (((TTiS# / 31556925.9936) - TTiY#) * 31556925.9936)
TTi
DO
wait$ = RIGHT$(TIME$, 2)
LOOP UNTIL wait$ <> oldwait$
oldwait$  wait$
LOOP