SCREEN 0
SCREEN 12
_TITLE "Graph Maker"
start:
DO
    CLEAR
    COLOR 15, 0
    DO
        _LIMIT 64
        CLS
        PRINT "What kind of graph do you want to make?"
        PRINT "    1-Pie Chart"
        PRINT "    2-Bar Graph"
        PRINT "    3-Histogram"
        PRINT "    4-Line Graph"
        PRINT "    5-Dot Plot"
        PRINT "    6-Scatter Plot"
        PRINT "    7-Stem-and-Leaf Plot"
        PRINT "    8-Pictograph"
        GOSUB control
        IF k$ = CHR$(49) THEN
            DO
                _LIMIT 64
                CLS
                PRINT "What is the title of your pie chart?"
                PRINT ": "; title$
                GOSUB control
                IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                    title$ = title$ + k$
                END IF
                IF k$ = CHR$(8) AND LEN(title$) <> 0 THEN title$ = MID$(title$, 1, (LEN(title$) - 1))
                _DISPLAY
            LOOP UNTIL k$ = CHR$(13)
            DO
                DO
                    _LIMIT 64
                    CLS
                    PRINT "How many groups are represented in the data?"
                    PRINT ": "; groups$
                    GOSUB control
                    IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                        groups$ = groups$ + k$
                    END IF
                    IF k$ = CHR$(8) AND LEN(groups$) <> 0 THEN groups$ = MID$(groups$, 1, (LEN(groups$) - 1))
                    _DISPLAY
                LOOP UNTIL k$ = CHR$(13)
                groups = VAL(groups$)
                IF groups < 2 OR groups > 15 THEN
                    DO
                        _LIMIT 64
                        CLS
                        PRINT "You cannot have less than 2 or more than 15 groups"
                        PRINT "Press Space to enter another value"
                        GOSUB control
                        _DISPLAY
                    LOOP UNTIL k$ = CHR$(32)
                    groups$ = ""
                ELSE
                    EXIT DO
                END IF
            LOOP
            DIM set1$(15)
            DIM set2$(15)
            DIM paintangle(15)
            FOR group = 1 TO groups
                DO
                    _LIMIT 64
                    CLS
                    PRINT "Enter the name of the set"; group
                    PRINT ": "; set1$(group)
                    GOSUB control
                    IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                        set1$(group) = set1$(group) + k$
                    END IF
                    IF k$ = CHR$(8) AND LEN(set1$(group)) <> 0 THEN set1$(group) = MID$(set1$(group), 1, (LEN(set1$(group)) - 1))
                    IF LEN(set1$(group)) > 10 THEN set1$(group) = MID$(set1$(group), 1, 10)
                    _DISPLAY
                LOOP UNTIL k$ = CHR$(13)
                DO
                    _LIMIT 64
                    CLS
                    PRINT "Enter the value of "; set1$(group)
                    PRINT ": "; set2$(group)
                    GOSUB control
                    IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                        set2$(group) = set2$(group) + k$
                    END IF
                    IF k$ = CHR$(8) AND LEN(set2$(group)) <> 0 THEN set2$(group) = MID$(set2$(group), 1, (LEN(set2$(group)) - 1))
                    _DISPLAY
                LOOP UNTIL k$ = CHR$(13)
                totalvalue = totalvalue + VAL(set2$(group))
            NEXT group
            CLS
            PSET (32, 32), 15
            DRAW "R576 D416 L576 U416"
            PAINT (33, 33), 15
            PSET (456, 63), 0
            boxdepth = (16 * (3 + groups))
            boxdepth$ = STR$(boxdepth)
            boxdepth$ = LTRIM$(boxdepth$)
            DRAW "R120 D" + boxdepth$ + " L120 U" + boxdepth$
            CIRCLE (260, 240), 175, 0
            PSET (260, 240), 0
            DRAW "U175"
            FOR circledividelines = 1 TO groups
                PSET (260, 240), 0
                thisangle = ((360 * (VAL(set2$(circledividelines)) / totalvalue)))
                angle = cumangle + thisangle
                angle$ = STR$(angle)
                angle$ = LTRIM$(angle$)
                DRAW "TA" + angle$ + " U175 TA360"
                cumangle = cumangle + thisangle
                PSET (260, 240), 0
                paintangle = angle - ((thisangle) / 2)
                paintangle$ = STR$(paintangle)
                paintangle$ = LTRIM$(paintangle$)
                DRAW "TA" + paintangle$ + " BU174 TA360"
                PAINT STEP(0, 0), circledividelines, 0
            NEXT circledividelines
            PSET (260, 240), 0
            DRAW "U175"
            FOR scalebox = 1 TO groups
                downness = (4 + (80 + (scalebox * 16)))
                PSET (460, downness), scalebox
                DRAW "D6 R6 U6 L6"
                PAINT (461, (downness + 1)), scalebox
                PSET (460, downness), 0
                DRAW "D6 R6 U6 L6"
            NEXT scalebox
            middle = (((80 - LEN(title$)) / 2))
            LOCATE 3, middle
            COLOR 0, 15
            PRINT title$
            LOCATE 5, 64
            PRINT "KEY"
            FOR scalebox = 1 TO groups
                LOCATE (6 + scalebox), 60
                PRINT set1$(scalebox)
            NEXT scalebox
            GOSUB control
            _DISPLAY
            DO
                DO
                    GOSUB control
                LOOP
            LOOP UNTIL k$ = CHR$(13)
            EXIT DO
        END IF
        IF k$ = CHR$(50) THEN

        END IF
        IF k$ = CHR$(51) THEN

        END IF
        IF k$ = CHR$(52) THEN

        END IF
        IF k$ = CHR$(53) THEN

        END IF
        IF k$ = CHR$(54) THEN

        END IF
        IF k$ = CHR$(55) THEN

        END IF
        IF k$ = CHR$(56) THEN
            DO
                _LIMIT 64
                CLS
                PRINT "Why would you even want to make a pictograph?"
                PRINT "That is like the dumbest kind of graph; it serves literally no purpose!"
                PRINT "You can't even see what number it ends on, it looks childish!"
                PRINT "Press Space to try and make a better choice"
                GOSUB control
                _DISPLAY
            LOOP UNTIL k$ = CHR$(32)
        END IF
        _DISPLAY
    LOOP
