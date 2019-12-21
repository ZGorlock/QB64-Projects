SCREEN 0
SCREEN 12
_TITLE "Reaction Timer"
DO
    DO
        CLS
        PRINT "You will be taken to a blank screen"
        PRINT "After a random amount of time, a circle will apear"
        PRINT "As soon as you see the circle, press Space"
        PRINT "You will then be informed of your reaction time"
        PRINT "Press Space to begin"
        DO
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
    LOOP UNTIL k$ = CHR$(32)
    CLS
    PSET (320, 240)
    a = TIMER
    r = 0
    loops = 0
    RANDOMIZE TIMER
    waittime1 = INT(RND * 10 + 1)
    RANDOMIZE TIMER
    waittime2 = INT(RND * 10 + 1)
    waittime = (waittime1 + (waittime2 / 10))
    DO
        _LIMIT 100
        k$ = INKEY$
        b = TIMER
        lapsed = (b - a)
        IF lapsed > waittime THEN
            IF r = 0 THEN
                FOR r = 1 TO 20
                    CIRCLE STEP(0, 0), r, 15
                NEXT r
            END IF
            loops = loops + 1
            loops$ = STR$(loops)
            loops$ = "     " + loops$ + "     "
            LOCATE 18, INT((((80 - LEN(loops$)) / 2) + 1))
            PRINT loops$
            IF k$ = CHR$(32) THEN
                reactiontime = loops
                _DELAY .5
                EXIT DO
            END IF
        END IF
    LOOP
    reactiontime$ = STR$(reactiontime)
    reactiontime$ = RTRIM$(reactiontime$)
    DO
        CLS
        PRINT "Your reaction time was"; reactiontime$; "/100ths of a seconds"
        PRINT "     1-Test Again"
        PRINT "     2-Exit"
        DO
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
        IF k$ = CHR$(50) THEN SYSTEM
    LOOP UNTIL k$ = CHR$(49)
LOOP