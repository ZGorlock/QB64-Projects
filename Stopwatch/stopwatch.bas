SCREEN 0
SCREEN 12
_TITLE "StopWatch"
DO
    CLEAR
    REDIM lap$(32768)
    laps = 0
    DO
        k$ = INKEY$
    LOOP UNTIL k$ = ""
    DO
        _LIMIT 64
        CLS
        PRINT "Press Space to start"
        PRINT "Press Space again to pause"
        PRINT "Press 'z' to lap"
        PRINT "Press 'x' to clear"
        PRINT "Press Esc to return to this page"
        PRINT "Press Esc on this page to close"
        k$ = INKEY$
        IF k$ = CHR$(27) THEN SYSTEM
        _DISPLAY
    LOOP UNTIL k$ = CHR$(32)
    start = TIMER
    DO
        _LIMIT 1000
        CLS
        timecatch = TIMER
        timecount = timecatch - start
        hours = INT(timecount / 3600)
        hours$ = STR$(hours)
        hours$ = LTRIM$(hours$)
        IF hours < 10 THEN hours$ = "0" + hours$
        minutes = INT(((((timecount / 3600) - hours) * 3600) / 60))
        minutes$ = STR$(minutes)
        minutes$ = LTRIM$(minutes$)
        IF minute < 10 THEN minutes$ = "0" + minutes$
        seconds = INT((((((timecount / 3600) - hours) * 3600) / 60) - minutes) * 60)
        seconds$ = STR$(seconds)
        seconds$ = LTRIM$(seconds$)
        IF seconds < 10 THEN seconds$ = "0" + seconds$
        miliseconds = INT(((timecount - INT(timecount)) * 1000))
        miliseconds$ = STR$(miliseconds)
        miliseconds$ = LTRIM$(miliseconds$)
        timea$ = hours$ + ":" + minutes$ + ":" + seconds$
        timeb$ = miliseconds$
        LOCATE 5, 36
        PRINT timea$
        LOCATE 6, 36
        PRINT timeb$
        lapprintloc = 14
        VIEW PRINT 15 TO 25
        FOR lapprint = 1 TO laps
            lappart1$ = "     LAP" + STR$(lapprint)
            PRINT lappart1$; SPACE$((50 - LEN(lappart1$)));
            PRINT lap$(lapprint)
        NEXT lapprint
        VIEW PRINT
        k$ = INKEY$
        IF k$ = CHR$(32) THEN
            DO
                k$ = INKEY$
            LOOP UNTIL k$ = ""
            DO
                k$ = INKEY$
            LOOP UNTIL k$ <> ""
        END IF
        IF k$ = CHR$(122) THEN
            laps = laps + 1
            lap$(laps) = timea$ + ":" + timeb$
        END IF
        IF k$ = CHR$(120) THEN
            CLEAR
            REDIM lap$(32768)
            laps = 0
            start = TIMER
        END IF
        IF k$ = CHR$(27) THEN EXIT DO
        _DISPLAY
    LOOP
LOOP