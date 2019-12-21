SCREEN 12
_TITLE "Spirograph Turner"
_FULLSCREEN

rmaxc = 180
DO
    _LIMIT 90
    spin = spin - 1
    spin2 = spin2 - 1
    ox = ox - .25
    osx = osx + .25
    spinx = spinx + 1
    spin2x = spin2x - 1
    innercspinner = innercspinner + 4
    CLS
    CIRCLE (320, 240), 169, 15
    lines = 60
    FOR l = 1 TO lines
        x = radian(l * INT(360 / lines) + osx)
        y = radian(l * INT(360 / lines) + 90 + osx)
        LINE ((320 + (240 * COS(x))), (240 + (240 * SIN(x))))-((320 + (240 * COS(y))), (240 + (240 * SIN(y)))), 15
    NEXT l
    lines = 36
    FOR p = 1 TO lines
        ax = radian(p * INT(360 / lines) + ox)
        ay = radian(p * INT(360 / lines) + 80 + ox)
        LINE ((320 + (220 * COS(ax))), (240 + (220 * SIN(ax))))-((320 + (220 * COS(ay))), (240 + (220 * SIN(ay)))), 15
    NEXT p
    FOR inc = 1 TO 4
        a = radian((inc * 90) + spin)
        locx = 320 + ((rmaxc / 2) * COS(a))
        locy = 240 + ((rmaxc / 2) * SIN(a))
        CIRCLE (locx, locy), (rmaxc / 3), 15
        lines = 12
        FOR n = 1 TO lines
            a2x = radian(n * INT(360 / lines) + spinx)
            a2y = radian(n * INT(360 / lines) + 90 + spinx)
            LINE ((locx + ((rmaxc / 3) * COS(a2x))), (locy + ((rmaxc / 3) * SIN(a2x))))-((locx + ((rmaxc / 3) * COS(a2y))), (locy + ((rmaxc / 3) * SIN(a2y)))), 15
        NEXT n
        FOR innerc = 1 TO 4
            a2 = radian((innerc * 90) + spin2)
            lx = locx + ((rmaxc / 8) * COS(a2))
            ly = locy + ((rmaxc / 8) * SIN(a2))
            CIRCLE (lx, ly), (rmaxc / 12), 15
            RANDOMIZE TIMER
            lines = 6
            FOR m = 1 TO lines
                a2x2 = radian(m * INT(360 / lines) - spin2x)
                a2y2 = radian(m * INT(360 / lines) + innercspinner - spin2x)
                LINE ((lx + ((rmaxc / 12) * COS(a2x2))), (ly + ((rmaxc / 12) * SIN(a2x2))))-((lx + ((rmaxc / 12) * COS(a2y2))), (ly + ((rmaxc / 12) * SIN(a2y2)))), 15
            NEXT m
        NEXT innerc
    NEXT inc
    _DISPLAY
    k$ = INKEY$
LOOP UNTIL k$ > ""
SYSTEM

FUNCTION radian (d)
radian = d * (4 * ATN(1)) / 180
END FUNCTION