LOOP

control:
k$ = INKEY$
IF k$ = CHR$(27) THEN
    GOTO start
END IF
IF k$ = (CHR$(0) + CHR$(62)) THEN
    CLEAR
    SYSTEM
END IF
IF k$ = (CHR$(0) + CHR$(133)) THEN
    IF full = 1 THEN
        _FULLSCREEN _OFF
        full = 0
    ELSE
        _FULLSCREEN
        full = 1
    END IF
END IF
RETURN



















SCREEN 12
DO
    colorcount = 0
    totalvalue = 0
    REDIM set1$(15)
    REDIM set2$(15)
    REDIM set3(15)
    groups = 8
    FOR a = 1 TO groups
        colorcount = colorcount + 1
        set1$(a) = STR$(a)
        RANDOMIZE TIMER
        set2$(a) = STR$(INT(RND * 100 + 1))
        totalvalue = totalvalue + VAL(set2$(a))
        set3(a) = colorcount
    NEXT a
    FOR checkacc = 1 TO 10
        FOR check1 = 1 TO groups
            FOR check2 = 1 TO groups
                IF set2$(check2) < set2$(check1) THEN
                    SWAP set2$(check1), set2$(check2)
                    SWAP set3(check1), set3(check2)
                END IF
            NEXT check2
        NEXT check1
    NEXT checkacc

    CLS
    PSET (32, 32), 15
    DRAW "R576 D416 L576 U416"
    PAINT (33, 33), 15
    PSET (456, 63), 0
    boxdepth = (16 * (3 + groups))
    boxdepth$ = STR$(boxdepth)
    boxdepth$ = LTRIM$(boxdepth$)
    DRAW "R120 D" + boxdepth$ + " L120 U" + boxdepth$
    CIRCLE (260, 240), 175, 0
    PSET (260, 240), 0
    DRAW "U175"
    FOR circledividelines = 1 TO groups
        PSET (260, 240), 0
        thisangle = ((360 * (VAL(set2$(circledividelines)) / totalvalue)))
        angle = cumangle + thisangle
        angle$ = STR$(angle)
        angle$ = LTRIM$(angle$)
        DRAW "TA" + angle$ + " U175 TA360"
        cumangle = cumangle + thisangle
        PSET (260, 240), 0
        paintangle = angle - ((thisangle) / 2)
        paintangle$ = STR$(paintangle)
        paintangle$ = LTRIM$(paintangle$)
        DRAW "TA" + paintangle$ + " BU174 TA360"
        PAINT STEP(0, 0), set3(circledividelines), 0
    NEXT circledividelines
    PSET (260, 240), 0
    DRAW "U175"
    FOR scalebox = 1 TO groups
        downness = (4 + (80 + (scalebox * 16)))
        PSET (460, downness), set3(scalebox)
        DRAW "D6 R6 U6 L6"
        PAINT (461, (downness + 1)), set3(scalebox)
        PSET (460, downness), 0
        DRAW "D6 R6 U6 L6"
    NEXT scalebox
    middle = (((80 - LEN(title$)) / 2))
    LOCATE 3, middle
    COLOR 0, 15
    PRINT title$
    LOCATE 5, 64
    PRINT "KEY"
    FOR scalebox = 1 TO groups
        LOCATE (6 + scalebox), 60
        PRINT set1$(scalebox)
    NEXT scalebox
    SLEEP
LOOP