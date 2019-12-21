SCREEN 0
SCREEN 12
_TITLE "Etch-A-Sketch"
locationx = 320
locationy = 240
speed = 50
size = 5
colord = 15
DO
    _LIMIT speed
    CIRCLE (locationx, locationy), size, colord
    shake = _KEYDOWN(32)
    up = _KEYDOWN(119)
    left = _KEYDOWN(97)
    right = _KEYDOWN(100)
    down = _KEYDOWN(115)
    options = _KEYDOWN(27)
    IF up = -1 THEN locationy = locationy - 1
    IF left = -1 THEN locationx = locationx - 1
    IF right = -1 THEN locationx = locationx + 1
    IF down = -1 THEN locationy = locationy + 1
    IF shake = -1 THEN CLS
    IF options = -1 THEN
        DO
            CLS
            LOCATE 1, 36
            PRINT "-OPTIONS-"
            PRINT "1-Size"
            PRINT "2-Color"
            PRINT "3-Speed"
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            IF k$ = CHR$(49) THEN
                size$ = ""
                inputlength = 0
                DO
                    CLS
                    PRINT "Enter the size in pixels of the radius of the line you want"
                    PRINT "Current Size:"; size
                    PRINT ": "; size$
                    FOR drawing = 0 TO 40
                        CIRCLE ((280 + drawing), 240), size, colord
                    NEXT drawing
                    DO
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                        size$ = size$ + k$
                        inputlength = LEN(size$)
                    END IF
                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                        size$ = MID$(size$, 1, (inputlength - 1))
                        inputlength = (inputlength - 1)
                    END IF
                    size = VAL(size$)
                LOOP UNTIL k$ = CHR$(13)
                CLS
                locationx = 320
                locationy = 240
                EXIT DO
            END IF
            IF k$ = CHR$(50) THEN
                color$ = ""
                inputlength = 0
                DO
                    CLS
                    PRINT "Enter the color of the line you want (1-15)"
                    PRINT "Current Color:"; colord
                    PRINT ": "; color$
                    FOR drawing = 0 TO 40
                        CIRCLE ((280 + drawing), 240), size, colord
                    NEXT drawing
                    DO
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                        color$ = color$ + k$
                        inputlength = LEN(color$)
                    END IF
                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                        color$ = MID$(color$, 1, (inputlength - 1))
                        inputlength = (inputlength - 1)
                    END IF
                    colord = VAL(color$)
                LOOP UNTIL k$ = CHR$(13)
                CLS
                locationx = 320
                locationy = 240
                EXIT DO
            END IF
            IF k$ = CHR$(51) THEN
                speed$ = ""
                inputlength = 0
                DO
                    CLS
                    PRINT "Enter the speed you want"
                    PRINT "The speed is how many pixels it will draw per second if you hold it down"
                    PRINT "Current Speed:"; speed
                    PRINT ": "; speed$
                    DO
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                        speed$ = speed$ + k$
                        inputlength = LEN(speed$)
                    END IF
                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                        speed$ = MID$(speed$, 1, (inputlength - 1))
                        inputlength = (inputlength - 1)
                    END IF
                LOOP UNTIL k$ = CHR$(13)
                speed = VAL(speed$)
                CLS
                locationx = 320
                locationy = 240
                EXIT DO
            END IF
        LOOP
    END IF
LOOP