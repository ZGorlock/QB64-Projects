SCREEN 12
_TITLE "Spirograph"
'_FULLSCREEN

REDIM lines(8)
lines(0) = 6
lines(1) = 12
lines(2) = 24
lines(3) = 30
lines(4) = 36
lines(5) = 60
lines(6) = 72
lines(7) = 90
lines(8) = 120

DO
    RANDOMIZE TIMER
    throw = INT(RND * 8)
    lines = lines(throw)
    FOR n = 1 TO 360
        CLS
        'PRINT throw
        _DELAY .01
        FOR m = 1 TO lines
            a = radian(m * INT(360 / lines))
            a2 = radian(m * INT(360 / lines) + n)
            CIRCLE (320, 240), 200, 15
            LINE ((320 + (200 * COS(a))), (240 + (200 * SIN(a))))-((320 + (200 * COS(a2))), (240 + (200 * SIN(a2)))), 15
        NEXT m
        _DISPLAY
    NEXT n
    k$ = INKEY$
LOOP UNTIL k$ > ""
SYSTEM

FUNCTION radian (d)
radian = d * (4 * ATN(1)) / 180
END FUNCTION